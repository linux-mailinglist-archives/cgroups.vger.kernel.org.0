Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059731CEDFE
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgELH0j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 03:26:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgELH0j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 May 2020 03:26:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id h4so20542389wmb.4
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 00:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFlAfneoEdxMk+THzb55w1AkHwlGtgVk2mA+FNXaRow=;
        b=FJcQjzxd3rDVRPvmjeCmhvtpBovzwCNM3QKgJWKvuMV1TShikskiHm+TltazLXZehd
         XGadZOEKJ2Z8us1JFjuNuRpMLuq0s2YOY+bCVSG+zngCgwexjjeaPxFK+RRJvyNLeEtm
         lTGtWTmmMYNSGImMzn0lrwHi0J0ldAxUaTF2Bjclzaiw0XBHu+gaOo/0bbW4L9chMm2/
         rEB5yqaiYAopiZpPTsgegS0istRnQLzDrD9XjdrW+EdECC0N67o3KrAXxUROVGtvGzwP
         R0cufJCK+F+S2/lrtJaab857rR6Ufu7fvHZOgD7PpPG6xuC4lERKSgJNEBSC8ouuuwVN
         ZjsQ==
X-Gm-Message-State: AGi0Pua6ov9UG3PfZrkrP9R0uDp9CikT+2zKzA/aqgqz5kM3y0WYO+rn
        DbwwAx06CvFXG674zphPoRDs5B+o
X-Google-Smtp-Source: APiQypJ6UoT0g6vL8NtypNS/GZt2XcY9k9HGNyZWP6T8B3IPpK0BvRqCR/2dLYdDClvEJfczOb7nFA==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr13837995wme.48.1589268397112;
        Tue, 12 May 2020 00:26:37 -0700 (PDT)
Received: from localhost (ip-37-188-140-86.eurotel.cz. [37.188.140.86])
        by smtp.gmail.com with ESMTPSA id b2sm18094701wrm.30.2020.05.12.00.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 00:26:35 -0700 (PDT)
Date:   Tue, 12 May 2020 09:26:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200512072634.GP29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511225516.2431921-4-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:
> Add a memory.swap.high knob, which can be used to protect the system
> from SWAP exhaustion. The mechanism used for penelizing is similar
> to memory.high penalty (sleep on return to user space), but with
> a less steep slope.
> 
> That is not to say that the knob itself is equivalent to memory.high.
> The objective is more to protect the system from potentially buggy
> tasks consuming a lot of swap and impacting other tasks, or even
> bringing the whole system to stand still with complete SWAP
> exhaustion. Hopefully without the need to find per-task hard
> limits.
> 
> Slowing misbehaving tasks down gradually allows user space oom
> killers or other protection mechanisms to react. oomd and earlyoom
> already do killing based on swap exhaustion, and memory.swap.high
> protection will help implement such userspace oom policies more
> reliably.

Thanks for adding more information about the usecase and motivation.
> 
> Use one counter for number of pages allocated under pressure
> to save struct task space and avoid two separate hierarchy
> walks on the hot path.
> 
> Use swap.high when deciding if swap is full.

Please be more specific why.

> Perform reclaim and count memory over high events.

Please expand on this and explain how this is working and why the
semantic is subtly different from MEMCG_HIGH. I suspect the reason
is that there is no reclaim for the swap so you are only emitting an
event on the memcg which is actually throttled. This is in line with
memory.high but the difference is that we do reclaim each memcg subtree
in the high limit excess. That means that the counter tells us how many
times the specific memcg was in excess which would be impossible with
your implementation.

I would also suggest to explain or ideally even separate the swap
penalty scaling logic to a seprate patch. What kind of data it is based
on?
 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> v2:
