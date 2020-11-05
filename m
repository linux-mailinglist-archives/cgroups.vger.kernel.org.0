Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4744E2A76B3
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 05:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgKEEwT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 23:52:19 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33215 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730336AbgKEEwS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 23:52:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UEHE5zB_1604551930;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEHE5zB_1604551930)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 12:52:11 +0800
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
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
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
Date:   Thu, 5 Nov 2020 12:52:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104174603.GB744831@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/11/5 上午1:46, Johannes Weiner 写道:
> On Wed, Nov 04, 2020 at 07:27:21PM +0800, Alex Shi wrote:
>> 在 2020/11/3 上午4:20, Johannes Weiner 写道:
>>> On Mon, Nov 02, 2020 at 02:49:27PM +0000, Matthew Wilcox wrote:
>>>> On Mon, Nov 02, 2020 at 09:41:10AM -0500, Johannes Weiner wrote:
>>>>> On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
>>>>>> From: Hugh Dickins <hughd@google.com>
>>>>>>
>>>>>> It is necessary for page_idle_get_page() to recheck PageLRU() after
>>>>>> get_page_unless_zero(), but holding lru_lock around that serves no
>>>>>> useful purpose, and adds to lru_lock contention: delete it.
>>>>>>
>>>>>> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
>>>>>> discussion that led to lru_lock there; but __page_set_anon_rmap() now
>>>>>> uses WRITE_ONCE(),
>>>>>
>>>>> That doesn't seem to be the case in Linus's or Andrew's tree. Am I
>>>>> missing a dependent patch series?
>>>>>
>>>>>> and I see no other risk in page_idle_clear_pte_refs() using
>>>>>> rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
>>>>>> not entirely prevented by page_count() check in ksm.c's
>>>>>> write_protect_page(): that risk being shared with page_referenced()
>>>>>> and not helped by lru_lock).
>>>>>
>>>>> Isn't it possible, as per Minchan's description, for page->mapping to
>>>>> point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
>>>>> thinking it's looking at a struct address_space?
>>>>
>>>> I don't think it can point to an anon_vma without the ANON bit set.
>>>> Minchan's concern in that email was that it might still be NULL.
>>>
>>> Hm, no, the thread is a lengthy discussion about whether the store
>>> could be split such that page->mapping is actually pointing to
>>> something invalid (anon_vma without the PageAnon bit).
>>>
>>> From his email:
>>>
>>>         CPU 0                                                                           CPU 1
>>>
>>> do_anonymous_page
>>>   __page_set_anon_rmap
>>>   /* out of order happened so SetPageLRU is done ahead */
>>>   SetPageLRU(page)
>>
>> This SetPageLRU done in __pagevec_lru_add_fn() which under the lru_lock
>> protection, so the original memory barrier or lock concern isn't
>> correct. that means, the SetPageLRU isn't possible to be here.
>> And then no warry on right side 'CPU 1' problem.
> 
> The SetPageLRU is done under lru_lock, but the store to page->mapping
> is not, so what ensures ordering between them? And what prevents the
> compiler from tearing the store to page->mapping?
> 

Right, I misunderstand the spin_lock in memory barrier. Thanks a lot
for point out this.
So, is this patch fine to fix the problem?

From 8427121da195a6a386d1ce71abcb41b31211e21f Mon Sep 17 00:00:00 2001
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
 mm/rmap.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c050dab2ae65..56af18aa57de 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1054,8 +1054,27 @@ static void __page_set_anon_rmap(struct page *page,
 	if (!exclusive)
 		anon_vma = anon_vma->root;
 
+	/*
+	 * w/o the WRITE_ONCE here the following scenario may happens due to
+	 * store reordering.
+	 *
+	 *      CPU 0                                          CPU 1
+	 *
+	 * do_anonymous_page				page_idle_clear_pte_refs
+	 *   __page_set_anon_rmap
+	 *     page->mapping = anon_vma + PAGE_MAPPING_ANON
+	 *   lru_cache_add_inactive_or_unevictable()
+	 *     SetPageLRU(page)
+	 *                                               rmap_walk
+	 *                                                if PageAnon(page)
+	 *
+	 *  The 'SetPageLRU' may reordered before page->mapping setting, and
+	 *  page->mapping may set with anon_vma, w/o anon bit, then rmap_walk
+	 *  may goes to rmap_walk_file() for a anon page.
+	 */
+
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
-	page->mapping = (struct address_space *) anon_vma;
+	WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
 	page->index = linear_page_index(vma, address);
 }
 
-- 
1.8.3.1


> The writer does this:
> 
> 	CPU 0
> 	page_add_new_anon_rmap()
> 	  page->mapping = anon_vma + PAGE_MAPPING_ANON
> 	lru_cache_add_inactive_or_unevictable()
> 	  spin_lock(lruvec->lock)
> 	  SetPageLRU()
> 	  spin_unlock(lruvec->lock)
> 
> The concern is what CPU 1 will observe at page->mapping after
> observing PageLRU set on the page.
> 
> 1. anon_vma + PAGE_MAPPING_ANON
> 
>    That's the in-order scenario and is fine.
> 
> 2. NULL
> 
>    That's possible if the page->mapping store gets reordered to occur
>    after SetPageLRU. That's fine too because we check for it.
> 
> 3. anon_vma without the PAGE_MAPPING_ANON bit
> 
>    That would be a problem and could lead to all kinds of undesirable
>    behavior including crashes and data corruption.
> 
>    Is it possible? AFAICT the compiler is allowed to tear the store to
>    page->mapping and I don't see anything that would prevent it.
> 
> That said, I also don't see how the reader testing PageLRU under the
> lru_lock would prevent that in the first place. AFAICT we need that
> WRITE_ONCE() around the page->mapping assignment that's referenced in
> the changelog of this patch but I cannot find in any tree or patch.
> 
