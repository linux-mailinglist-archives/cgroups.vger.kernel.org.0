Return-Path: <cgroups+bounces-368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93B7EA38E
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559D1280F22
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5182376B;
	Mon, 13 Nov 2023 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gMfnvmxh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IzoyBqQa"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2E2377E
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569E1729;
	Mon, 13 Nov 2023 11:14:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E37402191E;
	Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBHYobYuCSx6ydYwBPVMXk5g8Fw3SvV+K+uyrFaLYqs=;
	b=gMfnvmxh9AlIT3bqRFHNkpU6w97DZm8sY2fHlghu1LWd91DdWQ0fJSE9oIrvV708zcOP2m
	rLNSUucfoB2BcIHM98hVTxv0f9pGqDocqbsMX9MW/LSIYvqlCuR2GxYBNENI9Ad/XJ17VX
	RydNE+CmJjE4Bfefo9lMiy5Mw7veqcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBHYobYuCSx6ydYwBPVMXk5g8Fw3SvV+K+uyrFaLYqs=;
	b=IzoyBqQayUy657/MfnNja7dTq8ElUc3pLgEZ/NxSL1N0oLUTzbZ8CHUIwlckYbwaRJR09Z
	U5ateASX+6X+EyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AFB313907;
	Mon, 13 Nov 2023 19:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aPo/IYV1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:13 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 13/20] mm/slab: move memcg related functions from slab.h to slub.c
Date: Mon, 13 Nov 2023 20:13:54 +0100
Message-ID: <20231113191340.17482-35-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113191340.17482-22-vbabka@suse.cz>
References: <20231113191340.17482-22-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't share those between SLAB and SLUB anymore, so most memcg
related functions can be moved to slub.c proper.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 206 ------------------------------------------------------
 mm/slub.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 206 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index aad18992269f..8de9780d345a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -485,12 +485,6 @@ void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
 ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 		       size_t count, loff_t *ppos);
 
-static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
-{
-	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
-}
-
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
 DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
@@ -550,220 +544,20 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_slab);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
-
-static inline void memcg_free_slab_cgroups(struct slab *slab)
-{
-	kfree(slab_objcgs(slab));
-	slab->memcg_data = 0;
-}
-
-static inline size_t obj_full_size(struct kmem_cache *s)
-{
-	/*
-	 * For each accounted object there is an extra space which is used
-	 * to store obj_cgroup membership. Charge it too.
-	 */
-	return s->size + sizeof(struct obj_cgroup *);
-}
-
-/*
- * Returns false if the allocation should fail.
- */
-static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-					     struct list_lru *lru,
-					     struct obj_cgroup **objcgp,
-					     size_t objects, gfp_t flags)
-{
-	struct obj_cgroup *objcg;
-
-	if (!memcg_kmem_online())
-		return true;
-
-	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
-		return true;
-
-	/*
-	 * The obtained objcg pointer is safe to use within the current scope,
-	 * defined by current task or set_active_memcg() pair.
-	 * obj_cgroup_get() is used to get a permanent reference.
-	 */
-	objcg = current_obj_cgroup();
-	if (!objcg)
-		return true;
-
-	if (lru) {
-		int ret;
-		struct mem_cgroup *memcg;
-
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		ret = memcg_list_lru_alloc(memcg, lru, flags);
-		css_put(&memcg->css);
-
-		if (ret)
-			return false;
-	}
-
-	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
-		return false;
-
-	*objcgp = objcg;
-	return true;
-}
-
-static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct obj_cgroup *objcg,
-					      gfp_t flags, size_t size,
-					      void **p)
-{
-	struct slab *slab;
-	unsigned long off;
-	size_t i;
-
-	if (!memcg_kmem_online() || !objcg)
-		return;
-
-	for (i = 0; i < size; i++) {
-		if (likely(p[i])) {
-			slab = virt_to_slab(p[i]);
-
-			if (!slab_objcgs(slab) &&
-			    memcg_alloc_slab_cgroups(slab, s, flags,
-							 false)) {
-				obj_cgroup_uncharge(objcg, obj_full_size(s));
-				continue;
-			}
-
-			off = obj_to_index(s, slab, p[i]);
-			obj_cgroup_get(objcg);
-			slab_objcgs(slab)[off] = objcg;
-			mod_objcg_state(objcg, slab_pgdat(slab),
-					cache_vmstat_idx(s), obj_full_size(s));
-		} else {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
-		}
-	}
-}
-
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-					void **p, int objects)
-{
-	struct obj_cgroup **objcgs;
-	int i;
-
-	if (!memcg_kmem_online())
-		return;
-
-	objcgs = slab_objcgs(slab);
-	if (!objcgs)
-		return;
-
-	for (i = 0; i < objects; i++) {
-		struct obj_cgroup *objcg;
-		unsigned int off;
-
-		off = obj_to_index(s, slab, p[i]);
-		objcg = objcgs[off];
-		if (!objcg)
-			continue;
-
-		objcgs[off] = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
-				-obj_full_size(s));
-		obj_cgroup_put(objcg);
-	}
-}
-
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
 {
 	return NULL;
 }
 
