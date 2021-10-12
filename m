Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAA142AC53
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhJLStd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Oct 2021 14:49:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:43718 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhJLStd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 Oct 2021 14:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=64IcsFb8bBS4pFgFI9KVjfapZy7rEeNKQF8dCkvviYY=; b=pcmeKt+OWhafIWGl+
        Rsq0UqWHt6l2z4rGEpWKXORZXiSDMKTtmftnTOedW5rwjcVI2qepA2vleNRBTivfqynFbNdjJVz9i
        rxsu0SoUkl2/uSmisuOWf21E9oDhshP6OrjfrNC1n8SV04Qxku1PBM1OKoscx4JNdBmVKnrZn6siY
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1maMml-005pmF-PE; Tue, 12 Oct 2021 21:45:59 +0300
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in
 __alloc_pages_bulk
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
 <YWWrai/ChIgycgCo@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <3467508f-0f0f-fc28-c973-ad9f0eeb9818@virtuozzo.com>
Date:   Tue, 12 Oct 2021 21:45:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWWrai/ChIgycgCo@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12.10.2021 18:36, Michal Hocko wrote:
> On Tue 12-10-21 17:58:21, Vasily Averin wrote:
>> Enable memory accounting for bulk page allocator.
> 
> ENOCHANGELOG
>  
> And I have to say I am not very happy about the solution. It adds a very
> tricky code where it splits different charging steps apart.
> 
> Would it be just too inefficient to charge page-by-page once all pages
> are already taken away from the pcp lists? This bulk should be small so
> this shouldn't really cause massive problems. I mean something like
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..8bcd69195ef5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  
> +	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
> +		/* charge pages here */
> +	}
> +
>  	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>  	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> 

In general it looks like we can do it.

We can traverse via filled page_array or page_list.
For page_array we need to check is the page already accounted 
(incoming array can contain some pages already, both in the beginning and in middle)
For each taken page we can try to charge it.
If it was charges successfully -- we will process next page in list/array.
When charge fails we need to remove rest of pages from list/array and somehow release them. 
At present I do not understand how to do it correctly -- perhaps just call free_page() ?
Finally, we'll need to adjust nr_account and nr_populated properly.

I'll try to implement this tomorrow.

Thank you,
	Vasily Averin
