Return-Path: <cgroups+bounces-11804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44CC4C68D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 09:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2644F4A11
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBC2ECEAE;
	Tue, 11 Nov 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/b7C496"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCF20C00C
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849458; cv=none; b=pSxROGn9kBajrqUl8ogPwQQR//UWs/HRyEm5dE7S7oUe8QCGWJNXKAHKEGufVMgTOru9EuM85y8KElcYvR32ltlFxVMo+I0GHt+mBwoZrzNrBtqi2WGT10AkHW/tLtdr/wZJnBrkAsNj+z0iUgRVpYLVj/l02DfalqpcT2KmaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849458; c=relaxed/simple;
	bh=uL9hwq5gNe5dCTSe7z+6wGFFcAQxAaT0OYjeBYF3mDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndG1LWsg0TlHYECg+3dXI9LKfh6JrYPoXChsDKm4ZNdgabLf2s0stWoNCy4eZzVqx7Q+fywSjELY9vZTfuCVgU2gCKtdYk7XHyYa3bFgeyg5jRz+Hjn1AmlU6ZXlGnC+MwRGryyWTmvk1jBrcsxN4bKvbcbpAW9rakFNz8w0AkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/b7C496; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19219ae3-209d-4371-b275-ab2043151f60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762849444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1lCF8ZxwiRf7MmmtFFe+0D9tQtuDiUNOYjnvpfAnHA=;
	b=e/b7C496YBxC6KfnwzYKF3iSY9yupIoQg9pFTwlzfN6vHwdjD/PU+M7GyhLeE8pZjvEXJS
	eLbTUlW6R9Si/egd5wODSTyNN3E7HSmi54FePJXdTXu+iDCWKdsWgDJ/Ard2bSG8vlm+On
	OsJUgeyAMmPk0rUsQF0Lv8L1EcHdrSk=
Date: Tue, 11 Nov 2025 16:23:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] memcg: remove __mod_lruvec_kmem_state
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-3-shakeel.butt@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251110232008.1352063-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 11/11/25 7:20 AM, Shakeel Butt wrote:
> The __mod_lruvec_kmem_state is already safe against irqs, so there is no
> need to have a separate interface (i.e. mod_lruvec_kmem_state) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __mod_lruvec_kmem_state to mod_lruvec_kmem_state.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

One nit below:

> ---
>   include/linux/memcontrol.h | 28 +++++-----------------------
>   mm/memcontrol.c            |  2 +-
>   mm/workingset.c            |  2 +-
>   3 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f82fac2fd988..1384a9d305e1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -957,17 +957,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>   void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>   void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
>   
> -void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
> -
> -static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> -					 int val)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	__mod_lruvec_kmem_state(p, idx, val);
> -	local_irq_restore(flags);
> -}
> +void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
>   
>   void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>   			unsigned long count);
> @@ -1403,14 +1393,6 @@ static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
>   {
>   }
>   
> -static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> -					   int val)
> -{
> -	struct page *page = virt_to_head_page(p);
> -
> -	mod_node_page_state(page_pgdat(page), idx, val);
> -}
> -
>   static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>   					 int val)
>   {
> @@ -1470,14 +1452,14 @@ struct slabobj_ext {
>   #endif
>   } __aligned(8);
>   
> -static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
> +static inline void inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
>   {
> -	__mod_lruvec_kmem_state(p, idx, 1);
> +	mod_lruvec_kmem_state(p, idx, 1);
>   }

The inc_lruvec_kmem_state() has only one user.

>   
> -static inline void __dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
> +static inline void dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
>   {
> -	__mod_lruvec_kmem_state(p, idx, -1);
> +	mod_lruvec_kmem_state(p, idx, -1);
>   }

The dec_lruvec_kmem_state() has no user.

Not sure whether inc_lruvec_kmem_state() and dec_lruvec_kmem_state()
also need to be removed.

Thanks,
Qi

>   
>   static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f4b8a6414ed3..3a59d3ee92a7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -799,7 +799,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
>   }
>   EXPORT_SYMBOL(__lruvec_stat_mod_folio);
>   
> -void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
> +void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>   {
>   	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
>   	struct mem_cgroup *memcg;
> diff --git a/mm/workingset.c b/mm/workingset.c
> index d32dc2e02a61..892f6fe94ea9 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -749,7 +749,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
>   	if (WARN_ON_ONCE(node->count != node->nr_values))
>   		goto out_invalid;
>   	xa_delete_node(node, workingset_update_node);
> -	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
> +	inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
>   
>   out_invalid:
>   	xa_unlock_irq(&mapping->i_pages);


