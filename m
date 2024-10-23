Return-Path: <cgroups+bounces-5212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B99AD76B
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 00:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D94D283CFE
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570E21E2315;
	Wed, 23 Oct 2024 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxDbuDy3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F291C3030
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721867; cv=none; b=FN7KmeWePmfaVNtYhBWitdCDxJzSB3RrtGozkUD7ECyDB7PPRaaJzL60guyAtGHf1ZlRj33T0ErnM390ObZhy/jOssVhNj1AGzQbHGx7yu923lArPu3Sji0NlPkhfzbpK4CC2/byqpJ7copY0P7EGaB+rIjZE8WsLMoLsaLnle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721867; c=relaxed/simple;
	bh=nl/Fi0lK9nRLwlnTm9n7IsKNCuE4JyFYoeygcP5Serc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lItQcQR8oLNn0+vWmxcUjCeNstado8REXMWr3h+v7poGqNaRYR1klxP2KSxJdRVBTAyaH5/NozREt0jU2WHv/LcmMCveRoSW311jXHtLxePJo2cYFJGWHikjAalz1mvIFrjCyxGSWCJZ9oYxCf9QvoxfEsIZ1WfZn6juUJux/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxDbuDy3; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 15:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729721861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbJ/667kHqyaQ1rF1n2BRQKGCbmZnDfhN6bBeCoJSXo=;
	b=gxDbuDy3+4DK9t/omshSIxPKIxPYROTS3pLFzMSaXNZj//qFz+EPt5g2aFpstP0MASaQW9
	BLTzY5DNoNTozy9+h4bxKjD+IIu7K6XuN+1f+NhhL41twZFwkcgcsLinBKsufgdRhXbyBh
	HLcEM5jy053N7uDVgeq3NatAL4KvvqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushcin@linux.dev, muchun.song@linux.dev, lnyng@meta.com, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <acaahpfoyy3rci6ekfw2l3i2k5jpww6uzmc7dintpird7b4ayq@6cgrsqyy3xg6>
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 01:34:33PM GMT, Joshua Hahn wrote:
> Changelog
> v2:
>   * Enables the feature only if memcg accounts for hugeTLB usage
>   * Moves the counter from memcg_stat_item to node_stat_item
>   * Expands on motivation & justification in commitlog
>   * Added Suggested-by: Nhat Pham
> 
> This patch introduces a new counter to memory.stat that tracks hugeTLB
> usage, only if hugeTLB accounting is done to memory.current. This
> feature is enabled the same way hugeTLB accounting is enabled, via
> the memory_hugetlb_accounting mount flag for cgroupsv2.
> 
> 1. Why is this patch necessary?
> Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> hugeTLB usage to memory.current. However, the metric is not reported in
> memory.stat. Given that users often interpret memory.stat as a breakdown
> of the value reported in memory.current, the disparity between the two
> reports can be confusing. This patch solves this problem by including
> the metric in memory.stat as well, but only if it is also reported in
> memory.current (it would also be confusing if the value was reported in
> memory.stat, but not in memory.current)
> 
> Aside from the consistentcy between the two files, we also see benefits
> in observability. Userspace might be interested in the hugeTLB footprint
> of cgroups for many reasons. For instance, system admins might want to
> verify that hugeTLB usage is distributed as expected across tasks: i.e.
> memory-intensive tasks are using more hugeTLB pages than tasks that
> don't consume a lot of memory, or is seen to fault frequently. Note that
> this is separate from wanting to inspect the distribution for limiting
> purposes (in which case, hugeTLB controller makes more sense).
> 
> 2. We already have a hugeTLB controller. Why not use that?
> It is true that hugeTLB tracks the exact value that we want. In fact, by
> enabling the hugeTLB controller, we get all of the observability
> benefits that I mentioned above, and users can check the total hugeTLB
> usage, verify if it is distributed as expected, etc.
> 
> With this said, there are 2 problems:
>   (a) They are still not reported in memory.stat, which means the
>       disparity between the memcg reports are still there.
>   (b) We cannot reasonably expect users to enable the hugeTLB controller
>       just for the sake of hugeTLB usage reporting, especially since
>       they don't have any use for hugeTLB usage enforcing [2].
> 
> [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
> [2] Of course, we can't make a new patch for every feature that can be
>     duplicated. However, since the exsting solution of enabling the
>     hugeTLB controller is an imperfect solution that still leaves a
>     discrepancy between memory.stat and memory.curent, I think that it
>     is reasonable to isolate the feature in this case.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  include/linux/mmzone.h |  3 +++
>  mm/hugetlb.c           |  4 ++++
>  mm/memcontrol.c        | 11 +++++++++++
>  mm/vmstat.c            |  3 +++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 17506e4a2835..d3ba49a974b2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -215,6 +215,9 @@ enum node_stat_item {
>  #ifdef CONFIG_NUMA_BALANCING
>  	PGPROMOTE_SUCCESS,	/* promote successfully */
>  	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +	HUGETLB_B,

As Yosry pointed out, this is in pages, not bytes. There is already
functionality to display this bin ytes for the readers of the memory
stats.

Also you will need to update Documentation/admin-guide/cgroup-v2.rst to
include the hugetlb stats.

>  #endif
>  	/* PGDEMOTE_*: pages demoted */
>  	PGDEMOTE_KSWAPD,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..055bc91858e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
>  				     pages_per_huge_page(h), folio);
>  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					  pages_per_huge_page(h), folio);
> +	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> +		lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge_page(h));

Please note that by you are adding this stat not only in memcg but also
in global and per-node vmstat. This check will break those interfaces
when this mount option is not used. You only need the check at the
charging time. The uncharging and stats update functions will do the
right thing as they check memcg_data attached to the folio.

>  	mem_cgroup_uncharge(folio);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> @@ -3094,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	if (!memcg_charge_ret)
>  		mem_cgroup_commit_charge(folio, memcg);
>  	mem_cgroup_put(memcg);
> +	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)

Same here.

> +		lruvec_stat_mod_folio(folio, HUGETLB_B, pages_per_huge_page(h));
>  
>  	return folio;
  

