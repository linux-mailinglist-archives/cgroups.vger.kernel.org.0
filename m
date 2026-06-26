Return-Path: <cgroups+bounces-17333-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4/IPGWyNPmpGHwkAu9opvQ
	(envelope-from <cgroups+bounces-17333-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:32:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC56CDEF2
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GDwsXadG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17333-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17333-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28E430209E9
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231D3F7A83;
	Fri, 26 Jun 2026 14:30:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6926A08F;
	Fri, 26 Jun 2026 14:30:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484254; cv=none; b=mQMvkHSznikil5iHaFxp1kDwiItJwPP+cf8uL0cKSECZSYU8UEE3wb1QCbUIYSMRv+McYx4gYpIwpmBBoiea/dQFoN7ed8OcL23EKDGnQ+9LHja4HzNJ4ebiwmvq0yvro4RHF7y2VAQYnl8nxphcabcAEcFUVeTjIOi3v0owaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484254; c=relaxed/simple;
	bh=3XLmTiO6eadTaOv9ADltHdISY35t/Nox0ZgjOhRXpIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBXotUJ4ZL+KUtAO/6gHv1PVSxutP5vZnIKaIp+awoTJkgkZDnP7Zx99Knh+BW4S/ZPo901Y/xe290UHfr+Cv1d0+4+qxy5/s1vfCc6YJTSlKhltuJ4k1h4dqHQfDLZ7BcaXLXdhtPxZd3SjwzgNicpkTUcBo0owES8uGJj8hRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDwsXadG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30871F000E9;
	Fri, 26 Jun 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782484253;
	bh=vu8WzrwqApX7wsPkaWrxMrSifCAb56jkTiTB7+zyurI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GDwsXadGCDqv1qq8R5wyE2mYy9bMCwO74e6g644EFGVGk8OCUpOgICLOZigXvg31l
	 msYkZOAKKBaMsNkAoPdHAOL0y/JJ2DG0ZWG97k6CBMgNKKxC2LH4sVq1EtSQqSPv6e
	 WomcAvBIFxWyzIL5IaliZZ2ahLx8xemr1KBnsrMOzmXpp8wDTY5WDHVZ1MGpwVcRz5
	 mgltLTDa30yepVyh6w5NzhetDMxe2wfi3oKjgVwBHOK5I58qJQcTDnhFaF7/z5A+9T
	 Crhks2tl+4q+ILFS2p4CopOCrQP4YclPdwyQl9bUX3AZSTEhNOV1GwgyhlkYTx3fV7
	 7Hngm+Y4fB7XQ==
Message-ID: <104794ff-9f04-48be-91e8-89d5d2269f95@kernel.org>
Date: Fri, 26 Jun 2026 16:30:48 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] mm/memcontrol: do not drain objcg stock when
 spinning is not allowed
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <20260624-kmalloc-nolock-fixes-v1-1-fdf4d17351dd@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-1-fdf4d17351dd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17333-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFBC56CDEF2

On 6/24/26 15:11, Harry Yoo (Oracle) wrote:
> When kmalloc_nolock() drains objcg stock, the stock might be holding
> the last reference to the objcg. Since obj_cgroup_release() is a
> callback for percpu refcount and does not know whether spinning is
> allowed, it is not safe to invoke obj_cgroup_put().
> 
> This was caught by lockdep on PREEMPT_RT because acquiring
> a sleeping lock (objcg_lock) violates lock nesting rules:
> 
>   kernel: BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>   kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1267, name: systemd-resolve
>   preempt_count: 1, expected: 0
>   RCU nest depth: 3, expected: 3
>   6 locks held by systemd-resolve/1267:
>    #0: ffff888a8165fa20 ((&pcs->lock)){+.+.}-{3:3}, at: kmem_cache_alloc_noprof+0x185/0xa20
>    #1: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x74/0x2a0
>    #2: ffff888a81648598 ((lock)#4){+.+.}-{3:3}, at: trylock_stock+0x118/0x380
>    #3: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x74/0x2a0
>    #4: ffffffff9658a4c0 (rcu_read_lock){....}-{1:3}, at: percpu_ref_put_many.constprop.0+0x40/0x270
>    #5: ffffffff96af11d8 (objcg_lock){+.+.}-{3:3}, at: obj_cgroup_release+0x8a/0x410
>   [...]
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x8a/0xe0
>    dump_stack+0x14/0x1c
>    __might_resched.cold+0x233/0x2bb
>    rt_spin_lock+0xd3/0x410
>    obj_cgroup_release+0x8a/0x410
>    percpu_ref_put_many.constprop.0+0x226/0x270
>    drain_obj_stock_slot+0x27e/0x8d0
>    __refill_obj_stock+0x409/0x6d0
>    __memcg_slab_post_alloc_hook+0xa45/0x1500
>    __kmalloc_nolock_noprof+0x988/0xc40
>    [...]
> 
> However, this is illegal in !RT kernels too because the objcg release
> callback acquires a spinlock even when spinning is not allowed.
> 
> To fix this issue, fall back to atomics when the cached objcg doesn't
> match, but it is unsafe to drain because spinning is not allowed.
> 
> This is expected to affect performance of kmalloc_nolock() since
> it can no longer drain and refill the stock and falls back to a
> per-objcg atomic counter (objcg->nr_charged_bytes).

