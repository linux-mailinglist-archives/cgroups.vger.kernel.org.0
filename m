Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09F252702B
	for <lists+cgroups@lfdr.de>; Sat, 14 May 2022 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiENIwR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 May 2022 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiENIvp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 May 2022 04:51:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86604252AB;
        Sat, 14 May 2022 01:51:42 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L0fJT0s0jzCsWd;
        Sat, 14 May 2022 16:46:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 14 May 2022 16:51:39 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 14 May
 2022 16:51:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 8/8] block, bfq: cleanup bfq_bfqq_handle_idle_busy_switch()
Date:   Sat, 14 May 2022 17:05:22 +0800
Message-ID: <20220514090522.1669270-9-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220514090522.1669270-1-yukuai3@huawei.com>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

'wr_or_deserves_wr' is only used in bfq_update_bfqq_wr_on_rq_arrival(),
which is only called from bfq_bfqq_handle_idle_busy_switch() in specific
code branch, thus there is no need to precaculate 'wr_or_deserves_wr'
each time bfq_bfqq_handle_idle_busy_switch() is called.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 110 +++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 48 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1e57d76c8dd3..cea8cb3f5ee2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1624,15 +1624,65 @@ static unsigned long bfq_smallest_from_now(void)
 	return jiffies - MAX_JIFFY_OFFSET;
 }
 
+/*
+ * bfqq deserves to be weight-raised if:
+ * - it is sync,
+ * - it does not belong to a large burst,
+ * - it has been idle for enough time or is soft real-time,
+ * - is linked to a bfq_io_cq (it is not shared in any sense),
+ * - has a default weight (otherwise we assume the user wanted
+ *   to control its weight explicitly)
+ *
+ * Merged bfq_queues are kept out of weight-raising
+ * (low-latency) mechanisms. The reason is that these queues
+ * are usually created for non-interactive and
+ * non-soft-real-time tasks. Yet this is not the case for
+ * stably-merged queues. These queues are merged just because
+ * they are created shortly after each other. So they may
+ * easily serve the I/O of an interactive or soft-real time
+ * application, if the application happens to spawn multiple
+ * processes. So let also stably-merged queued enjoy weight
+ * raising.
+ */
+static bool bfqq_wr_or_deserves_wr(struct bfq_data *bfqd,
+				   struct bfq_queue *bfqq,
+				   struct request *rq,
+				   bool interactive, bool soft_rt)
+{
+	if (!bfqd->low_latency)
+		return false;
+
+	if (bfqq->wr_coeff > 1)
+		return true;
+
+	if (!bfq_bfqq_sync(bfqq))
+		return false;
+
+	if (!bfqq->bic && !RQ_BIC(rq)->stably_merged)
+		return false;
+
+	if (!interactive && !soft_rt)
+		return false;
+
+	return true;
+}
+
 static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     unsigned int old_wr_coeff,
-					     bool wr_or_deserves_wr,
-					     bool interactive,
-					     bool in_burst,
-					     bool soft_rt)
-{
-	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
+					     struct request *rq,
+					     bool interactive)
+{
+	bool in_burst = bfq_bfqq_in_large_burst(bfqq);
+	bool soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
+		       !BFQQ_TOTALLY_SEEKY(bfqq) &&
+		       !in_burst &&
+		       time_is_before_jiffies(bfqq->soft_rt_next_start) &&
+		       bfqq->dispatched == 0 &&
+		       bfqq->entity.new_weight == 40;
+
+	if (old_wr_coeff == 1 &&
+	    bfqq_wr_or_deserves_wr(bfqd, bfqq, rq, interactive, soft_rt)) {
 		/* start a weight-raising period */
 		if (interactive) {
 			bfqq->service_from_wr = 0;
@@ -1674,9 +1724,9 @@ static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 		if (interactive) { /* update wr coeff and duration */
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
-		} else if (in_burst)
+		} else if (in_burst) {
 			bfqq->wr_coeff = 1;
-		else if (soft_rt) {
+		} else if (soft_rt) {
 			/*
 			 * The application is now or still meeting the
 			 * requirements for being deemed soft rt.  We
@@ -1768,44 +1818,11 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct request *rq,
 					     bool *interactive)
 {
-	bool soft_rt, in_burst,	wr_or_deserves_wr,
-		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq);
+	bool in_burst = bfq_bfqq_in_large_burst(bfqq);
+	bool idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq);
 
-	/*
-	 * bfqq deserves to be weight-raised if:
-	 * - it is sync,
-	 * - it does not belong to a large burst,
-	 * - it has been idle for enough time or is soft real-time,
-	 * - is linked to a bfq_io_cq (it is not shared in any sense),
-	 * - has a default weight (otherwise we assume the user wanted
-	 *   to control its weight explicitly)
-	 */
-	in_burst = bfq_bfqq_in_large_burst(bfqq);
-	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
-		!BFQQ_TOTALLY_SEEKY(bfqq) &&
-		!in_burst &&
-		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
-		bfqq->dispatched == 0 &&
-		bfqq->entity.new_weight == 40;
 	*interactive = !in_burst && idle_for_long_time &&
 		bfqq->entity.new_weight == 40;
-	/*
-	 * Merged bfq_queues are kept out of weight-raising
-	 * (low-latency) mechanisms. The reason is that these queues
-	 * are usually created for non-interactive and
-	 * non-soft-real-time tasks. Yet this is not the case for
-	 * stably-merged queues. These queues are merged just because
-	 * they are created shortly after each other. So they may
-	 * easily serve the I/O of an interactive or soft-real time
-	 * application, if the application happens to spawn multiple
-	 * processes. So let also stably-merged queued enjoy weight
-	 * raising.
-	 */
-	wr_or_deserves_wr = bfqd->low_latency &&
-		(bfqq->wr_coeff > 1 ||
-		 (bfq_bfqq_sync(bfqq) &&
-		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
-		   (*interactive || soft_rt)));
 
 	/*
 	 * If bfqq happened to be activated in a burst, but has been
@@ -1840,11 +1857,8 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		if (time_is_before_jiffies(bfqq->split_time +
 					   bfqd->bfq_wr_min_idle_time)) {
 			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
-							 old_wr_coeff,
-							 wr_or_deserves_wr,
-							 *interactive,
-							 in_burst,
-							 soft_rt);
+							 old_wr_coeff, rq,
+							 *interactive);
 
 			if (old_wr_coeff != bfqq->wr_coeff)
 				bfqq->entity.prio_changed = 1;
-- 
2.31.1

