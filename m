Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4A434F42
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTPtk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 11:49:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:36086 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPth (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 11:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=ttAK6Gqf/TyX+MT4z0DPfUPRY7KYPOn3puccc9GorZE=; b=rqfgh5Q5comYze+CV
        u0HaVR5J9Mkytg6GHPvR91X3KbZesnUGemY2IC41F4dwNhVLm/NOsEkGzpwcriwMuNZ7lJejaVELX
        b5i5NPD2PCdADzCdMFoT5B+yheZly9Hk9agPrNnFVoHi05+aHXdAtXu+to+93VWpX8rGNeY3SvlLI
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdDoE-006cn0-HO; Wed, 20 Oct 2021 18:47:18 +0300
Subject: Re: [PATCH memcg 3/3] memcg: handle memcg oom failures
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
 <YXATW7KsUZzbbGHy@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <d3b32c72-6375-f755-7599-ab804719e1f6@virtuozzo.com>
Date:   Wed, 20 Oct 2021 18:46:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXATW7KsUZzbbGHy@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 20.10.2021 16:02, Michal Hocko wrote:
> On Wed 20-10-21 15:14:27, Vasily Averin wrote:
>> mem_cgroup_oom() can fail if current task was marked unkillable
>> and oom killer cannot find any victim.
>>
>> Currently we force memcg charge for such allocations,
>> however it allow memcg-limited userspace task in to overuse assigned limits
>> and potentially trigger the global memory shortage.
> 
> You should really go into more details whether that is a practical
> problem to handle. OOM_FAILED means that the memcg oom killer couldn't
> find any oom victim so it cannot help with a forward progress. There are
> not that many situations when that can happen. Naming that would be
> really useful.

I've pointed above: 
"if current task was marked unkillable and oom killer cannot find any victim."
This may happen when current task cannot be oom-killed because it was marked
unkillable i.e. it have p->signal->oom_score_adj == OOM_SCORE_ADJ_MIN
and other processes in memcg are either dying, or are kernel threads or are marked unkillable 
by the same way. Or when memcg have this process only.

If we always approve such kind of allocation, it can be misused.
Process can mmap a lot of memory,
ant then touch it and generate page fault and make overcharged memory allocations.
Finally it can consume all node memory and trigger global memory shortage on the host.

>> Let's fail the memory charge in such cases.
>>
>> This failure should be somehow recognised in #PF context,
> 
> explain why

When #PF cannot allocate memory (due to reason described above), handle_mm_fault returns VM_FAULT_OOM,
then its caller executes pagefault_out_of_memory(). If last one cannot recognize the real reason of this fail,
it expect it was global memory shortage and executed global out_ouf_memory() that can kill random process 
or just crash node if sysctl vm.panic_on_oom is set to 1.

Currently pagefault_out_of_memory() knows about possible async memcg OOM and handles it correctly.
However it is not aware that memcg can reject some other allocations, do not recognize the fault
as memcg-related and allows to run global OOM.

>> so let's use current->memcg_in_oom == (struct mem_cgroup *)OOM_FAILED
>>
>> ToDo: what is the best way to notify pagefault_out_of_memory() about 
>>     mem_cgroup_out_of_memory failure ?
> 
> why don't you simply remove out_of_memory from pagefault_out_of_memory
> and leave it only with the blocking memcg OOM handling? Wouldn't that be a
> more generic solution? Your first patch already goes that way partially.

I clearly understand that global out_of_memory should not be trggired by memcg restrictions.
I clearly understand that dying task will release some memory soon and we can do not run global oom if current task is dying.

However I'm not sure that I can remove out_of_memory at all. At least I do not have good arguments to do it.

> This change is more risky than the first one. If somebody returns
> VM_FAULT_OOM without invoking allocator then it can loop for ever but
> invoking OOM killer in such a situation is equally wrong as the oom
> killer cannot really help, right?

I'm not ready to comment this right now and take time out to think about.

Thank you,
	Vasily Averin
