Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446654ED666
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiCaJDD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiCaJC5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 05:02:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B025549E;
        Thu, 31 Mar 2022 02:01:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A519210FC;
        Thu, 31 Mar 2022 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648717267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88K9QJhQy9KGsblKgnldVstyIQfXw56LTq188acmDe8=;
        b=LXZ+BXrFjTOZqlg8vf5GeaZXhkxaBjFDkDiXofk9wm7fXtRyFNy61PxCmqJfNaXSEXu38f
        PVw5AfRN0cN7b8l8L5/Mr6TPRFkbgiBfcYeHNkX9J7eQO8r658n2Na4nDTXXLDtPKfIPTr
        3EKUO451pND78f4Ni3pC9SvmCJH/08E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E42ECA3B87;
        Thu, 31 Mar 2022 09:01:06 +0000 (UTC)
Date:   Thu, 31 Mar 2022 11:01:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        ke.wang@unisoc.com
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <YkVt0m+VxnXgnulq@dhcp22.suse.cz>
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> For some kind of memcg, the usage is varies greatly from scenarios. Such as
> multimedia app could have the usage range from 50MB to 500MB, which generated
> by loading an special algorithm into its virtual address space and make it hard
> to protect the expanded usage without userspace's interaction.

Do I get it correctly that the concern you have is that you do not know
how much memory your workload will need because that depends on some
parameters?

> Furthermore, fixed
> memory.low is a little bit against its role of soft protection as it will response
> any system's memory pressure in same way.

Could you be more specific about this as well?

> Taking all above into consideration, we introduce a kind of dynamic protection
> based on group's watermark and system's memory pressure in this patch. Our aims are:
> 1. dynamic protection with no fixed setting
> 2. proper protection value on memory.current

How do you define the "proper protection"

> 3. time based decay protection
> 4. memory pressue related protection
> 
> The basic concept could be descripted as bellowing, where we take group->watermark
> as a representative of usage
> 		group->memory.low = decayed_watermark * decay_factor
> 		decayed_watermark = group->watermark * func_wm_decay(time)
> 		decay_factor = psi_system[PSI_MEM][time]
> 
> func_wm_decay could be deemed as a linear decay funcion that will decay 1/2 in
> 68s(36bit).If we take 2048 as "1", it could be descripted as:
> 		decayed_watermark = time >> (group->wm_dec_factor - 10)
> 		decayed_watermark = new_usage(if new_usage > decayed_watermark)
> 
> decay_factor is as simple as a table lookingup and compose the final value by
> weight of some and full as
> 		some = psi_system.avg[PSI_MEM * 2][time]
> 		full = psi_system.avg[PSI_MEM * 2 + 1][time]
> 		decay_factor = some * 70% + full *30%

One very important thing that I am missing here is the overall objective of this
tuning. From the above it seems that you want to (ab)use memory->low to
protect some portion of the charged memory and that the protection
shrinks over time depending on the the global PSI metrict and time.
But why this is a good thing?

Also you seem to base your back off on the global PSI numbers. How does
that cope with a memcg memory pressure?

> We simply test above change on a v5.4 based system in bellowing topology and
> observe some behavious as we expected:
>       A
>      / \
>     B   C
> 1. With regard to the protection, elow is in a proper range as proportion of watermark.
> 2. Elapsed time has positive impact on elow via decayed_watermark.
> 3. Memory pressure has negitive impact on elow which could keep more usage when
>    system is under less pressure.

I am sorry but this doesn't really help much. As pointed out out above,
I completely fail to see what is the expected behavior and why it makes
sense.

> PS: It should be configured as a sub-type of memcg and choosed by the user when
> create the group.

