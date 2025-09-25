Return-Path: <cgroups+bounces-10447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA10B9E0DE
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C9D7AB71B
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFA2EC082;
	Thu, 25 Sep 2025 08:25:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF12EA16A;
	Thu, 25 Sep 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788758; cv=none; b=jbePAQLJQ255uvU4ag4LoUN/7xRuUELZ/l4yAGj0Sh9QYEmxkn+B9/ajBTql0QZ9kTdzq2+wUbDeqmag5C8E3z0iFjP9LKLQPN7l+g7senEKjATJ/AHIOG/MiGaISHXPXWRBEird51I2M5A2a6Q1ELrZvVyD9s4qZFW/p3QUEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788758; c=relaxed/simple;
	bh=AaJ1+MMzk64vHzOglRtANSXkg4fvCRkyoL6gtlFsyak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekC8+7UWe2lJDvG/NICLeVgz4xK/ZyKCDzSScwl7hNjKr05IlTmQ7OUQ896lDApn+bkCvVgnobU3d/HAfHPnSVweaxHlZWPI1GlmLF3+wCv398L+N3MSfvIYbmOlRFhVQ8weMn+gl/GChcwIFCZ/m73ec+2KwE5jDol/IjDbczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcS6FqTzKHN4d;
	Thu, 25 Sep 2025 16:25:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B76B21A13D3;
	Thu, 25 Sep 2025 16:25:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S14;
	Thu, 25 Sep 2025 16:25:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	vgoyal@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 10/10] blk-throttle: fix possible deadlock due to queue_lock in timer
Date: Thu, 25 Sep 2025 16:15:25 +0800
Message-Id: <20250925081525.700639-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250925081525.700639-1-yukuai1@huaweicloud.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S14
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUCr4rGF13XFy7Ar45GFg_yoW7XryrpF
	Waga1ayw48Xr4q9r9rG3Wq9FWagw4vg3y5t393Ja13tr4Fvrn8WF1DAFyFvayFvFsruanx
	Zr4Ut395JF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

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
index 2c5b64b1a724..a2fa440559c9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -33,6 +33,7 @@ static struct workqueue_struct *kthrotld_workqueue;
 
 struct throtl_data
 {
+	spinlock_t lock;
 	/* service tree for active throtl groups */
 	struct throtl_service_queue service_queue;
 
@@ -1140,7 +1141,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	else
 		q = td->queue;
 
-	spin_lock_irq(&q->queue_lock);
+	spin_lock(&td->lock);
 
 	if (!q->root_blkg)
 		goto out_unlock;
@@ -1166,9 +1167,9 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 			break;
 
 		/* this dispatch windows is still open, relax and repeat */
-		spin_unlock_irq(&q->queue_lock);
+		spin_unlock(&td->lock);
 		cpu_relax();
-		spin_lock_irq(&q->queue_lock);
+		spin_lock(&td->lock);
 	}
 
 	if (!dispatched)
@@ -1191,7 +1192,7 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 		queue_work(kthrotld_workqueue, &td->dispatch_work);
 	}
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock(&td->lock);
 }
 
 /**
@@ -1207,7 +1208,6 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	struct throtl_data *td = container_of(work, struct throtl_data,
 					      dispatch_work);
 	struct throtl_service_queue *td_sq = &td->service_queue;
-	struct request_queue *q = td->queue;
 	struct bio_list bio_list_on_stack;
 	struct bio *bio;
 	struct blk_plug plug;
@@ -1215,11 +1215,11 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 
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
@@ -1297,7 +1297,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	rcu_read_unlock();
 
 	/*
-	 * We're already holding queue_lock and know @tg is valid.  Let's
+	 * We're already holding td->lock and know @tg is valid.  Let's
 	 * apply the new config directly.
 	 *
 	 * Restart the slices for both READ and WRITES. It might happen
@@ -1324,6 +1324,7 @@ static int blk_throtl_init(struct gendisk *disk)
 	if (!td)
 		return -ENOMEM;
 
+	spin_lock_init(&td->lock);
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
 
@@ -1694,12 +1695,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
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
@@ -1713,7 +1709,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		tg_flush_bios(blkg_to_tg(blkg));
 	}
 	rcu_read_unlock();
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_bh(&q->td->lock);
 }
 
 static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
@@ -1746,7 +1742,6 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 
 bool __blk_throtl_bio(struct bio *bio)
 {
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg);
@@ -1756,7 +1751,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	struct throtl_data *td = tg->td;
 
 	rcu_read_lock();
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_bh(&td->lock);
 	sq = &tg->service_queue;
 
 	while (true) {
@@ -1832,7 +1827,7 @@ bool __blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_bh(&td->lock);
 
 	rcu_read_unlock();
 	return throttled;
-- 
2.39.2


