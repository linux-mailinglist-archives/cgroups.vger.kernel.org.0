Return-Path: <cgroups+bounces-10801-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B94BE1465
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535EF486006
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D63AC39;
	Thu, 16 Oct 2025 02:32:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FBB661
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581962; cv=none; b=sz6HcDpeshgvGhJTF6QWdmbL3+SsQZmWxec7yR5xzIX6d99UDTu/enR2IJ/ip/pSVNqLcZ7Vrxx4ZifntMjvJsBEDsMQ9WVxX2f7QBdFAEojucr1IZiWqMMzB9a8+y/6EHb0jFOlp1rCG8xGyavmufQcg636SAmlKx7e9O9tQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581962; c=relaxed/simple;
	bh=MBxjOhSHrGk64NeA/wj33pDcYFMB/oGopy8SpR4JHUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsGNDToXZji17UQD4+3/agOSQy2aLtCCgtOfWH7dswBhlXsQEVUT4UWQNCytQMMGnFkG4fH/EtGc77wQNtyZy2+2nUe6zBdtXyVx5l6b5PhxsIXURnTEGTN08ZrsimgZSODDWZnltWf9wsdNR9FJAobhBbIVbIKxj7SkSC9vZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-Sv8n9ygvPUaII5TFwtzuOw-1; Wed,
 15 Oct 2025 22:32:34 -0400
X-MC-Unique: Sv8n9ygvPUaII5TFwtzuOw-1
X-Mimecast-MFC-AGG-ID: Sv8n9ygvPUaII5TFwtzuOw_1760581952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A82C1800592;
	Thu, 16 Oct 2025 02:32:32 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FD10180057B;
	Thu, 16 Oct 2025 02:32:24 +0000 (UTC)
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
Subject: [PATCH 02/16] drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)
Date: Thu, 16 Oct 2025 12:31:30 +1000
Message-ID: <20251016023205.2303108-3-airlied@gmail.com>
In-Reply-To: <20251016023205.2303108-1-airlied@gmail.com>
References: <20251016023205.2303108-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sR8EyVLJYpVvHpqnasDHkvtWRb5jS-U_i7_QeMqQjvY_1760581952
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dave Airlie <airlied@redhat.com>

This uses the newly introduced per-node gpu tracking stats,
to track GPU memory allocated via TTM and reclaimable memory in
the TTM page pools.

These stats will be useful later for system information and
later when mem cgroups are integrated.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>

---
v2: add reclaim parameters and adjust the right counters.
v3: drop the nid helper and get it from page.
v4: use mod_lruvec_page_state (Shakeel)
---
 drivers/gpu/drm/ttm/ttm_pool.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index baf27c70a419..148c7530738d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -150,8 +150,10 @@ static struct page *ttm_pool_alloc_page(struct ttm_poo=
l *pool, gfp_t gfp_flags,
=20
 =09if (!pool->use_dma_alloc) {
 =09=09p =3D alloc_pages_node(pool->nid, gfp_flags, order);
-=09=09if (p)
+=09=09if (p) {
 =09=09=09p->private =3D order;
+=09=09=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
+=09=09}
 =09=09return p;
 =09}
=20
@@ -186,7 +188,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool=
 *pool, gfp_t gfp_flags,
=20
 /* Reset the caching and pages of size 1 << order */
 static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching cac=
hing,
-=09=09=09       unsigned int order, struct page *p)
+=09=09=09       unsigned int order, struct page *p, bool reclaim)
 {
 =09unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
 =09struct ttm_pool_dma *dma;
@@ -201,6 +203,8 @@ static void ttm_pool_free_page(struct ttm_pool *pool, e=
num ttm_caching caching,
 #endif
=20
 =09if (!pool || !pool->use_dma_alloc) {
+=09=09mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
+=09=09=09=09      -(1 << order));
 =09=09__free_pages(p, order);
 =09=09return;
 =09}
@@ -288,6 +292,9 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt=
, struct page *p)
 =09list_add(&p->lru, &pt->pages);
 =09spin_unlock(&pt->lock);
 =09atomic_long_add(1 << pt->order, &allocated_pages);
+
+=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
+=09mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
 }
=20
 /* Take pages from a specific pool_type, return NULL when nothing availabl=
e */
@@ -299,6 +306,8 @@ static struct page *ttm_pool_type_take(struct ttm_pool_=
type *pt)
 =09p =3D list_first_entry_or_null(&pt->pages, typeof(*p), lru);
 =09if (p) {
 =09=09atomic_long_sub(1 << pt->order, &allocated_pages);
+=09=09mod_lruvec_page_state(p, NR_GPU_ACTIVE, (1 << pt->order));
+=09=09mod_lruvec_page_state(p, NR_GPU_RECLAIM, -(1 << pt->order));
 =09=09list_del(&p->lru);
 =09}
 =09spin_unlock(&pt->lock);
@@ -331,7 +340,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt=
)
 =09spin_unlock(&shrinker_lock);
=20
 =09while ((p =3D ttm_pool_type_take(pt)))
-=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
+=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p, true);
 }
=20
 /* Return the pool_type to use for the given caching and order */
@@ -383,7 +392,7 @@ static unsigned int ttm_pool_shrink(void)
=20
 =09p =3D ttm_pool_type_take(pt);
 =09if (p) {
-=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
+=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p, true);
 =09=09num_pages =3D 1 << pt->order;
 =09} else {
 =09=09num_pages =3D 0;
@@ -475,7 +484,7 @@ static pgoff_t ttm_pool_unmap_and_free(struct ttm_pool =
*pool, struct page *page,
 =09if (pt)
 =09=09ttm_pool_type_give(pt, page);
 =09else
-=09=09ttm_pool_free_page(pool, caching, order, page);
+=09=09ttm_pool_free_page(pool, caching, order, page, false);
=20
 =09return nr;
 }
@@ -780,7 +789,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
 =09return 0;
=20
 error_free_page:
-=09ttm_pool_free_page(pool, page_caching, order, p);
+=09ttm_pool_free_page(pool, page_caching, order, p, false);
=20
 error_free_all:
 =09if (tt->restore)
--=20
2.51.0


