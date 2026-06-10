Return-Path: <cgroups+bounces-16813-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DsbRHI2HKWomYwMAu9opvQ
	(envelope-from <cgroups+bounces-16813-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:49:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5966B05E
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MGXfLz7Z;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16813-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16813-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D299300D4FD
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5036426EAB;
	Wed, 10 Jun 2026 15:40:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAD40F8CC;
	Wed, 10 Jun 2026 15:40:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106037; cv=none; b=ONwTNB1gyyhKu/o7j9fupWhR5EfXBU/9G7JupJcNfwoFawQPfQKZiX5w3X3aLKGvj3nrLSZ4Vjwli5pbMib4V4GOL8gBXrEg5DlU/OUtS235GHppg7zFa834gJnjX+PnbFhe+Gt37ioIsvc84/2Msja1629MXkmG7LtuHbjsW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106037; c=relaxed/simple;
	bh=pFckZEoBOV8R1q4DBvG8W0GV8pl7Ebmk5d5fQ9thixA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlD1DZuMPSnO7Yl5KJEZqDtoxD6wLcxHnpO6ubqcuVeW6r34ySfZUHoVJXvT3zElymEzX7TYG4otC1pUWSoErLv6lQgDz8DhRyg8hbFkjtVn+nRoIEEY+QH3UsmgyDdCPZ/iYAwLMRAAGVqIhmF9uRRrIDP1jSbSVHS0+7MBnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGXfLz7Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067421F00893;
	Wed, 10 Jun 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106036;
	bh=ZhFKmHctgSxoJWqzBYD58wKUXHYe5psqPpAeu+LOPVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MGXfLz7ZZVI7GqiN/jfhQa/zsWy9FrniBQpUixElaK2h8d+l7MRqVQ9U8bttWhrvt
	 pcuvBZg2MfxB/9/Q0PIRpo2dQdk99czRHJR83TG496O+h97+AWRBWC5Q1XxePGo1uY
	 Nj6mAlYXB5M42sx679YfYDE8S3AV0NA1UprxNgEgUg7JrfPXFDsvnNLjTxXODA1/Ts
	 cTTzAVYJcvSJtYdsG5XKPStNXixlNvTF6O1qZitE6feN8u6K2dDkj4bwvSr1IR3lsZ
	 BGq5SoMUIYMoHVWEmCp4syrJtm8k3Ov8NEwXrxrKC43cc87FrLr6TPH65baRtzfrbz
	 j9jTC+MmTLwew==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:04 +0200
Subject: [PATCH v2 02/16] mm/slab: do not init any kfence objects on
 allocation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org>
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16813-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26F5966B05E

When init (zeroing) on allocation is requested, for kmalloc() we
generally have to zero the full object size even if a smaller size is
requested, in order to provide krealloc()'s __GFP_ZERO guarantees.

When we end up allocating a kfence object, kfence perfoms the zeroing on
its own because has its own redzone beyond the requested size. Thus
slab_post_alloc_hook() has an 'init' parameter which has to be evaluated
in all callers (via slab_want_init_on_alloc()) and should be false for
kfence allocations.

For kfence allocations in slab_alloc_node() this is achieved by subtly
skipping over the slab_want_init_on_alloc() call. Other callers (i.e.
kmem_cache_alloc_bulk_noprof()) however evaluate it unconditionally even
if they do end up with a kfence allocation. This is only subtly not a
problem, as those are not kmalloc allocations and thus the "requested
size" equals s->object_size and thus it cannot interfere with kfence's
redzone. There's just a unnecessary double zeroing (in both kfence and
slab_post_alloc_hook()), but it's all very fragile and contradicts the
comment in kfence_guarded_alloc().

Remove this subtlety and simplify the code by eliminating the init
parameter from slab_post_alloc_hook() and make it call
slab_want_init_on_alloc() itself. Instead add a is_kfence_address()
check before performing the memset, which will start doing the right
thing for all callers of slab_post_alloc_hook().

This potentially adds overhead of the is_kfence_address() check to
allocation hotpath, but that one is designed to be as small as possible,
and it's only evaluated if zeroing is about to happen. This means (aside
from init_on_alloc hardening) only for __GFP_ZERO allocations, and the
zeroing itself comes with an overhead likely larger than the added
check.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/kfence/core.c |  2 +-
 mm/slub.c        | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 655dc5ce3240..5e0b406924e9 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -500,7 +500,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 
 	/*
 	 * We check slab_want_init_on_alloc() ourselves, rather than letting
-	 * SL*B do the initialization, as otherwise we might overwrite KFENCE's
+	 * slab do the initialization, as otherwise it might overwrite KFENCE's
 	 * redzone.
 	 */
 	if (unlikely(slab_want_init_on_alloc(gfp, cache)))
diff --git a/mm/slub.c b/mm/slub.c
index e2ee8f1aaccf..8e5264d3ddbf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4565,9 +4565,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 
 static __fastpath_inline
 bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-			  gfp_t flags, size_t size, void **p, bool init,
+			  gfp_t flags, size_t size, void **p,
 			  unsigned int orig_size)
 {
+	bool init = slab_want_init_on_alloc(flags, s);
 	unsigned int zero_size = s->object_size;
 	bool kasan_init = init;
 	size_t i;
@@ -4608,7 +4609,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
 		if (p[i] && init && (!kasan_init ||
-				     !kasan_has_integrated_init()))
+				     !kasan_has_integrated_init())
+				 && !is_kfence_address(p[i]))
 			memset(p[i], 0, zero_size);
 		if (gfpflags_allow_spinning(flags))
 			kmemleak_alloc_recursive(p[i], s->object_size, 1,
@@ -4910,7 +4912,6 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
-	bool init = false;
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
@@ -4926,16 +4927,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
 
 	maybe_wipe_obj_freeptr(s, object);
-	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
 	/*
-	 * When init equals 'true', like for kzalloc() family, only
-	 * @orig_size bytes might be zeroed instead of s->object_size
 	 * In case this fails due to memcg_slab_post_alloc_hook(),
 	 * object is set to NULL
 	 */
-	slab_post_alloc_hook(s, lru, gfpflags, 1, &object, init, orig_size);
+	slab_post_alloc_hook(s, lru, gfpflags, 1, &object, orig_size);
 
 	return object;
 }
@@ -5230,7 +5228,6 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 				   struct slab_sheaf *sheaf)
 {
 	void *ret = NULL;
-	bool init;
 
 	if (sheaf->size == 0)
 		goto out;
@@ -5240,10 +5237,8 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 	if (likely(!ret))
 		ret = sheaf->objects[--sheaf->size];
 
-	init = slab_want_init_on_alloc(gfp, s);
-
 	/* add __GFP_NOFAIL to force successful memcg charging */
-	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
+	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, s->object_size);
 out:
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
 
@@ -5423,8 +5418,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
-			     slab_want_init_on_alloc(alloc_gfp, s), orig_size);
+	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret, orig_size);
 
 	ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
 	return ret;
@@ -7339,8 +7333,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
 
 out:
 	/* memcg and kmem_cache debug support and memory initialization */
-	return likely(slab_post_alloc_hook(s, NULL, flags, size, p,
-			slab_want_init_on_alloc(flags, s), s->object_size));
+	return likely(slab_post_alloc_hook(s, NULL, flags, size, p, s->object_size));
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 

-- 
2.54.0


