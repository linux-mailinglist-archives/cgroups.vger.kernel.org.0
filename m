Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B525F4B6
	for <lists+cgroups@lfdr.de>; Mon,  7 Sep 2020 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIGIMA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Sep 2020 04:12:00 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37517 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgIGILO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Sep 2020 04:11:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U89GXWL_1599466230;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U89GXWL_1599466230)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:10:30 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] blk-throttle: Define readable macros instead of static variables
Date:   Mon,  7 Sep 2020 16:10:15 +0800
Message-Id: <0a1c4f411da22feeafe08d06472a807e2c68fff9.1599458244.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The 'throtl_grp_quantum' and 'throtl_quantum' are both read-only
variables, thus better to use readable macros instead of static
variables, which can also save some spaces for .bss area.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 06e73ed..ca9002d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -15,10 +15,10 @@
 #include "blk-cgroup-rwstat.h"
 
 /* Max dispatch from a group in 1 round */
-static int throtl_grp_quantum = 8;
+#define THROTL_GRP_QUANTUM 8
 
 /* Total max dispatch from all groups in one round */
-static int throtl_quantum = 32;
+#define THROTL_QUANTUM 32
 
 /* Throttling is performed over a slice and after that slice is renewed */
 #define DFL_THROTL_SLICE_HD (HZ / 10)
@@ -1175,8 +1175,8 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 	unsigned int nr_reads = 0, nr_writes = 0;
-	unsigned int max_nr_reads = throtl_grp_quantum*3/4;
-	unsigned int max_nr_writes = throtl_grp_quantum - max_nr_reads;
+	unsigned int max_nr_reads = THROTL_GRP_QUANTUM * 3 / 4;
+	unsigned int max_nr_writes = THROTL_GRP_QUANTUM - max_nr_reads;
 	struct bio *bio;
 
 	/* Try to dispatch 75% READS and 25% WRITES */
@@ -1226,7 +1226,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		if (sq->nr_queued[0] || sq->nr_queued[1])
 			tg_update_disptime(tg);
 
-		if (nr_disp >= throtl_quantum)
+		if (nr_disp >= THROTL_QUANTUM)
 			break;
 	}
 
-- 
1.8.3.1

