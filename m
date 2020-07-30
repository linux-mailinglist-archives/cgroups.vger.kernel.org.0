Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98D232BB2
	for <lists+cgroups@lfdr.de>; Thu, 30 Jul 2020 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3GIv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jul 2020 02:08:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36373 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgG3GIv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jul 2020 02:08:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4D5cZp_1596089323;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4D5cZp_1596089323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jul 2020 14:08:44 +0800
Subject: Re: [PATCH v17 18/21] mm/lru: introduce the relock_page_lruvec
 function
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
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-19-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdFDcz=CQ+6mzcjh-apwy3UyPqAuOozvYr+2PSCNQrENA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3345bfbf-ebe9-b5e0-a731-77dd7d76b0c9@linux.alibaba.com>
Date:   Thu, 30 Jul 2020 14:08:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdFDcz=CQ+6mzcjh-apwy3UyPqAuOozvYr+2PSCNQrENA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/30 上午1:52, Alexander Duyck 写道:
>> +       rcu_read_lock();
>> +       locked = mem_cgroup_page_lruvec(page, pgdat) == locked_lruvec;
>> +       rcu_read_unlock();
>> +
>> +       if (locked)
>> +               return locked_lruvec;
>> +
>> +       if (locked_lruvec)
>> +               unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
>> +
>> +       return lock_page_lruvec_irqsave(page, flags);
>> +}
>> +
> So looking these over they seem to be pretty inefficient for what they
> do. Basically in worst case (locked_lruvec == NULL) you end up calling
> mem_cgoup_page_lruvec and all the rcu_read_lock/unlock a couple times
> for a single page. It might make more sense to structure this like:
> if (locked_lruvec) {

Uh, we still need to check this page's lruvec, that needs a rcu_read_lock.
to save a mem_cgroup_page_lruvec call, we have to open lock_page_lruvec
as your mentained before.

>     if (lruvec_holds_page_lru_lock(page, locked_lruvec))
>         return locked_lruvec;
> 
>     unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
> }
> return lock_page_lruvec_irqsave(page, flags);
> 
> The other piece that has me scratching my head is that I wonder if we
> couldn't do this without needing the rcu_read_lock. For example, what
> if we were to compare the page mem_cgroup pointer to the memcg back
> pointer stored in the mem_cgroup_per_node? It seems like ordering
> things this way would significantly reduce the overhead due to the
> pointer chasing to see if the page is in the locked lruvec or not.
> 

If page->mem_cgroup always be charged. the following could be better.

+/* Don't lock again iff page's lruvec locked */
+static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
+               struct lruvec *locked_lruvec, unsigned long *flags)
+{
+       struct lruvec *lruvec;
+
+       if (mem_cgroup_disabled())
+               return locked_lruvec;
+
+       /* user page always be charged */
+       VM_BUG_ON_PAGE(!page->mem_cgroup, page);
+
+       rcu_read_lock();
+       if (likely(lruvec_memcg(locked_lruvec) == page->mem_cgroup)) {
+               rcu_read_unlock();
+               return locked_lruvec;
+       }
+
+       if (locked_lruvec)
+               unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
+
+       lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+       spin_lock_irqsave(&lruvec->lru_lock, *flags);
+       rcu_read_unlock();
+       lruvec_memcg_debug(lruvec, page);
+
+       return lruvec;
+}
+

The user page is always be charged since readahead page is charged now.
and looks we also can apply this patch. I will test it to see if there is
other exception.


commit 826128346e50f6c60c513e166998466b593becad
Author: Alex Shi <alex.shi@linux.alibaba.com>
Date:   Thu Jul 30 13:58:38 2020 +0800

    mm/memcg: remove useless check on page->mem_cgroup

    Since readahead page will be charged on memcg too. We don't need to
    check this exception now.

    Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af96217f2ec5..0c7f6bed199b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1336,12 +1336,6 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd

        VM_BUG_ON_PAGE(PageTail(page), page);
        memcg = READ_ONCE(page->mem_cgroup);
-       /*
-        * Swapcache readahead pages are added to the LRU - and
-        * possibly migrated - before they are charged.
-        */
-       if (!memcg)
-               memcg = root_mem_cgroup;

        mz = mem_cgroup_page_nodeinfo(memcg, page);
        lruvec = &mz->lruvec;
@@ -6962,10 +6956,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
        if (newpage->mem_cgroup)
                return;

-       /* Swapcache readahead pages can get replaced before being charged */
        memcg = oldpage->mem_cgroup;
-       if (!memcg)
-               return;

        /* Force-charge the new page. The old one will be freed soon */
        nr_pages = thp_nr_pages(newpage);
@@ -7160,10 +7151,6 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)

        memcg = page->mem_cgroup;

-       /* Readahead page, never charged */
-       if (!memcg)
-               return;
-
        /*
         * In case the memcg owning these pages has been offlined and doesn't
         * have an ID allocated to it anymore, charge the closest online
