Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242F268C94
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgINNwn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 09:52:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51723 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgINNwW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600091494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu/1GHUDf4AcKJWnq4PI0AJl4nVdBvz984mVLLa8XWI=;
        b=FXur+oHttylqzUUIdyCox9+t9no2W5Hg02/O1KZXBXsILmO/f8dvL+me4gbOKYXRLPA6S0
        FNC7RyrknDa9olelUdO6SZObUVpBpT1Wp9XKxhKTYssqyHzU+b62i9HrETu+pM1fux/Xzk
        qzc4SLOTz7r/GR3xXBRWzEJyrmlNE00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-FShcX2-SMQ2YvK_dh2FRxA-1; Mon, 14 Sep 2020 09:51:30 -0400
X-MC-Unique: FShcX2-SMQ2YvK_dh2FRxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479C884F227;
        Mon, 14 Sep 2020 13:51:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-85.rdu2.redhat.com [10.10.118.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85011002D60;
        Mon, 14 Sep 2020 13:51:26 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200914024452.19167-1-longman@redhat.com>
 <20200914024452.19167-3-longman@redhat.com>
 <20200914114825.GM16999@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e8ddc443-b56a-1dd6-6d41-ad217e9aea80@redhat.com>
Date:   Mon, 14 Sep 2020 09:51:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200914114825.GM16999@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/14/20 7:48 AM, Michal Hocko wrote:
> On Sun 13-09-20 22:44:51, Waiman Long wrote:
>> The mem_cgroup_get_max() function used to get memory+swap max from
>> both the v1 memsw and v2 memory+swap page counters & return the maximum
>> of these 2 values. This is redundant and it is more efficient to just
>> get either the v1 or the v2 values depending on which one is currently
>> in use.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 20 +++++++++-----------
>>   1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8c74f1200261..ca36bed588d1 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1633,17 +1633,15 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>>    */
>>   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>>   {
>> -	unsigned long max;
>> -
>> -	max = READ_ONCE(memcg->memory.max);
>> -	if (mem_cgroup_swappiness(memcg)) {
>> -		unsigned long memsw_max;
>> -		unsigned long swap_max;
>> -
>> -		memsw_max = memcg->memsw.max;
>> -		swap_max = READ_ONCE(memcg->swap.max);
>> -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
>> -		max = min(max + swap_max, memsw_max);
>> +	unsigned long max = READ_ONCE(memcg->memory.max);
>> +
>> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>> +		if (mem_cgroup_swappiness(memcg))
>> +			max += min(READ_ONCE(memcg->swap.max),
>> +				   (unsigned long)total_swap_pages);
>> +	} else { /* v1 */
>> +		if (mem_cgroup_swappiness(memcg))
>> +			max = memcg->memsw.max;
> I agree that making v1 vs. v2 distinction here makes the code more
> obvious. But I do not think your code is correct for v1. In a default
> state it would lead to max = PAGE_COUNTER_MAX which is not something
> we want, right?
>
> instead you want
> 		max += min(READ_ONCE(memcg->memsw.max), total_swap_pages);
>
You are right, it is a bit tricky for v1.

I will change it to

     max += min(READ_ONCE(memcg->memsw.max) - max, total_swap_pages):

Thanks,
Longman

