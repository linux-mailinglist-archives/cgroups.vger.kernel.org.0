Return-Path: <cgroups+bounces-492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841087F1CA5
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A17D2827B7
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD734CF7;
	Mon, 20 Nov 2023 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GurbnCGj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KGJL7ZA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37A10C;
	Mon, 20 Nov 2023 10:34:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34F561F8C0;
	Mon, 20 Nov 2023 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dd/IArvjIRWfQN3Q+n8Y43IiuEYmqtBXkwN7diMKwU=;
	b=GurbnCGj79cofMqZNPG5ggQmlEGil9xl2Qc9QDrDU876ARGhNDVN6UHUcgTrd/RgAiAp6q
	wq48EYqN9pInZujNhWLyDFmzJ3B8jZC+++PZaNdFghIMT84xO9p0za0gTakob1u3XyyZPG
	8xvARXzCWa9lZ3irelYfoUecZM6zhnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dd/IArvjIRWfQN3Q+n8Y43IiuEYmqtBXkwN7diMKwU=;
	b=2KGJL7ZAkrwa/Tpv3q3xTY10kiRMrlQOQHqsN8kMGpf3r3mzdtqg/dSVXVYujQtdsvMJEg
	YhrpXfvL6XTCEDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1FA313499;
	Mon, 20 Nov 2023 18:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QEOSOsKmW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:27 +0100
Subject: [PATCH v2 16/21] mm/slab: move kfree() from slab_common.c to
 slub.c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-16-9c9c70177183@suse.cz>
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
X-Spam-Level: 
X-Spam-Score: -6.79
X-Spamd-Result: default: False [-6.79 / 50.00];
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
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-2.99)[99.94%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

This should result in better code. Currently kfree() makes a function
call between compilation units to __kmem_cache_free() which does its own
virt_to_slab(), throwing away the struct slab pointer we already had in
kfree(). Now it can be reused. Additionally kfree() can now inline the
whole SLUB freeing fastpath.

Also move over free_large_kmalloc() as the only callsites are now in
slub.c, and make it static.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |  4 ----
 mm/slab_common.c | 45 ---------------------------------------------
 mm/slub.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 5ae6a978e9c2..35a55c4a407d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -395,8 +395,6 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
 			      unsigned long caller);
-void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
-
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
@@ -559,8 +557,6 @@ static inline int memcg_alloc_slab_cgroups(struct slab *slab,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-void free_large_kmalloc(struct folio *folio, void *object);
-
 size_t __ksize(const void *objp);
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bbc2e3f061f1..f4f275613d2a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -963,22 +963,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 }
 
-void free_large_kmalloc(struct folio *folio, void *object)
-{
-	unsigned int order = folio_order(folio);
-
-	if (WARN_ON_ONCE(order == 0))
-		pr_warn_once("object pointer: 0x%p\n", object);
-
-	kmemleak_free(object);
-	kasan_kfree_large(object);
-	kmsan_kfree_large(object);
-
-	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
-			      -(PAGE_SIZE << order));
-	__free_pages(folio_page(folio, 0), order);
-}
-
 static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
@@ -1023,35 +1007,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-/**
- * kfree - free previously allocated memory
- * @object: pointer returned by kmalloc() or kmem_cache_alloc()
- *
- * If @object is NULL, no operation is performed.
- */
-void kfree(const void *object)
-{
-	struct folio *folio;
-	struct slab *slab;
-	struct kmem_cache *s;
-
-	trace_kfree(_RET_IP_, object);
-
-	if (unlikely(ZERO_OR_NULL_PTR(object)))
-		return;
-
-	folio = virt_to_folio(object);
-	if (unlikely(!folio_test_slab(folio))) {
-		free_large_kmalloc(folio, (void *)object);
-		return;
-	}
-
-	slab = folio_slab(folio);
-	s = slab->slab_cache;
-	__kmem_cache_free(s, (void *)object, _RET_IP_);
-}
-EXPORT_SYMBOL(kfree);
-
 /**
  * __ksize -- Report full size of underlying allocation
  * @object: pointer to the object
diff --git a/mm/slub.c b/mm/slub.c
index cc801f8258fe..2baa9e94d9df 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4197,11 +4197,6 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	return cachep;
 }
 
-void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
-{
-	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
-}
-
 /**
  * kmem_cache_free - Deallocate an object
  * @s: The cache the allocation was from.
@@ -4220,6 +4215,52 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+static void free_large_kmalloc(struct folio *folio, void *object)
+{
+	unsigned int order = folio_order(folio);
+
+	if (WARN_ON_ONCE(order == 0))
+		pr_warn_once("object pointer: 0x%p\n", object);
+
+	kmemleak_free(object);
+	kasan_kfree_large(object);
+	kmsan_kfree_large(object);
+
+	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+			      -(PAGE_SIZE << order));
+	__free_pages(folio_page(folio, 0), order);
+}
+
+/**
+ * kfree - free previously allocated memory
+ * @object: pointer returned by kmalloc() or kmem_cache_alloc()
+ *
+ * If @object is NULL, no operation is performed.
+ */
+void kfree(const void *object)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *x = (void *)object;
+
+	trace_kfree(_RET_IP_, object);
+
+	if (unlikely(ZERO_OR_NULL_PTR(object)))
+		return;
+
+	folio = virt_to_folio(object);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, (void *)object);
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	slab_free(s, slab, x, NULL, &x, 1, _RET_IP_);
+}
+EXPORT_SYMBOL(kfree);
+
 struct detached_freelist {
 	struct slab *slab;
 	void *tail;

-- 
2.42.1


