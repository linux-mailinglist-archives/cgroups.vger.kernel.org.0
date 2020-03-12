Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E1183826
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCLSDJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 14:03:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50889 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgCLSDJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 14:03:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id a5so7118860wmb.0
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=db1bUIPese8tjEPtKXx5DKELzL2SGDYpGP6uaK+iPYk=;
        b=tmWupmQn6aBGlxS345WRGAZeHC8WXMQPju9i7p6QnNUOSx21Xp5MO9v9Bmms9+plRJ
         aJHMDf/lddi7gNlBlJeMQXSy5Wu0fY67UMHLwg5PDMHqLMs3SJUAGd11Z4nrIo5kdDkN
         sNB9XXE0s93VkX6/77RkeFloCCdRWi7p6Kq7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=db1bUIPese8tjEPtKXx5DKELzL2SGDYpGP6uaK+iPYk=;
        b=jZ9FegUR6h3aWwUmZ3HY550cbtsZNM6rVURwfcDhsg3LPmERwD6/lFjTSnzbk3t+QA
         L8NZcGZwiqZsIrDugSLZQCRmSWHkpltLAsvR/sfSBxztkQFvLt9TS3XQ5Ubyty6qqI2W
         Kj61WNQI25zY1GtHIH8EGfHRNCx+RJQ4WN2sjhUlU1Wuq0coaNChT7C24VgKqKLvpGfV
         p5ZyWwuusW+xoU8bmOJCTSb9HvwJ6hH4BDHxf1q5LsUN4L6Lc2haXH6G48FhDfW77A8u
         ictTkXQTWeC2vbhr86tq6MLFemG4g962k9TR4tiQAh9qkiNRZyU2RxT7zYd+Cdcp5tcY
         xAYg==
X-Gm-Message-State: ANhLgQ0uHj5lNhJ7pfUCdWTzruUGDZT+8062vRLUDDRL6Q6BiUamf9dp
        duNE1xtj33O7gUAp726/pygaYQ==
X-Google-Smtp-Source: ADFU+vutvYGFAV1tB5uHMNz9p4y1YcFFQjkvM+h/eK2G2W26UXo6YFXBHS4vT87Cr98Fz+Y5NXotTA==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr6075251wmf.85.1584036185206;
        Thu, 12 Mar 2020 11:03:05 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id b141sm14147822wme.2.2020.03.12.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:03:04 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:03:04 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] mm, memcg: Throttle allocators based on ancestral
 memory.high
Message-ID: <8cd132f84bd7e16cdb8fde3378cdbf05ba00d387.1584036142.git.chris@chrisdown.name>
References: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prior to this commit, we only directly check the affected cgroup's
memory.high against its usage. However, it's possible that we are being
reclaimed as a result of hitting an ancestor memory.high and should be
penalised based on that, instead.

This patch changes memory.high overage throttling to use the largest
overage in its ancestors when considering how many penalty jiffies to
charge. This makes sure that we penalise poorly behaving cgroups in the
same way regardless of at what level of the hierarchy memory.high was
breached.

Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org # 5.4.x
---
 mm/memcontrol.c | 93 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a70206e516fe..46d649241a21 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2297,28 +2297,41 @@ static void high_work_func(struct work_struct *work)
  #define MEMCG_DELAY_SCALING_SHIFT 14
 
 /*
- * Scheduled by try_charge() to be executed from the userland return path
- * and reclaims memory over the high limit.
+ * Get the number of jiffies that we should penalise a mischievous cgroup which
+ * is exceeding its memory.high by checking both it and its ancestors.
  */
-void mem_cgroup_handle_over_high(void)
+static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
+					  unsigned int nr_pages)
 {
-	unsigned long usage, high, clamped_high;
-	unsigned long pflags;
-	unsigned long penalty_jiffies, overage;
-	unsigned int nr_pages = current->memcg_nr_pages_over_high;
-	struct mem_cgroup *memcg;
+	unsigned long penalty_jiffies;
+	u64 max_overage = 0;
 
-	if (likely(!nr_pages))
-		return;
+	do {
+		unsigned long usage, high;
+		u64 overage;
 
-	memcg = get_mem_cgroup_from_mm(current->mm);
-	reclaim_high(memcg, nr_pages, GFP_KERNEL);
-	current->memcg_nr_pages_over_high = 0;
+		usage = page_counter_read(&memcg->memory);
+		high = READ_ONCE(memcg->high);
+
+		/*
+		 * Prevent division by 0 in overage calculation by acting as if
+		 * it was a threshold of 1 page
+		 */
+		high = max(high, 1UL);
+
+		overage = usage - high;
+		overage <<= MEMCG_DELAY_PRECISION_SHIFT;
+		overage = div64_u64(overage, high);
+
+		if (overage > max_overage)
+			max_overage = overage;
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		 !mem_cgroup_is_root(memcg));
+
+	if (!max_overage)
+		return 0;
 
 	/*
-	 * memory.high is breached and reclaim is unable to keep up. Throttle
-	 * allocators proactively to slow down excessive growth.
-	 *
 	 * We use overage compared to memory.high to calculate the number of
 	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
 	 * fairly lenient on small overages, and increasingly harsh when the
@@ -2326,24 +2339,9 @@ void mem_cgroup_handle_over_high(void)
 	 * its crazy behaviour, so we exponentially increase the delay based on
 	 * overage amount.
 	 */
-
-	usage = page_counter_read(&memcg->memory);
-	high = READ_ONCE(memcg->high);
-
-	if (usage <= high)
-		goto out;
-
-	/*
-	 * Prevent division by 0 in overage calculation by acting as if it was a
-	 * threshold of 1 page
-	 */
-	clamped_high = max(high, 1UL);
-
-	overage = div64_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
-			  clamped_high);
-
-	penalty_jiffies = ((u64)overage * overage * HZ)
-		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
+	penalty_jiffies = max_overage * max_overage * HZ;
+	penalty_jiffies >>= MEMCG_DELAY_PRECISION_SHIFT;
+	penalty_jiffies >>= MEMCG_DELAY_SCALING_SHIFT;
 
 	/*
 	 * Factor in the task's own contribution to the overage, such that four
@@ -2360,7 +2358,32 @@ void mem_cgroup_handle_over_high(void)
 	 * application moving forwards and also permit diagnostics, albeit
 	 * extremely slowly.
 	 */
-	penalty_jiffies = min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+	return min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+}
+
+/*
+ * Scheduled by try_charge() to be executed from the userland return path
+ * and reclaims memory over the high limit.
+ */
+void mem_cgroup_handle_over_high(void)
+{
+	unsigned long penalty_jiffies;
+	unsigned long pflags;
+	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	struct mem_cgroup *memcg;
+
+	if (likely(!nr_pages))
+		return;
+
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	reclaim_high(memcg, nr_pages, GFP_KERNEL);
+	current->memcg_nr_pages_over_high = 0;
+
+	/*
+	 * memory.high is breached and reclaim is unable to keep up. Throttle
+	 * allocators proactively to slow down excessive growth.
+	 */
+	penalty_jiffies = calculate_high_delay(memcg, nr_pages);
 
 	/*
 	 * Don't sleep if the amount of jiffies this memcg owes us is so low
-- 
2.25.1

