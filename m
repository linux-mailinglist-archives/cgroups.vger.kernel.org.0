Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0A29FB9E
	for <lists+cgroups@lfdr.de>; Fri, 30 Oct 2020 03:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ3CtG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 22:49:06 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43121 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbgJ3CtF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 22:49:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UDb1Q6i_1604026140;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDb1Q6i_1604026140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Oct 2020 10:49:01 +0800
Subject: Re: [PATCH v20 04/20] mm/thp: use head for head page in
 lru_add_page_tail
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
 <20201029135047.GE599825@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <06a5b7d8-bbf2-51b7-1352-2b630186e15f@linux.alibaba.com>
Date:   Fri, 30 Oct 2020 10:46:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029135047.GE599825@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/10/29 ÏÂÎç9:50, Johannes Weiner Ð´µÀ:
> On Thu, Oct 29, 2020 at 06:44:49PM +0800, Alex Shi wrote:
>> Since the first parameter is only used by head page, it's better to make
>> it explicit.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/huge_memory.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 038db815ebba..93c0b73eb8c6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2346,19 +2346,19 @@ static void remap_page(struct page *page, unsigned int nr)
>>  	}
>>  }
>>  
>> -static void lru_add_page_tail(struct page *page, struct page *page_tail,
>> +static void lru_add_page_tail(struct page *head, struct page *page_tail,
> 
> It may be better to pick either
> 	head and tail

Hi Johannes,

Thanks for comments!

Right, Consider functions in this file are using head/tail more as parameters
I will change to use head/tail too. And then, the 04th, 05th, and 18th patch 
will be changed accordingly.

Thanks
Alex

> or
> 	page_head and page_tail
> 
> ?
> 

From a9ee63a213f40eb4d5a69b52fbb348ff9cd7cf6c Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 26 May 2020 16:49:22 +0800
Subject: [PATCH v21 04/20] mm/thp: use head for head page in lru_add_page_tail

Since the first parameter is only used by head page, it's better to make
it explicit.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/huge_memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 038db815ebba..32a4bf5b80c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2346,33 +2346,32 @@ static void remap_page(struct page *page, unsigned int nr)
 	}
 }
 
-static void lru_add_page_tail(struct page *page, struct page *page_tail,
+static void lru_add_page_tail(struct page *head, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
-	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
+	VM_BUG_ON_PAGE(!PageHead(head), head);
+	VM_BUG_ON_PAGE(PageCompound(tail), head);
+	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
 
 	if (!list)
-		SetPageLRU(page_tail);
+		SetPageLRU(tail);
 
-	if (likely(PageLRU(page)))
-		list_add_tail(&page_tail->lru, &page->lru);
+	if (likely(PageLRU(head)))
+		list_add_tail(&tail->lru, &head->lru);
 	else if (list) {
 		/* page reclaim is reclaiming a huge page */
-		get_page(page_tail);
-		list_add_tail(&page_tail->lru, list);
+		get_page(tail);
+		list_add_tail(&tail->lru, list);
 	} else {
 		/*
 		 * Head page has not yet been counted, as an hpage,
 		 * so we must account for each subpage individually.
 		 *
-		 * Put page_tail on the list at the correct position
+		 * Put tail on the list at the correct position
 		 * so they all end up in order.
 		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
+		add_page_to_lru_list_tail(tail, lruvec, page_lru(tail));
 	}
 }
 
-- 
1.8.3.1

