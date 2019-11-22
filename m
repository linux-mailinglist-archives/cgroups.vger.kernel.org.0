Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518ED105EAB
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2019 03:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVCgt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Nov 2019 21:36:49 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59398 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfKVCgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Nov 2019 21:36:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TilD44h_1574390198;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TilD44h_1574390198)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Nov 2019 10:36:39 +0800
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
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
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119160456.GD382712@cmpxchg.org>
 <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
 <20191121220613.GB487872@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com>
Date:   Fri, 22 Nov 2019 10:36:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191121220613.GB487872@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/22 上午6:06, Johannes Weiner 写道:
>>
>> Forgive my idiot, I still don't know the details of unsafe lruvec here.
>> From my shortsight, the spin_lock_irq(embedded a preempt_disable) could block all rcu syncing thus, keep all memcg alive until the preempt_enabled in unspinlock, is this right?
>> If so even the page->mem_cgroup is migrated to others cgroups, the new and old cgroup should still be alive here.
> You are right about the freeing part, I missed this. And I should have
> read this email here before sending out my "fix" to the current code;
> thankfully Hugh re-iterated my mistake on that thread. My apologies.
> 

That's all right. You and Hugh do give me a lot of help! :)

> But I still don't understand how the moving part is safe. You look up
> the lruvec optimistically, lock it, then verify the lookup. What keeps
> page->mem_cgroup from changing after you verified it?
> 
> lock_page_lruvec():				mem_cgroup_move_account():
> again:
> rcu_read_lock()
> lruvec = page->mem_cgroup->lruvec
> 						isolate_lru_page()
> spin_lock_irq(&lruvec->lru_lock)
> rcu_read_unlock()
> if page->mem_cgroup->lruvec != lruvec:
>   spin_unlock_irq(&lruvec->lru_lock)
>   goto again;
> 						page->mem_cgroup = new cgroup
> 						putback_lru_page() // new lruvec
> 						  SetPageLRU()
> return lruvec; // old lruvec
> 
> The caller assumes page belongs to the returned lruvec and will then
> change the page's lru state with a mismatched page and lruvec.
> 
Yes, that's the problem we have to deal.

> If we could restrict lock_page_lruvec() to working only on PageLRU
> pages, we could fix the problem with memory barriers. But this won't
> work for split_huge_page(), which is AFAICT the only user that needs
> to freeze the lru state of a page that could be isolated elsewhere.
> 
> So AFAICS the only option is to lock out mem_cgroup_move_account()
> entirely when the lru_lock is held. Which I guess should be fine.

I guess we can try from lock_page_memcg, is that a good start?


diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7e6387ad01f0..f4bbbf72c5b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1224,7 +1224,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
                goto out;
        }

-       memcg = page->mem_cgroup;
+       memcg = lock_page_memcg(page);
        /*
         * Swapcache readahead pages are added to the LRU - and
         * possibly migrated - before they are charged.


Thanks a lot!
Alex
