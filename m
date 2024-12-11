Return-Path: <cgroups+bounces-5793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357FB9EC404
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 05:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42406167AC3
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 04:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115602451CE;
	Wed, 11 Dec 2024 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vos/2H+F"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E06136;
	Wed, 11 Dec 2024 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891582; cv=none; b=eun95CHJoUygmXYKGTJIv3/60YiliGMnQMaGLrKzGltUAsquou37F9NHq9ICXYAdvoQKigf0rMs15SJnfGwQy46rt3ZEmTvkWe+L0s3EM/CNEXq9RSpihbx0AQpvluBIHcgxd6MPXMPLweUgsdEwvQuUs5EKUsOxfLD9KsKT+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891582; c=relaxed/simple;
	bh=8Y25msfHBU8KKb2lQV/CmDvpLU99kPRKi9d2j4RYNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS+AbxDFYDvoMLiFHz+vwoDKKD5XjVtWmhoFM/40w9lHrtPuSwqDgp8klHPTJlYfr6QzxLj8bQQ+gjLVuTK3saw9+Sc+zf59B8Upi1i2a21wxq13apRhGQbKrf1DkTKV1VnPPyuQO6+Tr+/IV9D34ST8SG0EwGbHxOyL9nJhHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vos/2H+F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kYgcX+CsLcaggzAlRVTJ/EcQANIp0vNfureKuWSQ4N8=; b=Vos/2H+FuYlHIfx7q00+cIyILL
	XkahFh6CzKVaojHzl5FXx8YKvd8fsXltvKPaSGq9ILxNgItmdc9fEdrOMCtxZdVfPZ6qEGv+IUGf7
	ms4KbJCKwWynvAerSHHsueugkA4pbqvRioy3Hon22SzKLZzCyVNjU1jiaB8loE+50lkb0IZ+rdEv3
	4+CfEd/lKtz6+snWV6r795h0nI2/hb6kN0HvPzNH0hK53237GOjMout2H/SYS+s3U36gfvDVgDwwz
	qLOsafZpJNe5G5JQTy2beexIKqkE/zjl7pZ4v4rFxYrMzn9ETBuUEwqzxNReP4KhFYgE9jjkUN/pA
	TVc9Oj7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLEP7-0000000DpR6-1kmn;
	Wed, 11 Dec 2024 04:32:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Date: Wed, 11 Dec 2024 04:32:50 +0000
Message-ID: <20241211043252.3295947-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211043252.3295947-1-willy@infradead.org>
References: <20241211043252.3295947-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today we account each page individually to the memcg, which works well
enough, if a little inefficiently (N atomic operations per page instead
of N per allocation).  Unfortunately, the stats can get out of sync when
i915 calls vmap() with VM_MAP_PUT_PAGES.  The pages being passed were not
allocated by vmalloc, so the MEMCG_VMALLOC counter was never incremented.
But it is decremented when the pages are freed with vfree().

Solve all of this by tracking the memcg at the vm_struct level.
This logic has to live in the memcontrol file as it calls several
functions which are currently static.

Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h |  7 ++++++
 include/linux/vmalloc.h    |  3 +++
 mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c               | 14 ++++++------
 4 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5502aa8e138e..83ebcadebba6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1676,6 +1676,10 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+int obj_cgroup_charge_vmalloc(struct obj_cgroup **objcgp,
+		unsigned int nr_pages, gfp_t gfp);
+void obj_cgroup_uncharge_vmalloc(struct obj_cgroup *objcgp,
+		unsigned int nr_pages);
 
 extern struct static_key_false memcg_bpf_enabled_key;
 static inline bool memcg_bpf_enabled(void)
@@ -1756,6 +1760,9 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
+/* Must be macros to avoid dereferencing objcg in vm_struct */
+#define obj_cgroup_charge_vmalloc(objcgp, nr_pages, gfp)	0
+#define obj_cgroup_uncharge_vmalloc(objcg, nr_pages)	do { } while (0)
 static inline struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	return NULL;
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..ec7c2d607382 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -60,6 +60,9 @@ struct vm_struct {
 #endif
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
+#ifdef CONFIG_MEMCG
+	struct obj_cgroup	*objcg;
+#endif
 	const void		*caller;
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..629bffc3e26d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5472,4 +5472,50 @@ static int __init mem_cgroup_swap_init(void)
 }
 subsys_initcall(mem_cgroup_swap_init);
 
+/**
+ * obj_cgroup_charge_vmalloc - Charge vmalloc memory
+ * @objcgp: Pointer to an object cgroup
+ * @nr_pages: Number of pages
+ * @gfp: Memory allocation flags
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int obj_cgroup_charge_vmalloc(struct obj_cgroup **objcgp,
+		unsigned int nr_pages, gfp_t gfp)
+{
+	struct obj_cgroup *objcg;
+	int err;
+
+	if (mem_cgroup_disabled() || !(gfp & __GFP_ACCOUNT))
+		return 0;
+
+	objcg = current_obj_cgroup();
+	if (!objcg)
+		return 0;
+
+	err = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
+	if (err)
+		return err;
+	obj_cgroup_get(objcg);
+	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_VMALLOC, nr_pages);
+	*objcgp = objcg;
+
+	return 0;
+}
+
+/**
+ * obj_cgroup_uncharge_vmalloc - Uncharge vmalloc memory
+ * @objcg: The object cgroup
+ * @nr_pages: Number of pages
+ */
+void obj_cgroup_uncharge_vmalloc(struct obj_cgroup *objcg,
+		unsigned int nr_pages)
+{
+	if (!objcg)
+		return;
+	mod_memcg_state(objcg->memcg, MEMCG_VMALLOC, 0L - nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_put(objcg);
+}
+
 #endif /* CONFIG_SWAP */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bc9c91f3b373..d5e9068d9091 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3374,7 +3374,6 @@ void vfree(const void *addr)
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
@@ -3384,6 +3383,7 @@ void vfree(const void *addr)
 	}
 	if (!(vm->flags & VM_MAP_PUT_PAGES))
 		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
+	obj_cgroup_uncharge_vmalloc(vm->objcg, vm->nr_pages);
 	kvfree(vm->pages);
 	kfree(vm);
 }
@@ -3537,6 +3537,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	struct page *page;
 	int i;
 
+	/* Accounting handled in caller */
+	gfp &= ~__GFP_ACCOUNT;
+
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
 	 * the page array is partly or not at all populated due
@@ -3670,12 +3673,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-	if (gfp_mask & __GFP_ACCOUNT) {
-		int i;
-
-		for (i = 0; i < area->nr_pages; i++)
-			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
-	}
+	ret = obj_cgroup_charge_vmalloc(&area->objcg, gfp_mask, area->nr_pages);
+	if (ret)
+		goto fail;
 
 	/*
 	 * If not enough pages were obtained to accomplish an
-- 
2.45.2


