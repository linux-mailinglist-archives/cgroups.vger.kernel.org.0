Return-Path: <cgroups+bounces-16816-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2MYMMiIKWqEYwMAu9opvQ
	(envelope-from <cgroups+bounces-16816-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:54:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA466B11D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:54:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aCXPhkm8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16816-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16816-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4387F34A5C6B
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDD42848C;
	Wed, 10 Jun 2026 15:40:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9F416D1D;
	Wed, 10 Jun 2026 15:40:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106058; cv=none; b=YK8DoxNz36LcyZvOsHHlpaoZwWz9K3QKOIbmxgUwAjoerbRRM0xuZpnFXdWl/nAJsNCyEVuDyORszj3qSX60uNTQS1mS+ydSNQ2Q/NRv/H598x+1I2K6jA/EAtR8yHCACE8PvetISoms3UwTHRPBI+lC1ibpIZ+utd5CxQSyuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106058; c=relaxed/simple;
	bh=e+XV3AZqAoAC7RIKgePG4YKkJSPPEI10nmOB2NUI12c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4xFqkGGQtfEEO9jDCoHsuQiWbu4Z4H2MGZMMj0GbsYUawj8paEQlloZMETjBNIjCBk4ckxzdE60hBbVFYf8fERSyBbm+zdJV49F3KwqBAwqpIyYmdoB6YeXUBP5GdBRQvoFbalG99j8KMlACWjeKMnxQfcketAjcPeV/ht9aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCXPhkm8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E11F00898;
	Wed, 10 Jun 2026 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106057;
	bh=uzrQqVr+7rwNnJX12Vdm6hcXiPQHxl3cGwRGRVjeEkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aCXPhkm8nAkdUVhcPCJUTOjkUtEJISo7BfGZrCD7i28tiCbagbHjNon8sAPgrzyYc
	 2RkRNiVBG+fSPgFQixWt62WNno7HDDOpVLkxlbVAOff0N2BRYxkY26fOCMQgqnxIQg
	 Vo6/+wKzhCMrPVUUkdYBvEko/zuKCyMmAc5ejtIHc93n94xPW9QfEejrYaYkqazkc0
	 TZ+dRNAy1COnYajg+g3r+nMP1/8JHCUZ3ShqlSynY7NQKWfgT6lUPu/5jED69sEsyf
	 rTxnFxgtwHqzh6qGp2iD7D9WVL1dU3WYdmEvzAnc8FubCtBIY8M6+XDQ9jNguIIFzo
	 OR6jq3M1atcFA==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:07 +0200
Subject: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-16816-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13BA466B11D

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
index 1bf9c3021ae3..96f65b625600 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -16,6 +16,15 @@
  * Internal slab definitions
  */
 
+/* slab's alloc_flags definitions */
+#define SLAB_ALLOC_DEFAULT	0x00 /* no flags */
+#define SLAB_ALLOC_TRYLOCK	0x01 /* a kmalloc_nolock() allocation */
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
index a3cac7281cc6..e79fbca11bc0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4638,7 +4638,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
  * unlocked.
  */
 static struct slub_percpu_sheaves *
-__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
+__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
+			 gfp_t gfp, unsigned int alloc_flags)
 {
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
@@ -4664,7 +4665,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	allow_spin = gfpflags_allow_spinning(gfp);
+	allow_spin = alloc_flags_allow_spinning(alloc_flags);
 
 	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
@@ -4750,7 +4751,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 }
 
 static __fastpath_inline
-void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
+void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, unsigned int alloc_flags, int node)
 {
 	struct slub_percpu_sheaves *pcs;
 	bool node_requested;
@@ -4795,7 +4796,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == 0)) {
-		pcs = __pcs_replace_empty_main(s, pcs, gfp);
+		pcs = __pcs_replace_empty_main(s, pcs, gfp, alloc_flags);
 		if (unlikely(!pcs))
 			return NULL;
 	}
@@ -4928,7 +4929,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	object = alloc_from_pcs(s, gfpflags, node);
+	object = alloc_from_pcs(s, gfpflags, SLAB_ALLOC_DEFAULT, node);
 
 	if (unlikely(!object)) {
 		struct slab_alloc_context ac = {
@@ -5359,6 +5360,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 {
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
 	size_t orig_size = size;
+	unsigned int alloc_flags = SLAB_ALLOC_TRYLOCK;
 	struct kmem_cache *s;
 	bool can_retry = true;
 	void *ret;
@@ -5397,7 +5399,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, alloc_gfp, node);
+	ret = alloc_from_pcs(s, alloc_gfp, alloc_flags, node);
 	if (ret)
 		goto success;
 
@@ -7216,9 +7218,6 @@ refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
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


