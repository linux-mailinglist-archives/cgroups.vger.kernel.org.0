Return-Path: <cgroups+bounces-10779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77DBDEDF2
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6C68341131
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA223D7C5;
	Wed, 15 Oct 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="kwAhS31W"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246C23BD1D
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536683; cv=none; b=aI81rB4f+37M+XKY/2yPlmsakLM2c1bJGyLiKRDMh1k60TZu8xNjjJrjMd5gYVNQjK3vqvZI+Crj1XwwVxMIF6SIVloPHzE0CzmtYw9fF9aK2hDmqnOGkXn4tI2dWOyf1aqWciG9xCARmFloSrwIacHHSx/b6YlZnKdSUt2CkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536683; c=relaxed/simple;
	bh=iBZuaAF9/vZt5EZnWh7xWXCfDxK3yNnAP+ZITy2hs/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PA8hDARG3tyRarWC+ZPHi9bMr+t8mx3R/DTiVNemdEJv9foLMBaopnz7vR3cPcGqM1qIZ5oH37+RlW52mNdDryBq9qAUAVRSF66QV84fgrMwoIW3kExcphhlv7ceQ/+D/mBwcmib84ParTMbaMfLKYicLhxkA078yB1ztaIwwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=kwAhS31W; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760536674; x=1761141474; i=natalie.vock@gmx.de;
	bh=ZfXFDXTVVcVjH9CbKFppb74hdNyo76DwCcqC4Pzs9V0=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kwAhS31WMbe0W16H1GuEy7jcKjdMOarJ2E3b5iMg6KHVRTe7l1en9vqLQEGtTo/G
	 kl9+xg+LElsbEFWhFILhO6D53F9KeeO05V9FbJD8EeN3iU8JJmr7AohWqMSWmltpy
	 U7PtYTUYb5LOEENRGcOeScX6u0ttqIWHNg9Elf8cVczMHS3L9ZQIZ7ld/4Gkrr9B8
	 vUpSYRldgcqpDMAvDk+a4A+IcrCcs0MwTqmpq+fzDAtebjkEWwWfOForWQ0wPNuwu
	 ZfEplLJMpR79l3I5j+jgGoJCTrq95X4tXjagYoZds5hq59C3Fak1U+bIoBrEyj8/y
	 AXvrwm0XVekxwITQgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1uPUe71ajt-00o7D9; Wed, 15
 Oct 2025 15:57:54 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Wed, 15 Oct 2025 15:57:31 +0200
Subject: [PATCH v2 4/5] drm/ttm: Be more aggressive when allocating below
 protection limit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251015-dmemcg-aggressive-protect-v2-4-36644fb4e37f@gmx.de>
References: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
In-Reply-To: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
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
X-Provags-ID: V03:K1:IaLmcoicxgJQOJuORepvvkU8I/vYfXLT34YonRdGR7iPe7LMtLF
 jQlYLm/yPTDmsoN+JKwReIqTBw3enCLZbcl0Ol9r2lVtUmIfQPDviHX7EYTm8ClLcQi0CKI
 RIgXg98JF4FDyReICxtMICOdawthPET4qyXDJcA6bN717zYs0d9UNqH8SQaghpWeClipYGW
 T6d4uKjfk9xhGnhqJUiAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V4i6HINxl2g=;5tIKdOgOjGDAf8Ww/8oeElR6F+g
 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
 YjhuwELiCBDER7e/M=

When the cgroup's memory usage is below the low/min limit and allocation
fails, try evicting some unprotected buffers to make space. Otherwise,
application buffers may be forced to go into GTT even though usage is
below the corresponding low/min limit, if other applications filled VRAM
with their allocations first.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c       | 43 ++++++++++++++++++++++++++++-----=
-
 drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++++++++++------=
=2D----
 include/drm/ttm/ttm_resource.h     |  6 ++++-
 3 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 829d99479883594f8be5b9ceed4cc53c4864ace5..7f7872ab2090cc8db188e08ddf=
