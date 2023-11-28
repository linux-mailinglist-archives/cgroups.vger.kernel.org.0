Return-Path: <cgroups+bounces-633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE657FC746
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 22:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778E7287EEB
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C2481DD;
	Tue, 28 Nov 2023 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZkypQGk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905F42AB1;
	Tue, 28 Nov 2023 21:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5DEC433AD;
	Tue, 28 Nov 2023 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205731;
	bh=4XV+uvut0OD24gODkknEsc5TunCYGuGUOYpLn49RsNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZkypQGkJ57zn6gKfQGO/Unwy1lzjeUVfHM9+Q/hkfsjvZXdyT8zfJoIJgN1520KA
	 O6n/wdehzF8B9DcQ9/yr0EV4H+TcRAta1zQhEOA+qP8ijNNT8lGoh4o+MVMApLLR8Q
	 R+rf08c84Fnkr4TZgc5sxXnXxMxd6XThk2EB1Z/cLZWg9YWNQfjgA9yx7NVV+uOamh
	 vCOMVZElcD+7gtsxlxl6KuDrq2NwHgY5E8OY3hPqA4NAJC0hVChEV7T3FDNuu7xU9k
	 z2HljzcUuhpqTLl4fvvjRAGMYAeWVWcWj4cHSFvIxgjYwaut+iOb5Bua0XKxvVNx1K
	 6LOTBpWuItNwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/15] blk-cgroup: bypass blkcg_deactivate_policy after destroying
Date: Tue, 28 Nov 2023 16:08:25 -0500
Message-ID: <20231128210843.876493-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit e63a57303599b17290cd8bc48e6f20b24289a8bc ]

blkcg_deactivate_policy() can be called after blkg_destroy_all()
returns, and it isn't necessary since blkg_destroy_all has covered
policy deactivation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3ee4c1217b636..fd81a73708645 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -425,6 +425,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -447,6 +448,18 @@ static void blkg_destroy_all(struct request_queue *q)
 		}
 	}
 
+	/*
+	 * Mark policy deactivated since policy offline has been done, and
+	 * the free is scheduled, so future blkcg_deactivate_policy() can
+	 * be bypassed
+	 */
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (pol)
+			__clear_bit(pol->plid, q->blkcg_pols);
+	}
+
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
-- 
2.42.0


