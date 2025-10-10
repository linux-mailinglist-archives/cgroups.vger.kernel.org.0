Return-Path: <cgroups+bounces-10633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70530BCC45D
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AB4FC1F6
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6B276031;
	Fri, 10 Oct 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puSKUgh7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04728274B5C;
	Fri, 10 Oct 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087704; cv=none; b=hoPHb3pi2Z/wvrkPrw8ZU/35pGvus8Fk74taGsTR45CVPMh+Cp5LwboW3ynTMZ4tiuLqbB6DpFxf0szU31/eWCngRTQJqsq+WQlvAey/9etAlc58IbrnMTC1KbNVcFXerzWfQ3J+TcXzsvNv5dlS5lPWEwcMV1RPtRonYWWbdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087704; c=relaxed/simple;
	bh=ovGLFVCTGYuUOq4yNzliDM5OKa3CSQx0e3n0oSGzHFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SppcJl8F+we0LqxX76b7rJlMvtbspa6QrthD1iblenA0IIEfCXb5yt9/vZMnwi7APTe9fU3uFmxPdUKamKK8abLjwnhNwB39jC89xepncjElSwVamSM8YS6LE59fRcHsZyo6S96hqMQjaIS7OXG1U56Dh7uH63WtZdJqGUp9QbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puSKUgh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D4CC4CEF1;
	Fri, 10 Oct 2025 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087703;
	bh=ovGLFVCTGYuUOq4yNzliDM5OKa3CSQx0e3n0oSGzHFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puSKUgh74qhPenhdcqpgluAILDfsmC+ftc5uyGPFAd+eYy+xWsCgA9OanqBdpAPcn
	 XnM1VH4MeubcQ5NFdG5pudsTvnmAR0ytwnAyhwqYRigYUuHnrjhHHuwsMhL76wEwqt
	 O4uGN1KEwmSV86kf2pTNUi2dvD6ObfgYxdNUcYeC8Xnc6ILbEDWda3QnRw7CjKPE6Y
	 XaITSTbXkQ5QkNLtwPbJHamE/oYAH824F3HAjhmlg22Ij18UzYNCMtT/W2FxMDOtLT
	 vJWTc+UR6TXC6+Obf0MHiL8HHGZquw/tLHy2mwbTQQdiKxzUHTfu/008IcKR6OcAlC
	 3LYUwRxXteCdw==
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
Subject: [PATCH v2 04/19] blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
Date: Fri, 10 Oct 2025 17:14:29 +0800
Message-ID: <20251010091446.3048529-5-yukuai@kernel.org>
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

Changes to two step:

1) hold rcu lock and do blkg_lookup() from fast path;
2) hold queue_lock directly from slow path, and don't nest it under rcu
   lock;

Prepare to convert protecting blkcg with blkcg_mutex instead of
queue_lock;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 57 +++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fb40262971c9..3363d2476fed 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -467,22 +467,17 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 {
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg;
-	unsigned long flags;
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	blkg = blkg_lookup(blkcg, q);
-	if (blkg)
-		return blkg;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
+	rcu_read_lock();
 	blkg = blkg_lookup(blkcg, q);
 	if (blkg) {
 		if (blkcg != &blkcg_root &&
 		    blkg != rcu_dereference(blkcg->blkg_hint))
 			rcu_assign_pointer(blkcg->blkg_hint, blkg);
-		goto found;
+		rcu_read_unlock();
+		return blkg;
 	}
+	rcu_read_unlock();
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
@@ -514,8 +509,6 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 			break;
 	}
 
-found:
-	spin_unlock_irqrestore(&q->queue_lock, flags);
 	return blkg;
 }
 
@@ -2078,6 +2071,18 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	atomic64_add(delta, &blkg->delay_nsec);
 }
 
+static inline struct blkcg_gq *blkg_lookup_tryget(struct blkcg_gq *blkg)
+{
+retry:
+	if (blkg_tryget(blkg))
+		return blkg;
+
+	blkg = blkg->parent;
+	if (blkg)
+		goto retry;
+
+	return NULL;
+}
 /**
  * blkg_tryget_closest - try and get a blkg ref on the closet blkg
  * @bio: target bio
@@ -2090,20 +2095,30 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
 		struct cgroup_subsys_state *css)
 {
-	struct blkcg_gq *blkg, *ret_blkg = NULL;
+	struct request_queue *q = bio->bi_bdev->bd_queue;
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
 
 	rcu_read_lock();
-	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_bdev->bd_disk);
-	while (blkg) {
-		if (blkg_tryget(blkg)) {
-			ret_blkg = blkg;
-			break;
-		}
-		blkg = blkg->parent;
-	}
+	blkg = blkg_lookup(blkcg, q);
+	if (likely(blkg))
+		blkg = blkg_lookup_tryget(blkg);
 	rcu_read_unlock();
 
-	return ret_blkg;
+	if (blkg)
+		return blkg;
+
+	/*
+	 * Fast path failed, we're probably issuing IO in this cgroup the first
+	 * time, hold lock to create new blkg.
+	 */
+	spin_lock_irq(&q->queue_lock);
+	blkg = blkg_lookup_create(blkcg, bio->bi_bdev->bd_disk);
+	if (blkg)
+		blkg = blkg_lookup_tryget(blkg);
+	spin_unlock_irq(&q->queue_lock);
+
+	return blkg;
 }
 
 /**
-- 
2.51.0


