Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E321C17B
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2020 03:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGKBAM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 21:00:12 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54338 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgGKA7I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 20:59:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U2KGAZr_1594429139;
Received: from alexshi-test.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2KGAZr_1594429139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jul 2020 08:59:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v16 04/22] mm/compaction: rename compact_deferred as compact_should_defer
Date:   Sat, 11 Jul 2020 08:58:38 +0800
Message-Id: <1594429136-20002-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The compact_deferred is a defer suggestion check, deferring action does in
defer_compaction not here. so, better rename it to avoid confusing.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/compaction.h        | 4 ++--
 include/trace/events/compaction.h | 2 +-
 mm/compaction.c                   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 6fa0eea3f530..be9ed7437a38 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -100,7 +100,7 @@ extern enum compact_result compaction_suitable(struct zone *zone, int order,
 		unsigned int alloc_flags, int highest_zoneidx);
 
 extern void defer_compaction(struct zone *zone, int order);
-extern bool compaction_deferred(struct zone *zone, int order);
+extern bool compaction_should_defer(struct zone *zone, int order);
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
 extern bool compaction_restarting(struct zone *zone, int order);
@@ -199,7 +199,7 @@ static inline void defer_compaction(struct zone *zone, int order)
 {
 }
 
-static inline bool compaction_deferred(struct zone *zone, int order)
+static inline bool compaction_should_defer(struct zone *zone, int order)
 {
 	return true;
 }
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 54e5bf081171..33633c71df04 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -274,7 +274,7 @@
 		1UL << __entry->defer_shift)
 );
 
-DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_deferred,
+DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_should_defer,
 
 	TP_PROTO(struct zone *zone, int order),
 
diff --git a/mm/compaction.c b/mm/compaction.c
index cd1ef9e5e638..f14780fc296a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -154,7 +154,7 @@ void defer_compaction(struct zone *zone, int order)
 }
 
 /* Returns true if compaction should be skipped this time */
-bool compaction_deferred(struct zone *zone, int order)
+bool compaction_should_defer(struct zone *zone, int order)
 {
 	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
 
@@ -168,7 +168,7 @@ bool compaction_deferred(struct zone *zone, int order)
 	if (zone->compact_considered >= defer_limit)
 		return false;
 
-	trace_mm_compaction_deferred(zone, order);
+	trace_mm_compaction_should_defer(zone, order);
 
 	return true;
 }
@@ -2377,7 +2377,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		enum compact_result status;
 
 		if (prio > MIN_COMPACT_PRIORITY
-					&& compaction_deferred(zone, order)) {
+				&& compaction_should_defer(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
 			continue;
 		}
@@ -2561,7 +2561,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (compaction_deferred(zone, cc.order))
+		if (compaction_should_defer(zone, cc.order))
 			continue;
 
 		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
-- 
1.8.3.1

