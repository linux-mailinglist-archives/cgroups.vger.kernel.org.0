Return-Path: <cgroups+bounces-5489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA949C27AF
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 23:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B328464E
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237D1F582B;
	Fri,  8 Nov 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEQtUttB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19551D0F4F
	for <cgroups@vger.kernel.org>; Fri,  8 Nov 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105784; cv=none; b=SyHG3o1q2vqYzjegevnJvKcnprNHy/kw4amLw6LyUMFErEoNCtTAAe53XoB13Ul9sSS+KzzFdVYXF8sQVjErOP0RgSMSC9Ml3AvACcad7a+bCowHyNYmaBjzEfSHyj6wmQRbLN9mcbLvXYRbKJyQeoTnn51cVCoqCpC99AZjCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105784; c=relaxed/simple;
	bh=UA1j0lGdwXPAfAD9de0XdydIWE64+hqZJBeYPdvRVGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+RySFNdP2+tVAVj0sBtorTLiDpfq6umGhNeGE1IzNuqpagcpfJvJJECYZ27wVyhRDXKDOEekdu8Bc+eXOgfBxSEJT/7HoRP2YPmZmefK6/b8gEq5iZ+ZztVOYk3ve4ha5NNoZWVP+wcPEXsltinVy6rI78tPBcA3sgqdKamYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEQtUttB; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 14:42:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731105779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EaU4/A6qN+s4NwESrU06mXqhjeqkwS2os0mJlrPgmQI=;
	b=TEQtUttB7t3S6AALgjFubWKeTXnbmbztwdNlefzVXB8eWM0fLE+0abM2Yz35F5K4BoRd+i
	93IOMjCmdltbyLl4a1yWt+Ir0jrzU/2ISpeLaqyk96dp30k/1OesU+nqJZIS7o+7JP4IMj
	b869/3ZD3/+6UzLWdqGjnrRwg9ql8yw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <kpxl646zwhqcyrq23kfnslqdjgqy5s72vlq2uoc6vhfvwza2ld@yjyj3j6rnlag>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 01:29:45PM -0800, Joshua Hahn wrote:
> This patch introduces mem_cgroup_charge_hugetlb, which combines the
> logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of
> memcg in hugetlb code, and also consolidates the error path that memcg
> can take into just one point.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/hugetlb.c               | 34 ++++++++++++----------------------
>  mm/memcontrol.c            | 19 +++++++++++++++++++
>  3 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bb49e0d4b377..d90c1ac791f1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -678,6 +678,8 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  		long nr_pages);
>  
> +int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
> +
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fbb10e52d7ea..6f6841483039 100644
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
> @@ -3092,10 +3080,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	if (!memcg_charge_ret)
> -		mem_cgroup_commit_charge(folio, memcg);
> -	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> -	mem_cgroup_put(memcg);
> +	ret = mem_cgroup_charge_hugetlb(folio, gfp);
> +	if (ret == -ENOMEM) {
> +		spin_unlock_irq(&hugetlb_lock);

spin_unlock_irq??

> +		free_huge_folio(folio);

free_huge_folio() will call lruvec_stat_mod_folio() unconditionally but
you are only calling it on success. This may underflow the metric.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +	else if (!ret)
> +		lruvec_stat_mod_folio(folio, NR_HUGETLB,
> +		      pages_per_huge_page(h));
>  
>  	return folio;
>  
> @@ -3110,9 +3103,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
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
> index 97f63ec9c9fb..95ee77fe27af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4529,6 +4529,25 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	return 0;
>  }
>  
> +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
> +{
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
> +	int ret = 0;
> +
> +	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
> +		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +		ret = -EOPNOTSUPP;

why EOPNOTSUPP? You need to return 0 here. We do want
lruvec_stat_mod_folio() to be called.

> +		goto out;
> +	}
> +
> +	if (charge_memcg(folio, memcg, gfp))
> +		ret = -ENOMEM;
> +
> +out:
> +	mem_cgroup_put(memcg);
> +	return ret;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
>   * @folio: folio to charge.
> -- 
> 2.43.5
> 

