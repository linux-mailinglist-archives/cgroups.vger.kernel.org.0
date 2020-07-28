Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A812303A9
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG1HPu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 03:15:50 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37784 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgG1HPu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 03:15:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U42Lwr8_1595920545;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U42Lwr8_1595920545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 15:15:46 +0800
Subject: Re: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdaW4Rf43yULhQBuP07vQgmoPbaWHGKv1Z7fEPP6jH83w@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <49d2a784-3560-4d97-ece2-f2dfb6941495@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 15:15:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdaW4Rf43yULhQBuP07vQgmoPbaWHGKv1Z7fEPP6jH83w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/28 上午7:34, Alexander Duyck 写道:

>> @@ -847,11 +847,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>                  * contention, to give chance to IRQs. Abort completely if
>>                  * a fatal signal is pending.
>>                  */
>> -               if (!(low_pfn % SWAP_CLUSTER_MAX)
>> -                   && compact_unlock_should_abort(&pgdat->lru_lock,
>> -                                           flags, &locked, cc)) {
>> -                       low_pfn = 0;
>> -                       goto fatal_pending;
>> +               if (!(low_pfn % SWAP_CLUSTER_MAX)) {
>> +                       if (locked_lruvec) {
>> +                               unlock_page_lruvec_irqrestore(locked_lruvec,
>> +                                                                       flags);
>> +                               locked_lruvec = NULL;
>> +                       }
>> +
>> +                       if (fatal_signal_pending(current)) {
>> +                               cc->contended = true;
>> +
>> +                               low_pfn = 0;
>> +                               goto fatal_pending;
>> +                       }
>> +
>> +                       cond_resched();
>>                 }
>>
>>                 if (!pfn_valid_within(low_pfn))
> 
> I'm noticing this patch introduces a bunch of noise. What is the
> reason for getting rid of compact_unlock_should_abort? It seems like
> you just open coded it here. If there is some sort of issue with it
> then it might be better to replace it as part of a preparatory patch
> before you introduce this one as changes like this make it harder to
> review.

Thanks for comments, Alex.

the func compact_unlock_should_abort should be removed since one of parameters
changed from 'bool *locked' to 'struct lruvec *lruvec'. So it's not applicable
now. I have to open it here instead of adding a only one user func.

> 
> It might make more sense to look at modifying
> compact_unlock_should_abort and compact_lock_irqsave (which always
> returns true so should probably be a void) to address the deficiencies
> they have that make them unusable for you.

I am wondering if people like a patch which just open compact_unlock_should_abort
func and move bool to void as a preparation patch, do you like this?


>> @@ -966,10 +975,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>                 if (!TestClearPageLRU(page))
>>                         goto isolate_fail_put;
>>
>> +               rcu_read_lock();
>> +               lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +
>>                 /* If we already hold the lock, we can skip some rechecking */
>> -               if (!locked) {
>> -                       locked = compact_lock_irqsave(&pgdat->lru_lock,
>> -                                                               &flags, cc);
>> +               if (lruvec != locked_lruvec) {
>> +                       if (locked_lruvec)
>> +                               unlock_page_lruvec_irqrestore(locked_lruvec,
>> +                                                                       flags);
>> +
>> +                       compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
>> +                       locked_lruvec = lruvec;
>> +                       rcu_read_unlock();
>> +
>> +                       lruvec_memcg_debug(lruvec, page);
>>
>>                         /* Try get exclusive access under lock */
>>                         if (!skip_updated) {
> 
> So this bit makes things a bit complicated. From what I can can tell
> the comment about exclusive access under the lock is supposed to apply
> to the pageblock via the lru_lock. However you are having to retest
> the lock for each page because it is possible the page was moved to
> another memory cgroup while the lru_lock was released correct? So in

The pageblock is aligned by pfn, so pages in them maynot on same memcg
originally. and yes, page may be changed memcg also.

> this case is the lru vector lock really providing any protection for
> the skip_updated portion of this code block if the lock isn't
> exclusive to the pageblock? In theory this would probably make more
> sense to have protected the skip bits under the zone lock, but I
> imagine that was avoided due to the additional overhead.

when we change to lruvec->lru_lock, it does the same thing as pgdat->lru_lock.
just may get a bit more chance to here, and find out this is a skipable
pageblock and quit. 
Yes, logically, pgdat lru_lock seems better, but since we are holding lru_lock.
It's fine to not bother more locks.

> 
>> @@ -1876,6 +1876,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>                  *                                        list_add(&page->lru,)
>>                  *     list_add(&page->lru,) //corrupt
>>                  */
>> +               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>> +               if (new_lruvec != lruvec) {
>> +                       if (lruvec)
>> +                               spin_unlock_irq(&lruvec->lru_lock);
>> +                       lruvec = lock_page_lruvec_irq(page);
>> +               }
>>                 SetPageLRU(page);
>>
>>                 if (unlikely(put_page_testzero(page))) {
> 
> I was going through the code of the entire patch set and I noticed
> these changes in move_pages_to_lru. What is the reason for adding the
> new_lruvec logic? My understanding is that we are moving the pages to
> the lruvec provided are we not?If so why do we need to add code to get
> a new lruvec? The code itself seems to stand out from the rest of the
> patch as it is introducing new code instead of replacing existing
> locking code, and it doesn't match up with the description of what
> this function is supposed to do since it changes the lruvec.

A code here since some bugs happened. I will check it again anyway.

Thanks!
