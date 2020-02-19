Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB1164DC0
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSShg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 13:37:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36021 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSShg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 13:37:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1802454wma.1;
        Wed, 19 Feb 2020 10:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9fEWLo0nNwXjNwDwLYztFQpM4TMlyLT7ksb0PU5d00=;
        b=Dy8qc0ltj4gkyR4PA27fqN9rR6UNluSEgGdVhJg98jfFjtQs0cuse4ho3cMv8/dj26
         eZxMZX4Tse8LMKEBLJ7SGQH0NkYaLxpT00y1R8Rnv7SljQK29w25hKPjcDboqcnUE2xw
         SIDET+nXGCxah3MkxhdZcGdbdGxqaLXfvZadZKLAY91kbBX+INpNDxU/xaQe+EIYdbBN
         nm+CIn1kJqr5JWRXO5NuxrBkd3MPoQbHXj2aiTAE4tn8EVwlavWVa+UIY5SkdPP11QCY
         CaGLv4u3ESmrXpg/ppFAWfvA4yxv6Dwk5nnz99q/MrXef4os9FswA/iHLKQHNXEq6KeP
         FSuA==
X-Gm-Message-State: APjAAAU3ZFo0VQBNr3MFppfzTXfT8JV+1hpiBsTH2VyNPuP1OlCFLXIn
        K00qCjW20MCpO/E9yC4GOO8=
X-Google-Smtp-Source: APXvYqw3cwz8bAE9+6mXnfb3+gIml84qnTHc3uCVu6YkcDXmZ3ZIzezOYC34Fih/QURLCvWhhX/iTA==
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr11547523wmf.100.1582137453771;
        Wed, 19 Feb 2020 10:37:33 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id r1sm768293wrx.11.2020.02.19.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:37:33 -0800 (PST)
Date:   Wed, 19 Feb 2020 19:37:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219183731.GC11847@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219181219.54356-1-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> We have received regression reports from users whose workloads moved
> into containers and subsequently encountered new latencies. For some
> users these were a nuisance, but for some it meant missing their SLA
> response times. We tracked those delays down to cgroup limits, which
> inject direct reclaim stalls into the workload where previously all
> reclaim was handled my kswapd.

I am curious why is this unexpected when the high limit is explicitly
documented as a throttling mechanism.

> This patch adds asynchronous reclaim to the memory.high cgroup limit
> while keeping direct reclaim as a fallback. In our testing, this
> eliminated all direct reclaim from the affected workload.

Who is accounted for all the work? Unless I am missing something this
just gets hidden in the system activity and that might hurt the
isolation. I do see how moving the work to a different context is
desirable but this work has to be accounted properly when it is going to
become a normal mode of operation (rather than a rare exception like the
existing irq context handling).

