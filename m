Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA160EF58
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 07:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiJ0FOW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiJ0FOV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 01:14:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F24153834;
        Wed, 26 Oct 2022 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666847660; x=1698383660;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=9d3aFGAFLQAxiFqVF47lE8CevVy7cGqVqRyit2lkJRE=;
  b=HMUMKMk4KDmrqMCgMZ2t/RRDDgqvprvtDyQEgCseYaZPN9FvfcreHNWB
   7Z3ekID+vzuxLKEHBAiBpxIDCcT7iis0UsjCsPtVvTaK4AoICY4b3ol7Y
   TE8acTs5K+rUD6NbwjfMRfX/Mj3Q30ZEdZ7GEbzUmlu2NXnogKPpHgd0+
   sMuOyM8iTHYn3NSqQrPhuAXkNvKjf+s4sswcj9utLpUJs4a1gHiaIoMAU
   M7I2JI5QATodhCBc5SYsgQvvNV8Dy8Q7KNZCKQ16GUxHlYhQNxbzuVP/x
   PtoFM7INzOkZPn0aybZM94bWLn4L8ur7IxaQRT5SU7IazL/dTdI/bt6kK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291434272"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="291434272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:14:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774858075"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774858075"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:14:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@intel.com>,
        <tim.c.chen@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
References: <20221026074343.6517-1-feng.tang@intel.com>
Date:   Thu, 27 Oct 2022 13:13:30 +0800
In-Reply-To: <20221026074343.6517-1-feng.tang@intel.com> (Feng Tang's message
        of "Wed, 26 Oct 2022 15:43:43 +0800")
Message-ID: <878rl1luh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> In page reclaim path, memory could be demoted from faster memory tier
> to slower memory tier. Currently, there is no check about cpuset's
> memory policy, that even if the target demotion node is not allowd
> by cpuset, the demotion will still happen, which breaks the cpuset
> semantics.
>
> So add cpuset policy check in the demotion path and skip demotion
> if the demotion targets are not allowed by cpuset.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Hi reviewers,
>
> For easy bisectable, I combined the cpuset change and mm change
> in one patch, if you prefer to separate them, I can turn it into
> 2 patches.
>
> Thanks,
> Feng
>
>  include/linux/cpuset.h |  6 ++++++
>  kernel/cgroup/cpuset.c | 29 +++++++++++++++++++++++++++++
>  mm/vmscan.c            | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..6fcce2bd2631 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -178,6 +178,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> +extern void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask);
>  #else /* !CONFIG_CPUSETS */
>  
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -299,6 +301,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
>  
> +static inline void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup,
> +						nodemask_t *nmask)
> +{
> +}
>  #endif /* !CONFIG_CPUSETS */
>  
>  #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3ea2e836e93e..cbb118c0502f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3750,6 +3750,35 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>  	return mask;
>  }
>  
> +/*
> + * Retrieve the allowed memory nodemask for a cgroup.
> + *
> + * Set *nmask to cpuset's effective allowed nodemask for cgroup v2,
> + * and NODE_MASK_ALL (means no constraint) for cgroup v1 where there
> + * is no guaranteed association from a cgroup to a cpuset.
> + */
> +void cpuset_get_allowed_mem_nodes(struct cgroup *cgroup, nodemask_t *nmask)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +
> +	if (!is_in_v2_mode()) {
> +		*nmask = NODE_MASK_ALL;
> +		return;
> +	}
> +
> +	rcu_read_lock();
> +	css = cgroup_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (css) {
> +		css_get(css);
> +		cs = css_cs(css);
> +		*nmask = cs->effective_mems;
> +		css_put(css);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * cpuset_nodemask_valid_mems_allowed - check nodemask vs. current mems_allowed
>   * @nodemask: the nodemask to be checked
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 18f6497994ec..c205d98283bc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1537,9 +1537,21 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  {
>  	struct page *target_page;
>  	nodemask_t *allowed_mask;
> -	struct migration_target_control *mtc;
> +	struct migration_target_control *mtc = (void *)private;
>  
> -	mtc = (struct migration_target_control *)private;

I think we should avoid (void *) conversion here.

> +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> +	struct mem_cgroup *memcg;
> +	nodemask_t cpuset_nmask;
> +
> +	memcg = page_memcg(page);
> +	cpuset_get_allowed_mem_nodes(memcg->css.cgroup, &cpuset_nmask);
> +
> +	if (!node_isset(mtc->nid, cpuset_nmask)) {
> +		if (mtc->nmask)
> +			nodes_and(*mtc->nmask, *mtc->nmask, cpuset_nmask);
> +		return alloc_migration_target(page, (unsigned long)mtc);
> +	}

If node_isset(mtc->nid, cpuset_nmask) == true, we should keep the
original 2 steps allocation and apply nodes_and() on node mask.

> +#endif
>  
>  	allowed_mask = mtc->nmask;
>  	/*
> @@ -1649,6 +1661,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		enum folio_references references = FOLIOREF_RECLAIM;
>  		bool dirty, writeback;
>  		unsigned int nr_pages;
> +		bool skip_this_demotion = false;
>  
>  		cond_resched();
>  
> @@ -1658,6 +1671,22 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
> +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
> +		if (do_demote_pass) {
> +			struct mem_cgroup *memcg;
> +			nodemask_t nmask, nmask1;
> +
> +			node_get_allowed_targets(pgdat, &nmask);

pgdat will not change in the loop, so we can move this out of the loop?

> +			memcg = folio_memcg(folio);
> +			if (memcg)
> +				cpuset_get_allowed_mem_nodes(memcg->css.cgroup,
> +								&nmask1);
> +
> +			if (!nodes_intersects(nmask, nmask1))
> +				skip_this_demotion = true;
> +		}

If nodes_intersects() == true, we will call
cpuset_get_allowed_mem_nodes() twice.  Better to pass the intersecting
mask to demote_folio_list()?

> +#endif
> +
>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>  
>  		nr_pages = folio_nr_pages(folio);
> @@ -1799,7 +1828,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		 * Before reclaiming the folio, try to relocate
>  		 * its contents to another node.
>  		 */
> -		if (do_demote_pass &&
> +		if (do_demote_pass && !skip_this_demotion &&
>  		    (thp_migration_supported() || !folio_test_large(folio))) {
>  			list_add(&folio->lru, &demote_folios);
>  			folio_unlock(folio);

Best Regards,
Huang, Ying
