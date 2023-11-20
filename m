Return-Path: <cgroups+bounces-496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988887F1CAA
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121011F25A32
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AA347B0;
	Mon, 20 Nov 2023 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LCzJgngk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dVVsCdgV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA4100;
	Mon, 20 Nov 2023 10:34:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C354A1F8B2;
	Mon, 20 Nov 2023 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l41Jb+BHNYtQ2OIFgOGmX9WMKyvcGjadAJ7/ZFyre/E=;
	b=LCzJgngkzITGb5Tf0wQOI+ebqHHcqa+GWs7cc+7WK7+jpNWwF/bcTQTNRVPXcGQ01CGICv
	ncaCAQ/HZm06a64rnhjOXN3b9S9XNga/ibSht5pA2L6A5MWVv5JAM8bOo7CPnLv0WV56BW
	q6exGNXv09TdutkEwyn0/rMlVEeaaPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l41Jb+BHNYtQ2OIFgOGmX9WMKyvcGjadAJ7/ZFyre/E=;
	b=dVVsCdgVXxLlGdzVI19fD3bgdu6SF1+kdlZ9nh7NFaxQIN/5XU0uCCQx033gY2PJHi2iYV
	xCNf7qL+X9Mol2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8455213499;
	Mon, 20 Nov 2023 18:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OCGvH8OmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:29 +0100
Subject: [PATCH v2 18/21] mm/slab: move kmalloc() functions from
 slab_common.c to slub.c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-18-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
To: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.30
X-Spamd-Result: default: False [1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL563rtnmcmc9sawm86hmgtctc)];
	 BAYES_SPAM(5.10)[100.00%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

This will eliminate a call between compilation units through
__kmem_cache_alloc_node() and allow better inlining of the allocation
fast path.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |   3 --
 mm/slab_common.c | 119 ----------------------------------------------------
 mm/slub.c        | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 118 insertions(+), 130 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7d7cc7af614e..54deeb0428c6 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -416,9 +416,6 @@ kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
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
index 2baa9e94d9df..d6bc15929d22 100644
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
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @s: The cache to allocate from.
@@ -3882,6 +3874,124 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
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


