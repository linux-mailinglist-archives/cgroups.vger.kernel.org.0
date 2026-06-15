Return-Path: <cgroups+bounces-16957-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id viEaCL/oL2p+IwUAu9opvQ
	(envelope-from <cgroups+bounces-16957-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:57:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83150685E53
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 13:57:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AWC46ogu;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16957-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16957-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD8A304A661
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F63E92B7;
	Mon, 15 Jun 2026 11:55:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB593E558A;
	Mon, 15 Jun 2026 11:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524509; cv=none; b=ntytDFlT5CP1ChGjJPHVZmcr4a8KGEugeEKr7JJluy46+3an2vtZTF7mqbcP2Rc6fZfvDhB4t3bv/QNM8Q/n5IAQCMv3I3VOOVL8NUsBKeGwF3nwIEcT9BHv+QCCwOD7ZBgH6afAyZvw7Yz/EnRjN38Wd+sbGu5LGguOfjveM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524509; c=relaxed/simple;
	bh=kUhMlsSWxtf42zaZR9a3XQ6yvqG+mZDCBSFmfErTTno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eczq+gEcFb4OQv7sDIJfHvxYhv67uaMHZocwmy4lzRvx/eLG8NMprh6rM9I9dKlyZ7ZAXR5cq9ue/SGknRLgQ59OlVPufUx/ESjI8URcJRthTAbwCmXCznwCHLaaCKIgAsiDM6rnT600sg69wOu1asTz4qhZ3nmNxMvkcol8l2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWC46ogu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985AC1F000E9;
	Mon, 15 Jun 2026 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524508;
	bh=KsQDkH3NB7HMKXjyEodAbkV9bHFoqveFAU9ferOkqko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AWC46ogu0sYJ/Rr7SWenD+Jg+OOXx0c6mLS2CDXgfEIr8g3KbNy6gcXh5Ku1FkLjd
	 rxY037pOgmf6k9WiSYcPfWopQf6SEBcES52i0ROrfcEUCp0HGXJnlcEgMcyp7jXs/2
	 8L+v9q9p7FMIx8ts1KJOe77SQezoNySATrCwoIVE4X5moiLl5DDbWI0i/i0NuBAWcW
	 YLmX4m6/BuXw5xFNUu6NjlmFVT4BLCamUu2EXKR2lY59/GYr8Vm+ZsBlKk6IiSeV7q
	 zAyz7k8tk3jpRyFRDsTpVqq/uoVpimEUSBS3VscwvaTYsXO/2jg4a0Oou1CbY7JeyE
	 5LPoY/V5e4B4Q==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:39 +0200
Subject: [PATCH v3 06/15] mm/slab: add alloc_flags to slab_alloc_context
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-6-ce1146d140fb@kernel.org>
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16957-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83150685E53

Add alloc_flags as a new field to the slab_alloc_context helper struct,
so we can pass it to more functions in the slab implementation without
adding another function parameter.

Start checking them via alloc_flags_allow_spinning() in
alloc_single_from_new_slab() (where we can drop the allow_spin
parameter), ___slab_alloc(), get_from_partial_node() and
get_from_any_partial(). This further reduces false-positive
spinning-not-allowed from allocations that are not kmalloc_nolock() but
lack __GFP_RECLAIM flags.

_kmalloc_nolock_noprof() initializes ac.alloc_flags using its flags that
are SLAB_ALLOC_NOLOCK. slab_alloc_node() and __kmem_cache_alloc_bulk()
are not reachable from kmalloc_nolock() and all their callers expect
spinning to be allowed, so they can use SLAB_ALLOC_DEFAULT. This is
temporary as the scope of slab_alloc_context will further move to the
callers, making the alloc_flags usage more obvious.

Also change how trynode_flags are constructed in ___slab_alloc() to
achieve the same "do not upgrade to GFP_NOWAIT" by using masking instead
of checking allow_spin. We need to do that because we now determine
allow_spin from alloc_flags, and would otherwise start to upgrade e.g.
kmalloc() allocations without __GFP_KSWAPD_RECLAIM (that however do
allow spinning) to GFP_NOWAIT, thus including __GFP_KSWAPD_RECLAIM.

During the masking keep also existing __GFP_NOMEMALLOC (pointed out by
Sashiko) and __GFP_ACCOUNT. Previously the hardcoded GFP_NOWAIT would
eliminate them, but it's not a big problem that would need a separate
fix.

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6f6c15d796e1..3a34907b881b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -217,6 +217,7 @@ static DEFINE_STATIC_KEY_FALSE(strict_numa);
 struct slab_alloc_context {
 	unsigned long caller_addr;
 	size_t orig_size;
+	unsigned int alloc_flags;
 };
 
 /* Structure holding parameters for get_partial_node_bulk() */
@@ -3687,9 +3688,9 @@ static inline void init_slab_obj_iter(struct kmem_cache *s, struct slab *slab,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
-					const struct slab_alloc_context *ac,
-					bool allow_spin)
+					const struct slab_alloc_context *ac)
 {
+	bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
 	struct kmem_cache_node *n;
 	struct slab_obj_iter iter;
 	bool needs_add_partial;
@@ -3835,7 +3836,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
 	if (!n || !n->nr_partial)
 		return NULL;
 
-	if (gfpflags_allow_spinning(gfp_flags))
+	if (alloc_flags_allow_spinning(ac->alloc_flags))
 		spin_lock_irqsave(&n->list_lock, flags);
 	else if (!spin_trylock_irqsave(&n->list_lock, flags))
 		return NULL;
@@ -3891,7 +3892,7 @@ static void *get_from_any_partial(struct kmem_cache *s, gfp_t gfp_flags,
 	struct zone *zone;
 	enum zone_type highest_zoneidx = gfp_zone(gfp_flags);
 	unsigned int cpuset_mems_cookie;
-	bool allow_spin = gfpflags_allow_spinning(gfp_flags);
+	bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
 
 	/*
 	 * The defrag ratio allows a configuration of the tradeoffs between
@@ -4449,7 +4450,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			   const struct slab_alloc_context *ac)
 {
-	bool allow_spin = gfpflags_allow_spinning(gfpflags);
+	bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
 	gfp_t trynode_flags;
 	void *object;
 	struct slab *slab;
@@ -4466,18 +4467,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * 1) try to get a partial slab from target node only by having
 	 *    __GFP_THISNODE in trynode_flags for get_from_partial()
 	 * 2) if 1) failed, try to allocate a new slab from target node with
-	 *    GPF_NOWAIT | __GFP_THISNODE opportunistically
+	 *    (at most) GFP_NOWAIT | __GFP_THISNODE opportunistically
 	 * 3) if 2) failed, retry with original gfpflags which will allow
 	 *    get_from_partial() try partial lists of other nodes before
 	 *    potentially allocating new page from other nodes
 	 */
 	if (unlikely(node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
 		     && try_thisnode)) {
-		if (unlikely(!allow_spin))
-			/* Do not upgrade gfp to NOWAIT from more restrictive mode */
-			trynode_flags = gfpflags | __GFP_THISNODE;
-		else
-			trynode_flags = GFP_NOWAIT | __GFP_THISNODE;
+		trynode_flags &= GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_ACCOUNT;
+		trynode_flags |= __GFP_NOWARN | __GFP_THISNODE;
 	}
 
 	object = get_from_partial(s, node, trynode_flags, ac);
@@ -4499,7 +4497,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
-		object = alloc_single_from_new_slab(s, slab, ac, allow_spin);
+		object = alloc_single_from_new_slab(s, slab, ac);
 
 		if (likely(object))
 			goto success;
@@ -4918,6 +4916,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
 static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
+	const unsigned int alloc_flags = SLAB_ALLOC_DEFAULT;
 	void *object;
 
 	s = slab_pre_alloc_hook(s, gfpflags);
@@ -4928,12 +4927,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	object = alloc_from_pcs(s, gfpflags, SLAB_ALLOC_DEFAULT, node);
+	object = alloc_from_pcs(s, gfpflags, alloc_flags, node);
 
 	if (unlikely(!object)) {
 		const struct slab_alloc_context ac = {
 			.caller_addr = addr,
 			.orig_size = orig_size,
+			.alloc_flags = alloc_flags,
 		};
 		object = __slab_alloc_node(s, gfpflags, node, &ac);
 	}
@@ -5366,6 +5366,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	const struct slab_alloc_context ac = {
 		.caller_addr = _RET_IP_,
 		.orig_size = orig_size,
+		.alloc_flags = alloc_flags,
 	};
 
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
@@ -7254,6 +7255,7 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 		const struct slab_alloc_context ac = {
 			.caller_addr = _RET_IP_,
 			.orig_size = s->object_size,
+			.alloc_flags = SLAB_ALLOC_DEFAULT,
 		};
 		for (i = 0; i < size; i++) {
 

-- 
2.54.0


