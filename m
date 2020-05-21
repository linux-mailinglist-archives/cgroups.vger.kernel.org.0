Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8331DC385
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgEUAYO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 20:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgEUAYO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 May 2020 20:24:14 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B03420823;
        Thu, 21 May 2020 00:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590020653;
        bh=ZoOY+rC/eV6Da9f7fUbDXCoX+1Y8SakH9Q87upnDs5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UDMVLeb7A4fAgMtV8REfo0I+AHavqw2Orjtuqg5yC2rQEdMkXgdniFBzwQzk4avy
         ir3gXWeIIiSVHA4ztlrKXbdVigcHquQb1Ly7qNuvXjw5xup1ziNAPJJqOz3cUW+zZ2
         lAAa6g0tuUAwmeMbtkL4BujQ3h3mFIsUZGr1tGN0=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v5 RESEND 1/4] mm: prepare for swap over-high accounting and penalty calculation
Date:   Wed, 20 May 2020 17:24:08 -0700
Message-Id: <20200521002411.3963032-2-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521002411.3963032-1-kuba@kernel.org>
References: <20200521002411.3963032-1-kuba@kernel.org>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 62 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2df9510b7d64..0d05e6a593f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2302,41 +2302,48 @@ static void high_work_func(struct work_struct *work)
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
 
@@ -2392,7 +2399,8 @@ void mem_cgroup_handle_over_high(void)
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

