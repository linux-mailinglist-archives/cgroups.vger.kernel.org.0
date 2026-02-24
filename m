Return-Path: <cgroups+bounces-14183-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIi3CXUInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14183-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:09:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9A180DF4
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28C383026AA8
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22423EA99;
	Tue, 24 Feb 2026 02:09:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3523EA83
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898993; cv=none; b=StCYM5p15hbdyn1Y2tiD4FJehVb1VGJRkhKWzQnIYXuGAVEkmZFZBL6RvN2aj2fpEKodS+u0FI62v3dDxbnfprcNOoWPVUSwOe/c1lMXBQ5TkhK3xHP73R6EnaTgmHO3Xd1lwkIQKLh3befcFWVbb3Um5YHoSWD/FqzYuLMlykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898993; c=relaxed/simple;
	bh=PXNOLXZcZstWqzbYt17UPITh9uLSd4OYaD9oGfRFx3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agoyHhO3wdy/kXBcDWHA8OZPnzKM5tOW8hrnJbmAq+vE+muDGlQnkZk9O78fewsyLzcImqf//SKLRLTinc2QvSobUcnsSoB/xrLYXBaIMDDVq08jbtpCMjGM+28F62R171gU2MQ/gaaMADMN0BI+hxli4rseoaG+GIYSK+rJixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-YPm3JPQjNdiXoq3y15mdjQ-1; Mon,
 23 Feb 2026 21:09:44 -0500
X-MC-Unique: YPm3JPQjNdiXoq3y15mdjQ-1
X-Mimecast-MFC-AGG-ID: YPm3JPQjNdiXoq3y15mdjQ_1771898983
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52C74180025C;
	Tue, 24 Feb 2026 02:09:43 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D5E330001BB;
	Tue, 24 Feb 2026 02:09:36 +0000 (UTC)
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
Subject: [PATCH 05/16] ttm/pool: make pool shrinker NUMA aware (v2)
Date: Tue, 24 Feb 2026 12:06:22 +1000
Message-ID: <20260224020854.791201-6-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: aba4Yv-Sagb5ktwGceVNNgayyH3HIGHLrViJCm6RTTk_1771898983
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14183-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fromorbit.com:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCB9A180DF4
X-Rspamd-Action: no action

From: Dave Airlie <airlied@redhat.com>

This enable NUMA awareness for the shrinker on the
ttm pools.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Dave Chinner <david@fromorbit.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>

---
v2: AI review - found reverse diff calculation
---
 drivers/gpu/drm/ttm/ttm_pool.c | 38 +++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index 3989e15ab5b0..880228132b91 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -423,12 +423,12 @@ static struct ttm_pool_type *ttm_pool_select_type(str=
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
@@ -436,13 +436,10 @@ static unsigned int ttm_pool_shrink(void)
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
@@ -791,6 +788,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
 =09=09pt =3D ttm_pool_select_type(pool, page_caching, order);
 =09=09if (pt && allow_pools)
 =09=09=09p =3D ttm_pool_type_take(pt, ttm_pool_nid(pool));
+
 =09=09/*
 =09=09 * If that fails or previously failed, allocate from system.
 =09=09 * Note that this also disallows additional pool allocations using
@@ -941,8 +939,10 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_t=
t *tt)
 {
 =09ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
=20
-=09while (atomic_long_read(&allocated_pages) > page_pool_size)
-=09=09ttm_pool_shrink();
+=09while (atomic_long_read(&allocated_pages) > page_pool_size) {
+=09=09unsigned long diff =3D atomic_long_read(&allocated_pages) - page_poo=
l_size;
+=09=09ttm_pool_shrink(ttm_pool_nid(pool), diff);
+=09}
 }
 EXPORT_SYMBOL(ttm_pool_free);
=20
@@ -1197,7 +1197,7 @@ static unsigned long ttm_pool_shrinker_scan(struct sh=
rinker *shrink,
 =09unsigned long num_freed =3D 0;
=20
 =09do
-=09=09num_freed +=3D ttm_pool_shrink();
+=09=09num_freed +=3D ttm_pool_shrink(sc->nid, sc->nr_to_scan);
 =09while (num_freed < sc->nr_to_scan &&
 =09       atomic_long_read(&allocated_pages));
=20
@@ -1325,11 +1325,15 @@ static int ttm_pool_debugfs_shrink_show(struct seq_=
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
@@ -1377,7 +1381,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
=20
-=09mm_shrinker =3D shrinker_alloc(0, "drm-ttm_pool");
+=09mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
 =09if (!mm_shrinker)
 =09=09return -ENOMEM;
=20
--=20
2.52.0


