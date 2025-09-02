Return-Path: <cgroups+bounces-9590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E74B3F379
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73041792BB
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 04:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06452E0936;
	Tue,  2 Sep 2025 04:11:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAD1804A
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786285; cv=none; b=k6q4x/eYvANy7LzWohjPKLQiOs8sykOURPhvDjeLjG06zFQ21+jcySaZD1aiqHohp9Vs8zGzfEDerUqXRjA2gjK2aZUR5+Z40yx3FS6s8TFwL3nFfqNzJMkO/u1vttRXl3tRTSEcj0GGVFbG4PEJ1EbM8+aNkvAIAvYeORc27ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786285; c=relaxed/simple;
	bh=f3K5TkhRCKXm6hlXtDeIMuVn8keYWBzxy0T8cMbl9NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XSLo/o1pNdJ6xABevii+kaglRqP8AcBl0TUOWr2bTB2aY/dT0GRiOxKdP5fL9t3NEbSG2u0NU84eyA9fgz7nXMCCJhpBGZXxkQCRgntX6hHcBfm36/EF3Zu5Rw3ShS/VC6Yuh3fbjcpx/b6l0s8cONP3WfoYT29QQ8sISYwdjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-icFbU9qSNXW0M_yLkmT2sg-1; Tue,
 02 Sep 2025 00:11:17 -0400
X-MC-Unique: icFbU9qSNXW0M_yLkmT2sg-1
X-Mimecast-MFC-AGG-ID: icFbU9qSNXW0M_yLkmT2sg_1756786276
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017781956096;
	Tue,  2 Sep 2025 04:11:16 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 682EE30001A2;
	Tue,  2 Sep 2025 04:11:08 +0000 (UTC)
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
Subject: [PATCH 05/15] ttm/pool: make pool shrinker NUMA aware
Date: Tue,  2 Sep 2025 14:06:44 +1000
Message-ID: <20250902041024.2040450-6-airlied@gmail.com>
In-Reply-To: <20250902041024.2040450-1-airlied@gmail.com>
References: <20250902041024.2040450-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GATuX6kkXGEEpN9tqnpXPI8wOIoEHMWngK-algtPL_4_1756786276
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

This enable NUMA awareness for the shrinker on the
ttm pools.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 38 +++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index bc8a796201b4..ae46aa370545 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -413,12 +413,12 @@ static struct ttm_pool_type *ttm_pool_select_type(str=
uct ttm_pool *pool,
 =09return NULL;
 }
=20
-/* Free pages using the global shrinker list */
-static unsigned int ttm_pool_shrink(void)
+/* Free pages using the per-node shrinker list */
+static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 {
+=09LIST_HEAD(dispose);
 =09struct ttm_pool_type *pt;
 =09unsigned int num_pages;
-=09struct page *p;
=20
 =09down_read(&pool_shrink_rwsem);
 =09spin_lock(&shrinker_lock);
@@ -426,13 +426,10 @@ static unsigned int ttm_pool_shrink(void)
 =09list_move_tail(&pt->shrinker_list, &shrinker_list);
 =09spin_unlock(&shrinker_lock);
=20
-=09p =3D ttm_pool_type_take(pt, ttm_pool_nid(pt->pool));
-=09if (p) {
-=09=09ttm_pool_free_page(pt->pool, pt->caching, pt->order, p, true);
-=09=09num_pages =3D 1 << pt->order;
-=09} else {
-=09=09num_pages =3D 0;
-=09}
+=09num_pages =3D list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_=
list, &dispose, &num_to_free);
+=09num_pages *=3D 1 << pt->order;
+
+=09ttm_pool_dispose_list(pt, &dispose);
 =09up_read(&pool_shrink_rwsem);
=20
 =09return num_pages;
@@ -781,6 +778,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
 =09=09pt =3D ttm_pool_select_type(pool, page_caching, order);
 =09=09if (pt && allow_pools)
 =09=09=09p =3D ttm_pool_type_take(pt, ttm_pool_nid(pool));
+
 =09=09/*
 =09=09 * If that fails or previously failed, allocate from system.
 =09=09 * Note that this also disallows additional pool allocations using
@@ -929,8 +927,10 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_t=
t *tt)
 {
 =09ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
=20
-=09while (atomic_long_read(&allocated_pages) > page_pool_size)
-=09=09ttm_pool_shrink();
+=09while (atomic_long_read(&allocated_pages) > page_pool_size) {
+=09=09unsigned long diff =3D page_pool_size - atomic_long_read(&allocated_=
pages);
+=09=09ttm_pool_shrink(ttm_pool_nid(pool), diff);
+=09}
 }
 EXPORT_SYMBOL(ttm_pool_free);
=20
@@ -1187,7 +1187,7 @@ static unsigned long ttm_pool_shrinker_scan(struct sh=
rinker *shrink,
 =09unsigned long num_freed =3D 0;
=20
 =09do
-=09=09num_freed +=3D ttm_pool_shrink();
+=09=09num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan);
 =09while (num_freed < sc->nr_to_scan &&
 =09       atomic_long_read(&allocated_pages));
=20
@@ -1315,11 +1315,15 @@ static int ttm_pool_debugfs_shrink_show(struct seq_=
file *m, void *data)
 =09=09.nr_to_scan =3D TTM_SHRINKER_BATCH,
 =09};
 =09unsigned long count;
+=09int nid;
=20
 =09fs_reclaim_acquire(GFP_KERNEL);
-=09count =3D ttm_pool_shrinker_count(mm_shrinker, &sc);
-=09seq_printf(m, "%lu/%lu\n", count,
-=09=09   ttm_pool_shrinker_scan(mm_shrinker, &sc));
+=09for_each_node(nid) {
+=09=09sc.nid =3D nid;
+=09=09count =3D ttm_pool_shrinker_count(mm_shrinker, &sc);
+=09=09seq_printf(m, "%d: %lu/%lu\n", nid, count,
+=09=09=09   ttm_pool_shrinker_scan(mm_shrinker, &sc));
+=09}
 =09fs_reclaim_release(GFP_KERNEL);
=20
 =09return 0;
@@ -1367,7 +1371,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
=20
-=09mm_shrinker =3D shrinker_alloc(0, "drm-ttm_pool");
+=09mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
 =09if (!mm_shrinker)
 =09=09return -ENOMEM;
=20
--=20
2.50.1


