Return-Path: <cgroups+bounces-16773-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8CJlJ8PeJ2rn3gIAu9opvQ
	(envelope-from <cgroups+bounces-16773-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603565E666
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O+lAReT+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16773-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16773-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7FF30EF2A6
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF73F824D;
	Tue,  9 Jun 2026 09:18:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340EB3F7AAD;
	Tue,  9 Jun 2026 09:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996723; cv=none; b=fMj7irqDagHmqatm4UflUa9NEKq2hU9F1OEE0zPnRIFFKlCwZvfasGGhj+jTIXPGaknsvo4WQ6BotDzeSFcIFd1q5DwtMWyFAwPsR19bRIECLHqh0TKzoQwzIIQdK7ZdYZfhHORRkEq3gJimgtmOo7t/tOlg80/j0EPXDXW5j74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996723; c=relaxed/simple;
	bh=vH2bBbOqcUBCCxFiLJQnffo+gmkcd0R244f929l+WOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tr1jaAsuFXvheV7cZogcfdwSsCV/wjNhELJMoAAoiZe5pxayD7KTEwKcXVCqWf6aLhWd5sQI8X4joMJMeG8NIrMfRY4N607hloMWuJoxgRZBQfeOO6CZ6TwiXQiyq2eCSiHorx0mN/yms2sh5/8Co24OH64yhh96E/K9XN8w+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+lAReT+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F781F00898;
	Tue,  9 Jun 2026 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996721;
	bh=EpyqwcPlF0qyNQnaXmyS4YqGBf1HLcYFrD5EYMZEjBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O+lAReT+de6tcsvpGObqmLv84nKfJpswHPzAsYVqWrSc1Rm5kscoCNYsBp3VqEiCj
	 Cr5rpl5kMEms+MH3xFCJL1bGnE1fKZjYD19QtwgDsBl8c6K0xoAG6k8MT3VGaI5jEP
	 bVfpGaWs6N3RVr+MvZKISWQ/KaPIhRJDvad4or6/t40uemY6/LuU3W2UWvFf5EHyn0
	 wYBOC0rZ1Qik7J+SbjLCAmY6lZdbqjUQlyVleLXVNV0ucwQj2vhsT5sUz22NYVWn3V
	 q+IJR5eeFHB61kJK67afYWzLr/XEzT9a8L2+h63lGCac32xze8X63Gn9HxsmoMlTWV
	 nRf6aXvzeJpeQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:57 +0200
Subject: [PATCH RFC 12/15] mm/slab: introduce kmalloc_flags()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-12-2bf4a4b9b526@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16773-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0603565E666

With alloc_flags usage in slab, we can replace __GFP_NO_OBJ_EXT with an
alloc flag that prevents kmalloc recursion. For that we need a version
of kmalloc() that takes alloc_flags and use it in places that perform
these potentially recursive kmalloc allocations (of sheaves or obj_ext
arrays).

Add this function, named kmalloc_flags(). Right now it's only useful for
these nested allocations, so it doesn't need to optimize build-time
constant sizes like kmalloc() or kmalloc_buckets.

Since we need it to support both normal and non-spinning
kmalloc_nolock() context through the SLAB_ALLOC_TRYLOCK flag, split out
most of the special _kmalloc_nolock_noprof() implementation to
__kmalloc_nolock_noprof() that takes a slab_alloc_context, and make
_kmalloc_nolock_noprof() a simple tail calling wrapper with the proper
context.

kmalloc_flags() can thus determine whether to call
__kmalloc_nolock_noprof() or __do_kmalloc_node(), based on the
given alloc_flags.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/slab.h | 12 +++++++++++
 mm/slub.c            | 56 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index ce1c867dc0ba..11e82fdbe8d3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -944,6 +944,10 @@ void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
 void *__kmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags, int node)
 				__assume_kmalloc_alignment __alloc_size(1);
 
