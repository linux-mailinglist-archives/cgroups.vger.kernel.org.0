Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACAC408910
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhIMKgV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 06:36:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:42532 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235123AbhIMKgT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 06:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=JtnXdiyIXGAC109gjCty025cKhFakGINc+ixRMlNDpA=; b=A+qYkWFCnoHTc649z
        HHLFN2PQHVW+RQhZp5w5+2cbHQTq1eQVtFctCPop4AQ2O6l1lZR3yYepfmSnBPbrqITSivRv2+pqX
        tbp2/oezk8tLXe94ZguInAw4zdietPjN+h/L0pJm7V4tb4VC1shs+tdbXGXbVf3TZkucEPZVrYfDI
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mPjIk-001oDU-0G; Mon, 13 Sep 2021 13:35:02 +0300
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
 <YT8RjxShvfEVe4YU@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <7af26106-388c-6f99-e018-669a8f0cf9b5@virtuozzo.com>
Date:   Mon, 13 Sep 2021 13:35:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT8RjxShvfEVe4YU@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/21 11:53 AM, Michal Hocko wrote:
> On Fri 10-09-21 15:39:28, Vasily Averin wrote:
>> The kernel currently allows dying tasks to exceed the memcg limits.
>> The allocation is expected to be the last one and the occupied memory
>> will be freed soon.
>> This is not always true because it can be part of the huge vmalloc
>> allocation. Allowed once, they will repeat over and over again.
>> Moreover lifetime of the allocated object can differ from
>> In addition the lifetime of the dying task.
>> Multiple such allocations running concurrently can not only overuse
>> the memcg limit, but can lead to a global out of memory and,
>> in the worst case, cause the host to panic.
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  mm/memcontrol.c | 23 +++++------------------
>>  1 file changed, 5 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 389b5766e74f..67195fcfbddf 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1834,6 +1834,9 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>>  		return OOM_ASYNC;
>>  	}
>>  
>> +	if (should_force_charge())
>> +		return OOM_SKIPPED;
> 
> mem_cgroup_out_of_memory already check for the bypass, now you are
> duplicating that check with a different answer to the caller. This is
> really messy. One of the two has to go away.

In this case mem_cgroup_out_of_memory() takes locks and mutexes but doing nothing
useful and its success causes try_charge_memcg() to repeat the loop unnecessarily.

I cannot change mem_cgroup_out_of_memory internals, because it is used in other places too.The check inside mem_cgroup_out_of_memory is required because situation can be changed after
check added into mem_cgroup_oom().

Though I got your argument, and will think how to improve the patch.
Anyway we'll need to do something with name of should_force_charge() function
that will NOT lead to forced charge.

Thank you,
	Vasily Averin

Thank you,
