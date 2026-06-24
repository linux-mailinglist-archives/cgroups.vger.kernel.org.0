Return-Path: <cgroups+bounces-17235-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rDiiK6vXO2o4eAgAu9opvQ
	(envelope-from <cgroups+bounces-17235-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:12:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC56BE772
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:12:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cRDmLMFL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17235-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17235-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8AE300C315
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86D3B27E2;
	Wed, 24 Jun 2026 13:12:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713C1FFC48;
	Wed, 24 Jun 2026 13:12:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306729; cv=none; b=scnF70pdMxXh2FH8EP5uBHGvZdM6gPMTFUrjgqApXlH5hkHfiAB4GVR7GPiqTflcDyzgpLEph0GsJJSVHtU8tf1o/ToJJkEZOy0qlPZQwUYOWujc3U6Se5kVWXQJwMJqlrS+AExhIQx26oIF2ERkQ/xtokHBxZExKIrGPhmkp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306729; c=relaxed/simple;
	bh=9UrLMufOvlGxoknkqSt52NNPmLsH24rSllEDqGq2zFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCprJx7nepRiL4Zcu7qU/pPhLNNPu1aWjNDjKy/gh+/+GJdCB/gkglggAYGOzY2cEcWMav8ADsgMImKmUTJ7jBR47LaX/i2sbetU5wfgsWyoMHLtjTlUHmyFmUd2SLVH6RRz5VycSC0ULXaCPb05Yp8VHYLKyHgG5n8IdD1+kBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRDmLMFL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65E41F00A3A;
	Wed, 24 Jun 2026 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782306727;
	bh=p9Sz4g8DRTMzN+c2HzV4SHb1s9SDfxqT7aAYZmS3o8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cRDmLMFLdsEEOk1HgcrUPYgfXy2J0WVajmVYeSPtRIhlSocPvOSqdG6Ravz8Njok+
	 zA2dzg2BeNbjfWRyt9krdYrkKwwgRm8t7w4yIe+9/gs9ffVjea0tjeolyLDCCpJJyR
	 DdmL6mUohi8/pFWGRk45vuJ+RbPrHgHRSr1DQ42xn0+8RWhFaWq63XoX/n5UmwzSNq
	 Ilq1lc2i48TkqDQw3h270CSyIUPct9xQCBKaY6Dp+ligFYI+HlZSDXxs1BxjNIPn4Y
	 apVn5JRfBVwqM7vYEgspmeXBG6q5zqHL3KVvsyeQ1AQokTSonVzQLfkfYWxl88GKNE
	 k1Ftt1y5BNVhA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 24 Jun 2026 22:11:38 +0900
Subject: [PATCH RFC 1/4] mm/memcontrol: do not drain objcg stock when
 spinning is not allowed
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-kmalloc-nolock-fixes-v1-1-fdf4d17351dd@kernel.org>
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17235-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FEC56BE772

When kmalloc_nolock() drains objcg stock, the stock might be holding
the last reference to the objcg. Since obj_cgroup_release() is a
callback for percpu refcount and does not know whether spinning is
allowed, it is not safe to invoke obj_cgroup_put().

This was caught by lockdep on PREEMPT_RT because acquiring
a sleeping lock (objcg_lock) violates lock nesting rules:

  kernel: BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1267, name: systemd-resolve
  preempt_count: 1, expected: 0
  RCU nest depth: 3, expected: 3
  6 locks held by systemd-resolve/1267:
   #0: ffff888a8165fa20 ((&pcs->lock)){+.+.}-{3:3}, at: kmem_cache_alloc_noprof+0x185/0xa20
   #1: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x74/0x2a0
   #2: ffff888a81648598 ((lock)#4){+.+.}-{3:3}, at: trylock_stock+0x118/0x380
   #3: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x74/0x2a0
   #4: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: percpu_ref_put_many.constprop.0+0x40/0x270
   #5: ffffffff96af11d8 (objcg_lock){+.+.}-{3:3}, at: obj_cgroup_release+0x8a/0x410
  [...]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x8a/0xe0
   dump_stack+0x14/0x1c
   __might_resched.cold+0x233/0x2bb
   rt_spin_lock+0xd3/0x410
   obj_cgroup_release+0x8a/0x410
   percpu_ref_put_many.constprop.0+0x226/0x270
   drain_obj_stock_slot+0x27e/0x8d0
   __refill_obj_stock+0x409/0x6d0
   __memcg_slab_post_alloc_hook+0xa45/0x1500
   __kmalloc_nolock_noprof+0x988/0xc40
   [...]

However, this is illegal in !RT kernels too because the objcg release
callback acquires a spinlock even when spinning is not allowed.

To fix this issue, fall back to atomics when the cached objcg doesn't
match, but it is unsafe to drain because spinning is not allowed.

This is expected to affect performance of kmalloc_nolock() since
it can no longer drain and refill the stock and falls back to a
per-objcg atomic counter (objcg->nr_charged_bytes).

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/memcontrol.c | 34 +++++++++++++++++++++++-----------
 mm/slab.h       |  3 ++-
 mm/slub.c       | 29 +++++++++++++++++++----------
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29390ba13baa..5bb5e75ef5b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3316,18 +3316,19 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 static void __refill_obj_stock(struct obj_cgroup *objcg,
 			       struct obj_stock_pcp *stock,
 			       unsigned int nr_bytes,
-			       bool allow_uncharge)
+			       bool allow_uncharge,
+			       bool allow_spin)
 {
 	unsigned int nr_pages = 0;
 
-	if (!stock) {
-		nr_pages = nr_bytes >> PAGE_SHIFT;
-		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
-		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
-		goto out;
-	}
+	if (!stock)
+		goto fallback;
 
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
+		/* Not safe to drain since objcg release acquires spinlock */
+		if (unlikely(!allow_spin))
+			goto fallback;
+
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3346,6 +3347,13 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+	return;
+
+fallback:
+	nr_pages = nr_bytes >> PAGE_SHIFT;
+	nr_bytes = nr_bytes & (PAGE_SIZE - 1);
+	atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+	goto out;
 }
 
 static void refill_obj_stock(struct obj_cgroup *objcg,
@@ -3353,7 +3361,8 @@ static void refill_obj_stock(struct obj_cgroup *objcg,
 			     bool allow_uncharge)
 {
 	struct obj_stock_pcp *stock = trylock_stock();
-	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
+	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge,
+			   /* allow_spin = */ true);
 	unlock_stock(stock);
 }
 
