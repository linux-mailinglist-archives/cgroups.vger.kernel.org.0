Return-Path: <cgroups+bounces-3612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C392E2FB
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F32C280FB4
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A2156641;
	Thu, 11 Jul 2024 09:03:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EE14F9E4;
	Thu, 11 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688602; cv=none; b=PrufNmmCweEECoPqmpdSgjkm+WPpwQYtOp7fFBjx76N5H7R5/WbY5Raz/Wy4YNVLKHAYc03xsZS4bqfvmNR8oWAVm8jDcuTLVlPwU03nlDe5QuAH+bLMFATZ0aM1tHu+XJ68pIcPIcSMiHbkEtNAHVfjiGNbooXZPpEL1umLB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688602; c=relaxed/simple;
	bh=h+bFswsSxVaFt1iKIu4yyXHcgUnXCYAcJSNUl/rr1OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTqaVSKjl4j+6x2NkGFjhhi+ZZ8H8ldDo0iESNFY36AwwBdPLO6yjUYbY0YEBUu3vfH5/GFG7QMK57dhswzZkQJ8aUsPYDHtNW9Gtbj1RgpK/wGNIoqDncT2wQvWT1jZNL2a1gclBzxyNItXj4VRSp1L/klTTQdyL9HABSCENGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKTJy1xLsz4f3l1d;
	Thu, 11 Jul 2024 17:02:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2E1171A0170;
	Thu, 11 Jul 2024 17:03:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgB34YbMn49msI0qBw--.62219S6;
	Thu, 11 Jul 2024 17:03:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	bvanassche@acm.org,
	jack@suse.cz,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/2] blk-ioprio: remove per-disk structure
Date: Thu, 11 Jul 2024 17:00:59 +0800
Message-Id: <20240711090059.3998565-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YbMn49msI0qBw--.62219S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kGw15JFW5tw1Uuw48JFb_yoWrWw4xpF
	43GrsIkFZYgF1IgF4DGa18Ar1Syw4UK348JayrGw4Fyr17Ary0g3WUCrs3AFWrAFW7CFW3
	Ar1FqrWUCF48ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

ioprio works on the blk-cgroup level, all disks in the same cgroup
are the same, and the struct ioprio_blkg doesn't have anything in it.
Hence register the policy is enough, because cpd_alloc/free_fn will
be handled for each blk-cgroup, and there is no need to activate the
policy for disk.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c |  8 --------
 block/blk-ioprio.c | 45 ---------------------------------------------
 block/blk-ioprio.h |  9 ---------
 3 files changed, 62 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..c7d00d95d499 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1458,7 +1458,6 @@ int blkcg_init_disk(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *new_blkg, *blkg;
 	bool preloaded;
-	int ret;
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1478,15 +1477,8 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_ioprio_init(disk);
-	if (ret)
-		goto err_destroy_all;
-
 	return 0;
 
-err_destroy_all:
-	blkg_destroy_all(disk);
-	return ret;
 err_unlock:
 	spin_unlock_irq(&q->queue_lock);
 	if (preloaded)
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index ae52b418e984..8fff7ccc0ac7 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -49,14 +49,6 @@ static const char *policy_name[] = {
 
 static struct blkcg_policy ioprio_policy;
 
-/**
- * struct ioprio_blkg - Per (cgroup, request queue) data.
- * @pd: blkg_policy_data structure.
- */
-struct ioprio_blkg {
-	struct blkg_policy_data pd;
-};
-
 /**
  * struct ioprio_blkcg - Per cgroup data.
  * @cpd: blkcg_policy_data structure.
@@ -67,11 +59,6 @@ struct ioprio_blkcg {
 	enum prio_policy	 prio_policy;
 };
 
-static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
-{
-	return pd ? container_of(pd, struct ioprio_blkg, pd) : NULL;
-}
-
 static struct ioprio_blkcg *blkcg_to_ioprio_blkcg(struct blkcg *blkcg)
 {
 	return container_of(blkcg_to_cpd(blkcg, &ioprio_policy),
@@ -108,25 +95,6 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
-static struct blkg_policy_data *
-ioprio_alloc_pd(struct gendisk *disk, struct blkcg *blkcg, gfp_t gfp)
-{
-	struct ioprio_blkg *ioprio_blkg;
-
-	ioprio_blkg = kzalloc(sizeof(*ioprio_blkg), gfp);
-	if (!ioprio_blkg)
-		return NULL;
-
-	return &ioprio_blkg->pd;
-}
-
-static void ioprio_free_pd(struct blkg_policy_data *pd)
-{
-	struct ioprio_blkg *ioprio_blkg = pd_to_ioprio(pd);
-
-	kfree(ioprio_blkg);
-}
-
 static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)
 {
 	struct ioprio_blkcg *blkcg;
@@ -169,9 +137,6 @@ static struct blkcg_policy ioprio_policy = {
 
 	.cpd_alloc_fn	= ioprio_alloc_cpd,
 	.cpd_free_fn	= ioprio_free_cpd,
-
-	.pd_alloc_fn	= ioprio_alloc_pd,
-	.pd_free_fn	= ioprio_free_pd,
 };
 
 void blkcg_set_ioprio(struct bio *bio)
@@ -209,16 +174,6 @@ void blkcg_set_ioprio(struct bio *bio)
 		bio->bi_ioprio = prio;
 }
 
-void blk_ioprio_exit(struct gendisk *disk)
-{
-	blkcg_deactivate_policy(disk, &ioprio_policy);
-}
-
-int blk_ioprio_init(struct gendisk *disk)
-{
-	return blkcg_activate_policy(disk, &ioprio_policy);
-}
-
 static int __init ioprio_init(void)
 {
 	return blkcg_policy_register(&ioprio_policy);
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
index b6afb8e80de0..9265143f9bc9 100644
--- a/block/blk-ioprio.h
+++ b/block/blk-ioprio.h
@@ -9,17 +9,8 @@ struct request_queue;
 struct bio;
 
 #ifdef CONFIG_BLK_CGROUP_IOPRIO
-int blk_ioprio_init(struct gendisk *disk);
-void blk_ioprio_exit(struct gendisk *disk);
 void blkcg_set_ioprio(struct bio *bio);
 #else
-static inline int blk_ioprio_init(struct gendisk *disk)
-{
-	return 0;
-}
-static inline void blk_ioprio_exit(struct gendisk *disk)
-{
-}
 static inline void blkcg_set_ioprio(struct bio *bio)
 {
 }
-- 
2.39.2


