Return-Path: <cgroups+bounces-9782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337EB48873
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477BD1B23F8A
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E22F3617;
	Mon,  8 Sep 2025 09:29:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71C2EB5BF;
	Mon,  8 Sep 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323771; cv=none; b=IfseIv4Je2DWNc0qfqGZpB9UYeLFpcranyhgdbYIvX9YgWFvROSSk4dLpYwMYc0gsVFOSk3jYMT8VgztVQAh+Hy98/ePxoAj+TNtOHZ3agakWcd4JoihWVcH9aha9lOft8sy0KVtG0p4wuLQLndiifCwoAiimoM3KXGW10SG/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323771; c=relaxed/simple;
	bh=zcUoMdH7hBNz7MSsR7/dhT0RSHn4wSbUyGgnmqAeiNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7ZbRV6nEpZ/8ZKI4X6r2cbt2bi2sbFjuNyul212MmR8qalVlnYrJCHEmDJAyHj62qgH6hVB4CzlNMdCsQ8/izjw5tfLfMj3XMFM0B5YFhQ4xdChwEnb1WR8TCpxU8W3efgaHlq5lhxrwMvlPTG0i7pe+le3igAu6lSEXuGcxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cL1qp4pNVzKHN7F;
	Mon,  8 Sep 2025 17:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE88F1A0E98;
	Mon,  8 Sep 2025 17:29:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzzob5oGjMyBw--.46699S5;
	Mon, 08 Sep 2025 17:29:26 +0800 (CST)
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
Subject: [PATCH v4 for-6.18/block 1/5] blk-mq-sched: introduce high level elevator lock
Date: Mon,  8 Sep 2025 17:20:03 +0800
Message-Id: <20250908092007.3796967-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXYIzzob5oGjMyBw--.46699S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fGr1kCr1kGrg_yoWrGF45pF
	4rGa98Kw1kXF42gF97A3W3Xw43K34v9r9xZrWxZ3y7tFn7Jr4fW3W8GF1UZF4UZr4fGFsF
	qr18taykWay7G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfU8XdbUUUUU
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
 block/elevator.h     | 31 +++++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d06bb137a743..6f2b0573a8ff 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (budget_token < 0)
 			break;
 
-		rq = e->type->ops.dispatch_request(hctx);
+		if (blk_queue_sq_sched(q)) {
+			elevator_dispatch_lock(e);
+			rq = e->type->ops.dispatch_request(hctx);
+			elevator_dispatch_unlock(e);
+		} else {
+			rq = e->type->ops.dispatch_request(hctx);
+		}
+
 		if (!rq) {
 			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
diff --git a/block/elevator.c b/block/elevator.c
index e2ebfbf107b3..e132a24f9ce3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -146,6 +146,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	eq->type = e;
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
+	spin_lock_init(&eq->lock);
 	hash_init(eq->hash);
 	eq->et = et;
 
diff --git a/block/elevator.h b/block/elevator.h
index c4d20155065e..4864add27136 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -119,13 +119,13 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
 /*
  * each queue has an elevator_queue associated with it
  */
-struct elevator_queue
-{
+struct elevator_queue {
 	struct elevator_type *type;
 	struct elevator_tags *et;
 	void *elevator_data;
 	struct kobject kobj;
 	struct mutex sysfs_lock;
+	spinlock_t lock;
 	unsigned long flags;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
@@ -133,6 +133,33 @@ struct elevator_queue
 #define ELEVATOR_FLAG_REGISTERED	0
 #define ELEVATOR_FLAG_DYING		1
 #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
+#define ELEVATOR_FLAG_DISPATCH_IRQ	3
+
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
+static inline void elevator_dispatch_lock(struct elevator_queue *eq)
+{
+	if (test_bit(ELEVATOR_FLAG_DISPATCH_IRQ, &eq->flags))
+		elevator_lock_irq(eq);
+	else
+		elevator_lock(eq);
+}
+
+static inline void elevator_dispatch_unlock(struct elevator_queue *eq)
+{
+	if (test_bit(ELEVATOR_FLAG_DISPATCH_IRQ, &eq->flags))
+		elevator_unlock_irq(eq);
+	else
+		elevator_unlock(eq);
+}
 
 /*
  * block elevator interface
-- 
2.39.2