-static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
-{
-	return NULL;
-}
-
 static inline int memcg_alloc_slab_cgroups(struct slab *slab,
 					       struct kmem_cache *s, gfp_t gfp,
 					       bool new_slab)
 {
 	return 0;
 }
-
-static inline void memcg_free_slab_cgroups(struct slab *slab)
-{
-}
-
-static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-					     struct list_lru *lru,
-					     struct obj_cgroup **objcgp,
-					     size_t objects, gfp_t flags)
-{
-	return true;
-}
-
-static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct obj_cgroup *objcg,
-					      gfp_t flags, size_t size,
-					      void **p)
-{
-}
-
-static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-					void **p, int objects)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
-static inline struct kmem_cache *virt_to_cache(const void *obj)
-{
-	struct slab *slab;
-
-	slab = virt_to_slab(obj);
-	if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n",
-					__func__))
-		return NULL;
-	return slab->slab_cache;
-}
-
-static __always_inline void account_slab(struct slab *slab, int order,
-					 struct kmem_cache *s, gfp_t gfp)
-{
-	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
-		memcg_alloc_slab_cgroups(slab, s, gfp, true);
-
-	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
-			    PAGE_SIZE << order);
-}
-
-static __always_inline void unaccount_slab(struct slab *slab, int order,
-					   struct kmem_cache *s)
-{
-	if (memcg_kmem_online())
-		memcg_free_slab_cgroups(slab);
-
-	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
-			    -(PAGE_SIZE << order));
-}
-
-static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
-{
-	struct kmem_cache *cachep;
-
-	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
-	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
-		return s;
-
-	cachep = virt_to_cache(x);
-	if (WARN(cachep && cachep != s,
-		  "%s: Wrong slab cache. %s but object is from %s\n",
-		  __func__, s->name, cachep->name))
-		print_tracking(cachep, x);
-	return cachep;
-}
-
 void free_large_kmalloc(struct folio *folio, void *object);
 
 size_t __ksize(const void *objp);
diff --git a/mm/slub.c b/mm/slub.c
index e15912d1f6ed..25ff9d2d44a8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1814,6 +1814,165 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 #endif
 #endif /* CONFIG_SLUB_DEBUG */
 
