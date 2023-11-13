Return-Path: <cgroups+bounces-371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CB7EA394
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF65B20D91
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E002420B;
	Mon, 13 Nov 2023 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LiNsUX0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5iBlhYbr"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9222F1E
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:23 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01AC10EC;
	Mon, 13 Nov 2023 11:14:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8C7221940;
	Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lj2Ybkc9bEyxzgjbB/gyBkYp7HC/f0D1F7NR5xIwYLA=;
	b=LiNsUX0qC19DyvSVJKsLeb7BpuyU8EcyLm+7LbMe3HCx9f7yx1OTc9qGSsTNTzotRowJgh
	+G5i4+E5s097LUo3M55sk40/xT2anALj7t96A59r0wrf9eYAkF2XP2qH22NA0yxRDtVkQO
	/MhsRD+VgHPC8OqyzSbL8wp/mRU2lMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lj2Ybkc9bEyxzgjbB/gyBkYp7HC/f0D1F7NR5xIwYLA=;
	b=5iBlhYbrFOrnn6k5t+01hBzwT103ynklcSqnl4VDF5Ghwmnpx6N/lFwpSbaZqtFnLx5SNK
	kBQYxO2DtBxzWTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8757A13907;
	Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +CJlIId1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:15 +0000
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
Subject: [PATCH 19/20] mm/slub: optimize alloc fastpath code layout
Date: Mon, 13 Nov 2023 20:14:00 +0100
Message-ID: <20231113191340.17482-41-vbabka@suse.cz>
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

With allocation fastpaths no longer divided between two .c files, we
have better inlining, however checking the disassembly of
kmem_cache_alloc() reveals we can do better to make the fastpaths
smaller and move the less common situations out of line or to separate
functions, to reduce instruction cache pressure.

- split memcg pre/post alloc hooks to inlined checks that use likely()
  to assume there will be no objcg handling necessary, and non-inline
  functions doing the actual handling

- add some more likely/unlikely() to pre/post alloc hooks to indicate
  which scenarios should be out of line

- change gfp_allowed_mask handling in slab_post_alloc_hook() so the
  code can be optimized away when kasan/kmsan/kmemleak is configured out

bloat-o-meter shows:
add/remove: 4/2 grow/shrink: 1/8 up/down: 521/-2924 (-2403)
Function                                     old     new   delta
__memcg_slab_post_alloc_hook                   -     461    +461
kmem_cache_alloc_bulk                        775     791     +16
__pfx_should_failslab.constprop                -      16     +16
__pfx___memcg_slab_post_alloc_hook             -      16     +16
should_failslab.constprop                      -      12     +12
__pfx_memcg_slab_post_alloc_hook              16       -     -16
kmem_cache_alloc_lru                        1295    1023    -272
kmem_cache_alloc_node                       1118     817    -301
kmem_cache_alloc                            1076     772    -304
kmalloc_node_trace                          1149     838    -311
kmalloc_trace                               1102     789    -313
__kmalloc_node_track_caller                 1393    1080    -313
__kmalloc_node                              1397    1082    -315
__kmalloc                                   1374    1059    -315
memcg_slab_post_alloc_hook                   464       -    -464

Note that gcc still decided to inline __memcg_pre_alloc_hook(), but the
code is out of line. Forcing noinline did not improve the results. As a
result the fastpaths are shorter and overal code size is reduced.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 89 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d2363b91d55c..7a40132b717a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1866,25 +1866,17 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 /*
  * Returns false if the allocation should fail.
  */
-static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-					     struct list_lru *lru,
-					     struct obj_cgroup **objcgp,
-					     size_t objects, gfp_t flags)
+static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					struct list_lru *lru,
+					struct obj_cgroup **objcgp,
+					size_t objects, gfp_t flags)
 {
-	struct obj_cgroup *objcg;
-
-	if (!memcg_kmem_online())
-		return true;
-
-	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
-		return true;
-
 	/*
 	 * The obtained objcg pointer is safe to use within the current scope,
 	 * defined by current task or set_active_memcg() pair.
 	 * obj_cgroup_get() is used to get a permanent reference.
 	 */
-	objcg = current_obj_cgroup();
+	struct obj_cgroup *objcg = current_obj_cgroup();
 	if (!objcg)
 		return true;
 
@@ -1907,17 +1899,34 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	return true;
 }
 
-static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct obj_cgroup *objcg,
-					      gfp_t flags, size_t size,
-					      void **p)
+/*
+ * Returns false if the allocation should fail.
+ */
+static __fastpath_inline
+bool memcg_slab_pre_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
+			       struct obj_cgroup **objcgp, size_t objects,
+			       gfp_t flags)
+{
+	if (!memcg_kmem_online())
+		return true;
+
+	if (likely(!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT)))
+		return true;
+
+	return likely(__memcg_slab_pre_alloc_hook(s, lru, objcgp, objects,
+						  flags));
+}
+
+static void __memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					 struct obj_cgroup *objcg,
+					 gfp_t flags, size_t size,
+					 void **p)
 {
 	struct slab *slab;
 	unsigned long off;
 	size_t i;
 
-	if (!memcg_kmem_online() || !objcg)
-		return;
+	flags &= gfp_allowed_mask;
 
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
@@ -1940,6 +1949,16 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	}
 }
 
+static __fastpath_inline
+void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
+				gfp_t flags, size_t size, void **p)
+{
+	if (likely(!memcg_kmem_online() || !objcg))
+		return;
+
+	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
+}
+
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
@@ -3709,34 +3728,34 @@ noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 }
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
 
-static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-						     struct list_lru *lru,
-						     struct obj_cgroup **objcgp,
-						     size_t size, gfp_t flags)
+static __fastpath_inline
+struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
+				       struct list_lru *lru,
+				       struct obj_cgroup **objcgp,
+				       size_t size, gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
 
 	might_alloc(flags);
 
-	if (should_failslab(s, flags))
+	if (unlikely(should_failslab(s, flags)))
 		return NULL;
 
-	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
+	if (unlikely(!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags)))
 		return NULL;
 
 	return s;
 }
 
-static inline void slab_post_alloc_hook(struct kmem_cache *s,
-					struct obj_cgroup *objcg, gfp_t flags,
-					size_t size, void **p, bool init,
-					unsigned int orig_size)
+static __fastpath_inline
+void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
+			  gfp_t flags, size_t size, void **p, bool init,
+			  unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
 	bool kasan_init = init;
 	size_t i;
-
-	flags &= gfp_allowed_mask;
+	gfp_t init_flags = flags & gfp_allowed_mask;
 
 	/*
 	 * For kmalloc object, the allocated memory size(object_size) is likely
@@ -3769,13 +3788,13 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
 	 */
 	for (i = 0; i < size; i++) {
-		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
+		p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
 		if (p[i] && init && (!kasan_init ||
 				     !kasan_has_integrated_init()))
 			memset(p[i], 0, zero_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
-					 s->flags, flags);
-		kmsan_slab_alloc(s, p[i], flags);
+					 s->flags, init_flags);
+		kmsan_slab_alloc(s, p[i], init_flags);
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
@@ -3799,7 +3818,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	bool init = false;
 
 	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
-	if (!s)
+	if (unlikely(!s))
 		return NULL;
 
 	object = kfence_alloc(s, orig_size, gfpflags);
-- 
2.42.1


