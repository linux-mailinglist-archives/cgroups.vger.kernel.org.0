Return-Path: <cgroups+bounces-10804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B654BE1483
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584CA188584A
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5E1DDC08;
	Thu, 16 Oct 2025 02:33:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB01AB6F1
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581996; cv=none; b=kUsx09pOqJ3wV9zBaBHd5DNLQ3JCA6z9J9Lg0z8C3sokq11cg/8KS5dg+VtM+ApnS4vz3kqUlDV2/ucwI+sUkHWK8eHt5/ROgPWpJRwYc9CvoiyfQ+DMat9+kXSygxOKjrnK3DM2az4hbLFE31uF6uDTDEXlHJh+4VbBSMiUtx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581996; c=relaxed/simple;
	bh=zehmKo6Fhdh2lfOOmTxiP9kwMmZKTZrFPQKCsh22G9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYYisyy83fD6q5Qyz+O/czTOFIwgNyuFTLBzcD1PAZlNGNkCFDGFcvCHTCpQYgKaG8p5z2ZMQEF5eTLMVryX9HFXyC1KifoGhmhE5DXKXeE++V7/SEdEemoEEDSmxh/SOS1iC+FLW9AH61Nw4Yjozg1HHmzqH+DB7mlW/l1gPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-q0eLMjwaP7a0MZH95cB0MA-1; Wed,
 15 Oct 2025 22:33:10 -0400
X-MC-Unique: q0eLMjwaP7a0MZH95cB0MA-1
X-Mimecast-MFC-AGG-ID: q0eLMjwaP7a0MZH95cB0MA_1760581988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BB8C1801312;
	Thu, 16 Oct 2025 02:33:08 +0000 (UTC)
