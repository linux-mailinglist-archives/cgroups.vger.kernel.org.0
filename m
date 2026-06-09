Return-Path: <cgroups+bounces-16770-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iBGFKL3eJ2rl3gIAu9opvQ
	(envelope-from <cgroups+bounces-16770-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD665E663
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k4EYp5WV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16770-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16770-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 003C1308F87C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A83F5BDF;
	Tue,  9 Jun 2026 09:18:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696843F0AB7;
	Tue,  9 Jun 2026 09:18:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996711; cv=none; b=Irp8qRDvDap9h7XY+b7OroN6LOFfu2j+xsM/EuwF7oxGl4MeBwbKIenKFv09HIFM29ccyZhB/NJPlAsnsBpbfAT/DEfag9R12+LRS3wlAObTqi7MMlgf8e6rCWoT3iV7CsTnl3fqwJjchuFPCkA4VSHyU6OeArLf6TpDkE2551w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996711; c=relaxed/simple;
	bh=lrnrucuMbuwwNqpZGoaFaIh8aNamFATsO8stM3JoCqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMXzvQsLgyVf0M+8xPHUrL2bgr4hCEulgj7TxTOQHZd49ipIMSoTUa0n3HsX80uhUpDx6DUb8vh+77dmC9grKnAt8i/vFNVssW75xrao86Wm1PIzVrFcKmtheEUryo57xsXNdQ3WslW0YiB2FcaN/MCHJsct3+xF6JYBl76AXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4EYp5WV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE1D1F00899;
	Tue,  9 Jun 2026 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996710;
	bh=pi3O3D8NkrwDsiflwfpbJbAUdo/o74gPku/tjUk2wnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k4EYp5WVrNZXlKvH/rsFUgnWi5jQNPZ0/cTItnU98OxAcliXIFzqU1mosvG1Y1G8W
	 7uADeqxV3aNk9JiWUgOdt9K4P4mI9jUhZpi1KSm7NuuyrQOV+o9BbKFsohfE04emv7
	 APPgQqnnpvHeuG8crrXlb6kqDRlaXlAb1ibNirMLWqCnOkkoB4RiakAo/n4sGwya8R
	 uBk9+3iEX4/02ZPVIDsPxgMs0izEpQ9t5gxKl0dqRQLxC+KjBhneIFh2BBDzBMwPhx
	 COHB94NEZ9rOAEjddIetOiJ5vtNhIkhJQNfdWhvdoXvUpK+ZcDfTVrdL8/4rcnQO8q
	 7fPVB2J+XkaQg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:54 +0200
Subject: [PATCH RFC 09/15] mm/slab: replace slab_alloc_node() parameters
 with slab_alloc_context
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-9-2bf4a4b9b526@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-16770-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBD665E663

The function takes all the parameters that exist as fields in
slab_alloc_context, except alloc_flags. Replace them with a single
pointer.

This moves slab_alloc_context initialization to a number of callers,
which is more verbose, but arguably also more clear than a long list of
parameters, and most do not use the 'lru' field.

This will also allow kmalloc_nolock() to call slab_alloc_node() and
reduce the special open-coding it currently has.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 034f2cd1c1fd..b511d768e9b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4905,30 +4905,23 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
-		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s,
+		gfp_t gfpflags, int node, struct slab_alloc_context *ac)
 {
-	const unsigned int alloc_flags = SLAB_ALLOC_DEFAULT;
 	void *object;
-	struct slab_alloc_context ac = {
-		.caller_addr = addr,
-		.orig_size = orig_size,
-		.alloc_flags = alloc_flags,
-		.lru = lru,
-	};
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
 		return NULL;
 
-	object = kfence_alloc(s, orig_size, gfpflags);
+	object = kfence_alloc(s, ac->orig_size, gfpflags);
 	if (unlikely(object))
 		goto out;
 
-	object = alloc_from_pcs(s, gfpflags, alloc_flags, node);
+	object = alloc_from_pcs(s, gfpflags, ac->alloc_flags, node);
 
 	if (!object)
-		object = __slab_alloc_node(s, gfpflags, node, &ac);
+		object = __slab_alloc_node(s, gfpflags, node, ac);
 
 	maybe_wipe_obj_freeptr(s, object);
 
@@ -4937,15 +4930,21 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	 * In case this fails due to memcg_slab_post_alloc_hook(),
 	 * object is set to NULL
 	 */
-	slab_post_alloc_hook(s, gfpflags, 1, &object, &ac);
+	slab_post_alloc_hook(s, gfpflags, 1, &object, ac);
 
 	return object;
 }
 
 void *kmem_cache_alloc_noprof(struct kmem_cache *s, gfp_t gfpflags)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
-				    s->object_size);
+	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
@@ -4956,8 +4955,15 @@ EXPORT_SYMBOL(kmem_cache_alloc_noprof);
 void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
-	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
-				    s->object_size);
+	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+		.lru = lru,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
@@ -4989,7 +4995,14 @@ EXPORT_SYMBOL(kmem_cache_charge);
  */
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, node, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
 
@@ -5319,6 +5332,11 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 {
 	struct kmem_cache *s;
 	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = caller,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node_noprof(size, flags, node);
@@ -5332,7 +5350,7 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 
 	s = kmalloc_slab(size, b, flags, token);
 
-	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
+	ret = slab_alloc_node(s, flags, node, &ac);
 	ret = kasan_kmalloc(s, ret, size, flags);
 	trace_kmalloc(caller, ret, size, s->size, flags, node);
 	return ret;
@@ -5451,8 +5469,14 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
-					    _RET_IP_, size);
+	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
 
@@ -5464,7 +5488,14 @@ EXPORT_SYMBOL(__kmalloc_cache_noprof);
 void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
 				  int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
+	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, node, &ac);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
 

-- 
2.54.0


