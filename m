Return-Path: <cgroups+bounces-372-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D107EA393
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D111C20965
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99452420E;
	Mon, 13 Nov 2023 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D46Whj8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sib4jhJi"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907523753
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47B1732;
	Mon, 13 Nov 2023 11:14:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4048A2192D;
	Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7E+/AO4YI9JRw9v06Xn3hJRV/04TmJk0Y92H5grHWg=;
	b=D46Whj8Q6QonuM/Pbf/QbhvCbS3sZsUb90QIsWFW79n6vLYtfn2DMcVp+sbsP8kOED7wmY
	fyg10f5CBok+ktkURsWt0wvTh11EV2yADa7T8Pbj7nVu7KCFBoBPnyLSKqAX+HtusIoeSY
	QH3OGPX8gxKDaRkWbKBCSPrAM/+msAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7E+/AO4YI9JRw9v06Xn3hJRV/04TmJk0Y92H5grHWg=;
	b=Sib4jhJiAUR9HENXCcUXXzLqY9yFkRaZ9xM/WjbLKNqXtpvfe/CfebFcq5xH1h9BXeQmA5
	oVOXZRKaooRGSiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E469513907;
	Mon, 13 Nov 2023 19:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GA4qN4Z1UmVFOgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 13 Nov 2023 19:14:14 +0000
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
Subject: [PATCH 17/20] mm/slab: move kmalloc() functions from slab_common.c to slub.c
Date: Mon, 13 Nov 2023 20:13:58 +0100
Message-ID: <20231113191340.17482-39-vbabka@suse.cz>
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

This will eliminate a call between compilation units through
__kmem_cache_alloc_node() and allow better inlining of the allocation
fast path.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |   3 --
 mm/slab_common.c | 119 --------------------------------------------
 mm/slub.c        | 126 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 118 insertions(+), 130 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 744384efa7be..eb04c8a5dbd1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -415,9 +415,6 @@ kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
 	return kmalloc_caches[kmalloc_type(flags, caller)][index];
 }
 
-void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
-			      int node, size_t orig_size,
-			      unsigned long caller);
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 31ade17a7ad9..238293b1dbe1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -936,50 +936,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 }
 
-static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
-static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = __kmalloc_large_node(size, flags, node);
-		trace_kmalloc(caller, ret, size,
-			      PAGE_SIZE << get_order(size), flags, node);
-		return ret;
-	}
-
-	if (unlikely(!size))
-		return ZERO_SIZE_PTR;
-
-	s = kmalloc_slab(size, flags, caller);
-
-	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
-	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc(caller, ret, size, s->size, flags, node);
-	return ret;
-}
-
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc_node);
-
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
-				  int node, unsigned long caller)
-{
-	return __do_kmalloc_node(size, flags, node, caller);
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 /**
  * __ksize -- Report full size of underlying allocation
  * @object: pointer to the object
@@ -1016,30 +972,6 @@ size_t __ksize(const void *object)
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 
-void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
-{
-	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
-					    size, _RET_IP_);
-
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
-
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_trace);
-
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-			 int node, size_t size)
-{
-	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
-
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
-
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_node_trace);
-
 gfp_t kmalloc_fix_flags(gfp_t flags)
 {
 	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
@@ -1052,57 +984,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
 	return flags;
 }
 
-/*
- * To avoid unnecessary overhead, we pass through large allocation requests
- * directly to the page allocator. We use __GFP_COMP, because we will need to
- * know the allocation order to free the pages properly in kfree.
- */
-
-static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
-{
-	struct page *page;
-	void *ptr = NULL;
-	unsigned int order = get_order(size);
-
-	if (unlikely(flags & GFP_SLAB_BUG_MASK))
-		flags = kmalloc_fix_flags(flags);
-
-	flags |= __GFP_COMP;
-	page = alloc_pages_node(node, flags, order);
-	if (page) {
-		ptr = page_address(page);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-				      PAGE_SIZE << order);
-	}
-
-	ptr = kasan_kmalloc_large(ptr, size, flags);
-	/* As ptr might get tagged, call kmemleak hook after KASAN. */
-	kmemleak_alloc(ptr, size, 1, flags);
-	kmsan_kmalloc_large(ptr, size, flags);
-
-	return ptr;
-}
-
-void *kmalloc_large(size_t size, gfp_t flags)
-{
-	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
-
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
-		      flags, NUMA_NO_NODE);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_large);
-
-void *kmalloc_large_node(size_t size, gfp_t flags, int node)
-{
-	void *ret = __kmalloc_large_node(size, flags, node);
-
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
-		      flags, node);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_large_node);
-
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
 static void freelist_randomize(unsigned int *list,
diff --git a/mm/slub.c b/mm/slub.c
index 52e2a65b1b11..b44243e7cc5e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3851,14 +3851,6 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
 
-void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
-			      int node, size_t orig_size,
-			      unsigned long caller)
-{
-	return slab_alloc_node(s, NULL, gfpflags, node,
-			       caller, orig_size);
-}
-
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
@@ -3869,6 +3861,124 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+/*
+ * To avoid unnecessary overhead, we pass through large allocation requests
+ * directly to the page allocator. We use __GFP_COMP, because we will need to
+ * know the allocation order to free the pages properly in kfree.
+ */
+static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	struct page *page;
+	void *ptr = NULL;
+	unsigned int order = get_order(size);
+
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_fix_flags(flags);
+
+	flags |= __GFP_COMP;
+	page = alloc_pages_node(node, flags, order);
+	if (page) {
+		ptr = page_address(page);
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      PAGE_SIZE << order);
+	}
+
+	ptr = kasan_kmalloc_large(ptr, size, flags);
+	/* As ptr might get tagged, call kmemleak hook after KASAN. */
+	kmemleak_alloc(ptr, size, 1, flags);
+	kmsan_kmalloc_large(ptr, size, flags);
+
+	return ptr;
+}
+
+void *kmalloc_large(size_t size, gfp_t flags)
+{
+	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
+
+	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
+		      flags, NUMA_NO_NODE);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_large);
+
+void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	void *ret = __kmalloc_large_node(size, flags, node);
+
+	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
+		      flags, node);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_large_node);
+
+static __always_inline
+void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+			unsigned long caller)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+		ret = __kmalloc_large_node(size, flags, node);
+		trace_kmalloc(caller, ret, size,
+			      PAGE_SIZE << get_order(size), flags, node);
+		return ret;
+	}
+
+	if (unlikely(!size))
+		return ZERO_SIZE_PTR;
+
+	s = kmalloc_slab(size, flags, caller);
+
+	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
+	ret = kasan_kmalloc(s, ret, size, flags);
+	trace_kmalloc(caller, ret, size, s->size, flags, node);
+	return ret;
+}
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+}
+EXPORT_SYMBOL(__kmalloc_node);
+
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+}
+EXPORT_SYMBOL(__kmalloc);
+
+void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
+				  int node, unsigned long caller)
+{
+	return __do_kmalloc_node(size, flags, node, caller);
+}
+EXPORT_SYMBOL(__kmalloc_node_track_caller);
+
+void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+{
+	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
+					    _RET_IP_, size);
+
+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
+
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_trace);
+
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+			 int node, size_t size)
+{
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
+
+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
+
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_node_trace);
+
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
-- 
2.42.1


