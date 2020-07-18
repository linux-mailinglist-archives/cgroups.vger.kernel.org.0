Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C73224BB3
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGROPM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jul 2020 10:15:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60592 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgGROPM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jul 2020 10:15:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U33hZjf_1595081706;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U33hZjf_1595081706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Jul 2020 22:15:06 +0800
Subject: Re: [PATCH v16 18/22] mm/lru: replace pgdat lru_lock with lruvec lock
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
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Rong Chen <rong.a.chen@intel.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-19-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Ud+Dj-Q8Sxv8eDQhjM3fFHwnU_ZFEVG54debBennUmxAg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <62dfd262-a7ac-d18e-216a-2988c690b256@linux.alibaba.com>
Date:   Sat, 18 Jul 2020 22:15:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud+Dj-Q8Sxv8eDQhjM3fFHwnU_ZFEVG54debBennUmxAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/18 上午5:38, Alexander Duyck 写道:
>> +               return locked_lruvec;
>> +
>> +       if (locked_lruvec)
>> +               unlock_page_lruvec_irqrestore(locked_lruvec, *flags);
>> +
>> +       return lock_page_lruvec_irqsave(page, flags);
>> +}
>> +
> These relock functions have no users in this patch. It might make
> sense and push this code to patch 19 in your series since that is
> where they are first used. In addition they don't seem very efficient
> as you already had to call mem_cgroup_page_lruvec once, why do it
> again when you could just store the value and lock the new lruvec if
> needed?

Right, it's better to move for late patch.

As to call the func again, mainly it's for code neat.

Thanks!

> 
>>  #ifdef CONFIG_CGROUP_WRITEBACK
>>
>>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 14c668b7e793..36c1680efd90 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -261,6 +261,8 @@ struct lruvec {
>>         atomic_long_t                   nonresident_age;
>>         /* Refaults at the time of last reclaim cycle */
>>         unsigned long                   refaults;
>> +       /* per lruvec lru_lock for memcg */
>> +       spinlock_t                      lru_lock;
>>         /* Various lruvec state flags (enum lruvec_flags) */
>>         unsigned long                   flags;
> Any reason for placing this here instead of at the end of the
> structure? From what I can tell it looks like lruvec is already 128B
> long so placing the lock on the end would put it into the next
> cacheline which may provide some performance benefit since it is
> likely to be bounced quite a bit.

Rong Chen(Cced) once reported a performance regression when the lock at
the end of struct, and move here could remove it.
Although I can't not reproduce. But I trust his report.

...

>>  putback:
>> -               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>>                 pvec->pages[i] = NULL;
>>         }
>> -       /* tempary disable irq, will remove later */
>> -       local_irq_disable();
>>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>> -       local_irq_enable();
>> +       if (lruvec)
>> +               unlock_page_lruvec_irq(lruvec);
> So I am not a fan of this change. You went to all the trouble of
> reducing the lock scope just to bring it back out here again. In
> addition it implies there is a path where you might try to update the
> page state without disabling interrupts.

Right. but any idea to avoid this except a extra local_irq_disable?

...

>>                 if (PageLRU(page)) {
>> -                       struct pglist_data *pgdat = page_pgdat(page);
>> +                       struct lruvec *new_lruvec;
>>
>> -                       if (pgdat != locked_pgdat) {
>> -                               if (locked_pgdat)
>> -                                       spin_unlock_irqrestore(&locked_pgdat->lru_lock,
>> +                       new_lruvec = mem_cgroup_page_lruvec(page,
>> +                                                       page_pgdat(page));
>> +                       if (new_lruvec != lruvec) {
>> +                               if (lruvec)
>> +                                       unlock_page_lruvec_irqrestore(lruvec,
>>                                                                         flags);
>>                                 lock_batch = 0;
>> -                               locked_pgdat = pgdat;
>> -                               spin_lock_irqsave(&locked_pgdat->lru_lock, flags);
>> +                               lruvec = lock_page_lruvec_irqsave(page, &flags);
>>                         }
> This just kind of seems ugly to me. I am not a fan of having to fetch
> the lruvec twice when you already have it in new_lruvec. I suppose it
> is fine though since you are just going to be replacing it later
> anyway.
> 

yes, it will be reproduce later.

Thanks
Alex
