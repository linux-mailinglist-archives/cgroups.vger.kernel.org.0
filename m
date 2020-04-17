Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B701AD3F1
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgDQBGn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Apr 2020 21:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgDQBGn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 Apr 2020 21:06:43 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B0E221F9;
        Fri, 17 Apr 2020 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587085602;
        bh=wwP2ZQQOucH3tqgJbeyLtNHf8l02/Io71xBhQiVmaBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIC1YsSJ56PA7bAPrRkZRXL+0/4wHL4BFl+1q2ZEiONJb6PIaA9gqf2hymFlLIAMm
         dT+PvUNy0y0PAfq5T9eig0Iaxpiv96x+ggDJfNnS8wJeBi3AtRtTH/tO2C3XsUddcD
         1sebrVtBC/9YA1jPA9aXD0sg4XSmSfrWAWt4sg7Y=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/3] mm: prepare for swap over-high accounting and penalty calculation
Date:   Thu, 16 Apr 2020 18:06:15 -0700
Message-Id: <20200417010617.927266-2-kuba@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417010617.927266-1-kuba@kernel.org>
References: <20200417010617.927266-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Slice the memory overage calculation logic a little bit so we can
reuse it to apply a similar penalty to the swap. The logic which
accesses the memory-specific fields (use and high values) has to
be taken out of calculate_high_delay().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
change log including private exchanges with Johannes:

v0.4: calculate max outside of calculate_overage()
---
 mm/memcontrol.c | 62 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75a978307863..9bfb7dcb3489 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2319,41 +2319,48 @@ static void high_work_func(struct work_struct *work)
  #define MEMCG_DELAY_PRECISION_SHIFT 20
  #define MEMCG_DELAY_SCALING_SHIFT 14
 
-/*
- * Get the number of jiffies that we should penalise a mischievous cgroup which
- * is exceeding its memory.high by checking both it and its ancestors.
- */
-static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
-					  unsigned int nr_pages)
+static u64 calculate_overage(unsigned long usage, unsigned long high)
 {
-	unsigned long penalty_jiffies;
-	u64 max_overage = 0;
-
-	do {
-		unsigned long usage, high;
-		u64 overage;
+	u64 overage;
 
-		usage = page_counter_read(&memcg->memory);
-		high = READ_ONCE(memcg->high);
+	if (usage <= high)
+		return 0;
 
-		if (usage <= high)
-			continue;
+	/*
+	 * Prevent division by 0 in overage calculation by acting as if
+	 * it was a threshold of 1 page
+	 */
+	high = max(high, 1UL);
 
-		/*
-		 * Prevent division by 0 in overage calculation by acting as if
-		 * it was a threshold of 1 page
-		 */
-		high = max(high, 1UL);
+	overage = usage - high;
+	overage <<= MEMCG_DELAY_PRECISION_SHIFT;
+	return div64_u64(overage, high);
+}
 
-		overage = usage - high;
-		overage <<= MEMCG_DELAY_PRECISION_SHIFT;
-		overage = div64_u64(overage, high);
+static u64 mem_find_max_overage(struct mem_cgroup *memcg)
+{
+	u64 overage, max_overage = 0;
 
-		if (overage > max_overage)
-			max_overage = overage;
+	do {
+		overage = calculate_overage(page_counter_read(&memcg->memory),
+					    READ_ONCE(memcg->high));
+		max_overage = max(overage, max_overage);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
 
+	return max_overage;
+}
+
+/*
+ * Get the number of jiffies that we should penalise a mischievous cgroup which
+ * is exceeding its memory.high by checking both it and its ancestors.
+ */
+static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
+					  unsigned int nr_pages,
+					  u64 max_overage)
+{
+	unsigned long penalty_jiffies;
+
 	if (!max_overage)
 		return 0;
 
@@ -2409,7 +2416,8 @@ void mem_cgroup_handle_over_high(void)
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
 	 */
-	penalty_jiffies = calculate_high_delay(memcg, nr_pages);
+	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
+					       mem_find_max_overage(memcg));
 
 	/*
 	 * Don't sleep if the amount of jiffies this memcg owes us is so low
-- 
2.25.2

