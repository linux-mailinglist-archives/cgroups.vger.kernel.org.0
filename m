Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC41DC381
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgEUAUP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 20:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgEUAUO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 May 2020 20:20:14 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB292089D;
        Thu, 21 May 2020 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590020414;
        bh=fYQ8OnJ3Ge66iWFEzeoxN//qddjlscbQeoZisEJJtEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vH8Skx5wIZQBNkoWoF7HOUmn4NI2z0P+lPpexlg3PP3DougsnPWjPAlei0mVt4+Hr
         H3u2tHXOFgl7LHdbPZZjW8aBoMw8sYHbzIPtUYwIihgg23bq+H44uXI/folb8Ukwau
         4y19AjSL2dM67jdfpyVLejMgRkXMHz4lZhQerw1Q=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v5 3/4] mm: move cgroup high memory limit setting into struct page_counter
Date:   Wed, 20 May 2020 17:20:09 -0700
Message-Id: <20200521002010.3962544-4-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521002010.3962544-1-kuba@kernel.org>
References: <20200521002010.3962544-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

High memory limit is currently recorded directly in
struct mem_cgroup. We are about to add a high limit
for swap, move the field to struct page_counter and
add some helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v5: make page_counter_set_high() a static inline in the header
v4: new patch
---
 include/linux/memcontrol.h   |  3 ---
 include/linux/page_counter.h | 13 +++++++++++++
 mm/memcontrol.c              | 17 +++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e0bcef180672..d726867d8af9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -206,9 +206,6 @@ struct mem_cgroup {
 	struct page_counter kmem;
 	struct page_counter tcpmem;
 
-	/* Upper bound of normal memory consumption range */
-	unsigned long high;
-
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index bab7e57f659b..6a89ff948412 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -10,6 +10,7 @@ struct page_counter {
 	atomic_long_t usage;
 	unsigned long min;
 	unsigned long low;
+	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
 
@@ -55,6 +56,13 @@ bool page_counter_try_charge(struct page_counter *counter,
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+
+static inline void page_counter_set_high(struct page_counter *counter,
+					 unsigned long nr_pages)
+{
+	WRITE_ONCE(counter->high, nr_pages);
+}
+
 int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
@@ -64,4 +72,9 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = page_counter_read(counter);
 }
 
+static inline bool page_counter_is_above_high(struct page_counter *counter)
+{
+	return page_counter_read(counter) > READ_ONCE(counter->high);
+}
+
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dd8605a9137a..d4b7bc80aa38 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2233,7 +2233,7 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			 gfp_t gfp_mask)
 {
 	do {
-		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
+		if (!page_counter_is_above_high(&memcg->memory))
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
@@ -2326,7 +2326,7 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 
 	do {
 		overage = calculate_overage(page_counter_read(&memcg->memory),
-					    READ_ONCE(memcg->high));
+					    READ_ONCE(memcg->memory.high));
 		max_overage = max(overage, max_overage);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2585,7 +2585,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
+		if (page_counter_is_above_high(&memcg->memory)) {
 			/* Don't bother a random interrupted task */
 			if (in_interrupt()) {
 				schedule_work(&memcg->high_work);
@@ -4286,7 +4286,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 
 	while ((parent = parent_mem_cgroup(memcg))) {
 		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
-					    READ_ONCE(memcg->high));
+					    READ_ONCE(memcg->memory.high));
 		unsigned long used = page_counter_read(&memcg->memory);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
@@ -5011,7 +5011,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
 
-	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
@@ -5164,7 +5164,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -5984,7 +5984,8 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 
 static int memory_high_show(struct seq_file *m, void *v)
 {
-	return seq_puts_memcg_tunable(m, READ_ONCE(mem_cgroup_from_seq(m)->high));
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.high));
 }
 
 static ssize_t memory_high_write(struct kernfs_open_file *of,
@@ -6001,7 +6002,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	WRITE_ONCE(memcg->high, high);
+	page_counter_set_high(&memcg->memory, high);
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
-- 
2.25.4

