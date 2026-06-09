Return-Path: <cgroups+bounces-16765-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lErkDTPcJ2oy3gIAu9opvQ
	(envelope-from <cgroups+bounces-16765-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:26:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9579765E4F1
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="bljgESA/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16765-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16765-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E683152754
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D53ED5DC;
	Tue,  9 Jun 2026 09:18:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A493F39E5;
	Tue,  9 Jun 2026 09:18:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996691; cv=none; b=rqH57qz7PeDK4yIHbvSpswnKouuMBnUSr7Ab9wxgOrK4VKcmzGcyRUujvM6vQpv5fi7mBR98lo+RrtdCpp4GVIzeLE7NXndYS9AMdWpe2Vnk7uQXQymZlu3ZwQGcDOPehu75FR2jqc7ok3K9Vhkuv28ZH0q4w+ncCJSzJ/9d9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996691; c=relaxed/simple;
	bh=6Snad4aqCNEvwXQP1hrc62/crw8/VOgYZ7yE4VKZ0Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sO9PS9rCwnYVC3zXpd3rArOJnpQfS8GhIACswYMiP5su8NWlnLOTZFm370J7ElsX28Wz89XMCBW5qGJLe/hT8RzvqC+6dzJntaF8OYRUtYKvLulVoQt9up1DcA34+1O8COkHQqWm+bbCvxuM2GBBI0LzrUhU2EKPDLoz6xpElOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bljgESA/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C61F008A1;
	Tue,  9 Jun 2026 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996690;
	bh=D0jKKYeVe3GOsHiT9w2I0J78neM62mSyd5GKmJH2d5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bljgESA/jqmLYPOioHWBwsF8jHKWn4DOAoZBVAKxkywX+5Bf74eaadpUyEuoLLVkm
	 hQv/E4KkGHbO4sbCaR99hIFpwTRlnzKda066KDq0Nh8iAaj1shfHlwZ9CVBUcW3n54
	 6j/O1/6JpQzHWQymZxABYN1ZbyjRN4/VFkCC0HAKgevx9KZGkW1X5ehAndML9xQI4D
	 Rf8ilzwltkI07ufLvxxW2v5nJRZtKg1/Uqsh3iaP4YDVkD+Uj5TQMFklq5JlgEdG4o
	 Co1XBUCYvgDD2R42QFMsvEbBrs7WpuJDU7uT7Qg5flrB49iW5znSMcxKoLfVXwdWTT
	 2WEoJz5Ces8zw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:49 +0200
Subject: [PATCH RFC 04/15] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-4-2bf4a4b9b526@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16765-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9579765E4F1

Similarly to the page allocators, introduce slab-allocator specific
alloc flags that internally control allocation behavior in addition to
gfp_flags, without occupying the limited gfp flags space.

Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
page allocator's ALLOC_TRYLOCK and will be used to reimplement
kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM flags,
importantly __GFP_KSWAPD_RECLAIM. This can give false-positive results
e.g. in early boot with a restricted gfp_allowed_mask.

Also introduce alloc_flags_allow_spinning() to replace the usage of
gfpflags_allow_spinning().

Start using alloc_flags and the new check first in alloc_from_pcs() and
__pcs_replace_empty_main(). This means some slab allocations that were
falsely treated as kmalloc_nolock() due to their gfp flags will now have
higher chances of succeed, and this will further increase with followup
changes.

Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate to
reach it from a slab allocation that's not _nolock() and yet lacks
__GFP_KSWAPD_RECLAIM for other reasons.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h |  9 +++++++++
 mm/slub.c | 17 ++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 1bf9c3021ae3..3e75182ee144 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -16,6 +16,15 @@
  * Internal slab definitions
  */
 
+/* slab's alloc_flags definitions */
+#define SLAB_ALLOC_DEFAULT	0x00
+#define SLAB_ALLOC_TRYLOCK	0x01
+
+static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
+{
+	return !(alloc_flags & SLAB_ALLOC_TRYLOCK);
+}
+
 #ifdef CONFIG_64BIT
 # ifdef system_has_cmpxchg128
 # define system_has_freelist_aba()	system_has_cmpxchg128()
diff --git a/mm/slub.c b/mm/slub.c
index 06fc1656080f..278d8cbcc7ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4622,7 +4622,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
  * unlocked.
  */
 static struct slub_percpu_sheaves *
-__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
+__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
+			 gfp_t gfp, unsigned int alloc_flags)
 {
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
@@ -4648,7 +4649,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	allow_spin = gfpflags_allow_spinning(gfp);
+	allow_spin = alloc_flags_allow_spinning(alloc_flags);
 
 	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
@@ -4734,7 +4735,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 }
 
 static __fastpath_inline
-void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
+void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, unsigned int alloc_flags, int node)
 {
 	struct slub_percpu_sheaves *pcs;
 	bool node_requested;
@@ -4779,7 +4780,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == 0)) {
-		pcs = __pcs_replace_empty_main(s, pcs, gfp);
+		pcs = __pcs_replace_empty_main(s, pcs, gfp, alloc_flags);
 		if (unlikely(!pcs))
 			return NULL;
 	}
@@ -4912,7 +4913,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	object = alloc_from_pcs(s, gfpflags, node);
+	object = alloc_from_pcs(s, gfpflags, SLAB_ALLOC_DEFAULT, node);
 
 	if (unlikely(!object)) {
 		struct slab_alloc_context ac = {
@@ -5343,6 +5344,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 {
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
 	size_t orig_size = size;
+	unsigned int alloc_flags = SLAB_ALLOC_TRYLOCK;
 	struct kmem_cache *s;
 	bool can_retry = true;
 	void *ret;
@@ -5381,7 +5383,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, alloc_gfp, node);
+	ret = alloc_from_pcs(s, alloc_gfp, alloc_flags, node);
 	if (ret)
 		goto success;
 
@@ -7200,9 +7202,6 @@ refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 	unsigned int refilled;
 	struct slab *slab;
 
-	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
-		return 0;
-
 	refilled = __refill_objects_node(s, p, gfp, min, max,
 					 get_node(s, local_node),
 					 /* allow_spin = */ true);

-- 
2.54.0


