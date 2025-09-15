Return-Path: <cgroups+bounces-10088-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540FB57B3F
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8803ABA73
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B26930B51B;
	Mon, 15 Sep 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="IeSF41Xe"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052A30ACEB
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939840; cv=none; b=atkY27gzua7He6fV3Hv3W1/JetBZ2O6xdBAO324uixMqirE9TmwWt6NzLE/bPsgU/Gyzyn2WeFGBAEILJsqxxzs6hPXmjAcIjvw+VZXDlWcrXvencEZlfM20vJevvXxpxwEIJT8/LDDm0FM5xlzHF7ffQd2BrgulmHI64Wb9C9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939840; c=relaxed/simple;
	bh=gFsdXWx4N7W0AfpKDz67vCb3kEy31arMzMIXpPzcFuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1iaYf2tFw3iarI2SJGC2or80vx6ZKIrYLHae1fGmehs7IimwfUZP3AF25v38e972KBtDZp0ly2jh1xjyJ4zl7x4sXPbK4Q0OcwvJH+cGDvrnJbO5DZLPH1U2pMGOgEnZV4kXvnP+upxH/pnLwyuecVrlzAkkWg67Nu38X+UA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=IeSF41Xe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757939823; x=1758544623; i=natalie.vock@gmx.de;
	bh=+Uhmroz29IvBLpyP5ZtwN6C23c0XBazRPte2m3jAQuA=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IeSF41XeqRQ6Tj7ERHNogu8Vg9uXTIMe/FQL1YbDaMybMmZw3bSqwHoBRpFTJpwL
	 o9CEfFg8zxaunpBVXxfR91973TZ63DNs9hpUOX7pzaDJRv/GkYRSb7s2oxFUUHJXn
	 /f7yLBVQhsCDXhTh3z2y4sjMdX9Qf/erc29Y+q5Ubew8dvfgaZpBfy5hZ9ltGLryA
	 Eunmc/YfYf1uVuFLGQ6w2N0RWKjpHlA0zM82s79adGNiALZUF3zy5+sc705jxgdOA
	 woUJcltQFjDuSSsIl9rYfjGSPDQHOSGnPgPwaAYOfmzsHp6yqKvjKgzcr6KxdZ323
	 jdDE2+QxuepCmEMfng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1ulZeP0v1m-00Wkt8; Mon, 15
 Sep 2025 14:37:03 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Mon, 15 Sep 2025 14:36:30 +0200
Subject: [PATCH 3/4] drm/ttm: Be more aggressive when allocating below
 protection limit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20250915-dmemcg-aggressive-protect-v1-3-2f3353bfcdac@gmx.de>
References: <20250915-dmemcg-aggressive-protect-v1-0-2f3353bfcdac@gmx.de>
In-Reply-To: <20250915-dmemcg-aggressive-protect-v1-0-2f3353bfcdac@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Provags-ID: V03:K1:JyGOHs7x3XT0GTk4ho9u1qT7Y5l78l0oA/yupAMHuY9cSU77Ite
 JVrJ/vV+DFkNNe3TmVWrP/Xp6eZ9WejeSOnpZPkXW/5MjHA6S7QtefrgmoKMmyb2wCcSogP
 wIAN9UyVQVAFYfZc4RuR+EeOD5sd7ed1c9Vy5kAhkXIrkIWe4ZzyvtPMRZTN+rHRzbcxc7S
 zkoOIXElaGnz0SbOmMfQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F3aqzgjZjmY=;4WnTVU7zKD/MSPeUBSz6qhaQuJC
 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

When the cgroup's memory usage is below the low/min limit and allocation
fails, try evicting some unprotected buffers to make space. Otherwise,
application buffers may be forced to go into GTT even though usage is
below the corresponding low/min limit, if other applications filled VRAM
with their allocations first.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c       | 57 ++++++++++++++++++++++++++++++---=
=2D----
 drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++++++---------
 include/drm/ttm/ttm_resource.h     |  6 +++-
 3 files changed, 86 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f4d9e68b21e70cb25d0db5e79391233e1dc72221..d20ff41411c08cd97b4467f603=
