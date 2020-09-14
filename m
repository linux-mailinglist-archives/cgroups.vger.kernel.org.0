Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094EE268A5F
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgINLvG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 07:51:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:58736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgINLs1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 07:48:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11374AC19;
        Mon, 14 Sep 2020 11:48:41 +0000 (UTC)
Date:   Mon, 14 Sep 2020 13:48:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Message-ID: <20200914114825.GM16999@dhcp22.suse.cz>
References: <20200914024452.19167-1-longman@redhat.com>
 <20200914024452.19167-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914024452.19167-3-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 13-09-20 22:44:51, Waiman Long wrote:
> The mem_cgroup_get_max() function used to get memory+swap max from
> both the v1 memsw and v2 memory+swap page counters & return the maximum
> of these 2 values. This is redundant and it is more efficient to just
> get either the v1 or the v2 values depending on which one is currently
> in use.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c74f1200261..ca36bed588d1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1633,17 +1633,15 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>   */
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  {
> -	unsigned long max;
> -
> -	max = READ_ONCE(memcg->memory.max);
> -	if (mem_cgroup_swappiness(memcg)) {
> -		unsigned long memsw_max;
> -		unsigned long swap_max;
> -
> -		memsw_max = memcg->memsw.max;
> -		swap_max = READ_ONCE(memcg->swap.max);
> -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
> -		max = min(max + swap_max, memsw_max);
> +	unsigned long max = READ_ONCE(memcg->memory.max);
> +
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> +		if (mem_cgroup_swappiness(memcg))
> +			max += min(READ_ONCE(memcg->swap.max),
> +				   (unsigned long)total_swap_pages);
> +	} else { /* v1 */
> +		if (mem_cgroup_swappiness(memcg))
> +			max = memcg->memsw.max;

I agree that making v1 vs. v2 distinction here makes the code more
obvious. But I do not think your code is correct for v1. In a default
state it would lead to max = PAGE_COUNTER_MAX which is not something
we want, right?

instead you want
		max += min(READ_ONCE(memcg->memsw.max), total_swap_pages);



>  	}
>  	return max;
>  }
> -- 
> 2.18.1
> 

-- 
Michal Hocko
SUSE Labs
