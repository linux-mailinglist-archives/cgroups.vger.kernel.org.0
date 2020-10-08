Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31B286D4F
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgJHDwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:52:47 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55559 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728333AbgJHDwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:52:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGOQ9C_1602129160;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGOQ9C_1602129160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:40 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] blk-throttle: Move service tree validation out of the throtl_rb_first()
Date:   Thu,  8 Oct 2020 11:52:27 +0800
Message-Id: <a35c029a21514c4e14f99ef4f638340f3270eb60.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The throtl_schedule_next_dispatch() will validate if the service queue
is empty before calling update_min_dispatch_time(), and the
update_min_dispatch_time() will call throtl_rb_first(), which will
validate service queue again.

Thus we can move the service queue validation out of the
throtl_rb_first() to remove the redundant validation in the fast path.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f1bcb5c..38aed8b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -638,9 +638,6 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
 throtl_rb_first(struct throtl_service_queue *parent_sq)
 {
 	struct rb_node *n;
-	/* Service tree is empty */
-	if (!parent_sq->nr_pending)
-		return NULL;
 
 	n = rb_first_cached(&parent_sq->pending_tree);
 	WARN_ON_ONCE(!n);
@@ -1224,9 +1221,13 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 	unsigned int nr_disp = 0;
 
 	while (1) {
-		struct throtl_grp *tg = throtl_rb_first(parent_sq);
+		struct throtl_grp *tg;
 		struct throtl_service_queue *sq;
 
+		if (!parent_sq->nr_pending)
+			break;
+
+		tg = throtl_rb_first(parent_sq);
 		if (!tg)
 			break;
 
-- 
1.8.3.1

