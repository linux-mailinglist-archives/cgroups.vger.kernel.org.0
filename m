Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67E1A75B5
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407115AbgDNIUP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 04:20:15 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47169 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407079AbgDNITd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 04:19:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=39;SR=0;TI=SMTPD_---0TvVqOrg_1586852360;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvVqOrg_1586852360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 16:19:21 +0800
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
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <42d5c2cb-3019-993f-eba7-33a1d69ef699@linux.alibaba.com>
Date:   Tue, 14 Apr 2020 16:19:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200413180725.GA99267@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/14 ÉÏÎç2:07, Johannes Weiner Ð´µÀ:
> But isolation actually needs to lock out charging, or it would operate
> on the wrong list:
> 
> isolation:                                     commit_charge:
> if (TestClearPageLRU(page))
>                                                page->mem_cgroup = new
>   // page is still physically on
>   // the root_mem_cgroup's LRU. We're
>   // updating the wrong list:
>   memcg = page->mem_cgroup
>   spin_lock(memcg->lru_lock)
>   del_page_from_lru_list(page, memcg)
>   spin_unlock(memcg->lru_lock)
> 
> lrucare really is a mess. Even before this patch series, it makes
> things tricky and subtle and error prone.
> 
> The only reason we're doing it is for when there is swapping without
> swap tracking, in which case swap reahadead needs to put pages on the
> LRU but cannot charge them until we have a faulting vma later.
> 
> But it's not clear how practical such a configuration is. Both memory
> and swap are shared resources, and isolation isn't really effective
> when you restrict access to memory but then let workloads swap freely.
> 
> Plus, the overhead of tracking is tiny - 512k per G of swap (0.04%).
> 
> Maybe we should just delete MEMCG_SWAP and unconditionally track swap
> entry ownership when the memory controller is enabled. I don't see a
> good reason not to, and it would simplify the entire swapin path, the
> LRU locking, and the page->mem_cgroup stabilization rules.

Hi Johannes,

I think what you mean here is to keep swap_cgroup id even it was swaped,
then we read back the page from swap disk, we don't need to charge it.
So all other memcg charge are just happens on non lru list, thus we have
no isolation required in above awkward scenario.

That sounds a good idea. so, split_huge_page and mem_cgroup_migrate should
be safe, tasks cgroup migration may needs extra from_vec->lru_lock. Is that
right?

That's a good idea. I'm glad to have a try...

BTW,
As to the memcg swapped page mixed in swap disk timely. Maybe we could try
Tim Chen's swap_slot for memcg. What's your idea?

Thanks
Alex
