Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6D78A64B
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjH1HLk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjH1HL0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 03:11:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3229D8;
        Mon, 28 Aug 2023 00:11:21 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZ1s33MzjzrSCZ;
        Mon, 28 Aug 2023 15:09:43 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 15:11:19 +0800
Subject: Re: [PATCH v3] mm: vmscan: try to reclaim swapcache pages if no swap
 space
To:     "Huang, Ying" <ying.huang@intel.com>
References: <20230826034401.640861-1-liushixin2@huawei.com>
 <87il9053zo.fsf@yhuang6-desk2.ccr.corp.intel.com>
CC:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <2992c888-b8c7-d93b-d132-ea90e2c516e3@huawei.com>
Date:   Mon, 28 Aug 2023 15:11:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87il9053zo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/8/28 9:51, Huang, Ying wrote:
> Liu Shixin <liushixin2@huawei.com> writes:
>
>> When spaces of swap devices are exhausted, only file pages can be reclaimed.
>> But there are still some swapcache pages in anon lru list. This can lead
>> to a premature out-of-memory.
>>
>> This problem can be fixed by checking number of swapcache pages in
>> can_reclaim_anon_pages().
>>
>> Add a new bit swapcache_only in struct scan_control to skip isolating anon
>> pages that are not in the swap cache when only swap cache can be reclaimed.
> Better to describe how you test the patch and test results.
OK, I will add the infomation.
>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  include/linux/swap.h |  6 ++++++
>>  mm/memcontrol.c      |  8 ++++++++
>>  mm/vmscan.c          | 29 +++++++++++++++++++++++++++--
>>  3 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 456546443f1f..0318e918bfa4 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>>  }
>>  
>>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>>  extern bool mem_cgroup_swap_full(struct folio *folio);
>>  #else
>>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>  	return get_nr_swap_pages();
>>  }
>>  
>> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +	return total_swapcache_pages();
>> +}
>> +
>>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>  	return vm_swap_full();
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e8ca4bdcb03c..c465829db92b 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>  	return nr_swap_pages;
>>  }
>>  
>> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +	if (mem_cgroup_disabled())
>> +		return total_swapcache_pages();
>> +
>> +	return memcg_page_state(memcg, NR_SWAPCACHE);
>> +}
>> +
>>  bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>  	struct mem_cgroup *memcg;
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7c33c5b653ef..5cb4adf6642b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -137,6 +137,9 @@ struct scan_control {
>>  	/* Always discard instead of demoting to lower tier memory */
>>  	unsigned int no_demotion:1;
>>  
>> +	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
>> +	unsigned int swapcache_only:1;
>> +
>>  	/* Allocation order */
>>  	s8 order;
>>  
>> @@ -613,10 +616,20 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>  		 */
>>  		if (get_nr_swap_pages() > 0)
>>  			return true;
>> +		/* Is there any swapcache pages to reclaim? */
>> +		if (total_swapcache_pages() > 0) {
>> +			sc->swapcache_only = 1;
>> +			return true;
>> +		}
>>  	} else {
>>  		/* Is the memcg below its swap limit? */
>>  		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>>  			return true;
>> +		/* Is there any swapcache pages in memcg to reclaim? */
>> +		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
>> +			sc->swapcache_only = 1;
>> +			return true;
>> +		}
>>  	}
>>  
>>  	/*
>> @@ -2280,6 +2293,19 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
>>  }
>>  #endif
>>  
>> +static bool skip_isolate(struct folio *folio, struct scan_control *sc,
>> +			 enum lru_list lru)
>> +{
>> +	if (folio_zonenum(folio) > sc->reclaim_idx)
>> +		return true;
>> +	if (skip_cma(folio, sc))
>> +		return true;
>> +	if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
>> +	    !folio_test_swapcache(folio)))
> Just
>
> 	if (unlikely(sc->swapcache_only && !folio_test_swapcache(folio)))
>
> is enough.
That would results the file pages to be skipped too, but what expected is to skip non-swapcache
pages in anon lru list. So I think the condition !is_file_lru(lru) is required.

Thanks,
>
>> +		return true;
>> +	return false;
>> +}
>> +
>>  /*
>>   * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
>>   *
>> @@ -2326,8 +2352,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>  		nr_pages = folio_nr_pages(folio);
>>  		total_scan += nr_pages;
>>  
>> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
>> -				skip_cma(folio, sc)) {
>> +		if (skip_isolate(folio, sc, lru)) {
>>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>>  			move_to = &folios_skipped;
>>  			goto move;
> --
> Best Regards,
> Huang, Ying
> .
>

