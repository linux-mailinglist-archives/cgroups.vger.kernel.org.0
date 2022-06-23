Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78C5556F9C
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376471AbiFWApA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jun 2022 20:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358232AbiFWAo7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jun 2022 20:44:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95B403E6
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 17:44:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317a4c8a662so101343027b3.6
        for <cgroups@vger.kernel.org>; Wed, 22 Jun 2022 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ymo7Rxhyocn/FvcXMtitPNOXuGv65pgzZZRA3BhOg+U=;
        b=BVh1qWcBjmTtI4sUM7Lm7CYQbPfXqjf0plMCgpo/LQ5CNE3+7ZTZT1AMNXFGEgf7L4
         GxcHKXUXoNhWxjTm5armDTa7BX/otZDHra4jT1ZppZczC8TTJwybXPZneqkKISdzzTmD
         q2joAjWl/TxolDCbUXoDMWP3YUEmebh0HXkG62nyQU5UpxfsNl7vzclXGS1Mk7YIH6Nn
         Pyc7GxAUY5sQrd/litNCGuSDpDJyxXrMbu4YGEN79PdDwr0M4xzaZK9Szv6MkviOb0aq
         GAl7WZEe8VIXL3KVGJhnP2mK7OlMpEmuDnzET+csWZhaBAsA8x66EBfp7MjhTfxHNak/
         Xvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ymo7Rxhyocn/FvcXMtitPNOXuGv65pgzZZRA3BhOg+U=;
        b=hZ9sRx9gzdATzX4PUcSL6Ew5SWTNQd5fg6PvPNE9OHpe//agBZkb/E0C4lMZgMZ4pD
         N1+cVeqtx0sVbVJsnpqtcP1yHgrxCsSl0vEhsHD7WWwr8iQZSMddx1nkSrix/mH9f0hd
         ZiWGc/H9nPS7VowSqnvEeYL82slzNZiCmWG8cXO1wgrGhTKXhHMLw3v0rFYBYyX7cWyR
         gVLjdBfWaKFq+oCYj/HGulitjBdFwOdWJ609OkcbLgb52hRrRbZQSjmKiODSnxb6vTD+
         6tqkVjBoBXlhSJT6WechjPbB+H7FgpRonqxHL6lK55+hiPPXYcv/CmyTz3uv3tgJuv6o
         OY4A==
X-Gm-Message-State: AJIora8Fk6xZaI9HpVllIIKaY5vzW5NoO+T4CerHXkcEPg8Ye4oYFjsN
        9DBEYdNIWv7iL6nlZmnOLljzd7gQrNJtM1s5
X-Google-Smtp-Source: AGRyM1uZE4vQrO8iEJNpgYL1u3hjonNaFAyvrPPQyOuEfYr323CGssDbaH/XJBQENNM0Zjoh1AvNvJTszbJRFC9z
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:afd4:0:b0:668:a903:ebd7 with SMTP
 id d20-20020a25afd4000000b00668a903ebd7mr7157182ybj.359.1655945096876; Wed,
 22 Jun 2022 17:44:56 -0700 (PDT)
Date:   Thu, 23 Jun 2022 00:44:52 +0000
Message-Id: <20220623004452.1217326-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
as memory pressure") made sure that memory reclaim that is induced by
userspace (limit-setting, proactive reclaim, ..) is not counted as
memory pressure for the purposes of psi.

Instead of counting psi inside try_to_free_mem_cgroup_pages(), callers
from try_charge() and reclaim_high() wrap the call to
try_to_free_mem_cgroup_pages() with psi handlers.

However, vmpressure is still counted in these cases where reclaim is
directly induced by userspace. This patch makes sure vmpressure is not
counted in those operations, in the same way as psi. Since vmpressure
calls need to happen deeper within the reclaim path, the same approach
could not be followed. Hence, a new "controlled" flag is added to struct
scan_control to flag a reclaim operation that is controlled by
userspace. This flag is set by limit-setting and proactive reclaim
operations, and is used to count vmpressure correctly.

To prevent future divergence of psi and vmpressure, commit e22c6ed90aa9
("mm: memcontrol: don't count limit-setting reclaim as memory pressure")
is effectively reverted and the same flag is used to control psi as
well.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

---

Changes in v2:
- Removed unnecessary initializations to zero (Andrew).
- Separate declarations and initializations when it causes line wrapping
  (Andrew).

---
 include/linux/swap.h |  5 ++++-
 mm/memcontrol.c      | 41 +++++++++++++++++++++++------------------
 mm/vmscan.c          | 36 ++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0c0fed1b348f2..5a6766e417afe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -411,10 +411,13 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
+
+#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
+#define MEMCG_RECLAIM_CONTROLLED (1 << 2)
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  bool may_swap);
+						  unsigned int reclaim_options);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe64..9d0ba4cff5e16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2319,20 +2319,16 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 				  gfp_t gfp_mask)
 {
 	unsigned long nr_reclaimed = 0;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 
 	do {
-		unsigned long pflags;
-
 		if (page_counter_read(&memcg->memory) <=
 		    READ_ONCE(memcg->memory.high))
 			continue;
-
 		memcg_memory_event(memcg, MEMCG_HIGH);
-
-		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
-							     gfp_mask, true);
-		psi_memstall_leave(&pflags);
+							     gfp_mask,
+							     reclaim_options);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
 
