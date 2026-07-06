Return-Path: <cgroups+bounces-17519-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQbJFAM8S2oCOAEAu9opvQ
	(envelope-from <cgroups+bounces-17519-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7970C91E
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 07:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17519-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17519-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1C230146A0
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223A3812F2;
	Mon,  6 Jul 2026 05:24:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC893B2D0F
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 05:24:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315452; cv=none; b=WQwuRXUB8e7MHpuD7zhLTW70LpcDpT4gcIxj5z3D/RTJ8Hda4eTzeKFGvLvjwLlioPxmoxNoSfMQUpPMT52xiQraiwde1wLaibeIUpAbBxPER5eDVkhemW8aDySPvv+Zts707UEEhSCQaRUzU/8F18pEHbmP29pm3kOMtMP4lVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315452; c=relaxed/simple;
	bh=LZdNd8pi+XD85RkPr76tMChJAYd65U4XM0L2yJJCR1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tV3g+UA5vvpcwwZi7ydj7Vnq0kQpXfREu3Z2ZEXIXYO1Yyh+tlwQRlvoMdBHZ63beYeBFqkdC2bZg+AQ0NJ0UgUjoR1mWPSx8EmmpX1fff5uE/FB282E6KZy1h7goQOSZtEQicxi3n2sM2/zbkeEO/XNl9+qm7l8sxCfNF7VjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-lvbqzOfQNs-JJx7mGVsmMQ-1; Mon,
 06 Jul 2026 01:24:04 -0400
X-MC-Unique: lvbqzOfQNs-JJx7mGVsmMQ-1
X-Mimecast-MFC-AGG-ID: lvbqzOfQNs-JJx7mGVsmMQ_1783315442
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F5F1955F04;
	Mon,  6 Jul 2026 05:24:01 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D4121956096;
	Mon,  6 Jul 2026 05:23:52 +0000 (UTC)
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
Subject: [PATCH 02/10] ttm: add a memcg accounting flag to the alloc/populate APIs
Date: Mon,  6 Jul 2026 15:22:31 +1000
Message-ID: <20260706052330.1110909-3-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: EbKpyMgwB740DxZwVaddm7j2HZ7gzLS64BBvfnyuXcA_1783315442
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17519-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3C7970C91E

From: Dave Airlie <airlied@redhat.com>

This flag does nothing yet, but this just changes the APIs to accept
it in the future across all users.

This flag will eventually be filled out with when to account a tt
populate to a memcg.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  3 ++-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  5 +++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c     |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c       |  4 ++--
 drivers/gpu/drm/loongson/lsdc_ttm.c              |  3 ++-
 drivers/gpu/drm/nouveau/nouveau_bo.c             |  6 ++++--
 drivers/gpu/drm/radeon/radeon_ttm.c              |  3 ++-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c        | 16 ++++++++--------
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c          | 12 ++++++------
 drivers/gpu/drm/ttm/ttm_bo.c                     |  7 ++++---
 drivers/gpu/drm/ttm/ttm_bo_util.c                |  6 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c                  |  4 +++-
 drivers/gpu/drm/ttm/ttm_pool.c                   |  6 ++++--
 drivers/gpu/drm/ttm/ttm_tt.c                     |  8 +++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c             |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c       |  7 ++++---
 drivers/gpu/drm/xe/xe_bo.c                       |  5 +++--
 include/drm/ttm/ttm_bo.h                         |  1 +
 include/drm/ttm/ttm_device.h                     |  1 +
 include/drm/ttm/ttm_pool.h                       |  1 +
 include/drm/ttm/ttm_tt.h                         |  1 +
 22 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 025625e7e800..8062b3d61157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1220,6 +1220,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm=
_buffer_object *bo,
  */
 static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 =09=09=09=09  struct ttm_tt *ttm,
+=09=09=09=09  bool memcg_account,
 =09=09=09=09  struct ttm_operation_ctx *ctx)
 {
 =09struct amdgpu_device *adev =3D amdgpu_ttm_adev(bdev);
@@ -1243,7 +1244,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *=
bdev,
 =09=09pool =3D &adev->mman.ttm_pools[gtt->pool_id];
 =09else
 =09=09pool =3D &adev->mman.bdev.pool;
-=09ret =3D ttm_pool_alloc(pool, ttm, ctx);
+=09ret =3D ttm_pool_alloc(pool, ttm, memcg_account, ctx);
 =09if (ret)
 =09=09return ret;
=20
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915=
/gem/i915_gem_ttm.c
index df3fcc2b1248..d45ccede78a4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -317,6 +317,7 @@ static struct ttm_tt *i915_ttm_tt_create(struct ttm_buf=
fer_object *bo,
=20
 static int i915_ttm_tt_populate(struct ttm_device *bdev,
 =09=09=09=09struct ttm_tt *ttm,
+=09=09=09=09bool memcg_account,
 =09=09=09=09struct ttm_operation_ctx *ctx)
 {
 =09struct i915_ttm_tt *i915_tt =3D container_of(ttm, typeof(*i915_tt), ttm=
);
@@ -324,7 +325,7 @@ static int i915_ttm_tt_populate(struct ttm_device *bdev=
,
 =09if (i915_tt->is_shmem)
 =09=09return i915_ttm_tt_shmem_populate(bdev, ttm, ctx);
=20
-=09return ttm_pool_alloc(&bdev->pool, ttm, ctx);
+=09return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
 }
=20
 static void i915_ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt =
*ttm)
@@ -815,7 +816,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_obj=
ect *obj,
 =09}
=20
 =09if (bo->ttm && !ttm_tt_is_populated(bo->ttm)) {
-=09=09ret =3D ttm_bo_populate(bo, &ctx);
+=09=09ret =3D ttm_bo_populate(bo, false, &ctx);
 =09=09if (ret)
 =09=09=09return ret;
=20
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm=
/i915/gem/i915_gem_ttm_move.c
index 56489cc127d6..b81c9df2d7eb 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -624,7 +624,7 @@ int i915_ttm_move(struct ttm_buffer_object *bo, bool ev=
ict,
=20
 =09/* Populate ttm with pages if needed. Typically system memory. */
 =09if (ttm && (dst_man->use_tt || (ttm->page_flags & TTM_TT_FLAG_SWAPPED))=
) {
-=09=09ret =3D ttm_bo_populate(bo, ctx);
+=09=09ret =3D ttm_bo_populate(bo, false, ctx);
 =09=09if (ret)
 =09=09=09return ret;
 =09}
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c b/drivers/gpu/drm/i=
915/gem/i915_gem_ttm_pm.c
index 4824f948daed..d951e58f78ea 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c
@@ -91,7 +91,7 @@ static int i915_ttm_backup(struct i915_gem_apply_to_regio=
n *apply,
 =09=09goto out_no_lock;
=20
 =09backup_bo =3D i915_gem_to_ttm(backup);
-=09err =3D ttm_bo_populate(backup_bo, &ctx);
+=09err =3D ttm_bo_populate(backup_bo, false, &ctx);
 =09if (err)
 =09=09goto out_no_populate;
=20
@@ -190,7 +190,7 @@ static int i915_ttm_restore(struct i915_gem_apply_to_re=
gion *apply,
 =09if (!backup_bo->resource)
 =09=09err =3D ttm_bo_validate(backup_bo, i915_ttm_sys_placement(), &ctx);
 =09if (!err)
-=09=09err =3D ttm_bo_populate(backup_bo, &ctx);
+=09=09err =3D ttm_bo_populate(backup_bo, false, &ctx);
 =09if (!err) {
 =09=09err =3D i915_gem_obj_copy_ttm(obj, backup, pm_apply->allow_gpu,
 =09=09=09=09=09    false);
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson=
/lsdc_ttm.c
index d7441d96a0dc..bfb5f1b1ec91 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -111,6 +111,7 @@ lsdc_ttm_tt_create(struct ttm_buffer_object *tbo, uint3=
2_t page_flags)
=20
 static int lsdc_ttm_tt_populate(struct ttm_device *bdev,
 =09=09=09=09struct ttm_tt *ttm,
+=09=09=09=09bool memcg_account,
 =09=09=09=09struct ttm_operation_ctx *ctx)
 {
 =09bool slave =3D !!(ttm->page_flags & TTM_TT_FLAG_EXTERNAL);
@@ -123,7 +124,7 @@ static int lsdc_ttm_tt_populate(struct ttm_device *bdev=
,
 =09=09return 0;
 =09}
=20
-=09return ttm_pool_alloc(&bdev->pool, ttm, ctx);
+=09return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
 }
=20
 static void lsdc_ttm_tt_unpopulate(struct ttm_device *bdev,
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau=
/nouveau_bo.c
index 0e8de6d4b36f..a38c19f1d6dc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1417,7 +1417,9 @@ vm_fault_t nouveau_ttm_fault_reserve_notify(struct tt=
m_buffer_object *bo)
=20
 static int
 nouveau_ttm_tt_populate(struct ttm_device *bdev,
-=09=09=09struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
+=09=09=09struct ttm_tt *ttm,
+=09=09=09bool memcg_account,
+=09=09=09struct ttm_operation_ctx *ctx)
 {
 =09struct ttm_tt *ttm_dma =3D (void *)ttm;
 =09struct nouveau_drm *drm;
@@ -1434,7 +1436,7 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
=20
 =09drm =3D nouveau_bdev(bdev);
=20
-=09return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
+=09return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, memcg_account, ctx);
 }
=20
 static void
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/r=
adeon_ttm.c
index e7ab8162ac69..98b09463abc2 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -526,6 +526,7 @@ static struct radeon_ttm_tt *radeon_ttm_tt_to_gtt(struc=
t radeon_device *rdev,
=20
 static int radeon_ttm_tt_populate(struct ttm_device *bdev,
 =09=09=09=09  struct ttm_tt *ttm,
+=09=09=09=09  bool memcg_account,
 =09=09=09=09  struct ttm_operation_ctx *ctx)
 {
 =09struct radeon_device *rdev =3D radeon_get_rdev(bdev);
@@ -547,7 +548,7 @@ static int radeon_ttm_tt_populate(struct ttm_device *bd=
ev,
 =09=09return 0;
 =09}
=20
-=09return ttm_pool_alloc(&rdev->mman.bdev.pool, ttm, ctx);
+=09return ttm_pool_alloc(&rdev->mman.bdev.pool, ttm, memcg_account, ctx);
 }
=20
 static void radeon_ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_t=
t *ttm)
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu=
/drm/ttm/tests/ttm_bo_validate_test.c
index 2db221f6fc3a..0cbf732eebf3 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -538,7 +538,7 @@ static void ttm_bo_validate_no_placement_signaled(struc=
t kunit *test)
=20
 =09if (params->with_ttm) {
 =09=09old_tt =3D priv->ttm_dev->funcs->ttm_tt_create(bo, 0);
-=09=09ttm_pool_alloc(&priv->ttm_dev->pool, old_tt, &ctx);
+=09=09ttm_pool_alloc(&priv->ttm_dev->pool, old_tt, false, &ctx);
 =09=09bo->ttm =3D old_tt;
 =09}
=20
diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/tt=
m/tests/ttm_pool_test.c
index be75c8abf388..af235d64b970 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -89,7 +89,7 @@ static struct ttm_pool *ttm_pool_pre_populated(struct kun=
it *test,
=20
 =09ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DM=
A_ALLOC);
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
 =09ttm_pool_free(pool, tt);
@@ -157,7 +157,7 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 =09KUNIT_ASSERT_EQ(test, pool->nid, NUMA_NO_NODE);
 =09KUNIT_ASSERT_EQ(test, pool->alloc_flags, params->alloc_flags);
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
 =09KUNIT_ASSERT_EQ(test, tt->num_pages, expected_num_pages);
=20
@@ -220,7 +220,7 @@ static void ttm_pool_alloc_basic_dma_addr(struct kunit =
*test)
=20
 =09ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DM=
A_ALLOC);
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
 =09KUNIT_ASSERT_EQ(test, tt->num_pages, expected_num_pages);
=20
@@ -253,7 +253,7 @@ static void ttm_pool_alloc_order_caching_match(struct k=
unit *test)
 =09tt =3D ttm_tt_kunit_init(test, 0, caching, size);
 =09KUNIT_ASSERT_NOT_NULL(test, tt);
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
 =09KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
@@ -285,7 +285,7 @@ static void ttm_pool_alloc_caching_mismatch(struct kuni=
t *test)
 =09KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt_pool->pages));
 =09KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt_tt->pages));
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
 =09ttm_pool_free(pool, tt);
@@ -319,7 +319,7 @@ static void ttm_pool_alloc_order_mismatch(struct kunit =
*test)
 =09KUNIT_ASSERT_FALSE(test, !list_lru_count(&pt_pool->pages));
 =09KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt_tt->pages));
