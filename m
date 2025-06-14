Return-Path: <cgroups+bounces-8526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD71AD9BD2
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD003BC7DB
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D325A355;
	Sat, 14 Jun 2025 09:31:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAF15E5BB;
	Sat, 14 Jun 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749893510; cv=none; b=LvWZe9jdO0NITNYGwkR7/6uGUxME7hBqsrZtAEMVz2Dvd5Lu8QbZa8T71tS4CqmNJYLke1D92PaBL3fpAgK2NkBklvzLFrBL3MtZcLxVqo+4/TvMTqRYHIWyI/5NbuWmFvvfk6MtCs2hhPn7rrr1YYIFv6REvMNNJ+WK97ja6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749893510; c=relaxed/simple;
	bh=SuPqZnoUl5cN0mQBBZZdsrZLQjAzocXjgpUF4FZc4n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lo2rsofY7bA/H29Ai28O/hdpTCHsvYiQlhc8yPafHRcNcpldtR7wmZ6PLd57AnwHUTTsngKwQjfdPg4CtPqbybAM2VuK81kHalgS0zhiAUu5zAIn7khHra+ohuVqN894M49rT2StyNcYQuKkU0+CazNi3p0tl7hsFdIKW0DRQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bK9y92SjDzKHNXs;
	Sat, 14 Jun 2025 17:31:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD3271A1F67;
	Sat, 14 Jun 2025 17:31:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19zQU1oHxfvPQ--.9099S7;
	Sat, 14 Jun 2025 17:31:43 +0800 (CST)
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
Subject: [PATCH RFC v2 3/5] block, bfq: switch to use elevator lock
Date: Sat, 14 Jun 2025 17:25:26 +0800
Message-Id: <20250614092528.2352680-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni19zQU1oHxfvPQ--.9099S7
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWfKw1UGr1ruw4UCFyDKFg_yoWfAryrpa
	1fKanIyw48Xr1FqF48Gw4qqr42gws3u3srKryxX3yftrZYywnxX3WFyryFvF4SqFs7Crsx
	Wr1jg39ayF4UJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JULBMNUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Convert 'bfqd->lock' to high level 'q->elevator->lock', prepare to support
batch requests dispatching.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  4 ++--
 block/bfq-iosched.c | 53 +++++++++++++++------------------------------
 block/bfq-iosched.h |  2 +-
 3 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..1717bac7eccc 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -878,7 +878,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	spin_lock_irqsave(bfqd->lock, flags);
 
 	if (!entity) /* root group */
 		goto put_async_queues;
@@ -923,7 +923,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
 
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	spin_unlock_irqrestore(bfqd->lock, flags);
 	/*
 	 * @blkg is going offline and will be ignored by
 	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..fd6d81a185f7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -473,7 +473,7 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
  */
 void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
-	lockdep_assert_held(&bfqd->lock);
+	lockdep_assert_held(bfqd->lock);
 
 	if (bfqd->queued != 0) {
 		bfq_log(bfqd, "schedule dispatch");
@@ -598,7 +598,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 	int level;
 
 retry:
-	spin_lock_irq(&bfqd->lock);
+	spin_lock_irq(bfqd->lock);
 	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
 	if (!bfqq)
 		goto out;
@@ -610,7 +610,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 	/* +1 for bfqq entity, root cgroup not included */
 	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
 	if (depth > alloc_depth) {
-		spin_unlock_irq(&bfqd->lock);
+		spin_unlock_irq(bfqd->lock);
 		if (entities != inline_entities)
 			kfree(entities);
 		entities = kmalloc_array(depth, sizeof(*entities), GFP_NOIO);
@@ -668,7 +668,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 		}
 	}
 out:
-	spin_unlock_irq(&bfqd->lock);
+	spin_unlock_irq(bfqd->lock);
 	if (entities != inline_entities)
 		kfree(entities);
 	return ret;
@@ -2458,18 +2458,9 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *free = NULL;
-	/*
-	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
-	 * store its return value for later use, to avoid nesting
-	 * queue_lock inside the bfqd->lock. We assume that the bic
-	 * returned by bfq_bic_lookup does not go away before
-	 * bfqd->lock is taken.
-	 */
 	struct bfq_io_cq *bic = bfq_bic_lookup(q);
 	bool ret;
 
