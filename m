Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FEA1B37FD
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDVGv7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDVGv6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:51:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2AC03C1A6;
        Tue, 21 Apr 2020 23:51:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so572027plt.2;
        Tue, 21 Apr 2020 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DcYHbMZGpcrHfvenBtxvVqpjCOh9H7+DlzQW3F21tOY=;
        b=DMgb26Rt8E21uB+Z94yu3hVn1nN3KlCOtpn5rVh9kXMZEHxByzeETb3slv0SqVcg96
         UVYIQPJTzHHdsUtP0HDfqeC3KFSjeZQ5TX9E+urWPMEBdQwYfjY2XFF7D+wV8hlSMOpO
         6vn/xaq+5nTrrWM8AQYq/26eL8tKNFg07ZEUsXhCYkUXVvd8psEYsyx/kYTLXHj2yqYS
         RCr2Qn/9lPTJ/XjptelCtyANi49BnLsMIdos8SYLK5ZFeknlmKIO0DeF5IGitE6HAav9
         VRnkETF5rGyqtTa8Ed5juiKr5GkrQeDYd2tPAa5qjTTIzHzvUXiDUFX5UIOoLM0kraa/
         eWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcYHbMZGpcrHfvenBtxvVqpjCOh9H7+DlzQW3F21tOY=;
        b=fHX5fQuaxiSWpmIZjizKeaZ7XCo38hPAdCcxi53U8pRwfTajTyk1YT7AR6USHe75nU
         s9DteXhVO70qE5StSt2Xwt/gv37rtffI3UyACql0zUYfumLOdqvpS4d69S6sZlqH9yl5
         X8e6orI8745BiGrtaJ2pLZSOt/CwFPxWWwNwQDoXVWwjfh1rd0eaYC/saDzWYC1+EGL8
         O2OFfjPkg1RliQp3j7r8V5nhZ6aswwswLOW9jVlIaKBbjGCicUVrkf7kju714lXJuTKR
         ZYdQB2uEuGw+4dc5n8TKtW6zG2yDcllB87m9QxB3CYCXU8ZxlJ4mpnaAog3WyGFiuUIg
         BRfA==
X-Gm-Message-State: AGi0Pua/3ASuZz/CSIM6WxUS6oyvB4GyXR6tw6VDUcbfPwWdOQCtMCnQ
        hZHF05YA6l6PdfFklf689BE=
X-Google-Smtp-Source: APiQypKM770ZVtMYqCFPVc4/VA0PXkEJArSeNo2L9bAAer47Xaxdc8shf6cUBwP8UhXZF5knphXtVQ==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr9679450pju.169.1587538317933;
        Tue, 21 Apr 2020 23:51:57 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 62sm4501797pfu.181.2020.04.21.23.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:51:57 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:51:52 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 10/18] mm: memcontrol: switch to native NR_ANON_MAPPED
 counter
