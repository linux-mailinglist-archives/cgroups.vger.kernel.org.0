Return-Path: <cgroups+bounces-16764-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vj/xGWHeJ2rD3gIAu9opvQ
	(envelope-from <cgroups+bounces-16764-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:35:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96D65E629
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XkiEQzgM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16764-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16764-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC5F3059FE8
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF793F1ADD;
	Tue,  9 Jun 2026 09:18:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2963E3DBE;
	Tue,  9 Jun 2026 09:18:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996688; cv=none; b=gYbiHOpo/jvb1DcwHx6idsNjQglo7+DFCHRD1eos/R0d+Bqq2JaUJZD3FtMMb0/tWhPVkGpHpeOP63EdZJJXM8FEeyM4Nlgcm0vADeVRid8ufdfh57T/0J54WIGhj+aqDdWTFWqRpUfbbtQLAoVS7pkRfl16xrrRPNIS8VzFH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996688; c=relaxed/simple;
	bh=zxroU++D0Gx/wndfUEr/4jlYP339HFW+fCeXji5ZsnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yi6mSpN2wFNl4QgQy+7FkhnNQTDVgZ/uWV++zUe1bhBaw3CzMLonOJhPBU2fV1MEDcX9yqCF4qJu0ZHAUp9qiwas1GspSaYnMH14evHtjhrZABEfLAKFWq0nTbqDjxnJsxJqUCtEhtVWetilnkE8WKpr5Kipb9m0RfVfdIdo7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkiEQzgM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052DB1F0089B;
	Tue,  9 Jun 2026 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996686;
	bh=weO6c/1G9Hrx18MM2p1O4dDAw1r/wQnymnAXQ1WYRCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XkiEQzgM65eRzR9w3QxLA4cK5j6i33PhkjrObytF8KmOdNLSlripy9FAjHUCHYMm2
	 Abi2RR+kKce8qpTquTUyAL8vyTuc3eJwKtEvvaAdjmgZ9eX8xmN/epXrENYlqjpTEB
	 dK3P6K2xRX+Kh1q+/zRlwKlw0nBqOvaqOP/1Uc58BCHYlZbFSgrK3fI5HW0q2LqnCs
	 866So9kzR3HmNmGs+eRngdf3zRhwzPwa1zSqkMU1QaN6kXme1g+1MgYv4ILvFEwwre
	 TmRPS7hqTvQ0fYaA+OITuI6apIFs3pAC6p+ROBgrei5iW1a+SR1Ka0ct5P8RkYAZQh
	 rFk+XJd4cQoGg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:48 +0200
Subject: [PATCH RFC 03/15] mm/slab: introduce slab_alloc_context
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-3-2bf4a4b9b526@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16764-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: AB96D65E629

Similarly to page allocator's struct alloc_context, introduce a helper
struct to hold a part of the allocation arguments. This will allow
reducing the number of parameters in many functions of the
implementation, and extend them easily if needed.

For now, make it hold the caller address and the originally requested
allocation size.

Convert alloc_single_from_new_slab(), __slab_alloc_node() and
___slab_alloc(). No functional change intended.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index af85f338db4f..06fc1656080f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -213,6 +213,12 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 static DEFINE_STATIC_KEY_FALSE(strict_numa);
 #endif
 
+/* Structure holding extra parameters for slab allocations */
+struct slab_alloc_context {
+	unsigned long caller_addr;
+	unsigned long orig_size;
+};
+
 /* Structure holding parameters for get_from_partial() call chain */
 struct partial_context {
 	gfp_t flags;
@@ -3687,7 +3693,8 @@ static inline void init_slab_obj_iter(struct kmem_cache *s, struct slab *slab,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
-					int orig_size, bool allow_spin)
+					struct slab_alloc_context *ac,
+					bool allow_spin)
 {
 	struct kmem_cache_node *n;
 	struct slab_obj_iter iter;
@@ -3705,7 +3712,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	/* alloc_debug_processing() always expects a valid freepointer */
 	set_freepointer(s, object, slab->freelist);
 
-	if (!alloc_debug_processing(s, slab, object, orig_size)) {
+	if (!alloc_debug_processing(s, slab, object, ac->orig_size)) {
 		/*
 		 * It's not really expected that this would fail on a
 		 * freshly allocated slab, but a concurrent memory
@@ -4443,7 +4450,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
  * slab.
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			   unsigned long addr, unsigned int orig_size)
+			   struct slab_alloc_context *ac)
 {
 	bool allow_spin = gfpflags_allow_spinning(gfpflags);
 	void *object;
@@ -4476,7 +4483,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			pc.flags = GFP_NOWAIT | __GFP_THISNODE;
 	}
 
-	pc.orig_size = orig_size;
+	pc.orig_size = ac->orig_size;
 	object = get_from_partial(s, node, &pc);
 	if (object)
 		goto success;
@@ -4496,7 +4503,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
-		object = alloc_single_from_new_slab(s, slab, orig_size, allow_spin);
+		object = alloc_single_from_new_slab(s, slab, ac, allow_spin);
 
 		if (likely(object))
 			goto success;
@@ -4514,13 +4521,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 success:
 	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
-		set_track(s, object, TRACK_ALLOC, addr, gfpflags);
+		set_track(s, object, TRACK_ALLOC, ac->caller_addr, gfpflags);
 
 	return object;
 }
 
 static void *__slab_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
-			       unsigned long addr, size_t orig_size)
+			       struct slab_alloc_context *ac)
 {
 	void *object;
 
@@ -4545,7 +4552,7 @@ static void *__slab_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 #endif
 
-	object = ___slab_alloc(s, gfpflags, node, addr, orig_size);
+	object = ___slab_alloc(s, gfpflags, node, ac);
 
 	return object;
 }
@@ -4907,8 +4914,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 
 	object = alloc_from_pcs(s, gfpflags, node);
 
-	if (unlikely(!object))
-		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
+	if (unlikely(!object)) {
+		struct slab_alloc_context ac = {
+			.caller_addr = addr,
+			.orig_size = orig_size,
+		};
+		object = __slab_alloc_node(s, gfpflags, node, &ac);
+	}
 
 	maybe_wipe_obj_freeptr(s, object);
 
@@ -5373,13 +5385,18 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 	if (ret)
 		goto success;
 
+	struct slab_alloc_context ac = {
+		.caller_addr = _RET_IP_,
+		.orig_size = orig_size,
+	};
+
 	/*
 	 * Do not call slab_alloc_node(), since trylock mode isn't
 	 * compatible with slab_pre_alloc_hook/should_failslab and
 	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
-	ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, orig_size);
+	ret = __slab_alloc_node(s, alloc_gfp, node, &ac);
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
@@ -7221,10 +7238,13 @@ static bool __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 	int i;
 
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
+		struct slab_alloc_context ac = {
+			.caller_addr = _RET_IP_,
+			.orig_size = s->object_size,
+		};
 		for (i = 0; i < size; i++) {
 
-			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
-					     s->object_size);
+			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, &ac);
 			if (unlikely(!p[i]))
 				goto error;
 

-- 
2.54.0


