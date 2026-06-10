Return-Path: <cgroups+bounces-16823-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 58CXGjuJKWqxYwMAu9opvQ
	(envelope-from <cgroups+bounces-16823-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D681B66B150
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:56:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Su1gbBTv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16823-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16823-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F17353E4A7
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530FB3E9C1F;
	Wed, 10 Jun 2026 15:41:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9843D4EF;
	Wed, 10 Jun 2026 15:41:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106110; cv=none; b=N+Cj4IBSHOpwY9RvozAmBvDbSVtCvdVVevfdGqKYaNBb59t8XambCun9Kar1xpH4Yl3ji15ZIl1l9HLGmcBqNgTZEshrASqz7gDoPhXqCTBMldVzSHOPaJ7sYHwljIm4jemCj2Vaut6tPzbuwaqTgNR4klZ0F0xx5QVPLDuRQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106110; c=relaxed/simple;
	bh=/4WmPX44Q4AFm8S99K3lkmPJVJCVaZFE72dvTQFFoto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aU7z8CGbvFcYrKvbAArT+L1jdVKyTNkzHfUYpo5YbaKuCUkk766GdgpRHIcUA5tpX0vWAr+pSzNu/xK281LRUtHQD9BcKf9KQmjKTwYLGpfW1FjscSqgkNKm3MycMHVxSHw9Nli3tGxCOwo2SynK6BgLtWNLklJJxbA26KszmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su1gbBTv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8B1F00893;
	Wed, 10 Jun 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106108;
	bh=Z4p7lBTo620lw4Cx9cPSuEFRwzQZKtUkN/W+8V4LMiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Su1gbBTvmRn8OWDOvh3qn3pI4cAxHZ45px1Swujt8aZRyDQ2J7bmOwZiD1kaqqChI
	 HetPcwR6LmZcW4IC8PlXBx/UmddVjTIcdIO3FOs6AnS58JKxtaPhIbT8wb8accI83E
	 g3t5AfHsFGIIRPOYjEHT7BPV7OtTDbuAdMQEiStz5Jixcbxo4J3KK2+gvgEWDBCmF9
	 jccFfMTKAgQnaLM37K620iiUYGXcScDJS/t6B9eG+EKRovUFFlWbdVryacWBLk9mm9
	 HOk6gy3RMYea3PCFfmfHKRA/snC0KQNkbfiwHpIfsxc1d5g3cME27KqU1tmsG9tWvk
	 kD/LblYVS9Dow==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:14 +0200
Subject: [PATCH v2 12/16] mm/slab: pass slab_alloc_context to
 __do_kmalloc_node()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-slab_alloc_flags-v2-12-7190909db118@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16823-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D681B66B150

With alloc_flags usage in slab, we can replace __GFP_NO_OBJ_EXT with an
alloc flag that prevents kmalloc recursion. For that we need a version
of kmalloc() that takes alloc_flags and use it in places that perform
these potentially recursive kmalloc allocations (of sheaves or obj_ext
arrays).

As a preparatory step, make __do_kmalloc_node() take a pointer to
slab_alloc_context. This replaces the 'caller' parameter and includes
alloc_flags which we'll make use of.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ef457e07db83..6845e15c148a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5338,19 +5338,14 @@ EXPORT_SYMBOL(__kmalloc_large_node_noprof);
 
 static __always_inline
 void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
-			unsigned long caller, kmalloc_token_t token)
+			kmalloc_token_t token, struct slab_alloc_context *ac)
 {
 	struct kmem_cache *s;
 	void *ret;
-	struct slab_alloc_context ac = {
-		.caller_addr = caller,
-		.orig_size = size,
-		.alloc_flags = SLAB_ALLOC_DEFAULT,
-	};
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node_noprof(size, flags, node);
-		trace_kmalloc(caller, ret, size,
+		trace_kmalloc(ac->caller_addr, ret, size,
 			      PAGE_SIZE << get_order(size), flags, node);
 		return ret;
 	}
@@ -5360,22 +5355,34 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 
 	s = kmalloc_slab(size, b, flags, token);
 
-	ret = slab_alloc_node(s, flags, node, &ac);
+	ret = slab_alloc_node(s, flags, node, ac);
 	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc(caller, ret, size, s->size, flags, node);
+	trace_kmalloc(ac->caller_addr, ret, size, s->size, flags, node);
 	return ret;
 }
 void *__kmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags, int node)
 {
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
 	return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
-				 _RET_IP_, PASS_TOKEN_PARAM(token));
+				 PASS_TOKEN_PARAM(token), &ac);
 }
 EXPORT_SYMBOL(__kmalloc_node_noprof);
 
 void *__kmalloc_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t flags)
 {
-	return __do_kmalloc_node(size, NULL, flags,  NUMA_NO_NODE, _RET_IP_,
-				 PASS_TOKEN_PARAM(token));
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
+
+	return __do_kmalloc_node(size, NULL, flags,  NUMA_NO_NODE,
+				 PASS_TOKEN_PARAM(token), &ac);
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
@@ -5471,9 +5478,14 @@ EXPORT_SYMBOL_GPL(_kmalloc_nolock_noprof);
 void *__kmalloc_node_track_caller_noprof(DECL_KMALLOC_PARAMS(size, b, token), gfp_t flags,
 					 int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
-				 caller, PASS_TOKEN_PARAM(token));
+	struct slab_alloc_context ac = {
+		.caller_addr = caller,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
+	return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node,
+				 PASS_TOKEN_PARAM(token), &ac);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
@@ -6874,6 +6886,11 @@ void *__kvmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), unsigned long
 {
 	bool allow_block;
 	void *ret;
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -6881,7 +6898,7 @@ void *__kvmalloc_node_noprof(DECL_KMALLOC_PARAMS(size, b, token), unsigned long
 	 */
 	ret = __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
 				kmalloc_gfp_adjust(flags, size),
-				node, _RET_IP_, PASS_TOKEN_PARAM(token));
+				node, PASS_TOKEN_PARAM(token), &ac);
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 

-- 
2.54.0


