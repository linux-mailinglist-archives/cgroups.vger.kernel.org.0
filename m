Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7144384E2
	for <lists+cgroups@lfdr.de>; Sat, 23 Oct 2021 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJWTSH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Oct 2021 15:18:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:39782 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhJWTSH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 23 Oct 2021 15:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=ZuyZvSB+IWaABIIMJw/ofGXgNTuvJPGvRG6ORPX+xCg=; b=b7Oxo3QFYkhUf1+aI
        vPwuGhnkZ+uxt4WvbR2ObgwJZxJp6oCuOj7RZTnquMghZb9hiJEd6Azb67tU4KnhnbHCdu13JAlWW
        V4CxHMXB7c6kmU4Y6+2LRBdsC8J1Dt4hpk+dSis16Zs/lGfAdZFoHZ4NqP8QqfBE8tFluHxwv7UMU
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1meMUX-006wTn-2M; Sat, 23 Oct 2021 22:15:41 +0300
Subject: Re: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from
 the #PF
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
 <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <5038ff2f-7358-80df-8167-3449c1a540fe@virtuozzo.com>
Date:   Sat, 23 Oct 2021 22:15:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 23.10.2021 18:01, Tetsuo Handa wrote:
> On 2021/10/23 22:20, Vasily Averin wrote:
>>  /*
>> - * The pagefault handler calls here because it is out of memory, so kill a
>> - * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
>> - * killing is already in progress so do nothing.
>> + * The pagefault handler calls here because some allocation has failed. We have
>> + * to take care of the memcg OOM here because this is the only safe context without
>> + * any locks held but let the oom killer triggered from the allocation context care
>> + * about the global OOM.
>>   */
> 
> Excuse me for a stupid question. I consider
> 
>   if (!mutex_trylock(&oom_lock))
>     return;
>   out_of_memory(&oc);
>   mutex_unlock(&oom_lock);
> 
> here as the last resort (safeguard) when neither __alloc_pages_may_oom()
> nor mem_cgroup_out_of_memory() can make progress. This patch says
> 
>   let the oom killer triggered from the allocation context care
>   about the global OOM.
> 
> but what if the OOM killer cannot be invoked from the allocation context?
> Is there a guarantee that all memory allocations which might result in
> VM_FAULT_OOM can invoke the OOM killer?

I don't think this question is stupid, since I asked it myself :)
You can find this discussion here:
https://lkml.org/lkml/2021/10/21/900

Let me quote it here too
:> 1) VM_FAULT_OOM may be triggered w/o execution of out_of_memory()
:> for exampel it can be caused by incorrect vm fault operations, 
:> (a) which can return this error without calling allocator at all.
:
:I would argue this to be a bug. How can that particular code tell
:whether the system is OOM and the oom killer is the a reasonable measure
:to take?
:
:> (b) or which can provide incorrect gfp flags and allocator can fail without execution of out_of_memory.
:
: I am not sure I can see any sensible scenario where pagefault oom killer
: would be an appropriate fix for that.
:
:> (c) This may happen on stable/LTS kernels when successful allocation was failed by hit into limit of legacy memcg-kmem contoller.
:> We'll drop it in upstream kernels, however how to handle it in old kenrels?
:
:Triggering the global oom killer for legacy kmem charge failure is
:clearly wrong. Removing oom killer from #PF would fix that problem.

I would note: (c) is not theoretical but real life problem, in this case allocation was failed without execution of OOM,
however, it is in this case that execution out_of_memory() from pagefault_out_of_memory() leads to a disaster.

Thank you,
	Vasily Averin
