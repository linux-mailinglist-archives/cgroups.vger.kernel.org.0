Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBF414194
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhIVGT7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 02:19:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:43430 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232627AbhIVGT5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 22 Sep 2021 02:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=kKOaxfW8XB27athhg5MSO4zSrJCF13FJZud0x020yE8=; b=IHdKcPfUPcD6gzlte
        oJgaZ+oyFAcfYtjMjvklvMzm5jQS4DtCDM0LlYM5w9D6naqxNoSSahSKPvMVS4juqoA91FoVEkznB
        cDzBYB6U1kH2Qdy2Jm6UnAKEWVom8SxyCBNxI9wF++kxzdIFPCmmAxZTZY1o/Fj6aFsZSciLhCYL0
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mSvaI-002n84-BQ; Wed, 22 Sep 2021 09:18:22 +0300
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
 <20210919163126.431674722b8db218453dc18c@linux-foundation.org>
 <bb5616b0-faa6-e12a-102b-b9c402e27ec1@i-love.sakura.ne.jp>
 <c9d43874-138e-54a9-3222-a08c269eeeb5@virtuozzo.com>
 <20210921115523.8606cea0b2f0a5ca4e79cbd0@linux-foundation.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <9eb3d50d-9777-087d-eee8-36573f32cf14@virtuozzo.com>
Date:   Wed, 22 Sep 2021 09:18:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921115523.8606cea0b2f0a5ca4e79cbd0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/21/21 9:55 PM, Andrew Morton wrote:
> On Mon, 20 Sep 2021 13:59:35 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:
> 
>> On 9/20/21 4:22 AM, Tetsuo Handa wrote:
>>> On 2021/09/20 8:31, Andrew Morton wrote:
>>>> On Fri, 17 Sep 2021 11:06:49 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:
>>>>
>>>>> Huge vmalloc allocation on heavy loaded node can lead to a global
>>>>> memory shortage. A task called vmalloc can have the worst badness
>>>>> and be chosen by OOM-killer, however received fatal signal and
>>>>> oom victim mark does not interrupt allocation cycle. Vmalloc will
>>>>> continue allocating pages over and over again, exacerbating the crisis
>>>>> and consuming the memory freed up by another killed tasks.
>>>>>
>>>>> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
>>>>> effective and avoid host panic.
>>>>>
>>>>> Unfortunately it is not 100% safe. Previous attempt to break vmalloc
>>>>> cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
>>>>> the current task is killed"") due to some vmalloc callers did not handled
>>>>> failures properly. Found issues was resolved, however, there may
>>>>> be other similar places.
>>>>
>>>> Well that was lame of us.
>>>>
>>>> I believe that at least one of the kernel testbots can utilize fault
>>>> injection.  If we were to wire up vmalloc (as we have done with slab
>>>> and pagealloc) then this will help to locate such buggy vmalloc callers.
>>
>> Andrew, could you please clarify how we can do it?
>> Do you mean we can use exsiting allocation fault injection infrastructure to trigger
>> such kind of issues? Unfortunately I found no ways to reach this goal.
>> It  allows to emulate single faults with small probability, however it is not enough,
>> we need to completely disable all vmalloc allocations. 
> 
> I don't see why there's a problem?  You're saying "there might still be
> vmalloc() callers which don't correctly handle allocation failures",
> yes?
> 
> I'm suggesting that we use fault injection to cause a small proportion
> of vmalloc() calls to artificially fail, so such buggy callers will
> eventually be found and fixed.  Why does such a scheme require that
> *all* vmalloc() calls fail?

Let me explain.
1) it is not trivial to use current allocation fault injection to cause
a small proportion of vmalloc() calls to artificially fail.

vmalloc
 __vmalloc_node
  __vmalloc_node_range
   __vmalloc_area_node
    vm_area_alloc_pages
 
vm_area_alloc_pages uses new __alloc_pages_bulk subsystem, requesting up to 100 pages in cycle.
__alloc_pages_bulk() can be interrupted by allocation fault injection, however in this case
vm_area_alloc_pages() will failback to old-style page allocation cycle.
In general case it successfully finishes allocation and vmalloc itself will not fail.

To fail vmalloc we need to fail both alloc_pages_bulk_array_node() and alloc_pages_node() together.

2) if we failed single vmalloc it is not enough.
I would remind, we want to emulate fatal signal reaction.
However I afraid dying task can execute a quite complex rollback procedure.
This rollback can call another vmalloc and last one will be failed
again on fatal_signal_pending check.

To emulate this behavior in fault injection we need to disable all following
vmalloc calls of our victim, pseudo-"dying" task.

I doubt both these goals can be reached by current allocation fault injection subsystem,
I do not understand how to configure it accordingly.

Thank you,
	Vasily Averin
