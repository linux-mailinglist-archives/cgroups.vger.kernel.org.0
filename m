Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65047224BA8
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGROBy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jul 2020 10:01:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54981 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbgGROBx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jul 2020 10:01:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U33ffAT_1595080903;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U33ffAT_1595080903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Jul 2020 22:01:44 +0800
Subject: Re: [PATCH v16 19/22] mm/lru: introduce the relock_page_lruvec
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
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-20-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdL7ppCdszBNyY3O9d2stE0tCZ8vCzH7tBEnHG2ZwkZHg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <640e4081-3db3-c941-4b02-8a9aef26e7ba@linux.alibaba.com>
Date:   Sat, 18 Jul 2020 22:01:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdL7ppCdszBNyY3O9d2stE0tCZ8vCzH7tBEnHG2ZwkZHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/18 上午6:03, Alexander Duyck 写道:
>> index 129c532357a4..9fb906fbaed5 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -209,19 +209,12 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>>
>>         for (i = 0; i < pagevec_count(pvec); i++) {
>>                 struct page *page = pvec->pages[i];
>> -               struct lruvec *new_lruvec;
>> -
>> -               new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>> -               if (lruvec != new_lruvec) {
>> -                       if (lruvec)
>> -                               unlock_page_lruvec_irqrestore(lruvec, flags);
>> -                       lruvec = lock_page_lruvec_irqsave(page, &flags);
>> -               }
>>
>>                 /* block memcg migration during page moving between lru */
>>                 if (!TestClearPageLRU(page))
>>                         continue;
>>
>> +               lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
>>                 (*move_fn)(page, lruvec);
>>
>>                 SetPageLRU(page);
> So looking at this I realize that patch 18 probably should have
> ordered this the same way with the TestClearPageLRU happening before
> you fetched the new_lruvec. Otherwise I think you are potentially
> exposed to the original issue you were fixing the the previous patch
> that added the call to TestClearPageLRU.

Good catch. It's better to be aligned in next version.
Thanks!

> 
>> @@ -866,17 +859,12 @@ void release_pages(struct page **pages, int nr)
>>                 }
>>
>>                 if (PageLRU(page)) {
>> -                       struct lruvec *new_lruvec;
>> -
>> -                       new_lruvec = mem_cgroup_page_lruvec(page,
>> -                                                       page_pgdat(page));
>> -                       if (new_lruvec != lruvec) {
>> -                               if (lruvec)
>> -                                       unlock_page_lruvec_irqrestore(lruvec,
>> -                                                                       flags);
>> +                       struct lruvec *pre_lruvec = lruvec;
>> +
>> +                       lruvec = relock_page_lruvec_irqsave(page, lruvec,
>> +                                                                       &flags);
>> +                       if (pre_lruvec != lruvec)
> So this doesn't really read right. I suppose "pre_lruvec" should
> probably be "prev_lruvec" since I assume you mean "previous" not
> "before".

yes, it's previous, I will rename it.
Thanks
Alex
> 
