Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3542B78A7D7
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjH1Iic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjH1IiU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 04:38:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D9EA;
        Mon, 28 Aug 2023 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693211898; x=1724747898;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RUStWxpzF7Ipa9jq6Gk2F8lHcqJmZdIpH+4YwkEsZhs=;
  b=dLYs0QkFLA0kK4JzN1KDDjq+iAAO3rVndJSpOFWbVsMQlcDro0hHCXSS
   S6r8yX9FmVDtwL+6aPWwxaQEsbaDooh4B4XSG9PnMK82A4hOoZCZQQnuy
   D7N3wYrTejVcsJJaWC8VD8v3aTApz/+PS0pwRQP6jfnS+qkEkES01e4rJ
   ABMNIBbLzv47mRiBO9y0gHePJl10RfPjofJdEKz1d2FXNF6eVkPLsvzmf
   C9O2iLqoT/oSOddBN8+ZiGgEOLnXbM+m4B72Uveo5ILRaeyFOHvb58MZg
   Iu4PKUt+/WHVIVI4TmWQZ27fCZSezsv1mbm+rU7BX39Ocg/EjR+M8lEvT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354572886"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="354572886"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881861962"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:38:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3] mm: vmscan: try to reclaim swapcache pages if no
 swap space
References: <20230826034401.640861-1-liushixin2@huawei.com>
        <87il9053zo.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2992c888-b8c7-d93b-d132-ea90e2c516e3@huawei.com>
Date:   Mon, 28 Aug 2023 16:35:55 +0800
In-Reply-To: <2992c888-b8c7-d93b-d132-ea90e2c516e3@huawei.com> (Liu Shixin's
        message of "Mon, 28 Aug 2023 15:11:19 +0800")
Message-ID: <87a5ub5ztg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Liu Shixin <liushixin2@huawei.com> writes:

> On 2023/8/28 9:51, Huang, Ying wrote:
>> Liu Shixin <liushixin2@huawei.com> writes:
>>
>>> When spaces of swap devices are exhausted, only file pages can be reclaimed.
>>> But there are still some swapcache pages in anon lru list. This can lead
>>> to a premature out-of-memory.
>>>
>>> This problem can be fixed by checking number of swapcache pages in
>>> can_reclaim_anon_pages().
>>>
>>> Add a new bit swapcache_only in struct scan_control to skip isolating anon
>>> pages that are not in the swap cache when only swap cache can be reclaimed.
>> Better to describe how you test the patch and test results.
> OK, I will add the infomation.
>>
>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>> ---
>>>  include/linux/swap.h |  6 ++++++
>>>  mm/memcontrol.c      |  8 ++++++++
>>>  mm/vmscan.c          | 29 +++++++++++++++++++++++++++--
>>>  3 files changed, 41 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 456546443f1f..0318e918bfa4 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>>>  }
>>>  
>>>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>>> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>>>  extern bool mem_cgroup_swap_full(struct folio *folio);
>>>  #else
>>>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>>> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>>  	return get_nr_swap_pages();
>>>  }
>>>  
>>> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>>> +{
>>> +	return total_swapcache_pages();
>>> +}
>>> +
>>>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>>>  {
>>>  	return vm_swap_full();
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index e8ca4bdcb03c..c465829db92b 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>>  	return nr_swap_pages;
>>>  }
>>>  
>>> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>>> +{
>>> +	if (mem_cgroup_disabled())
>>> +		return total_swapcache_pages();
>>> +
>>> +	return memcg_page_state(memcg, NR_SWAPCACHE);
>>> +}
>>> +
>>>  bool mem_cgroup_swap_full(struct folio *folio)
>>>  {
>>>  	struct mem_cgroup *memcg;
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 7c33c5b653ef..5cb4adf6642b 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -137,6 +137,9 @@ struct scan_control {
>>>  	/* Always discard instead of demoting to lower tier memory */
>>>  	unsigned int no_demotion:1;
>>>  
>>> +	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
>>> +	unsigned int swapcache_only:1;
>>> +
>>>  	/* Allocation order */
>>>  	s8 order;
>>>  
>>> @@ -613,10 +616,20 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>>  		 */
>>>  		if (get_nr_swap_pages() > 0)
>>>  			return true;
>>> +		/* Is there any swapcache pages to reclaim? */
>>> +		if (total_swapcache_pages() > 0) {
>>> +			sc->swapcache_only = 1;
>>> +			return true;
>>> +		}
>>>  	} else {
>>>  		/* Is the memcg below its swap limit? */
>>>  		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>>>  			return true;
>>> +		/* Is there any swapcache pages in memcg to reclaim? */
>>> +		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
>>> +			sc->swapcache_only = 1;
>>> +			return true;
>>> +		}
>>>  	}
>>>  
>>>  	/*
>>> @@ -2280,6 +2293,19 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
>>>  }
>>>  #endif
>>>  
>>> +static bool skip_isolate(struct folio *folio, struct scan_control *sc,
>>> +			 enum lru_list lru)
>>> +{
>>> +	if (folio_zonenum(folio) > sc->reclaim_idx)
>>> +		return true;
>>> +	if (skip_cma(folio, sc))
>>> +		return true;
>>> +	if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
>>> +	    !folio_test_swapcache(folio)))
>> Just
>>
>> 	if (unlikely(sc->swapcache_only && !folio_test_swapcache(folio)))
>>
>> is enough.
> That would results the file pages to be skipped too, but what expected is to skip non-swapcache
> pages in anon lru list. So I think the condition !is_file_lru(lru) is required.

Ah, you are right.

--
Best Regards,
Huang, Ying

>>
>>> +		return true;
>>> +	return false;
>>> +}
>>> +
>>>  /*
>>>   * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
>>>   *
>>> @@ -2326,8 +2352,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>>  		nr_pages = folio_nr_pages(folio);
>>>  		total_scan += nr_pages;
>>>  
>>> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
>>> -				skip_cma(folio, sc)) {
>>> +		if (skip_isolate(folio, sc, lru)) {
>>>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>>>  			move_to = &folios_skipped;
>>>  			goto move;
