Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D931408866
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhIMJjR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 05:39:17 -0400
Received: from relay.sw.ru ([185.231.240.75]:36190 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238675AbhIMJjQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 05:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=TkHNL+ib7NjPWsL57OO6zVdK+l/V7nLiS/zl/t9RNEE=; b=mJMKaH5Pr/TTWXM+k
        BEesbC+Nhe8eaboiOWdPHcU5U96lxPEXpN9qBs6mIIhOBWJukn/dMrao3+jSik9NoiDCJ433lNL1D
        iFTCZhUdXvw3FbwiTF/L4rZS0qQBqAMcRAEKv7t/zgTypsrXOeHh8j3HVW0/bYC89sjznMxIt5Pyg
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mPiPV-001nw1-Lj; Mon, 13 Sep 2021 12:37:57 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <8b98d44a-aeb2-5f5f-2545-ac2bd0c7049b@virtuozzo.com>
 <YT8OTozT3FN9P2k7@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <b4b1e66e-e6e6-84e9-46a1-060ed412dd56@virtuozzo.com>
Date:   Mon, 13 Sep 2021 12:37:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT8OTozT3FN9P2k7@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/21 11:39 AM, Michal Hocko wrote:
> On Mon 13-09-21 10:51:37, Vasily Averin wrote:
>> On 9/10/21 3:39 PM, Vasily Averin wrote:
>>> The kernel currently allows dying tasks to exceed the memcg limits.
>>> The allocation is expected to be the last one and the occupied memory
>>> will be freed soon.
>>> This is not always true because it can be part of the huge vmalloc
>>> allocation. Allowed once, they will repeat over and over again.
>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 389b5766e74f..67195fcfbddf 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2622,15 +2625,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>  	if (gfp_mask & __GFP_ATOMIC)
>>>  		goto force;
>>>  
>>> -	/*
>>> -	 * Unlike in global OOM situations, memcg is not in a physical
>>> -	 * memory shortage.  Allow dying and OOM-killed tasks to
>>> -	 * bypass the last charges so that they can exit quickly and
>>> -	 * free their memory.
>>> -	 */
>>> -	if (unlikely(should_force_charge()))
>>> -		goto force;
>>> -
>>
>> Should we keep current behaviour for (current->flags & PF_EXITING) case perhaps?
> 
> Why?

On this stage task really dies and mostly releases taken resources.
It can allocate though, and this allocation can reach memcg limit due to the activity
of parallel memcg threads.

Noting bad should happen if we reject this allocation,
because the same thing can happen in non-memcg case too.
However I doubt misuse is possible here and we have possibility to allow graceful shutdown here.

In other words: we are not obliged to allow such allocations, but we CAN do it because
we hope that it is safe and cannot be misused.

>> It is set inside do_exit only and (I hope) cannot trigger huge vmalloc allocations.
> 
> Allocations in this code path should be rare but it is not like they are
> non-existent. This is rather hard to review area spread at many places
> so if we are deciding to make the existing model simpler (no bypassing)
> then I would rather have no exceptions unless they are reaaly necessary
> and document them if they are.

Thank you,
	vasily Averin