> memory.high has a grace buffer of about 4% between when it becomes
> exceeded and when allocating threads get throttled. We can use the
> same buffer for the async reclaimer to operate in. If the worker
> cannot keep up and the grace buffer is exceeded, allocating threads
> will fall back to direct reclaim before getting throttled.
> 
> For irq-context, there's already async memory.high enforcement. Re-use
> that work item for all allocating contexts, but switch it to the
> unbound workqueue so reclaim work doesn't compete with the workload.
> The work item is per cgroup, which means the workqueue infrastructure
> will create at maximum one worker thread per reclaiming cgroup.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
>  mm/vmscan.c     | 10 +++++++--
>  2 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cf02e3ef3ed9..bad838d9c2bb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1446,6 +1446,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	seq_buf_printf(&s, "pgsteal %lu\n",
>  		       memcg_events(memcg, PGSTEAL_KSWAPD) +
>  		       memcg_events(memcg, PGSTEAL_DIRECT));
> +	seq_buf_printf(&s, "pgscan_direct %lu\n",
> +		       memcg_events(memcg, PGSCAN_DIRECT));
> +	seq_buf_printf(&s, "pgsteal_direct %lu\n",
> +		       memcg_events(memcg, PGSTEAL_DIRECT));
>  	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
>  		       memcg_events(memcg, PGACTIVATE));
>  	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> @@ -2235,10 +2239,19 @@ static void reclaim_high(struct mem_cgroup *memcg,
>  
>  static void high_work_func(struct work_struct *work)
>  {
> +	unsigned long high, usage;
>  	struct mem_cgroup *memcg;
>  
>  	memcg = container_of(work, struct mem_cgroup, high_work);
> -	reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
> +
> +	high = READ_ONCE(memcg->high);
> +	usage = page_counter_read(&memcg->memory);
> +
> +	if (usage <= high)
> +		return;
> +
> +	set_worker_desc("cswapd/%llx", cgroup_id(memcg->css.cgroup));
> +	reclaim_high(memcg, usage - high, GFP_KERNEL);
>  }
>  
>  /*
> @@ -2304,15 +2317,22 @@ void mem_cgroup_handle_over_high(void)
>  	unsigned long pflags;
>  	unsigned long penalty_jiffies, overage;
>  	unsigned int nr_pages = current->memcg_nr_pages_over_high;
> +	bool tried_direct_reclaim = false;
>  	struct mem_cgroup *memcg;
>  
>  	if (likely(!nr_pages))
>  		return;
>  
> -	memcg = get_mem_cgroup_from_mm(current->mm);
> -	reclaim_high(memcg, nr_pages, GFP_KERNEL);
>  	current->memcg_nr_pages_over_high = 0;
>  
> +	memcg = get_mem_cgroup_from_mm(current->mm);
> +	high = READ_ONCE(memcg->high);
> +recheck:
> +	usage = page_counter_read(&memcg->memory);
> +
> +	if (usage <= high)
> +		goto out;
> +
>  	/*
>  	 * memory.high is breached and reclaim is unable to keep up. Throttle
>  	 * allocators proactively to slow down excessive growth.
> @@ -2325,12 +2345,6 @@ void mem_cgroup_handle_over_high(void)
>  	 * overage amount.
>  	 */
>  
> -	usage = page_counter_read(&memcg->memory);
> -	high = READ_ONCE(memcg->high);
> -
> -	if (usage <= high)
> -		goto out;
> -
>  	/*
>  	 * Prevent division by 0 in overage calculation by acting as if it was a
>  	 * threshold of 1 page
> @@ -2369,6 +2383,16 @@ void mem_cgroup_handle_over_high(void)
>  	if (penalty_jiffies <= HZ / 100)
>  		goto out;
>  
> +	/*
> +	 * It's possible async reclaim just isn't able to keep
> +	 * up. Before we go to sleep, try direct reclaim.
> +	 */
> +	if (!tried_direct_reclaim) {
> +		reclaim_high(memcg, nr_pages, GFP_KERNEL);
> +		tried_direct_reclaim = true;
> +		goto recheck;
> +	}
> +
>  	/*
>  	 * If we exit early, we're guaranteed to die (since
>  	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
> @@ -2544,13 +2568,21 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	do {
>  		if (page_counter_read(&memcg->memory) > memcg->high) {
> +			/*
> +			 * Kick off the async reclaimer, which should
> +			 * be doing most of the work to avoid latency
> +			 * in the workload. But also check in on its
> +			 * progress before resuming to userspace, in
> +			 * case we need to do direct reclaim, or even
> +			 * throttle the allocating thread if reclaim
> +			 * cannot keep up with allocation demand.
> +			 */
> +			queue_work(system_unbound_wq, &memcg->high_work);
>  			/* Don't bother a random interrupted task */
> -			if (in_interrupt()) {
> -				schedule_work(&memcg->high_work);
> -				break;
> +			if (!in_interrupt()) {
> +				current->memcg_nr_pages_over_high += batch;
> +				set_notify_resume(current);
>  			}
> -			current->memcg_nr_pages_over_high += batch;
> -			set_notify_resume(current);
>  			break;
>  		}
>  	} while ((memcg = parent_mem_cgroup(memcg)));
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 74e8edce83ca..d6085115c7f2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1947,7 +1947,10 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
>  	reclaim_stat->recent_scanned[file] += nr_taken;
>  
> -	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> +	if (current_is_kswapd() || (cgroup_reclaim(sc) && current_work()))
> +		item = PGSCAN_KSWAPD;
> +	else
> +		item = PGSCAN_DIRECT;
>  	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_scanned);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> @@ -1961,7 +1964,10 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  
>  	spin_lock_irq(&pgdat->lru_lock);
>  
> -	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> +	if (current_is_kswapd() || (cgroup_reclaim(sc) && current_work()))
> +		item = PGSTEAL_KSWAPD;
> +	else
> +		item = PGSTEAL_DIRECT;
>  	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -- 
> 2.24.1
> 

-- 
Michal Hocko
SUSE Labs
