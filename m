Return-Path: <cgroups+bounces-16762-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LbwqLCjdJ2pk3gIAu9opvQ
	(envelope-from <cgroups+bounces-16762-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:30:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34EA65E580
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Img4nAe/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16762-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16762-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21F84307E3ED
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041B38553F;
	Tue,  9 Jun 2026 09:18:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC643EF0A6;
	Tue,  9 Jun 2026 09:17:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996680; cv=none; b=TKr+y8d7WLUmEExuykjcPhPATqujPaG3lXULEKjc0lZ/mQ2avawuabzeqnfp/XYNOqfTXYadOw8Cpg+HOJqagIZiXl2+ovH6Y2WmeGaZOf2IbEYMsDIBzn/T2hbjWmimyqj4J8dytLsZMhSEm+kxaPaSBtp0Kf4IlGaHpzC3Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996680; c=relaxed/simple;
	bh=70gqDcrg+5oJHJ8prYoI1zCHFnYjpQ9ymUFMV42yIBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhVO20fVfe0Ldwf3szW9EcWWdGchT51SC9AJW3pchWSx713Bk1FZwFfge6K0rF9A1SAw5Uj+MAxHWs4CoIp5y7Dm5g8hQdoeGkf8Moq8T9zahM5LRh/PafGg78Dwqr6alF66WxfvsMBt/ddRP9pE/Qso8T+mXNrXi7/EB5KAE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Img4nAe/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EECB1F00898;
	Tue,  9 Jun 2026 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996678;
	bh=hqVWkFIfMg3YzVLrDjibkNrMS+xjyWA2/yvCzTNv4UI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Img4nAe/5V8E6cxtW6XUME70KqHhQt4eQitIoMBnbvRO8EolKfGQy4ph6150/1q4I
	 r+QkZbx82GWXn3BT1OkLWXVRjPMq8xdU2SAnWgFnzT5FKa++00H0sFhZqsQ8KsqGL5
	 5i6sxzxG+JNS5HfFGuY8qhtIuOd+gVHbAL0WxV29K/rERjA50i6Noa0vcv/7LTzLxL
	 RPESWW2K1sM2Bf06nYBlc5O/yujnys6yOPlsKbXZRm+V3mpduFQvVzbh4YrxZQ9UQK
	 b2D2jqtGSm/bgjGw9uxvDMaLaHXHM+G6Q4mO1OFhqS71V9gJsROwxg0iXZRQLW9JqN
	 qL9XXPr8aYukA==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:46 +0200
Subject: [PATCH RFC 01/15] mm/slab: always zero only requested size on
 alloc
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-1-2bf4a4b9b526@kernel.org>
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16762-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B34EA65E580

When zeroing on alloc is requested (by __GFP_ZERO or the init_on_alloc
parameter), we have been trying to zero the whole kmalloc bucket size
and not just requested size, if possible.

This probably comes from the past where ksize() could be used to
discover the bucket size and use it opportunistically beyond the
requested size. This is now forbidden and enabling debugging such as
KASAN or slab's red zoning would catch this misuse. Therefore, nobody
can be relying on __GFP_ZERO zeroing beyond requested size.

Theoretically it might still improve hardening in case of unintended
accesses beond requested size accessing some sensitive data from a
previous allocation. But then, init_on_free is probably used also for
hardening and would have cleared that.

So the usefullness of zeroing beyond requested size is practically none
nowadays. The disadvantages for doing it are:

- Interaction with KFENCE, which perfoms the zeroing on its own because
  it has its own redzone beyond requested size. As a consequence
  slab_post_alloc_hook() has an 'init' parameter which has to be
  evaluated in all callers (via slab_want_init_on_alloc()).

  For kfence allocations in slab_alloc_node() this evaluation is subtly
  skipped over in order to do the right thing. Other callers (i.e.
  kmem_cache_alloc_bulk_noprof()) evaluate it unconditionally even if
  they do end up with a kfence allocation. This is only subtly not a
  problem, as those are not kmalloc allocations and are using
  s->object_size as requested size, so it doesn't interfere with kfence's
  redzone. There's just a unnecessary double zeroing (in both kfence and
  slab_post_alloc_hook()), but it's all very fragile and contradicts the
  comment in kfence_guarded_alloc().