>  - add docs,
>  - improve commit message.
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 16 +++++
>  include/linux/memcontrol.h              |  4 ++
>  mm/memcontrol.c                         | 94 +++++++++++++++++++++++--
>  3 files changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5f12f203822e..c60226daa193 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1374,6 +1374,22 @@ PAGE_SIZE multiple when read back.
>  	The total amount of swap currently being used by the cgroup
>  	and its descendants.
>  
> +  memory.swap.high
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "max".
> +
> +	Swap usage throttle limit.  If a cgroup's swap usage exceeds
> +	this limit, all its further allocations will be throttled to
> +	allow userspace to implement custom out-of-memory procedures.
> +
> +	This limit marks a point of no return for the cgroup. It is NOT
> +	designed to manage the amount of swapping a workload does
> +	during regular operation. Compare to memory.swap.max, which
> +	prohibits swapping past a set amount, but lets the cgroup
> +	continue unimpeded as long as other memory can be reclaimed.
> +
> +	Healthy workloads are not expected to reach this limit.
> +
>    memory.swap.max
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "max".
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b478a4e83297..882bda952a5c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -45,6 +45,7 @@ enum memcg_memory_event {
>  	MEMCG_MAX,
>  	MEMCG_OOM,
>  	MEMCG_OOM_KILL,
> +	MEMCG_SWAP_HIGH,
>  	MEMCG_SWAP_MAX,
>  	MEMCG_SWAP_FAIL,
>  	MEMCG_NR_MEMORY_EVENTS,
> @@ -212,6 +213,9 @@ struct mem_cgroup {
>  	/* Upper bound of normal memory consumption range */
>  	unsigned long high;
>  
> +	/* Upper bound of swap consumption range */
> +	unsigned long swap_high;
> +
>  	/* Range enforcement for interrupt charges */
>  	struct work_struct high_work;
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 66dd87bb9e0f..a3d13b30e3d6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2353,12 +2353,34 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
>  	return max_overage;
>  }
>  
> +static u64 swap_find_max_overage(struct mem_cgroup *memcg)
> +{
> +	u64 overage, max_overage = 0;
> +	struct mem_cgroup *max_cg;
> +
> +	do {
> +		overage = calculate_overage(page_counter_read(&memcg->swap),
> +					    READ_ONCE(memcg->swap_high));
> +		if (overage > max_overage) {
> +			max_overage = overage;
> +			max_cg = memcg;
> +		}
> +	} while ((memcg = parent_mem_cgroup(memcg)) &&
> +		 !mem_cgroup_is_root(memcg));
> +
> +	if (max_overage)
> +		memcg_memory_event(max_cg, MEMCG_SWAP_HIGH);
> +
> +	return max_overage;
> +}
> +
>  /*
>   * Get the number of jiffies that we should penalise a mischievous cgroup which
>   * is exceeding its memory.high by checking both it and its ancestors.
>   */
>  static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
>  					  unsigned int nr_pages,
> +					  unsigned char cost_shift,
>  					  u64 max_overage)
>  {
>  	unsigned long penalty_jiffies;
> @@ -2366,6 +2388,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
>  	if (!max_overage)
>  		return 0;
>  
> +	if (cost_shift)
> +		max_overage >>= cost_shift;
> +
>  	/*
>  	 * We use overage compared to memory.high to calculate the number of
>  	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
> @@ -2411,9 +2436,16 @@ void mem_cgroup_handle_over_high(void)
>  	 * memory.high is breached and reclaim is unable to keep up. Throttle
>  	 * allocators proactively to slow down excessive growth.
>  	 */
> -	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
> +	penalty_jiffies = calculate_high_delay(memcg, nr_pages, 0,
>  					       mem_find_max_overage(memcg));
>  
> +	/*
> +	 * Make the swap curve more gradual, swap can be considered "cheaper",
> +	 * and is allocated in larger chunks. We want the delays to be gradual.
> +	 */
> +	penalty_jiffies += calculate_high_delay(memcg, nr_pages, 2,
> +						swap_find_max_overage(memcg));
> +
>  	/*
>  	 * Clamp the max delay per usermode return so as to still keep the
>  	 * application moving forwards and also permit diagnostics, albeit
> @@ -2604,12 +2636,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * reclaim, the cost of mismatch is negligible.
>  	 */
>  	do {
> -		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
> -			/* Don't bother a random interrupted task */
> -			if (in_interrupt()) {
> +		bool mem_high, swap_high;
> +
> +		mem_high = page_counter_read(&memcg->memory) >
> +			READ_ONCE(memcg->high);
> +		swap_high = page_counter_read(&memcg->swap) >
> +			READ_ONCE(memcg->swap_high);
> +
> +		/* Don't bother a random interrupted task */
> +		if (in_interrupt()) {
> +			if (mem_high) {
>  				schedule_work(&memcg->high_work);
>  				break;
>  			}
> +			continue;
> +		}
> +
> +		if (mem_high || swap_high) {
>  			current->memcg_nr_pages_over_high += batch;
>  			set_notify_resume(current);
>  			break;
> @@ -5076,6 +5119,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  
>  	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
> @@ -5229,6 +5273,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
>  	memcg_wb_domain_size_changed(memcg);
>  }
>  
> @@ -7136,10 +7181,13 @@ bool mem_cgroup_swap_full(struct page *page)
>  	if (!memcg)
>  		return false;
>  
> -	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
> -		if (page_counter_read(&memcg->swap) * 2 >=
> -		    READ_ONCE(memcg->swap.max))
> +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +		unsigned long usage = page_counter_read(&memcg->swap);
> +
> +		if (usage * 2 >= READ_ONCE(memcg->swap_high) ||
> +		    usage * 2 >= READ_ONCE(memcg->swap.max))
>  			return true;
> +	}
>  
>  	return false;
>  }
> @@ -7169,6 +7217,30 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
>  	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
>  }
>  
> +static int swap_high_show(struct seq_file *m, void *v)
> +{
> +	unsigned long high = READ_ONCE(mem_cgroup_from_seq(m)->swap_high);
> +
> +	return seq_puts_memcg_tunable(m, high);
> +}
> +
> +static ssize_t swap_high_write(struct kernfs_open_file *of,
> +			       char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned long high;
> +	int err;
> +
> +	buf = strstrip(buf);
> +	err = page_counter_memparse(buf, "max", &high);
> +	if (err)
> +		return err;
> +
> +	WRITE_ONCE(memcg->swap_high, high);
> +
> +	return nbytes;
> +}
> +
>  static int swap_max_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -7196,6 +7268,8 @@ static int swap_events_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> +	seq_printf(m, "high %lu\n",
> +		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
>  	seq_printf(m, "max %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
>  	seq_printf(m, "fail %lu\n",
> @@ -7210,6 +7284,12 @@ static struct cftype swap_files[] = {
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  		.read_u64 = swap_current_read,
>  	},
> +	{
> +		.name = "swap.high",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = swap_high_show,
> +		.write = swap_high_write,
> +	},
>  	{
>  		.name = "swap.max",
>  		.flags = CFTYPE_NOT_ON_ROOT,
> -- 
> 2.25.4

-- 
Michal Hocko
SUSE Labs
