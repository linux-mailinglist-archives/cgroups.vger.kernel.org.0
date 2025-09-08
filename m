Return-Path: <cgroups+bounces-9783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185DB48877
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94784E15A8
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F22F60A2;
	Mon,  8 Sep 2025 09:29:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E32F068E;
	Mon,  8 Sep 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323771; cv=none; b=aYaSa+saQM3tnol1J4cshzfzhaD6ProxDPLCVLb5W0JZQNUqtNz2Owxk+9lIGdz4cQ8SwkvaJ00HsSsCwgxangd58hPaApzXJL+3IhSt+9AmgR+Yd+nZMNcL6mxmk8rzN4VXuv4rNqvWPcZGZwCcQhhTD6iWZw1txo/v6gb2+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323771; c=relaxed/simple;
	bh=Syo51umTQhqv1HC0LouVUaYiyrIvpOJaTmFlhLQhDNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxiQ8LCv+5OiWtAniDnZ+r3khqIfGQN7oxtYMbb5dzs5aYdF/PyZiG5gZXDGq3ijy7QkVf/DXbfqCN7tYS5EU5Z31Rfd3K9Q6wv6k8bEhRgyl1JfJaLyGKdxpihygMEKDYUAKAcY52QtTI+R+S2vvF0+XFjWuiltQeZXEjofDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cL1qr5zwWzYQvYf;
	Mon,  8 Sep 2025 17:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 565061A174E;
	Mon,  8 Sep 2025 17:29:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzzob5oGjMyBw--.46699S6;
	Mon, 08 Sep 2025 17:29:27 +0800 (CST)
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
Subject: [PATCH v4 for-6.18/block 2/5] mq-deadline: switch to use elevator lock
Date: Mon,  8 Sep 2025 17:20:04 +0800
Message-Id: <20250908092007.3796967-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXYIzzob5oGjMyBw--.46699S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XryrGFyfKFWrZFW8ZF18Zrb_yoW3ur48pF
	W5Ka90yr4rXFsrZF1DJa9rZr4agw4I9342qr93Kw4fKFn7Jr9rW3WjkF10vrs3Jr9rCFsI
	gF4qga98JF17Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUOdgAUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Replace the internal spinlock 'dd->lock' with the new spinlock in
elevator_queue, things will keep working the same way as before.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/mq-deadline.c | 60 ++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2e689b2c4021..2f394571a6ba 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -101,7 +101,7 @@ struct deadline_data {
 	u32 async_depth;
 	int prio_aging_expire;
 
-	spinlock_t lock;
+	struct elevator_queue *e;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	dd->per_prio[prio].stats.merged++;
 
@@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 {
 	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	return stats->inserted - atomic_read(&stats->completed);
 }
@@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	enum dd_prio prio;
 	u8 ioprio_class;
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	if (!list_empty(&per_prio->dispatch)) {
 		rq = list_first_entry(&per_prio->dispatch, struct request,
@@ -434,7 +434,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	enum dd_prio prio;
 	int prio_cnt;
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
 		   !!dd_queued(dd, DD_IDLE_PRIO);
@@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
-	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
-		goto unlock;
+		return rq;
 
 	/*
 	 * Next, dispatch requests in priority order. Ignore lower priority
@@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			break;
 	}
 
-unlock:
-	spin_unlock(&dd->lock);
-
 	return rq;
 }
 
@@ -528,9 +524,9 @@ static void dd_exit_sched(struct elevator_queue *e)
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
 
-		spin_lock(&dd->lock);
+		elevator_lock(e);
 		queued = dd_queued(dd, prio);
-		spin_unlock(&dd->lock);
+		elevator_unlock(e);
 
 		WARN_ONCE(queued != 0,
 			  "statistics for priority %d: i %u m %u d %u c %u\n",
@@ -571,7 +567,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
-	spin_lock_init(&dd->lock);
+	dd->e = eq;
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
@@ -620,13 +616,12 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
 	struct request *free = NULL;
 	bool ret;
 
-	spin_lock(&dd->lock);
+	elevator_lock(q->elevator);
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
-	spin_unlock(&dd->lock);
+	elevator_unlock(q->elevator);
 
 	if (free)
 		blk_mq_free_request(free);
@@ -648,7 +643,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
@@ -689,10 +684,9 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       blk_insert_t flags)
 {
 	struct request_queue *q = hctx->queue;
-	struct deadline_data *dd = q->elevator->elevator_data;
 	LIST_HEAD(free);
 
-	spin_lock(&dd->lock);
+	elevator_lock(q->elevator);
 	while (!list_empty(list)) {
 		struct request *rq;
 
@@ -700,7 +694,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 		list_del_init(&rq->queuelist);
 		dd_insert_request(hctx, rq, flags, &free);
 	}
-	spin_unlock(&dd->lock);
+	elevator_unlock(q->elevator);
 
 	blk_mq_free_requests(&free);
 }
@@ -816,13 +810,13 @@ static const struct elv_fs_entry deadline_attrs[] = {
 #define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
 static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 					  loff_t *pos)			\
-	__acquires(&dd->lock)						\
+	__acquires(&dd->e->lock)					\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
 									\
-	spin_lock(&dd->lock);						\
+	elevator_lock(dd->e);						\
 	return seq_list_start(&per_prio->fifo_list[data_dir], *pos);	\
 }									\
 									\
@@ -837,12 +831,12 @@ static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
 }									\
 									\
 static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(&d->e->lock)						\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
-	spin_unlock(&dd->lock);						\
+	elevator_unlock(dd->e);						\
 }									\
 									\
 static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
@@ -908,11 +902,11 @@ static int dd_queued_show(void *data, struct seq_file *m)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	u32 rt, be, idle;
 
-	spin_lock(&dd->lock);
+	elevator_lock(dd->e);
 	rt = dd_queued(dd, DD_RT_PRIO);
 	be = dd_queued(dd, DD_BE_PRIO);
 	idle = dd_queued(dd, DD_IDLE_PRIO);
-	spin_unlock(&dd->lock);
+	elevator_unlock(dd->e);
 
 	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
@@ -924,7 +918,7 @@ static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
 {
 	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
 
-	lockdep_assert_held(&dd->lock);
+	elevator_lock_assert_held(dd->e);
 
 	return stats->dispatched + stats->merged -
 		atomic_read(&stats->completed);
@@ -936,11 +930,11 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	u32 rt, be, idle;
 
-	spin_lock(&dd->lock);
+	elevator_lock(dd->e);
 	rt = dd_owned_by_driver(dd, DD_RT_PRIO);
 	be = dd_owned_by_driver(dd, DD_BE_PRIO);
 	idle = dd_owned_by_driver(dd, DD_IDLE_PRIO);
-	spin_unlock(&dd->lock);
+	elevator_unlock(dd->e);
 
 	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
@@ -950,13 +944,13 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 #define DEADLINE_DISPATCH_ATTR(prio)					\
 static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
 					     loff_t *pos)		\
-	__acquires(&dd->lock)						\
+	__acquires(&dd->e->lock)					\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
 									\
-	spin_lock(&dd->lock);						\
+	elevator_lock(dd->e);						\
 	return seq_list_start(&per_prio->dispatch, *pos);		\
 }									\
 									\
@@ -971,12 +965,12 @@ static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
 }									\
 									\
 static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(&dd->e->lock)					\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
-	spin_unlock(&dd->lock);						\
+	elevator_unlock(dd->e);						\
 }									\
 									\
 static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
-- 
2.39.2