@@ -2576,9 +2572,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
-	bool may_swap = true;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	bool drained = false;
-	unsigned long pflags;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
@@ -2593,7 +2588,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		mem_over_limit = mem_cgroup_from_counter(counter, memory);
 	} else {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
-		may_swap = false;
+		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 	}
 
 	if (batch > nr_pages) {
@@ -2618,10 +2613,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
 
-	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, may_swap);
-	psi_memstall_leave(&pflags);
+						    gfp_mask, reclaim_options);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
 		goto retry;
@@ -3369,7 +3362,9 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	int ret;
 	bool limits_invariant;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+	unsigned int reclaim_options = memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP;
 
+	reclaim_options |= MEMCG_RECLAIM_CONTROLLED;
 	do {
 		if (signal_pending(current)) {
 			ret = -EINTR;
@@ -3403,7 +3398,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1,
-					GFP_KERNEL, !memsw)) {
+					GFP_KERNEL, reclaim_options)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3502,6 +3497,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
 	int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned int reclaim_options;
+
+	reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -3513,7 +3511,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 		if (signal_pending(current))
 			return -EINTR;
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+						  reclaim_options))
 			nr_retries--;
 	}
 
@@ -6215,6 +6214,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long high;
+	unsigned int reclaim_options;
 	int err;
 
 	buf = strstrip(buf);
@@ -6223,6 +6223,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_high(&memcg->memory, high);
+	reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
@@ -6241,7 +6242,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-							 GFP_KERNEL, true);
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6264,6 +6265,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
+	unsigned int reclaim_options;
 	int err;
 
 	buf = strstrip(buf);
@@ -6272,6 +6274,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		return err;
 
 	xchg(&memcg->memory.max, max);
+	reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
@@ -6290,7 +6293,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-							  GFP_KERNEL, true))
+						GFP_KERNEL, reclaim_options))
 				nr_reclaims--;
 			continue;
 		}
@@ -6419,6 +6422,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
+	unsigned int reclaim_options;
 	int err;
 
 	buf = strstrip(buf);
@@ -6426,6 +6430,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	if (err)
 		return err;
 
+	reclaim_options = MEMCG_RECLAIM_CONTROLLED | MEMCG_RECLAIM_MAY_SWAP;
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;
 
@@ -6442,7 +6447,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, true);
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7d..a972ff28f2d38 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -102,6 +102,9 @@ struct scan_control {
 	/* Can pages be swapped as part of reclaim? */
 	unsigned int may_swap:1;
 
+	/* Reclaim is controlled by userspace */
+	unsigned int controlled:1;
+
 	/*
 	 * Cgroup memory below memory.low is protected as long as we
 	 * don't threaten to OOM. If any cgroup is reclaimed at
@@ -3125,9 +3128,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			    sc->priority);
 
 		/* Record the group's reclaim efficiency */
-		vmpressure(sc->gfp_mask, memcg, false,
-			   sc->nr_scanned - scanned,
-			   sc->nr_reclaimed - reclaimed);
+		if (!sc->controlled)
+			vmpressure(sc->gfp_mask, memcg, false,
+				   sc->nr_scanned - scanned,
+				   sc->nr_reclaimed - reclaimed);
 
 	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
 }
@@ -3250,9 +3254,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/* Record the subtree's reclaim efficiency */
-	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
-		   sc->nr_scanned - nr_scanned,
-		   sc->nr_reclaimed - nr_reclaimed);
+	if (!sc->controlled)
+		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
+			   sc->nr_scanned - nr_scanned,
+			   sc->nr_reclaimed - nr_reclaimed);
 
 	if (sc->nr_reclaimed - nr_reclaimed)
 		reclaimable = true;
@@ -3534,8 +3539,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
 
 	do {
-		vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
-				sc->priority);
+		if (!sc->controlled)
+			vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
+					sc->priority);
 		sc->nr_scanned = 0;
 		shrink_zones(zonelist, sc);
 
@@ -3825,10 +3831,12 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   bool may_swap)
+					   unsigned int reclaim_options)
 {
 	unsigned long nr_reclaimed;
+	unsigned long pflags;
 	unsigned int noreclaim_flag;
+	bool controlled_reclaim = reclaim_options & MEMCG_RECLAIM_CONTROLLED;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
 		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
@@ -3838,7 +3846,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
-		.may_swap = may_swap,
+		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
+		.controlled = controlled_reclaim,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -3848,12 +3857,19 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
+
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
+
+	if (!controlled_reclaim)
+		psi_memstall_enter(&pflags);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
+	if (!controlled_reclaim)
+		psi_memstall_leave(&pflags);
+
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
 
-- 
2.37.0.rc0.104.g0611611a94-goog

