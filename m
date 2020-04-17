Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118B51AD789
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgDQHhc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 03:37:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44494 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgDQHha (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 03:37:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so1841666wrg.11
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 00:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lT0iwe0OCQqwtwQLImwkGBhnO4D55FNI9uUX8Skkpq4=;
        b=ZclTxJijEwDpskPyxNCb0rj7mAAszHOh4tc/Af0xFWkDZoUS8aXRlaemr7NOljbmWY
         JRQhX/4dWDbVduQqIZ01o8xkbT/jd4EkAuDsYR4ixhow2L+Rjh+E3fqkw/jXr4chKs1Y
         xjSZWEDiegKc86nHY4p6uF9RjdsOi7eeyUylFPqflGURsVsitBRCuIUpldVd3X8NAVfc
         uKkJ2oqpwfm/fbSj30JRgJlzESnv/RpAlLJzAmvoc/nUUEvXwZbsvY0z7CrrQvhJox34
         s8+aXPO+NoTmo5ex7wafM2GLnnBgIOC0yUN/JePE5UfvVDxLwB7sisPf7bcTPdoZILcS
         zTng==
X-Gm-Message-State: AGi0PuaOJU9gV79W26o5Y/ruH8DPndEFnRUF/jMTmIaBCbyo2ImmmGyS
        QGUwnXdwp3ys1XfDKmHizBUS+Ngu
X-Google-Smtp-Source: APiQypIp64LPHNDdkGLXVtLigJ7ZTwPtsRt0sNsXcTxtBqhtxBGt+5CFdfbE2RXM9+4tgcaMPSsdkA==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr2329896wrq.234.1587109047046;
        Fri, 17 Apr 2020 00:37:27 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id c83sm7205171wmd.23.2020.04.17.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:37:26 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:37:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: automatically penalize tasks with high swap use
Message-ID: <20200417073716.GG26707@dhcp22.suse.cz>
References: <20200417010617.927266-1-kuba@kernel.org>
 <20200417010617.927266-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417010617.927266-4-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 16-04-20 18:06:17, Jakub Kicinski wrote:
> Add a memory.swap.high knob, which functions in a similar way
> to memory.high, but with a less steep slope.

This really begs for more details. What does "similar way to
memory.high" mean? Because my first thought would be that the swap usage
will be throttled and kept at the swap.high level. From a quick look at
the patch you only do throttling. There is no swap space reclaim to keep
the usage at the level. So unless I am missing something this is very
confusing and it doesn't really fit into high limit semantic.

This changelog also doesn't describe any usecase.

> Use one counter for number of pages allocated under pressure
> to save struct task space and avoid two separate hierarchy
> walks on the hot path.
> 
> Use swap.high when deciding if swap is full.
> Perform reclaim and count memory over high events.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> change log including private exchanges with Johannes:
> 
> v0.4:
>  - count the events only for the highest offender
>  - don't schedule_work for swap
>  - take high into account in mem_cgroup_swap_full()
> v0.3:
>  - rebase
>  - use one nr_pages
>  - s/overage_shf/cost_shift/
> v0.2:
>  - move to counting overage in try_charge()
>  - add comment about slope being more gradual
> ---
>  include/linux/memcontrol.h |  4 ++
>  mm/memcontrol.c            | 94 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 91 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d630af1a4e17..b52f7dcddfa1 100644
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
> @@ -218,6 +219,9 @@ struct mem_cgroup {
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
> index 90266c04fd76..7d0895c0d903 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2351,12 +2351,34 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
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
> @@ -2364,6 +2386,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
>  	if (!max_overage)
>  		return 0;
>  
> +	if (cost_shift)
> +		max_overage >>= cost_shift;
> +
>  	/*
>  	 * We use overage compared to memory.high to calculate the number of
>  	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
> @@ -2409,9 +2434,16 @@ void mem_cgroup_handle_over_high(void)
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
> @@ -2602,12 +2634,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
> @@ -5071,6 +5114,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  
>  	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
> @@ -5224,6 +5268,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	page_counter_set_low(&memcg->memory, 0);
>  	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
>  	memcg_wb_domain_size_changed(memcg);
>  }
>  
> @@ -7137,10 +7182,13 @@ bool mem_cgroup_swap_full(struct page *page)
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
> @@ -7170,6 +7218,30 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
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
> @@ -7197,6 +7269,8 @@ static int swap_events_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> +	seq_printf(m, "high %lu\n",
> +		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
>  	seq_printf(m, "max %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
>  	seq_printf(m, "fail %lu\n",
> @@ -7211,6 +7285,12 @@ static struct cftype swap_files[] = {
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
> 2.25.2

-- 
Michal Hocko
SUSE Labs
