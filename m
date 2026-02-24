Return-Path: <cgroups+bounces-14190-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIv/MaIInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14190-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:10:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42E180E7E
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1951F3033F99
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AC244687;
	Tue, 24 Feb 2026 02:10:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168535695
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899039; cv=none; b=Ozeel3P9rgIux+BCOq5Xk9VxrGJpDTSir34qNIWcADq1gjL7Qr9Mg3XCqhqicCcaIrku6ysQLZKxqz8lZ+Ei51M4m9pQ/FiXSSd9q+fZ/lyjCl3YKoY8+5LGLqXSNSG72vlas9gXCd8tiG1u+DDJyTBoyv6KXxBdNWdHSXa9wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899039; c=relaxed/simple;
	bh=zFe4rYyrw+FSqt16rgCOIg7vdskyKdIJ5BLi2l49Kig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvJ6TSTmxgDlAgOtzSmAsO/C/WpO6oldBMYJok4azoy9VbRbvScHBxRFtrXHw3LBN6NqELy43PQpiMLiQgV1ISgivKYfFLDGiJGNlEwB2QuzftCARenkuWtCpZIOpaUJrDwh7ZbLHvj9kohc+KoHMczIhvSebPm11iNkvvyKg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-8Gk0eZVuMs6KYWhaz1-FZA-1; Mon,
 23 Feb 2026 21:10:35 -0500
X-MC-Unique: 8Gk0eZVuMs6KYWhaz1-FZA-1
X-Mimecast-MFC-AGG-ID: 8Gk0eZVuMs6KYWhaz1-FZA_1771899034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 294ED1955F24;
	Tue, 24 Feb 2026 02:10:34 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBF3B30001BB;
	Tue, 24 Feb 2026 02:10:27 +0000 (UTC)
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
Subject: [PATCH 12/16] ttm: hook up memcg placement flags.
Date: Tue, 24 Feb 2026 12:06:29 +1000
Message-ID: <20260224020854.791201-13-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: x4KIVrEfeYY2NRyL4E0HP0Oee7wmJotnZDpGEec6zog_1771899034
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-14190-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 5D42E180E7E
X-Rspamd-Action: no action

From: Dave Airlie <airlied@redhat.com>

This adds a placement flag that requests that any bo with this
placement flag set gets accounted for memcg if it's a system memory
allocation.

Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c      | 4 ++--
 drivers/gpu/drm/ttm/ttm_bo_util.c | 6 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c   | 2 +-
 drivers/gpu/drm/xe/xe_bo.c        | 2 +-
 include/drm/ttm/ttm_placement.h   | 3 +++
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 4234bf7f1110..52f73a2ea971 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -145,7 +145,7 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_obj=
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
@@ -1301,7 +1301,7 @@ int ttm_bo_setup_export(struct ttm_buffer_object *bo,
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
index 1502515043c0..a67818c4143d 100644
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
@@ -352,7 +352,7 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo=
,
=20
 =09BUG_ON(!ttm);
=20
-=09ret =3D ttm_bo_populate(bo, false, &ctx);
+=09ret =3D ttm_bo_populate(bo, mem->placement & TTM_PL_FLAG_MEMCG, &ctx);
 =09if (ret)
 =09=09return ret;
=20
@@ -533,7 +533,7 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct io=
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
index 9cb4344c93df..fae2d738ecd2 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1810,7 +1810,7 @@ static int xe_bo_fault_migrate(struct xe_bo *bo, stru=
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
index b510a4812609..4e9f07d70483 100644
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
2.52.0


