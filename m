Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4263FEAA
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 04:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiLBDPi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 22:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiLBDPe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 22:15:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0E8D49E3
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 19:15:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id z4-20020a17090ab10400b002195a146546so8173598pjq.9
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 19:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XH6mwHf7EDaGC67MtDUhfOFlBKrgBczQTfSrrHT2Rug=;
        b=ZTA6jNpY64q+OTD6IPuzuRI5YVchd2BVByQJxeZ+0jNgkDeRrpoOSkoYrs8JTmtO3d
         bQeuiSzvI8Ajv8CanGZU6FLXzkwcAwv8yy1vGr0fNUUydgPcY8g7mBvrUDpb0e/XO8fs
         T06y1p4yGVbIgmqg58n2Hwu6IDMMPHWVc0EEgdWfTYNjjs8rp/kWAwifEabu7DOLnPVo
         8VTwxQgN+22poPKnK24M4MaFK+hfJ4iz2zC1d2eAK71nOT6Gep1QdONb5DEWjyPhqqtk
         JgQr59SzkaGqoo588LCfjHTJIbDJZ8Pyt8mGpq3V7fKVudzULA9iipwyeSMlqpqctAZ0
         dNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH6mwHf7EDaGC67MtDUhfOFlBKrgBczQTfSrrHT2Rug=;
        b=08JFPpTcadwUi9WwBygpRt0vK5xppE9cofOqgqo/UmIWxEjIVHfyCVpDkf3GjtdQrA
         Yj8nNaYDTskIepKyKRUGtRPBiV61RCFoXNDtlo1NZaHBRuiWzRd+1mTHw3bdRZ1jumml
         BVn+aJvuifQPeYVS8JsrkRBvfISkDvtdIaX6AD4fPLB3BAreXFMI4q9gm6XvUy50X4Uz
         p0NZmA8Xhp17qXXWNMP1tZ7rMmRzeBWA7f/taIK41UnbzVRUfklXrRfTjZ8LyBdZ0Fcs
         mq/x7foH1P9qQ9C9EdlAdNoG4TISUmSlrVkjhjfEk2xSmKrFdz5/3PXGYsAHFPraKf7x
         j1UQ==
X-Gm-Message-State: ANoB5plEN57XVmDh6LUODp6dNzPHfSDgDZnU07yocZ9/QtHpY7hUdK3Y
        Ih3e75vgYu1VxmoiF7mcReAsP3QQyHdBhlS/
X-Google-Smtp-Source: AA0mqf7PBETjtescCL3/FyX99YGmCALEDVA/h4FWTwolclKu6Pt0Ujihl1FAwjY7B0JyQYI/Hpzx3pIuupApd/fK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with SMTP
 id ft9-20020a17090b0f8900b002195b3b2b9fmr1432190pjb.2.1669950931626; Thu, 01
 Dec 2022 19:15:31 -0800 (PST)
Date:   Fri,  2 Dec 2022 03:15:10 +0000
In-Reply-To: <20221202031512.1365483-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221202031512.1365483-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202031512.1365483-2-yosryahmed@google.com>
Subject: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim target memcg
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During reclaim, mem_cgroup_calculate_protection() is used to determine
the effective protection (emin and elow) values of a memcg. The
protection of the reclaim target is ignored, but we cannot set their
effective protection to 0 due to a limitation of the current
implementation (see comment in mem_cgroup_protection()). Instead,
we leave their effective protection values unchaged, and later ignore it
in mem_cgroup_protection().

However, mem_cgroup_protection() is called later in
shrink_lruvec()->get_scan_count(), which is after the
mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
result, the stale effective protection values of the target memcg may
lead us to skip reclaiming from the target memcg entirely, before
calling shrink_lruvec(). This can be even worse with recursive
protection, where the stale target memcg protection can be higher than
its standalone protection. See two examples below (a similar version of
example (a) is added to test_memcontrol in a later patch).

(a) A simple example with proactive reclaim is as follows. Consider the
following hierarchy:
ROOT
 |
 A
 |
 B (memory.min = 10M)