=20
-=09err =3D ttm_pool_alloc(pool, tt, &simple_ctx);
+=09err =3D ttm_pool_alloc(pool, tt, false, &simple_ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
 =09ttm_pool_free(pool, tt);
@@ -349,7 +349,7 @@ static void ttm_pool_free_dma_alloc(struct kunit *test)
 =09KUNIT_ASSERT_NOT_NULL(test, pool);
=20
 =09ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, TTM_ALLOCATION_POOL_USE_DM=
A_ALLOC);
-=09ttm_pool_alloc(pool, tt, &simple_ctx);
+=09ttm_pool_alloc(pool, tt, false, &simple_ctx);
=20
 =09pt =3D &pool->caching[caching].orders[order];
 =09KUNIT_ASSERT_TRUE(test, !list_lru_count(&pt->pages));
@@ -379,7 +379,7 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *te=
st)
 =09KUNIT_ASSERT_NOT_NULL(test, pool);
=20
 =09ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, 0);
-=09ttm_pool_alloc(pool, tt, &simple_ctx);
+=09ttm_pool_alloc(pool, tt, false, &simple_ctx);
=20
 =09ttm_pool_free(pool, tt);
 =09ttm_tt_fini(tt);
diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/=
tests/ttm_tt_test.c
index bd5f7d0b9b62..dfa38bbfd829 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
@@ -262,7 +262,7 @@ static void ttm_tt_populate_null_ttm(struct kunit *test=
)
 =09struct ttm_operation_ctx ctx =3D { };
 =09int err;
