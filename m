Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5922250D0
	for <lists+cgroups@lfdr.de>; Sun, 19 Jul 2020 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGSJMl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jul 2020 05:12:41 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46584 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgGSJMl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jul 2020 05:12:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U37udgA_1595149946;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U37udgA_1595149946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jul 2020 17:12:27 +0800
Subject: Re: [PATCH v16 18/22] mm/lru: replace pgdat lru_lock with lruvec lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
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
 <62dfd262-a7ac-d18e-216a-2988c690b256@linux.alibaba.com>
Message-ID: <c339f46e-ae04-4e65-2713-a5c8be56051a@linux.alibaba.com>
Date:   Sun, 19 Jul 2020 17:12:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <62dfd262-a7ac-d18e-216a-2988c690b256@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/18 下午10:15, Alex Shi 写道:
>>>
>>>  struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 14c668b7e793..36c1680efd90 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -261,6 +261,8 @@ struct lruvec {
>>>         atomic_long_t                   nonresident_age;
>>>         /* Refaults at the time of last reclaim cycle */
>>>         unsigned long                   refaults;
>>> +       /* per lruvec lru_lock for memcg */
>>> +       spinlock_t                      lru_lock;
>>>         /* Various lruvec state flags (enum lruvec_flags) */
>>>         unsigned long                   flags;
>> Any reason for placing this here instead of at the end of the
>> structure? From what I can tell it looks like lruvec is already 128B
>> long so placing the lock on the end would put it into the next
>> cacheline which may provide some performance benefit since it is
>> likely to be bounced quite a bit.
> Rong Chen(Cced) once reported a performance regression when the lock at
> the end of struct, and move here could remove it.
> Although I can't not reproduce. But I trust his report.
> 
Oops, Rong's report is on another member which is different with current
struct. 

Compare to move to tail, how about to move it to head of struct, which is
close to lru list? Did you have some data of the place change?

Thanks
Alex

 
> ...
> 
>>>  putback:
>>> -               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>>>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>>>                 pvec->pages[i] = NULL;
>>>         }
>>> -       /* tempary disable irq, will remove later */
>>> -       local_irq_disable();
>>>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>>> -       local_irq_enable();
>>> +       if (lruvec)
>>> +               unlock_page_lruvec_irq(lruvec);
>> So I am not a fan of this change. You went to all the trouble of
>> reducing the lock scope just to bring it back out here again. In
>> addition it implies there is a path where you might try to update the
>> page state without disabling interrupts.
> Right. but any idea to avoid this except a extra local_irq_disable?
> 

The following changes would resolve the problem. Is this ok?
@@ -324,7 +322,8 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
                pagevec_add(&pvec_putback, pvec->pages[i]);
                pvec->pages[i] = NULL;
        }
-       __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
+       if (delta_munlocked)
+               __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
        if (lruvec)
                unlock_page_lruvec_irq(lruvec);
