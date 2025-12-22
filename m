Return-Path: <cgroups+bounces-12563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA7CD49CA
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7215B3006442
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81033325495;
	Mon, 22 Dec 2025 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLXTjyXj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2C25D208
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373149; cv=none; b=ZlaERl0/UHmeIiOtGc8LkXvp9jeNGj8GpKoVewPhvx8SCUOHsh4Nm1+bCsMZ2gWotFKnozQ93HQxm6sGqJ0LgbFtp4/wbH047UcoGxyk89KkffuS7c9vC5U8QbDM4CSuukNeof6enopImlv/Z1xvdPKXquVrOywrmeUNuU6Gulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373149; c=relaxed/simple;
	bh=8ubcDfZCx9I+/7lLfpob8ayqW+/iRvtcqlrAIvQcolY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfP70AbVgQX+DrUKyB9YRY4ULO+9YgE9DQYfHUt8I4ctER7A4g6klzrV4CSLC+Ibu+ngTpSme34Ry7YMgZD9FZdelZ2Xtsn2H9+jKlOdb7w2QZhsSOdEMI4CpyFViS4hMk4zK12woLHiVIapgwW9DvKE3fyZLpjiITOmOWxOnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLXTjyXj; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Dec 2025 19:12:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766373133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhDz9De+0KQKYXwyi7fXsZXUS+UyFkHbIg9lL8okLng=;
	b=LLXTjyXj4sjKaSd7i+xSAkBw/Egc4X73CMw9V0L1nvh4msC2Wo73V2CTmMnyFZ6OV4btxo
	fGnwKNSKQDavxwzVJ0cZAwHrzN+Rppl+CgK3m8F3QniAgBfr2K3jzqizcuiYBDRUx9b9ql
	rMlMj7XO0cSjsvw3e70ahe02CtnyJxs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, zhengqi.arch@bytedance.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 1/5] mm/mglru: use mem_cgroup_iter for global
 reclaim
