Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8DAD970
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2019 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfIIM4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Sep 2019 08:56:43 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:21537 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfIIM4m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Sep 2019 08:56:42 -0400
Received: (qmail 2847 invoked from network); 9 Sep 2019 14:56:39 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.182]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Mon, 09 Sep 2019 14:56:39 +0200
Subject: Re: lot of MemAvailable but falling cache and raising PSI
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20190905114022.GH3838@dhcp22.suse.cz>
 <7a3d23f2-b5fe-b4c0-41cd-e79070637bd9@profihost.ag>
 <e866c481-04f2-fdb4-4d99-e7be2414591e@profihost.ag>
 <20190909082732.GC27159@dhcp22.suse.cz>
 <1d9ee19a-98c9-cd78-1e5b-21d9d6e36792@profihost.ag>
 <20190909110136.GG27159@dhcp22.suse.cz>
 <20190909120811.GL27159@dhcp22.suse.cz>
 <88ff0310-b9ab-36b6-d8ab-b6edd484d973@profihost.ag>
 <20190909122852.GM27159@dhcp22.suse.cz>
 <2d04fc69-8fac-2900-013b-7377ca5fd9a8@profihost.ag>
 <20190909124950.GN27159@dhcp22.suse.cz>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <10fa0b97-631d-f82b-0881-89adb9ad5ded@profihost.ag>
Date:   Mon, 9 Sep 2019 14:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909124950.GN27159@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 09.09.19 um 14:49 schrieb Michal Hocko:
> On Mon 09-09-19 14:37:52, Stefan Priebe - Profihost AG wrote:
>>
>> Am 09.09.19 um 14:28 schrieb Michal Hocko:
>>> On Mon 09-09-19 14:10:02, Stefan Priebe - Profihost AG wrote:
>>>>
>>>> Am 09.09.19 um 14:08 schrieb Michal Hocko:
>>>>> On Mon 09-09-19 13:01:36, Michal Hocko wrote:
>>>>>> and that matches moments when we reclaimed memory. There seems to be a
>>>>>> steady THP allocations flow so maybe this is a source of the direct
>>>>>> reclaim?
>>>>>
>>>>> I was thinking about this some more and THP being a source of reclaim
>>>>> sounds quite unlikely. At least in a default configuration because we
>>>>> shouldn't do anything expensinve in the #PF path. But there might be a
>>>>> difference source of high order (!costly) allocations. Could you check
>>>>> how many allocation requests like that you have on your system?
>>>>>
>>>>> mount -t debugfs none /debug
>>>>> echo "order > 0" > /debug/tracing/events/kmem/mm_page_alloc/filter
>>>>> echo 1 > /debug/tracing/events/kmem/mm_page_alloc/enable
>>>>> cat /debug/tracing/trace_pipe > $file
>>>
>>> echo 1 > /debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_begin/enable
>>> echo 1 > /debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_end/enable
>>>  
>>> might tell us something as well but it might turn out that it just still
>>> doesn't give us the full picture and we might need
>>> echo stacktrace > /debug/tracing/trace_options
>>>
>>> It will generate much more output though.
>>>
>>>> Just now or when PSI raises?
>>>
>>> When the excessive reclaim is happening ideally.
>>
>> This one is from a server with 28G memfree but memory pressure is still
>> jumping between 0 and 10%.
>>
>> I did:
>> echo "order > 0" >
>> /sys/kernel/debug/tracing/events/kmem/mm_page_alloc/filter
>>
>> echo 1 > /sys/kernel/debug/tracing/events/kmem/mm_page_alloc/enable
>>
>> echo 1 >
>> /sys/kernel/debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_begin/enable
>>
>> echo 1 >
>> /sys/kernel/debug/tracing/events/vmscan/mm_vmscan_direct_reclaim_end/enable
>>
>> timeout 120 cat /sys/kernel/debug/tracing/trace_pipe > /trace
>>
>> File attached.
> 
> There is no reclaim captured in this trace dump.
> $ zcat trace1.gz | sed 's@.*\(order=[0-9]\).*\(gfp_flags=.*\)@\1 \2@' | sort | uniq -c
>     777 order=1 gfp_flags=__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>     663 order=1 gfp_flags=__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>     153 order=1 gfp_flags=__GFP_IO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>     911 order=1 gfp_flags=GFP_KERNEL_ACCOUNT|__GFP_ZERO
>    4872 order=1 gfp_flags=GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_ACCOUNT
>      62 order=1 gfp_flags=GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>      14 order=2 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
>      11 order=2 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE
>    1263 order=2 gfp_flags=__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>      45 order=2 gfp_flags=__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE
>       1 order=2 gfp_flags=GFP_KERNEL|__GFP_COMP|__GFP_ZERO
>    7853 order=2 gfp_flags=GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_ACCOUNT
>      73 order=3 gfp_flags=__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>     729 order=3 gfp_flags=__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE
>     528 order=3 gfp_flags=__GFP_IO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>    1203 order=3 gfp_flags=GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_ACCOUNT
>    5295 order=3 gfp_flags=GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
>       1 order=3 gfp_flags=GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>     132 order=3 gfp_flags=GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
>      13 order=5 gfp_flags=GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO
>       1 order=6 gfp_flags=GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO
>    1232 order=9 gfp_flags=GFP_TRANSHUGE
>     108 order=9 gfp_flags=GFP_TRANSHUGE|__GFP_THISNODE
>     362 order=9 gfp_flags=GFP_TRANSHUGE_LIGHT|__GFP_THISNODE
> 
> Nothing really stands out because except for the THP ones none of others
> are going to even be using movable zone.
It might be that this is not an ideal example is was just the fastest i
could find. May be we really need one with much higher pressure.

I would try to find one with much higher pressure.

>  You've said that your machine
> doesn't have more than one NUMA node, right?

Yes the first example is / was a VM. This one is a Single Xeon.

Stefan
