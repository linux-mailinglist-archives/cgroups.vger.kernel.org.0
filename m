Return-Path: <cgroups+bounces-8927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EDB15AA3
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895B718853D1
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63A292B55;
	Wed, 30 Jul 2025 08:29:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F59292B45;
	Wed, 30 Jul 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864145; cv=none; b=JcZuD14b8AZGDUu4IAg/cKJZWu+D3DM+6efDyzykUX8NgSDyNp/mYidNZAi/Gdno/+Hm7mUnlMLeuYzHZOsWAhKCwmBxCyLbNKsKcn6ecBrEzxi5+uyXj/qdfbM+z7VRn4gqHl9vZOLFMAmLgTPeJpWvpl5uPrQIlJx0PsDf+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864145; c=relaxed/simple;
	bh=R9mFR35pKpTZrPbmRbP2nm/mOvzrvfpl0dmwwuPTIe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/m/8ZxX1Sa9jQOkUXbWzRKaCpQK4kwba6NHV5heSZWvNEWd+dxGOoirGE5iqqXmEU9YrnTM53gyuN2MIOLEEZggydjPx6oeWYLFPfjrI0ZPoWyQbpS4xlR/sb31bLPAdS4Kj0vdV1cQqMqTe0tEFBpYKyQRmyxJ3Fsnln0UZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bsQNX5fWGzKHMyR;
	Wed, 30 Jul 2025 16:29:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A94C11A111D;
	Wed, 30 Jul 2025 16:28:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxPI14lokcLlBw--.17899S5;
	Wed, 30 Jul 2025 16:28:59 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: dlemoal@kernel.org,
	hare@suse.de,
	jack@suse.cz,
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
Subject: [PATCH v2 1/5] blk-mq-sched: introduce high level elevator lock
Date: Wed, 30 Jul 2025 16:22:03 +0800
Message-Id: <20250730082207.4031744-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxPI14lokcLlBw--.17899S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fGr1kCr1kGrg_yoW5Xr1DpF
	4rJanIkFs0qF10vF97Aa13Xw13J3929r9xW398A3yayFn7GrZ3XF1kGF1UZFWIyF4fCFsr
	Wr1ktaykZa42g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 block/blk-mq-sched.c | 6 ++++++
 block/elevator.c     | 1 +
 block/elevator.h     | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..7911fae75ce4 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -98,6 +98,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		max_dispatch = hctx->queue->nr_requests;
 
 	do {
+		bool sq_sched = blk_queue_sq_sched(q);
 		struct request *rq;
 		int budget_token;
 
@@ -113,7 +114,12 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (budget_token < 0)
 			break;
 
+		if (sq_sched)
+			spin_lock(&e->lock);
 		rq = e->type->ops.dispatch_request(hctx);
+		if (sq_sched)
+			spin_unlock(&e->lock);
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
-- 
2.39.2