=20
-=09err =3D ttm_tt_populate(devs->ttm_dev, NULL, &ctx);
+=09err =3D ttm_tt_populate(devs->ttm_dev, NULL, false, &ctx);
 =09KUNIT_ASSERT_EQ(test, err, -EINVAL);
 }
=20
@@ -283,11 +283,11 @@ static void ttm_tt_populate_populated_ttm(struct kuni=
t *test)
 =09err =3D ttm_tt_init(tt, bo, 0, ttm_cached, 0);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
-=09err =3D ttm_tt_populate(devs->ttm_dev, tt, &ctx);
+=09err =3D ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
 =09populated_page =3D *tt->pages;
=20
-=09err =3D ttm_tt_populate(devs->ttm_dev, tt, &ctx);
+=09err =3D ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
 =09KUNIT_ASSERT_PTR_EQ(test, populated_page, *tt->pages);
 }
=20
@@ -307,7 +307,7 @@ static void ttm_tt_unpopulate_basic(struct kunit *test)
 =09err =3D ttm_tt_init(tt, bo, 0, ttm_cached, 0);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
-=09err =3D ttm_tt_populate(devs->ttm_dev, tt, &ctx);
+=09err =3D ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
 =09KUNIT_ASSERT_TRUE(test, ttm_tt_is_populated(tt));
