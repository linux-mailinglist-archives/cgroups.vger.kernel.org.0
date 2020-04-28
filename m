Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE62C1BC7D5
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgD1S1E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 14:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728884AbgD1S1D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 14:27:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4CBC03C1AC
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 11:27:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so4018099wmh.0
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbhBW/kVDmKBpgBPPDRywC4JTwBWDdk0LU6fqNqndyM=;
        b=OuNXAGxvdUOUc9ZBfgB767lk50030ejNZaRDkEYB6KuqorrlYWG7cJxPf4RkcJWkbV
         Rb5HrQ+gTll9Y+l5xv5kK3PWiwLB2qNBQTpDztW5AuUSMfVYEKH8jHOJQHQPMsSXbjSK
         fa1BiGUCbJIK9mdCAFVMw9EgkTzhHxxjmy7lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbhBW/kVDmKBpgBPPDRywC4JTwBWDdk0LU6fqNqndyM=;
        b=hIyrcvz8oHjwUhyJ3HE3mVenF6owIIVFHBTQd4sZvECgqoHWu+W65R03/ggBHZXECz
         j6FEgYoO+20ouSVfcED/mLOiiyldkGGVjYrv9imQXotK46EQJYjTkjiLYBo4H7/sICzO
         0fH8Adnmjxn9AVFo4ds8wZl9hR7j4oNRiII0qn56qj58eRDjcRW8wkk3U07vPAeBMARK
         NqP4BJ7Me0/ZTiwB2+XsDmGcsk+Fa7vg9MUP1993bXWOsWFM5fr66OtKuLglaiCldIUq
         9VOucbrCAX0NtRXwNqzOKbWBI0541qXnJVp2cuXKWfSyhJmFhFsTal2nXTAp86g5ct4z
         Ysmg==
X-Gm-Message-State: AGi0Pub2vPfZK7LfTmJIXcS1EZM80VkyjNBS6OCraygNlm5JIMgPtnBJ
        nLeXhsbjJ0pVFGGlHqpB6e5rzg==
X-Google-Smtp-Source: APiQypItaAgbrMyavidZT6lgynKH9R7FHzJu+K99KFV9jUtxw7W/Ss6N3fBp/UNDfbIk0XzuT3fBvw==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr6261512wmk.39.1588098421110;
        Tue, 28 Apr 2020 11:27:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id h2sm4475049wmf.34.2020.04.28.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:27:00 -0700 (PDT)
Date:   Tue, 28 Apr 2020 19:27:00 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm, memcg: Decouple e{low,min} state mutations from
 protection checks
Message-ID: <51ffacb736bb02ecc09c828ebe8f4ec7fda68c48.1588092152.git.chris@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588092152.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_protected currently is both used to set effective low and min
and return a mem_cgroup_protection based on the result. As a user, this
can be a little unexpected: it appears to be a simple predicate
function, if not for the big warning in the comment above about the
order in which it must be executed.

This change makes it so that we separate the state mutations from the
actual protection checks, which makes it more obvious where we need to
be careful mutating internal state, and where we are simply checking and
don't need to worry about that.

Signed-off-by: Chris Down <chris@chrisdown.name>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 48 +++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 30 +++++++-----------------
 mm/vmscan.c                | 17 ++++----------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d630af1a4e17..88576b1235b0 100644
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
@@ -357,8 +351,26 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
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
@@ -838,13 +850,27 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 						  bool in_low_reclaim)
 {
+
+
+static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg);
+{
+}
+
+static inline void mem_cgroup_protection(struct mem_cgroup *memcg,
+					 bool in_low_reclaim)
+{
 	return 0;
 }
 
-static inline enum mem_cgroup_protection mem_cgroup_protected(
-	struct mem_cgroup *root, struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 {
-	return MEMCG_PROT_NONE;
+	return false;
 }
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b0374be44e9e..317dbbaac603 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6368,27 +6368,21 @@ static unsigned long effective_protection(unsigned long usage,
 }
 
 /**
- * mem_cgroup_protected - check if memory consumption is in the normal range
+ * mem_cgroup_calculate_protection - calculate and cache effective low and min
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
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
@@ -6403,22 +6397,22 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 		 */
 		WRITE_ONCE(memcg->memory.emin, 0);
 		WRITE_ONCE(memcg->memory.elow, 0);
-		return MEMCG_PROT_NONE;
+		return;
 	}
 
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
@@ -6431,14 +6425,6 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
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
index 72ac38eb8c29..e913c4652341 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2645,14 +2645,15 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
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
@@ -2664,16 +2665,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
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
2.26.2

