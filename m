Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE354654F5
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352164AbhLASTH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 13:19:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352241AbhLASSm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 13:18:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA941FDFD;
        Wed,  1 Dec 2021 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638382519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0/rBeFeucpyB5eR+yI6wcQARAoucV5Vh3arlrutk1o=;
        b=P/uWa8pvMldBBBpARhPMDG3dBFh2v2Dph/QymG0bhj9spZT+IycvMJZI2kZzCKKt54eD6y
        JxE0blxeSD1AJwTRvvClpMiqJi9CA02jj0vhe9dd+xDiDj1xO/+qoX0iXx8KRXd50ZZ7yf
        mTprlFdCsoiU48HLnmSX9gNBgGU5P3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638382519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0/rBeFeucpyB5eR+yI6wcQARAoucV5Vh3arlrutk1o=;
        b=6pZ79VbmmNRCvP0QgeKeWTD9X6UdQl4Vr6DouJZ8MkCiq1mi3FjctM8Vr89FneiIpnlplA
        /SOHPW4C8/DbwACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4991114050;
        Wed,  1 Dec 2021 18:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLo5Ebe7p2HPSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Dec 2021 18:15:19 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: [PATCH v2 23/33] mm/memcg: Convert slab objcgs from struct page to struct slab
Date:   Wed,  1 Dec 2021 19:15:00 +0100
Message-Id: <20211201181510.18784-24-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201181510.18784-1-vbabka@suse.cz>
References: <20211201181510.18784-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12729; h=from:subject; bh=2gFwaSUFu5+TO8dizzXad+fz0D9VNIeN/5XUKZMSrXU=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhp7uSU3f/a01ekx7yjssTe9je59PedL4begohchKJ GqCoWZGJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYae7kgAKCRDgIcpz8YmpEIZoCA Cuo91LO4fXmvgL4Yl2bGr+XEUJr76fTt9lmH36HhwGYm2zxMb32tA5A5cWVcLvLydT02w01MAcGKTk CJDZyqLDA8eozr29DLFv75qPNcTi9YLnlbQOETwdhM6qj28VBQ7ba9qg0AQH/OETOzs97VvWx/E4tP /xwWWJEc3tTiGCYkFVc0/dKvF28ONhGy2ZvgULhmO/Ty7myOQN8x2gjxpNaf0ZEEQK06n1p0ZMHDV9 UD7uasdvohcq1kwNPJnpVoPNUBDzWyjQEMdUYrRHMXbFN+scvCPrcz1hKoxsxDb0y0P6ITW9W2ukKf +u4QJwW3Tijbnl9Fjps6vBSnmdojuD
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

page->memcg_data is used with MEMCG_DATA_OBJCGS flag only for slab pages
so convert all the related infrastructure to struct slab.

To avoid include cycles, move the inline definitions of slab_objcgs() and
slab_objcgs_check() from memcontrol.h to mm/slab.h.

This is not just mechanistic changing of types and names. Now in
mem_cgroup_from_obj() we use PageSlab flag to decide if we interpret the page
as slab, instead of relying on MEMCG_DATA_OBJCGS bit checked in
page_objcgs_check() (now slab_objcgs_check()). Similarly in
memcg_slab_free_hook() where we can encounter kmalloc_large() pages (here the
PageSlab flag check is implied by virt_to_slab()).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: <cgroups@vger.kernel.org>
---
 include/linux/memcontrol.h |  48 ------------------
 mm/memcontrol.c            |  43 +++++++++-------
 mm/slab.h                  | 101 ++++++++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 89 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..e34112f6a369 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -536,45 +536,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
-/*
- * page_objcgs - get the object cgroups vector associated with a page
- * @page: a pointer to the page struct
- *
- * Returns a pointer to the object cgroups vector associated with the page,
- * or NULL. This function assumes that the page is known to have an
- * associated object cgroups vector. It's not safe to call this function
- * against pages, which might have an associated memory cgroup: e.g.
- * kernel stack pages.
- */
-static inline struct obj_cgroup **page_objcgs(struct page *page)
-{
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
-
-	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
-
-	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-}
-
-/*
- * page_objcgs_check - get the object cgroups vector associated with a page
- * @page: a pointer to the page struct
- *
- * Returns a pointer to the object cgroups vector associated with the page,
- * or NULL. This function is safe to use if the page can be directly associated
- * with a memory cgroup.
- */
-static inline struct obj_cgroup **page_objcgs_check(struct page *page)
-{
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
-
-	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
-		return NULL;
-
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
-
-	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-}
 
 #else
 static inline bool folio_memcg_kmem(struct folio *folio)
