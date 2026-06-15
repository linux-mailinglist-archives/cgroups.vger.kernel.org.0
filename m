Return-Path: <cgroups+bounces-16966-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nObWKuLpL2rNIwUAu9opvQ
	(envelope-from <cgroups+bounces-16966-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F039685F0A
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:02:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="d8jmFUp/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16966-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16966-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259063208A93
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1503E9C33;
	Mon, 15 Jun 2026 11:55:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FA3ECBC8;
	Mon, 15 Jun 2026 11:55:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524544; cv=none; b=cVxxtwoel+iedyySUfHr9eldYnZf0bfuEFk/O3iI8Y2r1PVHarvchSoWz+biv++IQPl9n2mXwNQIcjD2LMSaMhqG5l2gM1OqI8N0xz/vqpXhioJN6P767OMFGqcYOkM7wPgq1ladL81ZWirPwvIgYXwda85GHzOKoa5Hymompvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524544; c=relaxed/simple;
	bh=lD8MW/Bb5H4hskOjqs2EfF7UNzsrjT3kZqJK/+VOMnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHa5e8sd+ItNhMGsrP0XZ7QsFbiC/SzJcKpyMS1Lilw0TqR3DkjVVXGvsgNwcQl2UAgF7RnGjxvtwg2dOrdGDSc76bFvJVGVM4QLC7wcgkgrJfnVenSsePnnkhQf1GPquYm1pYy2cdoiLAuOq8wVqpAWDdM2Hven8dKv4dJ1gyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8jmFUp/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8C41F00A3D;
	Mon, 15 Jun 2026 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524543;
	bh=zyqT9IUsAQbwcRrsuy0yQvWZuxd/DTadym+oabv6LFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d8jmFUp/F1i15NtYKHs1xEpmGn13xYRQw8UK76UBniN6VQQEsiS7EafW7XcA3wJrv
	 LuOBwmr7LzNL81XvHPNQN/OUfRmBGS/cAfl+RArwqO1oBTK/ksbG8WbDJdMsHR68Tt
	 0KNhFL0vu5fM63FbeMqNhalcPBuU+wJPyIv9wvmiSQ7EZjw+ZpIAlie3x0zWSCDyqZ
	 u4O4+AmROtWI6lBI912OrObWnoWVpn96iZUM1RyXgd3qiOW0gwtq8xlMFPyujLf3uM
	 fEqe3Z/ve8vlAD2aNR3LFcGtzR6BQ6GNbXR+KobjhRkWJQw8WS0iRcHEB4rQ+6WnLU
	 Z/VsxlyDl8tzg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:48 +0200
Subject: [PATCH v3 15/15] mm/slab: replace __GFP_NO_OBJ_EXT with
 SLAB_ALLOC_NO_RECURSE for sheaves
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16966-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F039685F0A

Finish the switch away from __GFP_NO_OBJ_EXT by replacing it with
SLAB_ALLOC_NO_RECURSE when allocating empty sheaves. Pass alloc_flags to
[__]alloc_empty_sheaf(). Callers that can't be part of a recursive
kmalloc() chain simply pass SLAB_ALLOC_DEFAULT. Use kmalloc_flags()
instead of kzalloc() for allocating the sheaf.

With that we can finalize the removal the __GFP_NO_OBJ_EXT handling from
obj_ext allocations as well, leaving only SLAB_ALLOC_NO_RECURSE in
place.

This leaves __GFP_NO_OBJ_EXT with no users in slab, so stop allowing the
flag in kmalloc_nolock().

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-16-7190909db118@kernel.org
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/slab.h |  6 +++---
 mm/slub.c            | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b955f3cbb732..43c3d9b51107 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1039,9 +1039,9 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 /**
  * kmalloc_nolock - Allocate an object of given size from any context.
  * @size: size to allocate
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO, __GFP_NO_OBJ_EXT
- * allowed. Also __GFP_NOWARN and __GFP_NOMEMALLOC are allowed but added
- * internally thus not necessary.
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT and __GFP_ZERO allowed.  Also
+ * __GFP_NOWARN and __GFP_NOMEMALLOC are allowed but added internally thus not
+ * necessary.
  * @node: node number of the target node.
  *
  * Return: pointer to the new object or NULL in case of error.
diff --git a/mm/slub.c b/mm/slub.c
index fc5b8c85b690..62e9cd46916f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2171,7 +2171,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
-	gfp |= __GFP_NO_OBJ_EXT;
 	alloc_flags |= SLAB_ALLOC_NO_RECURSE;
 
 	sz = obj_exts_alloc_size(s, slab, gfp);
@@ -2376,7 +2375,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
 		return;
 
-	if (alloc_flags & SLAB_ALLOC_NO_RECURSE || flags & __GFP_NO_OBJ_EXT)
+	if (alloc_flags & SLAB_ALLOC_NO_RECURSE)
 		return;
 
 	slab = virt_to_slab(object);
@@ -2761,7 +2760,7 @@ static inline void *setup_object(struct kmem_cache *s, void *object)
 }
 
 static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
-					      unsigned int capacity)
+				unsigned int alloc_flags, unsigned int capacity)
 {
 	struct slab_sheaf *sheaf;
 	size_t sheaf_size;
@@ -2772,10 +2771,10 @@ static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
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
@@ -2788,20 +2787,20 @@ static struct slab_sheaf *__alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp,
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
@@ -4693,7 +4692,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 
 	if (!empty) {
-		empty = alloc_empty_sheaf(s, gfp);
+		empty = alloc_empty_sheaf(s, gfp, alloc_flags);
 		if (!empty)
 			return NULL;
 	}
@@ -5066,7 +5065,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 
 	if (unlikely(size > s->sheaf_capacity)) {
 
-		sheaf = __alloc_empty_sheaf(s, gfp, size);
+		sheaf = __alloc_empty_sheaf(s, gfp, SLAB_ALLOC_DEFAULT, size);
 		if (!sheaf)
 			return NULL;
 
@@ -5111,7 +5110,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 
 
 	if (!sheaf)
-		sheaf = alloc_empty_sheaf(s, gfp);
+		sheaf = alloc_empty_sheaf(s, gfp, SLAB_ALLOC_DEFAULT);
 
 	if (sheaf) {
 		sheaf->capacity = s->sheaf_capacity;
@@ -5396,7 +5395,7 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
 
 	VM_WARN_ON_ONCE(alloc_flags_allow_spinning(ac->alloc_flags));
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
-			__GFP_NO_OBJ_EXT | __GFP_NOWARN | __GFP_NOMEMALLOC));
+				      __GFP_NOWARN | __GFP_NOMEMALLOC));
 
 	gfp_flags |= __GFP_NOWARN | __GFP_NOMEMALLOC;
 
@@ -5911,7 +5910,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	if (!allow_spin)
 		return NULL;
 
-	empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+	empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
 	if (empty)
 		goto got_empty;
 
@@ -6095,7 +6094,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 		local_unlock(&s->cpu_sheaves->lock);
 
-		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
 
 		if (!empty)
 			goto fail;
@@ -7640,7 +7639,7 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 		if (!s->sheaf_capacity)
 			pcs->main = &bootstrap_sheaf;
 		else
-			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL, SLAB_ALLOC_DEFAULT);
 
 		if (!pcs->main)
 			return -ENOMEM;
@@ -8506,7 +8505,8 @@ static void __init bootstrap_cache_sheaves(struct kmem_cache *s)
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		pcs->main = __alloc_empty_sheaf(s, GFP_KERNEL, capacity);
+		pcs->main = __alloc_empty_sheaf(s, GFP_KERNEL,
+				SLAB_ALLOC_DEFAULT, capacity);
 
 		if (!pcs->main) {
 			failed = true;

-- 
2.54.0


