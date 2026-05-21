Return-Path: <cgroups+bounces-16181-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H0yF05QD2pEJAYAu9opvQ
	(envelope-from <cgroups+bounces-16181-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:34:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCF5AB18C
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 586F530EE9DA
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356AE355F35;
	Thu, 21 May 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baTJHRdV"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518593BD638;
	Thu, 21 May 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384621; cv=none; b=pKBAhXsM+SmDoJYOR+r0pSGjliHhkgUaMGfS5kuuQVVvE2ef/04auMnoaQc425ojLPUJv6K+YwFmX+xWEstht+BNth6zpbIm6r7QV9qJuNiT9/psl193mjgt+cxWLHwTaWwuGv1JPMVymVjz1rVzpY4tIfDEu0KE51ICVxeLWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384621; c=relaxed/simple;
	bh=7wnTIhjI5KLSQCta2lyRt6t9yBlxqxVBGbcVL9dorLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMPGxBWisszHDthkNySx0bJl87yPqCJNfjCWRAQ5dhrNGd/Vx+J7Nq11MC93qMpOFjbUhHwhYWZvTkXHZvkXQ+MpNj8sTMUiHQYEU1AJY/M/8d+a9Q+GHQNTWHEQ3+BsNhxOAXfMFnNBuPnEPwwpJJVyUVLTvY/ZrQ2Ou5VsQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=baTJHRdV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KbROC1RMvZVOCR60m+LvXazRO+hu6hGVDgS2VEWrSyE=; b=baTJHRdV8nQoRmLInfmLU9g+oK
	NIKuBFrfk7vDVaT72XYmeTSmRQpl+RI8cKE9krnZhT8ZYLFIggWmS3CR8lvZA9LthssBZVJzHJ3YM
	fdPBSNTRzpzrOO9j0g8RGZ4j0HObQ5V1cAoeb8qfcFaF7t8ArRVCfCMQ9bXV8Ot7CKTilkgdEJKvb
	GwI8ajqWzKVsFXzHi/OMVKvA0Mbcl7t0gKVjd8CLkLAbjjc3qu0gmdEoWX6WeEPi3fUlf3WT/lwlK
	dw1D11JXEM0zKBs3I52113KUD9qPPJNsYAHPWoqjBrPEzMdXiVZk+u6P+3O/Hr+ncS1OJ6ZlHYm4b
	EHfNs9Fg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7Dq-00000008eAg-2Hof;
	Thu, 21 May 2026 17:30:15 +0000
Date: Thu, 21 May 2026 13:30:11 -0400
From: "Liam R . Howlett" <liam@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Kairui Song <ryncsn@gmail.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] mm: list_lru: introduce caller locking for
 additions and deletions
Message-ID: <g3yr5nxoxdj6v23qcsl7dx3k6guzovl52yxezrkregconeci6v@gyarid536gmb>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
 <20260521150330.1955924-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521150330.1955924-6-hannes@cmpxchg.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16181-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liam@infradead.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:dkim,cmpxchg.org:email,linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78DCF5AB18C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/21 11:02AM, Johannes Weiner wrote:
