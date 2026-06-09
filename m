Return-Path: <cgroups+bounces-16775-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ckR4D8PcJ2pR3gIAu9opvQ
	(envelope-from <cgroups+bounces-16775-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:28:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E251965E542
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:28:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E5ttyo6E;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16775-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16775-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C23F0319DCA6
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FC3F8883;
	Tue,  9 Jun 2026 09:18:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6E3F39D0;
	Tue,  9 Jun 2026 09:18:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996731; cv=none; b=MN1lNHhtsloiUWzFEozWG3ekawbeAr6w2gxV95NifrrpqM8nE3o3+tvMeUAQCo8C2O3OvI1HTGOJpdaly11TSH9pm0oJSLffuhu5iBGHtyj2aVcJ3btc3xPDGld/d0eTCBJh+hnYi84bK6t78Ct9tOvvNFgH20AcCabSJrLXesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996731; c=relaxed/simple;
	bh=Uu7TihQ3xjju8J7pOBh/8HGwqevf6Z0TEQ5ELjXalds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joh9wGfC3sz72jyrk9nHe4q54s9Lri0/XxVFKYOcNOeyHBCQD3w0nQ2OzU3J+7ZrFhoWLyxccSRoWhPvu4yT5Ejfi85lX19u/Y+qv6axxLQYDdRjK3+crmhPCXA6fZouhvtaUcewmOIdSLPJNim94NmfMiF+ACDgWJ988H6W0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5ttyo6E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B091F00898;
	Tue,  9 Jun 2026 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996729;
	bh=1k7/eTSRSHQNvSATdJogMPt72tbv5SKy6aqMXKlQdps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E5ttyo6EIovS3/k53exumTPWOrIocAsvVAtZsCcCAqVey/Y2FBd9f/WqJKuwQ34V7
	 kZqDaW/cdyFFmirlN+XMZ5wiwErTgpFbnVW+UyKwMOrAWfy9zdteOBHvniutyD9etH
	 mCNKy7Q3nXTcBVT9RCleh9vO5LhJyH8tnQfNuK9RcJZcGFY2YbDJt+nN9ioqA5lfil
	 SIixSHW6fPLIoKLLLyQQiH7H7krkaSQ9lIqYujeiGaDBX6QIp192Ac9jOW5f5SkPjo
	 AwgtiSNSX4MONA+8Ujv8Vst7Szur37JtBHHd2Nee6RH9bBdPDsDlO/M7dMUSaOXLbq
	 GDWZH6ix/RM1w==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:59 +0200
Subject: [PATCH RFC 14/15] mm/slab: replace __GFP_NO_OBJ_EXT with
 SLAB_ALLOC_NO_RECURSE for sheaves
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-14-2bf4a4b9b526@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-16775-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: E251965E542

Finish the switch away from __GFP_NO_OBJ_EXT by replacing it with
SLAB_ALLOC_NO_RECURSE when allocating empty sheaves. Pass alloc_flags to
[__]alloc_empty_sheaf(). Callers that can't be part of a recursive
kmalloc() chain simply pass SLAB_ALLOC_DEFAULT. Use kmalloc_flags()
instead of kzalloc() for allocating the sheaf.

This leaves __GFP_NO_OBJ_EXT with no users, to be removed next.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8a655636dee6..26ec015efdba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2756,7 +2756,7 @@ static inline void *setup_object(struct kmem_cache *s, void *object)
 }
 
 static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
-					      unsigned int capacity)
+				unsigned int alloc_flags, unsigned int capacity)
 {
 	struct slab_sheaf *sheaf;
 	size_t sheaf_size;
@@ -2767,10 +2767,10 @@ static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
 	 * bucket)
 	 */
 	if (s->flags & SLAB_KMALLOC)
-		gfp |= __GFP_NO_OBJ_EXT;
+		alloc_flags |= SLAB_ALLOC_NO_RECURSE;
 
 	sheaf_size = struct_size(sheaf, objects, capacity);
-	sheaf = kzalloc(sheaf_size, gfp);
+	sheaf = kmalloc_flags(sheaf_size, gfp | __GFP_ZERO, alloc_flags, NUMA_NO_NODE);
 
 	if (unlikely(!sheaf))
 		return NULL;
@@ -2783,20 +2783,20 @@ static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
 }
 
 static inline struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s,
-						   gfp_t gfp)
+				gfp_t gfp, unsigned int alloc_flags)
 {
-	if (gfp & __GFP_NO_OBJ_EXT)
+	if (alloc_flags & SLAB_ALLOC_NO_RECURSE)
 		return NULL;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 
-	return __alloc_empty_sheaf(s, gfp, s->sheaf_capacity);
+	return __alloc_empty_sheaf(s, gfp, alloc_flags, s->sheaf_capacity);
 }
 
 static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 {
 	/*
-	 * If the sheaf was created with __GFP_NO_OBJ_EXT flag then its
+	 * If the sheaf was created with SLAB_ALLOC_NO_RECURSE flag then its
 	 * corresponding extension is NULL and alloc_tag_sub() will throw a
 	 * warning, therefore replace NULL with CODETAG_EMPTY to indicate
 	 * that the extension for this sheaf is expected to be NULL.
@@ -4673,7 +4673,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 
 	if (!empty) {
-		empty = alloc_empty_sheaf(s, gfp);
+		empty = alloc_empty_sheaf(s, gfp, alloc_flags);
 		if (!empty)
 			return NULL;
 	}
@@ -5047,7 +5047,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 
 	if (unlikely(size > s->sheaf_capacity)) {
 
-		sheaf = __alloc_empty_sheaf(s, gfp, size);
+		sheaf = __alloc_empty_sheaf(s, gfp, SLAB_ALLOC_DEFAULT, size);
 		if (!sheaf)
 			return NULL;
 
@@ -5092,7 +5092,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 
 
 	if (!sheaf)
-		sheaf = alloc_empty_sheaf(s, gfp);
+		sheaf = alloc_empty_sheaf(s, gfp, SLAB_ALLOC_DEFAULT);
 
 	if (sheaf) {
 		sheaf->capacity = s->sheaf_capacity;
@@ -5376,8 +5376,7 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
 	void *ret;
 
 	VM_WARN_ON_ONCE(alloc_flags_allow_spinning(ac->alloc_flags));
-	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
-				      __GFP_NO_OBJ_EXT));
+	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
 
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
@@ -5890,7 +5889,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	if (!allow_spin)
 		return NULL;
 
-	empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+	empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
 	if (empty)
 		goto got_empty;
 
@@ -6074,7 +6073,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 		local_unlock(&s->cpu_sheaves->lock);
 
-		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
 
 		if (!empty)
 			goto fail;
@@ -7619,7 +7618,7 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 		if (!s->sheaf_capacity)
 			pcs->main = &bootstrap_sheaf;
 		else
-			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL, SLAB_ALLOC_DEFAULT);
 
 		if (!pcs->main)
 			return -ENOMEM;
@@ -8485,7 +8484,8 @@ static void __init bootstrap_cache_sheaves(struct kmem_cache *s)
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		pcs->main = __alloc_empty_sheaf(s, GFP_KERNEL, capacity);
+		pcs->main = __alloc_empty_sheaf(s, GFP_KERNEL,
+				SLAB_ALLOC_DEFAULT, capacity);
 
 		if (!pcs->main) {
 			failed = true;

-- 
2.54.0


