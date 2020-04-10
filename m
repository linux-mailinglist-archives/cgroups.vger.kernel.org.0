Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7E1A4160
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2020 06:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgDJDsg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 23:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgDJDsg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 Apr 2020 23:48:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66D120B1F;
        Fri, 10 Apr 2020 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490516;
        bh=kRzMbY3EgV4E6Qm3X/KDl19rd8PRqtZJwSZTVXijMQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ou76GEutbHPYvOXZCQMe5VdiEGGF0KQaqL9Nx6CUD44ac/iPSoq8qWkaV960qMuDE
         nuGl8W205d5Nz4NhhxM0NM4VhqNXq09zF9tON1r2Zn9Q/QPUveZr5dWG7ojNOAeog4
         By6ht53HsR2ZhOUmVBeAf2eq3P83EoTy/U9aKuzQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>, cki-project@redhat.com,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 30/56] block, bfq: move forward the getting of an extra ref in bfq_bfqq_move
Date:   Thu,  9 Apr 2020 23:47:34 -0400
Message-Id: <20200410034800.8381-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit fd1bb3ae54a9a2e0c42709de861c69aa146b8955 ]

Commit ecedd3d7e199 ("block, bfq: get extra ref to prevent a queue
from being freed during a group move") gets an extra reference to a
bfq_queue before possibly deactivating it (temporarily), in
bfq_bfqq_move(). This prevents the bfq_queue from disappearing before
being reactivated in its new group.

Yet, the bfq_queue may also be expired (i.e., its service may be
stopped) before the bfq_queue is deactivated. And also an expiration
may lead to a premature freeing. This commit fixes this issue by
simply moving forward the getting of the extra reference already
introduced by commit ecedd3d7e199 ("block, bfq: get extra ref to
prevent a queue from being freed during a group move").

Reported-by: cki-project@redhat.com
Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 5a64607ce7744..a6d42339fb342 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -641,6 +641,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
+	/*
+	 * Get extra reference to prevent bfqq from being freed in
+	 * next possible expire or deactivate.
+	 */
+	bfqq->ref++;
+
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
 	 * from data structures related to current group. Otherwise we
@@ -651,12 +657,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
-	/*
-	 * get extra reference to prevent bfqq from being freed in
-	 * next possible deactivate
-	 */
-	bfqq->ref++;
-
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
@@ -676,7 +676,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
-	/* release extra ref taken above */
+	/* release extra ref taken above, bfqq may happen to be freed now */
 	bfq_put_queue(bfqq);
 }
 
-- 
2.20.1

