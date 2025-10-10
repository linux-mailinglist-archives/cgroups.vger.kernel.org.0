Return-Path: <cgroups+bounces-10639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A70BCC4C7
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04534426660
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6D27990D;
	Fri, 10 Oct 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWeTXK9U"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077D2765E6;
	Fri, 10 Oct 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087724; cv=none; b=f6JfJ/KR6U0mUvXpRg4BtJTp5eO9Zf0rwVX6KOpJMiEWcM1qKdTKqMRiog62nNJSispHfhAyDV4MQ3ZCIcYf4T7DXb3L0D0UQpANC2zIkAgRVQtJB9tf5w8aO+JcDo1moTqxb7FsYG5kRE2ELZthF9Th9vXpql2eYww0cotrXFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087724; c=relaxed/simple;
	bh=71t1rc86LBoLpp/AZ7tkC/o2XX//I5mO8PuzK7GqrtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHvU+tPieHLVXqJV3N9T+e0FG+2xzm6QBlH1lUAY2oyli48rigj0AinpFmKz32kBL5WABXvzmo819a2CG/Jc8mpoBe3WWpyj4dXyZi8ElIYbJ99Wi90FIfDN9xRQeG1mUVVwiiLJvW7ddXB/SHa/TQUCvYP2lMkyano0Ogf1jjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWeTXK9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B958DC4CEF8;
	Fri, 10 Oct 2025 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087724;
	bh=71t1rc86LBoLpp/AZ7tkC/o2XX//I5mO8PuzK7GqrtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWeTXK9URzTJtZkBTn/CaM7Kf/qkbsu6fXJWF6j6Sbsw27MnWVf4CjHSlW5/rGzoq
	 Grt/KJFg3+OBYCqYKrKn3GNYoR2c6FMaPrbGNZvWEKyUOnMPbnCiUs+sp+50Ht9YQT
	 wrL3xSPARIK4lwh2yg7UaF3dlDIMyWdJdARdKRwKnYfN15SA3TJj4G8BK7Wp0Aps8a
	 8trw3Qx4+YDddSOwN0ZRp1Mtnc+eNW5MduuW6ptBQq3+ueuzSlIoZ9/g5gE1XYuZsz
	 uY7NA3sriMnTmZIdmj5rpFIsVQ0oElVS5wBor/LA8ADs8WZQkKdecOhCjFShCB0Mm7
	 B96uGHcz168gA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 11/19] blk-cgroup: remove preallocate blkg for blkg_create()
Date: Fri, 10 Oct 2025 17:14:36 +0800
Message-ID: <20251010091446.3048529-12-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

Now that blkg_create is protected with blkcg_mutex, there is no need to
preallocate blkg, remove related code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 91 +++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 58 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 030499d70543..3c23d2d1e237 100644
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
@@ -880,7 +874,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent;
-		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
 		while (parent && !blkg_lookup(parent, q)) {
@@ -888,23 +881,14 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
@@ -1469,27 +1453,18 @@ void blkg_init_queue(struct request_queue *q)
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
2.51.0