Consider the following scenario:
- B has memory.current = 10M.
- The system undergoes global reclaim (or memcg reclaim in A).
- In shrink_node_memcgs():
  - mem_cgroup_calculate_protection() calculates the effective min (emin)
    of B as 10M.
  - mem_cgroup_below_min() returns true for B, we do not reclaim from B.
- Now if we want to reclaim 5M from B using proactive reclaim
  (memory.reclaim), we should be able to, as the protection of the
  target memcg should be ignored.
- In shrink_node_memcgs():
  - mem_cgroup_calculate_protection() immediately returns for B without
    doing anything, as B is the target memcg, relying on
    mem_cgroup_protection() to ignore B's stale effective min (still 10M).
  - mem_cgroup_below_min() reads the stale effective min for B and we
    skip it instead of ignoring its protection as intended, as we never
    reach mem_cgroup_protection().

(b) An more complex example with recursive protection is as follows.
Consider the following hierarchy with memory_recursiveprot:
ROOT
 |
 A (memory.min = 50M)
 |
 B (memory.min = 10M, memory.high = 40M)

Consider the following scenario:
- B has memory.current = 35M.
- The system undergoes global reclaim (target memcg is NULL).
- B will have an effective min of 50M (all of A's unclaimed protection).
- B will not be reclaimed from.
- Now allocate 10M more memory in B, pushing it above it's high limit.
- The system undergoes memcg reclaim from B (target memcg is B).
- Like example (a), we do nothing in mem_cgroup_calculate_protection(),
  then call mem_cgroup_below_min(), which will read the stale effective
  min for B (50M) and skip it. In this case, it's even worse because we
  are not just considering B's standalone protection (10M), but we are
  reading a much higher stale protection (50M) which will cause us to not
  reclaim from B at all.

This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
e{low,min} state mutations from protection checks") which made
mem_cgroup_calculate_protection() only change the state without
returning any value. Before that commit, we used to return
MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
mem_cgroup_below_{min/low}() checks. After that commit we do not return
anything and we end up checking the min & low effective protections for
the target memcg, which are stale.

Update mem_cgroup_supports_protection() to also check if we are
reclaiming from the target, and rename it to mem_cgroup_unprotected()
(now returns true if we should not protect the memcg, much simpler logic).

Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 31 +++++++++++++++++++++----------
 mm/vmscan.c                | 11 ++++++-----
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1644a24009c..d3c8203cab6c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -615,28 +615,32 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 				     struct mem_cgroup *memcg);
 
-static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
+					  struct mem_cgroup *memcg)
 {
 	/*
 	 * The root memcg doesn't account charges, and doesn't support
-	 * protection.
+	 * protection. The target memcg's protection is ignored, see
+	 * mem_cgroup_calculate_protection() and mem_cgroup_protection()
 	 */
-	return !mem_cgroup_disabled() && !mem_cgroup_is_root(memcg);
-
+	return mem_cgroup_disabled() || mem_cgroup_is_root(memcg) ||
+		memcg == target;
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
 
-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.emin) >=
@@ -1209,12 +1213,19 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
+					  struct mem_cgroup *memcg)
+{
+	return true;
+}
+static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
 	return false;
 }
 
-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
 	return false;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..79ef0fe67518 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4486,7 +4486,7 @@ static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned
 
 	mem_cgroup_calculate_protection(NULL, memcg);
 
-	if (mem_cgroup_below_min(memcg))
+	if (mem_cgroup_below_min(NULL, memcg))
 		return false;
 
 	need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, swappiness, &nr_to_scan);
@@ -5047,8 +5047,9 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (mem_cgroup_below_min(memcg) ||
-	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
+	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
+	    (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
+	     !sc->memcg_low_reclaim))
 		return 0;
 
 	*need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &nr_to_scan);
@@ -6048,13 +6049,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
-		if (mem_cgroup_below_min(memcg)) {
+		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		} else if (mem_cgroup_below_low(memcg)) {
+		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