- Interaction with slab's redzoning where we have to limit the zeroing
  to requested size.

We can make the code much more simple by always zeroing only up to the
requested size. Move slab_want_init_on_alloc() call to
slab_post_alloc_hook(), removing the parameter. Remove the red zone
handling.

For kfence's zeroing code, update the comment. We could remove it
completely, but due to possible interactions with KASAN, there are
configurations where neither slab or KASAN would zero the object,
so simply do it in kfence. At worst the zeroing will happen twice, but
kfence allocations are rare by design so the cost is negligible.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/kfence/core.c |  6 +++---
 mm/slub.c        | 35 +++++++----------------------------
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 655dc5ce3240..c765ba0a3a67 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -499,9 +499,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	set_canary(meta);
 
 	/*
-	 * We check slab_want_init_on_alloc() ourselves, rather than letting
-	 * SL*B do the initialization, as otherwise we might overwrite KFENCE's
-	 * redzone.
+	 * SLUB will generally init kfence objects, but due to possible
+	 * interactions with KASAN, it might not happen, so do it ourselves.
+	 * In the worst case the init just happens twice.
 	 */
 	if (unlikely(slab_want_init_on_alloc(gfp, cache)))
 		memzero_explicit(addr, size);
diff --git a/mm/slub.c b/mm/slub.c
index 63c1ef998dd3..f787dc422d1b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4565,26 +4565,14 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 
 static __fastpath_inline
 bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-			  gfp_t flags, size_t size, void **p, bool init,
+			  gfp_t flags, size_t size, void **p,
 			  unsigned int orig_size)
 {
-	unsigned int zero_size = s->object_size;
+	bool init = slab_want_init_on_alloc(flags, s);
 	bool kasan_init = init;
 	size_t i;
 	gfp_t init_flags = flags & gfp_allowed_mask;
 
-	/*
-	 * For kmalloc object, the allocated memory size(object_size) is likely
-	 * larger than the requested size(orig_size). If redzone check is
-	 * enabled for the extra space, don't zero it, as it will be redzoned
-	 * soon. The redzone operation for this extra space could be seen as a
-	 * replacement of current poisoning under certain debug option, and
-	 * won't break other sanity checks.
-	 */
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
-	    (s->flags & SLAB_KMALLOC))
-		zero_size = orig_size;
-
 	/*
 	 * When slab_debug is enabled, avoid memory initialization integrated
 	 * into KASAN and instead zero out the memory via the memset below with
@@ -4607,7 +4595,7 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
 		if (p[i] && init && (!kasan_init ||
 				     !kasan_has_integrated_init()))
-			memset(p[i], 0, zero_size);
+			memset(p[i], 0, orig_size);
 		if (gfpflags_allow_spinning(flags))
 			kmemleak_alloc_recursive(p[i], s->object_size, 1,
 						 s->flags, init_flags);
@@ -4908,7 +4896,6 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
-	bool init = false;
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
@@ -4924,16 +4911,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
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
@@ -5228,7 +5212,6 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 				   struct slab_sheaf *sheaf)
 {
 	void *ret = NULL;
-	bool init;
 
 	if (sheaf->size == 0)
 		goto out;
@@ -5238,10 +5221,8 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 	if (likely(!ret))
 		ret = sheaf->objects[--sheaf->size];
 
-	init = slab_want_init_on_alloc(gfp, s);
-
 	/* add __GFP_NOFAIL to force successful memcg charging */
-	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
+	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, s->object_size);
 out:
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
 
@@ -5421,8 +5402,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
-			     slab_want_init_on_alloc(alloc_gfp, s), orig_size);
+	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret, orig_size);
 
 	ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
 	return ret;
@@ -7337,8 +7317,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
 
 out:
 	/* memcg and kmem_cache debug support and memory initialization */
-	return likely(slab_post_alloc_hook(s, NULL, flags, size, p,
-			slab_want_init_on_alloc(flags, s), s->object_size));
+	return likely(slab_post_alloc_hook(s, NULL, flags, size, p, s->object_size));
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 

-- 
2.54.0


