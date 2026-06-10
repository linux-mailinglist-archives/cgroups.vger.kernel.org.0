Return-Path: <cgroups+bounces-16819-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8e/5GwyIKWpQYwMAu9opvQ
	(envelope-from <cgroups+bounces-16819-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:51:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01E66B0B2
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:51:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nIC4+tgu;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16819-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16819-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70A6B313A0DF
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7F42EEAA;
	Wed, 10 Jun 2026 15:41:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB2466B74;
	Wed, 10 Jun 2026 15:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106079; cv=none; b=MeN8nFWISVCc/PPp33nYtHwzWmzLex316zpgXS8q7B/a+nF7WCB/Hq7h4JpWfRB2zW3uL4+24xxGR8BWuSgtaRgZxFU7w3hk9LTfM4z3vOADr2D8+/vThHXwc4y20x+v3CDPV/gU7XSz+difqBHqH9vlGRMRKxLSV+NY7unIdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106079; c=relaxed/simple;
	bh=fuvEkNGOaa1Ud/36lrMH0EnDnBb52t0E2Z0UOSqbU5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoPQViINOxzYtal/ajZMu2MSsuFf/s9jywFn0M8TElPzsBg/uj8mYS99Zv9uZR3tWYwIIIvWgzgRXRGtYbGqrsaSSvl3RkwiSMOwHm+ztULxzTf1OIfVhGmFbFmF1rgIHKxICiDemdUh+BjheuRagHeFjAYIu06MnqEEHCnRcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIC4+tgu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3922E1F00893;
	Wed, 10 Jun 2026 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106077;
	bh=zw7OfgTsThDHzuQXS+OL+Mrf7Mf3Iw/m9nWLfYn615A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nIC4+tguZQTWq8AmKG92I9Jn9Q7ZciPLThGgiggAl2kImmdgWPpBQenefZeEvZRlx
	 ey5e2PnNze0f+V3yjUZarwjMTpXmCZeH+YkpxeTzLUYWfr8qcI6FMNVFNa0666iQd+
	 3Rm3WN2juaXNqUcFbjgtIcFY1gcJM52rNy9hoN1tqd7h85HqHkjl/u6VxBwv1KmPno
	 kcdu1liXPl9KXtdVvu1btuA1W57iiBEFl/2Mg169S39LQB+ANgVEe4zn8UyDjlRqfS
	 PpxQ1lvKTKgF7ZcW+3qjhHRH12ZVTaRYU0W3gACrtD4bbBYFpS0JlUuuHKw/PcAUiX
	 rltrfMALmUqrw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:10 +0200
Subject: [PATCH v2 08/16] mm/slab: pass alloc_flags to new slab allocation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16819-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F01E66B0B2

Add the alloc_flags parameter to allocate_slab() and new_slab()
so it can be used to determine if spinning is allowed, independently
from gfp flags.

refill_objects() passes SLAB_ALLOC_DEFAULT because it can only be
reached from contexts that allow spinning.

Also change how trynode_flags are constructed in ___slab_alloc() to
achieve the same "do not upgrade to GFP_NOWAIT" by using masking instead
of a branch. It will now also not upgrade in cases where gfp is weaker
than GFP_NOWAIT (i.e. lacks __GFP_KSWAPD_RECLAIM) but doesn't come from
kmalloc_nolock() - which is more correct anyway.

During the masking keep also existing __GFP_NOMEMALLOC (pointed out by
Sashiko) and __GFP_ACCOUNT. Previously the hardcoded GFP_NOWAIT would
eliminate them, but it's not a big problem that would need a separate
fix.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 98b79e5e7679..8f6ca3d5fdfa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3378,9 +3378,10 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 }
 
 /* Allocate and initialize a slab without building its freelist. */
-static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
+static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
+				  unsigned int alloc_flags, int node)
 {
-	bool allow_spin = gfpflags_allow_spinning(flags);
+	bool allow_spin = alloc_flags_allow_spinning(alloc_flags);
 	struct slab *slab;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
@@ -3438,15 +3439,17 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	return slab;
 }
 
-static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+static struct slab *new_slab(struct kmem_cache *s, gfp_t flags,
+			     unsigned int alloc_flags, int node)
 {
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
-	return allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+	flags &= GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK;
+
+	return allocate_slab(s, flags, alloc_flags, node);
 }
 
 static void __free_slab(struct kmem_cache *s, struct slab *slab, bool allow_spin)
@@ -4467,25 +4470,22 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * 1) try to get a partial slab from target node only by having
 	 *    __GFP_THISNODE in pc.flags for get_from_partial()
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
 	if (object)
 		goto success;
 
-	slab = new_slab(s, trynode_flags, node);
+	slab = new_slab(s, trynode_flags, ac->alloc_flags, node);
 
 	if (unlikely(!slab)) {
 		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
@@ -7231,7 +7231,7 @@ refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 
 new_slab:
 
-	slab = new_slab(s, gfp, local_node);
+	slab = new_slab(s, gfp, SLAB_ALLOC_DEFAULT, local_node);
 	if (!slab)
 		goto out;
 
@@ -7579,7 +7579,7 @@ static void early_kmem_cache_node_alloc(int node)
 
 	BUG_ON(kmem_cache_node->size < sizeof(struct kmem_cache_node));
 
-	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
+	slab = new_slab(kmem_cache_node, GFP_NOWAIT, SLAB_ALLOC_DEFAULT, node);
 
 	BUG_ON(!slab);
 	if (slab_nid(slab) != node) {

-- 
2.54.0


