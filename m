Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8E11A334
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2019 04:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKDwp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 22:52:45 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54312 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfLKDwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 22:52:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TkapNAY_1576036356;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TkapNAY_1576036356)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Dec 2019 11:52:37 +0800
Subject: Re: [PATCH v5 2/8] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
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
References: <1575978384-222381-1-git-send-email-alex.shi@linux.alibaba.com>
 <1575978384-222381-3-git-send-email-alex.shi@linux.alibaba.com>
 <20191210134133.GI32169@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b86dc335-fad6-01a1-77ba-3d2a9d5c4c22@linux.alibaba.com>
Date:   Wed, 11 Dec 2019 11:51:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210134133.GI32169@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/12/10 ÏÂÎç9:41, Matthew Wilcox Ð´µÀ:
> On Tue, Dec 10, 2019 at 07:46:18PM +0800, Alex Shi wrote:
>> -static void lock_page_lru(struct page *page, int *isolated)
>> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>>  {
>> -	pg_data_t *pgdat = page_pgdat(page);
>> +	struct lruvec *lruvec = lock_page_lruvec_irq(page);
>>  
>> -	spin_lock_irq(&pgdat->lru_lock);
>>  	if (PageLRU(page)) {
>> -		struct lruvec *lruvec;
>>  
>> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  		ClearPageLRU(page);
>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		*isolated = 1;
>>  	} else
>>  		*isolated = 0;
>> +
>> +	return lruvec;
>>  }
> 
> I still don't understand how this is supposed to work for !PageLRU
> pages.  Which lruvec have you locked if this page isn't on an LRU?
> 

Good question. We could just fold it under PageLRU and no meaning changes.
Is this better to has this patch?

Thanks
Alex

commit 0f4b66d4a42397d57638352b738c3f9658003e44
Author: Alex Shi <alex.shi@linux.alibaba.com>
Date:   Wed Dec 11 11:31:53 2019 +0800

    mm/memcg: fold lock in lock_page_lru

    According to the calling path of commit_charge, the lrucare is bound
    with PageLRU, so we could just fold it under PageLRU. This has no
    functional change.

    Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Michal Hocko <mhocko@kernel.org>
    Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: cgroups@vger.kernel.org
    Cc: linux-mm@kvack.org
    Cc: linux-kernel@vger.kernel.org

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 833df0ce1bc1..4fe2252cf437 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2622,9 +2622,10 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)

 static struct lruvec *lock_page_lru(struct page *page, int *isolated)
 {
-       struct lruvec *lruvec = lock_page_lruvec_irq(page);
+       struct lruvec *lruvec = NULL;

        if (PageLRU(page)) {
+               lruvec = lock_page_lruvec_irq(page);

                ClearPageLRU(page);
                del_page_from_lru_list(page, lruvec, page_lru(page));
@@ -2638,17 +2639,18 @@ static struct lruvec *lock_page_lru(struct page *page, int *isolated)
 static void unlock_page_lru(struct page *page, int isolated,
                                struct lruvec *locked_lruvec)
 {
-       struct lruvec *lruvec;
+       if (isolated) {
+               struct lruvec *lruvec;

-       unlock_page_lruvec_irq(locked_lruvec);
-       lruvec = lock_page_lruvec_irq(page);
+               if (locked_lruvec)
+                       unlock_page_lruvec_irq(locked_lruvec);
+               lruvec = lock_page_lruvec_irq(page);

-       if (isolated) {
                VM_BUG_ON_PAGE(PageLRU(page), page);
                SetPageLRU(page);
                add_page_to_lru_list(page, lruvec, page_lru(page));
+               unlock_page_lruvec_irq(lruvec);
        }
-       unlock_page_lruvec_irq(lruvec);
 }

 static void commit_charge(struct page *page, struct mem_cgroup *memcg,
