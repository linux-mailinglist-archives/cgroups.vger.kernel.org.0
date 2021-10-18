Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08892431411
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhJRKIN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 06:08:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:49164 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhJRKIN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 Oct 2021 06:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=v4LeNmv3SwkPyguGAt7spZmFtAAdvhXagti3/HiYcJM=; b=r4Z5e0aOk/6+/4aZs
        d7663+ojeE6T0F6uJmOyL5Pz4218rmSSlZlOHAF0M1+A5jfWkm9VZQCR2reaIs6T5hlleLq2aGsdg
        /Lhhr8JbHMWL41nqvxptFCnM/ocSlQ/Z1BSsugLOrY81bJhOtJymU6dG8cwLy0kVZ+3C9JuHXUfjs
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mcPWm-006Kzj-DN; Mon, 18 Oct 2021 13:05:56 +0300
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
Message-ID: <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
Date:   Mon, 18 Oct 2021 13:05:35 +0300
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
>>
>> Partially this problem depends on one of my recent patches, disabled unlimited
>> memory allocation for dying tasks. However I think the problem can happen
>> on non-killed tasks too, for example because of kmem limit.
> 
> Could you be more specific on how this can happen without your patch? I
> have to say I haven't realized this side effect when discussing it.

We can reach obj_cgroup_charge_pages() for example via

do_user_addr_fault
handle_mm_fault
__handle_mm_fault
p4d_alloc
__p4d_alloc
p4d_alloc_one
get_zeroed_page
__get_free_pages
alloc_pages
__alloc_pages
__memcg_kmem_charge_page
obj_cgroup_charge_pages

Here we call try_charge_memcg() that return success and approve the allocation,
however then we hit into kmem limit and fail the allocation.

If required I can try to search how try_charge_memcg() can reject page allocation 
of non-dying task too.

> I will be honest that I am not really happy about pagefault_out_of_memory.
> I have tried to remove it in the past. Without much success back then,
> unfortunately[1]. 
> Maybe we should get rid of it finally. The OOM is always triggered from
> inside the allocator where we have much more infromation about the
> allocation context. A first step would be to skip pagefault_out_of_memory
> for killed or exiting processes.

I like this idea, however it may be not enough, at least in scenario described above.

> [1] I do not have msg-id so I cannot provide a lore link but google
> pointed me to https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1400402.html

Thank you, I'll read this discussion.
	Vasily Averin
