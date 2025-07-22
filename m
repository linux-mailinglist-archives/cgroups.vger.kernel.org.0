Return-Path: <cgroups+bounces-8826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469DB0D36A
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D24C1889C18
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205612E49A6;
	Tue, 22 Jul 2025 07:31:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD412D0C86;
	Tue, 22 Jul 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169462; cv=none; b=COF1Nwi+KS4ZLyYhGca3DvnyEftU7HpKMrRSd5rGPllA8NPQy5HcBDzstbIz2MT1TsWOa73AUyR/krBvuV8n7uQyBDac6pvqYVAVUsiVhm743l9GgtS243lYgYcRjD6rYfTIqkb1ZBHyUIs9CtgCY5Fp75RfLHxtymIAye8ATsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169462; c=relaxed/simple;
	bh=v6i0cid4H5yhWlKbRkygU1z4DHBIu/PeFOLdt8mYb6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V58J9CwIXubq07dbbPhrX5hQY6l8XzW7DfQePYnXqb/9KVB0grjayUBJMnsutJwV9r6hCD1PsMzQTtjsbHlhKQT+YVPoGdUX5fWXGqL69Nj76C6Tq0GYmrYRP5QG36OSos5OYm4qtd9rHs0N7gL+sDGy1Qmq3p3CNJrEO2Iky1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmTTG1jc5zKHMw9;
	Tue, 22 Jul 2025 15:30:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E6D271A1591;
	Tue, 22 Jul 2025 15:30:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMrPn9ovjJdBA--.52549S10;
	Tue, 22 Jul 2025 15:30:56 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
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
Subject: [PATCH 6/6] blk-mq-sched: support request batch dispatching for sq elevator
Date: Tue, 22 Jul 2025 15:24:31 +0800
Message-Id: <20250722072431.610354-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250722072431.610354-1-yukuai1@huaweicloud.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhMrPn9ovjJdBA--.52549S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWkXFyfCF1kuF15GFW5GFg_yoWrAF1rpF
	WrJa1FyrWvq3ZFqF9xCw47Jw15Gw4I9r9rWryfKr43JFs7XrsxGr1rJa4UZF4xAr4fCFsr
	ur4DXF95uF1Iva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For dispatch_request method, current behavior is dispatching one request at
a time. In the case of multiple dispatching contexts, This behavior, on the
one hand, introduce intense lock contention:

t1:                     t2:                     t3:
lock                    lock                    lock
// grab lock
ops.dispatch_request
unlock
                        // grab lock
                        ops.dispatch_request
                        unlock
                                                // grab lock
                                                ops.dispatch_request
                                                unlock

on the other hand, messing up the requests dispatching order:
t1:

lock
rq1 = ops.dispatch_request
unlock
                        t2:
                        lock
                        rq2 = ops.dispatch_request
                        unlock

lock
rq3 = ops.dispatch_request
unlock

                        lock
                        rq4 = ops.dispatch_request
                        unlock

//rq1,rq3 issue to disk
                        // rq2, rq4 issue to disk

In this case, the elevator dispatch order is rq 1-2-3-4, however,
such order in disk is rq 1-3-2-4, the order for rq2 and rq3 is inversed.

Fix those problems by introducing elevator_dispatch_requests(), this
helper will grab the lock and dispatch a batch of requests while holding
the lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 60 +++++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h       | 21 ++++++++++++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index f18aecf710ad..c4450b73ab25 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -101,6 +101,54 @@ static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
 	return true;
 }
 
+static void elevator_dispatch_requests(struct sched_dispatch_ctx *ctx)
+{
+	struct request *rq;
+	bool has_get_budget = ctx->q->mq_ops->get_budget != NULL;
+	int budget_token[BUDGET_TOKEN_BATCH];
+	int count = ctx->q->nr_requests;
+	int i;
+
+	while (true) {
+		if (!elevator_can_dispatch(ctx))
+			return;
+
+		if (has_get_budget) {
+			count = blk_mq_get_dispatch_budgets(ctx->q, budget_token);
+			if (count <= 0)
+				return;
+		}
+
+		spin_lock_irq(&ctx->e->lock);
+		for (i = 0; i < count; ++i) {
+			rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
+			if (!rq) {
+				ctx->run_queue = true;
+				goto err_free_budgets;
+			}
+
+			if (has_get_budget)
+				blk_mq_set_rq_budget_token(rq, budget_token[i]);
+			list_add_tail(&rq->queuelist, &ctx->rq_list);
+			ctx->count++;
+			if (rq->mq_hctx != ctx->hctx)
+				ctx->multi_hctxs = true;
+
+			if (!blk_mq_get_driver_tag(rq)) {
+				i++;
+				goto err_free_budgets;
+			}
+		}
+		spin_unlock_irq(&ctx->e->lock);
+	}
+
+err_free_budgets:
+	spin_unlock_irq(&ctx->e->lock);
+	if (has_get_budget)
+		for (; i < count; ++i)
+			blk_mq_put_dispatch_budget(ctx->q, budget_token[i]);
+}
+
 static bool elevator_dispatch_one_request(struct sched_dispatch_ctx *ctx)
 {
 	bool sq_sched = blk_queue_sq_sched(ctx->q);
@@ -213,10 +261,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	else
 		max_dispatch = hctx->queue->nr_requests;
 
-	do {
-		if (!elevator_dispatch_one_request(&ctx))
-			break;
-	} while (ctx.count < max_dispatch);
+	if (!hctx->dispatch_busy && blk_queue_sq_sched(ctx.q))
+		elevator_dispatch_requests(&ctx);
+	else {
+		do {
+			if (!elevator_dispatch_one_request(&ctx))
+				break;
+		} while (ctx.count < max_dispatch);
+	}
 
 	return elevator_finish_dispatch(&ctx);
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e..450c16a07841 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,7 @@ enum {
 };
 
 #define BLK_MQ_CPU_WORK_BATCH	(8)
+#define BUDGET_TOKEN_BATCH	(8)
 
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
@@ -262,6 +263,26 @@ static inline int blk_mq_get_dispatch_budget(struct request_queue *q)
 	return 0;
 }
 
+static inline int blk_mq_get_dispatch_budgets(struct request_queue *q,
+					      int *budget_token)
+{
+	int count = 0;
+
+	while (count < BUDGET_TOKEN_BATCH) {
+		int token = 0;
+
+		if (q->mq_ops->get_budget)
+			token = q->mq_ops->get_budget(q);
+
+		if (token < 0)
+			return count;
+
+		budget_token[count++] = token;
+	}
+
+	return count;
+}
+
 static inline void blk_mq_set_rq_budget_token(struct request *rq, int token)
 {
 	if (token < 0)
-- 
2.39.2


