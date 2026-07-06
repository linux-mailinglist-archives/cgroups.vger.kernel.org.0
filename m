Return-Path: <cgroups+bounces-17514-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/cYCzoWS2odLwEAu9opvQ
	(envelope-from <cgroups+bounces-17514-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:43:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C470C2EA
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17514-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17514-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3678B300E01B
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 02:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02F3A9639;
	Mon,  6 Jul 2026 02:43:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C43A9628
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 02:43:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305783; cv=none; b=r0qeFKPiKhoHbFV97RGLPCbIeXJpKmt/7xv/W2BksZJI8jLurJjHecEHhH3y0BqSXRmwwtz+Vpqk3oGRgGkLkSzyj+if7nPmPcCFoyTHdBy4RtyVFRJocsJEghSL8U7/i3QigU8L3gf3PvrEFvrmpBxQxg3kLA5th+nN2zUgQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305783; c=relaxed/simple;
	bh=CSb6DlmWZnNWPQO3SG+MXDiPWyTf0UQ0Jxw4B/Z0T6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=alS8NfQR0r5C1RI+fj/G9CPVG/gLy52ogib/fFKHS33270IrgwCX/YspOuQldI2zcLPYxk0gH0CddIdjHwDuBP2JO7mpVF8A0jxsX2+TxQklaNvraeUENlmoF15ZSR1TF24iXnNT9sxtU3XOSHCI6Rf+8Ags28JMZBlt5RhN5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-J5MRu7RAMjWyp02xDsLttQ-1; Sun,
 05 Jul 2026 22:41:45 -0400
X-MC-Unique: J5MRu7RAMjWyp02xDsLttQ-1
X-Mimecast-MFC-AGG-ID: J5MRu7RAMjWyp02xDsLttQ_1783305704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D8B1955F78;
	Mon,  6 Jul 2026 02:41:43 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4A7F300070A;
	Mon,  6 Jul 2026 02:41:36 +0000 (UTC)
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
Subject: [PATCH 01/10] memcg: add support for GPU page counters. (v4)
Date: Mon,  6 Jul 2026 12:36:10 +1000
Message-ID: <20260706024122.853329-2-airlied@gmail.com>
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
X-Mimecast-MFC-PROC-ID: JdLNvLCSxqFTEs5O7sDAUAoOmtDURu7IQszCsJP1uRE_1783305704
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
	TAGGED_FROM(0.00)[bounces-17514-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: B60C470C2EA

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

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
v2: use memcg_node_stat_items
v3: fix null ptr dereference in uncharge
v4: AI review: fix parameter names, fix problem with reclaim moving doing w=
rong thing
---
 Documentation/admin-guide/cgroup-v2.rst |   6 ++
 include/linux/memcontrol.h              |  11 +++
 mm/memcontrol.c                         | 104 ++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 993446ab66d0..aa4f503770c5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1573,6 +1573,12 @@ The following nested keys are defined.
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
index e1f46a0016fc..3a968c6be0c8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1583,6 +1583,17 @@ static inline void mem_cgroup_flush_foreign(struct b=
di_writeback *wb)
 #endif=09/* CONFIG_CGROUP_WRITEBACK */
=20
 struct sock;
+bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *pag=
e,
+=09=09=09   unsigned int order,
+=09=09=09   gfp_t gfp_mask, bool reclaim);
+void mem_cgroup_uncharge_gpu_page(struct page *page,
+=09=09=09=09  unsigned int order,
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
index 6dc4888a90f3..4c682b91cbbe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -423,6 +423,8 @@ static const unsigned int memcg_node_stat_items[] =3D {
 #ifdef CONFIG_HUGETLB_PAGE
 =09NR_HUGETLB,
 #endif
+=09NR_GPU_ACTIVE,
+=09NR_GPU_RECLAIM,
 };
=20
 static const unsigned int memcg_stat_items[] =3D {
@@ -1553,6 +1555,8 @@ static const struct memory_stat memory_stats[] =3D {
 =09{ "percpu",=09=09=09MEMCG_PERCPU_B=09=09=09},
 =09{ "sock",=09=09=09MEMCG_SOCK=09=09=09},
 =09{ "vmalloc",=09=09=09NR_VMALLOC=09=09=09},
+=09{ "gpu_active",=09=09=09NR_GPU_ACTIVE=09=09=09},
+=09{ "gpu_reclaim",=09=09NR_GPU_RECLAIM=09                },
 =09{ "shmem",=09=09=09NR_SHMEM=09=09=09},
 #ifdef CONFIG_ZSWAP
 =09{ "zswap",=09=09=09MEMCG_ZSWAP_B=09=09=09},
@@ -5508,6 +5512,106 @@ void mem_cgroup_flush_workqueue(void)
 =09flush_workqueue(memcg_wq);
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
+=09if (!objcg || !new_objcg || objcg =3D=3D new_objcg) {
+=09=09struct mem_cgroup *memcg =3D objcg ? get_mem_cgroup_from_objcg(objcg=
) : NULL;
+=09=09struct lruvec *lruvec;
+=09=09unsigned long flags;
+=09=09int nr_pages =3D 1 << order;
+
+=09=09lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
+=09=09local_irq_save(flags);
+=09=09mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE=
, nr_pages);
+=09=09mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_ACTIVE : NR_GPU_RECLAIM=
, -nr_pages);
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
2.54.0


