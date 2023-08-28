Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632C978A40C
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjH1Bxr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Aug 2023 21:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjH1Bx0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Aug 2023 21:53:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C9126;
        Sun, 27 Aug 2023 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693187600; x=1724723600;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=9PUQL+UG8cSDSXi335re1KStoEMye9svOM9enea2wTY=;
  b=b3gD65tUNMGbRRzAyE9hNmqsbBJskQw0vcgeiRRm/fTL6Ne5grXm5WqC
   gmsKOxbgerKABJWgYmi8+N1XeWKWvuUK7WC9kODiQfBrxgzfhIiZJBhPg
   4YgsgNVyXxI95Fr+zWVsnPFEbfd+DbNwwKjC2bVLuXeSRyC68GFUh651q
   UsPB/8CU33K51yplUefHMfJXHAcxXQ+LA5cysWEFVMmiS2EyIZ6FJm2iU
   eafHzHVblpbZ06MSeG1TowGJ30JPR/BUDkKQGCidmi/VINBtTt8dO+Vcz
   hdsL8Y0n9y6RWvaUTEXd5E8u2TgdsONdGKJEoyVzr+0AA/+7H6oNeWoVF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="438941783"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="438941783"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 18:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803525904"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="803525904"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 18:53:16 -0700
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
Subject: Re: [PATCH v3] mm: vmscan: try to reclaim swapcache pages if no
 swap space
References: <20230826034401.640861-1-liushixin2@huawei.com>
Date:   Mon, 28 Aug 2023 09:51:07 +0800
In-Reply-To: <20230826034401.640861-1-liushixin2@huawei.com> (Liu Shixin's
        message of "Sat, 26 Aug 2023 11:44:01 +0800")
Message-ID: <87il9053zo.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> When spaces of swap devices are exhausted, only file pages can be reclaimed.
> But there are still some swapcache pages in anon lru list. This can lead
> to a premature out-of-memory.
>
> This problem can be fixed by checking number of swapcache pages in
> can_reclaim_anon_pages().
>
> Add a new bit swapcache_only in struct scan_control to skip isolating anon
> pages that are not in the swap cache when only swap cache can be reclaimed.

Better to describe how you test the patch and test results.

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
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
> index 7c33c5b653ef..5cb4adf6642b 100644
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

Just

	if (unlikely(sc->swapcache_only && !folio_test_swapcache(folio)))

is enough.

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

--
Best Regards,
Huang, Ying
