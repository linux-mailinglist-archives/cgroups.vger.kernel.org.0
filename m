Return-Path: <cgroups+bounces-14806-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AImMEp34s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14806-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:44:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2028265B
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28184328C3F2
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D73019D8;
	Fri, 13 Mar 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="l2LQ8rEo"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90498381AFF
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402060; cv=none; b=CrFA0z0qy1UJkZLTRjTRZQodsX05T7z+0ogJMCGh8KL0XTswLOdgFxSD4V/id2WXR/0dX9CGsU4iqP55LZQGKhOisUU17gspZpMgzEystGVPRrFunFykpdWu4ZV9Rok9YeH1oGC5YCoqJ/rjdp2g+h8Zv6H3rGOHcvpv+DUtgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402060; c=relaxed/simple;
	bh=tlTapWst1mUfjKvTjEXddfgMD6ReMMF2xq5/nOxizws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UD5nOlMTuppCIrbMvKVvKsT5A0N8CGxxjxTH+RNuWys+3/VJaZElRpMbVTJ3TD2S0Fqn1CyYm9gqvg1wMBRIiSEBLvRKrnXPbAJiJk8hp9MwIv/6HFOvSW42KOFla8/Q0MtpTud77CSwxP1sUAfh/QdC0ugeYSEVHjaPKWiX4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=l2LQ8rEo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773402040; x=1774006840; i=natalie.vock@gmx.de;
	bh=kEIR7Z8a6OmCsUS2jDewz+Et7+kIBzmaixMAQDEs0dQ=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l2LQ8rEoFs3cqTfqHPgPuFqOUiFFlXf/4GeSwHICGjEz/y6WcwEaA+sfQltph4VU
	 umbdrmQCfi0CXlzuvewhUS/S5KoL4Qr09G2FzLbmfkmV3Abr6rpeDNtPc+IfyTsRz
	 5RvJC5ou+haquM3b6B53c4fFUSRBnmva6drPaTD9hWxk9RmBj5rdJ0qJDaVs/sEYT
	 e/ELZeoL/ccUA3NOoY9uT39xBhkcqE/nr5+h76tNbkbUSRjCb5sH33mSYhfmsCacW
	 YFFBARE0MbGeafDo9jB+ef9JZcmp+wLfZvnGbe+Fc083ZLMwpO7Zmo2H8rrW56f2o
	 Zuv+586K7Tfd4aUHiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1vcaAK2psO-012nte; Fri, 13
 Mar 2026 12:40:40 +0100
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 13 Mar 2026 12:40:02 +0100
Subject: [PATCH v6 3/6] drm/ttm: Extract code for attempting allocation in
 a place
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260313-dmemcg-aggressive-protect-v6-3-7c71cc1492db@gmx.de>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
X-Mailer: b4 0.14.3
X-Provags-ID: V03:K1:nmsmw/7K/Oq1ginZ6PBKppSp+5X9oWFd/uoDA88bOQxabprpZ75
 PtM2iKhfgGyRdA1pgk+F/xUbXgQXEgloR5XoITrdhY9Kg4V0i95LUVcKYcKM1pQyy/iAHXI
 dJ8m9xkqzkrJpZhxphIc02CApj6nHx36ysCMpvm7Jqz5GCTgRIHSSe0dvSI4pJ2NNn1jGYK
 cuHsDHFAPoBTDQgO9wnUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:98gojeN88jI=;1gT8dZRB52dWJXH3y3wVhLVEGcQ
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14806-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmx.de,igalia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C2028265B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move all code for attempting allocation for a specific place to
ttm_bo_alloc_place. With subsequent patches, this logic is going to get
more complicated, so it helps readability to have this separate.

ttm_bo_alloc_at_place takes a pointer to a struct ttm_bo_alloc_state.
This struct holds various state produced by the allocation (e.g. cgroup
resource associated with the allocation) that the caller needs to keep
track of (and potentially dispose of). This is just the limiting cgroup
pool for now, but future patches will add more state needing to be tracked=
.

ttm_bo_alloc_at_place also communicates via return codes if eviction
using ttm_bo_evict_alloc should be attempted. This is preparation for
attempting eviction in more cases than just force_space being set.

No functional change intended.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
=2D--
 drivers/gpu/drm/ttm/ttm_bo.c | 101 +++++++++++++++++++++++++++++++++-----=
=2D----
 1 file changed, 79 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index acb9197db8798..5cca0d6edbaf6 100644
=2D-- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -489,6 +489,62 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struc=
t ttm_resource_manager *man
 	return ret;
 }
