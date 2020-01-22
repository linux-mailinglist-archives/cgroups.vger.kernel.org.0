Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C882114542B
	for <lists+cgroups@lfdr.de>; Wed, 22 Jan 2020 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAVMBh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jan 2020 07:01:37 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:57209 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgAVMBh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jan 2020 07:01:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0ToLTDEr_1579694489;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToLTDEr_1579694489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Jan 2020 20:01:30 +0800
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <9ee80b68-a78f-714a-c727-1f6d2b4f87ea@linux.alibaba.com>
 <20200121160005.GA69293@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0bd0a561-93cc-11b6-1eae-24b450b0f033@linux.alibaba.com>
Date:   Wed, 22 Jan 2020 20:01:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121160005.GA69293@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/22 上午12:00, Johannes Weiner 写道:
> On Mon, Jan 20, 2020 at 08:58:09PM +0800, Alex Shi wrote:
>>
>>
>> 在 2020/1/17 上午5:52, Johannes Weiner 写道:
>>
>>> You simply cannot serialize on page->mem_cgroup->lruvec when
>>> page->mem_cgroup isn't stable. You need to serialize on the page
>>> itself, one way or another, to make this work.
>>>
>>>
>>> So here is a crazy idea that may be worth exploring:
>>>
>>> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
>>> linked list.
>>>
>>> Can we make PageLRU atomic and use it to stabilize the lru_lock
>>> instead, and then use the lru_lock only serialize list operations?
>>>
>>
>> Hi Johannes,
>>
>> I am trying to figure out the solution of atomic PageLRU, but is 
>> blocked by the following sitations, when PageLRU and lru list was protected
>> together under lru_lock, the PageLRU could be a indicator if page on lru list
>> But now seems it can't be the indicator anymore.
>> Could you give more clues of stabilization usage of PageLRU?
> 
> There are two types of PageLRU checks: optimistic and deterministic.
> 
> The check in activate_page() for example is optimistic and the result
> unstable, but that's okay, because if we miss a page here and there
> it's not the end of the world.
> 
> But the check in __activate_page() is deterministic, because we need
> to be sure before del_page_from_lru_list(). Currently it's made
> deterministic by testing under the lock: whoever acquires the lock
> first gets to touch the LRU state. The same can be done with an atomic
> TestClearPagLRU: whoever clears the flag first gets to touch the LRU
> state (the lock is then only acquired to not corrupt the linked list,
> in case somebody adds or removes a different page at the same time).

Hi Johannes,

Thanks a lot for detailed explanations! I just gonna to take 2 weeks holiday
from tomorrow as Chinese new year season with families. I am very sorry for 
can not hang on this for a while.

> 
> I.e. in my proposal, if you want to get a stable read of PageLRU, you
> have to clear it atomically. But AFAICS, everybody who currently does
> need a stable read either already clears it or can easily be converted
> to clear it and then set it again (like __activate_page and friends).
> 
>> __page_cache_release/release_pages/compaction            __pagevec_lru_add
>> if (TestClearPageLRU(page))                              if (!PageLRU())
>>                                                                 lruvec_lock();
>>                                                                 list_add();
>>         			                                lruvec_unlock();
>>         			                                SetPageLRU() //position 1
>>         lock_page_lruvec_irqsave(page, &flags);
>>         del_page_from_lru_list(page, lruvec, ..);
>>         unlock_page_lruvec_irqrestore(lruvec, flags);
>>                                                                 SetPageLRU() //position 2
> 
> Hm, that's not how __pagevec_lru_add() looks. In fact,
> __pagevec_lru_add_fn() has a BUG_ON(PageLRU).
> 
> That's because only one thread can own the isolation state at a time.
> 
> If PageLRU is set, only one thread can claim it. Right now, whoever
> takes the lock first and clears it wins. When we replace it with
> TestClearPageLRU, it's the same thing: only one thread can win.
> 
> And you cannot set PageLRU, unless you own it. Either you isolated the
> page using TestClearPageLRU, or you allocated a new page.

Yes I understand isolatation would exclusive by PageLRU, but forgive my
stupid, I didn't figure out how a new page lruvec adding could be blocked.

Anyway, I will try my best to catch up after holiday.

Many thanks for nice cocaching!
Alex