751f483d1c7ff4 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -504,6 +504,8 @@ struct ttm_bo_evict_walk {
 	/** @evicted: Number of successful evictions. */
 	unsigned long evicted;
=20
+	/** @charge_pool: The memory pool the resource is charged to */
+	struct dmem_cgroup_pool_state *charge_pool;
 	/** @limit_pool: Which pool limit we should test against */
 	struct dmem_cgroup_pool_state *limit_pool;
 	/** @try_low: Whether we should attempt to evict BO's with low watermark=
 threshold */
@@ -539,7 +541,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, =
struct ttm_buffer_object *
 	evict_walk->evicted++;
 	if (evict_walk->res)
 		lret =3D ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
-					  evict_walk->res, NULL);
+					  evict_walk->res, evict_walk->charge_pool);
 	if (lret =3D=3D 0)
 		return 1;
 out:
@@ -561,6 +563,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 			      struct ttm_operation_ctx *ctx,
 			      struct ww_acquire_ctx *ticket,
 			      struct ttm_resource **res,
+			      bool only_evict_unprotected,
+			      struct dmem_cgroup_pool_state *charge_pool,
 			      struct dmem_cgroup_pool_state *limit_pool)
 {
 	struct ttm_bo_evict_walk evict_walk =3D {
@@ -574,6 +578,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 		.place =3D place,
 		.evictor =3D evictor,
 		.res =3D res,
+		.charge_pool =3D charge_pool,
 		.limit_pool =3D limit_pool,
 	};
 	s64 lret;
@@ -582,7 +587,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
=20
 	/* One more attempt if we hit low limit? */
-	if (!lret && evict_walk.hit_low) {
+	if (!lret && evict_walk.hit_low && !only_evict_unprotected) {
 		evict_walk.try_low =3D true;
 		lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	}
@@ -603,7 +608,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	} while (!lret && evict_walk.evicted);
=20
 	/* We hit the low limit? Try once more */
-	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
+	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
+			!only_evict_unprotected) {
 		evict_walk.try_low =3D true;
 		goto retry;
 	}
@@ -724,9 +730,9 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_obj=
ect *bo,
=20
 	for (i =3D 0; i < placement->num_placement; ++i) {
 		const struct ttm_place *place =3D &placement->placement[i];
-		struct dmem_cgroup_pool_state *limit_pool =3D NULL;
+		struct dmem_cgroup_pool_state *limit_pool =3D NULL, *charge_pool =3D NU=
LL;
 		struct ttm_resource_manager *man;
-		bool may_evict;
+		bool may_evict, is_protected =3D false;
=20
 		man =3D ttm_manager_type(bdev, place->mem_type);
 		if (!man || !ttm_resource_manager_used(man))
@@ -737,24 +743,53 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_o=
bject *bo,
 			continue;
=20
 		may_evict =3D (force_space && place->mem_type !=3D TTM_PL_SYSTEM);
-		ret =3D ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : =
NULL);
+		ret =3D ttm_resource_try_charge(bo, place, &charge_pool,
+					      force_space ? &limit_pool : NULL);
+		if (ret) {
+			if (ret !=3D -EAGAIN) {
+				dmem_cgroup_pool_state_put(limit_pool);
+				return ret;
+			} else if (!may_evict) {
+				dmem_cgroup_pool_state_put(limit_pool);
+				continue;
+			}
+		} else {
+			is_protected =3D dmem_cgroup_below_min(NULL, charge_pool) ||
+				       dmem_cgroup_below_low(NULL, charge_pool);
+			ret =3D ttm_resource_alloc(bo, place, res, charge_pool);
+		}
+
 		if (ret) {
 			if (ret !=3D -ENOSPC && ret !=3D -EAGAIN) {
 				dmem_cgroup_pool_state_put(limit_pool);
+				if (charge_pool) {
+					dmem_cgroup_uncharge(charge_pool, bo->base.size);
+					dmem_cgroup_pool_state_put(charge_pool);
+				}
 				return ret;
 			}
-			if (!may_evict) {
+			if (!may_evict && !is_protected) {
 				dmem_cgroup_pool_state_put(limit_pool);
+				if (charge_pool) {
+					dmem_cgroup_uncharge(charge_pool, bo->base.size);
+					dmem_cgroup_pool_state_put(charge_pool);
+				}
 				continue;
 			}
=20
 			ret =3D ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
-						 ticket, res, limit_pool);
+						 ticket, res, !may_evict && is_protected,
+						 charge_pool, limit_pool);
 			dmem_cgroup_pool_state_put(limit_pool);