=20
+struct ttm_bo_alloc_state {
+	/** @limit_pool: Which pool limit we should test against */
+	struct dmem_cgroup_pool_state *limit_pool;
+};
+
+/**
+ * ttm_bo_alloc_at_place - Attempt allocating a BO's backing store in a p=
lace
+ *
+ * @bo: The buffer to allocate the backing store of
+ * @place: The place to attempt allocation in
+ * @ctx: ttm_operation_ctx associated with this allocation
+ * @force_space: If we should evict buffers to force space
+ * @res: On allocation success, the resulting struct ttm_resource.
+ * @alloc_state: Object holding allocation state such as charged cgroups.
+ *
+ * Returns:
+ * -EBUSY: No space available, but allocation should be retried with ttm_=
bo_evict_alloc.
+ * -ENOSPC: No space available, allocation should not be retried.
+ * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.
+ *
+ */
+static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
+				 const struct ttm_place *place,
+				 struct ttm_operation_ctx *ctx,
+				 bool force_space,
+				 struct ttm_resource **res,
+				 struct ttm_bo_alloc_state *alloc_state)
+{
+	bool may_evict;
+	int ret;
+
+	may_evict =3D force_space && place->mem_type !=3D TTM_PL_SYSTEM;
+
+	ret =3D ttm_resource_alloc(bo, place, res,
+				 force_space ? &alloc_state->limit_pool : NULL);
+
+	if (ret) {
+		/*
+		 * -EAGAIN means the charge failed, which we treat like an
+		 * allocation failure. Therefore, return an error code indicating
+		 * the allocation failed - either -EBUSY if the allocation should
+		 * be retried with eviction, or -ENOSPC if there should be no second
+		 * attempt.
+		 */
+		if (ret =3D=3D -EAGAIN)
+			return may_evict ? -EBUSY : -ENOSPC;
+
+		if (ret =3D=3D -ENOSPC && may_evict)
+			return -EBUSY;
+
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * struct ttm_bo_evict_walk - Parameters for the evict walk.
  */
@@ -504,12 +560,13 @@ struct ttm_bo_evict_walk {
 	/** @evicted: Number of successful evictions. */
 	unsigned long evicted;
=20
-	/** @limit_pool: Which pool limit we should test against */
-	struct dmem_cgroup_pool_state *limit_pool;
 	/** @try_low: Whether we should attempt to evict BO's with low watermark=
 threshold */
 	bool try_low;
 	/** @hit_low: If we cannot evict a bo when @try_low is false (first pass=
) */
 	bool hit_low;
+
+	/** @alloc_state: State associated with the allocation attempt. */
+	struct ttm_bo_alloc_state *alloc_state;
 };
=20
 static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_o=
bject *bo)
@@ -518,8 +575,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, =
struct ttm_buffer_object *
 		container_of(walk, typeof(*evict_walk), walk);
 	s64 lret;
=20
-	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resour=
ce->css,
-					      evict_walk->try_low, &evict_walk->hit_low))
+	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_poo=
l,
+					      bo->resource->css, evict_walk->try_low,
+					      &evict_walk->hit_low))
 		return 0;
=20
 	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk-=
>place))
@@ -561,7 +619,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 			      struct ttm_operation_ctx *ctx,
 			      struct ww_acquire_ctx *ticket,
 			      struct ttm_resource **res,
-			      struct dmem_cgroup_pool_state *limit_pool)
+			      struct ttm_bo_alloc_state *state)
 {
 	struct ttm_bo_evict_walk evict_walk =3D {
 		.walk =3D {
@@ -574,7 +632,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 		.place =3D place,
 		.evictor =3D evictor,
 		.res =3D res,
-		.limit_pool =3D limit_pool,
+		.alloc_state =3D state,
 	};
 	s64 lret;
=20
@@ -725,9 +783,8 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_obj=
ect *bo,
=20
 	for (i =3D 0; i < placement->num_placement; ++i) {
 		const struct ttm_place *place =3D &placement->placement[i];
-		struct dmem_cgroup_pool_state *limit_pool =3D NULL;
+		struct ttm_bo_alloc_state alloc_state =3D {};
 		struct ttm_resource_manager *man;
-		bool may_evict;
=20
 		man =3D ttm_manager_type(bdev, place->mem_type);
 		if (!man || !ttm_resource_manager_used(man))
@@ -737,25 +794,25 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_o=
bject *bo,
 				    TTM_PL_FLAG_FALLBACK))
 			continue;
=20
-		may_evict =3D (force_space && place->mem_type !=3D TTM_PL_SYSTEM);
-		ret =3D ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : =
NULL);
-		if (ret) {
-			if (ret !=3D -ENOSPC && ret !=3D -EAGAIN) {
-				dmem_cgroup_pool_state_put(limit_pool);
-				return ret;
-			}
-			if (!may_evict) {
-				dmem_cgroup_pool_state_put(limit_pool);
-				continue;
-			}
+		ret =3D ttm_bo_alloc_at_place(bo, place, ctx, force_space,
+				res, &alloc_state);
=20
+		if (ret =3D=3D -ENOSPC) {
+			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
+			continue;
+		} else if (ret =3D=3D -EBUSY) {
 			ret =3D ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
-						 ticket, res, limit_pool);
-			dmem_cgroup_pool_state_put(limit_pool);
+						 ticket, res, &alloc_state);
+
+			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
+
 			if (ret =3D=3D -EBUSY)
 				continue;
-			if (ret)
+			else if (ret)
 				return ret;
+		} else if (ret) {
+			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
+			return ret;
 		}
=20
 		ret =3D ttm_bo_add_pipelined_eviction_fences(bo, man, ctx->no_wait_gpu)=
;

=2D-=20
2.53.0


