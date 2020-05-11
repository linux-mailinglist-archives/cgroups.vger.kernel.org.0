Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6747E1CE895
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 00:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEKWzb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 18:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKWzb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 May 2020 18:55:31 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F11B2075E;
        Mon, 11 May 2020 22:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589237730;
        bh=hPqe/05rnU2qdGjFk4enrQ1+qhpSIPRruaw+FWrv/LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2dLXmEh0CKBx9VFApsDss2e5KCl8DyX4XBB2a6yvgq6nUKiDvzxgzmhPxH2P0HVv
         y/u/H8BUsrJfjDRZlulnyIFUOa1t2633inD5FBCT8CxVxzw98RN10xChEdedn+TyIO
         hD/9mMEX97ho/kShv/lNAlH7Mo04AX65nsEH3Otk=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v2 1/3] mm: prepare for swap over-high accounting and penalty calculation
Date:   Mon, 11 May 2020 15:55:14 -0700
Message-Id: <20200511225516.2431921-2-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200511225516.2431921-1-kuba@kernel.org>
References: <20200511225516.2431921-1-kuba@kernel.org>
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
 mm/memcontrol.c | 62 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05dcb72314b5..8a9b671c3249 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2321,41 +2321,48 @@ static void high_work_func(struct work_struct *work)
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
 
@@ -2411,7 +2418,8 @@ void mem_cgroup_handle_over_high(void)
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
 	 */
-	penalty_jiffies = calculate_high_delay(memcg, nr_pages);
+	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
+					       mem_find_max_overage(memcg));
 
 	/*
 	 * Don't sleep if the amount of jiffies this memcg owes us is so low
-- 
2.25.4

