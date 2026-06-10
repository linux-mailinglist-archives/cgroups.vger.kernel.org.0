Return-Path: <cgroups+bounces-16825-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qsqwLBmLKWpcZAMAu9opvQ
	(envelope-from <cgroups+bounces-16825-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:04:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29666B24F
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JDGT057Y;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16825-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16825-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39621309F4B6
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5043E49B;
	Wed, 10 Jun 2026 15:42:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167341C302;
	Wed, 10 Jun 2026 15:42:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106124; cv=none; b=UJxqYvnj2IdHU+jKTy/EGTnAe+QYk9Anr+AhHDKdigzsnPB1tbaKGgTxm2wgl5fNIlWRC71BZf3zeelM1Q/4P0pg8TligDToxbO6WK6DrSHt6O3Gh07jo9XVf4ABPIs4lTIt55vvSi1rdFo3sV2Nm1XUdpsIcKLmhIBFwohlgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106124; c=relaxed/simple;
	bh=E3a6nBvzaPsYrqInn8x63O5jfBd9tk7neG0PWoNozdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=go4QlGm0S5GP6z6+EA7+UuQbXlzqXbx1sddNROh80EkAU7/8GV0NOVS2l/Ffpx0Fl2Urb6+eHKSGOqD9CH1SwkBwJDnPbrk7UzJoPR1ZKZmVeZugvs1kCln8RmVIFU/V/ggMMVF4WSzsXERmS2/M07yqi1SX555TGFzW569s0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDGT057Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7771F00893;
	Wed, 10 Jun 2026 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106123;
	bh=5z1rZN9sqWsWaxKpHBc5tulXDwFk9WStgfZajrZ0EDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JDGT057YotqaJUSdir5KmN+Jl5ptw2nNXgLoxRjoGKKMDlQ9glv9FolEVJS50/ldy
	 rESgVlL3FtpMk2/8euhOLgExEvxrwX2ZgfYX5w5nkMlkoMBqWcJGIXw8UuXWnM9m+z
	 lEGE2JVClQdV4QwnlXSZPyTAgorq9fhTsh1h3yDSFElmKEuAGqiLtKdXPaetwinquY
	 BAJ6JWi2lxvZEzopFmdi4g6BKfwLS3AuTrtKrfqaPYXp6ivxGadt4ANl9K5V8oxM1W
	 aLi0kVocb1hst4K9iGWp6ZfIWUvBLDH/m2eaB/hDtrab2HQ6QGOGWhHomO09LoQkea
	 uTtz6wpYW9Tzw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:16 +0200
Subject: [PATCH v2 14/16] mm/slab: introduce kmalloc_flags()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-14-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-16825-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB29666B24F

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
 mm/slab.h | 13 +++++++++++++
 mm/slub.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 4db6d8aa0ee3..45bfcfb35a9c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,6 +11,7 @@
 #include <linux/memcontrol.h>
 #include <linux/kfence.h>
 #include <linux/kasan.h>
+#include <linux/slab.h>
 
 /*
  * Internal slab definitions
@@ -26,6 +27,18 @@ static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 	return !(alloc_flags & SLAB_ALLOC_TRYLOCK);
 }
 
+void *__kmalloc_flags_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags,
+				  unsigned int alloc_flags, int node)
+				  __assume_kmalloc_alignment __alloc_size(1);
+
+static __always_inline __alloc_size(1) void *_kmalloc_flags_noprof(size_t size,
+		gfp_t flags, unsigned int alloc_flags, int node, kmalloc_token_t token)
+{
+	return __kmalloc_flags_noprof(PASS_TOKEN_PARAMS(size, token), flags, alloc_flags, node);
+}
+#define kmalloc_flags_noprof(...)	_kmalloc_flags_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
+#define kmalloc_flags(...)		alloc_hooks(kmalloc_flags_noprof(__VA_ARGS__))
+
 #ifdef CONFIG_64BIT
 # ifdef system_has_cmpxchg128
 # define system_has_freelist_aba()	system_has_cmpxchg128()
diff --git a/mm/slub.c b/mm/slub.c
index 847cad5203b2..cbb38bd01e46 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5386,14 +5386,14 @@ void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node)
+static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags,
+				     int node, struct slab_alloc_context *ac)
 {
-	size_t orig_size = size;
-	unsigned int alloc_flags = SLAB_ALLOC_TRYLOCK;
 	struct kmem_cache *s;
 	bool can_retry = true;
 	void *ret;
 
+	VM_WARN_ON_ONCE(alloc_flags_allow_spinning(ac->alloc_flags));
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
 			__GFP_NO_OBJ_EXT | __GFP_NOWARN | __GFP_NOMEMALLOC));
 
@@ -5430,23 +5430,17 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 		 */
 		return NULL;
 
-	ret = alloc_from_pcs(s, gfp_flags, alloc_flags, node);
+	ret = alloc_from_pcs(s, gfp_flags, ac->alloc_flags, node);
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
-	ret = __slab_alloc_node(s, gfp_flags, node, &ac);
+	ret = __slab_alloc_node(s, gfp_flags, node, ac);
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
@@ -5469,11 +5463,23 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, gfp_flags, 1, &ret, &ac);
+	slab_post_alloc_hook(s, gfp_flags, 1, &ret, ac);
 
-	ret = kasan_kmalloc(s, ret, orig_size, gfp_flags);
+	ret = kasan_kmalloc(s, ret, ac->orig_size, gfp_flags);
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
@@ -5527,6 +5533,30 @@ void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
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


