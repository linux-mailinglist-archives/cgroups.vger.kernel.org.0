Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63B22232C6
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 07:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgGQFLC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 01:11:02 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46617 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgGQFLC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 01:11:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U2ytDbF_1594962637;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ytDbF_1594962637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jul 2020 13:10:38 +0800
Subject: Re: [PATCH v16 15/22] mm/compaction: do page isolation first in
 compaction
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-16-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ue72SfAmxCS+tay1NjioW9WBOvVgrhwUtVPz2aDCrcHPQ@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e724c44b-4135-3302-16fa-1df624fa81fa@linux.alibaba.com>
Date:   Fri, 17 Jul 2020 13:09:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue72SfAmxCS+tay1NjioW9WBOvVgrhwUtVPz2aDCrcHPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


>> @@ -950,6 +951,21 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>                 if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>>                         goto isolate_fail;
>>
>> +               /*
>> +                * Be careful not to clear PageLRU until after we're
>> +                * sure the page is not being freed elsewhere -- the
>> +                * page release code relies on it.
>> +                */
>> +               if (unlikely(!get_page_unless_zero(page)))
>> +                       goto isolate_fail;
>> +
>> +               if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
>> +                       goto isolate_fail_put;
>> +
>> +               /* Try isolate the page */
>> +               if (!TestClearPageLRU(page))
>> +                       goto isolate_fail_put;
>> +
>>                 /* If we already hold the lock, we can skip some rechecking */
>>                 if (!locked) {
>>                         locked = compact_lock_irqsave(&pgdat->lru_lock,
> 
> Why not do the __isolate_lru_page_prepare before getting the page?
> That way you can avoid performing an extra atomic operation on non-LRU
> pages.
>

This change come from Hugh Dickins as mentioned from commit log:
>> trylock_page() is not safe to use at this time: its setting PG_locked
>> can race with the page being freed or allocated ("Bad page"), and can
>> also erase flags being set by one of those "sole owners" of a freshly
>> allocated page who use non-atomic __SetPageFlag().

Hi Hugh,

would you like to show more details of the bug?

...

>> +                        * sure the page is not being freed elsewhere -- the
>> +                        * page release code relies on it.
>> +                        */
>> +                       if (unlikely(!get_page_unless_zero(page)))
>> +                               goto busy;
>> +
>> +                       if (!TestClearPageLRU(page)) {
>> +                               /*
>> +                                * This page may in other isolation path,
>> +                                * but we still hold lru_lock.
>> +                                */
>> +                               put_page(page);
>> +                               goto busy;
>> +                       }
>> +
> 
> I wonder if it wouldn't make sense to combine these two atomic ops
> with tests and the put_page into a single inline function? Then it
> could be possible to just do one check and if succeeds you do the
> block of code below, otherwise you just fall-through into the -EBUSY
> case.
> 

Uh, since get_page changes page->_refcount, TestClearPageLRU changes page->flags,
So I don't know how to combine them, could you make it more clear with code?

Thanks
Alex
