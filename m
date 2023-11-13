Return-Path: <cgroups+bounces-363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8E7EA387
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C5E1C2098B
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA123757;
	Mon, 13 Nov 2023 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cb9azOi+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZzAxb8Q"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAE2377F
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 19:14:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFB1735;
	Mon, 13 Nov 2023 11:14:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 893D52193C;
	Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699902855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc0ydpEKadjGMZmR6AOilRcjjCaikOgVLMhJfLa5KNY=;
	b=Cb9azOi+79RTNG1eEAaRK2qKO08RdjEozYg5VQaWSgjm9ZtEhKXDtBAnNZSXPOGfqbZ5Yx
	zjyoWUbZWmftG6lgXdDLymTg9Eq0TbgJJoTL9ePBdM+V3LwH5TQf8gQMZUYvaz7iGhzAtV
	Qnmt4KB+99CZs9Oky9jRP7dc8P9XkBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699902855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc0ydpEKadjGMZmR6AOilRcjjCaikOgVLMhJfLa5KNY=;
	b=YZzAxb8QZCafpYhSWsUv7cmsWbx/IMh0AC7UrukpeAEDxfHnpnbLPFz7TSL4WQSuD7NdVi
	vwsIBz9/OyMbwQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EDFC13398;
	Mon, 13 Nov 2023 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eOW7Dod1UmVFOgAAMHmgww
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
Subject: [PATCH 18/20] mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
Date: Mon, 13 Nov 2023 20:13:59 +0100
Message-ID: <20231113191340.17482-40-vbabka@suse.cz>
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

slab_alloc() is a thin wrapper around slab_alloc_node() with only one
caller.  Replace with direct call of slab_alloc_node().
__kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
so replace it with direct calls of slab_alloc_node() and
trace_kmem_cache_alloc().

This also makes sure _RET_IP_ has always the expected value and not
depending on inlining decisions.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b44243e7cc5e..d2363b91d55c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,39 +3821,33 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	return object;
 }
 
-static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
-		gfp_t gfpflags, unsigned long addr, size_t orig_size)
-{
-	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
-}
-
-static __fastpath_inline
-void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			     gfp_t gfpflags)
+void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 {
-	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
+				    s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
 	return ret;
 }
-
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
-{
-	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
-}
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
-	return __kmem_cache_alloc_lru(s, lru, gfpflags);
+	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
+				    s->object_size);
+
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
+
+	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
 
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_,
+				    s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
 
-- 
2.42.1


