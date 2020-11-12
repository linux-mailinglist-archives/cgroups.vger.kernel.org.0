Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA16E2B03C9
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKLLYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 06:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKLLYU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 12 Nov 2020 06:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D0F0AF0D;
        Thu, 12 Nov 2020 11:24:18 +0000 (UTC)
Subject: Re: [PATCH v21 14/19] mm/lru: introduce TestClearPageLRU
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-15-git-send-email-alex.shi@linux.alibaba.com>
 <b4c08619-d365-bbaf-de08-9b2495a0a8d8@suse.cz>
 <alpine.LSU.2.11.2011111729350.2174@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <057bb8c8-3993-5638-42e9-f58d72f21b9e@suse.cz>
Date:   Thu, 12 Nov 2020 12:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2011111729350.2174@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/12/20 3:03 AM, Hugh Dickins wrote:
> On Wed, 11 Nov 2020, Vlastimil Babka wrote:
>> On 11/5/20 9:55 AM, Alex Shi wrote:
>> 
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -1542,7 +1542,7 @@ unsigned int reclaim_clean_pages_from_list(struct
>> > zone *zone,
>> >    */
>> >   int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>> >   {
>> > -	int ret = -EINVAL;
>> > +	int ret = -EBUSY;
>> >     	/* Only take pages on the LRU. */
>> >   	if (!PageLRU(page))
>> > @@ -1552,8 +1552,6 @@ int __isolate_lru_page(struct page *page,
>> > isolate_mode_t mode)
>> >   	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
>> >   		return ret;
>> >   -	ret = -EBUSY;
>> 
>> I'm not sure why this change is here, looks unrelated to the patch?
>> 
>> Oh I see, you want to prevent the BUG() in isolate_lru_pages().
> 
> Yes, I suggested this part of the patch to Alex, when I hit that BUG().
> 
>> 
>> But due to that, the PageUnevictable check was also affected unintentionally.
>> But I don't think it's that important to BUG() when we run into
>> PageUnevictable unexpectedly, so that's probably ok.
> 
> Not unintentional.  __isolate_lru_page(), or __isolate_lru_page_prepare(),
> is a silly function, used by two callers whose requirements are almost
> entirely disjoint.  The ISOLATE_UNEVICTABLE case is only for compaction.c,
> which takes no interest in -EINVAL versus -EBUSY, and has no such BUG().
> 
> I think it dates back to lumpy reclaim days, and it probably made more
> sense back then.

Ah, thanks for explaining.


>> 
>> But with that, we can just make __isolate_lru_page() a bool function and
>> remove the ugly switch in  isolate_lru_pages()?
> 
> I agree that the switch statement in isolate_lru_pages() seems pointless
> now, and can be turned into an if{}else{}.  But that cleanup is a
> diversion from this particular TestClearPageLRU patch, and I think from
> the whole series (checking final state of the patchset, yes, the switch
> is still there - though I think there have been variant series which
> removed it).
> 
> Can we please leave that cleanup until after the series has gone in?

Sure thing!

The patch seems functionally fine, so

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> I think several of us have cleanups or optimization that we want to
> follow (I had one that inlines what isolate_migratepages_block() wanted
> of __isolate_lru_page() into that function, so simplifying what vmscan.c
> needs; perhaps that can now eliminate it completely, I've not tried
> recently).  But there was a point at which the series was growing
> ten patches per release as we all added our bits and pieces on top,
> it got harder and harder to review the whole, and further from
> getting the basics in: I do push back against that tendency.
> 
> Hugh
> 

