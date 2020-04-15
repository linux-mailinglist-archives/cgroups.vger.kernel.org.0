Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664A1AA8E6
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633378AbgDONnI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Apr 2020 09:43:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49077 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730647AbgDONnH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 09:43:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TvcmpSS_1586958174;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvcmpSS_1586958174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Apr 2020 21:42:55 +0800
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
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 21:42:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414163114.GA136578@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/4/15 上午12:31, Johannes Weiner 写道:
> On Tue, Apr 14, 2020 at 12:52:30PM +0800, Alex Shi wrote:
>> 在 2020/4/14 上午2:07, Johannes Weiner 写道:
>>> Plus, the overhead of tracking is tiny - 512k per G of swap (0.04%).
>>>
>>> Maybe we should just delete MEMCG_SWAP and unconditionally track swap
>>> entry ownership when the memory controller is enabled. I don't see a
>>> good reason not to, and it would simplify the entire swapin path, the
>>> LRU locking, and the page->mem_cgroup stabilization rules.
>>>
>>
>> Sorry for not follow you up, did you mean just remove the MEMCG_SWAP configuration
>> and keep the feature in default memcg? 
> 
> Yes.
> 
>> That does can remove lrucare, but PageLRU lock scheme still fails since
>> we can not isolate the page during commit_charge, is that right?
> 
> No, without lrucare the scheme works. Charges usually do:
> 
> page->mem_cgroup = new;
> SetPageLRU(page);
> 
> And so if you can TestClearPageLRU(), page->mem_cgroup is stable.
> 
> lrucare charging is the exception: it changes page->mem_cgroup AFTER
> PageLRU has already been set, and even when it CANNOT acquire the
> PageLRU lock itself. It violates the rules.
> 
> If we make MEMCG_SWAP mandatory, we always have cgroup records for
> swapped out pages. That means we can charge all swapin pages
> (incl. readahead pages) directly in __read_swap_cache_async(), before
> setting PageLRU on the new pages.
> 
> Then we can delete lrucare.
> 
> And then TestClearPageLRU() guarantees page->mem_cgroup is stable.
> 

Hi Johannes,

Thanks a lot for point out!

Charging in __read_swap_cache_async would ask for 3 layers function arguments
pass, that would be a bit ugly. Compare to this, could we move out the
lru_cache add after commit_charge, like ksm copied pages?

That give a bit extra non lru list time, but the page just only be used only
after add_anon_rmap setting. Could it cause troubles?

I tried to track down the reason of lru_cache_add here, but no explanation
till first git kernel commit.

Thanks
Alex 