@@ -3428,6 +3437,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  size_t size, void **p)
 {
 	size_t obj_size = obj_full_size(s);
+	bool allow_spin = alloc_flags_allow_spinning(slab_alloc_flags);
 	struct obj_cgroup *objcg;
 	struct slab *slab;
 	unsigned long off;
@@ -3497,7 +3507,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				return false;
 			stock = trylock_stock();
 			if (remainder)
-				__refill_obj_stock(objcg, stock, remainder, false);
+				__refill_obj_stock(objcg, stock, remainder, false,
+						   allow_spin);
 		}
 		__account_obj_stock(objcg, stock, obj_size,
 				    slab_pgdat(slab), cache_vmstat_idx(s));
@@ -3516,7 +3527,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 }
 
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, unsigned long obj_exts)
+			    void **p, int objects, unsigned long obj_exts,
+			    bool allow_spin)
 {
 	size_t obj_size = obj_full_size(s);
 
@@ -3535,7 +3547,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 		obj_ext->objcg = NULL;
 
 		stock = trylock_stock();
-		__refill_obj_stock(objcg, stock, obj_size, true);
+		__refill_obj_stock(objcg, stock, obj_size, true, allow_spin);
 		__account_obj_stock(objcg, stock, -obj_size,
 				    slab_pgdat(slab), cache_vmstat_idx(s));
 		unlock_stock(stock);
diff --git a/mm/slab.h b/mm/slab.h
index 281a65233795..a6b4ac298d08 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -660,7 +660,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, unsigned int slab_alloc_flags,
 				  size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, unsigned long obj_exts);
