Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F0138C45
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 08:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAMHX2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 02:23:28 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53427 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727555AbgAMHX2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 02:23:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TnZoR5p_1578900205;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnZoR5p_1578900205)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jan 2020 15:23:25 +0800
Subject: Re: [PATCH v7 01/10] mm/vmscan: remove unnecessary lruvec adding
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org
Cc:     yun.wang@linux.alibaba.com
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-2-git-send-email-alex.shi@linux.alibaba.com>
 <6c91fb0a-d4e0-d960-1cfd-62bef5cd15a5@yandex-team.ru>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8f0f9fd5-56d3-0ec3-e875-f2eb5e1e7971@linux.alibaba.com>
Date:   Mon, 13 Jan 2020 15:21:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6c91fb0a-d4e0-d960-1cfd-62bef5cd15a5@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/10 下午4:39, Konstantin Khlebnikov 写道:
> On 25/12/2019 12.04, Alex Shi wrote:
>> We don't have to add a freeable page into lru and then remove from it.
>> This change saves a couple of actions and makes the moving more clear.
>>
>> The SetPageLRU needs to be kept here for list intergrity. Otherwise:
>>
>>      #0 mave_pages_to_lru                #1 release_pages
>>                                          if (put_page_testzero())
>>      if (put_page_testzero())
>>                                         !PageLRU //skip lru_lock
>>                                                  list_add(&page->lru,);
>>      else
>>          list_add(&page->lru,) //corrupt
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: yun.wang@linux.alibaba.com
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   mm/vmscan.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 572fb17c6273..8719361b47a0 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1852,26 +1852,18 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> 
> Here is another cleanup: pass only pgdat as argument.
> 
> This function reavaluates lruvec for each page under lru lock.
> Probably this is redundant for now but could be used in the future (or your patchset already use that).

Thanks a lot for comments, Konstantin!

yes, we could use pgdat here, but since to remove the pgdat later, maybe better to save this change? :)

> 
>>       while (!list_empty(list)) {
>>           page = lru_to_page(list);
>>           VM_BUG_ON_PAGE(PageLRU(page), page);
>> +        list_del(&page->lru);
>>           if (unlikely(!page_evictable(page))) {
>> -            list_del(&page->lru);
>>               spin_unlock_irq(&pgdat->lru_lock);
>>               putback_lru_page(page);
>>               spin_lock_irq(&pgdat->lru_lock);
>>               continue;
>>           }
>> -        lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> -
> 
> Please leave a comment that we must set PageLRU before dropping our page reference.

Right, I will try to give a comments here.
 
> 
>>           SetPageLRU(page);
>> -        lru = page_lru(page);
>> -
>> -        nr_pages = hpage_nr_pages(page);
>> -        update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
>> -        list_move(&page->lru, &lruvec->lists[lru]);
>>             if (put_page_testzero(page)) {
>>               __ClearPageLRU(page);
>>               __ClearPageActive(page);
>> -            del_page_from_lru_list(page, lruvec, lru);
>>                 if (unlikely(PageCompound(page))) {
>>                   spin_unlock_irq(&pgdat->lru_lock);
>> @@ -1880,6 +1872,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>               } else
>>                   list_add(&page->lru, &pages_to_free);
>>           } else {
>> +            lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +            lru = page_lru(page);
>> +            nr_pages = hpage_nr_pages(page);
>> +
>> +            update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
>> +            list_add(&page->lru, &lruvec->lists[lru]);
>>               nr_moved += nr_pages;
>>           }
> 
> IMHO It looks better to in this way:> 
> SetPageLRU()
> 
> if (unlikely(put_page_testzero())) {
>  <free>
>  continue;
> }
> 
> <add>

Yes, this looks better!

Thanks
Alex

> 
>>       }
>>
