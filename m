Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EC24C6C0
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHTU3h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 16:29:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728353AbgHTU3h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 16:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597955375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqTEDMhBKHUNdE/xOyKTnipumO1ldzx6XH3nmOiyvQQ=;
        b=UqoHrxDCUmVGNuNcjX3y5BjoF2tgaUImBNGrCwRDViVBs1s+5iIBRSrF/O1JyDobx4q+jy
        mWDSWtxy/fxtSQQ5ceNPpEYMhtSphwX0pWk+VxmYfbJa1fQRChKqY6UEQmdBcveqGtVYVK
        MR5QQexJ+YsFvOghE+dWdSRs9Mg43Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-EUGSS4-LNaCluMQg0kLEHw-1; Thu, 20 Aug 2020 16:29:31 -0400
X-MC-Unique: EUGSS4-LNaCluMQg0kLEHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CF364080;
        Thu, 20 Aug 2020 20:29:29 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.10.115.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE10039A55;
        Thu, 20 Aug 2020 20:29:27 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-3-longman@redhat.com>
 <20200820173546.GB912520@cmpxchg.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
Date:   Thu, 20 Aug 2020 16:29:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200820173546.GB912520@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/20/20 1:35 PM, Johannes Weiner wrote:
> On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
>> The mem_cgroup_get_max() function used to get memory+swap max from
>> both the v1 memsw and v2 memory+swap page counters & return the maximum
>> of these 2 values. This is redundant and it is more efficient to just
>> get either the v1 or the v2 values depending on which one is currently
>> in use.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 26b7a48d3afb..d219dca5239f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>>    */
>>   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>>   {
>> -	unsigned long max;
>> +	unsigned long max = READ_ONCE(memcg->memory.max);
>>   
>> -	max = READ_ONCE(memcg->memory.max);
>>   	if (mem_cgroup_swappiness(memcg)) {
>> -		unsigned long memsw_max;
>> -		unsigned long swap_max;
>> -
>> -		memsw_max = memcg->memsw.max;
>> -		swap_max = READ_ONCE(memcg->swap.max);
>> -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
>> -		max = min(max + swap_max, memsw_max);
>> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>> +			max += READ_ONCE(memcg->swap.max);
>> +		else
>> +			max = memcg->memsw.max;
> I agree with the premise of the patch, but v1 and v2 have sufficiently
> different logic, and the way v1 overrides max from the innermost
> branch again also doesn't help in understanding what's going on.
>
> Can you please split out the v1 and v2 code?
>
> 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> 		max = READ_ONCE(memcg->memory.max);
> 		if (mem_cgroup_swappiness(memcg))
> 			max += READ_ONCE(memcg->swap.max);
> 	} else {
> 		if (mem_cgroup_swappiness(memcg))
> 			max = memcg->memsw.max;
> 		else
> 			max = READ_ONCE(memcg->memory.max);
> 	}
>
> It's slightly repetitive, but IMO much more readable.
>
Sure. That makes it even better.

Cheers,
Longman

