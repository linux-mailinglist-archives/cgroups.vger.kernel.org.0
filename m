Return-Path: <cgroups+bounces-8525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A7AD9BCB
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE37917C95B
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33DF2571BA;
	Sat, 14 Jun 2025 09:31:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C3155CBD;
	Sat, 14 Jun 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749893509; cv=none; b=GTO9hPFcCoCQEE7Fwd2rpEiJw00yLQIaOobCdoYvvZ2Dk240C9roxiIdwZCNvKHjqLzdHFrn4tx/UrzvuFIhRujSSgySX+rAQu2EiEjhg7NBhtkM1u5o0Kk0/zyxflV6mbPN5Gu2a6p9b5qpr0yyQqHpU1HrW8v5G282sLLtVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749893509; c=relaxed/simple;
	bh=m157EbdqaysdWSxG7epQ+w2dupFLoeJrQFDqv9WR4ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8YK7mzduUhILdOnSr98HDEwSI/mVOozIbJ6IEM9o/ulp4VcHCmnCZbCKECczACbVL2y0WQg+tg5+DFx5dg0w3cVMWtwob9Td3MlkPj0d9c0MHCtqIKfoHL6RO39RQZC19MuDJa48+zAlm65kGsXBQfl5sJQrckwEUPQi6lwWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bK9y95WlrzYQvP4;
	Sat, 14 Jun 2025 17:31:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B95C51A17A7;
	Sat, 14 Jun 2025 17:31:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19zQU1oHxfvPQ--.9099S9;
	Sat, 14 Jun 2025 17:31:44 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	yukuai3@huawei.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC v2 5/5] blk-mq-sched: support request batch dispatching for sq elevator
Date: Sat, 14 Jun 2025 17:25:28 +0800
Message-Id: <20250614092528.2352680-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19zQU1oHxfvPQ--.9099S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45Cr43KrW3tFW3Zr1DJrb_yoW5ur45pF
	4rGa1YkryqqFnFqFy3Aw47J3W5J3yI9r9rWrW3Kr43JFs7Xrsxt3WrJa4UJF4xJr4rCFsr
	ur4DWFyDuF1Iva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Before this patch, each context will hold a global lock to dispatch one
request at a time, which introduce intense lock competition:

lock
ops.dispatch_request
unlock

Hence support dispatch a batch of requests while holding the lock to
reduce lock contention.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 55 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-mq.h       | 21 +++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 990d0f19594a..d7cb88c8e8c7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -101,6 +101,49 @@ static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
 	return true;
 }
 
+static void elevator_dispatch_requests(struct sched_dispatch_ctx *ctx)
+{
+	struct request *rq;
+	int budget_token[BUDGET_TOKEN_BATCH];
+	int count;
+	int i;
+
+	while (true) {
+		if (!elevator_can_dispatch(ctx))
+			return;
+
+		count = blk_mq_get_dispatch_budgets(ctx->q, budget_token);
+		if (count <= 0)
+			return;
+
+		elevator_lock(ctx->e);
+		for (i = 0; i < count; ++i) {
+			rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
+			if (!rq) {
+				ctx->run_queue = true;
+				goto err_free_budgets;
+			}
+
+			blk_mq_set_rq_budget_token(rq, budget_token[i]);
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
+		elevator_unlock(ctx->e);
+	}
+
+err_free_budgets:
+	elevator_unlock(ctx->e);
+	for (; i < count; ++i)
+		blk_mq_put_dispatch_budget(ctx->q, budget_token[i]);
+}
+
 static bool elevator_dispatch_one_request(struct sched_dispatch_ctx *ctx)
 {
 	struct request *rq;
@@ -202,10 +245,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
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


