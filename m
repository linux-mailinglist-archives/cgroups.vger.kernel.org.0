Return-Path: <cgroups+bounces-17523-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SZDwARw8S2oVOAEAu9opvQ
	(envelope-from <cgroups+bounces-17523-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593270C93B
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17523-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17523-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83CE33005AB7
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 05:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026933AF665;
	Mon,  6 Jul 2026 05:24:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB993AFCED
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 05:24:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315481; cv=none; b=PLZ0/lHVVilAB+KkV6lOFl+5cAlAax+qJo8E7go8E8J7CCLeVGdWUsEmc9sF/OvORHHCeNAncx14YZ+4bT2Pir06cvRZctfev+ppYX+PjKMk8PWu70fj6xQtzEkFZg4ixP8WwrBvuX5CvuGZvemxyngOT5Iie5HMrBL7mJvXnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315481; c=relaxed/simple;
	bh=uL152Z9Hu91B24j7nyVI9Y8irQZt/lLJOyVhbJxLXwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TKR597H97zaA1NiA2606oJSg91TsupS13ToWCTS3XyW2SDoDM/GMbPfNWIwuA3rqixHGp52rhh4M51goMT5yPrD1UVihaKw5hpEG7jiML1TDY6DZljswIDRzcuI8QELce+yP85G3GJ9zk4RdS7elO5PBkbuDG8yA67hal2IHYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-SJzZ-BEoPUa0rT7XMiSAUg-1; Mon,
 06 Jul 2026 01:24:37 -0400
X-MC-Unique: SJzZ-BEoPUa0rT7XMiSAUg-1
X-Mimecast-MFC-AGG-ID: SJzZ-BEoPUa0rT7XMiSAUg_1783315475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A8C81955F73;
	Mon,  6 Jul 2026 05:24:35 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5D27195609F;
	Mon,  6 Jul 2026 05:24:27 +0000 (UTC)
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
Subject: [PATCH 06/10] ttm: hook up memcg placement flags.
Date: Mon,  6 Jul 2026 15:22:35 +1000
Message-ID: <20260706052330.1110909-7-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: uZRwsTtb9pvXkDJVnOfunGieK0wHk4E0kvwSB7INK2s_1783315475
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17523-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9593270C93B

From: Dave Airlie <airlied@redhat.com>

This adds a placement flag that requests that any bo with this
placement flag set gets accounted for memcg if it's a system memory
allocation.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c      | 4 ++--
 drivers/gpu/drm/ttm/ttm_bo_util.c | 6 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c   | 2 +-
 drivers/gpu/drm/xe/xe_bo.c        | 2 +-
 include/drm/ttm/ttm_placement.h   | 3 +++
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8e38c6c5c82e..54ee9d4e7a13 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -146,7 +146,7 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_obj=
ect *bo,
 =09=09=09goto out_err;
=20
 =09=09if (mem->mem_type !=3D TTM_PL_SYSTEM) {
-=09=09=09ret =3D ttm_bo_populate(bo, false, ctx);
+=09=09=09ret =3D ttm_bo_populate(bo, mem->placement & TTM_PL_FLAG_MEMCG, c=
tx);
 =09=09=09if (ret)
 =09=09=09=09goto out_err;
 =09=09}
@@ -1296,7 +1296,7 @@ int ttm_bo_setup_export(struct ttm_buffer_object *bo,
 =09if (ret !=3D 0)
 =09=09return ret;
=20
-=09ret =3D ttm_bo_populate(bo, false, ctx);
+=09ret =3D ttm_bo_populate(bo, bo->resource->placement & TTM_PL_FLAG_MEMCG=
, ctx);
 =09ttm_bo_unreserve(bo);
 =09return ret;
 }
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo=
_util.c
index 07e58f6dd461..1846c7cfa168 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -167,7 +167,7 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
 =09src_man =3D ttm_manager_type(bdev, src_mem->mem_type);
 =09if (ttm && ((ttm->page_flags & TTM_TT_FLAG_SWAPPED) ||
 =09=09    dst_man->use_tt)) {
-=09=09ret =3D ttm_bo_populate(bo, false, ctx);
+=09=09ret =3D ttm_bo_populate(bo, dst_mem->placement & TTM_PL_FLAG_MEMCG, =
ctx);
 =09=09if (ret)
 =09=09=09return ret;
 =09}
@@ -354,7 +354,7 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo=
,
=20
 =09BUG_ON(!ttm);
=20
-=09ret =3D ttm_bo_populate(bo, false, &ctx);
+=09ret =3D ttm_bo_populate(bo, mem->placement & TTM_PL_FLAG_MEMCG, &ctx);
 =09if (ret)
 =09=09return ret;
=20
@@ -535,7 +535,7 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct io=
sys_map *map)
 =09=09pgprot_t prot;
 =09=09void *vaddr;
=20
-=09=09ret =3D ttm_bo_populate(bo, false, &ctx);
+=09=09ret =3D ttm_bo_populate(bo, mem->placement & TTM_PL_FLAG_MEMCG, &ctx=
);
 =09=09if (ret)
 =09=09=09return ret;
=20
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_v=
m.c
index 2e59836b6085..98cf8f83220f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -225,7 +225,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vm=
f,
=20
 =09=09ttm =3D bo->ttm;
 =09=09err =3D ttm_bo_populate(bo,
-=09=09=09=09      false,
+=09=09=09=09      bo->resource->placement & TTM_PL_FLAG_MEMCG,
 =09=09=09=09      &ctx);
 =09=09if (err) {
 =09=09=09if (err =3D=3D -EINTR || err =3D=3D -ERESTARTSYS ||
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 20a10a174d1d..62f1da04ca2b 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1927,7 +1927,7 @@ static int xe_bo_fault_migrate(struct xe_bo *bo, stru=
ct ttm_operation_ctx *ctx,
 =09if (ttm_manager_type(tbo->bdev, tbo->resource->mem_type)->use_tt) {
 =09=09err =3D xe_bo_wait_usage_kernel(bo, ctx);
 =09=09if (!err)
-=09=09=09err =3D ttm_bo_populate(&bo->ttm, false, ctx);
+=09=09=09err =3D ttm_bo_populate(&bo->ttm, tbo->resource->placement & TTM_=
PL_FLAG_MEMCG, ctx);
 =09} else if (should_migrate_to_smem(bo)) {
 =09=09xe_assert(xe_bo_device(bo), bo->flags & XE_BO_FLAG_SYSTEM);
 =09=09err =3D xe_bo_migrate(bo, XE_PL_TT, ctx, exec);
diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placemen=
t.h
index ab2639e42c54..3db7f9b7e9da 100644
--- a/include/drm/ttm/ttm_placement.h
+++ b/include/drm/ttm/ttm_placement.h
@@ -70,6 +70,9 @@
 /* Placement is only used during eviction */
 #define TTM_PL_FLAG_FALLBACK=09(1 << 4)
=20
+/* Placement should account mem cgroup */
+#define TTM_PL_FLAG_MEMCG=09(1 << 5)
+
 /**
  * struct ttm_place
  *
--=20
2.54.0