Maybe it's not bad that the constrained operation will not do a drain? Could
we say it's likely that both _nolock() and normal operations will likely be
happening on the same cpu for the same memcg, so a normal one will soon
handle it?

> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  mm/memcontrol.c | 34 +++++++++++++++++++++++-----------
>  mm/slab.h       |  3 ++-
>  mm/slub.c       | 29 +++++++++++++++++++----------
>  3 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 29390ba13baa..5bb5e75ef5b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3316,18 +3316,19 @@ static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
>  static void __refill_obj_stock(struct obj_cgroup *objcg,
>  			       struct obj_stock_pcp *stock,
>  			       unsigned int nr_bytes,
> -			       bool allow_uncharge)
> +			       bool allow_uncharge,
> +			       bool allow_spin)
>  {
>  	unsigned int nr_pages = 0;
>  
> -	if (!stock) {
> -		nr_pages = nr_bytes >> PAGE_SHIFT;
> -		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
> -		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> -		goto out;
> -	}
> +	if (!stock)
> +		goto fallback;
>  
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> +		/* Not safe to drain since objcg release acquires spinlock */
> +		if (unlikely(!allow_spin))
> +			goto fallback;
> +
>  		drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
>  		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> @@ -3346,6 +3347,13 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>  out:
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> +	return;
> +
> +fallback:
> +	nr_pages = nr_bytes >> PAGE_SHIFT;
> +	nr_bytes = nr_bytes & (PAGE_SIZE - 1);
> +	atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> +	goto out;
>  }
>  
>  static void refill_obj_stock(struct obj_cgroup *objcg,
> @@ -3353,7 +3361,8 @@ static void refill_obj_stock(struct obj_cgroup *objcg,
>  			     bool allow_uncharge)
>  {
>  	struct obj_stock_pcp *stock = trylock_stock();
> -	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge);
> +	__refill_obj_stock(objcg, stock, nr_bytes, allow_uncharge,
> +			   /* allow_spin = */ true);
>  	unlock_stock(stock);
>  }
>  
> @@ -3428,6 +3437,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				  size_t size, void **p)
>  {
>  	size_t obj_size = obj_full_size(s);
> +	bool allow_spin = alloc_flags_allow_spinning(slab_alloc_flags);
>  	struct obj_cgroup *objcg;
>  	struct slab *slab;
>  	unsigned long off;
> @@ -3497,7 +3507,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				return false;
>  			stock = trylock_stock();
>  			if (remainder)
> -				__refill_obj_stock(objcg, stock, remainder, false);
> +				__refill_obj_stock(objcg, stock, remainder, false,
> +						   allow_spin);
>  		}
>  		__account_obj_stock(objcg, stock, obj_size,
>  				    slab_pgdat(slab), cache_vmstat_idx(s));
> @@ -3516,7 +3527,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  }
>  
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -			    void **p, int objects, unsigned long obj_exts)
> +			    void **p, int objects, unsigned long obj_exts,
> +			    bool allow_spin)
>  {
>  	size_t obj_size = obj_full_size(s);
>  
> @@ -3535,7 +3547,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  		obj_ext->objcg = NULL;
>  
>  		stock = trylock_stock();
> -		__refill_obj_stock(objcg, stock, obj_size, true);
> +		__refill_obj_stock(objcg, stock, obj_size, true, allow_spin);
>  		__account_obj_stock(objcg, stock, -obj_size,
>  				    slab_pgdat(slab), cache_vmstat_idx(s));
>  		unlock_stock(stock);
> diff --git a/mm/slab.h b/mm/slab.h
> index 281a65233795..a6b4ac298d08 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -660,7 +660,8 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  				  gfp_t flags, unsigned int slab_alloc_flags,
>  				  size_t size, void **p);
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -			    void **p, int objects, unsigned long obj_exts);
> +			    void **p, int objects, unsigned long obj_exts,
> +			    bool allow_spin);
>  #endif
>  
>  void kvfree_rcu_cb(struct rcu_head *head);
> diff --git a/mm/slub.c b/mm/slub.c
> index 917635203f73..32672a92581b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2488,7 +2488,7 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>  
>  static __fastpath_inline
>  void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
> -			  int objects)
> +			  int objects, bool allow_spin)
>  {
>  	unsigned long obj_exts;
>  
> @@ -2500,7 +2500,7 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  		return;
>  
>  	get_slab_obj_exts(obj_exts);
> -	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
> +	__memcg_slab_free_hook(s, slab, p, objects, obj_exts, allow_spin);
>  	put_slab_obj_exts(obj_exts);
>  }
>  
> @@ -2575,7 +2575,7 @@ static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  }
>  
>  static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -					void **p, int objects)
> +					void **p, int objects, bool allow_spin)
>  {
>  }
>  
> @@ -2946,11 +2946,12 @@ static bool __rcu_free_sheaf_prepare(struct kmem_cache *s,
>  	void **p = &sheaf->objects[0];
>  	unsigned int i = 0;
>  	bool pfmemalloc = false;
> +	bool allow_spin = true;
>  
>  	while (i < sheaf->size) {
>  		struct slab *slab = virt_to_slab(p[i]);
>  
> -		memcg_slab_free_hook(s, slab, p + i, 1);
> +		memcg_slab_free_hook(s, slab, p + i, 1, allow_spin);
>  		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
>  
>  		if (unlikely(!slab_free_hook(s, p[i], init, true))) {
> @@ -6215,12 +6216,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	struct node_barn *barn;
>  	void *remote_objects[PCS_BATCH_MAX];
>  	unsigned int remote_nr = 0;
> +	bool allow_spin = true;
>  
>  next_remote_batch:
>  	while (i < size) {
>  		struct slab *slab = virt_to_slab(p[i]);
>  
> -		memcg_slab_free_hook(s, slab, p + i, 1);
> +		memcg_slab_free_hook(s, slab, p + i, 1, allow_spin);
>  		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
>  
>  		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
> @@ -6398,13 +6400,16 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	       unsigned long addr)
>  {
> -	memcg_slab_free_hook(s, slab, &object, 1);
> +	bool allow_spin = true;
> +
> +	memcg_slab_free_hook(s, slab, &object, 1, allow_spin);
>  	alloc_tagging_slab_free_hook(s, slab, &object, 1);
>  
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>  
> -	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, object, true)))
> +	if (likely(can_free_to_pcs(slab)) &&
> +			likely(free_to_pcs(s, object, allow_spin)))
>  		return;
>  
>  	__slab_free(s, slab, object, object, 1, addr);
> @@ -6429,7 +6434,9 @@ static __fastpath_inline
>  void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>  		    void *tail, void **p, int cnt, unsigned long addr)
>  {
> -	memcg_slab_free_hook(s, slab, p, cnt);
> +	bool allow_spin = true;
> +
> +	memcg_slab_free_hook(s, slab, p, cnt, allow_spin);
>  	alloc_tagging_slab_free_hook(s, slab, p, cnt);
>  	/*
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
> @@ -6734,6 +6741,7 @@ void kfree_nolock(const void *object)
>  	struct slab *slab;
>  	struct kmem_cache *s;
>  	void *x = (void *)object;
> +	bool allow_spin = false;
>  
>  	if (unlikely(ZERO_OR_NULL_PTR(object)))
>  		return;
> @@ -6746,7 +6754,7 @@ void kfree_nolock(const void *object)
>  
>  	s = slab->slab_cache;
>  
> -	memcg_slab_free_hook(s, slab, &x, 1);
> +	memcg_slab_free_hook(s, slab, &x, 1, allow_spin);
>  	alloc_tagging_slab_free_hook(s, slab, &x, 1);
>  	/*
>  	 * Unlike slab_free() do NOT call the following:
> @@ -6776,7 +6784,8 @@ void kfree_nolock(const void *object)
>  	 */
>  	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
>  
> -	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
> +	if (likely(can_free_to_pcs(slab)) &&
> +			likely(free_to_pcs(s, x, allow_spin)))
>  		return;
>  
>  	/*
> 


