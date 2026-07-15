Return-Path: <cgroups+bounces-17837-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tuZxDL1dV2roKQEAu9opvQ
	(envelope-from <cgroups+bounces-17837-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777CE75CD55
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:15:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XLtRB46a;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17837-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17837-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41F3B311ADE1
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2A43C7A2;
	Wed, 15 Jul 2026 10:11:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0A43B4B9;
	Wed, 15 Jul 2026 10:11:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110264; cv=none; b=oGjbRZ2r8Y29Ic93o+XNjw8K6lrCoerDeCc8Jh7gHCRColdnO0b7ZoAWwdM+U2LM+2Ax+3H1dyVHk/wvrwJBih2QZwdLfciNvVpymkoUAg1w3sURrEW322rx1RTSQLQ4L2qUQb/hzjCiQDRIo0jhanmdRcZdyTn8eZPzjO/oc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110264; c=relaxed/simple;
	bh=9HhElATUP6juDMMZgc2GJzL6nhuRwWRGWslXQkd7VPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/R5vSodamdWr0wnlpqrxz8glgVGiHopZUQzK4iP9PqMMLtWVMf64m8uEmDGcaIIAJAwEJxS/0hQtWvaTuq9ei97QkZ4FQJ2UcJ0mHVFH+WqXkg5MDQM505vlhT+40okYIzfDmm8LXV7nZKTyhAEkDFSpbIoINHqneYHLGcyutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLtRB46a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1201F000E9;
	Wed, 15 Jul 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110260;
	bh=u6a6gIA6sTVgPNtUhqSfGZDUgWxEBBIZRB5pqLDi1cM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XLtRB46atn6QfmN5dAVo6auba4UvEwxMoK50FW7Eo4LIs9OaZCGxHNyui1Mo74TOJ
	 Sgb2RsD62sH/87Y6MZCzKFGZVQblwVwa4K81SVZ4YKOEnbDPpOuAg0JzEb21oMj9Pk
	 qDkFf8Txb5v2ihP3o4EmjRAUFwp6Nd/9/E7Hdk+iPaYYAvY/pMkQwSiA4oS2126PRy
	 HAehdK2jap0CL8ZnUc3sYKKVkDxQPI2tKQBN6+kF10Z12of9emT8KkYpbV+sM/P3RF
	 7LCOLpV9LPs6x5qHMlnoak0fKDDamqrYl97RoNiOPxGPCfg7lu0jGV3d3dqGG9vcTt
	 yLj7Ozc8pMWxg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:44 +0200
Subject: [PATCH RFC 04/12] mm/slab: make slab_obj_ext() determine object
 index
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-4-9a49c4ccf4c3@kernel.org>
References: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
In-Reply-To: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
To: Harry Yoo <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17837-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 777CE75CD55

All callers perform the same obj_to_index() calculation to pass the
index. Simplify by passing object pointer instead and determining the
index by slab_obj_ext().

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/memcontrol.c | 12 +++---------
 mm/slab.h       | 14 ++++++++------
 mm/slub.c       | 22 +++++++---------------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6dc4888a90f3..4e427286a88a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2865,15 +2865,13 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	 */
 	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
-	unsigned int off;
 
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
 		return NULL;
 
 	get_slab_obj_exts(obj_exts);
-	off = obj_to_index(slab->slab_cache, slab, p);
-	obj_ext = slab_obj_ext(slab, obj_exts, off);
+	obj_ext = slab_obj_ext(slab->slab_cache, slab, obj_exts, p);
 	if (obj_ext->objcg) {
 		struct obj_cgroup *objcg = obj_ext->objcg;
 
@@ -3541,7 +3539,6 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	size_t obj_size = obj_full_size(s);
 	struct obj_cgroup *objcg;
 	struct slab *slab;
-	unsigned long off;
 	size_t i;
 
 	/*
@@ -3616,8 +3613,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 
 		obj_exts = slab_obj_exts(slab);
 		get_slab_obj_exts(obj_exts);
-		off = obj_to_index(s, slab, p[i]);
-		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		obj_ext = slab_obj_ext(s, slab, obj_exts, p[i]);
 		obj_cgroup_get(objcg);
 		obj_ext->objcg = objcg;
 		put_slab_obj_exts(obj_exts);
@@ -3635,10 +3631,8 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		struct obj_cgroup *objcg;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
-		unsigned int off;
 
-		off = obj_to_index(s, slab, p[i]);
-		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		obj_ext = slab_obj_ext(s, slab, obj_exts, p[i]);
 		objcg = obj_ext->objcg;
 		if (!objcg)
 			continue;
diff --git a/mm/slab.h b/mm/slab.h
index 7bd361447c54..36d067d6e7c0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -646,14 +646,16 @@ static inline unsigned int slab_get_stride(struct slab *slab)
  * Returns a pointer to the object extension associated with the object.
  * Must be called within a section covered by get/put_slab_obj_exts().
  */
-static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
-					       unsigned long obj_exts,
-					       unsigned int index)
+static inline struct slabobj_ext *
+slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
+	     const void *obj)
 {
 	struct slabobj_ext *obj_ext;
+	unsigned int index;
 
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
+	index = obj_to_index(s, slab, obj);
 	obj_ext = (struct slabobj_ext *)(obj_exts +
 					 slab_get_stride(slab) * index);
 	return kasan_reset_tag(obj_ext);
@@ -669,9 +671,9 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return 0;
 }
 
