Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0260EFDE
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 08:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiJ0GGI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiJ0GGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 02:06:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650454DF31;
        Wed, 26 Oct 2022 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666850762; x=1698386762;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=IOtoJvotBvGQVQl8hxk+xZrgGkgYvVwH6HE/NLIQ6g0=;
  b=hma3Y+qBHbfVrf9+U1csL8WBe1foyx9EVeGP4mdPaCSRBKvE8aKAHyZm
   l0QlDjb4N1Dv3RghkTZfJO1WacLrz25HZS1zrkI4I5VAJzvycQdp7d8p+
   eC/QAlyHady+Z67+O2l3EbdWxBdPb6W1msThHHwfXgYDPld0UBoUGKScN
   ifCXKbo5D3BA5gD9mLZ2/eetyAQoLLqfy6N+wI2f0A556SemIa4qJvQ17
   yyGAERUUYb1W4pV2aZAy1YntW25Nnad3qU9mPXJxj98mZP3OpsKP/mFQ0
   rJbSNvIKfj1/Ylpm0FR+jknTMusJoN8HCniLy5xQE23UGnD3kA5mzcME3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="308132028"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="308132028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:06:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774871166"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774871166"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:05:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hocko, Michal" <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
References: <20221026074343.6517-1-feng.tang@intel.com>
        <878rl1luh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ob5XxqJzTDjBYy@feng-clx>
Date:   Thu, 27 Oct 2022 14:05:19 +0800
In-Reply-To: <Y1ob5XxqJzTDjBYy@feng-clx> (Feng Tang's message of "Thu, 27 Oct
        2022 13:49:25 +0800")
Message-ID: <871qqtls2o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> On Thu, Oct 27, 2022 at 01:13:30PM +0800, Huang, Ying wrote:
>> Feng Tang <feng.tang@intel.com> writes:
>> 
>> > In page reclaim path, memory could be demoted from faster memory tier
>> > to slower memory tier. Currently, there is no check about cpuset's
>> > memory policy, that even if the target demotion node is not allowd
>> > by cpuset, the demotion will still happen, which breaks the cpuset
>> > semantics.
>> >
>> > So add cpuset policy check in the demotion path and skip demotion
>> > if the demotion targets are not allowed by cpuset.
>> >
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> > ---
> [...]
>> > index 18f6497994ec..c205d98283bc 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -1537,9 +1537,21 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>> >  {
>> >  	struct page *target_page;
>> >  	nodemask_t *allowed_mask;
>> > -	struct migration_target_control *mtc;
>> > +	struct migration_target_control *mtc = (void *)private;
>> >  
>> > -	mtc = (struct migration_target_control *)private;
>> 
>> I think we should avoid (void *) conversion here.
>
> OK, will change back.
>
>> > +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
>> > +	struct mem_cgroup *memcg;
>> > +	nodemask_t cpuset_nmask;
>> > +
>> > +	memcg = page_memcg(page);
>> > +	cpuset_get_allowed_mem_nodes(memcg->css.cgroup, &cpuset_nmask);
>> > +
>> > +	if (!node_isset(mtc->nid, cpuset_nmask)) {
>> > +		if (mtc->nmask)
>> > +			nodes_and(*mtc->nmask, *mtc->nmask, cpuset_nmask);
>> > +		return alloc_migration_target(page, (unsigned long)mtc);
>> > +	}
>> 
>> If node_isset(mtc->nid, cpuset_nmask) == true, we should keep the
>> original 2 steps allocation and apply nodes_and() on node mask.
>
> Good catch! Yes, the nodes_and() call should be taken out from this
> check and done before calling node_isset().
>
>> > +#endif
>> >  
>> >  	allowed_mask = mtc->nmask;
>> >  	/*
>> > @@ -1649,6 +1661,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>> >  		enum folio_references references = FOLIOREF_RECLAIM;
>> >  		bool dirty, writeback;
>> >  		unsigned int nr_pages;
>> > +		bool skip_this_demotion = false;
>> >  
>> >  		cond_resched();
>> >  
>> > @@ -1658,6 +1671,22 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>> >  		if (!folio_trylock(folio))
>> >  			goto keep;
>> >  
>> > +#if IS_ENABLED(CONFIG_MEMCG) && IS_ENABLED(CONFIG_CPUSETS)
>> > +		if (do_demote_pass) {
>> > +			struct mem_cgroup *memcg;
>> > +			nodemask_t nmask, nmask1;
>> > +
>> > +			node_get_allowed_targets(pgdat, &nmask);
>> 
>> pgdat will not change in the loop, so we can move this out of the loop?
>  
> Yes
>
>> > +			memcg = folio_memcg(folio);
>> > +			if (memcg)
>> > +				cpuset_get_allowed_mem_nodes(memcg->css.cgroup,
>> > +								&nmask1);
>> > +
>> > +			if (!nodes_intersects(nmask, nmask1))
>> > +				skip_this_demotion = true;
>> > +		}
>> 
>> If nodes_intersects() == true, we will call
>> cpuset_get_allowed_mem_nodes() twice.  Better to pass the intersecting
>> mask to demote_folio_list()?
>  
> The pages in the loop may come from different mem control group, and
> the cpuset's nodemask could be different, I don't know how to save
> this per-page info to be used later in demote_folio_list.

Yes.  You are right.  We cannot do that.

Best Regards,
Huang, Ying

>
>> > +#endif
>> > +
>> >  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>> >  
>> >  		nr_pages = folio_nr_pages(folio);
>> > @@ -1799,7 +1828,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>> >  		 * Before reclaiming the folio, try to relocate
>> >  		 * its contents to another node.
>> >  		 */
>> > -		if (do_demote_pass &&
>> > +		if (do_demote_pass && !skip_this_demotion &&
>> >  		    (thp_migration_supported() || !folio_test_large(folio))) {
>> >  			list_add(&folio->lru, &demote_folios);
>> >  			folio_unlock(folio);
>> 
>> Best Regards,
>> Huang, Ying
