Return-Path: <cgroups+bounces-9784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39149B4887A
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81143B7E48
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A72F3639;
	Mon,  8 Sep 2025 09:29:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463B2EBDD9;
	Mon,  8 Sep 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323772; cv=none; b=mlmRfgGpO85UbhYzhbur7aHTbv2sjM52naoCa1DPWlAt7FjKnEWG/PXWFq6QGxLplS6HbOdc9sNBTKU5bnUaArsIb3o0T9mHkqj1ars8dE8LP8mtNknGMXGNiAT6B7RsIpMANOEYkeZe4GqhZoKaZrPLGatpTf5pOqC+GYiilmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323772; c=relaxed/simple;
	bh=KwWvbVIcttFb/phNvSQXEynyrXAMQeq4hE88O8a3w+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifN5v49r5m9HVvsAIHuVAhuV89KRHCvza7GXrL7qt76q2hgmpf6W4sEDRgXb//+1iGxSQ8m2PHxwAVZUjVQK6qUPBKgulw3oCWt3UMdeAYLPHKGySYMSAI6avXYgQr3EMJlsYREH8YE/fytKVlBYoeIcIHs6NcsnuyEQDlgBcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cL1qr2x9tzKHMxy;
	Mon,  8 Sep 2025 17:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 801211A2B2D;
	Mon,  8 Sep 2025 17:29:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzzob5oGjMyBw--.46699S8;
	Mon, 08 Sep 2025 17:29:28 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v4 for-6.18/block 4/5] blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
Date: Mon,  8 Sep 2025 17:20:06 +0800
Message-Id: <20250908092007.3796967-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908092007.3796967-1-yukuai1@huaweicloud.com>
References: <20250908092007.3796967-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIzzob5oGjMyBw--.46699S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4UuFy5GFWrAw1UGFyDKFg_yoW3XryUpF
	4fGF4ay395XF4jqFyIvw43Jw1fA34xuasrWryrKrW3twn0qrs8Jrn5JFyUAFs7Jr95uFZF
	9r4DWrZ8CFs2qrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Introduce struct sched_dispatch_ctx, and split the helper into
elevator_dispatch_one_request() and elevator_finish_dispatch(). Also
and comments about the non-error return value.

Make code cleaner, and make it easier to add a new branch to dispatch
a batch of requests at a time in the next patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 196 ++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 78 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 6f2b0573a8ff..e6305b680db9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -16,6 +16,16 @@
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
+struct sched_dispatch_ctx {
+	struct blk_mq_hw_ctx *hctx;
+	struct list_head rq_list;
+
+	int count;
+	bool multi_hctxs;
+	bool run_queue;
+	bool busy;
+};
+
 /*
  * Mark a hardware queue as needing a restart.
  */
