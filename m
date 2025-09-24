Return-Path: <cgroups+bounces-10415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633AB991D3
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 11:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B947AC869
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F132DE717;
	Wed, 24 Sep 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTSQvpMO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B2DC32B
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705859; cv=none; b=kqBwkUIKygqGya793Gc28bHW7PcvPoItZuiPQwT1WqCXJEyzH4nJr+4WMygvYgurV8vLoezv5U7ZBRZzIUiPX8qKIPKXCgS+/ahbHQ6vC6qsosJEZCy57Wbtuh5AFI1CuVMspwWzwkUZt+h0TxZh3VKr3BWWAn7NH2jsir2ppk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705859; c=relaxed/simple;
	bh=mSV2BTKxKVxAzIGNNjMum25tAnyuhGhXLJzP4cRYY2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+aaFtgTaJvhNYEnObh/WxsGkDJkSpPVbBP2aRNnjKuwQYyd31oVLvgKQ6cvc750nv5GeTVRt9HXocCoEQbmpLXGDEJbLy1lHy7NQ3sV+LGVn1ipYF68/4pTp/z2iD8qL44uusmJIlfJ7yTHE0Q2OgsfyLKHrrewK2936+JfyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTSQvpMO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758705841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wzo9Dce6E9bbwacKQ1Ls7mKYPDh+vWG+TtUgCH/OXas=;
	b=pTSQvpMOMjgXR64fDZuX0h3oxFz000s6Zr4Ovo6DPMsm1S5N8H8RS0PBUenEQIWyqabi4n
	rWKzQRXKWeCwCui0yJfERDJiGtQSaY7oxafIm5sfifcNNC0J1B2rfaXfIcmvtRzPDIsuLg
	SnJeD0BWSWGTvXOWCde/Zfqt48JVv18=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org,  hughd@google.com,  mhocko@suse.com,
  shakeel.butt@linux.dev,  muchun.song@linux.dev,  david@redhat.com,
  lorenzo.stoakes@oracle.com,  ziy@nvidia.com,  harry.yoo@oracle.com,
  baolin.wang@linux.alibaba.com,  Liam.Howlett@oracle.com,
  npache@redhat.com,  ryan.roberts@arm.com,  dev.jain@arm.com,
  baohua@kernel.org,  lance.yang@linux.dev,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
	(Qi Zheng's message of "Tue, 23 Sep 2025 17:16:25 +0800")
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
	<55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Date: Wed, 24 Sep 2025 09:23:49 +0000
Message-ID: <7ia4bjn06w62.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Qi Zheng <zhengqi.arch@bytedance.com> writes:

> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent.

Nit: commit logs should really focus on the actual change, not the future
plans.

>
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  include/linux/mmzone.h  |  1 +
>  mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c         |  1 +
>  mm/mm_init.c            |  1 +
>  5 files changed, 44 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..a0d4b751974d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>  	return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>  
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c57250..f3eb81fee056a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1346,6 +1346,7 @@ struct deferred_split {
>  	spinlock_t split_queue_lock;
>  	struct list_head split_queue;
>  	unsigned long split_queue_len;
> +	bool is_dying;
>  };
>  #endif
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48b51e6230a67..de7806f759cba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>  	struct deferred_split *queue;
>  
>  	memcg = folio_memcg(folio);
> +retry:
>  	queue = memcg ? &memcg->deferred_split_queue :
>  			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>  	spin_lock(&queue->split_queue_lock);
> +	if (unlikely(queue->is_dying == true)) {
> +		spin_unlock(&queue->split_queue_lock);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>  
>  	return queue;
>  }
> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>  	struct deferred_split *queue;
>  
>  	memcg = folio_memcg(folio);
> +retry:
>  	queue = memcg ? &memcg->deferred_split_queue :
>  			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>  	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> +	if (unlikely(queue->is_dying == true)) {
> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>  
>  	return queue;
>  }
> @@ -4284,6 +4296,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	return split;
>  }
>  
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> +	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
> +	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
> +	int nid;
> +
> +	spin_lock_irq(&ds_queue->split_queue_lock);
> +	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
> +
> +	if (!ds_queue->split_queue_len)
> +		goto unlock;
> +
> +	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
> +	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
> +	ds_queue->split_queue_len = 0;
> +	/* Mark the ds_queue dead */
> +	ds_queue->is_dying = true;
> +
> +	for_each_node(nid)
> +		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));

Does this loop need to be under locks?

> +
> +unlock:
> +	spin_unlock(&parent_ds_queue->split_queue_lock);
> +	spin_unlock_irq(&ds_queue->split_queue_lock);
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static void split_huge_pages_all(void)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e090f29eb03bd..d03da72e7585d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	zswap_memcg_offline_cleanup(memcg);
>  
>  	memcg_offline_kmem(memcg);
> +	reparent_deferred_split_queue(memcg);
>  	reparent_shrinker_deferred(memcg);

I guess the naming can be a bit more consistent here :)

Thanks!