=20
@@ -351,7 +351,7 @@ static void ttm_tt_swapin_basic(struct kunit *test)
 =09err =3D ttm_tt_init(tt, bo, 0, ttm_cached, 0);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
-=09err =3D ttm_tt_populate(devs->ttm_dev, tt, &ctx);
+=09err =3D ttm_tt_populate(devs->ttm_dev, tt, false, &ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
 =09KUNIT_ASSERT_TRUE(test, ttm_tt_is_populated(tt));
=20
@@ -361,7 +361,7 @@ static void ttm_tt_swapin_basic(struct kunit *test)
 =09KUNIT_ASSERT_TRUE(test, tt->page_flags & TTM_TT_FLAG_SWAPPED);
=20
 =09/* Swapout depopulates TT, allocate pages and then swap them in */
-=09err =3D ttm_pool_alloc(&devs->ttm_dev->pool, tt, &ctx);
+=09err =3D ttm_pool_alloc(&devs->ttm_dev->pool, tt, false, &ctx);
 =09KUNIT_ASSERT_EQ(test, err, 0);
=20
 =09err =3D ttm_tt_swapin(tt);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6bb7f0..cf4ab2b5521a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -145,7 +145,7 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_obj=
ect *bo,
 =09=09=09goto out_err;
=20
 =09=09if (mem->mem_type !=3D TTM_PL_SYSTEM) {
-=09=09=09ret =3D ttm_bo_populate(bo, ctx);
+=09=09=09ret =3D ttm_bo_populate(bo, false, ctx);
 =09=09=09if (ret)
 =09=09=09=09goto out_err;
 =09=09}
@@ -1255,6 +1255,7 @@ void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
  * is set to true.
  */
 int ttm_bo_populate(struct ttm_buffer_object *bo,
+=09=09    bool memcg_account,
 =09=09    struct ttm_operation_ctx *ctx)
 {
 =09struct ttm_device *bdev =3D bo->bdev;
@@ -1268,7 +1269,7 @@ int ttm_bo_populate(struct ttm_buffer_object *bo,
 =09=09return 0;
=20
 =09swapped =3D ttm_tt_is_swapped(tt);
-=09ret =3D ttm_tt_populate(bdev, tt, ctx);
+=09ret =3D ttm_tt_populate(bdev, tt, memcg_account, ctx);
 =09if (ret)
 =09=09return ret;
=20
@@ -1293,7 +1294,7 @@ int ttm_bo_setup_export(struct ttm_buffer_object *bo,
 =09if (ret !=3D 0)
 =09=09return ret;
=20
-=09ret =3D ttm_bo_populate(bo, ctx);
+=09ret =3D ttm_bo_populate(bo, false, ctx);
 =09ttm_bo_unreserve(bo);
 =09return ret;
 }
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo=
_util.c
index 3e3c201a0222..62dad6c05dff 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -167,7 +167,7 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
 =09src_man =3D ttm_manager_type(bdev, src_mem->mem_type);
 =09if (ttm && ((ttm->page_flags & TTM_TT_FLAG_SWAPPED) ||
 =09=09    dst_man->use_tt)) {
-=09=09ret =3D ttm_bo_populate(bo, ctx);
+=09=09ret =3D ttm_bo_populate(bo, false, ctx);
 =09=09if (ret)
 =09=09=09return ret;
 =09}
@@ -352,7 +352,7 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo=
,
=20
 =09BUG_ON(!ttm);
=20
-=09ret =3D ttm_bo_populate(bo, &ctx);
+=09ret =3D ttm_bo_populate(bo, false, &ctx);
 =09if (ret)
 =09=09return ret;
=20
@@ -533,7 +533,7 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct io=
sys_map *map)
 =09=09pgprot_t prot;
 =09=09void *vaddr;
=20
-=09=09ret =3D ttm_bo_populate(bo, &ctx);
+=09=09ret =3D ttm_bo_populate(bo, false, &ctx);
 =09=09if (ret)
 =09=09=09return ret;
=20
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_v=
m.c
index a80510489c45..2e59836b6085 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -224,7 +224,9 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vm=
f,
 =09=09};
=20
 =09=09ttm =3D bo->ttm;
-=09=09err =3D ttm_bo_populate(bo, &ctx);
+=09=09err =3D ttm_bo_populate(bo,
+=09=09=09=09      false,
+=09=09=09=09      &ctx);
 =09=09if (err) {
 =09=09=09if (err =3D=3D -EINTR || err =3D=3D -ERESTARTSYS ||
 =09=09=09    err =3D=3D -EAGAIN)
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index 278bbe7a11ad..e4dbf4c93091 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -761,6 +761,7 @@ static unsigned int ttm_pool_alloc_find_order(unsigned =
int highest,
 }
=20
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
+=09=09=09    bool memcg_account,
 =09=09=09    const struct ttm_operation_ctx *ctx,
 =09=09=09    struct ttm_pool_alloc_state *alloc,
 =09=09=09    struct ttm_pool_tt_restore *restore)
@@ -871,6 +872,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
  * Returns: 0 on successe, negative error code otherwise.
  */
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
+=09=09   bool memcg_account,
 =09=09   struct ttm_operation_ctx *ctx)
 {
 =09struct ttm_pool_alloc_state alloc;
@@ -880,7 +882,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt=
 *tt,
=20
 =09ttm_pool_alloc_state_init(tt, &alloc);
=20
-=09return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
+=09return __ttm_pool_alloc(pool, tt, memcg_account, ctx, &alloc, NULL);
 }
 EXPORT_SYMBOL(ttm_pool_alloc);
