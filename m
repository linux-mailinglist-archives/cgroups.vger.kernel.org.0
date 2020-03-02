Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B471758FE
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCBLCG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:02:06 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48721 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727978AbgCBLCF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:02:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrQmbfl_1583146861;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrQmbfl_1583146861)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:01:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 17/20] mm/pgdat: remove pgdat lru_lock
Date:   Mon,  2 Mar 2020 19:00:27 +0800
Message-Id: <1583146830-169516-18-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 include/linux/mmzone.h | 1 -
 mm/page_alloc.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a7bdff94990d..f1ff6713ac06 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -768,7 +768,6 @@ struct deferred_split {
 
 	/* Write-intensive fields used by page reclaim */
 	ZONE_PADDING(_pad1_)
-	spinlock_t		lru_lock;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..8c7df304bcd1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6709,7 +6709,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
 
 	pgdat_page_ext_init(pgdat);
-	spin_lock_init(&pgdat->lru_lock);
 	lruvec_init(&pgdat->__lruvec);
 }
 
-- 
1.8.3.1

