Return-Path: <cgroups+bounces-10641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21075BCC4EE
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABF942818D
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172227B331;
	Fri, 10 Oct 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhMkkYeR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660727AC44;
	Fri, 10 Oct 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087727; cv=none; b=POaZ1dNOcdpUJQN5DOJwCZGeaLOqhEhDyN4t3mwNFyQGd7hyGR9dAXfhZ6YHdYeReNg22aJTzHHsk8LFoEwDEQzpMNvffDryCgfAdlr68zE9IN0K42QPkIHajby5fToREDf/NrxXjMM9AtZHA6s66sOcZKWsirW7egzFlGny2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087727; c=relaxed/simple;
	bh=5UU4sesvV9+dhG0cfl65lKFBzq/uovJuWrNs1r3kNr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgaH5628vtpnq7gmQofbJyV9BM+67LeeXhrJP400emSXLfK0OOqzeCY7uIjNXrFx1Crw+Sr74tzLHuZEnNhnhJ3xXoPrx6iHXT0FAjbJgycCbT71u9ii/rG6SlzohbbNmHr+x6KffoIA58sN6aB6FEXLBmCFXcU32J+FSRGnDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhMkkYeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71013C4CEFE;
	Fri, 10 Oct 2025 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087727;
	bh=5UU4sesvV9+dhG0cfl65lKFBzq/uovJuWrNs1r3kNr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhMkkYeR82SsEDde1Ipap7NRuMllA9iW6c5Y+KgG7VjxsSBwLnGlJEQFwmxcxu4s1
	 pGrqFNO3lPsN8j68ey9s1Of/SYn1W/Vho05Ktfbe2B9mhs8CUNzL+BkMKrHGA3Cgnu
	 cj+STcglNWjr81v7Q/z2Kt6OpEmsqMPTEdx0pzynwRhJ1P8uWn+74V8R06OZPHJ1uq
	 TCCJ8wIIfNSBvwPFmyOLUIoJ54oPAHqGSRdcl1+Jz+NzfXhXi1cdOBIHoQsEVQlzQz
	 4z5laSZiLxcQ3ICivl9pgHVrp/TmI1GydlfxN8vSNAqKjBcABFIN99zhR5Gnrj4fTc
	 oOv8rPn5ow0uA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 12/19] blk-throttle: fix possible deadlock due to queue_lock in timer
Date: Fri, 10 Oct 2025 17:14:37 +0800
Message-ID: <20251010091446.3048529-13-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Abusing queue_lock to protect blk-throttle can cause deadlock:

1) throtl_pending_timer_fn() will hold the lock, while throtl_pd_free()
   will flush the timer, this is fixed by protecting blkgs with
   blkcg_mutex instead of queue_lock by previous patches.
2) queue_lock can be held from hardirq context, hence if
   throtl_pending_timer_fn() is interrupted by hardirq, deadlock can be
   triggered as well.

Stop abusing queue_lock to protect blk-throttle, and intorduce a new
internal lock td->lock for protection. And now that the new lock won't
be grabbed from hardirq context, it's safe to use spin_lock_bh() from
thread context and spin_lock() directly from softirq context.

Fixes: 6e1a5704cbbd ("blk-throttle: dispatch from throtl_pending_timer_fn()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cb3bfdb4684a..7feaa2ef0a6b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -33,6 +33,7 @@ static struct workqueue_struct *kthrotld_workqueue;
 
 struct throtl_data
 {
+	spinlock_t lock;
 	/* service tree for active throtl groups */
 	struct throtl_service_queue service_queue;
 
@@ -1149,7 +1150,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	else
 		q = td->queue;
 
-	spin_lock_irq(&q->queue_lock);
+	spin_lock(&td->lock);
 
 	if (!q->root_blkg)
 		goto out_unlock;
@@ -1175,9 +1176,9 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 			break;
 
 		/* this dispatch windows is still open, relax and repeat */
-		spin_unlock_irq(&q->queue_lock);
+		spin_unlock(&td->lock);
 		cpu_relax();
-		spin_lock_irq(&q->queue_lock);
+		spin_lock(&td->lock);
 	}
 
 	if (!dispatched)
@@ -1200,7 +1201,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 		queue_work(kthrotld_workqueue, &td->dispatch_work);
 	}
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock(&td->lock);
 }
 
 /**
@@ -1216,7 +1217,6 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	struct throtl_data *td = container_of(work, struct throtl_data,
 					      dispatch_work);
 	struct throtl_service_queue *td_sq = &td->service_queue;
-	struct request_queue *q = td->queue;
 	struct bio_list bio_list_on_stack;
 	struct bio *bio;
 	struct blk_plug plug;
@@ -1224,11 +1224,11 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 
 	bio_list_init(&bio_list_on_stack);
 
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_bh(&td->lock);
 	for (rw = READ; rw <= WRITE; rw++)
 		while ((bio = throtl_pop_queued(td_sq, NULL, rw)))
 			bio_list_add(&bio_list_on_stack, bio);
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_bh(&td->lock);
 
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
@@ -1306,7 +1306,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	rcu_read_unlock();
 
 	/*
-	 * We're already holding queue_lock and know @tg is valid.  Let's
+	 * We're already holding td->lock and know @tg is valid.  Let's
 	 * apply the new config directly.
 	 *
 	 * Restart the slices for both READ and WRITES. It might happen
@@ -1333,6 +1333,7 @@ static int blk_throtl_init(struct gendisk *disk)
 	if (!td)
 		return -ENOMEM;
 
+	spin_lock_init(&td->lock);
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
@@ -1703,12 +1704,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 	if (!blk_throtl_activated(q))
 		return;
 
-	spin_lock_irq(&q->queue_lock);
-	/*
-	 * queue_lock is held, rcu lock is not needed here technically.
-	 * However, rcu lock is still held to emphasize that following
-	 * path need RCU protection and to prevent warning from lockdep.
-	 */
+	spin_lock_bh(&q->td->lock);
 	rcu_read_lock();
 	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
 		/*
@@ -1722,7 +1718,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		tg_flush_bios(blkg_to_tg(blkg));
 	}
 	rcu_read_unlock();
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_bh(&q->td->lock);
 }
 
 static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
@@ -1755,7 +1751,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 
 bool __blk_throtl_bio(struct bio *bio)
 {
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1765,7 +1760,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	struct throtl_data *td = tg->td;
 
 	rcu_read_lock();
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_bh(&td->lock);
 	sq = &tg->service_queue;
 
 	while (true) {
@@ -1841,7 +1836,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_bh(&td->lock);
 
 	rcu_read_unlock();
 	return throttled;
-- 
2.51.0


