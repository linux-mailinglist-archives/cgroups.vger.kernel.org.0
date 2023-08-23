Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626F784E79
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHWCBI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 22:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjHWCBH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 22:01:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5726AE4A;
        Tue, 22 Aug 2023 19:01:01 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVq9066kJzNnDv;
        Wed, 23 Aug 2023 09:57:24 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 10:00:58 +0800
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache
 pages
To:     Yosry Ahmed <yosryahmed@google.com>
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com>
Date:   Wed, 23 Aug 2023 10:00:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/8/23 0:35, Yosry Ahmed wrote:
> On Mon, Aug 21, 2023 at 6:54 PM Liu Shixin <liushixin2@huawei.com> wrote:
>> When spaces of swap devices are exhausted, only file pages can be reclaimed.
>> But there are still some swapcache pages in anon lru list. This can lead
>> to a premature out-of-memory.
>>
>> This problem can be fixed by checking number of swapcache pages in
>> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that can
>> be used directly. For memcg v1, use total_swapcache_pages() instead, which
>> may not accurate but can solve the problem.
> Interesting find. I wonder if we really don't have any handling of
> this situation.
I have alreadly test this problem and can confirm that it is a real problem.
With 9MB swap space and 10MB mem_cgroup limit，when allocate 15MB memory,
there is a probability that OOM occurs.
>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  include/linux/swap.h |  6 ++++++
>>  mm/memcontrol.c      |  8 ++++++++
>>  mm/vmscan.c          | 12 ++++++++----
>>  3 files changed, 22 insertions(+), 4 deletions(-)
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
>>         return get_nr_swap_pages();
>>  }
>>
>> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +       return total_swapcache_pages();
>> +}
>> +
>>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>         return vm_swap_full();
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e8ca4bdcb03c..3e578f41023e 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>         return nr_swap_pages;
>>  }
>>
>> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +       if (mem_cgroup_disabled() || do_memsw_account())
>> +               return total_swapcache_pages();
>> +
>> +       return memcg_page_state(memcg, NR_SWAPCACHE);
>> +}
> Is there a reason why we cannot use NR_SWAPCACHE for cgroup v1? Isn't
> that being maintained regardless of cgroup version? It is not exposed
> in cgroup v1's memory.stat, but I don't think there is a reason we
> can't do that -- if only to document that it is being used with cgroup
> v1.
Thanks for your advice, it is more appropriate to use NR_SWAPCACH.
>
>
>> +
>>  bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>         struct mem_cgroup *memcg;
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7c33c5b653ef..bcb6279cbae7 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -609,13 +609,17 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>         if (memcg == NULL) {
>>                 /*
>>                  * For non-memcg reclaim, is there
>> -                * space in any swap device?
>> +                * space in any swap device or swapcache pages?
>>                  */
>> -               if (get_nr_swap_pages() > 0)
>> +               if (get_nr_swap_pages() + total_swapcache_pages() > 0)
>>                         return true;
>>         } else {
>> -               /* Is the memcg below its swap limit? */
>> -               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>> +               /*
>> +                * Is the memcg below its swap limit or is there swapcache
>> +                * pages can be freed?
>> +                */
>> +               if (mem_cgroup_get_nr_swap_pages(memcg) +
>> +                   mem_cgroup_get_nr_swapcache_pages(memcg) > 0)
>>                         return true;
>>         }
> I wonder if it would be more efficient to set a bit in struct
> scan_control if we only are out of swap spaces but have swap cache
> pages, and only isolate anon pages that are in the swap cache, instead
> of isolating random anon pages. We may end up isolating pages that are
> not in the swap cache for a few iterations and wasting cycles.
Good idea. Thanks.
>
>> --
>> 2.25.1
>>
> .
>

