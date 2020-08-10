Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412CC2402F0
	for <lists+cgroups@lfdr.de>; Mon, 10 Aug 2020 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgHJHos (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Aug 2020 03:44:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43021 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgHJHoq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Aug 2020 03:44:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U5HBimS_1597045472;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5HBimS_1597045472)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 15:44:33 +0800
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200731151655.GB491801@cmpxchg.org>
 <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
 <20200803081815.GD5174@dhcp22.suse.cz>
 <bd61e672-b997-c4cd-2047-fca9dc11cc4c@linux.alibaba.com>
 <92dd8e68-8095-72c5-0144-2a084e4d5993@linux.alibaba.com>
 <5622ef68-5e70-d1a9-d1be-b45411b6be5c@linux.alibaba.com>
 <4740bac1-72f6-a640-ab6a-a8801e68c27a@linux.alibaba.com>
 <20200808214306.GA1409287@carbon.dhcp.thefacebook.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e0529759-f9a8-a038-e49d-185d6c9ed845@linux.alibaba.com>
Date:   Mon, 10 Aug 2020 15:44:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200808214306.GA1409287@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/9 上午5:43, Roman Gushchin 写道:
>>>  mm/memcontrol.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index cb07a48d53aa..65f2b42d25af 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -7163,6 +7163,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>>>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>>>  	VM_BUG_ON_PAGE(page_count(page), page);
>>>  
>>> +	if (mem_cgroup_disabled())
>>> +		return;
>>> +
>>>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>>  		return;
>>>  
>>> @@ -7228,6 +7231,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>>>  	struct mem_cgroup *memcg;
>>>  	unsigned short oldid;
>>>  
>>> +	if (mem_cgroup_disabled())
>>> +		return 0;
>>> +
>>>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>>  		return 0;
>>>  
>>>
> 
> Hi Alex,
> 
> this patch looks good to me. Please, feel free to add
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks a lot!
> 
> What's the second patch?
> 

It's the patch, 
https://www.spinics.net/lists/linux-mm/msg222228.html
or

From 2ca3e87fd3878ab729551682ad083a70f15bb3fc Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sat, 1 Aug 2020 10:43:55 +0800
Subject: [PATCH v3] mm/memcg: warning on !memcg after readahead page charged

Since readahead page is charged on memcg too, in theory we don't have to
check this exception now. Before safely remove them all, add a warning
for the unexpected !memcg.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mmdebug.h | 13 +++++++++++++
 mm/memcontrol.c         | 15 ++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 2ad72d2c8cc5..4ed52879ce55 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -37,6 +37,18 @@
 			BUG();						\
 		}							\
 	} while (0)
+#define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
+	static bool __section(.data.once) __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
+
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
 #define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
@@ -48,6 +60,7 @@
 #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
 #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 130093bdf74b..299382fc55a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1322,10 +1322,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	}
 
 	memcg = page->mem_cgroup;
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
+	/* Readahead page is charged too, to see if other page uncharged */
+	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
@@ -6906,8 +6904,9 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (newpage->mem_cgroup)
 		return;
 
-	/* Swapcache readahead pages can get replaced before being charged */
 	memcg = oldpage->mem_cgroup;
+	/* Readahead page is charged too, to see if other page uncharged */
+	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
 	if (!memcg)
 		return;
 
@@ -7104,7 +7103,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 
 	memcg = page->mem_cgroup;
 
-	/* Readahead page, never charged */
+	/* Readahead page is charged too, to see if other page uncharged */
+	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
 		return;
 
@@ -7168,7 +7168,8 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 
 	memcg = page->mem_cgroup;
 
-	/* Readahead page, never charged */
+	/* Readahead page is charged too, to see if other page uncharged */
+	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
 		return 0;
 
-- 
1.8.3.1