@@ -582,15 +543,6 @@ static inline bool folio_memcg_kmem(struct folio *folio)
 	return false;
 }
 
-static inline struct obj_cgroup **page_objcgs(struct page *page)
-{
-	return NULL;
-}
-
-static inline struct obj_cgroup **page_objcgs_check(struct page *page)
-{
-	return NULL;
-}
 #endif
 
 static inline bool PageMemcgKmem(struct page *page)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 906edbd92436..522fff11d6d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2816,31 +2816,31 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
 
-int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp, bool new_page)
+int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
+				 gfp_t gfp, bool new_slab)
 {
-	unsigned int objects = objs_per_slab(s, page_slab(page));
+	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long memcg_data;
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
-			   page_to_nid(page));
+			   slab_nid(slab));
 	if (!vec)
 		return -ENOMEM;
 
 	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
-	if (new_page) {
+	if (new_slab) {
 		/*
-		 * If the slab page is brand new and nobody can yet access
-		 * it's memcg_data, no synchronization is required and
-		 * memcg_data can be simply assigned.
+		 * If the slab is brand new and nobody can yet access its
+		 * memcg_data, no synchronization is required and memcg_data can
+		 * be simply assigned.
 		 */
-		page->memcg_data = memcg_data;
-	} else if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
+		slab->memcg_data = memcg_data;
+	} else if (cmpxchg(&slab->memcg_data, 0, memcg_data)) {
 		/*
-		 * If the slab page is already in use, somebody can allocate
-		 * and assign obj_cgroups in parallel. In this case the existing
+		 * If the slab is already in use, somebody can allocate and
+		 * assign obj_cgroups in parallel. In this case the existing
 		 * objcg vector should be reused.
 		 */
 		kfree(vec);
@@ -2865,24 +2865,31 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
  */
 struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
-	struct page *page;
+	struct folio *folio;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	page = virt_to_head_page(p);
+	folio = virt_to_folio(p);
 
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
 	 * the page->obj_cgroups.
 	 */
-	if (page_objcgs_check(page)) {
+	if (folio_test_slab(folio)) {
+		struct obj_cgroup **objcgs;
 		struct obj_cgroup *objcg;
+		struct slab *slab;
 		unsigned int off;
 
-		off = obj_to_index(page->slab_cache, page_slab(page), p);
-		objcg = page_objcgs(page)[off];
+		slab = folio_slab(folio);
+		objcgs = slab_objcgs_check(slab);
+		if (!objcgs)
+			return NULL;
+
+		off = obj_to_index(slab->slab_cache, slab, p);
+		objcg = objcgs[off];
 		if (objcg)
 			return obj_cgroup_memcg(objcg);
 
@@ -2896,7 +2903,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	 * page_memcg_check(page) will guarantee that a proper memory
 	 * cgroup pointer or NULL will be returned.
 	 */
-	return page_memcg_check(page);
+	return page_memcg_check(folio_page(folio, 0));
 }
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
diff --git a/mm/slab.h b/mm/slab.h
index 15d109d8ec89..0760f20686a7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -412,15 +412,56 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
-				 gfp_t gfp, bool new_page);
+/*
+ * slab_objcgs - get the object cgroups vector associated with a slab
+ * @slab: a pointer to the slab struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the slab,
+ * or NULL. This function assumes that the slab is known to have an
+ * associated object cgroups vector. It's not safe to call this function
+ * against slabs with underlying pages, which might have an associated memory
+ * cgroup: e.g.  kernel stack pages.
+ */
+static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+{
+	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
+
+	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS),
+							slab_page(slab));
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, slab_page(slab));
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
+/*
+ * slab_objcgs_check - get the object cgroups vector associated with a slab
+ * @slab: a pointer to the slab struct
+ *
+ * Returns a pointer to the object cgroups vector associated with the slab, or
+ * NULL. This function is safe to use if the underlying page can be directly
+ * associated with a memory cgroup.
+ */
+static inline struct obj_cgroup **slab_objcgs_check(struct slab *slab)
+{
+	unsigned long memcg_data = READ_ONCE(slab->memcg_data);
+
+	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
+		return NULL;
+
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, slab_page(slab));
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
+int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
+				 gfp_t gfp, bool new_slab);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
 
