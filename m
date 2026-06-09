Return-Path: <cgroups+bounces-16769-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yGDYIPXdJ2qm3gIAu9opvQ
	(envelope-from <cgroups+bounces-16769-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:33:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E930565E5F4
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 11:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oD0i1VLV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16769-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16769-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2238D316662C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5D3F483E;
	Tue,  9 Jun 2026 09:18:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E493F58DF;
	Tue,  9 Jun 2026 09:18:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996708; cv=none; b=HfHEUZ+fy7nOzZk0rTg0XacU7t5c8KhuwLET+sYYKQFbU+VBDgyE6O9lVxMoZcajlnO9OW17TGacqdiSl/wxTv8tzwx9DC1/eTXMNepiuaiW+cY3wCYRbWNxHwL7v4mff/THsiBYgaU5RbQ9NbwCTc1qs4DvMWFOOCdciR0tgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996708; c=relaxed/simple;
	bh=eqqkND3CC7/hHHEEMvgTJXcfie6IHo4L6hhLaUNkRks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msA4oSgy6748Raf42oG61CwEL8ri6J7VyLxPf5tdqYIDcasmONhHHm77BCvHlS9vlniWiIgR5h5aakVtgzS76WDNZ6b73iDz3H7dF4Bohv82YXqFULf5ltlGTL8mXtif6qnMpmVx2B7aSQFtvq+urC5RqI7aNy0X6S6+oG7GO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD0i1VLV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD851F00898;
	Tue,  9 Jun 2026 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996706;
	bh=nCpSWlchkeKZmx6rE2e5R1dkCFGfPuoJVPYULJPYfvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oD0i1VLVMUVflavtGIlneCAHBIS7oQKelrI7EIf9IZaGr78w1OUAnGALkmpo1VHRH
	 cEylbYxSFqqpXSns1cwskw1ram0MrpAkcQ85ltWvmy0kT3VjdIeytA6L4c8piWA0l9
	 NTRIvlMvpvOvQp1AwzCHi/2XxBt8LrBieKaeD2W2AdVwmrlvvv1tf+xRwvRWGJIFRE
	 2hOWw8juBX7NeXfn/F/ZJYozsYWbVdUaGQG+3JGeCTP3/O37LydGenSxj5Mo/VVDfi
	 NStUNpGp9IDGdTvYuuebnglDCbLJ33Xwr0eYbWW2u6pYBN5RV7zoVGkP4pGs5R7vic
	 k7Zu8xI7rcKOw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 09 Jun 2026 11:17:53 +0200
Subject: [PATCH RFC 08/15] mm/slab: pass alloc_flags through
 slab_post_alloc_hook() chain
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-slab_alloc_flags-v1-8-2bf4a4b9b526@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16769-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: E930565E5F4

Convert the whole following call stack to pass either slab_alloc_context
(thus including alloc_flags) or just alloc_flags as necessary:

slab_post_alloc_hook()
  alloc_tagging_slab_alloc_hook()
    __alloc_tagging_slab_alloc_hook()
      prepare_slab_obj_exts_hook()
        alloc_slab_obj_exts()
  memcg_slab_post_alloc_hook()
    __memcg_slab_post_alloc_hook()
      alloc_slab_obj_exts()

Converting all these at once avoids unnecessary churn and is mostly
mechanical.

This ultimately allows to decide if spinning is allowed using
alloc_flags in alloc_slab_obj_exts(), as well as slab_post_alloc_hook().
Aside from alloc_from_pcs_bulk() (to be handled next) there is nothing
else in slab itself relying on gfpflags_allow_spinning() which can
be false even if not called from kmalloc_nolock().

A followup change will also use the alloc_flags availability in the call
stack above to remove the __GFP_NO_OBJ_EXT flag.

For alloc_slab_obj_exts(), also replace the suboptimal "bool new_slab"
parameter with a SLAB_ALLOC_NEW_SLAB flag with identical functionality.

To further reduce the number of parameters of slab_post_alloc_hook(),
also make 'struct list_lru *lru' (which is NULL for most callers) a new
field of slab_alloc_context.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/memcontrol.c |  5 +--
 mm/slab.h       |  6 ++--
 mm/slub.c       | 94 +++++++++++++++++++++++++++++++++------------------------
 3 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466..29390ba13baa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3424,7 +3424,8 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 }
 
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-				  gfp_t flags, size_t size, void **p)
+				  gfp_t flags, unsigned int slab_alloc_flags,
+				  size_t size, void **p)
 {
 	size_t obj_size = obj_full_size(s);
 	struct obj_cgroup *objcg;
@@ -3472,7 +3473,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
-		    alloc_slab_obj_exts(slab, s, flags, false)) {
+		    alloc_slab_obj_exts(slab, s, flags, slab_alloc_flags)) {
 			continue;
 		}
 
