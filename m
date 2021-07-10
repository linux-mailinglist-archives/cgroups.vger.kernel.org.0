Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B303C324B
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 05:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGJDkV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 23:40:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10346 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhGJDkV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 23:40:21 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GMFwc4rwXz77Zb;
        Sat, 10 Jul 2021 11:33:04 +0800 (CST)
Received: from [10.174.177.209] (10.174.177.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 10 Jul 2021 11:37:27 +0800
Subject: Re: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>
References: <20210710003626.3549282-1-surenb@google.com>
 <b29493f5-34d9-6e8f-ec41-179a043641f4@huawei.com>
 <CAJuCfpEGEoA9Pb8iLdXNH9Q3fiGEaNkKWM6p+M1KzE69cmEJww@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <24966bfd-008f-3b48-36f7-4aa298057559@huawei.com>
Date:   Sat, 10 Jul 2021 11:37:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEGEoA9Pb8iLdXNH9Q3fiGEaNkKWM6p+M1KzE69cmEJww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.209]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/7/10 10:40, Suren Baghdasaryan wrote:
> On Fri, Jul 9, 2021 at 6:52 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/7/10 8:36, Suren Baghdasaryan wrote:
>>> Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
>>> cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
>>> the pagefault and exit_mmap paths when memcgs are disabled using
>>> cgroup_disable=memory command-line option.
>>> This change results in ~2.1% overhead reduction when running PFT test
>>> comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
>>> CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
>>> ARM64 Android device.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>>  mm/memcontrol.c | 3 +++
>>>  mm/swapfile.c   | 3 +++
>>>  mm/vmpressure.c | 7 ++++++-
>>>  3 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index ae1f5d0cb581..a228cd51c4bd 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>>>       struct mem_cgroup *memcg;
>>>       unsigned short id;
>>>
>>> +     if (mem_cgroup_disabled())
>>> +             return;
>>> +
>>>       id = swap_cgroup_record(entry, 0, nr_pages);
>>>       rcu_read_lock();
>>>       memcg = mem_cgroup_from_id(id);
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 1e07d1c776f2..707fa0481bb4 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>>>       struct swap_info_struct *si, *next;
>>>       int nid = page_to_nid(page);
>>>
>>> +     if (mem_cgroup_disabled())
>>> +             return;
>>> +
>>
>> Many thanks for your patch. But I'am somewhat confused about this change.
>> IMO, cgroup_throttle_swaprate() is only related to blk_cgroup and it seems
>> it's irrelevant to mem_cgroup. Could you please have a explanation for me?
> 
> cgroup_throttle_swaprate() is a NoOp when CONFIG_MEMCG=n (see:
> https://elixir.bootlin.com/linux/latest/source/include/linux/swap.h#L699),

I browsed the git history related to cgroup_throttle_swaprate() and found this:

"""
mm: memcontrol: move out cgroup swaprate throttling

    The cgroup swaprate throttling is about matching new anon allocations to
    the rate of available IO when that is being throttled.  It's the io
    controller hooking into the VM, rather than a memory controller thing.
"""

It seems cgroup_throttle_swaprate() is working with memory allocations.
So mem_cgroup matters this way. But I'am not sure...

> therefore I assume we can safely skip it when memcgs are disabled via
> "cgroup_disable=memory". From perf results I also see no hits on this
> function when CONFIG_MEMCG=n.
> However, looking into the code, I'm not sure why it should depend on
> CONFIG_MEMCG. But it's Friday night and I might be missing some
> details here...

Many thanks for your replay at Friday night. :)

> 
>>
>> Thanks!
>>
>>>       if (!(gfp_mask & __GFP_IO))
>>>               return;
>>>
>>> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>>> index d69019fc3789..9b172561fded 100644
>>> --- a/mm/vmpressure.c
>>> +++ b/mm/vmpressure.c
>>> @@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
>>>  void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>>>               unsigned long scanned, unsigned long reclaimed)
>>>  {
>>> -     struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
>>> +     struct vmpressure *vmpr;
>>> +
>>> +     if (mem_cgroup_disabled())
>>> +             return;
>>> +
>>> +     vmpr = memcg_to_vmpressure(memcg);
>>>
>>>       /*
>>>        * Here we only want to account pressure that userland is able to
>>>
>>
> .
> 

