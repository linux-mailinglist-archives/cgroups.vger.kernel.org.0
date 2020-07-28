Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51979230889
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgG1LUK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 07:20:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42207 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728954AbgG1LUJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 07:20:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U43yIOJ_1595935203;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U43yIOJ_1595935203)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 19:20:03 +0800
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
Message-ID: <ccd01046-451c-463d-7c5d-9c32794f4b1e@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 19:19:52 +0800
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
> I was going through the code of the entire patch set and I noticed
> these changes in move_pages_to_lru. What is the reason for adding the
> new_lruvec logic? My understanding is that we are moving the pages to
> the lruvec provided are we not?If so why do we need to add code to get
> a new lruvec? The code itself seems to stand out from the rest of the
> patch as it is introducing new code instead of replacing existing
> locking code, and it doesn't match up with the description of what
> this function is supposed to do since it changes the lruvec.

this new_lruvec is the replacement of removed line, as following code:
>> -               lruvec = mem_cgroup_page_lruvec(page, pgdat);
This recheck is for the page move the root memcg, otherwise it cause the bug:

[ 2081.240795] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2081.248125] #PF: supervisor read access in kernel mode
[ 2081.253627] #PF: error_code(0x0000) - not-present page
[ 2081.259124] PGD 8000000044cb0067 P4D 8000000044cb0067 PUD 95c9067 PMD 0
[ 2081.266193] Oops: 0000 [#1] PREEMPT SMP PTI
[ 2081.270740] CPU: 5 PID: 131 Comm: kswapd0 Kdump: loaded Tainted: G        W         5.8.0-rc6-00025-gc708f8a0db47 #45
[ 2081.281960] Hardware name: Alibaba X-Dragon CN 01/20G4B, BIOS 1ALSP016 05/21/2018
[ 2081.290054] RIP: 0010:do_raw_spin_trylock+0x5/0x40
[ 2081.295209] Code: 76 82 48 89 df e8 bb fe ff ff eb 8c 89 c6 48 89 df e8 4f dd ff ff 66 90 eb 8b 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <8b> 07 85 c0 75 28 ba 01 00 00 00 f0 0f b1 17 75 1d 65 8b 05 03 6a
[ 2081.314832] RSP: 0018:ffffc900002ebac8 EFLAGS: 00010082
[ 2081.320410] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
[ 2081.327907] RDX: ffff888035833480 RSI: 0000000000000000 RDI: 0000000000000000
[ 2081.335407] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[ 2081.342907] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 2081.350405] R13: dead000000000100 R14: 0000000000000000 R15: ffffc900002ebbb0
[ 2081.357908] FS:  0000000000000000(0000) GS:ffff88807a200000(0000) knlGS:0000000000000000
[ 2081.366619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2081.372717] CR2: 0000000000000000 CR3: 0000000031228005 CR4: 00000000003606e0
[ 2081.380215] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2081.387713] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2081.395198] Call Trace:
[ 2081.398008]  _raw_spin_lock_irq+0x47/0x80
[ 2081.402387]  ? move_pages_to_lru+0x566/0xb80
[ 2081.407028]  move_pages_to_lru+0x566/0xb80
[ 2081.411495]  shrink_active_list+0x355/0xa70
[ 2081.416054]  shrink_lruvec+0x4f7/0x810
[ 2081.420176]  ? mem_cgroup_iter+0xb6/0x410
[ 2081.424558]  shrink_node+0x1cc/0x8d0
[ 2081.428510]  balance_pgdat+0x3cf/0x760
[ 2081.432634]  kswapd+0x232/0x660
[ 2081.436147]  ? finish_wait+0x80/0x80
[ 2081.440093]  ? balance_pgdat+0x760/0x760
[ 2081.444382]  kthread+0x17e/0x1b0
[ 2081.447975]  ? kthread_park+0xc0/0xc0
[ 2081.452005]  ret_from_fork+0x22/0x30

Thanks!
Alex
> 
>> @@ -1883,16 +1889,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>>                         __ClearPageActive(page);
>>
>>                         if (unlikely(PageCompound(page))) {
>> -                               spin_unlock_irq(&pgdat->lru_lock);
>> +                               spin_unlock_irq(&lruvec->lru_lock);
>>                                 destroy_compound_page(page);
>> -                               spin_lock_irq(&pgdat->lru_lock);
>> +                               spin_lock_irq(&lruvec->lru_lock);
>>                         } else
>>                                 list_add(&page->lru, &pages_to_free);
>>
>>                         continue;
>>                 }
>>
>> -               lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>                 lru = page_lru(page);
>>                 nr_pages = hpage_nr_pages(page);
