Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368F9228154
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGUNve (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 09:51:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50911 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgGUNve (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jul 2020 09:51:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U3PtznR_1595339485;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3PtznR_1595339485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 21:51:25 +0800
Subject: Re: [PATCH v16 16/22] mm/mlock: reorder isolation sequence during
 munlock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-17-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Udcry01samXT54RkurNqFKnVmv-686ZFHF+iw4b+12T_A@mail.gmail.com>
 <6e37ee32-c6c5-fcc5-3cad-74f7ae41fb67@linux.alibaba.com>
 <CAKgT0Ue2i96gL=Tqx_wFmsBj_b1cnM1KQHh8b+oYr5iRg0Tcpw@mail.gmail.com>
 <7a931661-e096-29ee-d97d-8bf96ba6c972@linux.alibaba.com>
Message-ID: <e7c9dda7-f222-5f05-9e02-4ea42c743999@linux.alibaba.com>
Date:   Tue, 21 Jul 2020 21:51:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7a931661-e096-29ee-d97d-8bf96ba6c972@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/21 下午5:26, Alex Shi 写道:
> 
> 
> 在 2020/7/21 上午2:51, Alexander Duyck 写道:
>>> Look into the __split_huge_page_tail, there is a tiny gap between tail page
>>> get PG_mlocked, and it is added into lru list.
>>> The TestClearPageLRU could blocked memcg changes of the page from stopping
>>> isolate_lru_page.
>> I get that there is a gap between the two in __split_huge_page_tail.
>> My concern is more the fact that you are pulling the bit testing
>> outside of the locked region when I don't think it needs to be. The
>> lock is being taken unconditionally, so why pull the testing out when
>> you could just do it inside the lock anyway? My worry is that you
>> might be addressing __split_huge_page_tail but in the process you
>> might be introducing a new race with something like
>> __pagevec_lru_add_fn.
> 
> Yes, the page maybe interfered by clear_page_mlock and add pages to wrong lru
> list.
> 
>>
>> If I am not mistaken the Mlocked flag can still be cleared regardless
>> of if the LRU bit is set or not. So you can still clear the LRU bit
>> before you pull the page out of the list, but it can be done after
>> clearing the Mlocked flag instead of before you have even taken the
>> LRU lock. In that way it would function more similar to how you
>> handled pagevec_lru_move_fn() as all this function is really doing is
>> moving the pages out of the unevictable list into one of the other LRU
>> lists anyway since the Mlocked flag was cleared.
>>
> 
> Without the lru bit guard, the page may be moved between memcgs, luckly,
> lock_page would stop the mem_cgroup_move_account with BUSY state cost.
> whole new change would like the following, I will testing/resend again.
> 

Hi Johannes,

It looks like lock_page_memcg() could be used to replace lock_page(), which
could change retry into spinlock wait. Would you like to give some comments?

Thank
Alex
> Thanks!
> Alex
> 
> @@ -182,7 +179,7 @@ static void __munlock_isolation_failed(struct page *page)
>  unsigned int munlock_vma_page(struct page *page)
>  {
>         int nr_pages;
> -       pg_data_t *pgdat = page_pgdat(page);
> +       struct lruvec *lruvec;
> 
>         /* For try_to_munlock() and to serialize with page migration */
>         BUG_ON(!PageLocked(page));
> @@ -190,11 +187,11 @@ unsigned int munlock_vma_page(struct page *page)
>         VM_BUG_ON_PAGE(PageTail(page), page);
> 
>         /*
> -        * Serialize with any parallel __split_huge_page_refcount() which
> +        * Serialize split tail pages in __split_huge_page_tail() which
>          * might otherwise copy PageMlocked to part of the tail pages before
>          * we clear it in the head page. It also stabilizes hpage_nr_pages().
>          */
> -       spin_lock_irq(&pgdat->lru_lock);
> +       lruvec = lock_page_lruvec_irq(page);
> 
>         if (!TestClearPageMlocked(page)) {
>                 /* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> @@ -205,15 +202,15 @@ unsigned int munlock_vma_page(struct page *page)
>         nr_pages = hpage_nr_pages(page);
>         __mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> 
> -       if (__munlock_isolate_lru_page(page, true)) {
> -               spin_unlock_irq(&pgdat->lru_lock);
> +       if (__munlock_isolate_lru_page(page, lruvec, true)) {
> +               unlock_page_lruvec_irq(lruvec);
>                 __munlock_isolated_page(page);
>                 goto out;
>         }
>         __munlock_isolation_failed(page);
> 
>  unlock_out:
> -       spin_unlock_irq(&pgdat->lru_lock);
> +       unlock_page_lruvec_irq(lruvec);
> 
>  out:
>         return nr_pages - 1;
> @@ -293,23 +290,27 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>         int nr = pagevec_count(pvec);
>         int delta_munlocked = -nr;
>         struct pagevec pvec_putback;
> +       struct lruvec *lruvec = NULL;
>         int pgrescued = 0;
> 
>         pagevec_init(&pvec_putback);
> 
>         /* Phase 1: page isolation */
> -       spin_lock_irq(&zone->zone_pgdat->lru_lock);
>         for (i = 0; i < nr; i++) {
>                 struct page *page = pvec->pages[i];
> 
> +               /* block memcg change in mem_cgroup_move_account */
> +               lock_page(page);
> +               lruvec = relock_page_lruvec_irq(page, lruvec);
>                 if (TestClearPageMlocked(page)) {
>                         /*
>                          * We already have pin from follow_page_mask()
>                          * so we can spare the get_page() here.
>                          */
> -                       if (__munlock_isolate_lru_page(page, false))
> +                       if (__munlock_isolate_lru_page(page, lruvec, false)) {
> +                               unlock_page(page);
>                                 continue;
> -                       else
> +                       } else
>                                 __munlock_isolation_failed(page);
>                 } else {
>                         delta_munlocked++;
> @@ -321,11 +322,14 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>                  * pin. We cannot do it under lru_lock however. If it's
>                  * the last pin, __page_cache_release() would deadlock.
>                  */
> +               unlock_page(page);
>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>                 pvec->pages[i] = NULL;
>         }
> -       __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> -       spin_unlock_irq(&zone->zone_pgdat->lru_lock);
> +       if (lruvec) {
> +               __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
> +               unlock_page_lruvec_irq(lruvec);
> +       }
> 
>         /* Now we can release pins of pages that we are not munlocking */
>         pagevec_release(&pvec_putback);
> 
