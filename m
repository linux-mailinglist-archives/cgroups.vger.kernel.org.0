Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F5296A69
	for <lists+cgroups@lfdr.de>; Fri, 23 Oct 2020 09:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374461AbgJWHmQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Oct 2020 03:42:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374460AbgJWHmQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Oct 2020 03:42:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603438934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCVcXJgtnbl5xb/5N2lzG24wq0yxvkQDQbOQxlLLxpQ=;
        b=rOH447hh4FY+XSJSdXj2KLMddyoXyyI0coBmjHTAKTAdQ0xgipqYuH0kTlgMSZhafzmOTF
        xW/RK/WU3YlW2KOxjWVzvvy0tzi5R+C+4ZCo+g8dp5Ve/0NGWOAnC0sW1j2yEy4hOmJJIo
        5fb6CvzXFagvuPXphyJ9u7dZQpO6Pg8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCE89AE7D;
        Fri, 23 Oct 2020 07:42:14 +0000 (UTC)
Date:   Fri, 23 Oct 2020 09:42:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Message-ID: <20201023074213.GR23790@dhcp22.suse.cz>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 22-10-20 11:18:44, Johannes Weiner wrote:
> As huge page usage in the page cache and for shmem files proliferates
> in our production environment, the performance monitoring team has
> asked for per-cgroup stats on those pages.
> 
> We already track and export anon_thp per cgroup. We already track file
> THP and shmem THP per node, so making them per-cgroup is only a matter
> of switching from node to lruvec counters. All callsites are in places
> where the pages are charged and locked, so page->memcg is stable.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/filemap.c     | 4 ++--
>  mm/huge_memory.c | 4 ++--
>  mm/khugepaged.c  | 4 ++--
>  mm/memcontrol.c  | 6 +++++-
>  mm/shmem.c       | 2 +-
>  5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e80aa9d2db68..334ce608735c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -204,9 +204,9 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>  	if (PageSwapBacked(page)) {
>  		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
>  		if (PageTransHuge(page))
> -			__dec_node_page_state(page, NR_SHMEM_THPS);
> +			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
>  	} else if (PageTransHuge(page)) {
> -		__dec_node_page_state(page, NR_FILE_THPS);
> +		__dec_lruvec_page_state(page, NR_FILE_THPS);
>  		filemap_nr_thps_dec(mapping);
>  	}
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cba3812a5c3e..5fe044e5dad5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2707,9 +2707,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		spin_unlock(&ds_queue->split_queue_lock);
>  		if (mapping) {
>  			if (PageSwapBacked(head))
> -				__dec_node_page_state(head, NR_SHMEM_THPS);
> +				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
>  			else
> -				__dec_node_page_state(head, NR_FILE_THPS);
> +				__dec_lruvec_page_state(head, NR_FILE_THPS);
>  		}
>  
>  		__split_huge_page(page, list, end, flags);
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f1d5f6dde47c..04828e21f434 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1833,9 +1833,9 @@ static void collapse_file(struct mm_struct *mm,
>  	}
>  
>  	if (is_shmem)
> -		__inc_node_page_state(new_page, NR_SHMEM_THPS);
> +		__inc_lruvec_page_state(new_page, NR_SHMEM_THPS);
>  	else {
> -		__inc_node_page_state(new_page, NR_FILE_THPS);
> +		__inc_lruvec_page_state(new_page, NR_FILE_THPS);
>  		filemap_nr_thps_inc(mapping);
>  	}
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2636f8bad908..98177d5e8e03 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1507,6 +1507,8 @@ static struct memory_stat memory_stats[] = {
>  	 * constant(e.g. powerpc).
>  	 */
>  	{ "anon_thp", 0, NR_ANON_THPS },
> +	{ "file_thp", 0, NR_FILE_THPS },
> +	{ "shmem_thp", 0, NR_SHMEM_THPS },
>  #endif
>  	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
>  	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> @@ -1537,7 +1539,9 @@ static int __init memory_stats_init(void)
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		if (memory_stats[i].idx == NR_ANON_THPS)
> +		if (memory_stats[i].idx == NR_ANON_THPS ||
> +		    memory_stats[i].idx == NR_FILE_THPS ||
> +		    memory_stats[i].idx == NR_SHMEM_THPS)
>  			memory_stats[i].ratio = HPAGE_PMD_SIZE;
>  #endif
>  		VM_BUG_ON(!memory_stats[i].ratio);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..5009d783d954 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -713,7 +713,7 @@ static int shmem_add_to_page_cache(struct page *page,
>  		}
>  		if (PageTransHuge(page)) {
>  			count_vm_event(THP_FILE_ALLOC);
> -			__inc_node_page_state(page, NR_SHMEM_THPS);
> +			__inc_lruvec_page_state(page, NR_SHMEM_THPS);
>  		}
>  		mapping->nrpages += nr;
>  		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
> -- 
> 2.29.0

-- 
Michal Hocko
SUSE Labs
