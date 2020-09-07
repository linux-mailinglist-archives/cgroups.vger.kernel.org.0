Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8125F4A2
	for <lists+cgroups@lfdr.de>; Mon,  7 Sep 2020 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgIGIKt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Sep 2020 04:10:49 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47619 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbgIGIKi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Sep 2020 04:10:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U89b3zw_1599466229;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U89b3zw_1599466229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:10:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] blk-throttle: Fix some comments' typos
Date:   Mon,  7 Sep 2020 16:10:13 +0800
Message-Id: <e9451429c646d2f34b4225e2f0d716bc1e8dad5f.1599458244.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix some comments' typos.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fee3325..2fc6c3e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -150,7 +150,7 @@ struct throtl_grp {
 	/* user configured IOPS limits */
 	unsigned int iops_conf[2][LIMIT_CNT];
 
-	/* Number of bytes disptached in current slice */
+	/* Number of bytes dispatched in current slice */
 	uint64_t bytes_disp[2];
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
@@ -852,7 +852,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	/*
 	 * A bio has been dispatched. Also adjust slice_end. It might happen
 	 * that initially cgroup limit was very low resulting in high
-	 * slice_end, but later limit was bumped up and bio was dispached
+	 * slice_end, but later limit was bumped up and bio was dispatched
 	 * sooner, then we need to reduce slice_end. A high bogus slice_end
 	 * is bad because it does not allow new slice to start.
 	 */
@@ -1082,7 +1082,7 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 	 * If @tg doesn't currently have any bios queued in the same
 	 * direction, queueing @bio can change when @tg should be
 	 * dispatched.  Mark that @tg was empty.  This is automatically
-	 * cleaered on the next tg_update_disptime().
+	 * cleared on the next tg_update_disptime().
 	 */
 	if (!sq->nr_queued[rw])
 		tg->flags |= THROTL_TG_WAS_EMPTY;
@@ -1303,7 +1303,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 			}
 		}
 	} else {
-		/* reached the top-level, queue issueing */
+		/* reached the top-level, queue issuing */
 		queue_work(kthrotld_workqueue, &td->dispatch_work);
 	}
 out_unlock:
@@ -1314,8 +1314,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
  * blk_throtl_dispatch_work_fn - work function for throtl_data->dispatch_work
  * @work: work item being executed
  *
- * This function is queued for execution when bio's reach the bio_lists[]
- * of throtl_data->service_queue.  Those bio's are ready and issued by this
+ * This function is queued for execution when bios reach the bio_lists[]
+ * of throtl_data->service_queue.  Those bios are ready and issued by this
  * function.
  */
 static void blk_throtl_dispatch_work_fn(struct work_struct *work)
@@ -2230,7 +2230,7 @@ bool blk_throtl_bio(struct bio *bio)
 
 		/*
 		 * @bio passed through this layer without being throttled.
-		 * Climb up the ladder.  If we''re already at the top, it
+		 * Climb up the ladder.  If we're already at the top, it
 		 * can be executed directly.
 		 */
 		qn = &tg->qnode_on_parent[rw];
-- 
1.8.3.1

