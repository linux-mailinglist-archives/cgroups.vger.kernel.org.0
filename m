Return-Path: <cgroups+bounces-8821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA6B0D334
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B0F3A6FD0
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BEC2BE624;
	Tue, 22 Jul 2025 07:31:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703592206BE;
	Tue, 22 Jul 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169459; cv=none; b=jH3DLEqixprZCIzu++YQJ6xpn8j2f9pZcGmTqVTHYdz+1wXX8mepYpPc7gyp48oeLSfbVTi2MMzBjhz25DCRL36Z31QG8a9no+fmXQxV/YZF4TlRxBdtCRgRgjypDth3tFoS8Usr/aMHVghpxls0Q2smy91RhsxmVLHixe19544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169459; c=relaxed/simple;
	bh=/RaYqj3j98hCwzssoKdXSriKns4zIZSdelvog1GUyOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jo1rGsXbHOyYfT6z1a/Z/sXQXWUPfZ93UG4QKRxWWbz1Yvj5tKUhxP/dANdByDL8F6X7Fm0L3nWwG7kynGsJHb/lu01VWvoksnENIbwURntQuG7aYyU5OuXaOLub+6JfSAtdOUA/P6MntYCtvGmXs0ljIproNc+1KrwFxDAr5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bmTTD0FRXzYQvJY;
	Tue, 22 Jul 2025 15:30:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC95C1A1949;
	Tue, 22 Jul 2025 15:30:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMrPn9ovjJdBA--.52549S6;
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
Subject: [PATCH 2/6] block, bfq: don't grab queue_lock from io path
Date: Tue, 22 Jul 2025 15:24:27 +0800
Message-Id: <20250722072431.610354-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnYhMrPn9ovjJdBA--.52549S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1rArWrKw43JrWxJFW7CFg_yoW7JryDpF
	WaqanIyr10gr47uryfJ3ZrZrn3W3W8ursrta93tw4Fkr92yrnav3Wjyry2vF1S9rWkAFsF
	vr4UK3ykAr48uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently issue io can grab queue_lock three times from bfq_bio_merge(),
bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
necessary if icq is already created:

- queue_usage_counter is already grabbed and queue won't exist;
- current thread won't exist;
- if other thread is allocating and inserting new icq to ioc->icq_tree,
  rcu can be used to protect lookup icq from the raidx tree, it's safe
  to use extracted icq until queue or current thread exit;

If ioc or icq is not created, then bfq_prepare_request() will create it,
which means the task is issuing io to queue the first time, this can
consider a slow path and queue_lock will still be held to protect
inserting allocated icq to ioc->icq_tree.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 24 +++++++-----------------
 block/blk-ioc.c     | 43 ++++++++++++++++++++++++++++++++++++++-----
 block/blk.h         |  2 +-
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..58d57c482acd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -454,17 +454,13 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
  */
 static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 {
-	struct bfq_io_cq *icq;
-	unsigned long flags;
-
-	if (!current->io_context)
-		return NULL;
+	struct io_cq *icq;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	icq = icq_to_bic(ioc_lookup_icq(q));
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	rcu_read_lock();
+	icq = ioc_lookup_icq_rcu(q);
+	rcu_read_unlock();
 
-	return icq;
+	return icq_to_bic(icq);
 }
 
 /*
@@ -2456,16 +2452,10 @@ static void bfq_remove_request(struct request_queue *q,
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
+	/* bic will not be freed until current or elevator exit */
+	struct bfq_io_cq *bic = bfq_bic_lookup(q);
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *free = NULL;
-	/*
-	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
-	 * store its return value for later use, to avoid nesting
-	 * queue_lock inside the bfqd->lock. We assume that the bic
-	 * returned by bfq_bic_lookup does not go away before
-	 * bfqd->lock is taken.
-	 */
-	struct bfq_io_cq *bic = bfq_bic_lookup(q);
 	bool ret;
 
 	spin_lock_irq(&bfqd->lock);
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index ce82770c72ab..0be097a37e22 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -314,7 +314,7 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
  * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
  * with @q->queue_lock held.
  */
-struct io_cq *ioc_lookup_icq(struct request_queue *q)
+static struct io_cq *ioc_lookup_icq(struct request_queue *q)
 {
 	struct io_context *ioc = current->io_context;
 	struct io_cq *icq;
@@ -341,7 +341,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
 	rcu_read_unlock();
 	return icq;
 }
-EXPORT_SYMBOL(ioc_lookup_icq);
+
+/**
+ * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
+ * @q: the associated request_queue
+ *
+ * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
+ * from io path, either return NULL if current issue io to @q for the first
+ * time, or return a valid icq.
+ */
+struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
+{
+	struct io_context *ioc = current->io_context;
+	struct io_cq *icq;
+
+	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
+
+	if (!ioc)
+		return NULL;
+
+	icq = rcu_dereference(ioc->icq_hint);
+	if (icq && icq->q == q)
+		return icq;
+
+	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
+	if (!icq)
+		return NULL;
+
+	if (WARN_ON_ONCE(icq->q != q))
+		return NULL;
+
+	rcu_assign_pointer(ioc->icq_hint, icq);
+	return icq;
+}
+EXPORT_SYMBOL(ioc_lookup_icq_rcu);
 
 /**
  * ioc_create_icq - create and link io_cq
@@ -420,9 +453,9 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 	} else {
 		get_io_context(ioc);
 
-		spin_lock_irq(&q->queue_lock);
-		icq = ioc_lookup_icq(q);
-		spin_unlock_irq(&q->queue_lock);
+		rcu_read_lock();
+		icq = ioc_lookup_icq_rcu(q);
+		rcu_read_unlock();
 	}
 
 	if (!icq) {
diff --git a/block/blk.h b/block/blk.h
index 468aa83c5a22..3c078e517d59 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -460,7 +460,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  * Internal io_context interface
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
-struct io_cq *ioc_lookup_icq(struct request_queue *q);
+struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
 #ifdef CONFIG_BLK_ICQ
 void ioc_clear_queue(struct request_queue *q);
 #else
-- 
2.39.2


