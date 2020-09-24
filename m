Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9098D276755
	for <lists+cgroups@lfdr.de>; Thu, 24 Sep 2020 05:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIXD3L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Sep 2020 23:29:11 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41282 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgIXD2t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Sep 2020 23:28:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0U9w0Ss1_1600918116;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9w0Ss1_1600918116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 11:28:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v19 12/20] mm/vmscan: remove lruvec reget in move_pages_to_lru
Date:   Thu, 24 Sep 2020 11:28:27 +0800
Message-Id: <1600918115-22007-13-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
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
index 656558bbf399..953a068b3fc7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1885,7 +1885,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			continue;
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		VM_BUG_ON_PAGE(mem_cgroup_page_lruvec(page, page_pgdat(page))
+							!= lruvec, page);
 		lru = page_lru(page);
 		nr_pages = thp_nr_pages(page);
 
-- 
1.8.3.1