-			if (ret =3D=3D -EBUSY)
-				continue;
-			if (ret)
+			if (ret) {
+				if (charge_pool) {
+					dmem_cgroup_uncharge(charge_pool, bo->base.size);
+					dmem_cgroup_pool_state_put(charge_pool);
+				}
+				if (ret =3D=3D -EBUSY)
+					continue;
 				return ret;
+			}
 		}
=20
 		ret =3D ttm_bo_add_move_fence(bo, man, ctx->no_wait_gpu);
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_=
resource.c
index e2c82ad07eb44b5e88bf5b5db1ef54dd6d27823b..fcfa8b51b033745f46a01e40a9=
dc83e0c69165fc 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -372,30 +372,52 @@ void ttm_resource_fini(struct ttm_resource_manager *=
man,
 }
 EXPORT_SYMBOL(ttm_resource_fini);
=20
+/**
+ * ttm_resource_try_charge - charge a resource manager's cgroup pool
+ * @bo: buffer for which an allocation should be charged
+ * @place: where the allocation is attempted to be placed
+ * @ret_pool: on charge success, the pool that was charged
+ * @ret_limit_pool: on charge failure, the pool responsible for the failu=
re
+ *
+ * Should be used to charge cgroups before attempting resource allocation=
.
+ * When charging succeeds, the value of ret_pool should be passed to
+ * ttm_resource_alloc.
+ *
+ * Returns: 0 on charge success, negative errno on failure.
+ */
+int ttm_resource_try_charge(struct ttm_buffer_object *bo,
+			    const struct ttm_place *place,
+			    struct dmem_cgroup_pool_state **ret_pool,
+			    struct dmem_cgroup_pool_state **ret_limit_pool)
+{
+	struct ttm_resource_manager *man =3D
+		ttm_manager_type(bo->bdev, place->mem_type);
+
+	if (!man->cg) {
+		*ret_pool =3D NULL;
+		if (ret_limit_pool)
+			*ret_limit_pool =3D NULL;
+		return 0;
+	}
+
+	return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
+				      ret_limit_pool);
+}
+
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res_ptr,
-		       struct dmem_cgroup_pool_state **ret_limit_pool)
+		       struct dmem_cgroup_pool_state *charge_pool)
 {
 	struct ttm_resource_manager *man =3D
 		ttm_manager_type(bo->bdev, place->mem_type);
-	struct dmem_cgroup_pool_state *pool =3D NULL;
 	int ret;
=20
-	if (man->cg) {
-		ret =3D dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit=
_pool);
-		if (ret)
-			return ret;
-	}
-
 	ret =3D man->func->alloc(man, bo, place, res_ptr);
-	if (ret) {
-		if (pool)
-			dmem_cgroup_uncharge(pool, bo->base.size);
+	if (ret)
 		return ret;
-	}
=20
-	(*res_ptr)->css =3D pool;
+	(*res_ptr)->css =3D charge_pool;
=20
 	spin_lock(&bo->bdev->lru_lock);
 	ttm_resource_add_bulk_move(*res_ptr, bo);
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource=
.h
index e52bba15012f78e352f392232ac2e89a83afd311..3aef7efdd7cfb8fd93071db85e=
632b975b53cf81 100644
=2D-- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -442,10 +442,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 void ttm_resource_fini(struct ttm_resource_manager *man,
 		       struct ttm_resource *res);
=20
+int ttm_resource_try_charge(struct ttm_buffer_object *bo,
+			    const struct ttm_place *place,
+			    struct dmem_cgroup_pool_state **ret_pool,
+			    struct dmem_cgroup_pool_state **ret_limit_pool);
 int ttm_resource_alloc(struct ttm_buffer_object *bo,
 		       const struct ttm_place *place,
 		       struct ttm_resource **res,
-		       struct dmem_cgroup_pool_state **ret_limit_pool);
+		       struct dmem_cgroup_pool_state *charge_pool);
 void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource =
**res);
 bool ttm_resource_intersects(struct ttm_device *bdev,
 			     struct ttm_resource *res,

=2D-=20
2.51.0


