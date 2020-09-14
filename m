Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC608268EB7
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 17:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgINO7G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 10:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbgINO64 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 10:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600095533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4EylP6DiiMU0xDyOAgmGkadg42XWec7eelWwk0KDc0=;
        b=U4O43qvkXPYTROsY7lhCsI8k3Z06Bjl18l9j5hcG2s+GmjCtPRencgt7LFq+rEzdM2cVgr
        VaAvtN43U+/v+I0S7fnE2xnT2T0LW5+Tx4uhRfNSexqYJqL6850/F8OCm1nFQUmUJJqu1+
        bM2omEBNjYmch12GW+RG5ss2xKf2EGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-kbpRmOvBMeOFddDEB9xAAg-1; Mon, 14 Sep 2020 10:58:49 -0400
X-MC-Unique: kbpRmOvBMeOFddDEB9xAAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A848189E62E;
        Mon, 14 Sep 2020 14:58:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-85.rdu2.redhat.com [10.10.118.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF18C5DA60;
        Mon, 14 Sep 2020 14:58:45 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] mm/memcg: Simplify mem_cgroup_get_max()
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
 <20200914141955.2145-1-longman@redhat.com>
 <20200914144739.GV16999@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <24d1cfe4-845e-0944-4187-217d345d59a5@redhat.com>
Date:   Mon, 14 Sep 2020 10:58:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200914144739.GV16999@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/14/20 10:47 AM, Michal Hocko wrote:
> On Mon 14-09-20 10:19:55, Waiman Long wrote:
>> The mem_cgroup_get_max() function used to get memory+swap max from
>> both the v1 memsw and v2 memory+swap page counters & return the maximum
>> of these 2 values. This is redundant and it is more efficient to just
>> get either the v1 or the v2 values depending on which one is currently
>> in use.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8c74f1200261..2331d4bc7c4d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1633,17 +1633,19 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
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
>> +		if (mem_cgroup_swappiness(memcg)) {
>> +			unsigned long memsw = READ_ONCE(memcg->memsw.max);
>> +
>> +			if (memsw > max)
>> +				max += min(memsw - max, (unsigned long)total_swap_pages);
> Yes this looks better. But, memsw can never be smaller than the hard
> limit (mem_cgroup_resize_max). I would find it slightly easier to
> understand if you did
> 	/* calculate swap excess capacity from memsw limit*/
> 	unsigned long memsw = READ_ONCE(memcg->memsw.max) - max;
> 	max += min (memsw, total_swap_pages);

Right, I thought it was possible to set memsw lower than mem. It was not 
allowed. So the extra check is unnecessary. Will fix that.

Cheers,
Longman