diff --git a/mm/slab.h b/mm/slab.h
index 3e75182ee144..13517abcad21 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -19,6 +19,7 @@
 /* slab's alloc_flags definitions */
 #define SLAB_ALLOC_DEFAULT	0x00
 #define SLAB_ALLOC_TRYLOCK	0x01
+#define SLAB_ALLOC_NEW_SLAB	0x02 /* a flag for alloc_slab_obj_exts() */
 
 static inline bool alloc_flags_allow_spinning(const unsigned int alloc_flags)
 {
@@ -612,7 +613,7 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-                        gfp_t gfp, bool new_slab);
+                        gfp_t gfp, unsigned int alloc_flags);
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
@@ -642,7 +643,8 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 
 #ifdef CONFIG_MEMCG
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-				  gfp_t flags, size_t size, void **p);
+				  gfp_t flags, unsigned int slab_alloc_flags,
+				  size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, unsigned long obj_exts);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 20df6b131f63..034f2cd1c1fd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -218,6 +218,7 @@ struct slab_alloc_context {
 	unsigned long caller_addr;
 	unsigned long orig_size;
 	unsigned int alloc_flags;
+	struct list_lru *lru;
 };
 
 /* Structure holding parameters for get_partial_node_bulk() */
@@ -2155,9 +2156,9 @@ static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-		        gfp_t gfp, bool new_slab)
+		        gfp_t gfp, unsigned int alloc_flags)
 {
-	bool allow_spin = gfpflags_allow_spinning(gfp);
+	const bool allow_spin = alloc_flags_allow_spinning(alloc_flags);
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long new_exts;
 	unsigned long old_exts;
@@ -2206,7 +2207,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 
-	if (new_slab) {
+	if (alloc_flags & SLAB_ALLOC_NEW_SLAB) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
 		 * obj_exts, no synchronization is required and obj_exts can
@@ -2331,7 +2332,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
 }
 
 static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-			       gfp_t gfp, bool new_slab)
+			       gfp_t gfp, unsigned int alloc_flags)
 {
 	return 0;
 }
@@ -2351,10 +2352,10 @@ static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
 
 static inline unsigned long
 prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
-			   gfp_t flags, void *p)
+			   gfp_t flags, unsigned int alloc_flags, void *p)
 {
 	if (!slab_obj_exts(slab) &&
-	    alloc_slab_obj_exts(slab, s, flags, false)) {
+	    alloc_slab_obj_exts(slab, s, flags, alloc_flags)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
 		return 0;
@@ -2366,7 +2367,8 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
-__alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
+__alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
+				unsigned int alloc_flags)
 {
 	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
@@ -2382,7 +2384,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 		return;
 
 	slab = virt_to_slab(object);
-	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, object);
+	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, alloc_flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
@@ -2401,10 +2403,11 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 }
 
 static inline void
-alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
+alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
+			      unsigned int alloc_flags)
 {
 	if (mem_alloc_profiling_enabled())
-		__alloc_tagging_slab_alloc_hook(s, object, flags);
+		__alloc_tagging_slab_alloc_hook(s, object, flags, alloc_flags);
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
@@ -2443,7 +2446,8 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void
-alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
+alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
+			      unsigned int alloc_flags)
 {
 }
 
@@ -2461,8 +2465,9 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
 
 static __fastpath_inline
-bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-				gfp_t flags, size_t size, void **p)
+bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
+				size_t size, void **p,
+				struct slab_alloc_context *ac)
 {
 	if (likely(!memcg_kmem_online()))
 		return true;
@@ -2470,7 +2475,8 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	if (likely(!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT)))
 		return true;
 
-	if (likely(__memcg_slab_post_alloc_hook(s, lru, flags, size, p)))
+	if (likely(__memcg_slab_post_alloc_hook(s, ac->lru, flags,
+						ac->alloc_flags, size, p)))
 		return true;
 
 	if (likely(size == 1)) {
@@ -2558,14 +2564,15 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 		put_slab_obj_exts(obj_exts);
 	}
 
-	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
+	return __memcg_slab_post_alloc_hook(s, NULL, flags, SLAB_ALLOC_DEFAULT,
+					    1, &p);
 }
 
 #else /* CONFIG_MEMCG */
 static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct list_lru *lru,
-					      gfp_t flags, size_t size,
-					      void **p)
+					      gfp_t flags,
+					      size_t size, void **p,
+					      struct slab_alloc_context *ac)
 {
 	return true;
 }
