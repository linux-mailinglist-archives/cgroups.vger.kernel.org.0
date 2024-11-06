Return-Path: <cgroups+bounces-5463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AB9BFA73
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 00:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCAD284588
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B820D4FE;
	Wed,  6 Nov 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2mAxqyV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19B1DE8A6
	for <cgroups@vger.kernel.org>; Wed,  6 Nov 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937020; cv=none; b=jfxMDRrSjAzLhuNwDyPOWOzwK29OSdBPVSsHzwo3WboSyC1IJeRVZogVqSgnA/EzzjIurM2X/LiLvZu55VNRlfAgO+lcmxhEW3MD899GPGM99T7ELvF+/l5LLBCZIPYboqEV6J+A3xSJrmAhqjSuKyqfl7LMH0Fop8WkjmQWZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937020; c=relaxed/simple;
	bh=o/1mJP6iyNuvjV8FxTsbxQ0X0cvhyb0dNuVHKSR69AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoKwhhI0RA9IUNYTq3riwbWFt9Pdr18tIDFOaeq08NEWbrxtad9sog5Sa8SwJi6Vs7Rgy1XQJ4P1acMmleogZztLkvWfskx2Q5YcspQKz9ALz33vFPQP83ZduoMpOTozdNnJbZtTV0l7nkK5v9HNmYMhVnZ3VMP3T9vXzhlq9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2mAxqyV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 15:50:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730937014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg2GvaE+yzZyVFg0LFOVZxNsyEO3RamNhvSGqKggQhQ=;
	b=q2mAxqyVW0UCvM1RaGeV38bhLQ7TyItjbQ1TtJuQ3PqusZI/nOuATgQroM6kw4U3Oh9qT2
	zD8AVKu6rt0VN1UgtMQyxSbnZ9a9yUW2J/w8GYbChQB880hB7TBca+sAftYtldOGMeGrUg
	ofsWvwFGfKzk/Y2RPGpuFYPTQ5+s4PE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg
 try-commit-cancel charging
Message-ID: <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106221434.2029328-3-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 02:14:34PM -0800, Joshua Hahn wrote:
> This patch deprecates the memcg try-{commit,cancel} logic used in hugetlb.
> Instead of having three points of error for memcg accounting, the error
> patch is reduced to just one point at the end, and shares the same path
> with the hugeTLB controller as well.
> 
> Please note that the hugeTLB controller still uses the try_charge to 
> {commit/cancel} protocol. 
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  include/linux/memcontrol.h |  3 +--
>  mm/hugetlb.c               | 35 ++++++++++++-----------------------
>  mm/memcontrol.c            | 37 +++++++++----------------------------
>  3 files changed, 22 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 25761d55799e..0024634d161f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -696,8 +696,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  
>  bool memcg_accounts_hugetlb(void);
>  
> -int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> -		long nr_pages);
> +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp);

Please cleanup mem_cgroup_cancel_charge() and mem_cgroup_commit_charge()
as well as there will be no users after this patch.

>  
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fbb10e52d7ea..db9801b16d13 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2967,21 +2967,13 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	struct hstate *h = hstate_vma(vma);
>  	struct folio *folio;
> -	long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
> +	long map_chg, map_commit;
>  	long gbl_chg;
> -	int memcg_charge_ret, ret, idx;
> +	int ret, idx;
>  	struct hugetlb_cgroup *h_cg = NULL;
> -	struct mem_cgroup *memcg;
>  	bool deferred_reserve;
>  	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
>  
> -	memcg = get_mem_cgroup_from_current();
> -	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
> -	if (memcg_charge_ret == -ENOMEM) {
> -		mem_cgroup_put(memcg);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
>  	idx = hstate_index(h);
>  	/*
>  	 * Examine the region/reserve map to determine if the process
> @@ -2989,12 +2981,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	 * code of zero indicates a reservation exists (no change).
>  	 */
>  	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
> -	if (map_chg < 0) {
> -		if (!memcg_charge_ret)
> -			mem_cgroup_cancel_charge(memcg, nr_pages);
> -		mem_cgroup_put(memcg);
> +	if (map_chg < 0)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	/*
>  	 * Processes that did not create the mapping will have no
> @@ -3056,6 +3044,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		/* Fall through */
>  	}
>  
> +	ret = mem_cgroup_charge_hugetlb(folio, gfp);

You can not call this with hugetlb_lock held.

> +	if (ret == -ENOMEM)
> +		goto free_folio;
> +	else if (!ret)
> +		lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> +
>  	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
>  	/* If allocation is not consuming a reservation, also store the
>  	 * hugetlb_cgroup pointer on the page.
> @@ -3092,13 +3086,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	if (!memcg_charge_ret)
> -		mem_cgroup_commit_charge(folio, memcg);
> -	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> -	mem_cgroup_put(memcg);
> -
>  	return folio;
>  
> +free_folio:
> +	spin_unlock_irq(&hugetlb_lock);
> +	free_huge_folio(folio);
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
>  out_uncharge_cgroup_reservation:
> @@ -3110,9 +3102,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		hugepage_subpool_put_pages(spool, 1);
>  out_end_reservation:
>  	vma_end_reservation(h, vma, addr);
> -	if (!memcg_charge_ret)
> -		mem_cgroup_cancel_charge(memcg, nr_pages);
> -	mem_cgroup_put(memcg);
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 59dea0122579..3b728635d6aa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1448,8 +1448,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  		u64 size;
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> -		if (unlikely(memory_stats[i].idx == NR_HUGETLB) &&
> -		    !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))
> +		if (unlikely(memory_stats[i].idx == NR_HUGETLB) && !memcg_accounts_hugetlb())
>  			continue;
>  #endif
>  		size = memcg_page_state_output(memcg, memory_stats[i].idx);
> @@ -4506,37 +4505,19 @@ bool memcg_accounts_hugetlb(void)
>  #endif
>  }
>  
> -/**
> - * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
> - * @memcg: memcg to charge.
> - * @gfp: reclaim mode.
> - * @nr_pages: number of pages to charge.
> - *
> - * This function is called when allocating a huge page folio to determine if
> - * the memcg has the capacity for it. It does not commit the charge yet,
> - * as the hugetlb folio itself has not been obtained from the hugetlb pool.
> - *
> - * Once we have obtained the hugetlb folio, we can call
> - * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain the
> - * folio, we should instead call mem_cgroup_cancel_charge() to undo the effect
> - * of try_charge().
> - *
> - * Returns 0 on success. Otherwise, an error code is returned.
> - */
> -int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> -			long nr_pages)
> +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
>  {
> -	/*
> -	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
> -	 * but do not attempt to commit charge later (or cancel on error) either.
> -	 */
> -	if (mem_cgroup_disabled() || !memcg ||
> -		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_current();

Leaking the above reference in error paths.

> +
> +	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
> +			!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return -EOPNOTSUPP;
>  
> -	if (try_charge(memcg, gfp, nr_pages))
> +	if (charge_memcg(folio, memcg, gfp))
>  		return -ENOMEM;
>  
> +	mem_cgroup_put(memcg);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.5
> 

