Return-Path: <cgroups+bounces-16965-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BHBZLb/pL2rKIwUAu9opvQ
	(envelope-from <cgroups+bounces-16965-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26468685F02
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LZh8Qh++;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16965-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16965-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7307D3039F7A
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060883E5A0D;
	Mon, 15 Jun 2026 11:55:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B13E9C14;
	Mon, 15 Jun 2026 11:55:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524540; cv=none; b=s2FHmwyE4qbdcmuX+N0eQhckxm2pg9aLBT6Ic9mqt9buPs6LTAS5Hxjzg4/+QuK0nS0TvyacPpVK9OSLcIte9H82B5PoYJ/tXxbMvPM0tGcOqU0z/8nJh8BPRppbMph1NYH4HddBgukp4IePzI+HxGozoTx0wzmkuGPs3DEl6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524540; c=relaxed/simple;
	bh=lrd0yb9ezeFE4+n3RCeBe0Hq8qJHRZzz1bTUJ4RHxcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuLCdwhwE53e9Im6md/3tTDht//WKxrhLH1Yu/9WXDZFhKb8mPOVhJhlqrSvEGzv5OWjAc7cer8rJOpKzjWVs78d+IyYnQtR+eWNxlGLbVSPCUqnBb3gdsnp/DjDy5YRHJaPHU0QvNIOMc5Y3PQuUZJbV552WK2pavBDHgShS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZh8Qh++; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CE71F00A3A;
	Mon, 15 Jun 2026 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524539;
	bh=vCbHjIdLkVYSp8h0SGNdIhVsAdl6qVmA4a+nq/MReUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LZh8Qh++tEH61G+ntPZxPtE8ncOXV23Aq8trMYRQubFZDHRJHLoixTTMzM1fLxi59
	 fBftqx0TJkFGx9aKZjhW7DXbcxXzex8oOb6yzzWeZVwrkkVdzluaAErY4y00MLrSkc
	 TavxoN15HDPILsWRIADkQSFBvgYBvztqjSZLlpak+r7QAk3se3a5+YAKwxgd6dVfyl
	 NxpeMWPtxCSw3a2AalOSsO4swRzDs6h9bCcEuiTEdgKbJr2/9lt5RI6+ETN4ycQaYy
	 nPScRKdEP2Who43yDuIUlx5pitJXXC9uMGuZktMeEe0dSFjLhimEaVF6wVvBMyfWsX
	 RJ6/y3XNy7+zQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:47 +0200
Subject: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16965-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26468685F02

__GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and
gfp flags are a scarce resource, unlike slab's alloc_flags.

Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
__GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
family function should not recurse into another kmalloc*() for the
purposes of allocating auxiliary structures (obj_ext arrays or sheaves).

First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
added. This will also pass through SLAB_ALLOC_NOLOCK so we don't need
to special case kmalloc_nolock() anymore.

Note that until now the kmalloc_nolock() ignored the incoming gfp flags
and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass on
the incoming gfp flags (only augmented with __GFP_ZERO), because if
alloc_flags contain SLAB_ALLOC_NOLOCK, the incoming gfp flags have to
be also compatible with it. However, we might have added __GFP_THISNODE
for opportunistic slab allocation, as pointed out by Hao Li, and
__GFP_COMP by allocate_slab() as pointed out by Shengming Hu. Solve this
by adding both flags to OBJCGS_CLEAR_MASK as it makes sense to strip
them anyway for non-kmalloc_nolock() allocations of sheaves or obj_ext
arrays as well.

To avoid recursion of sheaf -> obj_ext -> sheaf -> ... allocations at
this patch, until the next patch converts sheaves to
SLAB_ALLOC_NO_RECURSE, use both gfp and alloc_flags for obj_ext. The
next patch will remove the gfp part.

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-15-7190909db118@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h |  1 +
 mm/slub.c | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 482b8e0fe797..281a65233795 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -21,6 +21,7 @@
 #define SLAB_ALLOC_DEFAULT	0x00 /* no flags */
 #define SLAB_ALLOC_NOLOCK	0x01 /* a kmalloc_nolock() allocation */
 #define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
+#define SLAB_ALLOC_NO_RECURSE	0x04 /* prevent kmalloc() recursion */
 
 static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 383d39a22561..fc5b8c85b690 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2047,12 +2047,16 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
- * The allocated objcg pointers array is not accounted directly.
+ * The allocated objcg pointers array or sheaf is not accounted directly.
  * Moreover, it should not come from DMA buffer and is not readily
- * reclaimable. So those GFP bits should be masked off.
+ * reclaimable. Node restriction for the parent allocation also should
+ * not apply to the slab's internal objects, as well as __GFP_COMP used
+ * for new slab allocations.
+ * So those GFP bits should be masked off.
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
-				__GFP_ACCOUNT | __GFP_NOFAIL)
+				__GFP_ACCOUNT | __GFP_NOFAIL | \
+				__GFP_THISNODE | __GFP_COMP)
 
 #ifdef CONFIG_SLAB_OBJ_EXT
 
@@ -2168,14 +2172,12 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
+	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
 
 	sz = obj_exts_alloc_size(s, slab, gfp);
 
-	if (unlikely(!allow_spin))
-		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
-				     slab_nid(slab));
-	else
-		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
+	/* This will use kmalloc_nolock() if alloc_flags say so */
+	vec = kmalloc_flags(sz, gfp | __GFP_ZERO, alloc_flags, slab_nid(slab));
 
 	if (!vec) {
 		/*
@@ -2251,7 +2253,7 @@ static inline void free_slab_obj_exts(struct slab *slab, bool allow_spin)
 	}
 
 	/*
-	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
+	 * obj_exts was created with SLAB_ALLOC_NO_RECURSE flag, therefore its
 	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
 	 * warning if slab has extensions but the extension of an object is
 	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
@@ -2374,7 +2376,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
 		return;
 
-	if (flags & __GFP_NO_OBJ_EXT)
+	if (alloc_flags & SLAB_ALLOC_NO_RECURSE || flags & __GFP_NO_OBJ_EXT)
 		return;
 
 	slab = virt_to_slab(object);

-- 
2.54.0


