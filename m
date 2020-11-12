Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4C2B03CF
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 12:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgKLLZb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 06:25:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:59338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLLZa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 12 Nov 2020 06:25:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63172AF74;
        Thu, 12 Nov 2020 11:25:27 +0000 (UTC)
Subject: Re: [PATCH v21 15/19] mm/compaction: do page isolation first in
 compaction
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
        shy828301@gmail.com
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-16-git-send-email-alex.shi@linux.alibaba.com>
 <a0b8c198-6bd0-2ccb-fe55-970895c26a0b@suse.cz>
 <alpine.LSU.2.11.2011111803580.2174@eggly.anvils>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <85a40d01-09b6-1647-4ca0-7a83efdd9cbf@suse.cz>
Date:   Thu, 12 Nov 2020 12:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2011111803580.2174@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/12/20 3:28 AM, Hugh Dickins wrote:
> On Wed, 11 Nov 2020, Vlastimil Babka wrote:
>> On 11/5/20 9:55 AM, Alex Shi wrote:
>> 
>> > @@ -979,10 +995,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>> >   					goto isolate_abort;
>> >   			}
>> >   -			/* Recheck PageLRU and PageCompound under lock */
>> > -			if (!PageLRU(page))
>> > -				goto isolate_fail;
>> > -
>> >   			/*
>> >   			 * Page become compound since the non-locked check,
>> >   			 * and it's on LRU. It can only be a THP so the order
>> > @@ -990,16 +1002,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
> 
> Completely off-topic, and won't matter at all when Andrew rediffs into
> mmotm: but isn't it weird that this is showing "too_many_isolated(",
> when actually the function is isolate_migratepages_block()?
> 
>> >   			 */
>> >   			if (unlikely(PageCompound(page) &&
>> > !cc->alloc_contig)) {
>> >   				low_pfn += compound_nr(page) - 1;
>> > -				goto isolate_fail;
>> > +				SetPageLRU(page);
>> > +				goto isolate_fail_put;
>> >   			}
>> 
>> IIUC the danger here is khugepaged will collapse a THP. For that,
>> __collapse_huge_page_isolate() has to succeed isolate_lru_page(). Under the
>> new scheme, it shouldn't be possible, right? If that's correct, we can remove
>> this part?
> 
> I don't think so.  A preliminary check for PageCompound was made much
> higher up, before taking a reference on the page, but it can easily have
> become PageCompound since then (when racing prep_new_page() calls
> prep_compound_page()).
> 
> And __collapse_huge_page_isolate() does not turn a non-compound page
> into a compound page: it isolates small pages before copying them into
> the compound page (in the usual case: I can see there's also allowance
> for PageCompound there too, which will do something different).

Right, on both points, got too confused.

> Hugh
> 