@@ -3352,12 +3359,14 @@ static inline void init_freelist_randomization(void) { }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
 static __always_inline void account_slab(struct slab *slab, int order,
-					 struct kmem_cache *s, gfp_t gfp)
+					 struct kmem_cache *s, gfp_t gfp,
+					 unsigned int alloc_flags)
 {
 	if (memcg_kmem_online() &&
 			(s->flags & SLAB_ACCOUNT) &&
 			!slab_obj_exts(slab))
-		alloc_slab_obj_exts(slab, s, gfp, true);
+		alloc_slab_obj_exts(slab, s, gfp,
+				    alloc_flags | SLAB_ALLOC_NEW_SLAB);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -3434,7 +3443,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	 * to prevent the array from being overwritten.
 	 */
 	alloc_slab_obj_exts_early(s, slab);
-	account_slab(slab, oo_order(oo), s, flags);
+	account_slab(slab, oo_order(oo), s, flags, alloc_flags);
 
 	return slab;
 }
@@ -4568,9 +4577,8 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 }
 
 static __fastpath_inline
-bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-			  gfp_t flags, size_t size, void **p,
-			  unsigned int orig_size)
+bool slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags, size_t size,
+			  void **p, struct slab_alloc_context *ac)
 {
 	bool init = slab_want_init_on_alloc(flags, s);
 	bool kasan_init = init;
@@ -4599,15 +4607,15 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
 		if (p[i] && init && (!kasan_init ||
 				     !kasan_has_integrated_init()))
-			memset(p[i], 0, orig_size);
-		if (gfpflags_allow_spinning(flags))
+			memset(p[i], 0, ac->orig_size);
+		if (alloc_flags_allow_spinning(ac->alloc_flags))
 			kmemleak_alloc_recursive(p[i], s->object_size, 1,
 						 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
-		alloc_tagging_slab_alloc_hook(s, p[i], flags);
+		alloc_tagging_slab_alloc_hook(s, p[i], flags, ac->alloc_flags);
 	}
 
-	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
+	return memcg_slab_post_alloc_hook(s, flags, size, p, ac);
 }
 
 /*
@@ -4902,6 +4910,12 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 {
 	const unsigned int alloc_flags = SLAB_ALLOC_DEFAULT;
 	void *object;
+	struct slab_alloc_context ac = {
+		.caller_addr = addr,
+		.orig_size = orig_size,
+		.alloc_flags = alloc_flags,
+		.lru = lru,
+	};
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
@@ -4913,14 +4927,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 
 	object = alloc_from_pcs(s, gfpflags, alloc_flags, node);
 
-	if (unlikely(!object)) {
-		struct slab_alloc_context ac = {
-			.caller_addr = addr,
-			.orig_size = orig_size,
-			.alloc_flags = alloc_flags,
-		};
+	if (!object)
 		object = __slab_alloc_node(s, gfpflags, node, &ac);
-	}
 
 	maybe_wipe_obj_freeptr(s, object);
 
@@ -4929,7 +4937,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	 * In case this fails due to memcg_slab_post_alloc_hook(),
 	 * object is set to NULL
 	 */
-	slab_post_alloc_hook(s, lru, gfpflags, 1, &object, orig_size);
+	slab_post_alloc_hook(s, gfpflags, 1, &object, &ac);
 
 	return object;
 }
@@ -5224,6 +5232,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 				   struct slab_sheaf *sheaf)
 {
 	void *ret = NULL;
+	struct slab_alloc_context ac = {
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
 	if (sheaf->size == 0)
 		goto out;
@@ -5234,7 +5246,7 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 		ret = sheaf->objects[--sheaf->size];
 
 	/* add __GFP_NOFAIL to force successful memcg charging */
-	slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, s->object_size);
+	slab_post_alloc_hook(s, gfp | __GFP_NOFAIL, 1, &ret, &ac);
 out:
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
 
@@ -5421,7 +5433,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
 
 success:
 	maybe_wipe_obj_freeptr(s, ret);
-	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret, orig_size);
+	slab_post_alloc_hook(s, alloc_gfp, 1, &ret, &ac);
 
 	ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
 	return ret;
@@ -7287,6 +7299,10 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
 {
 	unsigned int i = 0;
 	void *kfence_obj;
+	struct slab_alloc_context ac = {
+		.orig_size = s->object_size,
+		.alloc_flags = SLAB_ALLOC_DEFAULT,
+	};
 
 	if (!size)
 		return false;
@@ -7337,7 +7353,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
 
 out:
 	/* memcg and kmem_cache debug support and memory initialization */
-	return likely(slab_post_alloc_hook(s, NULL, flags, size, p, s->object_size));
+	return likely(slab_post_alloc_hook(s, flags, size, p, &ac));
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 

-- 
2.54.0


