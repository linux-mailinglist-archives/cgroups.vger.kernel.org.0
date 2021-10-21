Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01BD435C91
	for <lists+cgroups@lfdr.de>; Thu, 21 Oct 2021 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJUIG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Oct 2021 04:06:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:43262 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhJUIG0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 21 Oct 2021 04:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=nC/QVr0jtd67Au3q+jnUAluZhpYLLVaIrvqIUdLTEDo=; b=Wtw08hMyX+W4NLre+
        n9xyyyWTQ+7yVckdtj4NgGGt3H07Uadf+aq/kXQ0s9YmKasnSl8h0WaWckzAzJbaxdJDikq3o2EtK
        PjakBSQeCbhcuQsyynQ5dQ/mJmVCGoPXQEHuzCe+/lntmiujD0qXlJrOGynXblB6Roux8XZG5w2DY
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdT3V-006gm0-IB; Thu, 21 Oct 2021 11:04:05 +0300
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <496ed57e-61c6-023a-05fd-4ef21b0294cf@virtuozzo.com>
Date:   Thu, 21 Oct 2021 11:03:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 18.10.2021 12:04, Michal Hocko wrote:
> On Mon 18-10-21 11:13:52, Vasily Averin wrote:
> [...]
>> How could this happen?
>>
>> User-space task inside the memcg-limited container generated a page fault,
>> its handler do_user_addr_fault() called handle_mm_fault which could not
>> allocate the page due to exceeding the memcg limit and returned VM_FAULT_OOM.
>> Then do_user_addr_fault() called pagefault_out_of_memory() which executed
>> out_of_memory() without set of memcg.

> I will be honest that I am not really happy about pagefault_out_of_memory.
> I have tried to remove it in the past. Without much success back then,
> unfortunately[1]. 
> 
> [1] I do not have msg-id so I cannot provide a lore link but google
> pointed me to https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1400402.html

I re-read this discussion and in general I support your position.
As far as I understand your opponents cannot explain why "random kill" is mandatory here,
they are just afraid that it might be useful here and do not want to remove it completely.

Ok, let's allow him to do it. Moreover I'm ready to keep it as default behavior.

However I would like to have some choice in this point.

In general we can:
- continue to use "random kill" and rely on the wisdom of the ancestors.
- do nothing, repeat #PF and rely on fate: "nothing bad will happen if we do it again".
- add some (progressive) killable delay, rely on good will of (unkillable) neighbors and wait for them to release required memory.
- mark the current task as cycled in #PF and somehow use this mark in allocator
- make sure that the current task is really cycled, have no progress, send him fatal signal to kill it and break the cycle.
- implement any better ideas,
- use any combination of previous points

We can select required strategy for example via sysctl.

For me "random kill" is worst choice, 
Why can't we just kill the looped process instead?
It can be marked as oom-unkillable, so OOM-killer was unable to select it.
However I doubt it means "never kill it", for me it is something like "last possible victim" priority.

Thank you,
	Vasily Averin
