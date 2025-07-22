Return-Path: <cgroups+bounces-8824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A242EB0D362
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14653BD8D6
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4312D9790;
	Tue, 22 Jul 2025 07:31:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59D21C178;
	Tue, 22 Jul 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169461; cv=none; b=GrydULQNWQDZG7RyNJsGhKm7i6QWorw3tfhnbY1m9v6RkiAPKqtzfHTlfDNpIktBig//OiZBJyiy2A1AbcpQhsx5c15VCd17LZ94GF3jWmTwWn9RadxMmqvWVdxTMNPrNw3j6LpfMi3kStak33P+LYq1HyM0FNckOgFG4EV1hyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169461; c=relaxed/simple;
	bh=CshaAEJ50QzSmD4QbdcSERaTf9DX+000tbGE3KVJv6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SSlEyGh1OjUDpyq9bcFFKcDprzMgw5q4jeCgvv8qaez8DWeEonnItizf4NJzEcr1pIB7w5wDkr4zN3GBmKyIdFeLvfUjfTITj5XvDkDsL58hpCPEh89EqP4bERBT7CcF9vGyFoIdwlDY1pS/9hnE1Gw1tY/3ugT1ArsYazUgIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmTTC3bxCzKHMvb;
	Tue, 22 Jul 2025 15:30:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 345241A124B;
	Tue, 22 Jul 2025 15:30:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMrPn9ovjJdBA--.52549S5;
	Tue, 22 Jul 2025 15:30:54 +0800 (CST)
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
Subject: [PATCH 1/6] mq-deadline: switch to use high layer elevator lock
Date: Tue, 22 Jul 2025 15:24:26 +0800
Message-Id: <20250722072431.610354-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnYhMrPn9ovjJdBA--.52549S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr43Gr18ZryDAF47XFy8uFg_yoWfXF1rpF
	W5KanIyw4rXFsrXF1DJayDZr4agw4I9ry7tr93Gw4fKFn7Ar9rXF1UGF4Fvrs5Jr97CFsI
	gF4jqa98AF17JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Introduce a new spinlock in elevator_queue, and switch dd->lock to
use the new lock. There are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/elevator.c    |  1 +
 block/elevator.h    |  4 ++--
 block/mq-deadline.c | 57 ++++++++++++++++++++++-----------------------
 3 files changed, 31 insertions(+), 31 deletions(-)

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
index a07ce773a38f..cbbac4f7825c 100644
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
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2edf1cac06d5..e31da6de7764 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -101,7 +101,7 @@ struct deadline_data {
 	u32 async_depth;
 	int prio_aging_expire;
 
-	spinlock_t lock;
+	spinlock_t *lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	const u8 ioprio_class = dd_rq_ioclass(next);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	dd->per_prio[prio].stats.merged++;
 
@@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
 {
 	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	return stats->inserted - atomic_read(&stats->completed);
 }
@@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	enum dd_prio prio;
 	u8 ioprio_class;
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	if (!list_empty(&per_prio->dispatch)) {
 		rq = list_first_entry(&per_prio->dispatch, struct request,
@@ -434,7 +434,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	enum dd_prio prio;
 	int prio_cnt;
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
 		   !!dd_queued(dd, DD_IDLE_PRIO);
@@ -466,7 +466,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
-	spin_lock(&dd->lock);
+	spin_lock(dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
 		goto unlock;
@@ -482,8 +482,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
-	spin_unlock(&dd->lock);
-
+	spin_unlock(dd->lock);
 	return rq;
 }
 
@@ -552,9 +551,9 @@ static void dd_exit_sched(struct elevator_queue *e)
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
 		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
 
-		spin_lock(&dd->lock);
+		spin_lock(dd->lock);
 		queued = dd_queued(dd, prio);
-		spin_unlock(&dd->lock);
+		spin_unlock(dd->lock);
 
 		WARN_ONCE(queued != 0,
 			  "statistics for priority %d: i %u m %u d %u c %u\n",
@@ -601,7 +600,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
-	spin_lock_init(&dd->lock);
+	dd->lock = &eq->lock;
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
@@ -657,9 +656,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 	struct request *free = NULL;
 	bool ret;
 
-	spin_lock(&dd->lock);
+	spin_lock(dd->lock);
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
-	spin_unlock(&dd->lock);
+	spin_unlock(dd->lock);
 
 	if (free)
 		blk_mq_free_request(free);
@@ -681,7 +680,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
@@ -725,7 +724,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	LIST_HEAD(free);
 
-	spin_lock(&dd->lock);
+	spin_lock(dd->lock);
 	while (!list_empty(list)) {
 		struct request *rq;
 
@@ -733,7 +732,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 		list_del_init(&rq->queuelist);
 		dd_insert_request(hctx, rq, flags, &free);
 	}
-	spin_unlock(&dd->lock);
+	spin_unlock(dd->lock);
 
 	blk_mq_free_requests(&free);
 }
@@ -849,13 +848,13 @@ static const struct elv_fs_entry deadline_attrs[] = {
 #define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
 static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 					  loff_t *pos)			\
-	__acquires(&dd->lock)						\
+	__acquires(dd->lock)						\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
 									\
-	spin_lock(&dd->lock);						\
+	spin_lock(dd->lock);						\
 	return seq_list_start(&per_prio->fifo_list[data_dir], *pos);	\
 }									\
 									\
@@ -870,12 +869,12 @@ static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
 }									\
 									\
 static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(dd->lock)						\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
-	spin_unlock(&dd->lock);						\
+	spin_unlock(dd->lock);						\
 }									\
 									\
 static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
@@ -941,11 +940,11 @@ static int dd_queued_show(void *data, struct seq_file *m)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	u32 rt, be, idle;
 
-	spin_lock(&dd->lock);
+	spin_lock(dd->lock);
 	rt = dd_queued(dd, DD_RT_PRIO);
 	be = dd_queued(dd, DD_BE_PRIO);
 	idle = dd_queued(dd, DD_IDLE_PRIO);
-	spin_unlock(&dd->lock);
+	spin_unlock(dd->lock);
 
 	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
@@ -957,7 +956,7 @@ static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
 {
 	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
 
-	lockdep_assert_held(&dd->lock);
+	lockdep_assert_held(dd->lock);
 
 	return stats->dispatched + stats->merged -
 		atomic_read(&stats->completed);
@@ -969,11 +968,11 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 	struct deadline_data *dd = q->elevator->elevator_data;
 	u32 rt, be, idle;
 
-	spin_lock(&dd->lock);
+	spin_lock(dd->lock);
 	rt = dd_owned_by_driver(dd, DD_RT_PRIO);
 	be = dd_owned_by_driver(dd, DD_BE_PRIO);
 	idle = dd_owned_by_driver(dd, DD_IDLE_PRIO);
-	spin_unlock(&dd->lock);
+	spin_unlock(dd->lock);
 
 	seq_printf(m, "%u %u %u\n", rt, be, idle);
 
@@ -983,13 +982,13 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 #define DEADLINE_DISPATCH_ATTR(prio)					\
 static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
 					     loff_t *pos)		\
-	__acquires(&dd->lock)						\
+	__acquires(dd->lock)						\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
 									\
-	spin_lock(&dd->lock);						\
+	spin_lock(dd->lock);						\
 	return seq_list_start(&per_prio->dispatch, *pos);		\
 }									\
 									\
@@ -1004,12 +1003,12 @@ static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
 }									\
 									\
 static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(dd->lock)						\
 {									\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
-	spin_unlock(&dd->lock);						\
+	spin_unlock(dd->lock);						\
 }									\
 									\
 static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
-- 
2.39.2