-static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
-					       unsigned long obj_exts,
-					       unsigned int index)
+static inline struct slabobj_ext *
+slab_obj_ext(struct kmem_cache *s, struct slab *slab, unsigned long obj_exts,
+	     const void *obj)
 {
 	return NULL;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 9e25f2dce7a6..5e3f53bcd0d3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2070,11 +2070,10 @@ static inline void mark_obj_codetag_empty(const void *obj)
 	obj_slab = virt_to_slab(obj);
 	slab_exts = slab_obj_exts(obj_slab);
 	if (slab_exts) {
+		struct slabobj_ext *ext;
+
 		get_slab_obj_exts(slab_exts);
-		unsigned int offs = obj_to_index(obj_slab->slab_cache,
-						 obj_slab, obj);
-		struct slabobj_ext *ext = slab_obj_ext(obj_slab,
-						       slab_exts, offs);
+		ext = slab_obj_ext(obj_slab->slab_cache, obj_slab, slab_exts, obj);
 
 		if (unlikely(is_codetag_empty(&ext->ref))) {
 			put_slab_obj_exts(slab_exts);
@@ -2362,10 +2361,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	 * check should be added before alloc_tag_add().
 	 */
 	if (obj_exts) {
-		unsigned int obj_idx = obj_to_index(s, slab, object);
-
 		get_slab_obj_exts(obj_exts);
-		obj_ext = slab_obj_ext(slab, obj_exts, obj_idx);
+		obj_ext = slab_obj_ext(s, slab, obj_exts, object);
 		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
 		put_slab_obj_exts(obj_exts);
 	} else {
@@ -2386,7 +2383,6 @@ static noinline void
 __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			       int objects)
 {
-	int i;
 	unsigned long obj_exts;
 
 	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
@@ -2398,13 +2394,11 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 		return;
 
 	get_slab_obj_exts(obj_exts);
-	for (i = 0; i < objects; i++) {
-		unsigned int off = obj_to_index(s, slab, p[i]);
-
+	for (int i = 0; i < objects; i++) {
 		if (is_kfence_address(p[i]))
 			continue;
 
-		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
+		alloc_tag_sub(&slab_obj_ext(s, slab, obj_exts, p[i])->ref, s->size);
 	}
 	put_slab_obj_exts(obj_exts);
 }
@@ -2489,7 +2483,6 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	struct kmem_cache *s;
 	struct page *page;
 	struct slab *slab;
-	unsigned long off;
 
 	page = virt_to_page(p);
 	if (PageLargeKmalloc(page)) {
@@ -2529,8 +2522,7 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	obj_exts = slab_obj_exts(slab);
 	if (obj_exts) {
 		get_slab_obj_exts(obj_exts);
-		off = obj_to_index(s, slab, p);
-		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		obj_ext = slab_obj_ext(s, slab, obj_exts, p);
 		if (unlikely(obj_ext->objcg)) {
 			put_slab_obj_exts(obj_exts);
 			return true;

-- 
2.55.0