> Locking is currently internal to the list_lru API. However, a caller
> might want to keep auxiliary state synchronized with the LRU state.
> 
> For example, the THP shrinker uses the lock of its custom LRU to keep
> PG_partially_mapped and vmstats consistent.
> 
> To allow the THP shrinker to switch to list_lru, provide normal and
> irqsafe locking primitives as well as caller-locked variants of the
> addition and deletion functions.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  include/linux/list_lru.h |  41 ++++++++++++
>  mm/list_lru.c            | 131 ++++++++++++++++++++++++++++++---------
>  2 files changed, 141 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index fe739d35a864..c79ed378311f 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -83,6 +83,44 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
>  			 gfp_t gfp);
>  void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
>  
> +/**
> + * list_lru_lock: lock the sublist for the given node and memcg
> + * @lru: the lru pointer
> + * @nid: the node id of the sublist to lock.
> + * @memcg: the cgroup of the sublist to lock.
> + *
> + * Returns the locked list_lru_one sublist. The caller must call
> + * list_lru_unlock() when done.
> + *
> + * You must ensure that the memcg is not freed during this call (e.g., with
> + * rcu or by taking a css refcnt).
> + *
> + * Return: the locked list_lru_one, or NULL on failure
> + */
> +struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
> +		struct mem_cgroup *memcg);
> +
> +/**
> + * list_lru_unlock: unlock a sublist locked by list_lru_lock()
> + * @l: the list_lru_one to unlock
> + */
> +void list_lru_unlock(struct list_lru_one *l);
> +
> +struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
> +		struct mem_cgroup *memcg);
> +void list_lru_unlock_irq(struct list_lru_one *l);
> +
> +struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
> +		struct mem_cgroup *memcg, unsigned long *irq_flags);
> +void list_lru_unlock_irqrestore(struct list_lru_one *l,
> +		unsigned long *irq_flags);
> +
> +/* Caller-locked variants, see list_lru_add() etc for documentation */
> +bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
> +		struct list_head *item, int nid, struct mem_cgroup *memcg);
> +bool __list_lru_del(struct list_lru *lru, struct list_lru_one *l,
> +		struct list_head *item, int nid);
> +
>  /**
>   * list_lru_add: add an element to the lru list's tail
>   * @lru: the lru pointer
> @@ -115,6 +153,9 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
>  bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
>  		    struct mem_cgroup *memcg);
>  
> +bool list_lru_add_irq(struct list_lru *lru, struct list_head *item, int nid,
> +		      struct mem_cgroup *memcg);
> +
>  /**
>   * list_lru_add_obj: add an element to the lru list's tail
>   * @lru: the lru pointer
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 65962dbf6dda..df58226eea8c 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -15,17 +15,23 @@
>  #include "slab.h"
>  #include "internal.h"
>  
> -static inline void lock_list_lru(struct list_lru_one *l, bool irq)
> +static inline void lock_list_lru(struct list_lru_one *l, bool irq,
> +				 unsigned long *irq_flags)
>  {
> -	if (irq)
> +	if (irq_flags)
> +		spin_lock_irqsave(&l->lock, *irq_flags);
> +	else if (irq)
>  		spin_lock_irq(&l->lock);
>  	else
>  		spin_lock(&l->lock);
>  }
>  
> -static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
> +static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off,
> +				   unsigned long *irq_flags)
>  {
> -	if (irq_off)
> +	if (irq_flags)
> +		spin_unlock_irqrestore(&l->lock, *irq_flags);
> +	else if (irq_off)
>  		spin_unlock_irq(&l->lock);
>  	else
>  		spin_unlock(&l->lock);
> @@ -78,7 +84,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  
>  static inline struct list_lru_one *
>  lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
> -		       bool irq, bool skip_empty)
> +		       bool irq, unsigned long *irq_flags, bool skip_empty)
>  {
>  	struct list_lru_one *l;
>  
> @@ -86,12 +92,12 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  again:
>  	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
>  	if (likely(l)) {
> -		lock_list_lru(l, irq);
> +		lock_list_lru(l, irq, irq_flags);
>  		if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
>  			rcu_read_unlock();
>  			return l;
>  		}
> -		unlock_list_lru(l, irq);
> +		unlock_list_lru(l, irq, irq_flags);
>  	}
>  	/*
>  	 * Caller may simply bail out if raced with reparenting or
> @@ -132,38 +138,106 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
>  
>  static inline struct list_lru_one *
>  lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
> -		       bool irq, bool skip_empty)
> +		       bool irq, unsigned long *irq_flags, bool skip_empty)
>  {
>  	struct list_lru_one *l = &lru->node[nid].lru;
>  
> -	lock_list_lru(l, irq);
> +	lock_list_lru(l, irq, irq_flags);
>  
>  	return l;
>  }
>  #endif /* CONFIG_MEMCG */
>  
> -/* The caller must ensure the memcg lifetime. */
> -bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> -		  struct mem_cgroup *memcg)
> +struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
> +				   struct mem_cgroup *memcg)
>  {
> -	struct list_lru_node *nlru = &lru->node[nid];
> -	struct list_lru_one *l;
> +	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/false,
> +				      /*irq_flags=*/NULL, /*skip_empty=*/false);
> +}
> +
> +void list_lru_unlock(struct list_lru_one *l)
> +{
> +	unlock_list_lru(l, /*irq_off=*/false, /*irq_flags=*/NULL);
> +}
> +
> +struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
> +				       struct mem_cgroup *memcg)
> +{
> +	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
> +				      /*irq_flags=*/NULL, /*skip_empty=*/false);
> +}
> +
> +void list_lru_unlock_irq(struct list_lru_one *l)
> +{
> +	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/NULL);
> +}
>  
> -	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
> +struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
> +					   struct mem_cgroup *memcg,
> +					   unsigned long *flags)
> +{
> +	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
> +				      /*irq_flags=*/flags, /*skip_empty=*/false);
> +}
> +
> +void list_lru_unlock_irqrestore(struct list_lru_one *l, unsigned long *flags)
> +{
> +	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/flags);
> +}
> +
> +bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
> +		    struct list_head *item, int nid,
> +		    struct mem_cgroup *memcg)
> +{
>  	if (list_empty(item)) {
>  		list_add_tail(item, &l->list);
>  		/* Set shrinker bit if the first element was added */
>  		if (!l->nr_items++)
>  			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
> -		unlock_list_lru(l, false);
> -		atomic_long_inc(&nlru->nr_items);
> +		atomic_long_inc(&lru->node[nid].nr_items);
>  		return true;
>  	}
> -	unlock_list_lru(l, false);
>  	return false;
>  }
>  EXPORT_SYMBOL_GPL(list_lru_add);
>  
> +bool __list_lru_del(struct list_lru *lru, struct list_lru_one *l,
> +		    struct list_head *item, int nid)
> +{
> +	if (!list_empty(item)) {
> +		list_del_init(item);
> +		l->nr_items--;
> +		atomic_long_dec(&lru->node[nid].nr_items);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/* The caller must ensure the memcg lifetime. */
> +bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> +		  struct mem_cgroup *memcg)
> +{
> +	struct list_lru_one *l;
> +	bool ret;
> +
> +	l = list_lru_lock(lru, nid, memcg);
> +	ret = __list_lru_add(lru, l, item, nid, memcg);
> +	list_lru_unlock(l);
> +	return ret;
> +}
> +
> +bool list_lru_add_irq(struct list_lru *lru, struct list_head *item,
> +		      int nid, struct mem_cgroup *memcg)
> +{
> +	struct list_lru_one *l;
> +	bool ret;
> +
> +	l = list_lru_lock_irq(lru, nid, memcg);
> +	ret = __list_lru_add(lru, l, item, nid, memcg);
> +	list_lru_unlock_irq(l);
> +	return ret;
> +}
> +
>  bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>  {
>  	bool ret;
> @@ -185,19 +259,13 @@ EXPORT_SYMBOL_GPL(list_lru_add_obj);
>  bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
>  		  struct mem_cgroup *memcg)
>  {
> -	struct list_lru_node *nlru = &lru->node[nid];
>  	struct list_lru_one *l;
> +	bool ret;
>  
> -	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
> -	if (!list_empty(item)) {
> -		list_del_init(item);
> -		l->nr_items--;
> -		unlock_list_lru(l, false);
> -		atomic_long_dec(&nlru->nr_items);
> -		return true;
> -	}
> -	unlock_list_lru(l, false);
> -	return false;
> +	l = list_lru_lock(lru, nid, memcg);
> +	ret = __list_lru_del(lru, l, item, nid);
> +	list_lru_unlock(l);
> +	return ret;
>  }
>  
>  bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> @@ -270,7 +338,8 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  	unsigned long isolated = 0;
>  
>  restart:
> -	l = lock_list_lru_of_memcg(lru, nid, memcg, irq_off, true);
> +	l = lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/irq_off,
> +				   /*irq_flags=*/NULL, /*skip_empty=*/true);
>  	if (!l)
>  		return isolated;
>  	list_for_each_safe(item, n, &l->list) {
> @@ -311,7 +380,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>  			BUG();
>  		}
>  	}
> -	unlock_list_lru(l, irq_off);
> +	unlock_list_lru(l, irq_off, NULL);
>  out:
>  	return isolated;
>  }
> -- 
> 2.54.0
> 

