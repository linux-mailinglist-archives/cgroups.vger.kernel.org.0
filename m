Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6464122361F
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGQHq3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 03:46:29 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49179 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgGQHq3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 03:46:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U2ysnp5_1594971981;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ysnp5_1594971981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jul 2020 15:46:23 +0800
Subject: Re: [PATCH v16 13/22] mm/lru: introduce TestClearPageLRU
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
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-14-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UfLbVRQ4+TOw-XnjuyZqoVmRmWb5_rbEZZ0povYv-n_Lg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <072b39ac-b95a-94f1-67a2-3293d4550ff8@linux.alibaba.com>
Date:   Fri, 17 Jul 2020 15:45:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfLbVRQ4+TOw-XnjuyZqoVmRmWb5_rbEZZ0povYv-n_Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/17 上午5:12, Alexander Duyck 写道:
> On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> Combine PageLRU check and ClearPageLRU into a function by new
>> introduced func TestClearPageLRU. This function will be used as page
>> isolation precondition to prevent other isolations some where else.
>> Then there are may non PageLRU page on lru list, need to remove BUG
>> checking accordingly.
>>
>> Hugh Dickins pointed that __page_cache_release and release_pages
>> has no need to do atomic clear bit since no user on the page at that
>> moment. and no need get_page() before lru bit clear in isolate_lru_page,
>> since it '(1) Must be called with an elevated refcount on the page'.
>>
>> As Andrew Morton mentioned this change would dirty cacheline for page
>> isn't on LRU. But the lost would be acceptable with Rong Chen
>> <rong.a.chen@intel.com> report:
>> https://lkml.org/lkml/2020/3/4/173
>>

...

>> diff --git a/mm/swap.c b/mm/swap.c
>> index f645965fde0e..5092fe9c8c47 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -83,10 +83,9 @@ static void __page_cache_release(struct page *page)
>>                 struct lruvec *lruvec;
>>                 unsigned long flags;
>>
>> +               __ClearPageLRU(page);
>>                 spin_lock_irqsave(&pgdat->lru_lock, flags);
>>                 lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
>> -               __ClearPageLRU(page);
>>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));
>>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>>         }
> 
> So this piece doesn't make much sense to me. Why not use
> TestClearPageLRU(page) here? Just a few lines above you are testing
> for PageLRU(page) and it seems like if you are going to go for an
> atomic test/clear and then remove the page from the LRU list you
> should be using it here as well otherwise it seems like you could run
> into a potential collision since you are testing here without clearing
> the bit.
> 

Hi Alex,

Thanks a lot for comments! 

In this func's call path __page_cache_release, the page is unlikely be
ClearPageLRU, since this page isn't used by anyone, and going to be freed.
just __ClearPageLRU would be safe, and could save a non lru page flags disturb.


>> @@ -878,9 +877,8 @@ void release_pages(struct page **pages, int nr)
>>                                 spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
>>                         }
>>
>> -                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>> -                       VM_BUG_ON_PAGE(!PageLRU(page), page);
>>                         __ClearPageLRU(page);
>> +                       lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
>>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>>                 }
>>
> 
> Same here. You are just moving the flag clearing, but you didn't
> combine it with the test. It seems like if you are expecting this to
> be treated as an atomic operation. It should be a relatively low cost
> to do since you already should own the cacheline as a result of
> calling put_page_testzero so I am not sure why you are not combining
> the two.

before the ClearPageLRU, there is a put_page_testzero(), that means no one using
this page, and isolate_lru_page can not run on this page the in func checking. 
	VM_BUG_ON_PAGE(!page_count(page), page);
So it would be safe here.


> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index c1c4259b4de5..18986fefd49b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1548,16 +1548,16 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
>>  {
>>         int ret = -EINVAL;
>>
>> -       /* Only take pages on the LRU. */
>> -       if (!PageLRU(page))
>> -               return ret;
>> -
>>         /* Compaction should not handle unevictable pages but CMA can do so */
>>         if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
>>                 return ret;
>>
>>         ret = -EBUSY;
>>
>> +       /* Only take pages on the LRU. */
>> +       if (!PageLRU(page))
>> +               return ret;
>> +
>>         /*
>>          * To minimise LRU disruption, the caller can indicate that it only
>>          * wants to isolate pages it will be able to operate on without
>> @@ -1671,8 +1671,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>                 page = lru_to_page(src);
>>                 prefetchw_prev_lru_page(page, src, flags);
>>
>> -               VM_BUG_ON_PAGE(!PageLRU(page), page);
>> -
>>                 nr_pages = compound_nr(page);
>>                 total_scan += nr_pages;
>>
> 
> So effectively the changes here are making it so that a !PageLRU page
> will cycle to the start of the LRU list. Now if I understand correctly
> we are guaranteed that if the flag is not set it cannot be set while
> we are holding the lru_lock, however it can be cleared while we are
> holding the lock, correct? Thus that is why isolate_lru_pages has to
> call TestClearPageLRU after the earlier check in __isolate_lru_page.

Right. 

> 
> It might make it more readable to pull in the later patch that
> modifies isolate_lru_pages that has it using TestClearPageLRU.
As to this change, It has to do in this patch, since any TestClearPageLRU may
cause lru bit miss in the lru list, so the precondication check has to
removed here.

Thank
Alex
