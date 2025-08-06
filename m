Return-Path: <cgroups+bounces-8993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E839B1C2CD
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D467A7818
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BF28A707;
	Wed,  6 Aug 2025 09:04:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA288CAF;
	Wed,  6 Aug 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471084; cv=none; b=VwneOKF3Udam0RfflOAxZunacVApipGbiQdx5LxBOPpAQix9cnSTrUgbMGIQbovnoH2/eX0+xootg9vefk/Hu0HvmIX2J5jRaqjML7ueEh0TcYfpwhX1gf+Qp2NJQbCDyppVxbayPDGLI7BHuQ5KlZlOWph4cMK9GGLqrAFSDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471084; c=relaxed/simple;
	bh=aInM3tcJXxAsiF0y+LwvtUH3ShUHUjeALm9xonqJjVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZFmMW5F3T65FzzMO+kNrhYiSw/v6bGRh+54XiMXc44NjYcxmDAsntTjPvI/tnSQNHnvBPP6dpP9FT8NEsHFv9gItA0ictsR5W/Or9biihWlYZk9lXMsjEGF/0FbuPIo6aQlKijqSukF3jkzFlULGHSRS5CmH2WP9Mcbylkpl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxkrS5vKzzKHMyc;
	Wed,  6 Aug 2025 17:04:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DDB3E1A0C12;
	Wed,  6 Aug 2025 17:04:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxOjGpNowBAGCw--.58870S7;
	Wed, 06 Aug 2025 17:04:39 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	jack@suse.cz,
	bvanassche@acm.org,
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
Subject: [PATCH v3 3/5] block, bfq: switch to use elevator lock
Date: Wed,  6 Aug 2025 16:57:18 +0800
Message-Id: <20250806085720.4040507-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
References: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxOjGpNowBAGCw--.58870S7
X-Coremail-Antispam: 1UD129KBjvJXoW3uF18CFW5KF4UWw4xAr1kKrg_yoWDKF4kpa
	1fKa90kr48Xr4FvF4jkwsFqw47Kwsagr9FvryxW3yftFWxJrnxX3ZYyFyFvF4SgFn7CFs0
	qr1jgayvyF1UtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Replace the internal spinlock 'bfqd->lock' with the new spinlock in
elevator_queue, things will keep working the same way as before.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c   |  6 ++---
 block/bfq-iosched.c  | 53 ++++++++++++++++++++------------------------
 block/bfq-iosched.h  |  2 --
 block/blk-mq-sched.c |  4 ++--
 4 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..a23622cc2be2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -746,7 +746,7 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
  * @bic: the bic to move.
  * @bfqg: the group to move to.
  *
- * Move bic to blkcg, assuming that bfqd->lock is held; which makes
+ * Move bic to blkcg, assuming that elevator lock is held; which makes
  * sure that the reference to cgroup is valid across the call (see
  * comments in bfq_bic_update_cgroup on this issue)
  */
@@ -878,7 +878,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	elevator_lock_irqsave(bfqd->queue->elevator, flags);
 
 	if (!entity) /* root group */
 		goto put_async_queues;
@@ -923,7 +923,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
 
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	elevator_unlock_irqrestore(bfqd->queue->elevator, flags);
 	/*
 	 * @blkg is going offline and will be ignored by
 	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f71ec0887733..f7962072d3aa 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -466,7 +466,7 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
  */
 void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
-	lockdep_assert_held(&bfqd->lock);
+	elevator_lock_assert_held(bfqd->queue->elevator);
 
 	if (bfqd->queued != 0) {
 		bfq_log(bfqd, "schedule dispatch");
@@ -591,7 +591,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 	int level;
 
 retry:
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(bfqd->queue->elevator);
 	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
 	if (!bfqq)
 		goto out;
@@ -603,7 +603,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 	/* +1 for bfqq entity, root cgroup not included */
 	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
 	if (depth > alloc_depth) {
-		spin_unlock_irq(&bfqd->lock);
+		elevator_unlock_irq(bfqd->queue->elevator);
 		if (entities != inline_entities)
 			kfree(entities);
 		entities = kmalloc_array(depth, sizeof(*entities), GFP_NOIO);
@@ -661,7 +661,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 		}
 	}
 out:
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(bfqd->queue->elevator);
 	if (entities != inline_entities)
 		kfree(entities);
 	return ret;
@@ -2217,7 +2217,7 @@ static void bfq_add_request(struct request *rq)
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
 	/*
-	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
+	 * Updating of 'bfqd->queued' is protected by elevator lock, however, it
 	 * may be read without holding the lock in bfq_has_work().
 	 */
 	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
