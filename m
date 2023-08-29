Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8558278BCB7
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 04:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjH2COw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjH2COn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 22:14:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBB1A4;
        Mon, 28 Aug 2023 19:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693275275; x=1724811275;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nR9wTrI9cfzWP5jUNG5QsV5f2sCU0io+s5Xq9+gWL5g=;
  b=O+zNqBCKSdQOkaJUDhj5I8NUyj1lmHkxn7tQywOt0K3dMtvhnrDSMflU
   /zNS1zTNLbYj+Tx/nrCjUhXnl/Jy+aErpn2TcW+CNFB0FnLAf+WhZkePK
   LOT4YnqF7sJc88c8MOBKOTtW/FvQ9g+wtCvdOrsfsbMtaG5/opZyF0hm7
   PBGfbVTX/3C6hmMKAUx+JEy+krcyp8d4YYZBlyJJ+abKD5nOLFD/Ri7Ge
   9UD8fdjhsiCCJOLLALi4DfmbI0+Xu1301XQ7YcmcstoA3zRFXyvPQRpN1
   ZFU51jrM+WVaOBULQTCMt5OcBNODc6ARV/lovtJoVUlPC71v67EwUoR7n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372670979"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="372670979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 19:14:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882138218"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 19:14:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4] mm: vmscan: try to reclaim swapcache pages if no
 swap space
References: <20230829024104.1505530-1-liushixin2@huawei.com>
Date:   Tue, 29 Aug 2023 10:12:27 +0800
In-Reply-To: <20230829024104.1505530-1-liushixin2@huawei.com> (Liu Shixin's
        message of "Tue, 29 Aug 2023 10:41:04 +0800")
Message-ID: <87y1hu4mwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Liu Shixin <liushixin2@huawei.com> writes:

> When spaces of swap devices are exhausted, only file pages can be reclaimed.
> But there are still some swapcache pages in anon lru list. This can lead
> to a premature out-of-memory.
>
> The problem is found with such step:
>
>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>  memory limit, then runs an program to allocates about 15MB memory.
>
> The problem occurs occasionally, which may need about 100 times.
>
> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true either. Moreover, add a new bit
> swapcache_only in struct scan_control to skip isolating anon pages that
> are not swapcache when only swapcache pages can be reclaimed to accelerate
> reclaim efficiency.
>
> Link: https://lore.kernel.org/linux-mm/14e15f31-f3d3-4169-8ed9-fb36e57cf578@huawei.com/
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Tested-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  include/linux/swap.h |  6 ++++++
>  mm/memcontrol.c      |  8 ++++++++
>  mm/vmscan.c          | 29 +++++++++++++++++++++++++++--
>  3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 456546443f1f..0318e918bfa4 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>  }
>  
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  	return get_nr_swap_pages();
>  }
>  
> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +	return total_swapcache_pages();
> +}
> +
>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>  {
>  	return vm_swap_full();
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..c465829db92b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  	return nr_swap_pages;
>  }
>  
> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +	if (mem_cgroup_disabled())
> +		return total_swapcache_pages();
> +
> +	return memcg_page_state(memcg, NR_SWAPCACHE);
> +}
> +
>  bool mem_cgroup_swap_full(struct folio *folio)
>  {
>  	struct mem_cgroup *memcg;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1080209a568b..e73e2df8828d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -137,6 +137,9 @@ struct scan_control {
>  	/* Always discard instead of demoting to lower tier memory */
>  	unsigned int no_demotion:1;
>  
> +	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
> +	unsigned int swapcache_only:1;
> +
>  	/* Allocation order */
>  	s8 order;
>  
> @@ -613,10 +616,20 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>  		 */
>  		if (get_nr_swap_pages() > 0)
>  			return true;
> +		/* Is there any swapcache pages to reclaim? */
> +		if (total_swapcache_pages() > 0) {
> +			sc->swapcache_only = 1;
> +			return true;
> +		}
>  	} else {
>  		/* Is the memcg below its swap limit? */
>  		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>  			return true;
> +		/* Is there any swapcache pages in memcg to reclaim? */
> +		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
> +			sc->swapcache_only = 1;
> +			return true;
> +		}
>  	}
>  
>  	/*
> @@ -2280,6 +2293,19 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
>  }
>  #endif
>  
> +static bool skip_isolate(struct folio *folio, struct scan_control *sc,
> +			 enum lru_list lru)
> +{
> +	if (folio_zonenum(folio) > sc->reclaim_idx)
> +		return true;
> +	if (skip_cma(folio, sc))
> +		return true;
> +	if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
> +	    !folio_test_swapcache(folio)))
> +		return true;
> +	return false;
> +}
> +
>  /*
>   * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
>   *
> @@ -2326,8 +2352,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
> -				skip_cma(folio, sc)) {
> +		if (skip_isolate(folio, sc, lru)) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;