dcd12fe924f743 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struc=
t ttm_resource_manager *man
 }
=20
 struct ttm_bo_alloc_state {
+	/** @charge_pool: The memory pool the resource is charged to */
+	struct dmem_cgroup_pool_state *charge_pool;
 	/** @limit_pool: Which pool limit we should test against */
 	struct dmem_cgroup_pool_state *limit_pool;
+	/** @only_evict_unprotected: If eviction should be restricted to unprote=
cted BOs */
+	bool only_evict_unprotected;
 };
=20
 /**
@@ -546,7 +550,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, =
struct ttm_buffer_object *
 	evict_walk->evicted++;
 	if (evict_walk->res)
 		lret =3D ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
-					  evict_walk->res, NULL);
+					  evict_walk->res, evict_walk->alloc_state->charge_pool);
 	if (lret =3D=3D 0)
 		return 1;
 out:
@@ -589,7 +593,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
=20
 	/* One more attempt if we hit low limit? */
-	if (!lret && evict_walk.hit_low) {
+	if (!lret && evict_walk.hit_low && !state->only_evict_unprotected) {
 		evict_walk.try_low =3D true;
 		lret =3D ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
 	}
@@ -610,7 +614,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 	} while (!lret && evict_walk.evicted);
=20
 	/* We hit the low limit? Try once more */
-	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
+	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
+			!state->only_evict_unprotected) {
 		evict_walk.try_low =3D true;
 		goto retry;
 	}
@@ -719,20 +724,40 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_o=
bject *bo,
 				 struct ttm_resource **res,
 				 struct ttm_bo_alloc_state *alloc_state)
 {
-	bool may_evict;
+	bool may_evict, is_protected =3D false;
 	int ret;
=20
 	may_evict =3D (force_space && place->mem_type !=3D TTM_PL_SYSTEM);
+	ret =3D ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
+				      force_space ? &alloc_state->limit_pool : NULL);
+	if (ret) {
+		/*
+		 * -EAGAIN means the charge failed, which we treat like an
+		 * allocation failure. Allocation failures are indicated
+		 * by -ENOSPC, so return that instead.
+		 */
+		if (ret =3D=3D -EAGAIN && !may_evict)
+			ret =3D -ENOSPC;
+		return ret;
+	}
=20
-	ret =3D ttm_resource_alloc(bo, place, res,
-				 force_space ? &alloc_state->limit_pool : NULL);
+	is_protected =3D dmem_cgroup_below_min(NULL, alloc_state->charge_pool) |=
|
+		       dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
+	ret =3D ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
+	alloc_state->only_evict_unprotected =3D !may_evict && is_protected;
=20
 	if (ret) {
-		if ((ret =3D=3D -ENOSPC || ret =3D=3D -EAGAIN) && may_evict)
+		if ((ret =3D=3D -ENOSPC || ret =3D=3D -EAGAIN) &&
+				(may_evict || is_protected))
 			ret =3D -EBUSY;
 		return ret;
 	}
=20
+	/*
+	 * Ownership of charge_pool has been transferred to the TTM resource,
+	 * don't make the caller think we still hold a reference to it.
+	 */
+	alloc_state->charge_pool =3D NULL;
 	return 0;
 }
=20
@@ -787,6 +812,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_obj=
ect *bo,
 				res, &alloc_state);
=20
 		if (ret =3D=3D -ENOSPC) {
+			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
 			continue;
 		} else if (ret =3D=3D -EBUSY) {
@@ -796,11 +822,14 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_o=
bject *bo,
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
=20
 			if (ret) {
+				dmem_cgroup_pool_state_put(
+						alloc_state.charge_pool);
 				if (ret !=3D -ENOSPC && ret !=3D -EBUSY)
 					return ret;
 				continue;
 			}
 		} else if (ret) {
+			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
 			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
 			return ret;
 		}
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


