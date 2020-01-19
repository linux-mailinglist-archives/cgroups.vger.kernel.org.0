Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EE141DA1
	for <lists+cgroups@lfdr.de>; Sun, 19 Jan 2020 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgASLd5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jan 2020 06:33:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34199 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbgASLd5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jan 2020 06:33:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0To5Mgrg_1579433626;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0To5Mgrg_1579433626)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jan 2020 19:33:48 +0800
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
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <36a55567-a701-ad6c-e4ea-79fd2021a648@linux.alibaba.com>
Date:   Sun, 19 Jan 2020 19:32:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116215222.GA64230@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> In a previous review, I pointed out the following race condition
> between page charging and compaction:
> 
> compaction:				generic_file_buffered_read:
> 
> 					page_cache_alloc()
> 
> !PageBuddy()
> 
> lock_page_lruvec(page)
>   lruvec = mem_cgroup_page_lruvec()
>   spin_lock(&lruvec->lru_lock)
>   if lruvec != mem_cgroup_page_lruvec()
>     goto again
> 
> 					add_to_page_cache_lru()
> 					  mem_cgroup_commit_charge()
> 					    page->mem_cgroup = foo
> 					  lru_cache_add()
> 					    __pagevec_lru_add()
> 					      SetPageLRU()
> 
> if PageLRU(page):
>   __isolate_lru_page()
> 
> As far as I can see, you have not addressed this. You have added
> lock_page_memcg(), but that prevents charged pages from moving between
> cgroups, it does not prevent newly allocated pages from being charged.
> 

yes, it's my fault to oversee this problem.

...

> 
> So here is a crazy idea that may be worth exploring:
> 
> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> linked list.
> 
> Can we make PageLRU atomic and use it to stabilize the lru_lock
> instead, and then use the lru_lock only serialize list operations?
> 

Sounds a good idea. I will try this.

Thanks
Alex

> I.e. in compaction, you'd do
> 
> 	if (!TestClearPageLRU(page))
> 		goto isolate_fail;
> 	/*
> 	 * We isolated the page's LRU state and thereby locked out all
> 	 * other isolators, including cgroup page moving, page reclaim,
> 	 * page freeing etc. That means page->mem_cgroup is now stable
> 	 * and we can safely look up the correct lruvec and take the
> 	 * page off its physical LRU list.
> 	 */
> 	lruvec = mem_cgroup_page_lruvec(page);
> 	spin_lock_irq(&lruvec->lru_lock);
> 	del_page_from_lru_list(page, lruvec, page_lru(page));
> 
> Putback would mostly remain the same (although you could take the
> PageLRU setting out of the list update locked section, as long as it's
> set after the page is physically linked):
> 
> 	/* LRU isolation pins page->mem_cgroup */
> 	lruvec = mem_cgroup_page_lruvec(page)
> 	spin_lock_irq(&lruvec->lru_lock);
> 	add_page_to_lru_list(...);
> 	spin_unlock_irq(&lruvec->lru_lock);
> 
> 	SetPageLRU(page);
> 
> And you'd have to carefully review and rework other sites that rely on
> PageLRU: reclaim, __page_cache_release(), __activate_page() etc.
> 
> Especially things like activate_page(), which used to only check
> PageLRU to shuffle the page on the LRU list would now have to briefly
> clear PageLRU and then set it again afterwards.
> 
> However, aside from a bit more churn in those cases, and the
> unfortunate additional atomic operations, I currently can't think of a
> fundamental reason why this wouldn't work.
> 
> Hugh, what do you think?
> 
