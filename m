Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB495B80
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfHTJtt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 05:49:49 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55410 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729761AbfHTJts (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 05:49:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TZznPmz_1566294577;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TZznPmz_1566294577)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 17:49:38 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH 13/14] lru/vmscan: using per lruvec lru_lock in get_scan_count
Date:   Tue, 20 Aug 2019 17:48:36 +0800
Message-Id: <1566294517-86418-14-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The lruvec is passed as parameter, so no lruvec->pgdat syncing needed.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 123447b9beda..ea5c2f3f2567 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2372,7 +2372,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	file  = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES) +
 		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
 
-	spin_lock_irq(&pgdat->lruvec.lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
 	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
 		reclaim_stat->recent_scanned[0] /= 2;
 		reclaim_stat->recent_rotated[0] /= 2;
@@ -2393,7 +2393,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 
 	fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
 	fp /= reclaim_stat->recent_rotated[1] + 1;
-	spin_unlock_irq(&pgdat->lruvec.lru_lock);
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	fraction[0] = ap;
 	fraction[1] = fp;
-- 
1.8.3.1

