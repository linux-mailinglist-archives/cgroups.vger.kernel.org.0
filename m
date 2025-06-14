Return-Path: <cgroups+bounces-8523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F021AD9BC7
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8FB18979C0
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004A23E356;
	Sat, 14 Jun 2025 09:31:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8A3594F;
	Sat, 14 Jun 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749893509; cv=none; b=ksTjpcg31S4SkYU8FEvUNqQdnZr4aCSfNPCRvjhiH5xzLUsCVkKL+zYbI0TWGLRayw2yc+9EfkTSb8h6KesmJUeWFMxiyISL7Qto68TJKcbIR0n4HvhqV5e9lludOiMEsZTeJUGCSR4exD2pg+xD2rNfL2eOh8vB71N4ani2P1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749893509; c=relaxed/simple;
	bh=wEQGdWGsmpfrovUYNN+akxZhK07M41/34FemLEAhQbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAXGq4dki7NiYCC9ftx5IgS/JOVWPNkMf4YbmM2uZPMjZk3apIgtk0k1D71Z2p87qkky7zWr/RK+/B5t7D10FVqXTK3ssXl7NgwcxRJqm4K03MRnWRXwM+Yt3WINN6Kpk2s/mLFo4rgoBQ2gkHjH7g5KJNe6MX6XXrWR2op5ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bK9y82Tg6zKHNQy;
	Sat, 14 Jun 2025 17:31:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AA8AC1A0DEE;
	Sat, 14 Jun 2025 17:31:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19zQU1oHxfvPQ--.9099S5;
	Sat, 14 Jun 2025 17:31:42 +0800 (CST)
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
Subject: [PATCH RFC v2 1/5] elevator: introduce global lock for sq_shared elevator
Date: Sat, 14 Jun 2025 17:25:24 +0800
Message-Id: <20250614092528.2352680-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni19zQU1oHxfvPQ--.9099S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45GF4fuF48AF4xtrWDurg_yoWrtF4kpF
	45Jan0kr4qqr47Za4xAa17Jw43t3929ry3ZrWfAw45tFyxGrWxXF18GFy8ZF4xZrs3CFsF
	qr4ktFZ8WFyIg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUIiiDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, both mq-deadline and bfq have internal global lock, prepare
to convert them to use this high level lock and support batch request
dispatching.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c |  4 +--
 block/blk-mq.c       |  5 ++--
 block/elevator.c     |  1 +
 block/elevator.h     | 61 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..c1390d3e6381 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -113,7 +113,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (budget_token < 0)
 			break;
 
-		rq = e->type->ops.dispatch_request(hctx);
+		rq = elevator_dispatch_request(hctx);
 		if (!rq) {
 			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
@@ -342,7 +342,7 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge) {
-		ret = e->type->ops.bio_merge(q, bio, nr_segs);
+		ret = elevator_bio_merge(q, bio, nr_segs);
 		goto out_put;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..2650b7b28d1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2637,7 +2637,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
 
 		list_add(&rq->queuelist, &list);
-		q->elevator->type->ops.insert_requests(hctx, &list, flags);
+		elevator_insert_requests(hctx, &list, flags);
 	} else {
 		trace_block_rq_insert(rq);
 
@@ -2912,8 +2912,7 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 		spin_unlock(&this_hctx->lock);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
 	} else if (this_hctx->queue->elevator) {
-		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
-				&list, 0);
+		elevator_insert_requests(this_hctx, &list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
 	} else {
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..91df270d9d91 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -144,6 +144,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	eq->type = e;
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
+	spin_lock_init(&eq->lock);
 	hash_init(eq->hash);
 
 	return eq;
diff --git a/block/elevator.h b/block/elevator.h
index a07ce773a38f..8399dfe5c3b6 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -110,12 +110,12 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 /*
  * each queue has an elevator_queue associated with it
  */
-struct elevator_queue
-{
+struct elevator_queue {
 	struct elevator_type *type;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
+	spinlock_t lock;
 	unsigned long flags;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
@@ -186,4 +186,61 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 void blk_mq_sched_reg_debugfs(struct request_queue *q);
 void blk_mq_sched_unreg_debugfs(struct request_queue *q);
 
+#define elevator_lock(e)	spin_lock_irq(&(e)->lock)
+#define elevator_unlock(e)	spin_unlock_irq(&(e)->lock)
+
+static inline struct request *elevator_dispatch_request(
+		struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	struct elevator_queue *e = q->elevator;
+	bool sq_shared = blk_queue_sq_sched(q);
+	struct request *rq;
+
+	if (sq_shared)
+		elevator_lock(e);
+
+	rq = e->type->ops.dispatch_request(hctx);
+
+	if (sq_shared)
+		elevator_unlock(e);
+
+	return rq;
+}
+
+static inline void elevator_insert_requests(struct blk_mq_hw_ctx *hctx,
+					    struct list_head *list,
+					    blk_insert_t flags)
+{
+	struct request_queue *q = hctx->queue;
+	struct elevator_queue *e = q->elevator;
+	bool sq_shared = blk_queue_sq_sched(q);
+
+	if (sq_shared)
+		elevator_lock(e);
+
+	e->type->ops.insert_requests(hctx, list, flags);
+
+	if (sq_shared)
+		elevator_unlock(e);
+}
+
+static inline bool elevator_bio_merge(struct request_queue *q, struct bio *bio,
+				      unsigned int nr_segs)
+{
+	struct elevator_queue *e = q->elevator;
+	bool sq_shared = blk_queue_sq_sched(q);
+	bool ret;
+
+	if (sq_shared)
+		elevator_lock(e);
+
+	ret = e->type->ops.bio_merge(q, bio, nr_segs);
+
+	if (sq_shared)
+		elevator_unlock(e);
+
+	return ret;
+}
+
 #endif /* _ELEVATOR_H */
-- 
2.39.2


