Return-Path: <cgroups+bounces-8130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599DAB2F75
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 08:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B8E189944F
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4282550DC;
	Mon, 12 May 2025 06:19:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE82550AB
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030783; cv=none; b=Y6PuloWuEUQOwX1Xah8scjhsrKktRcQhiNhbM6UaWJJxPizmZP/t0cK6Y1Z9JE+EfiOeqT9NX5BEKGVbidXSRSMvbmjDnPOu8aeVQgliTmy45wy3IhZ1zp5XBJVtdzbBR5z9CaJRhJRhwQ7xxbLBTWJsBwc9n9Sw+gt/p4v0oB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030783; c=relaxed/simple;
	bh=T4Mfo0KxmmZ7+/BjaYNEeeKwNla6CWnghAte/4w5Gck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=u9ZRY8+cszBNzznwE03LYPr0slFKajAS5dWkQkK4BA8j/zRyk6vgrZMcLEcaDn39TBKpTDlJFCHaspxrt987xJrBXQb9Gi3ktxQDexZnhqoQpZ+EpCKw0v0HPLnBcWNKlCGtOgNywIAZ9VJNxP3f/whMMWq1JyChkem72VG0UFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-hMvoSD6YNu2rP-1LvET84g-1; Mon,
 12 May 2025 02:19:36 -0400
X-MC-Unique: hMvoSD6YNu2rP-1LvET84g-1
X-Mimecast-MFC-AGG-ID: hMvoSD6YNu2rP-1LvET84g_1747030775
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCB24180036D;
	Mon, 12 May 2025 06:19:34 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 716A419560B9;
	Mon, 12 May 2025 06:19:29 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [PATCH 2/7] ttm: use gpu mm stats to track gpu memory allocations.
Date: Mon, 12 May 2025 16:12:08 +1000
Message-ID: <20250512061913.3522902-3-airlied@gmail.com>
In-Reply-To: <20250512061913.3522902-1-airlied@gmail.com>
References: <20250512061913.3522902-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jHiROLI5L8VYakb1VUkXoArjQuQH2kU72h7nQ8wQi2c_1747030775
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

This uses the per-node stats to track GPU memory allocations,
across nodes when available. It also tracks the memory in the
pool.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index c2ea865be657..ccc3b9a13e9e 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -130,6 +130,16 @@ static struct list_head shrinker_list;
 static struct shrinker *mm_shrinker;
 static DECLARE_RWSEM(pool_shrink_rwsem);
=20
+/* helper to get a current valid node id from a pool */
+static int ttm_pool_nid(struct ttm_pool *pool) {
+=09int nid =3D NUMA_NO_NODE;
+=09if (pool)
+=09=09nid =3D pool->nid;
+=09if (nid =3D=3D NUMA_NO_NODE)
+=09=09nid =3D numa_node_id();
+=09return nid;
+}
+
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_f=
lags,
 =09=09=09=09=09unsigned int order)
@@ -149,8 +159,10 @@ static struct page *ttm_pool_alloc_page(struct ttm_poo=
l *pool, gfp_t gfp_flags,
=20
 =09if (!pool->use_dma_alloc) {
 =09=09p =3D alloc_pages_node(pool->nid, gfp_flags, order);
-=09=09if (p)
+=09=09if (p) {
 =09=09=09p->private =3D order;
+=09=09=09mod_node_page_state(NODE_DATA(ttm_pool_nid(pool)), NR_GPU_ACTIVE,=
 (1 << order));
+=09=09}
 =09=09return p;
 =09}
=20
@@ -201,6 +213,7 @@ static void ttm_pool_free_page(struct ttm_pool *pool, e=
num ttm_caching caching,
=20
 =09if (!pool || !pool->use_dma_alloc) {
 =09=09__free_pages(p, order);
+=09=09mod_node_page_state(NODE_DATA(ttm_pool_nid(pool)), NR_GPU_ACTIVE, -(=
1 << order));
 =09=09return;
 =09}
=20
@@ -275,6 +288,7 @@ static void ttm_pool_unmap(struct ttm_pool *pool, dma_a=
ddr_t dma_addr,
 static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
 {
 =09unsigned int i, num_pages =3D 1 << pt->order;
+=09int nid =3D ttm_pool_nid(pt->pool);
=20
 =09for (i =3D 0; i < num_pages; ++i) {
 =09=09if (PageHighMem(p))
@@ -287,17 +301,23 @@ static void ttm_pool_type_give(struct ttm_pool_type *=
pt, struct page *p)
 =09list_add(&p->lru, &pt->pages);
 =09spin_unlock(&pt->lock);
 =09atomic_long_add(1 << pt->order, &allocated_pages);
+
+=09mod_node_page_state(NODE_DATA(nid), NR_GPU_ACTIVE, -(1 << pt->order));
+=09mod_node_page_state(NODE_DATA(nid), NR_GPU_RECLAIM, (1 << pt->order));
 }
=20
 /* Take pages from a specific pool_type, return NULL when nothing availabl=
e */
 static struct page *ttm_pool_type_take(struct ttm_pool_type *pt)
 {
 =09struct page *p;
+=09int nid =3D ttm_pool_nid(pt->pool);
=20
 =09spin_lock(&pt->lock);
 =09p =3D list_first_entry_or_null(&pt->pages, typeof(*p), lru);
 =09if (p) {
 =09=09atomic_long_sub(1 << pt->order, &allocated_pages);
+=09=09mod_node_page_state(NODE_DATA(nid), NR_GPU_ACTIVE, (1 << pt->order))=
;
+=09=09mod_node_page_state(NODE_DATA(nid), NR_GPU_RECLAIM, -(1 << pt->order=
));
 =09=09list_del(&p->lru);
 =09}
 =09spin_unlock(&pt->lock);
--=20
2.49.0


