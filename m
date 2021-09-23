Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72B415873
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 08:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhIWGvd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 02:51:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:39560 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239373AbhIWGvd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 23 Sep 2021 02:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=vtROa+P4fLarhoo5zHVgaO07dFJHZ8lgd6rV14a23N4=; b=mm4NFGv1WorRzXdvb
        0fANICC/P0JNGuqguha1XOl3FMrxkIIzBvMJSgQ8zZnnDu2HTxwDLxRe7NnFrR6Xq4TES1kfjz3TK
        n2Sa4PWBllcqGfzkEBCw+TTHgQm2HluKwcynBwEyDlKHKB6tpN3mAqO4PbI9bP0hQL8okJfjtZqeY
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mTIYP-002xdr-JG; Thu, 23 Sep 2021 09:49:57 +0300
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
 <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <fa29c6f9-a53c-83bd-adcb-1e09d4387024@virtuozzo.com>
Date:   Thu, 23 Sep 2021 09:49:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/22/21 3:27 PM, Michal Hocko wrote:
> On Fri 17-09-21 11:06:49, Vasily Averin wrote:
>> Huge vmalloc allocation on heavy loaded node can lead to a global
>> memory shortage. A task called vmalloc can have the worst badness
>> and be chosen by OOM-killer, however received fatal signal and
>> oom victim mark does not interrupt allocation cycle. Vmalloc will
>> continue allocating pages over and over again, exacerbating the crisis
>> and consuming the memory freed up by another killed tasks.
>>
>> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
>> effective and avoid host panic.
>>
>> Unfortunately it is not 100% safe. Previous attempt to break vmalloc
>> cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
>> the current task is killed"") due to some vmalloc callers did not handled
>> failures properly. Found issues was resolved, however, there may
>> be other similar places.
>>
>> Such failures may be acceptable for emergencies, such as OOM. On the other
>> hand, we would like to detect them earlier. However they are quite rare,
>> and will be hidden by OOM messages, so I'm afraid they wikk have quite
>> small chance of being noticed and reported.
>>
>> To improve the detection of such places this patch also interrupts the vmalloc
>> allocation cycle for all fatal signals. The checks are hidden under DEBUG_VM
>> config option to do not break unaware production kernels.
> 
> I really dislike this. We shouldn't have a sementically different
> behavior for a debugging kernel.

Yes, you're right, thank you.

> Is there any technical reason to not do fatal_signal_pending bailout
> unconditionally? OOM victim based check will make it less likely and
> therefore any potential bugs are just hidden more. So I think we should
> really go with fatal_signal_pending check here.

I'm agree, oom_victim == fatal_signal_pending.
I'm agree that vmalloc callers should expect and handle single vnalloc failures.
I think it is acceptable to enable fatal_signal_pending check to quickly
detect such kind of iussues.
However fatal_signal_pending check can cause serial vmalloc failures
and I doubt it is acceptable. 

Rollback after failed vmalloc can call new vmalloc calls that will be failed too, 
even properly handled such serial failures can cause troubles.

Hypothetically, cancelled vmalloc called inside some filesystem's transaction
forces its rollback, that in own turn it can call own vmalloc.
Any failures on this path can break the filesystem.
I doubt it is acceptable, especially for non-OOM fatal signals.
On the other hand I cannot say that it is a 100% bug.

Another scenario:
as you know failed vmalloc calls pr_warn. According message should be sent
to remote terminal or netconsole. I'm not sure about execution context,
however if this is done in task context it may call vmalloc either in terminal
or in network subsystems. Even handled, such failures are not fatal,
but this behaviour is at least unexpected.

Should we perhaps interrupt the first vmalloc only?

>> Vmalloc uses new alloc_pages_bulk subsystem, so newly added checks can
>> affect other users of this subsystem.
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  mm/page_alloc.c | 5 +++++
>>  mm/vmalloc.c    | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index b37435c274cf..133d52e507ff 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5288,6 +5288,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>>  			continue;
>>  		}
>>  
>> +		if (tsk_is_oom_victim(current) ||
>> +		    (IS_ENABLED(CONFIG_DEBUG_VM) &&
>> +		     fatal_signal_pending(current)))
>> +			break;
> 
> This allocator interface is used in some real hot paths. It is also
> meant to be fail fast interface (e.g. it only allocates from pcp
> allocator) so it shouldn't bring any additional risk to memory depletion
> under heavy memory pressure.
> 
> In other words I do not see any reason to bail out in this code path.

Thank you for the explanation, let's drop this check at all.

Thank you,
	Vasily Averin
