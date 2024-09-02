Return-Path: <cgroups+bounces-4672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7996886E
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CA31F22317
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A95205E16;
	Mon,  2 Sep 2024 13:05:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CF20FA8B;
	Mon,  2 Sep 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282304; cv=none; b=Xu5ZKgjC76QfUcWxpa5DLxHIvCYlybdKIs3lLY6+QpeI0ZEuxNLrSQqcOHeFJuSx+H9QBQxsky24tFUvrbHXj9vuRDl84P/eTj+HqMtPvHsP2/rGseH024oYvGGYE6teivflLGfa1egkWqR+JSoGBpWM1jInPO1jlGbaVtUKkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282304; c=relaxed/simple;
	bh=ZAypMsXgtUK/eCBt8/+FW02SBEJ1WO0KZLcjZtuROzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0flRoRJgBB0DQdMx8kvzSpWItNKxHiPkersWAHM88CMxlsRO+GWEV+ir9OvOCZG9zlozP+Z8jOOBgycwdnNy3YeOvI3+ppqcowVAd12/tIl08QzbbfMEFEqc/+g5n2BfUijz6d7Fo0uufAN8+BqICkKI5wQSpt1uSXQb5vM6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy89Y5B7Yz4f3jqx;
	Mon,  2 Sep 2024 21:04:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E3CCB1A0568;
	Mon,  2 Sep 2024 21:04:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8f1t9Vm9+rAAA--.25569S8;
	Mon, 02 Sep 2024 21:04:59 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	paolo.valente@unimore.it,
	mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.12 4/4] block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
Date: Mon,  2 Sep 2024 21:03:29 +0800
Message-Id: <20240902130329.3787024-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8f1t9Vm9+rAAA--.25569S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fGF15Jw17WF45XryxXwb_yoW8trW3pa
	nIgw47XF4UGr4rZr4UJ3WDXrn3WFn5u3srtrnYv340yw17Ar1aqFsIy34xXrWIqrZ3Arsx
	Z34Yg3s7Zr17KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

Instead of open coding it, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 7 +------
 block/bfq-iosched.c | 4 ++--
 block/bfq-iosched.h | 2 ++
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b758693697c0..9fb9f3533150 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -679,12 +679,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
 	bfqg_and_blkg_put(old_parent);
 
-	if (entity->parent &&
-	    entity->parent->last_bfqq_created == bfqq)
-		entity->parent->last_bfqq_created = NULL;
-	else if (bfqd->last_bfqq_created == bfqq)
-		bfqd->last_bfqq_created = NULL;
-
+	bfq_reassign_last_bfqq(bfqq, NULL);
 	entity->parent = bfqg->my_entity;
 	entity->sched_data = &bfqg->sched_data;
 	/* pin down bfqg and its associated blkg  */
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ca766b7d5560..d1bf2b8a3576 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3097,8 +3097,8 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 }
 
 
-static void
-bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq, struct bfq_queue *new_bfqq)
+void bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq,
+			    struct bfq_queue *new_bfqq)
 {
 	if (cur_bfqq->entity.parent &&
 	    cur_bfqq->entity.parent->last_bfqq_created == cur_bfqq)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 08ddf2cfae5b..e16d96e2367b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1156,6 +1156,8 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
 void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
 void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
+void bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq,
+			    struct bfq_queue *new_bfqq);
 
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
-- 
2.39.2