Received: from dreadlord.taild9177d.ts.net (unknown [10.67.32.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B68E1800446;
	Thu, 16 Oct 2025 02:33:01 +0000 (UTC)
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
Subject: [PATCH 07/16] memcg: add support for GPU page counters. (v3)
Date: Thu, 16 Oct 2025 12:31:35 +1000
Message-ID: <20251016023205.2303108-8-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: Vz_zqxIjUm_pH4HZgZtGl8e5CMifSYkmtXfATgq6DKY_1760581988
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dave Airlie <airlied@redhat.com>

This introduces 2 new statistics and 3 new memcontrol APIs for dealing
with GPU system memory allocations.

The stats corresponds to the same stats in the global vmstat,
for number of active GPU pages, and number of pages in pools that
can be reclaimed.

The first API charges a order of pages to a objcg, and sets
the objcg on the pages like kmem does, and updates the active/reclaim
statistic.

The second API uncharges a page from the obj cgroup it is currently charged
to.

The third API allows moving a page to/from reclaim and between obj cgroups.
When pages are added to the pool lru, this just updates accounting.
When pages are being removed from a pool lru, they can be taken from
the parent objcg so this allows them to be uncharged from there and transfe=
rred
to a new child objcg.

Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
v2: use memcg_node_stat_items
v3: fix null ptr dereference in uncharge
---
 Documentation/admin-guide/cgroup-v2.rst |   6 ++
 include/linux/memcontrol.h              |  11 +++
 mm/memcontrol.c                         | 107 ++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 0e6c67ac585a..9aa9b28562b8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1574,6 +1574,12 @@ The following nested keys are defined.
 =09  vmalloc (npn)
 =09=09Amount of memory used for vmap backed memory.
=20
+=09  gpu_active (npn)
+=09=09Amount of system memory used for GPU devices.
+
+=09  gpu_reclaim (npn)
+=09=09Amount of system memory cached for GPU devices.
+
 =09  shmem
 =09=09Amount of cached filesystem data that is swap-backed,
 =09=09such as tmpfs, shm segments, shared anonymous mmap()s
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..62c46c33f84f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1624,6 +1624,17 @@ static inline void mem_cgroup_flush_foreign(struct b=
di_writeback *wb)
 #endif=09/* CONFIG_CGROUP_WRITEBACK */
=20
 struct sock;
+bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *pag=
e,
+=09=09=09   unsigned int nr_pages,
+=09=09=09   gfp_t gfp_mask, bool reclaim);
+void mem_cgroup_uncharge_gpu_page(struct page *page,
+=09=09=09=09  unsigned int nr_pages,
+=09=09=09=09  bool reclaim);
+bool mem_cgroup_move_gpu_page_reclaim(struct obj_cgroup *objcg,
+=09=09=09=09      struct page *page,
+=09=09=09=09      unsigned int order,
+=09=09=09=09      bool to_reclaim);
+
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_e=
nabled_key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..ece340f3e391 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -330,6 +330,8 @@ static const unsigned int memcg_node_stat_items[] =3D {
 #ifdef CONFIG_HUGETLB_PAGE
 =09NR_HUGETLB,
 #endif
+=09NR_GPU_ACTIVE,
+=09NR_GPU_RECLAIM,
 };
=20
 static const unsigned int memcg_stat_items[] =3D {
@@ -1341,6 +1343,8 @@ static const struct memory_stat memory_stats[] =3D {
 =09{ "percpu",=09=09=09MEMCG_PERCPU_B=09=09=09},
 =09{ "sock",=09=09=09MEMCG_SOCK=09=09=09},
 =09{ "vmalloc",=09=09=09MEMCG_VMALLOC=09=09=09},
+=09{ "gpu_active",=09=09=09NR_GPU_ACTIVE=09=09=09},
+=09{ "gpu_reclaim",=09=09NR_GPU_RECLAIM=09                },
 =09{ "shmem",=09=09=09NR_SHMEM=09=09=09},
 #ifdef CONFIG_ZSWAP
 =09{ "zswap",=09=09=09MEMCG_ZSWAP_B=09=09=09},
@@ -5085,6 +5089,109 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, =
unsigned int nr_pages)
 =09refill_stock(memcg, nr_pages);
 }
=20
+/**
+ * mem_cgroup_charge_gpu_page - charge a page to GPU memory tracking
+ * @objcg: objcg to charge, NULL charges root memcg
+ * @page: page to charge
+ * @order: page allocation order
+ * @gfp_mask: gfp mode
+ * @reclaim: charge the reclaim counter instead of the active one.
+ *
+ * Charge the order sized @page to the objcg. Returns %true if the charge =
fit within
+ * @objcg's configured limit, %false if it doesn't.
+ */
+bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *pag=
e,
+=09=09=09=09unsigned int order, gfp_t gfp_mask, bool reclaim)
+{
+=09unsigned int nr_pages =3D 1 << order;
+=09struct mem_cgroup *memcg =3D NULL;
+=09struct lruvec *lruvec;
+=09int ret;
+
+=09if (objcg) {
+=09=09memcg =3D get_mem_cgroup_from_objcg(objcg);
+
+=09=09ret =3D try_charge_memcg(memcg, gfp_mask, nr_pages);
+=09=09if (ret) {
+=09=09=09mem_cgroup_put(memcg);
+=09=09=09return false;
+=09=09}
+
+=09=09obj_cgroup_get(objcg);
+=09=09page_set_objcg(page, objcg);
+=09}
+
+=09lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
+=09mod_lruvec_state(lruvec, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE, nr_p=
ages);
+
+=09mem_cgroup_put(memcg);
+=09return true;
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_charge_gpu_page);
+
+/**
+ * mem_cgroup_uncharge_gpu_page - uncharge a page from GPU memory tracking
+ * @page: page to uncharge
+ * @order: order of the page allocation
+ * @reclaim: uncharge the reclaim counter instead of the active.
+ */
+void mem_cgroup_uncharge_gpu_page(struct page *page,
+=09=09=09=09  unsigned int order, bool reclaim)
+{
+=09struct obj_cgroup *objcg =3D page_objcg(page);
+=09struct mem_cgroup *memcg;
+=09struct lruvec *lruvec;
+=09int nr_pages =3D 1 << order;
+
+=09memcg =3D objcg ? get_mem_cgroup_from_objcg(objcg) : NULL;
+
+=09lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
+=09mod_lruvec_state(lruvec, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE, -nr_=
pages);
+
+=09if (memcg && !mem_cgroup_is_root(memcg))
+=09=09refill_stock(memcg, nr_pages);
+=09page->memcg_data =3D 0;
+=09obj_cgroup_put(objcg);
+=09mem_cgroup_put(memcg);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_uncharge_gpu_page);
+
+/**
+ * mem_cgroup_move_gpu_reclaim - move pages from gpu to gpu reclaim and ba=
ck
+ * @new_objcg: objcg to move page to, NULL if just stats update.
+ * @nr_pages: number of pages to move
+ * @to_reclaim: true moves pages into reclaim, false moves them back
+ */
+bool mem_cgroup_move_gpu_page_reclaim(struct obj_cgroup *new_objcg,
+=09=09=09=09      struct page *page,
+=09=09=09=09      unsigned int order,
+=09=09=09=09      bool to_reclaim)
+{
+=09struct obj_cgroup *objcg =3D page_objcg(page);
+
+=09if (!objcg)
+=09=09return false;
+
+=09if (!new_objcg || objcg =3D=3D new_objcg) {
+=09=09struct mem_cgroup *memcg =3D get_mem_cgroup_from_objcg(objcg);
+=09=09struct lruvec *lruvec;
+=09=09unsigned long flags;
+=09=09int nr_pages =3D 1 << order;
+
+=09=09lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
+=09=09local_irq_save(flags);
+=09=09__mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTI=
VE, nr_pages);
+=09=09__mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_ACTIVE : NR_GPU_RECLA=
IM, -nr_pages);
+=09=09local_irq_restore(flags);
+=09=09mem_cgroup_put(memcg);
+=09=09return true;
+=09} else {
+=09=09mem_cgroup_uncharge_gpu_page(page, order, true);
+=09=09return mem_cgroup_charge_gpu_page(new_objcg, page, order, 0, false);
+=09}
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_move_gpu_page_reclaim);
+
 static int __init cgroup_memory(char *s)
 {
 =09char *token;
--=20
2.51.0


