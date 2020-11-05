Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4662A76C0
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 06:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgKEFDf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 00:03:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46810 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgKEFDe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 00:03:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UEHWfWQ_1604552603;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEHWfWQ_1604552603)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 13:03:24 +0800
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
 <20201104174603.GB744831@cmpxchg.org>
 <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
 <20201105045702.GI17076@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1e8f0162-cf2e-03eb-e7e0-ccc9f6a3eaf2@linux.alibaba.com>
Date:   Thu, 5 Nov 2020 13:03:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105045702.GI17076@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/5 ÏÂÎç12:57, Matthew Wilcox Ð´µÀ:
> On Thu, Nov 05, 2020 at 12:52:05PM +0800, Alex Shi wrote:
>> @@ -1054,8 +1054,27 @@ static void __page_set_anon_rmap(struct page *page,
>>  	if (!exclusive)
>>  		anon_vma = anon_vma->root;
>>  
>> +	/*
>> +	 * w/o the WRITE_ONCE here the following scenario may happens due to
>> +	 * store reordering.
>> +	 *
>> +	 *      CPU 0                                          CPU 1
>> +	 *
>> +	 * do_anonymous_page				page_idle_clear_pte_refs
>> +	 *   __page_set_anon_rmap
>> +	 *     page->mapping = anon_vma + PAGE_MAPPING_ANON
>> +	 *   lru_cache_add_inactive_or_unevictable()
>> +	 *     SetPageLRU(page)
>> +	 *                                               rmap_walk
>> +	 *                                                if PageAnon(page)
>> +	 *
>> +	 *  The 'SetPageLRU' may reordered before page->mapping setting, and
>> +	 *  page->mapping may set with anon_vma, w/o anon bit, then rmap_walk
>> +	 *  may goes to rmap_walk_file() for a anon page.
>> +	 */
>> +
>>  	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
>> -	page->mapping = (struct address_space *) anon_vma;
>> +	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
>>  	page->index = linear_page_index(vma, address);
>>  }
> 
> I don't like these verbose comments with detailed descriptions in
> the source code.  They're fine in changelogs, but they clutter the
> code, and they get outdated really quickly.  My preference is for
> something more brief:
> 
> 	/*
> 	 * Prevent page->mapping from pointing to an anon_vma without
> 	 * the PAGE_MAPPING_ANON bit set.  This could happen if the
> 	 * compiler stores anon_vma and then adds PAGE_MAPPING_ANON to it.
> 	 */
> 

Yes, it's reansonble. So is the following fine?

From f166f0d5df350c5eae1218456b9e6e1bd43434e7 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Thu, 5 Nov 2020 11:38:24 +0800
Subject: [PATCH] mm/rmap: stop store reordering issue on page->mapping

Hugh Dickins and Minchan Kim observed a long time issue which
discussed here, but actully the mentioned fix missed.
https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop/
The store reordering may cause problem in the scenario:

	CPU 0						CPU1
   do_anonymous_page
	page_add_new_anon_rmap()
	  page->mapping = anon_vma + PAGE_MAPPING_ANON
	lru_cache_add_inactive_or_unevictable()
	  spin_lock(lruvec->lock)
	  SetPageLRU()
	  spin_unlock(lruvec->lock)
						/* idletacking judged it as LRU
						 * page so pass the page in
						 * page_idle_clear_pte_refs
						 */
						page_idle_clear_pte_refs
						  rmap_walk
						    if PageAnon(page)

Johannes give detailed examples how the store reordering could cause
a trouble:
The concern is the SetPageLRU may get reorder before 'page->mapping'
setting, That would make CPU 1 will observe at page->mapping after
observing PageLRU set on the page.

1. anon_vma + PAGE_MAPPING_ANON

   That's the in-order scenario and is fine.

2. NULL

   That's possible if the page->mapping store gets reordered to occur
   after SetPageLRU. That's fine too because we check for it.

3. anon_vma without the PAGE_MAPPING_ANON bit

   That would be a problem and could lead to all kinds of undesirable
   behavior including crashes and data corruption.

   Is it possible? AFAICT the compiler is allowed to tear the store to
   page->mapping and I don't see anything that would prevent it.

That said, I also don't see how the reader testing PageLRU under the
lru_lock would prevent that in the first place. AFAICT we need that
WRITE_ONCE() around the page->mapping assignment.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/rmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c050dab2ae65..73788505aa0a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1054,8 +1054,13 @@ static void __page_set_anon_rmap(struct page *page,
 	if (!exclusive)
 		anon_vma = anon_vma->root;
 
+	/*
+	 * Prevent page->mapping from pointing to an anon_vma without
+	 * the PAGE_MAPPING_ANON bit set.  This could happen if the
+	 * compiler stores anon_vma and then adds PAGE_MAPPING_ANON to it.
+	 */
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
-	page->mapping = (struct address_space *) anon_vma;
+	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
 	page->index = linear_page_index(vma, address);
 }
 
-- 
1.8.3.1

