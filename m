Return-Path: <cgroups+bounces-12264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E634BCA5A07
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 23:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD3A1305B741
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64D30FC1C;
	Thu,  4 Dec 2025 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrXk+BB4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3362FBDF2;
	Thu,  4 Dec 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764887404; cv=none; b=RBwkJ1qg7CdV4T/wqUaLp0yZYboHjImPDTCl9xHBDnIGIDrek3uil3xfO6oQnBJybMS589f3XrJ7phqhZEZbyjVpkUkeICTQEuvfLfmY3R9125h8t6ZiQOTNOL81cvXsBx6nB8r9eh71gp54X2hAAISNUgQ0ngRx825UAMQKJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764887404; c=relaxed/simple;
	bh=sP8igXl6qsJwSekuiOY5UI4eR6UTOzfeRhmt0PyWowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvwK7E5QQrZfrhudDwb4tBsyx1+MoOSVuxQMVDNiQrjErWQcr2Xx3NwiyTQOe3r8SolSIP3Z3frfbw50GSSdzIViZ8XBSkMPgZS8iM4DFsPhLE0+K9OFdLOaaAM1Af8/7M5UsiPpcTfSutnnK0goo+j9fE/pCXERYXIWxrT1fzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrXk+BB4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Dec 2025 14:29:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764887398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZYSwOESe8KGknL6RO9823p3TDyuaFDKtZ3tBskISlA=;
	b=vrXk+BB4vd8tsHzc/9rBCiqMkFvgVmd1PUjLJaTjRYJ/zNYdPX7+JdPxEE26gICqmMSoD+
	7kOtjrOFjQ3Uzetugdn5Do3Kf9UiQzv2iC1fGbIlOL8alf33vMmTaC5PWjLlisa9iRM6sl
	2TmB/4+U9eQ56pgpC01DRWlxc2XG1cw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, yuzhao@google.com, zhengqi.arch@bytedance.com, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [RFC PATCH -next 1/2] mm/mglru: use mem_cgroup_iter for global
 reclaim
Message-ID: <tvrspnhlo7x7gpjc4nn7f73b2qoyphkpaxlcnnn4fsxciv6bks@3dibvbs7u5do>
References: <20251204123124.1822965-1-chenridong@huaweicloud.com>
 <20251204123124.1822965-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204123124.1822965-2-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

Hi Chen,

On Thu, Dec 04, 2025 at 12:31:23PM +0000, Chen Ridong wrote:
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
> It performed a stress test based on Zhao Yu's methodology [2] on a
> 1 TB, 4-node NUMA system. The results are summarized below:
> 
> 					memcg LRU    memcg iter
> stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
> sum(pgsteal) / sum(requested)             216.4%        230.5%
> 
> The new implementation demonstrates a significant improvement in
> fairness, reducing the standard deviation relative to the mean by
> 15.5 percentage points. While the reclaim accuracy shows a slight
> increase in overscan (from 85086871 to 90633890, 6.5%).
> 
> The primary benefits of this change are:
> 1. Simplified codebase by removing custom memcg LRU infrastructure
> 2. Improved fairness in memory reclaim across multiple cgroups
> 3. Better performance when creating many memory cgroups
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Thanks a lot of this awesome work.

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

Unrealted to your patch but why this flush_reclaim_state() is at
different place from the non-MGLRU code path?

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

This function kind of become very similar to shrink_node_memcgs()
function other than shrink_one vs shrink_lruvec. Can you try to combine
them and see if it looks not-ugly? Otherwise the code looks good to me.