+void *__kmalloc_flags_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags,
+				  unsigned int alloc_flags, int node)
+				  __assume_kmalloc_alignment __alloc_size(1);
+
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
 				__assume_kmalloc_alignment __alloc_size(3);
 
@@ -1176,6 +1180,14 @@ static __always_inline __alloc_size(1) void *_kmalloc_node_noprof(size_t size, g
 #define kmalloc_node_noprof(...)		_kmalloc_node_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
 #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
+static __always_inline __alloc_size(1) void *_kmalloc_flags_noprof(size_t size,
+		gfp_t flags, unsigned int alloc_flags, int node, kmalloc_token_t token)
+{
+	return __kmalloc_flags_noprof(PASS_TOKEN_PARAMS(size, token), flags, alloc_flags, node);
+}
+#define kmalloc_flags_noprof(...)		_kmalloc_flags_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
+#define kmalloc_flags(...)			alloc_hooks(kmalloc_flags_noprof(__VA_ARGS__))
+
 static inline __alloc_size(1, 2) void *_kmalloc_array_noprof(size_t n, size_t size, gfp_t flags, kmalloc_token_t token)
 {
 	size_t bytes;
diff --git a/mm/slub.c b/mm/slub.c
index c11edd58b52d..86691eb14002 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5370,15 +5370,15 @@ void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node)
+static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags,
+				     int node, struct slab_alloc_context *ac)
 {
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
-	size_t orig_size = size;
-	unsigned int alloc_flags = SLAB_ALLOC_TRYLOCK;
 	struct kmem_cache *s;
 	bool can_retry = true;
 	void *ret;
 
+	VM_WARN_ON_ONCE(alloc_flags_allow_spinning(ac->alloc_flags));
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
 				      __GFP_NO_OBJ_EXT));
 
@@ -5413,23 +5413,17 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, alloc_gfp, alloc_flags, node);
+	ret = alloc_from_pcs(s, alloc_gfp, ac->alloc_flags, node);
 	if (ret)
 		goto success;
 
-	struct slab_alloc_context ac = {
-		.caller_addr = _RET_IP_,
-		.orig_size = orig_size,
-		.alloc_flags = alloc_flags,
-	};
-
 	/*
 	 * Do not call slab_alloc_node(), since trylock mode isn't
 	 * compatible with slab_pre_alloc_hook/should_failslab and
 	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
-	ret = __slab_alloc_node(s, alloc_gfp, node, &ac);
+	ret = __slab_alloc_node(s, alloc_gfp, node, ac);
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
@@ -5452,11 +5446,23 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, alloc_gfp, 1, &ret, &ac);
+	slab_post_alloc_hook(s, alloc_gfp, 1, &ret, ac);
 
-	ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
+	ret = kasan_kmalloc(s, ret, ac->orig_size, alloc_gfp);
 	return ret;
 }
+
+void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node)
+{
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_TRYLOCK,
+	};
+
+	return __kmalloc_nolock_noprof(PASS_TOKEN_PARAMS(size, token),
+				       gfp_flags, node, &ac);
+}
 EXPORT_SYMBOL_GPL(_kmalloc_nolock_noprof);
 
 void *__kmalloc_node_track_caller_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags,
@@ -5510,6 +5516,30 @@ void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
 }
 EXPORT_SYMBOL(__kmalloc_cache_node_noprof);
 
+/*
+ * The only version of kmalloc_node() that takes alloc_flags and thus can
+ * determine on its own whether to handle the allocation via kmalloc_nolock() or
+ * normally
+ */
+void *__kmalloc_flags_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags,
+			     unsigned int alloc_flags, int node)
+{
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = alloc_flags,
+	};
+
+	if (alloc_flags_allow_spinning(alloc_flags)) {
+		return __do_kmalloc_node(size, NULL, flags, node,
+				PASS_TOKEN_PARAM(token), &ac);
+	} else {
+		return __kmalloc_nolock_noprof(PASS_TOKEN_PARAMS(size, token),
+					       flags, node, &ac);
+	}
+}
+
+
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,

-- 
2.54.0