Message-ID: <gkudpvytcc3aa5yjaigwtkyyyglmvnnqngrexfuqiv2mzxj5cn@e7rezszexd7l>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 09, 2025 at 01:25:53AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced for global reclaim to enhance
> scalability. However, its implementation complexity has led to performance
> regressions when dealing with a large number of memory cgroups [1].
> 
> As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
> cookie-based iteration for global reclaim, aligning with the approach
> already used in shrink_node_memcgs. This simplification removes the
> dedicated memcg LRU tracking while maintaining the core functionality.
> 
> It performed a stress test based on Yu Zhao's methodology [2] on a
> 1 TB, 4-node NUMA system. The results are summarized below:
> 
> 	pgsteal:
> 						memcg LRU    memcg iter
> 	stddev(pgsteal) / mean(pgsteal)		106.03%		93.20%
> 	sum(pgsteal) / sum(requested)		98.10%		99.28%
> 
> 	workingset_refault_anon:
> 						memcg LRU    memcg iter
> 	stddev(refault) / mean(refault)		193.97%		134.67%
> 	sum(refault)				1963229		2027567
> 
> The new implementation shows a clear fairness improvement, reducing the
> standard deviation relative to the mean by 12.8 percentage points. The
> pgsteal ratio is also closer to 100%. Refault counts increased by 3.2%
> (from 1,963,229 to 2,027,567).
> 
> The primary benefits of this change are:
> 1. Simplified codebase by removing custom memcg LRU infrastructure
> 2. Improved fairness in memory reclaim across multiple cgroups
> 3. Better performance when creating many memory cgroups
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
> Suggested-by: Johannes Weiner <hannes@cmxpchg.org>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Johannes Weiner <hannes@cmxpchg.org>
> ---
>  mm/vmscan.c | 117 ++++++++++++++++------------------------------------
>  1 file changed, 36 insertions(+), 81 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fddd168a9737..70b0e7e5393c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4895,27 +4895,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  	return nr_to_scan < 0;
>  }
>  
> -static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
> +static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>  {
> -	bool success;
>  	unsigned long scanned = sc->nr_scanned;
>  	unsigned long reclaimed = sc->nr_reclaimed;
> -	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>  
> -	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
> -	if (mem_cgroup_below_min(NULL, memcg))
> -		return MEMCG_LRU_YOUNG;
> -
> -	if (mem_cgroup_below_low(NULL, memcg)) {
> -		/* see the comment on MEMCG_NR_GENS */
> -		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
> -			return MEMCG_LRU_TAIL;
> -
> -		memcg_memory_event(memcg, MEMCG_LOW);
> -	}
> -
> -	success = try_to_shrink_lruvec(lruvec, sc);
> +	try_to_shrink_lruvec(lruvec, sc);
>  
>  	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
>  
> @@ -4924,86 +4911,55 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>  			   sc->nr_reclaimed - reclaimed);
>  
>  	flush_reclaim_state(sc);
> -
> -	if (success && mem_cgroup_online(memcg))
> -		return MEMCG_LRU_YOUNG;
> -
> -	if (!success && lruvec_is_sizable(lruvec, sc))
> -		return 0;
> -
> -	/* one retry if offlined or too small */
> -	return READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL ?
> -	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
>  }
>  
>  static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
>  {
> -	int op;
> -	int gen;
> -	int bin;
> -	int first_bin;
> -	struct lruvec *lruvec;
> -	struct lru_gen_folio *lrugen;
> +	struct mem_cgroup *target = sc->target_mem_cgroup;
> +	struct mem_cgroup_reclaim_cookie reclaim = {
> +		.pgdat = pgdat,
> +	};
> +	struct mem_cgroup_reclaim_cookie *cookie = &reclaim;

Please keep the naming same as shrink_node_memcgs i.e. use 'partial'
here.

>  	struct mem_cgroup *memcg;
> -	struct hlist_nulls_node *pos;
>  
> -	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
> -	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
> -restart:
> -	op = 0;
> -	memcg = NULL;
> -
> -	rcu_read_lock();
> +	if (current_is_kswapd() || sc->memcg_full_walk)
> +		cookie = NULL;
>  
> -	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
> -		if (op) {
> -			lru_gen_rotate_memcg(lruvec, op);
> -			op = 0;
> -		}
> +	memcg = mem_cgroup_iter(target, NULL, cookie);
> +	while (memcg) {

Please use the do-while loop same as shrink_node_memcgs and then change
the goto next below to continue similar to shrink_node_memcgs.

> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  
> -		mem_cgroup_put(memcg);
> -		memcg = NULL;
> +		cond_resched();
>  
> -		if (gen != READ_ONCE(lrugen->gen))
> -			continue;
> +		mem_cgroup_calculate_protection(target, memcg);
>  
> -		lruvec = container_of(lrugen, struct lruvec, lrugen);
> -		memcg = lruvec_memcg(lruvec);
> +		if (mem_cgroup_below_min(target, memcg))
> +			goto next;
>  
> -		if (!mem_cgroup_tryget(memcg)) {
> -			lru_gen_release_memcg(memcg);
> -			memcg = NULL;
> -			continue;
> +		if (mem_cgroup_below_low(target, memcg)) {
> +			if (!sc->memcg_low_reclaim) {
> +				sc->memcg_low_skipped = 1;
> +				goto next;
> +			}
> +			memcg_memory_event(memcg, MEMCG_LOW);
>  		}
>  
> -		rcu_read_unlock();
> +		shrink_one(lruvec, sc);
>  
> -		op = shrink_one(lruvec, sc);
> -
> -		rcu_read_lock();
> -
> -		if (should_abort_scan(lruvec, sc))
> +		if (should_abort_scan(lruvec, sc)) {
> +			if (cookie)
> +				mem_cgroup_iter_break(target, memcg);
>  			break;

This seems buggy as we may break the loop without calling
mem_cgroup_iter_break(). I think for kswapd the cookie will be NULL and
if should_abort_scan() returns true, we will break the loop without
calling mem_cgroup_iter_break() and will leak a reference to memcg.