+			    void **p, int objects, unsigned long obj_exts,
+			    bool allow_spin);
 #endif
 
 void kvfree_rcu_cb(struct rcu_head *head);
diff --git a/mm/slub.c b/mm/slub.c
index 917635203f73..32672a92581b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2488,7 +2488,7 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 
 static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
-			  int objects)
+			  int objects, bool allow_spin)
 {
 	unsigned long obj_exts;
 
@@ -2500,7 +2500,7 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 		return;
 
 	get_slab_obj_exts(obj_exts);
-	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
+	__memcg_slab_free_hook(s, slab, p, objects, obj_exts, allow_spin);
 	put_slab_obj_exts(obj_exts);
 }
 
@@ -2575,7 +2575,7 @@ static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-					void **p, int objects)
+					void **p, int objects, bool allow_spin)
 {
 }
 
@@ -2946,11 +2946,12 @@ static bool __rcu_free_sheaf_prepare(struct kmem_cache *s,
 	void **p = &sheaf->objects[0];
 	unsigned int i = 0;
 	bool pfmemalloc = false;
+	bool allow_spin = true;
 
 	while (i < sheaf->size) {
 		struct slab *slab = virt_to_slab(p[i]);
 
-		memcg_slab_free_hook(s, slab, p + i, 1);
+		memcg_slab_free_hook(s, slab, p + i, 1, allow_spin);
 		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
 
 		if (unlikely(!slab_free_hook(s, p[i], init, true))) {
@@ -6215,12 +6216,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	struct node_barn *barn;
 	void *remote_objects[PCS_BATCH_MAX];
 	unsigned int remote_nr = 0;
+	bool allow_spin = true;
 
 next_remote_batch:
 	while (i < size) {
 		struct slab *slab = virt_to_slab(p[i]);
 
-		memcg_slab_free_hook(s, slab, p + i, 1);
+		memcg_slab_free_hook(s, slab, p + i, 1, allow_spin);
 		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
 
 		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
@@ -6398,13 +6400,16 @@ static __fastpath_inline
 void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
-	memcg_slab_free_hook(s, slab, &object, 1);
+	bool allow_spin = true;
+
+	memcg_slab_free_hook(s, slab, &object, 1, allow_spin);
 	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, object, true)))
+	if (likely(can_free_to_pcs(slab)) &&
+			likely(free_to_pcs(s, object, allow_spin)))
 		return;
 
 	__slab_free(s, slab, object, object, 1, addr);
@@ -6429,7 +6434,9 @@ static __fastpath_inline
 void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		    void *tail, void **p, int cnt, unsigned long addr)
 {
-	memcg_slab_free_hook(s, slab, p, cnt);
+	bool allow_spin = true;
+
+	memcg_slab_free_hook(s, slab, p, cnt, allow_spin);
 	alloc_tagging_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
@@ -6734,6 +6741,7 @@ void kfree_nolock(const void *object)
 	struct slab *slab;
 	struct kmem_cache *s;
 	void *x = (void *)object;
+	bool allow_spin = false;
 
 	if (unlikely(ZERO_OR_NULL_PTR(object)))
 		return;
@@ -6746,7 +6754,7 @@ void kfree_nolock(const void *object)
 
 	s = slab->slab_cache;
 
-	memcg_slab_free_hook(s, slab, &x, 1);
+	memcg_slab_free_hook(s, slab, &x, 1, allow_spin);
 	alloc_tagging_slab_free_hook(s, slab, &x, 1);
 	/*
 	 * Unlike slab_free() do NOT call the following:
@@ -6776,7 +6784,8 @@ void kfree_nolock(const void *object)
 	 */
 	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
 
-	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
+	if (likely(can_free_to_pcs(slab)) &&
+			likely(free_to_pcs(s, x, allow_spin)))
 		return;
 
 	/*

-- 
2.53.0


