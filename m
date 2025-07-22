Return-Path: <cgroups+bounces-8825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF5B0D341
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83F87B4120
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB082E4988;
	Tue, 22 Jul 2025 07:31:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789622D7BF;
	Tue, 22 Jul 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169462; cv=none; b=iyiTJXB59QNp4nCt6uLY5Fv3HRihcmuEYPMBBfSeDPwQA5bzRtTj9Ty0vWUJke6DZgLBL9lFPFJ2zFgwuY8HjNTiH02BV+CJheiNllhc/adnGCvpBkkZjFM2Ck102IggOujlwcAkjI6PxCffoKbrITjB3oYgg8QC4HyG7/1A79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169462; c=relaxed/simple;
	bh=LgchtcgwWjC3WfIVegH0QDuQkTDQpcVk8Z4MT76AGA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fi4eabvLC60Z/dKdaCxqZZB6jJ90gYv1SgHyNZtOKlqf/Tznx3J/V4WhgAZ7LwOzAIGeYZR7o/w+vBbrLVc9fj2Ju0F+2yLLdXyiA1XLsbQ1umi6OL0+tLy2kjFFhfTlaOToUYaLuu/qjv/d9eMbMtjzSNsbrJKpU3e5qy/3sM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bmTTF115CzYQvJp;
	Tue, 22 Jul 2025 15:30:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D2CC41A1578;
	Tue, 22 Jul 2025 15:30:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhMrPn9ovjJdBA--.52549S8;
	Tue, 22 Jul 2025 15:30:55 +0800 (CST)
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
Subject: [PATCH 4/6] elevator: factor elevator lock out of dispatch_request method
Date: Tue, 22 Jul 2025 15:24:29 +0800
Message-Id: <20250722072431.610354-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnYhMrPn9ovjJdBA--.52549S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fGr4rKw48Zwb_yoW5tF45pF
	47Ka1ayF48XF1jqF97uanxJw17KwsrZ3srGr9rGr4ftFnrJrs3GFn5Ka4UZFWfZrs3CFsF
	gr1qq3s5Zw1Ig37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, both mq-deadline and bfq have global spin lock that will be
grabbed inside elevator methods like dispatch_request, insert_requests,
and bio_merge. And the global lock is the main reason mq-deadline and
bfq can't scale very well.

For dispatch_request method, current behavior is dispatching one request at
a time. In the case of multiple dispatching contexts, this behavior will
cause huge lock contention and messing up the requests dispatching
order. And folloiwng patches will support requests batch dispatching to
fix thoses problems.

While dispatching request, blk_mq_get_disatpch_budget() and
blk_mq_get_driver_tag() must be called, and they are not ready to be
called inside elevator methods, hence introduce a new method like
dispatch_requests is not possible.

In conclusion, this patch factor the global lock out of dispatch_request
method, and following patches will support request batch dispatch by
calling the methods multiple time while holding the lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c  | 3 ---
 block/blk-mq-sched.c | 6 ++++++
 block/mq-deadline.c  | 5 +----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 11b81b11242c..9f8a256e43f2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5307,8 +5307,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled = false;
 
-	spin_lock_irq(bfqd->lock);
-
 	in_serv_queue = bfqd->in_service_queue;
 	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
@@ -5318,7 +5316,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
 	}
 
-	spin_unlock_irq(bfqd->lock);
 	bfq_update_dispatch_stats(hctx->queue, rq,
 			idle_timer_disabled ? in_serv_queue : NULL,
 				idle_timer_disabled);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55a0fd105147..82c4f4eef9ed 100644
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
+			spin_lock_irq(&e->lock);
 		rq = e->type->ops.dispatch_request(hctx);
+		if (sq_sched)
+			spin_unlock_irq(&e->lock);
+
 		if (!rq) {
 			blk_mq_put_dispatch_budget(q, budget_token);
 			/*
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index e31da6de7764..a008e41bc861 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
-	spin_lock(dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
-		goto unlock;
+		return rq;
 
 	/*
 	 * Next, dispatch requests in priority order. Ignore lower priority
@@ -481,8 +480,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			break;
 	}
 
-unlock:
-	spin_unlock(dd->lock);
 	return rq;
 }
 
-- 
2.39.2