Message-ID: <20200422065151.GJ6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-11-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-11-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:18PM -0400, Johannes Weiner wrote:
> Memcg maintains a private MEMCG_RSS counter. This divergence from the
> generic VM accounting means unnecessary code overhead, and creates a
> dependency for memcg that page->mapping is set up at the time of
> charging, so that page types can be told apart.
> 
> Convert the generic accounting sites to mod_lruvec_page_state and
> friends to maintain the per-cgroup vmstat counter of
> NR_ANON_MAPPED. We use lock_page_memcg() to stabilize page->mem_cgroup
> during rmap changes, the same way we do for NR_FILE_MAPPED.
> 
> With the previous patch removing MEMCG_CACHE and the private NR_SHMEM
> counter, this patch finally eliminates the need to have page->mapping
> set up at charge time.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h |  3 +--
>  mm/memcontrol.c            | 27 ++++++++--------------
>  mm/rmap.c                  | 47 +++++++++++++++++++++++---------------
>  3 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c44aa1ccf553..bfb1d961e346 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -29,8 +29,7 @@ struct kmem_cache;
>  
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
> -	MEMCG_RSS = NR_VM_NODE_STAT_ITEMS,
> -	MEMCG_RSS_HUGE,
> +	MEMCG_RSS_HUGE = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SWAP,
>  	MEMCG_SOCK,
>  	/* XXX: why are these zone and not node counters? */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7e77166cf10b..c87178d6219f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -836,13 +836,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
>  					 struct page *page,
>  					 int nr_pages)
>  {
> -	/*
> -	 * Here, RSS means 'mapped anon' and anon's SwapCache. Shmem/tmpfs is
> -	 * counted as CACHE even if it's on ANON LRU.
> -	 */
> -	if (PageAnon(page))
> -		__mod_memcg_state(memcg, MEMCG_RSS, nr_pages);
> -
>  	if (abs(nr_pages) > 1) {
>  		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
>  		__mod_memcg_state(memcg, MEMCG_RSS_HUGE, nr_pages);
> @@ -1384,7 +1377,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	 */
>  
>  	seq_buf_printf(&s, "anon %llu\n",
> -		       (u64)memcg_page_state(memcg, MEMCG_RSS) *
> +		       (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
>  		       PAGE_SIZE);
>  	seq_buf_printf(&s, "file %llu\n",
>  		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
> @@ -3298,7 +3291,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  
>  	if (mem_cgroup_is_root(memcg)) {
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
> -			memcg_page_state(memcg, MEMCG_RSS);
> +			memcg_page_state(memcg, NR_ANON_MAPPED);
>  		if (swap)
>  			val += memcg_page_state(memcg, MEMCG_SWAP);
>  	} else {
> @@ -3768,7 +3761,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  
>  static const unsigned int memcg1_stats[] = {
>  	NR_FILE_PAGES,
> -	MEMCG_RSS,
> +	NR_ANON_MAPPED,
>  	MEMCG_RSS_HUGE,
>  	NR_SHMEM,
>  	NR_FILE_MAPPED,
> @@ -5395,7 +5388,12 @@ static int mem_cgroup_move_account(struct page *page,
>  
>  	lock_page_memcg(page);
>  
> -	if (!PageAnon(page)) {
> +	if (PageAnon(page)) {
> +		if (page_mapped(page)) {

This page_mapped() check is newly inserted. Could you elaborate more
on why mem_cgroup_charge_statistics() doesn't need this check?

> +			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
> +			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
> +		}
> +	} else {
>  		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
>  		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
>  
> @@ -6529,7 +6527,6 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
>  {
>  	unsigned int nr_pages = hpage_nr_pages(page);
>  
> -	VM_BUG_ON_PAGE(!page->mapping, page);
>  	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
>  
>  	if (mem_cgroup_disabled())
> @@ -6602,8 +6599,6 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
>  	struct mem_cgroup *memcg;
>  	int ret;
>  
> -	VM_BUG_ON_PAGE(!page->mapping, page);
> -
>  	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
>  	if (ret)
>  		return ret;
> @@ -6615,7 +6610,6 @@ struct uncharge_gather {
>  	struct mem_cgroup *memcg;
>  	unsigned long nr_pages;
>  	unsigned long pgpgout;
> -	unsigned long nr_anon;
>  	unsigned long nr_kmem;
>  	unsigned long nr_huge;
>  	struct page *dummy_page;
> @@ -6640,7 +6634,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	}
>  
>  	local_irq_save(flags);
> -	__mod_memcg_state(ug->memcg, MEMCG_RSS, -ug->nr_anon);
>  	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
>  	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
>  	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
> @@ -6682,8 +6675,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	if (!PageKmemcg(page)) {
>  		if (PageTransHuge(page))
>  			ug->nr_huge += nr_pages;
> -		if (PageAnon(page))
> -			ug->nr_anon += nr_pages;
>  		ug->pgpgout++;
>  	} else {
>  		ug->nr_kmem += nr_pages;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f79a206b271a..150513d31efa 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1114,6 +1114,11 @@ void do_page_add_anon_rmap(struct page *page,
>  	bool compound = flags & RMAP_COMPOUND;
>  	bool first;
>  
> +	if (unlikely(PageKsm(page)))
> +		lock_page_memcg(page);
> +	else
> +		VM_BUG_ON_PAGE(!PageLocked(page), page);
> +
>  	if (compound) {
>  		atomic_t *mapcount;
>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
> @@ -1134,12 +1139,13 @@ void do_page_add_anon_rmap(struct page *page,
>  		 */
>  		if (compound)
>  			__inc_node_page_state(page, NR_ANON_THPS);
> -		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
> +		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>  	}
> -	if (unlikely(PageKsm(page)))
> -		return;
>  
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	if (unlikely(PageKsm(page))) {
> +		unlock_page_memcg(page);
> +		return;
> +	}
>  
>  	/* address might be in next vma when migration races vma_adjust */
>  	if (first)
> @@ -1181,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
>  		/* increment count (starts at -1) */
>  		atomic_set(&page->_mapcount, 0);
>  	}
> -	__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
> +	__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>  	__page_set_anon_rmap(page, vma, address, 1);
>  }

memcg isn't setup yet and accounting isn't applied to proper memcg.
Maybe, it would be applied to root memcg. With this change, we don't
need the mapping to commit the charge so switching the order of
page_add_new_anon_rmap() and mem_cgroup_commit_charge() will solve the
issue.

Thanks.