=20
@@ -935,7 +937,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, s=
truct ttm_tt *tt,
 =09=09=09return 0;
 =09}
=20
-=09return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
+=09return __ttm_pool_alloc(pool, tt, false, ctx, &alloc, restore);
 }
=20
 /**
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..aa0f17fca770 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -368,7 +368,9 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_=
tt *ttm,
 EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_swapout);
=20
 int ttm_tt_populate(struct ttm_device *bdev,
-=09=09    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
+=09=09    struct ttm_tt *ttm,
+=09=09    bool memcg_account,
+=09=09    struct ttm_operation_ctx *ctx)
 {
 =09int ret;
=20
@@ -397,9 +399,9 @@ int ttm_tt_populate(struct ttm_device *bdev,
 =09}
=20
 =09if (bdev->funcs->ttm_tt_populate)
-=09=09ret =3D bdev->funcs->ttm_tt_populate(bdev, ttm, ctx);
+=09=09ret =3D bdev->funcs->ttm_tt_populate(bdev, ttm, memcg_account, ctx);
 =09else
-=09=09ret =3D ttm_pool_alloc(&bdev->pool, ttm, ctx);
+=09=09ret =3D ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
 =09if (ret)
 =09=09goto error;
=20
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_blit.c
index 135b75a3e013..baa1c3fdb12c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -569,13 +569,13 @@ int vmw_bo_cpu_blit(struct vmw_bo *vmw_dst,
 =09=09dma_resv_assert_held(src->base.resv);
=20
 =09if (!ttm_tt_is_populated(dst->ttm)) {
-=09=09ret =3D dst->bdev->funcs->ttm_tt_populate(dst->bdev, dst->ttm, &ctx)=
;
+=09=09ret =3D dst->bdev->funcs->ttm_tt_populate(dst->bdev, dst->ttm, false=
, &ctx);
 =09=09if (ret)
 =09=09=09return ret;
 =09}
=20
 =09if (!ttm_tt_is_populated(src->ttm)) {
-=09=09ret =3D src->bdev->funcs->ttm_tt_populate(src->bdev, src->ttm, &ctx)=
;
+=09=09ret =3D src->bdev->funcs->ttm_tt_populate(src->bdev, src->ttm, false=
, &ctx);
 =09=09if (ret)
 =09=09=09return ret;
 =09}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/v=
mwgfx/vmwgfx_ttm_buffer.c
index dfd08ee19041..368701756119 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -360,7 +360,8 @@ static void vmw_ttm_destroy(struct ttm_device *bdev, st=
ruct ttm_tt *ttm)
=20
=20
 static int vmw_ttm_populate(struct ttm_device *bdev,
-=09=09=09    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
+=09=09=09    struct ttm_tt *ttm, bool memcg_account,
+=09=09=09    struct ttm_operation_ctx *ctx)
 {
 =09bool external =3D (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) !=3D 0;
=20
@@ -372,7 +373,7 @@ static int vmw_ttm_populate(struct ttm_device *bdev,
 =09=09=09=09=09=09       ttm->dma_address,
 =09=09=09=09=09=09       ttm->num_pages);
=20
-=09return ttm_pool_alloc(&bdev->pool, ttm, ctx);
+=09return ttm_pool_alloc(&bdev->pool, ttm, memcg_account, ctx);
 }
=20
 static void vmw_ttm_unpopulate(struct ttm_device *bdev,
@@ -580,7 +581,7 @@ int vmw_bo_create_and_populate(struct vmw_private *dev_=
priv,
 =09if (unlikely(ret !=3D 0))
 =09=09return ret;
=20
-=09ret =3D vmw_ttm_populate(vbo->tbo.bdev, vbo->tbo.ttm, &ctx);
+=09ret =3D vmw_ttm_populate(vbo->tbo.bdev, vbo->tbo.ttm, false, &ctx);
 =09if (likely(ret =3D=3D 0)) {
 =09=09struct vmw_ttm_tt *vmw_tt =3D
 =09=09=09container_of(vbo->tbo.ttm, struct vmw_ttm_tt, dma_ttm);
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4c80bac67622..20a10a174d1d 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -536,6 +536,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffe=
r_object *ttm_bo,
 }
=20
 static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *t=
t,
+=09=09=09      bool memcg_account,
 =09=09=09      struct ttm_operation_ctx *ctx)
 {
 =09struct xe_ttm_tt *xe_tt =3D container_of(tt, struct xe_ttm_tt, ttm);
@@ -553,7 +554,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_de=
v, struct ttm_tt *tt,
 =09=09err =3D ttm_tt_restore(ttm_dev, tt, ctx);
 =09} else {
 =09=09ttm_tt_clear_backed_up(tt);
-=09=09err =3D ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
+=09=09err =3D ttm_pool_alloc(&ttm_dev->pool, tt, memcg_account, ctx);
 =09}
 =09if (err)
 =09=09return err;
@@ -1926,7 +1927,7 @@ static int xe_bo_fault_migrate(struct xe_bo *bo, stru=
ct ttm_operation_ctx *ctx,
 =09if (ttm_manager_type(tbo->bdev, tbo->resource->mem_type)->use_tt) {
 =09=09err =3D xe_bo_wait_usage_kernel(bo, ctx);
 =09=09if (!err)
-=09=09=09err =3D ttm_bo_populate(&bo->ttm, ctx);
+=09=09=09err =3D ttm_bo_populate(&bo->ttm, false, ctx);
 =09} else if (should_migrate_to_smem(bo)) {
 =09=09xe_assert(xe_bo_device(bo), bo->flags & XE_BO_FLAG_SYSTEM);
 =09=09err =3D xe_bo_migrate(bo, XE_PL_TT, ctx, exec);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..535ba37aff88 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -475,6 +475,7 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, stru=
ct ttm_resource *res,
 =09=09     pgprot_t tmp);
 void ttm_bo_tt_destroy(struct ttm_buffer_object *bo);
 int ttm_bo_populate(struct ttm_buffer_object *bo,
+=09=09    bool memcg_account,
 =09=09    struct ttm_operation_ctx *ctx);
 int ttm_bo_setup_export(struct ttm_buffer_object *bo,
 =09=09=09struct ttm_operation_ctx *ctx);
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index 5618aef462f2..a4bd23988ee0 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -85,6 +85,7 @@ struct ttm_device_funcs {
 =09 */
 =09int (*ttm_tt_populate)(struct ttm_device *bdev,
 =09=09=09       struct ttm_tt *ttm,
+=09=09=09       bool memcg_account,
 =09=09=09       struct ttm_operation_ctx *ctx);
=20
 =09/**
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..7f3f168c536c 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -78,6 +78,7 @@ struct ttm_pool {
 };
=20
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
+=09=09   bool memcg_account,
 =09=09   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
=20
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674b..15d4019685f6 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -250,6 +250,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_=
tt *ttm,
  * Calls the driver method to allocate pages for a ttm
  */
 int ttm_tt_populate(struct ttm_device *bdev, struct ttm_tt *ttm,
+=09=09    bool memcg_account,
 =09=09    struct ttm_operation_ctx *ctx);
=20
 /**
--=20
2.54.0


