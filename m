Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4065C42A286
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhJLKpI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 06:45:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:44362 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbhJLKpH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 Oct 2021 06:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=bEbXgNx8UNhTNiQSVrQ+7EoBtCdD7MvBGkcwxGWc4cs=; b=SmT2sdTNW0HEqxE0m
        moILfvR4WUkRN/qJdfdiDnBRMRXGquRZAofXgF5d54Zzkt1ln9tBN8XPALEk1iDBhHy8erFkLJ9Bo
        WnQyYEjYw1xSV/QWTN12zef+4kbJJVBsuatmIdz3aKFLQvIc7iGUuzKemcaf9gjg/k06zn9PtE2KM
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1maFFO-005nHz-Qb; Tue, 12 Oct 2021 13:43:02 +0300
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
 <29155011-f884-b0e5-218e-911039568acb@suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
Date:   Tue, 12 Oct 2021 13:42:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <29155011-f884-b0e5-218e-911039568acb@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 08.10.2021 14:47, Vlastimil Babka wrote:
> On 10/8/21 11:24, Vasily Averin wrote:
>> __alloc_pages_bulk can call __count_zid_vm_events and zone_statistics
>> with nr_account = 0.
> 
> But that's not a bug, right? Just an effective no-op that's not commonly
> happening, so is it worth the check?

Why not?

Yes, it's not a bug, it just makes the kernel a bit more efficient in a very unlikely case.
However, it looks strange and makes uninformed code reviewers like me worry about possible
problems inside the affected functions. No one else calls these functions from 0.
 
>> Fixes: 3e23060b2d0b ("mm/page_alloc: batch the accounting updates in the bulk allocator")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  mm/page_alloc.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 602819a232e5..e67113452ee8 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5364,9 +5364,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>>  	}
>>  
>>  	local_unlock_irqrestore(&pagesets.lock, flags);
>> -
>> -	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>> -	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
>> +	if (nr_account) {
>> +		__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>> +		zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
>> +	}
>>  	if (objcg)
>>  		memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
>>  
>>
> 