I do not understand but I suspect that a non-RFC proposal would use a
dedicated user interface. Your current implementation is surely not
acceptable as it changes semantic of a limit without any way to opt-out
of that behavior. Memory low has a well established semantic so this
cannot really be changed without an explicit opt-in.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/memcontrol.h   | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/page_counter.h |  4 ++++
>  include/linux/psi.h          |  2 ++
>  kernel/sched/psi.c           | 18 ++++++++++++++++
>  mm/memcontrol.c              |  4 ++++
>  mm/page_counter.c            |  4 ++++
>  6 files changed, 82 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c5c403..a510057 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -21,6 +21,9 @@
>  #include <linux/vmstat.h>
>  #include <linux/writeback.h>
>  #include <linux/page-flags.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/sched/clock.h>
> +#include <linux/psi.h>
>  
>  struct mem_cgroup;
>  struct obj_cgroup;
> @@ -28,6 +31,8 @@
>  struct mm_struct;
>  struct kmem_cache;
>  
> +#define MEMCG_INTERVAL	(2*HZ+1)	/* 2 sec intervals */
> +
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
> @@ -340,6 +345,10 @@ struct mem_cgroup {
>  	struct deferred_split deferred_split_queue;
>  #endif
>  
> +	u64 wm_dec_fact;
> +	u64 avg_next_update;
> +	u64 avg_last_update;
> +
>  	struct mem_cgroup_per_node *nodeinfo[];
>  };
>  
> @@ -608,6 +617,47 @@ static inline bool mem_cgroup_disabled(void)
>  	return !cgroup_subsys_enabled(memory_cgrp_subsys);
>  }
>  
> +/*
> + * calculate memory.low based on the historic watermark and memory pressure
> + */
> +static inline void calc_protected_low(struct mem_cgroup *group)
> +{
> +	u64 now, decay_factor;
> +	u64 decayed_watermark;
> +	u64 delta_time;
> +
> +	now = sched_clock();
> +
> +	if (!group->avg_next_update) {
> +		group->avg_next_update = now + jiffies_to_nsecs(5*HZ);
> +		return;
> +	}
> +
> +	if (time_before((unsigned long)now, (unsigned long)group->avg_next_update))
> +		return;
> +
> +	delta_time = group->avg_last_update ? now - group->avg_last_update : 0;
> +	/*
> +	 * we take 2048 as "1" and 68s decay 1/2(36bit) by default
> +	 * decay_factor = 1024 * delta_time / 68s(0x1000000000)
> +	 * 0.5(1024)/68s = decay_factor/delta_time ==> decay_factor = delta_time >> 26
> +	 */
> +	decay_factor = (2048 - min(2048ULL, delta_time >> (group->wm_dec_fact - 10)));
> +	decayed_watermark = group->memory.decayed_watermark * decay_factor / 2048;
> +	/* decay_factor: based on average memory pressure over elapsed time */
> +	decay_factor = psi_mem_get(delta_time);
> +	group->memory.low = decayed_watermark * (100 - decay_factor) / 100;
> +
> +	/*
> +	 * avg_next_update: expected expire time according to current status
> +	 */
> +	group->memory.decayed_watermark = decayed_watermark;
> +	group->avg_last_update = now;
> +	group->avg_next_update = now + jiffies_to_nsecs(2*HZ);
> +
> +	return;
> +}
> +
>  static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  					 struct mem_cgroup *memcg,
>  					 unsigned long *min,
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 6795913..2720eb9f 100644
> --- a/include/linux/page_counter.h



> +++ b/include/linux/page_counter.h
> @@ -25,8 +25,12 @@ struct page_counter {
>  
>  	/* legacy */
>  	unsigned long watermark;
> +	unsigned long decayed_watermark;
>  	unsigned long failcnt;
>  
> +	/* proportional protection */
> +	unsigned long min_prop;
> +	unsigned long low_prop;
>  	/*
>  	 * 'parent' is placed here to be far from 'usage' to reduce
>  	 * cache false sharing, as 'usage' is written mostly while
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index 65eb147..6c76993 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -25,6 +25,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  
>  int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
>  
> +unsigned long psi_mem_get(unsigned long time);
> +
>  #ifdef CONFIG_CGROUPS
>  int psi_cgroup_alloc(struct cgroup *cgrp);
>  void psi_cgroup_free(struct cgroup *cgrp);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index dd80bd2..8d315e0 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -291,6 +291,24 @@ static void get_recent_times(struct psi_group *group, int cpu,
>  	}
>  }
>  
> +unsigned long psi_mem_get(unsigned long time_ns)
> +{
> +	unsigned long time_sec = time_ns / (1000 * 1000 * 1000);
> +	unsigned long some, full;
> +	if (time_sec < 10) {
> +		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][0]);
> +		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][0]);
> +	} else if (time_sec < 60) {
> +		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][1]);
> +		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][1]);
> +	} else {
> +		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][2]);
> +		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][2]);
> +	}
> +
> +	return (some * 768 + full * 256) / 1024;
> +}
> +
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
>  		      u64 time, u64 period)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 508bcea..6b579a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5188,6 +5188,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
>  	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> +	memcg->wm_dec_fact = 36;
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
> @@ -6616,6 +6617,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  {
>  	unsigned long usage, parent_usage;
>  	struct mem_cgroup *parent;
> +	unsigned long memcg_emin, memcg_elow, parent_emin, parent_elow;
> +	unsigned long watermark;
>  
>  	if (mem_cgroup_disabled())
>  		return;
> @@ -6642,6 +6645,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  	if (!parent)
>  		return;
>  
> +	calc_protected_low(memcg);
>  	if (parent == root) {
>  		memcg->memory.emin = READ_ONCE(memcg->memory.min);
>  		memcg->memory.elow = READ_ONCE(memcg->memory.low);
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 7d83641..18abfdd 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -83,6 +83,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		 */
>  		if (new > READ_ONCE(c->watermark))
>  			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->decayed_watermark))
> +			WRITE_ONCE(c->decayed_watermark, new);
>  	}
>  }
>  
> @@ -137,6 +139,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		 */
>  		if (new > READ_ONCE(c->watermark))
>  			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->decayed_watermark))
> +			WRITE_ONCE(c->decayed_watermark, new);
>  	}
>  	return true;
>  
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
