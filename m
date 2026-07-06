Return-Path: <cgroups+bounces-17511-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fneIMigWS2oWLwEAu9opvQ
	(envelope-from <cgroups+bounces-17511-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:42:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5C70C2D4
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:42:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17511-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17511-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228A83006B01
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC13A9854;
	Mon,  6 Jul 2026 02:42:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0F3A9618
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 02:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305766; cv=none; b=rzK8K/M+Kd+EF/yTkonpdyzN7E2cKtCcr9SbtW48ZB5vLJRHXfw5T5NZ7J0F1TQ/n9KUWABV/4w5Ld2Tp2tYLd+UWPdg9PwU4nmA06stRFu2vlpKy3ijjObz9nLB3rBU5s6rRDcuOvqNEAarVLxBrIV+IdrCuFQrbDM+oSbw72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305766; c=relaxed/simple;
	bh=p1ANNPjuwpQCHzsn6VVjWywCQcuTc6HYbP1bAnA8lCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MikdgqM+8HhdsoOadjdDBqzyrRXSmXstmEiAFjW8BGXMysTYhSn8U0jmP0qDW23jTP3K3wyuq9zS7lCTid95XLEpg+yPtBEZwdJ1YeG+l0A6MaGjQuuF294mXnBJ5Pd7r5XkX2sA9MMXlh4oZ0ATB25aC8UjFkSBY98T8POthn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-PKOUoRp5OH6vp7_ivb1ATw-1; Sun,
 05 Jul 2026 22:42:39 -0400
X-MC-Unique: PKOUoRp5OH6vp7_ivb1ATw-1
X-Mimecast-MFC-AGG-ID: PKOUoRp5OH6vp7_ivb1ATw_1783305758
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DF051955F73;
	Mon,  6 Jul 2026 02:42:38 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 696D23000714;
	Mon,  6 Jul 2026 02:42:30 +0000 (UTC)
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
Subject: [PATCH 08/10] amdgpu: add support for memory cgroups
Date: Mon,  6 Jul 2026 12:36:17 +1000
Message-ID: <20260706024122.853329-9-airlied@gmail.com>
In-Reply-To: <20260706024122.853329-1-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1TLB_Hz9J68heAsyP1mYqJOLBX_GHhzntxK1HrOdKGQ_1783305758
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17511-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60F5C70C2D4

From: Dave Airlie <airlied@redhat.com>

This adds support for adding a obj cgroup to a buffer object,
and passing in the placement flags to make sure it's accounted
properly.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  3 +++
 mm/memcontrol.c                            |  1 +
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index 6a0699746fbc..38f8b3300989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -188,6 +188,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev=
, unsigned long size,
 =09bp.domain =3D initial_domain;
 =09bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
 =09bp.xcp_id_plus1 =3D xcp_id_plus1;
+=09bp.objcg =3D get_obj_cgroup_from_current();
=20
 =09r =3D amdgpu_bo_create_user(adev, &bp, &ubo);
 =09if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index f98bfba59a2c..e4fb1a1d699b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -159,7 +159,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
 =09=09places[c].mem_type =3D
 =09=09=09abo->flags & AMDGPU_GEM_CREATE_PREEMPTIBLE ?
 =09=09=09AMDGPU_PL_PREEMPT : TTM_PL_TT;
-=09=09places[c].flags =3D 0;
+=09=09places[c].flags =3D TTM_PL_FLAG_MEMCG;
 =09=09/*
 =09=09 * When GTT is just an alternative to VRAM make sure that we
 =09=09 * only use it as fallback and still try to fill up VRAM first.
@@ -174,7 +174,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *=
abo, u32 domain)
 =09=09places[c].fpfn =3D 0;
 =09=09places[c].lpfn =3D 0;
 =09=09places[c].mem_type =3D TTM_PL_SYSTEM;
-=09=09places[c].flags =3D 0;
+=09=09places[c].flags =3D TTM_PL_FLAG_MEMCG;
 =09=09c++;
 =09}
=20
@@ -654,16 +654,21 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 =09=09size =3D ALIGN(size, PAGE_SIZE);
 =09}
=20
-=09if (!amdgpu_bo_validate_size(adev, size, bp->domain))
+=09if (!amdgpu_bo_validate_size(adev, size, bp->domain)) {
+=09=09obj_cgroup_put(bp->objcg);
 =09=09return -ENOMEM;
+=09}
=20
 =09BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
=20
 =09*bo_ptr =3D NULL;
 =09bo =3D kvzalloc(bp->bo_ptr_size, GFP_KERNEL);
-=09if (bo =3D=3D NULL)
+=09if (bo =3D=3D NULL) {
+=09=09obj_cgroup_put(bp->objcg);
 =09=09return -ENOMEM;
+=09}
 =09drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
+=09ttm_bo_set_cgroup(&bo->tbo, bp->objcg); /* hand the reference to the tt=
m bo */
 =09bo->tbo.base.funcs =3D &amdgpu_gem_object_funcs;
 =09bo->vm_bo =3D NULL;
 =09bo->preferred_domains =3D bp->preferred_domain ? bp->preferred_domain :
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 4d68732d6223..1bc757e14292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -55,6 +55,7 @@ struct amdgpu_bo_param {
 =09enum ttm_bo_type=09=09type;
 =09bool=09=09=09=09no_wait_gpu;
 =09struct dma_resv=09=09=09*resv;
+=09struct obj_cgroup               *objcg;
 =09void=09=09=09=09(*destroy)(struct ttm_buffer_object *bo);
 =09/* xcp partition number plus 1, 0 means any partition */
 =09int8_t=09=09=09=09xcp_id_plus1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 8062b3d61157..1c8123c564ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -155,11 +155,14 @@ static void amdgpu_evict_flags(struct ttm_buffer_obje=
ct *bo,
 =09=09=09amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT |
 =09=09=09=09=09=09=09AMDGPU_GEM_DOMAIN_CPU);
 =09=09}
+=09=09for (int i =3D 0; i < abo->placement.num_placement; i++)
+=09=09=09abo->placements[i].flags &=3D ~TTM_PL_FLAG_MEMCG;
 =09=09break;
 =09case TTM_PL_TT:
 =09case AMDGPU_PL_PREEMPT:
 =09default:
 =09=09amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
+=09=09abo->placements[0].flags &=3D ~TTM_PL_FLAG_MEMCG;
 =09=09break;
 =09}
 =09*placement =3D abo->placement;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4c682b91cbbe..625de4a287eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3032,6 +3032,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup=
(void)
=20
 =09return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 }
+EXPORT_SYMBOL_GPL(current_obj_cgroup);
=20
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
--=20
2.54.0


