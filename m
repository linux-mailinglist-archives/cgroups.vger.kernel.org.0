Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7878F233187
	for <lists+cgroups@lfdr.de>; Thu, 30 Jul 2020 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgG3MBg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jul 2020 08:01:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgG3MAp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 114D2AE70;
        Thu, 30 Jul 2020 12:00:56 +0000 (UTC)
Date:   Thu, 30 Jul 2020 14:00:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: don't count limit-setting reclaim as
 memory pressure
Message-ID: <20200730120043.GI18727@dhcp22.suse.cz>
References: <20200728135210.379885-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-2-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-07-20 09:52:10, Johannes Weiner wrote:
> When an outside process lowers one of the memory limits of a cgroup
> (or uses the force_empty knob in cgroup1), direct reclaim is performed
> in the context of the write(), in order to directly enforce the new
> limit and have it being met by the time the write() returns.
> 
> Currently, this reclaim activity is accounted as memory pressure in
> the cgroup that the writer(!) belongs to. This is unexpected. It
> specifically causes problems for senpai
> (https://github.com/facebookincubator/senpai), which is an agent that
> routinely adjusts the memory limits and performs associated reclaim
> work in tens or even hundreds of cgroups running on the host. The
> cgroup that senpai is running in itself will report elevated levels of
> memory pressure, even though it itself is under no memory shortage or
> any sort of distress.
> 
> Move the psi annotation from the central cgroup reclaim function to
> callsites in the allocation context, and thereby no longer count any
> limit-setting reclaim as memory pressure. If the newly set limit
> causes the workload inside the cgroup into direct reclaim, that of
> course will continue to count as memory pressure.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 12 +++++++++++-
>  mm/vmscan.c     |  6 ------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 805a44bf948c..8377640ad494 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2233,11 +2233,18 @@ static void reclaim_high(struct mem_cgroup *memcg,
>  			 gfp_t gfp_mask)
>  {
>  	do {
> +		unsigned long pflags;
> +
>  		if (page_counter_read(&memcg->memory) <=
>  		    READ_ONCE(memcg->memory.high))
>  			continue;
> +
>  		memcg_memory_event(memcg, MEMCG_HIGH);
> +
> +		psi_memstall_enter(&pflags);
>  		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
> +		psi_memstall_leave(&pflags);
> +
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
>  }
> @@ -2451,10 +2458,11 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
> +	enum oom_status oom_status;
>  	unsigned long nr_reclaimed;
>  	bool may_swap = true;
>  	bool drained = false;
> -	enum oom_status oom_status;
> +	unsigned long pflags;
>  
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
> @@ -2514,8 +2522,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	memcg_memory_event(mem_over_limit, MEMCG_MAX);
>  
> +	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
>  						    gfp_mask, may_swap);
> +	psi_memstall_leave(&pflags);
>  
>  	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>  		goto retry;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749d239c62b2..742538543c79 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3318,7 +3318,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   bool may_swap)
>  {
>  	unsigned long nr_reclaimed;
> -	unsigned long pflags;
>  	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> @@ -3339,17 +3338,12 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>  
>  	set_task_reclaim_state(current, &sc.reclaim_state);
> -
>  	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
> -
> -	psi_memstall_enter(&pflags);
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
> -	psi_memstall_leave(&pflags);
> -
>  	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
>  	set_task_reclaim_state(current, NULL);
>  
> -- 
> 2.27.0
> 

-- 
Michal Hocko
SUSE Labs
