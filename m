Return-Path: <cgroups+bounces-8991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD37B1C2C7
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC4F17C4F9
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D9289E2E;
	Wed,  6 Aug 2025 09:04:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C322332E;
	Wed,  6 Aug 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471083; cv=none; b=TzYHnBerNxepPz1q5EbQztGF+VP7Jv4dZF72n80SEGfmtBqOAzcYPL1fsgr+5LoBeHJ0gVy88igkbK51FAMrRXJCFyKA/Ke/E/3BsRoRZY2Imt7ttLCIvGDuAElDzP1qBDaDwUlfneTDIOlC5ppzcvTha/ONCYAm60EIYmxzM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471083; c=relaxed/simple;
	bh=Ow/g6HtgbGvFK7p76Kz9UgvkhFULgvFmmI6Z+HBw5nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tg9dnG08Fp9VpL/MeTfV90uHcsNqrTif3XczHvsAxCd17BzZB5nDEvOv4ngb5dSdBuITNmJmClt2ttEcjRSiQmLcZp2A0ymZc0J7YGapW+elGakWz7sP5aHCzJyzxLYupaK9zOYWjPPnW9BlbqQu1RcORj737OIdLH7wMByTAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxkrR505xzKHMyS;
	Wed,  6 Aug 2025 17:04:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCF2F1A07C0;
	Wed,  6 Aug 2025 17:04:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxOjGpNowBAGCw--.58870S5;
	Wed, 06 Aug 2025 17:04:38 +0800 (CST)
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
Subject: [PATCH v3 1/5] blk-mq-sched: introduce high level elevator lock
Date: Wed,  6 Aug 2025 16:57:16 +0800
Message-Id: <20250806085720.4040507-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3sxOjGpNowBAGCw--.58870S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fGr1kCr1kGrg_yoW5Zw13pF
	4rGa9Ikr4kXF42vFn7A3W3Xw17G3yv9rnxurW0vw43tFn7Gr4fW3W8GF45ZFWUZr4xGFsr
	Wr1ktaykuay7K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Currently, both mq-deadline and bfq have global spin lock that will be
grabbed inside elevator methods like dispatch_request, insert_requests,
and bio_merge. And the global lock is the main reason mq-deadline and
bfq can't scale very well.

While dispatching request, blk_mq_get_disatpch_budget() and
blk_mq_get_driver_tag() must be called, and they are not ready to be called
inside elevator methods, hence introduce a new method like
dispatch_requests is not possible.

Hence introduce a new high level elevator lock, currently it is protecting
dispatch_request only. Following patches will convert mq-deadline and bfq
to use this lock and finally support request batch dispatching by calling
the method multiple time while holding the lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c |  9 ++++++++-
 block/elevator.c     |  1 +
 block/elevator.h     | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..1a2da5edbe13 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (budget_token < 0)
 			break;
 
-		rq = e->type->ops.dispatch_request(hctx);
+		if (blk_queue_sq_sched(q)) {
+			elevator_lock(e);
+			rq = e->type->ops.dispatch_request(hctx);
+			elevator_unlock(e);
+		} else {
+			rq = e->type->ops.dispatch_request(hctx);
+		}
+
 		if (!rq) {
 			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
diff --git a/block/elevator.c b/block/elevator.c
index 88f8f36bed98..45303af0ca73 100644
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
index a07ce773a38f..81f7700b0339 100644
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
@@ -124,6 +124,16 @@ struct elevator_queue
 #define ELEVATOR_FLAG_DYING		1
 #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
 
+#define elevator_lock(e)		spin_lock(&(e)->lock)
+#define elevator_unlock(e)		spin_unlock(&(e)->lock)
+#define elevator_lock_irq(e)		spin_lock_irq(&(e)->lock)
+#define elevator_unlock_irq(e)		spin_unlock_irq(&(e)->lock)
+#define elevator_lock_irqsave(e, flags) \
+	spin_lock_irqsave(&(e)->lock, flags)
+#define elevator_unlock_irqrestore(e, flags) \
+	spin_unlock_irqrestore(&(e)->lock, flags)
+#define elevator_lock_assert_held(e)	lockdep_assert_held(&(e)->lock)
+
 /*
  * block elevator interface
  */
-- 
2.39.2