@@ -74,92 +84,92 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
-/*
- * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
- * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() fails to get the budget.
- *
- * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
- * be run again.  This is necessary to avoid starving flushes.
- */
-static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_should_dispatch(struct sched_dispatch_ctx *ctx)
 {
-	struct request_queue *q = hctx->queue;
-	struct elevator_queue *e = q->elevator;
-	bool multi_hctxs = false, run_queue = false;
-	bool dispatched = false, busy = false;
-	unsigned int max_dispatch;
-	LIST_HEAD(rq_list);
-	int count = 0;
+	struct elevator_queue *e = ctx->hctx->queue->elevator;
 
-	if (hctx->dispatch_busy)
-		max_dispatch = 1;
-	else
-		max_dispatch = hctx->queue->nr_requests;
+	if (e->type->ops.has_work && !e->type->ops.has_work(ctx->hctx))
+		return false;
 
-	do {
-		struct request *rq;
-		int budget_token;
+	if (!list_empty_careful(&ctx->hctx->dispatch)) {
+		ctx->busy = true;
+		return false;
+	}
 
-		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
-			break;
+	return true;
+}
 
-		if (!list_empty_careful(&hctx->dispatch)) {
-			busy = true;
-			break;
-		}
+static bool blk_mq_dispatch_one_request(struct sched_dispatch_ctx *ctx)
+{
+	struct request_queue *q = ctx->hctx->queue;
+	struct elevator_queue *e = q->elevator;
+	struct request *rq;
+	int budget_token;
 
-		budget_token = blk_mq_get_dispatch_budget(q);
-		if (budget_token < 0)
-			break;
+	if (!blk_mq_should_dispatch(ctx))
+		return false;
 
-		if (blk_queue_sq_sched(q)) {
-			elevator_dispatch_lock(e);
-			rq = e->type->ops.dispatch_request(hctx);
-			elevator_dispatch_unlock(e);
-		} else {
-			rq = e->type->ops.dispatch_request(hctx);
-		}
+	budget_token = blk_mq_get_dispatch_budget(q);
+	if (budget_token < 0)
+		return false;
 
-		if (!rq) {
-			blk_mq_put_dispatch_budget(q, budget_token);
-			/*
-			 * We're releasing without dispatching. Holding the
-			 * budget could have blocked any "hctx"s with the
-			 * same queue and if we didn't dispatch then there's
-			 * no guarantee anyone will kick the queue.  Kick it
-			 * ourselves.
-			 */
-			run_queue = true;
-			break;
-		}
-
-		blk_mq_set_rq_budget_token(rq, budget_token);
+	if (blk_queue_sq_sched(q)) {
+		elevator_dispatch_lock(e);
+		rq = e->type->ops.dispatch_request(ctx->hctx);
+		elevator_dispatch_unlock(e);
+	} else {
+		rq = e->type->ops.dispatch_request(ctx->hctx);
+	}
 
+	if (!rq) {
+		blk_mq_put_dispatch_budget(q, budget_token);
 		/*
-		 * Now this rq owns the budget which has to be released
-		 * if this rq won't be queued to driver via .queue_rq()
-		 * in blk_mq_dispatch_rq_list().
+		 * We're releasing without dispatching. Holding the
+		 * budget could have blocked any "hctx"s with the
+		 * same queue and if we didn't dispatch then there's
+		 * no guarantee anyone will kick the queue.  Kick it
+		 * ourselves.
 		 */
-		list_add_tail(&rq->queuelist, &rq_list);
-		count++;
-		if (rq->mq_hctx != hctx)
-			multi_hctxs = true;
+		ctx->run_queue = true;
+		return false;
+	}
 
-		/*
-		 * If we cannot get tag for the request, stop dequeueing
-		 * requests from the IO scheduler. We are unlikely to be able
-		 * to submit them anyway and it creates false impression for
-		 * scheduling heuristics that the device can take more IO.
-		 */
-		if (!blk_mq_get_driver_tag(rq))
-			break;
-	} while (count < max_dispatch);
+	blk_mq_set_rq_budget_token(rq, budget_token);
 
-	if (!count) {
-		if (run_queue)
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
-	} else if (multi_hctxs) {
+	/*
+	 * Now this rq owns the budget which has to be released
+	 * if this rq won't be queued to driver via .queue_rq()
+	 * in blk_mq_dispatch_rq_list().
+	 */
+	list_add_tail(&rq->queuelist, &ctx->rq_list);
+	ctx->count++;
+	if (rq->mq_hctx != ctx->hctx)
+		ctx->multi_hctxs = true;
+
+	/*
+	 * If we cannot get tag for the request, stop dequeueing
+	 * requests from the IO scheduler. We are unlikely to be able
+	 * to submit them anyway and it creates false impression for
+	 * scheduling heuristics that the device can take more IO.
+	 */
+	return blk_mq_get_driver_tag(rq);
+}
+
+/*
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * be run again. This is necessary to avoid starving flushes.
+ * Return 0 if no request is dispatched.
+ * Return 1 if at least one request is dispatched.
+ */
+static int blk_mq_finish_dispatch(struct sched_dispatch_ctx *ctx)
+{
+	bool dispatched = false;
+
+	if (!ctx->count) {
+		if (ctx->run_queue)
+			blk_mq_delay_run_hw_queues(ctx->hctx->queue,
+						   BLK_MQ_BUDGET_DELAY);
+	} else if (ctx->multi_hctxs) {
 		/*
 		 * Requests from different hctx may be dequeued from some
 		 * schedulers, such as bfq and deadline.
@@ -167,19 +177,49 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * Sort the requests in the list according to their hctx,
 		 * dispatch batching requests from same hctx at a time.
 		 */
-		list_sort(NULL, &rq_list, sched_rq_cmp);
+		list_sort(NULL, &ctx->rq_list, sched_rq_cmp);
 		do {
-			dispatched |= blk_mq_dispatch_hctx_list(&rq_list);
-		} while (!list_empty(&rq_list));
+			dispatched |= blk_mq_dispatch_hctx_list(&ctx->rq_list);
+		} while (!list_empty(&ctx->rq_list));
 	} else {
-		dispatched = blk_mq_dispatch_rq_list(hctx, &rq_list, false);
+		dispatched = blk_mq_dispatch_rq_list(ctx->hctx, &ctx->rq_list,
+						     false);
 	}
 
-	if (busy)
+	if (ctx->busy)
 		return -EAGAIN;
+
 	return !!dispatched;
 }
 
+/*
+ * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
+ * its queue by itself in its completion handler, so we don't need to
+ * restart queue if .get_budget() fails to get the budget.
+ *
+ * See blk_mq_finish_dispatch() for return values.
+ */
+static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int max_dispatch;
+	struct sched_dispatch_ctx ctx = {
+		.hctx	= hctx,
+		.rq_list = LIST_HEAD_INIT(ctx.rq_list),
+	};
+
+	if (hctx->dispatch_busy)
+		max_dispatch = 1;
+	else
+		max_dispatch = hctx->queue->nr_requests;
+
+	do {
+		if (!blk_mq_dispatch_one_request(&ctx))
+			break;
+	} while (ctx.count < max_dispatch);
+
+	return blk_mq_finish_dispatch(&ctx);
+}
+
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned long end = jiffies + HZ;
-- 
2.39.2


