Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15E3B7DC4
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF3HAu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 03:00:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45088 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhF3HAt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 03:00:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 24D452250B;
        Wed, 30 Jun 2021 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625036300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UrvclaE0RBGDdqhzkHfO18FcjM9iOBKXol1swEPnP9E=;
        b=AKfP3CaF18wM2DTp5N77uqCluqABTG8w/UHZfRQcQAU/jEwWuIKXBm08RUR+4YvZcgPsqC
        b0oalB7f1ma6qNiCxbmxVn0voljzLRxP1ouSaZUVtIqpXOqy9ZVicVOevbzOTDFxf9okLx
        pmdo77snluXd3+Lgk4fgGp3t/8E+yI0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 848C1A3B8E;
        Wed, 30 Jun 2021 06:58:19 +0000 (UTC)
Date:   Wed, 30 Jun 2021 08:58:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 05/18] mm/memcg: Convert memcg_check_events to take a
 node ID
Message-ID: <YNwWC8Nb3QfhMOTs@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-6-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:21, Matthew Wilcox wrote:
> memcg_check_events only uses the page's nid, so call page_to_nid in the
> callers to make the folio conversion easier.

It will also make the interface slightly easier to follow as there
shouldn't be any real reason to take the page for these events.
So this is a good cleanup in general.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.
> ---
>  mm/memcontrol.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 29fdb70dca42..5d143d46a8a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -846,7 +846,7 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>   * Check events in order.
>   *
>   */
> -static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
> +static void memcg_check_events(struct mem_cgroup *memcg, int nid)
>  {
>  	/* threshold event is triggered in finer grain than soft limit */
>  	if (unlikely(mem_cgroup_event_ratelimit(memcg,
> @@ -857,7 +857,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
>  						MEM_CGROUP_TARGET_SOFTLIMIT);
>  		mem_cgroup_threshold(memcg);
>  		if (unlikely(do_softlimit))
> -			mem_cgroup_update_tree(memcg, page_to_nid(page));
> +			mem_cgroup_update_tree(memcg, nid);
>  	}
>  }
>  
> @@ -5573,7 +5573,7 @@ static int mem_cgroup_move_account(struct page *page,
>  	struct lruvec *from_vec, *to_vec;
>  	struct pglist_data *pgdat;
>  	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
> -	int ret;
> +	int nid, ret;
>  
>  	VM_BUG_ON(from == to);
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
> @@ -5662,12 +5662,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	__unlock_page_memcg(from);
>  
>  	ret = 0;
> +	nid = page_to_nid(page);
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(to, nr_pages);
> -	memcg_check_events(to, page);
> +	memcg_check_events(to, nid);
>  	mem_cgroup_charge_statistics(from, -nr_pages);
> -	memcg_check_events(from, page);
> +	memcg_check_events(from, nid);
>  	local_irq_enable();
>  out_unlock:
>  	unlock_page(page);
> @@ -6688,7 +6689,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
>  
>  	local_irq_disable();
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, page);
> +	memcg_check_events(memcg, page_to_nid(page));
>  	local_irq_enable();
>  out:
>  	return ret;
> @@ -6796,7 +6797,7 @@ struct uncharge_gather {
>  	unsigned long nr_memory;
>  	unsigned long pgpgout;
>  	unsigned long nr_kmem;
> -	struct page *dummy_page;
> +	int nid;
>  };
>  
>  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> @@ -6820,7 +6821,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	local_irq_save(flags);
>  	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
>  	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
> -	memcg_check_events(ug->memcg, ug->dummy_page);
> +	memcg_check_events(ug->memcg, ug->nid);
>  	local_irq_restore(flags);
>  
>  	/* drop reference from uncharge_page */
> @@ -6861,7 +6862,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  			uncharge_gather_clear(ug);
>  		}
>  		ug->memcg = memcg;
> -		ug->dummy_page = page;
> +		ug->nid = page_to_nid(page);
>  
>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&memcg->css);
> @@ -6979,7 +6980,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  
>  	local_irq_save(flags);
>  	mem_cgroup_charge_statistics(memcg, nr_pages);
> -	memcg_check_events(memcg, newpage);
> +	memcg_check_events(memcg, page_to_nid(newpage));
>  	local_irq_restore(flags);
>  }
>  
> @@ -7209,7 +7210,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	 */
>  	VM_BUG_ON(!irqs_disabled());
>  	mem_cgroup_charge_statistics(memcg, -nr_entries);
> -	memcg_check_events(memcg, page);
> +	memcg_check_events(memcg, page_to_nid(page));
>  
>  	css_put(&memcg->css);
>  }
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
