Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD25E108ACE
	for <lists+cgroups@lfdr.de>; Mon, 25 Nov 2019 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKYJ1E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Nov 2019 04:27:04 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33450 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbfKYJ1E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Nov 2019 04:27:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0Tj25bSL_1574674004;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tj25bSL_1574674004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Nov 2019 17:26:45 +0800
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
 <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com>
 <20191122161652.GA489821@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e629f595-df0a-71b2-35b4-b266ba1d0431@linux.alibaba.com>
Date:   Mon, 25 Nov 2019 17:26:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122161652.GA489821@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> 
> But that leaves me with one more worry: compaction. We locked out
> charge moving now, so between that and knowing that the page is alive,
> we have page->mem_cgroup stable. But compaction doesn't know whether
> the page is alive - it comes from a pfn and finds out using PageLRU.
> 
> In the current code, pgdat->lru_lock remains the same before and after
> the page is charged to a cgroup, so once compaction has that locked
> and it observes PageLRU, it can go ahead and isolate the page.
> 
> But lruvec->lru_lock changes during charging, and then compaction may
> hold the wrong lock during isolation:
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
> I don't see what prevents the lruvec from changing under compaction,
> neither in your patches nor in Hugh's. Maybe I'm missing something?
> 

Hi Johannes,

It looks my patch do the lruvec recheck/relock after PageLRU in compaction.c.
It should be fine for your question. So I will try more testing after all changes.

Thanks
Alex


@@ -949,10 +959,26 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
+		rcu_read_lock();
+reget_lruvec:
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+
 		/* If we already hold the lock, we can skip some rechecking */
-		if (!locked) {
-			locked = compact_lock_irqsave(&pgdat->lru_lock,
-								&flags, cc);
+		if (lruvec != locked_lruvec) {
+			if (locked_lruvec) {
+				spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							flags);
+				locked_lruvec = NULL;
+			}
+			if (compact_lock_irqsave(&lruvec->lru_lock,
+							&flags, cc))
+				locked_lruvec = lruvec;
+
+
+			if (lruvec != mem_cgroup_page_lruvec(page, pgdat))
+				goto reget_lruvec;
+
+			rcu_read_unlock();
 
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
@@ -974,9 +1000,9 @@ static bool too_many_isolated(pg_data_t *pgdat)
 				low_pfn += compound_nr(page) - 1;
 				goto isolate_fail;
 			}
-		}
+		} else
+			rcu_read_unlock();
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		/* Try isolate the page */
 		if (__isolate_lru_page(page, isolate_mode) != 0)
@@ -1017,9 +1043,10 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * page anyway.
 		 */
 		if (nr_isolated) {
-			if (locked) {
-				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-				locked = false;
+			if (locked_lruvec) {
+				spin_unlock_irqrestore(&locked_lruvec->lru_lock,
+							flags);
+				locked_lruvec = NULL;
 			}
 			putback_movable_pages(&cc->migratepages);
