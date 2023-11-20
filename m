Return-Path: <cgroups+bounces-477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785F7F1C89
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 19:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8681F25C91
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AF1DDDF;
	Mon, 20 Nov 2023 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A/zYVT7F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJDT17ry"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C94C4;
	Mon, 20 Nov 2023 10:34:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8EED218F8;
	Mon, 20 Nov 2023 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700505279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDePevE9GX1BKoA1NhlhcvLNyMlxXLyXeY5y95pZ5hE=;
	b=A/zYVT7Fx820C4tzi8eSuAucdooX4h6FC927L+IjA54Qe9YvxrByaTCTlXa499SCJcpQDX
	DCaaH924radXAEy2h8t6f0+s3rWY58/vJtLAuP2x1p6bn2FHQfgH3oiiHBXi7PxdwyXbtn
	MGTGou1b3lHqR0DtoIePDQhuSYDJ/30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700505279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDePevE9GX1BKoA1NhlhcvLNyMlxXLyXeY5y95pZ5hE=;
	b=OJDT17ry6C/LwnJ27TILex6mGaKTCUp7y6Oix12iBRNVJTSAyohHfQY/cpHEPL9Av5Wgk1
	F7BjUrQcvf9LrVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F7D213912;
	Mon, 20 Nov 2023 18:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +I10Hr+mW2UUMgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 20 Nov 2023 18:34:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 20 Nov 2023 19:34:12 +0100
Subject: [PATCH v2 01/21] mm/slab, docs: switch mm-api docs generation from
 slab.c to slub.c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.45
X-Spamd-Result: default: False [-6.45 / 50.00];
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
	 BAYES_HAM(-2.65)[98.46%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,google.com,arm.com,cmpxchg.org,kernel.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

The SLAB implementation is going to be removed, and mm-api.rst currently
uses mm/slab.c to obtain kerneldocs for some API functions. Switch it to
mm/slub.c and move the relevant kerneldocs of exported functions from
one to the other. The rest of kerneldocs in slab.c is for static SLAB
implementation-specific functions that don't have counterparts in slub.c
and thus can be simply removed with the implementation.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/mm-api.rst |  2 +-
 mm/slab.c                         | 21 ---------------------
 mm/slub.c                         | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 2d091c873d1e..af8151db88b2 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -37,7 +37,7 @@ The Slab Cache
 .. kernel-doc:: include/linux/slab.h
    :internal:
 
-.. kernel-doc:: mm/slab.c
+.. kernel-doc:: mm/slub.c
    :export:
 
 .. kernel-doc:: mm/slab_common.c
diff --git a/mm/slab.c b/mm/slab.c
index 9ad3d0f2d1a5..37efe3241f9c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3491,19 +3491,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-/**
- * kmem_cache_alloc_node - Allocate an object on the specified node
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- * @nodeid: node number of the target node.
- *
- * Identical to kmem_cache_alloc but it will allocate memory on the given
- * node, which can improve the performance for cpu bound structures.
- *
- * Fallback to other node is possible if __GFP_THISNODE is not set.
- *
- * Return: pointer to the new object or %NULL in case of error
- */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
@@ -3564,14 +3551,6 @@ void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
 	__do_kmem_cache_free(cachep, objp, caller);
 }
 
-/**
- * kmem_cache_free - Deallocate an object
- * @cachep: The cache the allocation was from.
- * @objp: The previously allocated object.
- *
- * Free an object which was previously allocated from this
- * cache.
- */
 void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
 	cachep = cache_from_obj(cachep, objp);
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..3e01731783df 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3518,6 +3518,19 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			       caller, orig_size);
 }
 
+/**
+ * kmem_cache_alloc_node - Allocate an object on the specified node
+ * @s: The cache to allocate from.
+ * @gfpflags: See kmalloc().
+ * @node: node number of the target node.
+ *
+ * Identical to kmem_cache_alloc but it will allocate memory on the given
+ * node, which can improve the performance for cpu bound structures.
+ *
+ * Fallback to other node is possible if __GFP_THISNODE is not set.
+ *
+ * Return: pointer to the new object or %NULL in case of error
+ */
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
@@ -3822,6 +3835,14 @@ void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
 	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
 }
 
+/**
+ * kmem_cache_free - Deallocate an object
+ * @s: The cache the allocation was from.
+ * @x: The previously allocated object.
+ *
+ * Free an object which was previously allocated from this
+ * cache.
+ */
 void kmem_cache_free(struct kmem_cache *s, void *x)
 {
 	s = cache_from_obj(s, x);

-- 
2.42.1