+static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
+{
+	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
+}
+
+#ifdef CONFIG_MEMCG_KMEM
+static inline void memcg_free_slab_cgroups(struct slab *slab)
+{
+	kfree(slab_objcgs(slab));
+	slab->memcg_data = 0;
+}
+
+static inline size_t obj_full_size(struct kmem_cache *s)
+{
+	/*
+	 * For each accounted object there is an extra space which is used
+	 * to store obj_cgroup membership. Charge it too.
+	 */
+	return s->size + sizeof(struct obj_cgroup *);
+}
+
+/*
+ * Returns false if the allocation should fail.
+ */
+static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
+					     struct obj_cgroup **objcgp,
+					     size_t objects, gfp_t flags)
+{
+	struct obj_cgroup *objcg;
+
+	if (!memcg_kmem_online())
+		return true;
+
+	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
+		return true;
+
+	/*
+	 * The obtained objcg pointer is safe to use within the current scope,
+	 * defined by current task or set_active_memcg() pair.
+	 * obj_cgroup_get() is used to get a permanent reference.
+	 */
+	objcg = current_obj_cgroup();
+	if (!objcg)
+		return true;
+
+	if (lru) {
+		int ret;
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		ret = memcg_list_lru_alloc(memcg, lru, flags);
+		css_put(&memcg->css);
+
+		if (ret)
+			return false;
+	}
+
+	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
+		return false;
+
+	*objcgp = objcg;
+	return true;
+}
+
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct obj_cgroup *objcg,
+					      gfp_t flags, size_t size,
+					      void **p)
+{
+	struct slab *slab;
+	unsigned long off;
+	size_t i;
+
+	if (!memcg_kmem_online() || !objcg)
+		return;
+
+	for (i = 0; i < size; i++) {
+		if (likely(p[i])) {
+			slab = virt_to_slab(p[i]);
+
+			if (!slab_objcgs(slab) &&
+			    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
+				obj_cgroup_uncharge(objcg, obj_full_size(s));
+				continue;
+			}
+
+			off = obj_to_index(s, slab, p[i]);
+			obj_cgroup_get(objcg);
+			slab_objcgs(slab)[off] = objcg;
+			mod_objcg_state(objcg, slab_pgdat(slab),
+					cache_vmstat_idx(s), obj_full_size(s));
+		} else {
+			obj_cgroup_uncharge(objcg, obj_full_size(s));
+		}
+	}
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+	struct obj_cgroup **objcgs;
+	int i;
+
+	if (!memcg_kmem_online())
+		return;
+
+	objcgs = slab_objcgs(slab);
+	if (!objcgs)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off = obj_to_index(s, slab, p[i]);
+		objcg = objcgs[off];
+		if (!objcg)
+			continue;
+
+		objcgs[off] = NULL;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg);
+	}
+}
+#else /* CONFIG_MEMCG_KMEM */
+static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
+{
+	return NULL;
+}
+
+static inline void memcg_free_slab_cgroups(struct slab *slab)
+{
+}
+
+static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
+					     struct obj_cgroup **objcgp,
+					     size_t objects, gfp_t flags)
+{
+	return true;
+}
+
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct obj_cgroup *objcg,
+					      gfp_t flags, size_t size,
+					      void **p)
+{
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+					void **p, int objects)
+{
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
@@ -2048,6 +2207,26 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
+static __always_inline void account_slab(struct slab *slab, int order,
+					 struct kmem_cache *s, gfp_t gfp)
+{
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+		memcg_alloc_slab_cgroups(slab, s, gfp, true);
+
+	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
+			    PAGE_SIZE << order);
+}
+
+static __always_inline void unaccount_slab(struct slab *slab, int order,
+					   struct kmem_cache *s)
+{
+	if (memcg_kmem_online())
+		memcg_free_slab_cgroups(slab);
+
+	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
+			    -(PAGE_SIZE << order));
+}
+
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
 	struct slab *slab;
@@ -3952,6 +4131,32 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
+static inline struct kmem_cache *virt_to_cache(const void *obj)
+{
+	struct slab *slab;
+
+	slab = virt_to_slab(obj);
+	if (WARN_ONCE(!slab, "%s: Object is not a Slab page!\n", __func__))
+		return NULL;
+	return slab->slab_cache;
+}
+
+static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
+{
+	struct kmem_cache *cachep;
+
+	if (!IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
+	    !kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS))
+		return s;
+
+	cachep = virt_to_cache(x);
+	if (WARN(cachep && cachep != s,
+		 "%s: Wrong slab cache. %s but object is from %s\n",
+		 __func__, s->name, cachep->name))
+		print_tracking(cachep, x);
+	return cachep;
+}
+
 void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
 {
 	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
-- 
2.42.1


