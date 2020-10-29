Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1529E95F
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 11:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgJ2Kq0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 06:46:26 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59754 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgJ2Kpl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 06:45:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UDXwDyN_1603968328;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDXwDyN_1603968328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Oct 2020 18:45:33 +0800
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
Subject: [PATCH v20 12/20] mm/vmscan: remove lruvec reget in move_pages_to_lru
Date:   Thu, 29 Oct 2020 18:44:57 +0800
Message-Id: <1603968305-8026-13-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A isolated page shouldn't be recharged by memcg since the memcg
migration isn't possible at the time.
So remove unnecessary regetting.

Thanks to Alexander Duyck for pointing this out.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Acked-by: Hugh Dickins <hughd@google.com>
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
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 42bac12aacb4..845733afccde 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1887,7 +1887,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			continue;
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		VM_BUG_ON_PAGE(mem_cgroup_page_lruvec(page, page_pgdat(page))
+							!= lruvec, page);
 		lru = page_lru(page);
 		nr_pages = thp_nr_pages(page);
 
-- 
1.8.3.1

