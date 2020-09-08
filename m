Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D88260F94
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIHKZb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 06:25:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48595 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729031AbgIHKZ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 06:25:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U8IvCd8_1599560724;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8IvCd8_1599560724)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Sep 2020 18:25:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH] mm/memcg: rename watermark as max_usage
Date:   Tue,  8 Sep 2020 18:25:21 +0800
Message-Id: <1599560721-68915-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The page_counter's watermark used to show as max_usage_in_bytes in memory
cgroup. named as watermark is a kind of misleadking. So, let's rename it
as it usage.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
Cc: linux-kernel@vger.kernel.org 
Cc: linux-mm@kvack.org 
Cc: cgroups@vger.kernel.org 
---
 include/linux/page_counter.h |  6 +++---
 mm/hugetlb_cgroup.c          |  8 ++++----
 mm/memcontrol.c              |  4 ++--
 mm/page_counter.c            | 12 ++++++------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 85bd413e784e..813f2da26c36 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -25,7 +25,7 @@ struct page_counter {
 	atomic_long_t children_low_usage;
 
 	/* legacy */
-	unsigned long watermark;
+	unsigned long max_usage;	/* max_usage_in_bytes */
 	unsigned long failcnt;
 };
 
@@ -67,9 +67,9 @@ static inline void page_counter_set_high(struct page_counter *counter,
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
-static inline void page_counter_reset_watermark(struct page_counter *counter)
+static inline void page_counter_reset_max_usage(struct page_counter *counter)
 {
-	counter->watermark = page_counter_read(counter);
+	counter->max_usage = page_counter_read(counter);
 }
 
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 1f87aec9ab5c..c7484f5eb8ef 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -437,9 +437,9 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 	case RES_RSVD_LIMIT:
 		return (u64)rsvd_counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return (u64)counter->max_usage * PAGE_SIZE;
 	case RES_RSVD_MAX_USAGE:
-		return (u64)rsvd_counter->watermark * PAGE_SIZE;
+		return (u64)rsvd_counter->max_usage * PAGE_SIZE;
 	case RES_FAILCNT:
 		return counter->failcnt;
 	case RES_RSVD_FAILCNT:
@@ -553,10 +553,10 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_max_usage(counter);
 		break;
 	case RES_RSVD_MAX_USAGE:
-		page_counter_reset_watermark(rsvd_counter);
+		page_counter_reset_max_usage(rsvd_counter);
 		break;
 	case RES_FAILCNT:
 		counter->failcnt = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c74f1200261..21b73de53073 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3559,7 +3559,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	case RES_LIMIT:
 		return (u64)counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return (u64)counter->max_usage * PAGE_SIZE;
 	case RES_FAILCNT:
 		return counter->failcnt;
 	case RES_SOFT_LIMIT:
@@ -3839,7 +3839,7 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_max_usage(counter);
 		break;
 	case RES_FAILCNT:
 		counter->failcnt = 0;
diff --git a/mm/page_counter.c b/mm/page_counter.c
index afe22ad335cc..d88ee074f4a6 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -75,10 +75,10 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		propagate_protected_usage(c, new);
 		/*
 		 * This is indeed racy, but we can live with some
-		 * inaccuracy in the watermark.
+		 * inaccuracy in the max_usage.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->max_usage))
+			WRITE_ONCE(c->max_usage, new);
 	}
 }
 
@@ -129,10 +129,10 @@ bool page_counter_try_charge(struct page_counter *counter,
 		propagate_protected_usage(c, new);
 		/*
 		 * Just like with failcnt, we can live with some
-		 * inaccuracy in the watermark.
+		 * inaccuracy in the max_usage.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->max_usage))
+			WRITE_ONCE(c->max_usage, new);
 	}
 	return true;
 
-- 
1.8.3.1

