Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B906E170D0A
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 01:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgB0AMc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 19:12:32 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43219 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgB0AMc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 19:12:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tr.dLPs_1582762346;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tr.dLPs_1582762346)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Feb 2020 08:12:28 +0800
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <20200226222642.GB30206@cmpxchg.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
Date:   Wed, 26 Feb 2020 16:12:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200226222642.GB30206@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/26/20 2:26 PM, Johannes Weiner wrote:
> On Wed, Feb 26, 2020 at 12:25:33PM -0800, Shakeel Butt wrote:
>> On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>> We have received regression reports from users whose workloads moved
>>> into containers and subsequently encountered new latencies. For some
>>> users these were a nuisance, but for some it meant missing their SLA
>>> response times. We tracked those delays down to cgroup limits, which
>>> inject direct reclaim stalls into the workload where previously all
>>> reclaim was handled my kswapd.
>>>
>>> This patch adds asynchronous reclaim to the memory.high cgroup limit
>>> while keeping direct reclaim as a fallback. In our testing, this
>>> eliminated all direct reclaim from the affected workload.
>>>
>>> memory.high has a grace buffer of about 4% between when it becomes
>>> exceeded and when allocating threads get throttled. We can use the
>>> same buffer for the async reclaimer to operate in. If the worker
>>> cannot keep up and the grace buffer is exceeded, allocating threads
>>> will fall back to direct reclaim before getting throttled.
>>>
>>> For irq-context, there's already async memory.high enforcement. Re-use
>>> that work item for all allocating contexts, but switch it to the
>>> unbound workqueue so reclaim work doesn't compete with the workload.
>>> The work item is per cgroup, which means the workqueue infrastructure
>>> will create at maximum one worker thread per reclaiming cgroup.
>>>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>>   mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
>>>   mm/vmscan.c     | 10 +++++++--
>> This reminds me of the per-memcg kswapd proposal from LSFMM 2018
>> (https://lwn.net/Articles/753162/).
> Ah yes, I remember those discussions. :)
>
> One thing that has changed since we tried to implement this last was
> the workqueue concurrency code. We don't have to worry about a single
> thread or fixed threads per cgroup, because the workqueue code has
> improved significantly to handle concurrency demands, and having one
> work item per cgroup makes sure we have anywhere between 0 threads and
> one thread per cgroup doing this reclaim work, completely on-demand.

Yes, exactly. Our in-house implementation was just converted to use 
workqueue instead of dedicated kernel thread for each cgroup.

>
> Also, with cgroup2, memory and cpu always have overlapping control
> domains, so the question who to account the work to becomes a much
> easier one to answer.
>
>> If I understand this correctly, the use-case is that the job instead
>> of direct reclaiming (potentially in latency sensitive tasks), prefers
>> a background non-latency sensitive task to do the reclaim. I am
>> wondering if we can use the memory.high notification along with a new
>> memcg interface (like memory.try_to_free_pages) to implement a user
>> space background reclaimer. That would resolve the cpu accounting
>> concerns as the user space background reclaimer can share the cpu cost
>> with the task.
> The idea is not necessarily that the background reclaimer is lower
> priority work, but that it can execute in parallel on a separate CPU
> instead of being forced into the execution stream of the main work.
>
> So we should be able to fully resolve this problem inside the kernel,
> without going through userspace, by accounting CPU cycles used by the
> background reclaim worker to the cgroup that is being reclaimed.

Actually I'm wondering if we really need account CPU cycles used by 
background reclaimer or not. For our usecase (this may be not general), 
the purpose of background reclaimer is to avoid latency sensitive 
workloads get into direct relcaim (avoid the stall from direct relcaim). 
In fact it just "steal" CPU cycles from lower priority or best-effort 
workloads to guarantee latency sensitive workloads behave well. If the 
"stolen" CPU cycles are accounted, it means the latency sensitive 
workloads would get throttled from somewhere else later, i.e. by CPU share.

We definitely don't want to the background reclaimer eat all CPU cycles. 
So, the whole background reclaimer is opt in stuff. The higher level 
cluster management and administration components make sure the cgroups 
are setup correctly, i.e. enable for specific cgroups, setup watermark 
properly, etc.

Of course, this may be not universal and may be just fine for some 
specific configurations or usecases.

>
>> One concern with this approach will be that the memory.high
>> notification is too late and the latency sensitive task has faced the
>> stall. We can either introduce a threshold notification or another
>> notification only limit like memory.near_high which can be set based
>> on the job's rate of allocations and when the usage hits this limit
>> just notify the user space.
> Yeah, I think it would be a pretty drastic expansion of the memory
> controller's interface.