-	spin_lock_irq(&bfqd->lock);
-
 	if (bic) {
 		/*
 		 * Make sure cgroup info is uptodate for current process before
@@ -2485,8 +2476,6 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 	bfqd->bio_bic = bic;
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
-
-	spin_unlock_irq(&bfqd->lock);
 	if (free)
 		blk_mq_free_request(free);
 
@@ -2661,7 +2650,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq;
 	int i;
 
-	spin_lock_irq(&bfqd->lock);
+	spin_lock_irq(bfqd->lock);
 
 	for (i = 0; i < bfqd->num_actuators; i++) {
 		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
@@ -2671,7 +2660,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
 
-	spin_unlock_irq(&bfqd->lock);
+	spin_unlock_irq(bfqd->lock);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
@@ -5317,8 +5306,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled = false;
 
-	spin_lock_irq(&bfqd->lock);
-
 	in_serv_queue = bfqd->in_service_queue;
 	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
@@ -5328,7 +5315,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
 	}
 
-	spin_unlock_irq(&bfqd->lock);
 	bfq_update_dispatch_stats(hctx->queue, rq,
 			idle_timer_disabled ? in_serv_queue : NULL,
 				idle_timer_disabled);
@@ -5506,9 +5492,9 @@ static void bfq_exit_icq(struct io_cq *icq)
 	 * this is the last time these queues are accessed.
 	 */
 	if (bfqd) {
-		spin_lock_irqsave(&bfqd->lock, flags);
+		spin_lock_irqsave(bfqd->lock, flags);
 		_bfq_exit_icq(bic, bfqd->num_actuators);
-		spin_unlock_irqrestore(&bfqd->lock, flags);
+		spin_unlock_irqrestore(bfqd->lock, flags);
 	} else {
 		_bfq_exit_icq(bic, BFQ_MAX_ACTUATORS);
 	}
@@ -6264,10 +6250,8 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
-	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
-		spin_unlock_irq(&bfqd->lock);
 		blk_mq_free_requests(&free);
 		return;
 	}
@@ -6300,7 +6284,6 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 * merge).
 	 */
 	cmd_flags = rq->cmd_flags;
-	spin_unlock_irq(&bfqd->lock);
 
 	bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
 				cmd_flags);
@@ -6681,7 +6664,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 					     rq->io_start_time_ns,
 					     rq->cmd_flags);
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	spin_lock_irqsave(bfqd->lock, flags);
 	if (likely(rq->rq_flags & RQF_STARTED)) {
 		if (rq == bfqd->waited_rq)
 			bfq_update_inject_limit(bfqd, bfqq);
@@ -6691,7 +6674,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 	bfqq_request_freed(bfqq);
 	bfq_put_queue(bfqq);
 	RQ_BIC(rq)->requests--;
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	spin_unlock_irqrestore(bfqd->lock, flags);
 
 	/*
 	 * Reset private fields. In case of a requeue, this allows
@@ -7022,7 +7005,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	enum bfqq_expiration reason;
 	unsigned long flags;
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	spin_lock_irqsave(bfqd->lock, flags);
 
 	/*
 	 * Considering that bfqq may be in race, we should firstly check
@@ -7032,7 +7015,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	 * been cleared in __bfq_bfqd_reset_in_service func.
 	 */
 	if (bfqq != bfqd->in_service_queue) {
-		spin_unlock_irqrestore(&bfqd->lock, flags);
+		spin_unlock_irqrestore(bfqd->lock, flags);
 		return;
 	}
 
@@ -7060,7 +7043,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 schedule_dispatch:
 	bfq_schedule_dispatch(bfqd);
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	spin_unlock_irqrestore(bfqd->lock, flags);
 }
 
 /*
@@ -7186,10 +7169,10 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
-	spin_lock_irq(&bfqd->lock);
+	spin_lock_irq(bfqd->lock);
 	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
-	spin_unlock_irq(&bfqd->lock);
+	spin_unlock_irq(bfqd->lock);
 
 	for (actuator = 0; actuator < bfqd->num_actuators; actuator++)
 		WARN_ON_ONCE(bfqd->rq_in_driver[actuator]);
@@ -7203,10 +7186,10 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 #else
-	spin_lock_irq(&bfqd->lock);
+	spin_lock_irq(bfqd->lock);
 	bfq_put_async_queues(bfqd, bfqd->root_group);
 	kfree(bfqd->root_group);
-	spin_unlock_irq(&bfqd->lock);
+	spin_unlock_irq(bfqd->lock);
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
@@ -7371,7 +7354,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* see comments on the definition of next field inside bfq_data */
 	bfqd->actuator_load_threshold = 4;
 
-	spin_lock_init(&bfqd->lock);
+	bfqd->lock = &eq->lock;
 
 	/*
 	 * The invocation of the next bfq_create_group_hierarchy
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 687a3a7ba784..d70eb6529dab 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -795,7 +795,7 @@ struct bfq_data {
 	/* fallback dummy bfqq for extreme OOM conditions */
 	struct bfq_queue oom_bfqq;
 
-	spinlock_t lock;
+	spinlock_t *lock;
 
 	/*
 	 * bic associated with the task issuing current bio for
-- 
2.39.2


