Return-Path: <cgroups+bounces-16960-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I75UHKHpL2q/IwUAu9opvQ
	(envelope-from <cgroups+bounces-16960-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:01:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE40685EEE
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 14:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ki1+3FRP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16960-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16960-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC4930CE360
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B23E6DCA;
	Mon, 15 Jun 2026 11:55:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD53E63A1;
	Mon, 15 Jun 2026 11:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524521; cv=none; b=spdSYI1CfxTUYe+W19tHW1dLOYdPW9yfHY/Fo0ysePhTk614etMWNcgztUbNzF4b6iZY9ZD3hrJHwTr6lfo8V71FQrYPAwDSdV6ohPvrG798ayoHkFkyFgdrNktllx9kZFSt5Rj9eVVRu5TilnH6C1666bqQj7P+2A5hf1GRxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524521; c=relaxed/simple;
	bh=yTRa8Ynru40QGHM6EcknGJn7HNGpu/ylalINBclLtls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQhaWW5YqetPz5mFKUVsD872G2DnvLz7coaPlfSTFKL1XzciG6IX24mcmXivl/W1ijkmj2xb0oD84W8Qz46qL1b622iyiJUekPIyfnsX7pyZrppiacYJ8dKnbC9ItbLL2rDgfs7lW844Bl4esvH+TLrFcwNymiUmtuXdZ8rRXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki1+3FRP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D0D1F000E9;
	Mon, 15 Jun 2026 11:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524519;
	bh=b/ONCctF5YKbZLzEkUCbIbq/8VsD8siPyJ17yXksSxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ki1+3FRPY5COKqVJtaJLCbGM5L/1vyiu41LlO4SMEIKmvm+Bl3T5L51NUYZX9kYfA
	 GuGcjm+Z1kzfTDxuJ8/K19Dhw7WuQ9O88hc0nw17v3EpGbZdXXRPQHOkauWdB3UM4a
	 34NXRdCganp015gkodc7LTz3LcigGHmlbYPhUPypBk9wy69eBSLhSldror/coHgSvc
	 6u4oZrDQBZ4xiRROFSlWMtZJFGKnbK2TewAudWsJy/bIDFMMrdk3uTEz8fnTD10y3x
	 YkFhFqPqT7zXeN/jGK6AtoRM2/11ps9qe/pQdqXfGQ3BVDm6AGa0SYCq6mF3p0TAzy
	 jv7MHn5+x1Giw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Mon, 15 Jun 2026 13:54:42 +0200
Subject: [PATCH v3 09/15] mm/slab: replace slab_alloc_node() parameters
 with slab_alloc_context
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-slab_alloc_flags-v3-9-ce1146d140fb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16960-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDE40685EEE

The function takes all the parameters that exist as fields in
slab_alloc_context, except alloc_flags. Replace them with a single
pointer.

This moves slab_alloc_context initialization to a number of callers,
which is more verbose, but arguably also more clear than a long list of
parameters, and most do not use the 'lru' field.

This will also allow kmalloc_nolock() to call slab_alloc_node() and
reduce the special open-coding it currently has.

Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-10-7190909db118@kernel.org
Reviewed-by: Hao Li <hao.li@linux.dev>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 465eb4db5770..562495b80d74 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4920,30 +4920,23 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
-		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s,
+		gfp_t gfpflags, int node, const struct slab_alloc_context *ac)
 {
-	const unsigned int alloc_flags = SLAB_ALLOC_DEFAULT;
 	void *object;
-	const struct slab_alloc_context ac = {
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
 
 	if (unlikely(!object))
-		object = __slab_alloc_node(s, gfpflags, node, &ac);
+		object = __slab_alloc_node(s, gfpflags, node, ac);
 
 	maybe_wipe_obj_freeptr(s, object);
 
@@ -4952,15 +4945,21 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
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
+	const struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
@@ -4971,8 +4970,15 @@ EXPORT_SYMBOL(kmem_cache_alloc_noprof);
 void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
-	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
-				    s->object_size);
+	void *ret;
+	const struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+		.lru = lru,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
@@ -5004,7 +5010,14 @@ EXPORT_SYMBOL(kmem_cache_charge);
  */
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret;
+	const struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, node, &ac);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
 
@@ -5334,6 +5347,11 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 {
 	struct kmem_cache *s;
 	void *ret;
+	const struct slab_alloc_context ac = {
+		.caller_addr = caller,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node_noprof(size, flags, node);
@@ -5347,7 +5365,7 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 
 	s = kmalloc_slab(size, b, flags, token);
 
-	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
+	ret = slab_alloc_node(s, flags, node, &ac);
 	ret = kasan_kmalloc(s, ret, size, flags);
 	trace_kmalloc(caller, ret, size, s->size, flags, node);
 	return ret;
@@ -5465,8 +5483,14 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
-					    _RET_IP_, size);
+	void *ret;
+	const struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, NUMA_NO_NODE, &ac);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
 
@@ -5478,7 +5502,14 @@ EXPORT_SYMBOL(__kmalloc_cache_noprof);
 void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
 				  int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
+	void *ret;
+	const struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	ret = slab_alloc_node(s, gfpflags, node, &ac);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
 

-- 
2.54.0


