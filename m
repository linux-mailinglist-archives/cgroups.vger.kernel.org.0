Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC4170CDF
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 00:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBZX7d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 18:59:33 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35368 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgBZX7d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 18:59:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tr.Q08s_1582761566;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tr.Q08s_1582761566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Feb 2020 07:59:28 +0800
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <1bfd6ea4-f012-5778-64c6-36731e69b5ba@linux.alibaba.com>
Date:   Wed, 26 Feb 2020 15:59:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/26/20 12:25 PM, Shakeel Butt wrote:
> On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>> We have received regression reports from users whose workloads moved
>> into containers and subsequently encountered new latencies. For some
>> users these were a nuisance, but for some it meant missing their SLA
>> response times. We tracked those delays down to cgroup limits, which
>> inject direct reclaim stalls into the workload where previously all
>> reclaim was handled my kswapd.
>>
>> This patch adds asynchronous reclaim to the memory.high cgroup limit
>> while keeping direct reclaim as a fallback. In our testing, this
>> eliminated all direct reclaim from the affected workload.
>>
>> memory.high has a grace buffer of about 4% between when it becomes
>> exceeded and when allocating threads get throttled. We can use the
>> same buffer for the async reclaimer to operate in. If the worker
>> cannot keep up and the grace buffer is exceeded, allocating threads
>> will fall back to direct reclaim before getting throttled.
>>
>> For irq-context, there's already async memory.high enforcement. Re-use
>> that work item for all allocating contexts, but switch it to the
>> unbound workqueue so reclaim work doesn't compete with the workload.
>> The work item is per cgroup, which means the workqueue infrastructure
>> will create at maximum one worker thread per reclaiming cgroup.
>>
>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> ---
>>   mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
>>   mm/vmscan.c     | 10 +++++++--
> This reminds me of the per-memcg kswapd proposal from LSFMM 2018
> (https://lwn.net/Articles/753162/).

Thanks for bringing this up.

>
> If I understand this correctly, the use-case is that the job instead
> of direct reclaiming (potentially in latency sensitive tasks), prefers
> a background non-latency sensitive task to do the reclaim. I am
> wondering if we can use the memory.high notification along with a new
> memcg interface (like memory.try_to_free_pages) to implement a user
> space background reclaimer. That would resolve the cpu accounting
> concerns as the user space background reclaimer can share the cpu cost
> with the task.

Actually I'm interested how you implement userspace reclaimer. Via a new 
syscall or a variant of existing syscall?

>
> One concern with this approach will be that the memory.high
> notification is too late and the latency sensitive task has faced the
> stall. We can either introduce a threshold notification or another
> notification only limit like memory.near_high which can be set based
> on the job's rate of allocations and when the usage hits this limit
> just notify the user space.

Yes, the solo purpose of background reclaimer is to avoid direct reclaim 
for latency sensitive workloads. Our in-house implementation has high 
watermark and low watermark, both of which is lower than limit or high. 
The background reclaimer would be triggered once available memory is 
reached low watermark, then keep reclaimed until available memory is 
reached high watermark. It is pretty same with how global water mark works.

>
> Shakeel

