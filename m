Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8423D152
	for <lists+cgroups@lfdr.de>; Wed,  5 Aug 2020 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHET6i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Aug 2020 15:58:38 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:41933 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbgHEQmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Aug 2020 12:42:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U4paFMA_1596632569;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4paFMA_1596632569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Aug 2020 21:02:49 +0800
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <5622ef68-5e70-d1a9-d1be-b45411b6be5c@linux.alibaba.com>
Date:   Wed, 5 Aug 2020 21:02:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <92dd8e68-8095-72c5-0144-2a084e4d5993@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/5 下午8:28, Alex Shi 写道:
> The last patch has a problem on define. this version could fix it.
> 
> BTW, I see some !memcg happens when MEMCG compilered but disabled by cgroup_disable
> 
> 
> [   94.657666] ---[ end trace f1f34bfc3b32ed2f ]---
> [   95.138995] anon flags: 0x5005b48008000d(locked|uptodate|dirty|swapbacked)
> [   95.146220] raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
> [   95.154549] raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
> [   95.162876] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> 
> 

The following patch may helpful.

From 8bfb26a2e37e08dc61d20212bcfa5812a367ba94 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Wed, 5 Aug 2020 20:32:12 +0800
Subject: [PATCH] mm/memcg: don't try charge swap if memcg disabled

If we disabled memcg by cgroup_disable=memory, the swap charges are
still called. Let's return from the funcs earlier and keep WARN_ON
monitor.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb07a48d53aa..65f2b42d25af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7163,6 +7163,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
@@ -7228,6 +7231,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
+	if (mem_cgroup_disabled())
+		return 0;
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
-- 
1.8.3.1

