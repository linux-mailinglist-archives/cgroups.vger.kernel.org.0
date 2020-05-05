Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06FE1C50A5
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEEImW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgEEImV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 04:42:21 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF0C061A0F;
        Tue,  5 May 2020 01:42:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so355696plt.5;
        Tue, 05 May 2020 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFskabmmHvp4C/dLmH3xd8j3vuwmgpDBL417EZ/Ewyw=;
        b=ZE2IcKT/v16LxgSX7/LGBmaV8h9lSA3IAukZ28Yx3M0eVAZgzcocSZ0N+LHp1V40s/
         6h6OLhHJA6bW3SOc/Dt6jxIAL/bMJ2HrPGg+Ke3WpjWa1vfh9MnBBaqxDxq67avZXdDj
         bOPli6joNV1r3S042vpilqGizaljOVRYRp0Q2dCmrMM9oS0GSeyOii4C7GdHLsH/FvFK
         wK3Ntb/KCfmiceYN2owoId25A7cE6SMt8Nnpeb2NLQv5hPFmpR/j1aqgBsaibPw8nQb9
         KXW5IL0W6pAkFmfB18b1kx9pyFA/ifrXLUMTt3r5q0Eznw5yM7kYH25VToF04s6ezP84
         UkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFskabmmHvp4C/dLmH3xd8j3vuwmgpDBL417EZ/Ewyw=;
        b=OYw2CiSgI3d85XbsJNPJOkvq2jmA+I8NynhiF+jndDNc/Ii373yh+JG1LMpwMVDU6z
         81viVserLJFKlHNDHG/jLpHBL1iKweH4OvO0pzxTCjY1U/Tq+v19bnt0hCa4Jda95A06
         FjNb0NiZeA3VmOGA+Yqh+f4SgEMScEXOe4zCh9tMdzTVx0BZGmRKdx+KwH2UupzukZ32
         5TyVpg5UaNBNoxxeVLGXSYSNWvgqtNkOS7HALZOkhx0JygNKX8x0s8JVc6zyP1lazWNW
         lX1o71QnqyXi13Seyp+Tn/FKAT9AysVjhSBIQg5GBqmAYHYF2NGpJWfUvrUvvBo7qaMW
         IzQA==
X-Gm-Message-State: AGi0PuYtq2Fsr0MeLg+7ZUD9wVgZFWIHq1Bs1Nf5MIelO2bLo/7d1aiE
        ckofTdcRueq6XqvjxNLNPPA=
X-Google-Smtp-Source: APiQypLkIBAw7b/wIXu/OuUUdCasl8aw/yoD+hgWC91mTpRhXmosnl4Jl/TBALIdaVOQ2vde7kbg9Q==
X-Received: by 2002:a17:90a:734b:: with SMTP id j11mr1661343pjs.108.1588668140507;
        Tue, 05 May 2020 01:42:20 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p190sm1443802pfp.207.2020.05.05.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:42:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations from protection checks
Date:   Tue,  5 May 2020 04:41:27 -0400
Message-Id: <20200505084127.12923-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200505084127.12923-1-laoar.shao@gmail.com>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chris Down <chris@chrisdown.name>

mem_cgroup_protected currently is both used to set effective low and min
and return a mem_cgroup_protection based on the result.  As a user, this
can be a little unexpected: it appears to be a simple predicate function,
if not for the big warning in the comment above about the order in which
it must be executed.

This change makes it so that we separate the state mutations from the
actual protection checks, which makes it more obvious where we need to be
careful mutating internal state, and where we are simply checking and
don't need to worry about that.

Signed-off-by: Chris Down <chris@chrisdown.name>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 43 ++++++++++++++++++++++++++++----------
 mm/memcontrol.c            | 28 +++++++------------------
 mm/vmscan.c                | 17 ++++-----------
 3 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c07548ce26cb..7a2c56fc220c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -50,12 +50,6 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
-enum mem_cgroup_protection {
-	MEMCG_PROT_NONE,
-	MEMCG_PROT_LOW,
-	MEMCG_PROT_MIN,
-};
-
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	unsigned int generation;
@@ -394,8 +388,26 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
 		   READ_ONCE(memcg->memory.elow));
 }
 
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg);
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg);
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	return READ_ONCE(memcg->memory.elow) >=
+		page_counter_read(&memcg->memory);
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	return READ_ONCE(memcg->memory.emin) >=
+		page_counter_read(&memcg->memory);
+}
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -879,10 +891,19 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *root,
 	return 0;
 }
 
-static inline enum mem_cgroup_protection mem_cgroup_protected(
-	struct mem_cgroup *root, struct mem_cgroup *memcg)
+static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg)
+{
+}
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
 {
-	return MEMCG_PROT_NONE;
+	return false;
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+	return false;
 }
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1206682edc1a..474815acaf93 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6370,21 +6370,15 @@ static unsigned long effective_protection(unsigned long usage,
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
- *
- * Returns one of the following:
- *   MEMCG_PROT_NONE: cgroup memory is not protected
- *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
- *     an unprotected supply of reclaimable memory from other cgroups.
- *   MEMCG_PROT_MIN: cgroup memory is protected
  */
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg)
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg)
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
 
 	if (mem_cgroup_disabled())
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (!root)
 		root = root_mem_cgroup;
@@ -6397,21 +6391,21 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	 * that special casing.
 	 */
 	if (memcg == root)
-		return MEMCG_PROT_NONE;
+		return;
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-		return MEMCG_PROT_NONE;
+		return;
 
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
 	if (!parent)
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
 		memcg->memory.elow = memcg->memory.low;
-		goto out;
+		return;
 	}
 
 	parent_usage = page_counter_read(&parent->memory);
@@ -6424,14 +6418,6 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
 			memcg->memory.low, READ_ONCE(parent->memory.elow),
 			atomic_long_read(&parent->memory.children_low_usage)));
-
-out:
-	if (usage <= memcg->memory.emin)
-		return MEMCG_PROT_MIN;
-	else if (usage <= memcg->memory.elow)
-		return MEMCG_PROT_LOW;
-	else
-		return MEMCG_PROT_NONE;
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4d3027ac131c..c71660e2c304 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2635,14 +2635,15 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long reclaimed;
 		unsigned long scanned;
 
-		switch (mem_cgroup_protected(target_memcg, memcg)) {
-		case MEMCG_PROT_MIN:
+		mem_cgroup_calculate_protection(target_memcg, memcg);
+
+		if (mem_cgroup_below_min(memcg)) {
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		case MEMCG_PROT_LOW:
+		} else if (mem_cgroup_below_low(memcg)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
@@ -2654,16 +2655,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				continue;
 			}
 			memcg_memory_event(memcg, MEMCG_LOW);
-			break;
-		case MEMCG_PROT_NONE:
-			/*
-			 * All protection thresholds breached. We may
-			 * still choose to vary the scan pressure
-			 * applied based on by how much the cgroup in
-			 * question has exceeded its protection
-			 * thresholds (see get_scan_count).
-			 */
-			break;
 		}
 
 		reclaimed = sc->nr_reclaimed;
-- 
2.18.2