-static inline void memcg_free_page_obj_cgroups(struct page *page)
+static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
-	kfree(page_objcgs(page));
-	page->memcg_data = 0;
+	kfree(slab_objcgs(slab));
+	slab->memcg_data = 0;
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -465,7 +506,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      gfp_t flags, size_t size,
 					      void **p)
 {
-	struct page *page;
+	struct slab *slab;
 	unsigned long off;
 	size_t i;
 
@@ -474,19 +515,19 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
-			page = virt_to_head_page(p[i]);
+			slab = virt_to_slab(p[i]);
 
-			if (!page_objcgs(page) &&
-			    memcg_alloc_page_obj_cgroups(page, s, flags,
+			if (!slab_objcgs(slab) &&
+			    memcg_alloc_slab_cgroups(slab, s, flags,
 							 false)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
 			}
 
-			off = obj_to_index(s, page_slab(page), p[i]);
+			off = obj_to_index(s, slab, p[i]);
 			obj_cgroup_get(objcg);
-			page_objcgs(page)[off] = objcg;
-			mod_objcg_state(objcg, page_pgdat(page),
+			slab_objcgs(slab)[off] = objcg;
+			mod_objcg_state(objcg, slab_pgdat(slab),
 					cache_vmstat_idx(s), obj_full_size(s));
 		} else {
 			obj_cgroup_uncharge(objcg, obj_full_size(s));
@@ -501,7 +542,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 	struct kmem_cache *s;
 	struct obj_cgroup **objcgs;
 	struct obj_cgroup *objcg;
-	struct page *page;
+	struct slab *slab;
 	unsigned int off;
 	int i;
 
@@ -512,43 +553,57 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 		if (unlikely(!p[i]))
 			continue;
 
-		page = virt_to_head_page(p[i]);
-		objcgs = page_objcgs_check(page);
+		slab = virt_to_slab(p[i]);
+		/* we could be given a kmalloc_large() object, skip those */
+		if (!slab)
+			continue;
+
+		objcgs = slab_objcgs_check(slab);
 		if (!objcgs)
 			continue;
 
 		if (!s_orig)
-			s = page->slab_cache;
+			s = slab->slab_cache;
 		else
 			s = s_orig;
 
-		off = obj_to_index(s, page_slab(page), p[i]);
+		off = obj_to_index(s, slab, p[i]);
 		objcg = objcgs[off];
 		if (!objcg)
 			continue;
 
 		objcgs[off] = NULL;
 		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
 				-obj_full_size(s));
 		obj_cgroup_put(objcg);
 	}
 }
 
 #else /* CONFIG_MEMCG_KMEM */
+static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
+{
+	return NULL;
+}
+
+static inline struct obj_cgroup **slab_objcgs_check(struct slab *slab)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
 }
 
-static inline int memcg_alloc_page_obj_cgroups(struct page *page,
+static inline int memcg_alloc_slab_cgroups(struct slab *slab,
 					       struct kmem_cache *s, gfp_t gfp,
-					       bool new_page)
+					       bool new_slab)
 {
 	return 0;
 }
 
-static inline void memcg_free_page_obj_cgroups(struct page *page)
+static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
 }
 
@@ -587,7 +642,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
 	if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_page_obj_cgroups(slab_page(slab), s, gfp, true);
+		memcg_alloc_slab_cgroups(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -597,7 +652,7 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
 	if (memcg_kmem_enabled())
-		memcg_free_page_obj_cgroups(slab_page(slab));
+		memcg_free_slab_cgroups(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
-- 
2.33.1

