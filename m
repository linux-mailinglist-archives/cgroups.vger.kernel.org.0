Return-Path: <cgroups+bounces-10445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24BB9E0C6
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DB43BDF99
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59EC2EB5B5;
	Thu, 25 Sep 2025 08:25:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3042EA16C;
	Thu, 25 Sep 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788757; cv=none; b=akwQu2/spJEP1k8YlSsKoRfyVMeJr6JoJqH2NODyhqWauPQFpskB2RZiF4lgnGAcS/gr3kWCRVagUOwrfMCSUepkOEtFV0u1Ius+uAsigXB1zOMlmxJS71YkNsooOkl9NZ9oNcVoq7Crfg+azUfp0iG7JvLKn1bRoc7fgF+kPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788757; c=relaxed/simple;
	bh=g+bf3aGO8uMvccb+KQ+RvINxPur2xnZjSPeHOD6R+zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+Lv/Vpg8SLyp1HaUZMrrYmIsXQDjDnZfcoaSKpSkzp/3bp8nSJmex57gnG+LyeslT8MPi2dS2PxnQsAB0ZRFf0IxQp9/0QIIuUjGhYNG/zQgf1XL8uX1sBSaEVYV2z7CjmyB3AydtGyepe7uuuCEs81CLRf62UrQYW8ytTPwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXRcS1skszKHN79;
	Thu, 25 Sep 2025 16:25:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1C6981A0CF4;
	Thu, 25 Sep 2025 16:25:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCna2OH_NRodTcIAw--.12615S13;
	Thu, 25 Sep 2025 16:25:51 +0800 (CST)
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
Subject: [PATCH 09/10] blk-cgroup: remove preallocate blkg for blkg_create()
Date: Thu, 25 Sep 2025 16:15:24 +0800
Message-Id: <20250925081525.700639-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCna2OH_NRodTcIAw--.12615S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48KF4xCFW8Ww48Jr1kXwb_yoW7Jry7pF
	43trsIy3y8Krnruas8Xr17Z34Sqw10q34rGFZ7Ga4rKF42vr1SqF1j9rWkCFWxAFWDWr13
	Xr4UtF1jkr4xCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that blkg_create is protected with blkcg_mutex, there is no need to
preallocate blkg, remove related code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 91 +++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 58 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bfc74cfebd3e..60b8c742f876 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -364,10 +364,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
  * If @new_blkg is %NULL, this function tries to allocate a new one as
  * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
  */
-static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
-				    struct blkcg_gq *new_blkg)
+static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk)
 {
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = NULL;
 	int i, ret;
 
 	lockdep_assert_held(&disk->queue->blkcg_mutex);
@@ -384,15 +383,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		goto err_free_blkg;
 	}
 
-	/* allocate */
-	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
-		if (unlikely(!new_blkg)) {
-			ret = -ENOMEM;
-			goto err_put_css;
-		}
+	blkg = blkg_alloc(blkcg, disk, GFP_NOIO);
+	if (unlikely(!blkg)) {
+		ret = -ENOMEM;
+		goto err_put_css;
 	}
-	blkg = new_blkg;
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
@@ -415,35 +410,34 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 	/* insert */
 	spin_lock(&blkcg->lock);
 	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
-	if (likely(!ret)) {
-		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
-		list_add(&blkg->q_node, &disk->queue->blkg_list);
+	if (unlikely(ret)) {
+		spin_unlock(&blkcg->lock);
+		blkg_put(blkg);
+		return ERR_PTR(ret);
+	}
 
-		for (i = 0; i < BLKCG_MAX_POLS; i++) {
-			struct blkcg_policy *pol = blkcg_policy[i];
+	hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
+	list_add(&blkg->q_node, &disk->queue->blkg_list);
 
-			if (blkg->pd[i]) {
-				if (pol->pd_online_fn)
-					pol->pd_online_fn(blkg->pd[i]);
-				blkg->pd[i]->online = true;
-			}
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (blkg->pd[i]) {
+			if (pol->pd_online_fn)
+				pol->pd_online_fn(blkg->pd[i]);
+			blkg->pd[i]->online = true;
 		}
 	}
+
 	blkg->online = true;
 	spin_unlock(&blkcg->lock);
-
-	if (!ret)
-		return blkg;
-
-	/* @blkg failed fully initialized, use the usual release path */
-	blkg_put(blkg);
-	return ERR_PTR(ret);
+	return blkg;
 
 err_put_css:
 	css_put(&blkcg->css);
 err_free_blkg:
-	if (new_blkg)
-		blkg_free(new_blkg);
+	if (blkg)
+		blkg_free(blkg);
 	return ERR_PTR(ret);
 }
 
@@ -498,7 +492,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 			parent = blkcg_parent(parent);
 		}
 
-		blkg = blkg_create(pos, disk, NULL);
+		blkg = blkg_create(pos, disk);
 		if (IS_ERR(blkg)) {
 			blkg = ret_blkg;
 			break;
@@ -879,7 +873,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent;
-		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
 		while (parent && !blkg_lookup(parent, q)) {
@@ -887,23 +880,14 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			parent = blkcg_parent(parent);
 		}
 
-		new_blkg = blkg_alloc(pos, disk, GFP_NOIO);
-		if (unlikely(!new_blkg)) {
-			ret = -ENOMEM;
-			goto fail_unlock;
-		}
-
 		if (!blkcg_policy_enabled(q, pol)) {
-			blkg_free(new_blkg);
 			ret = -EOPNOTSUPP;
 			goto fail_unlock;
 		}
 
 		blkg = blkg_lookup(pos, q);
-		if (blkg) {
-			blkg_free(new_blkg);
-		} else {
-			blkg = blkg_create(pos, disk, new_blkg);
+		if (!blkg) {
+			blkg = blkg_create(pos, disk);
 			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
 				goto fail_unlock;
@@ -1468,27 +1452,18 @@ void blkg_init_queue(struct request_queue *q)
 int blkcg_init_disk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	struct blkcg_gq *new_blkg, *blkg;
-
-	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
-	if (!new_blkg)
-		return -ENOMEM;
+	struct blkcg_gq *blkg;
 
+	/* Make sure the root blkg exists. */
 	mutex_lock(&q->blkcg_mutex);
+	blkg = blkg_create(&blkcg_root, disk);
+	mutex_unlock(&q->blkcg_mutex);
 
-	/* Make sure the root blkg exists. */
-	blkg = blkg_create(&blkcg_root, disk, new_blkg);
 	if (IS_ERR(blkg))
-		goto err_unlock;
-	q->root_blkg = blkg;
-
-	mutex_unlock(&q->blkcg_mutex);
+		return PTR_ERR(blkg);
 
+	q->root_blkg = blkg;
 	return 0;
-
-err_unlock:
-	mutex_unlock(&q->blkcg_mutex);
-	return PTR_ERR(blkg);
 }
 
 void blkcg_exit_disk(struct gendisk *disk)
-- 
2.39.2


