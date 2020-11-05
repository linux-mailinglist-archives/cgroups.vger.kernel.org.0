Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085882A79DE
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgKEI5e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 03:57:34 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45526 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730381AbgKEI4R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 03:56:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UEJC3Fv_1604566567;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEJC3Fv_1604566567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 16:56:12 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v21 11/19] mm/vmscan: remove lruvec reget in move_pages_to_lru
Date:   Thu,  5 Nov 2020 16:55:41 +0800
Message-Id: <1604566549-62481-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Isolated page shouldn't be recharged by memcg since the memcg
migration isn't possible at the time. All pages were isolated
from the same lruvec (and isolation inhibits memcg migration).
So remove unnecessary regetting.

Thanks to Alexander Duyck for pointing this out.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 mm/vmscan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d771f812e983..cb2f6256a7d6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1887,7 +1887,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			continue;
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		/*
+		 * All pages were isolated from the same lruvec (and isolation
+		 * inhibits memcg migration).
+		 */
+		VM_BUG_ON_PAGE(mem_cgroup_page_lruvec(page, page_pgdat(page))
+							!= lruvec, page);
 		lru = page_lru(page);
 		nr_pages = thp_nr_pages(page);
 
-- 
1.8.3.1

