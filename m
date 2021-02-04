Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1B30F3E3
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhBDN3u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 08:29:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:48532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236274AbhBDN3l (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Feb 2021 08:29:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612445333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRSYMjQRAzEHtFevMwBdexoUuf46f9eJ8r1i3WMioDI=;
        b=GcyhMd8vU7FiMUrjfpReK3jejf2JcNNuC/9fOqe8iI3GUHpmlS3W1NeI89vJMlKOm5Jq6S
        fDZJH9tjinKCe3lpv0vatkQWG57RzHKmtJxoGv6c+0wPresT11A9qR5KACB3Al8NZ421tf
        /rv2Z0u8UcaKLgD2rl/LNbc/H8TKIKE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 480C9ACB0;
        Thu,  4 Feb 2021 13:28:53 +0000 (UTC)
Date:   Thu, 4 Feb 2021 14:28:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <YBv2lAkaxcPD22dd@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-2-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 02-02-21 13:47:40, Johannes Weiner wrote:
> The memcg hotunplug callback erroneously flushes counts on the local
> CPU, not the counts of the CPU going away; those counts will be lost.
> 
> Flush the CPU that is actually going away.
> 
> Also simplify the code a bit by using mod_memcg_state() and
> count_memcg_events() instead of open-coding the upward flush - this is
> comparable to how vmstat.c handles hotunplug flushing.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Shakeel has already pointed out Fixes.

> ---
>  mm/memcontrol.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ed5cc78a8dbf..8120d565dd79 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2411,45 +2411,52 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  {
>  	struct memcg_stock_pcp *stock;
> -	struct mem_cgroup *memcg, *mi;
> +	struct mem_cgroup *memcg;
>  
>  	stock = &per_cpu(memcg_stock, cpu);
>  	drain_stock(stock);
>  
>  	for_each_mem_cgroup(memcg) {
> +		struct memcg_vmstats_percpu *statc;
>  		int i;
>  
> +		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> +
>  		for (i = 0; i < MEMCG_NR_STAT; i++) {
>  			int nid;
> -			long x;
>  
> -			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
> -			if (x)
> -				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -					atomic_long_add(x, &memcg->vmstats[i]);
> +			if (statc->stat[i]) {
> +				mod_memcg_state(memcg, i, statc->stat[i]);
> +				statc->stat[i] = 0;
> +			}
>  
>  			if (i >= NR_VM_NODE_STAT_ITEMS)
>  				continue;
>  
>  			for_each_node(nid) {
> +				struct batched_lruvec_stat *lstatc;
>  				struct mem_cgroup_per_node *pn;
> +				long x;
>  
>  				pn = mem_cgroup_nodeinfo(memcg, nid);
> -				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
> -				if (x)
> +				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
> +
> +				x = lstatc->count[i];
> +				lstatc->count[i] = 0;
> +
> +				if (x) {
>  					do {
>  						atomic_long_add(x, &pn->lruvec_stat[i]);
>  					} while ((pn = parent_nodeinfo(pn, nid)));
> +				}
>  			}
>  		}
>  
>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> -			long x;
> -
> -			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
> -			if (x)
> -				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -					atomic_long_add(x, &memcg->vmevents[i]);
> +			if (statc->events[i]) {
> +				count_memcg_events(memcg, i, statc->events[i]);
> +				statc->events[i] = 0;
> +			}
>  		}
>  	}
>  
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs
