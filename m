Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDC268235
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINAtK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 20:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgINAtK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 20:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600044548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghr5orKu6aikpqEdskdLQXzPfKKUxCEDmVqKYdI6iBc=;
        b=Db4r1fsbMeurLK7ZCzijTrbMdXRwu/wX16hK1nzXGaHlI63AJ12f7jCZSqTl/FoqkknGQW
        MQYafmcaacFwrS9gxocM6sg686cIYHRwmEs2ZEIgxA4qUb9IQCTNR1euOcdUV+kbNE9MrB
        EwlJpfM67n/ArJMMmOYIkYfe8FzdCBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-gFHhDZXQMyGmwnYw-_oZFw-1; Sun, 13 Sep 2020 20:49:05 -0400
X-MC-Unique: gFHhDZXQMyGmwnYw-_oZFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB18425CB;
        Mon, 14 Sep 2020 00:49:03 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-90.rdu2.redhat.com [10.10.113.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D919F60BF3;
        Mon, 14 Sep 2020 00:49:01 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-3-longman@redhat.com>
 <20200820173546.GB912520@cmpxchg.org>
 <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
 <CALvZod6GARMuO8YzMp-1FZaasSZJ8t2b9dUu5tXUcDeuHxA6KA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <73bab001-b819-1e6d-e130-c52ae2206f19@redhat.com>
Date:   Sun, 13 Sep 2020 20:49:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALvZod6GARMuO8YzMp-1FZaasSZJ8t2b9dUu5tXUcDeuHxA6KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/20/20 5:25 PM, Shakeel Butt wrote:
> On Thu, Aug 20, 2020 at 1:29 PM Waiman Long <longman@redhat.com> wrote:
>> On 8/20/20 1:35 PM, Johannes Weiner wrote:
>>> On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
>>>> The mem_cgroup_get_max() function used to get memory+swap max from
>>>> both the v1 memsw and v2 memory+swap page counters & return the maximum
>>>> of these 2 values. This is redundant and it is more efficient to just
>>>> get either the v1 or the v2 values depending on which one is currently
>>>> in use.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    mm/memcontrol.c | 14 +++++---------
>>>>    1 file changed, 5 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 26b7a48d3afb..d219dca5239f 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>>>>     */
>>>>    unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>>>>    {
>>>> -    unsigned long max;
>>>> +    unsigned long max = READ_ONCE(memcg->memory.max);
>>>>
>>>> -    max = READ_ONCE(memcg->memory.max);
>>>>       if (mem_cgroup_swappiness(memcg)) {
>>>> -            unsigned long memsw_max;
>>>> -            unsigned long swap_max;
>>>> -
>>>> -            memsw_max = memcg->memsw.max;
>>>> -            swap_max = READ_ONCE(memcg->swap.max);
>>>> -            swap_max = min(swap_max, (unsigned long)total_swap_pages);
>>>> -            max = min(max + swap_max, memsw_max);
>>>> +            if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>>> +                    max += READ_ONCE(memcg->swap.max);
>>>> +            else
>>>> +                    max = memcg->memsw.max;
>>> I agree with the premise of the patch, but v1 and v2 have sufficiently
>>> different logic, and the way v1 overrides max from the innermost
>>> branch again also doesn't help in understanding what's going on.
>>>
>>> Can you please split out the v1 and v2 code?
>>>
>>>        if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>>>                max = READ_ONCE(memcg->memory.max);
>>>                if (mem_cgroup_swappiness(memcg))
>>>                        max += READ_ONCE(memcg->swap.max);
>>>        } else {
>>>                if (mem_cgroup_swappiness(memcg))
>>>                        max = memcg->memsw.max;
>>>                else
>>>                        max = READ_ONCE(memcg->memory.max);
>>>        }
>>>
>>> It's slightly repetitive, but IMO much more readable.
>>>
>> Sure. That makes it even better.
>>
> Can you please also add in the commit message why it is ok to drop
> total_swap_pages comparison from mem_cgroup_get_max()?
>
My bad. I accidentally skipped the total_swap_pages check. Will add it 
back in v2.

Cheers,
Longman

