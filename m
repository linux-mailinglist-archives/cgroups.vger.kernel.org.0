Return-Path: <cgroups+bounces-14197-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAWGDcIInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14197-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C1180ED7
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1F1303C4D9
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188DA257459;
	Tue, 24 Feb 2026 02:11:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2A24A07C
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899071; cv=none; b=JpgJaJTnoQKfEuLH+3FiUuUnpP1EcBOQaL4TtzCKw00odIwToev4fhHofiIa5INdYeRm8y+Xki/ieYXglAlI/9CA3bYu2llJkH6o9Rul4GGUrOgoLFG26ZuYMLyrXRrkgndTCAWIizxWJLakMoKOhUOJyfS503Oi/M3SWGzID40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899071; c=relaxed/simple;
	bh=5g4/cCk1FoqNCQf3MsuoeYRTVCiBwfGjxds79J8cnZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ockc/Jtzauy6tdf2fw4QLcxTlsDhn9k31y6IJRPpGHWfza9fzVp7h+1L5VjYsvEzrrNLqfdZ0BidX99a8VckcBKdYpCBpwi8V0NM1+Zg79hiWGwF00YHf4hirP8Zc1tzb+NUMo8cZC5RD1SrGRshltwB8VQ2PZRlZ1e61+qQ/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-vrMaxZtWOamwfNix5OMg8A-1; Mon,
 23 Feb 2026 21:11:04 -0500
X-MC-Unique: vrMaxZtWOamwfNix5OMg8A-1
X-Mimecast-MFC-AGG-ID: vrMaxZtWOamwfNix5OMg8A_1771899063
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED9421956095;
	Tue, 24 Feb 2026 02:11:02 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F43C30001BB;
	Tue, 24 Feb 2026 02:10:56 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [PATCH 16/16] xe: create a flag to enable memcg accounting for XE as well.
Date: Tue, 24 Feb 2026 12:06:33 +1000
Message-ID: <20260224020854.791201-17-airlied@gmail.com>
In-Reply-To: <20260224020854.791201-1-airlied@gmail.com>
References: <20260224020854.791201-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8s2Od3QIUpDFXcG-Tj1-ppVPqCMxIz2beAVT0OhrjPs_1771899063
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14197-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lankhorst.se:email]
X-Rspamd-Queue-Id: D30C1180ED7
X-Rspamd-Action: no action

From: Maarten Lankhorst <dev@lankhorst.se>

This adds support for memcg accounting to ttm object used by xe driver.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/xe/xe_bo.c  | 10 +++++++---
 drivers/gpu/drm/xe/xe_bo.h  |  1 +
 drivers/gpu/drm/xe/xe_lrc.c |  3 ++-
 drivers/gpu/drm/xe/xe_oa.c  |  3 ++-
 drivers/gpu/drm/xe/xe_pt.c  |  3 ++-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index fae2d738ecd2..44ad97b7e0c1 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -56,6 +56,7 @@ static const struct ttm_place sys_placement_flags =3D {
 =09.flags =3D 0,
 };
=20
+/* TTM_PL_FLAG_MEMCG is not set, those placements are used for eviction */
 static struct ttm_placement sys_placement =3D {
 =09.num_placement =3D 1,
 =09.placement =3D &sys_placement_flags,
@@ -194,8 +195,8 @@ static void try_add_system(struct xe_device *xe, struct=
 xe_bo *bo,
=20
 =09=09bo->placements[*c] =3D (struct ttm_place) {
 =09=09=09.mem_type =3D XE_PL_TT,
-=09=09=09.flags =3D (bo_flags & XE_BO_FLAG_VRAM_MASK) ?
-=09=09=09TTM_PL_FLAG_FALLBACK : 0,
+=09=09=09.flags =3D TTM_PL_FLAG_MEMCG | ((bo_flags & XE_BO_FLAG_VRAM_MASK)=
 ?
+=09=09=09TTM_PL_FLAG_FALLBACK : 0),
 =09=09};
 =09=09*c +=3D 1;
 =09}
@@ -2216,6 +2217,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe,=
 struct xe_bo *bo,
 =09placement =3D (type =3D=3D ttm_bo_type_sg ||
 =09=09     bo->flags & XE_BO_FLAG_DEFER_BACKING) ? &sys_placement :
 =09=09&bo->placement;
+
+=09if (bo->flags & XE_BO_FLAG_ACCOUNTED)
+=09=09ttm_bo_set_cgroup(&bo->ttm, get_obj_cgroup_from_current());
 =09err =3D ttm_bo_init_reserved(&xe->ttm, &bo->ttm, type,
 =09=09=09=09   placement, alignment,
 =09=09=09=09   &ctx, NULL, resv, xe_ttm_bo_destroy);
@@ -3193,7 +3197,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void =
*data,
 =09if (XE_IOCTL_DBG(xe, args->size & ~PAGE_MASK))
 =09=09return -EINVAL;
=20
-=09bo_flags =3D 0;
+=09bo_flags =3D XE_BO_FLAG_ACCOUNTED;
 =09if (args->flags & DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING)
 =09=09bo_flags |=3D XE_BO_FLAG_DEFER_BACKING;
=20
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index c914ab719f20..2c2a93d018fe 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -52,6 +52,7 @@
 #define XE_BO_FLAG_CPU_ADDR_MIRROR=09BIT(24)
 #define XE_BO_FLAG_FORCE_USER_VRAM=09BIT(25)
 #define XE_BO_FLAG_NO_COMPRESSION=09BIT(26)
+#define XE_BO_FLAG_ACCOUNTED=09=09BIT(27)
=20
 /* this one is trigger internally only */
 #define XE_BO_FLAG_INTERNAL_TEST=09BIT(30)
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index b0f037bc227f..e4f2d6db18b3 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1466,7 +1466,8 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_=
hw_engine *hwe,
 =09=09   XE_BO_FLAG_GGTT_INVALIDATE;
=20
 =09if ((vm && vm->xef) || init_flags & XE_LRC_CREATE_USER_CTX) /* userspac=
e */
-=09=09bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER=
_VRAM;
+=09=09bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER=
_VRAM |
+=09=09=09    XE_BO_FLAG_ACCOUNTED;
=20
 =09lrc->bo =3D xe_bo_create_pin_map_novm(xe, tile,
 =09=09=09=09=09    bo_size,
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 4dd3f29933cf..2606395aafdd 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -887,7 +887,8 @@ static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *s=
tream, size_t size)
=20
 =09bo =3D xe_bo_create_pin_map_novm(stream->oa->xe, stream->gt->tile,
 =09=09=09=09       size, ttm_bo_type_kernel,
-=09=09=09=09       XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT, false);
+=09=09=09=09       XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT |
+=09=09=09=09       XE_BO_FLAG_ACCOUNTED, false);
 =09if (IS_ERR(bo))
 =09=09return PTR_ERR(bo);
=20
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 13b355fadd58..c1157dd56923 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -122,7 +122,8 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm, struct xe_=
tile *tile,
 =09=09   XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE |
 =09=09   XE_BO_FLAG_NO_RESV_EVICT | XE_BO_FLAG_PAGETABLE;
 =09if (vm->xef) /* userspace */
-=09=09bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER=
_VRAM;
+=09=09bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER=
_VRAM |
+=09=09=09    XE_BO_FLAG_ACCOUNTED;
=20
 =09pt->level =3D level;
=20
--=20
2.52.0


