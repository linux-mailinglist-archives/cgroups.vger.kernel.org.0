Return-Path: <cgroups+bounces-17527-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5uXECXQ8S2otOAEAu9opvQ
	(envelope-from <cgroups+bounces-17527-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:26:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF670C982
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17527-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17527-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F10301CCE2
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194853B5839;
	Mon,  6 Jul 2026 05:25:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CA3590AE
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 05:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315517; cv=none; b=F3euVcJtkzo9S28roCNMJOPf3rDBme1p5QR/NHmkDO/piMLQXmOKcsCP3nuQ/57x4M4QA5pVBYOvOUz9oirzaudms06xQlcOHDelmb8wBix+TcVqGSZdRf0ralB09MWsR5cdRDZRM9johD+9NaTbskccV2YUsTm+hlUEaDH+T3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315517; c=relaxed/simple;
	bh=257a0blGbP2rFyfFp35RvWDPKLF88h1p98fYy9AucM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rOD5QAr0YFIs2w/i3LFH65dtkxxmAEzgZI5zNABOVZvLyVc+x4mHzEFVOYXSTJFo1gfaC9J2Cmdxe4AQcaEH0GsOJaDfr+hxtNf1LCLLc+1OuGdSE5eUp57k+/RiMrxPAPxMnfZ2t7n4F8uOzkI+idcOEex0Jiy2W0Bw1QjAR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-APj01Y9IP2mujpffrA2ESQ-1; Mon,
 06 Jul 2026 01:25:10 -0400
X-MC-Unique: APj01Y9IP2mujpffrA2ESQ-1
X-Mimecast-MFC-AGG-ID: APj01Y9IP2mujpffrA2ESQ_1783315508
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D8CD1955F73;
	Mon,  6 Jul 2026 05:25:08 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 094671956096;
	Mon,  6 Jul 2026 05:25:00 +0000 (UTC)
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
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 10/10] xe: create a flag to enable memcg accounting for XE as well.
Date: Mon,  6 Jul 2026 15:22:39 +1000
Message-ID: <20260706052330.1110909-11-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7TLrO-kI1klSpLPfX1A9gEG1yOrPy1FOJ1oLH7z5dT8_1783315508
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17527-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lankhorst.se:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DDF670C982

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
index 62f1da04ca2b..e016f0314d86 100644
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
@@ -181,8 +182,8 @@ static void try_add_system(struct xe_device *xe, struct=
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
@@ -2384,6 +2385,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe,=
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
@@ -3361,7 +3365,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void =
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
index 6340317f7d2e..d38012c60175 100644
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
index a4292a11391d..61aa5033a292 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1661,7 +1661,8 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_=
hw_engine *hwe, struct xe_v
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
 =09bo =3D xe_bo_create_pin_map_novm(xe, tile, bo_size,
 =09=09=09=09       ttm_bo_type_kernel,
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 2dce6a47202c..38d491fa8231 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -910,7 +910,8 @@ static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *s=
tream, size_t size)
=20
 =09bo =3D xe_bo_create_pin_map_novm(stream->oa->xe, stream->gt->tile,
 =09=09=09=09       size, ttm_bo_type_kernel,
-=09=09=09=09       vram | XE_BO_FLAG_GGTT, false);
+=09=09=09=09       vram | XE_BO_FLAG_GGTT | XE_BO_FLAG_ACCOUNTED,
+=09=09=09=09       false);
 =09if (IS_ERR(bo))
 =09=09return PTR_ERR(bo);
=20
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 670bc2206fea..daf346eaa8f5 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -123,7 +123,8 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm, struct xe_=
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
2.54.0