@@ -2397,7 +2397,7 @@ static void bfq_remove_request(struct request_queue *q,
 		list_del_init(&rq->queuelist);
 	bfqq->queued[sync]--;
 	/*
-	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
+	 * Updating of 'bfqd->queued' is protected by elevator lock, however, it
 	 * may be read without holding the lock in bfq_has_work().
 	 */
 	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
@@ -2454,7 +2454,7 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 	struct request *free = NULL;
 	bool ret;
 
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(q->elevator);
 
 	if (bic) {
 		/*
@@ -2472,7 +2472,7 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(q->elevator);
 	if (free)
 		blk_mq_free_request(free);
 
@@ -2647,7 +2647,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq;
 	int i;
 
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(bfqd->queue->elevator);
 
 	for (i = 0; i < bfqd->num_actuators; i++) {
 		list_for_each_entry(bfqq, &bfqd->active_list[i], bfqq_list)
@@ -2657,7 +2657,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
 
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(bfqd->queue->elevator);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
@@ -5303,8 +5303,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled = false;
 
-	spin_lock_irq(&bfqd->lock);
-
 	in_serv_queue = bfqd->in_service_queue;
 	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
@@ -5314,7 +5312,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
 	}
 
-	spin_unlock_irq(&bfqd->lock);
 	bfq_update_dispatch_stats(hctx->queue, rq,
 			idle_timer_disabled ? in_serv_queue : NULL,
 				idle_timer_disabled);
@@ -5492,9 +5489,9 @@ static void bfq_exit_icq(struct io_cq *icq)
 	 * this is the last time these queues are accessed.
 	 */
 	if (bfqd) {
-		spin_lock_irqsave(&bfqd->lock, flags);
+		elevator_lock_irqsave(bfqd->queue->elevator, flags);
 		_bfq_exit_icq(bic, bfqd->num_actuators);
-		spin_unlock_irqrestore(&bfqd->lock, flags);
+		elevator_unlock_irqrestore(bfqd->queue->elevator, flags);
 	} else {
 		_bfq_exit_icq(bic, BFQ_MAX_ACTUATORS);
 	}
@@ -6250,10 +6247,10 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(q->elevator);
 	bfqq = bfq_init_rq(rq);
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
-		spin_unlock_irq(&bfqd->lock);
+		elevator_unlock_irq(q->elevator);
 		blk_mq_free_requests(&free);
 		return;
 	}
@@ -6286,7 +6283,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 * merge).
 	 */
 	cmd_flags = rq->cmd_flags;
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(q->elevator);
 
 	bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
 				cmd_flags);
@@ -6667,7 +6664,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 					     rq->io_start_time_ns,
 					     rq->cmd_flags);
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	elevator_lock_irqsave(bfqd->queue->elevator, flags);
 	if (likely(rq->rq_flags & RQF_STARTED)) {
 		if (rq == bfqd->waited_rq)
 			bfq_update_inject_limit(bfqd, bfqq);
@@ -6677,7 +6674,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 	bfqq_request_freed(bfqq);
 	bfq_put_queue(bfqq);
 	RQ_BIC(rq)->requests--;
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	elevator_unlock_irqrestore(bfqd->queue->elevator, flags);
 
 	/*
 	 * Reset private fields. In case of a requeue, this allows
@@ -7008,7 +7005,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	enum bfqq_expiration reason;
 	unsigned long flags;
 
-	spin_lock_irqsave(&bfqd->lock, flags);
+	elevator_lock_irqsave(bfqd->queue->elevator, flags);
 
 	/*
 	 * Considering that bfqq may be in race, we should firstly check
@@ -7018,7 +7015,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	 * been cleared in __bfq_bfqd_reset_in_service func.
 	 */
 	if (bfqq != bfqd->in_service_queue) {
-		spin_unlock_irqrestore(&bfqd->lock, flags);
+		elevator_unlock_irqrestore(bfqd->queue->elevator, flags);
 		return;
 	}
 
@@ -7046,7 +7043,7 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 schedule_dispatch:
 	bfq_schedule_dispatch(bfqd);
-	spin_unlock_irqrestore(&bfqd->lock, flags);
+	elevator_unlock_irqrestore(bfqd->queue->elevator, flags);
 }
 
 /*
@@ -7172,10 +7169,10 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(e);
 	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(e);
 
 	for (actuator = 0; actuator < bfqd->num_actuators; actuator++)
 		WARN_ON_ONCE(bfqd->rq_in_driver[actuator]);
@@ -7189,10 +7186,10 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(bfqd->queue->disk, &blkcg_policy_bfq);
 #else
-	spin_lock_irq(&bfqd->lock);
+	elevator_lock_irq(e);
 	bfq_put_async_queues(bfqd, bfqd->root_group);
 	kfree(bfqd->root_group);
-	spin_unlock_irq(&bfqd->lock);
+	elevator_unlock_irq(e);
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
@@ -7357,8 +7354,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* see comments on the definition of next field inside bfq_data */
 	bfqd->actuator_load_threshold = 4;
 
-	spin_lock_init(&bfqd->lock);
-
 	/*
 	 * The invocation of the next bfq_create_group_hierarchy
 	 * function is the head of a chain of function calls
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 687a3a7ba784..dab908f05235 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -795,8 +795,6 @@ struct bfq_data {
 	/* fallback dummy bfqq for extreme OOM conditions */
 	struct bfq_queue oom_bfqq;
 
-	spinlock_t lock;
-
 	/*
 	 * bic associated with the task issuing current bio for
 	 * merging. This and the next field are used as a support to
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1a2da5edbe13..42e3ec06c072 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -114,9 +114,9 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			break;
 
 		if (blk_queue_sq_sched(q)) {
-			elevator_lock(e);
+			elevator_lock_irq(e);
 			rq = e->type->ops.dispatch_request(hctx);
-			elevator_unlock(e);
+			elevator_unlock_irq(e);
 		} else {
 			rq = e->type->ops.dispatch_request(hctx);
 		}
-- 
2.39.2


