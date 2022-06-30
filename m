Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4156151F
	for <lists+cgroups@lfdr.de>; Thu, 30 Jun 2022 10:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiF3Ia7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 04:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiF3Iau (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 04:30:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DE165B7
        for <cgroups@vger.kernel.org>; Thu, 30 Jun 2022 01:30:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s194-20020a252ccb000000b00669b5702413so16048562ybs.22
        for <cgroups@vger.kernel.org>; Thu, 30 Jun 2022 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7HQituB3ydtZlLOBUfMwLNbC40NYxK5d+DcsRkBqWVw=;
        b=qvYugF4LGa9HNkaUfzlCATYgsT4KFJted/Z9XADqaC/MwyWLYNNFnLTNo2l+99eEpa
         lbf86B2fa2VUfXIazwlLRNTH5NI9s/e/ltuIPIsFxNqhvEwkDmt6zK57w1qFmFb0Vmgw
         9zTXjXP/P6Ml+0jYtnYufTU1yCWNRs8EoKD36nQz1QbzBYoTIiyQ+lOFN3xYExI5V2SN
         8fJfNqPkMrReaepHmvGHAY35gqvEucW7I1BdDoJrgbaJQ2MOnDnu8oqHjUsTmK+/m1mM
         2QTuCxNnzztReKYN1JxkqHzhvQZ6MaFunq58+5kZYgA2gBehwTT8wsqbN9jnBLU9cPMj
         6jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7HQituB3ydtZlLOBUfMwLNbC40NYxK5d+DcsRkBqWVw=;
        b=nPmct78i3290ZsRBNad2Hk/OD27aYEiD7ahQXqmme4Ys7AQuLM7MBxAGSOSDNajwb2
         IhxyjOzuRWBG4j2bGEVIash5DyDiQNRcFjbXO+lEcfyrnPkRpMwu7kk7SuqV82zxpYzp
         9uafvx+VkiQs/EqUF19W35eVvk2c5DMwhzUtb03jLZilplZeR38EFaVeMhPOpTrNLzhT
         d/J7ODV3WfFfu4p5QwxPuvDViBaRGVEvRzPmzjIB5CcapKSv4DmDpPhGCIwu34FH8lZd
         K7e/SzBZOPzP7orK2BvHs1302OIey0biiDwHODYW74qEJkBjIxvFhntSi0iqqkHWpffO
         9kwg==
X-Gm-Message-State: AJIora9P+vTOkviuNTb7lU3y1f6uAhadU7z3RK3P98l/8b85I3pcLsW/
        MwLx70eYcdx6U1/+1vpHkSc6VVgMKahUL02H
X-Google-Smtp-Source: AGRyM1vdFStgKd8mzDiN3GzzklDeJQtLdXUlA8XSsBQYP+u201j5Qau6OzQmviGHrBZOcwUh87d6Mwl74erD1XxU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:52d7:0:b0:317:b3bf:5c39 with SMTP
 id g206-20020a8152d7000000b00317b3bf5c39mr9197060ywb.99.1656577848620; Thu,
 30 Jun 2022 01:30:48 -0700 (PDT)
Date:   Thu, 30 Jun 2022 08:30:44 +0000
Message-Id: <20220630083044.997474-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3] mm: vmpressure: don't count proactive reclaim in vmpressure
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

vmpressure is used in cgroup v1 to notify userspace of reclaim
efficiency events, and is also used in both cgroup v1 and v2 as a signal
for memory pressure for networking, see
mem_cgroup_under_socket_pressure().

Proactive reclaim intends to probe memcgs for cold memory, without
affecting their performance. Hence, reclaim caused by writing to
memory.reclaim should not trigger vmpressure.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

Changes in v3:
- Limited the vmpressure change to memory.reclaim, dropped psi changes,
  updated changelog to reflect new behavior (Michal, Shakeel)

Changes in v2:
- Removed unnecessary initializations to zero (Andrew).
- Separate declarations and initializations when it causes line wrapping
  (Andrew).

---
 include/linux/swap.h |  5 ++++-
 mm/memcontrol.c      | 27 ++++++++++++++++++---------
 mm/vmscan.c          | 27 +++++++++++++++++----------
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0c0fed1b348f2..f6e9eaa2339fe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -411,10 +411,13 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
+
+#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
+#define MEMCG_RECLAIM_PROACTIVE (1 << 2)
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  bool may_swap);
+						  unsigned int reclaim_options);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9f2731d62eef2..8dc29cbb5fbf7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2319,6 +2319,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 				  gfp_t gfp_mask)
 {
 	unsigned long nr_reclaimed = 0;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 
 	do {
 		unsigned long pflags;
@@ -2331,7 +2332,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
-							     gfp_mask, true);
+							     gfp_mask,
+							     reclaim_options);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2576,7 +2578,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
-	bool may_swap = true;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	bool drained = false;
 	unsigned long pflags;
 
@@ -2593,7 +2595,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		mem_over_limit = mem_cgroup_from_counter(counter, memory);
 	} else {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
-		may_swap = false;
+		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 	}
 
 	if (batch > nr_pages) {
@@ -2620,7 +2622,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, may_swap);
+						    gfp_mask, reclaim_options);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3369,6 +3371,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	int ret;
 	bool limits_invariant;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+	unsigned int reclaim_options = memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP;
 
 	do {
 		if (signal_pending(current)) {
@@ -3403,7 +3406,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1,
-					GFP_KERNEL, !memsw)) {
+					GFP_KERNEL, reclaim_options)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3502,6 +3505,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
 	int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -3513,7 +3517,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 		if (signal_pending(current))
 			return -EINTR;
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+						  reclaim_options))
 			nr_retries--;
 	}
 
@@ -6222,6 +6227,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long high;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	int err;
 
 	buf = strstrip(buf);
@@ -6248,7 +6254,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-							 GFP_KERNEL, true);
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6271,6 +6277,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	int err;
 
 	buf = strstrip(buf);
@@ -6297,7 +6304,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-							  GFP_KERNEL, true))
+						GFP_KERNEL, reclaim_options))
 				nr_reclaims--;
 			continue;
 		}
@@ -6426,6 +6433,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
+	unsigned int reclaim_options;
 	int err;
 
 	buf = strstrip(buf);
@@ -6433,6 +6441,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	if (err)
 		return err;
 
+	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;
 
@@ -6449,7 +6458,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, true);
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7d..0969e6408a539 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -102,6 +102,9 @@ struct scan_control {
 	/* Can pages be swapped as part of reclaim? */
 	unsigned int may_swap:1;
 
+	/* Proactive reclaim invoked by userspace through memory.reclaim */
+	unsigned int proactive:1;
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
+		if (!sc->proactive)
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
+	if (!sc->proactive)
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
+		if (!sc->proactive)
+			vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
+					sc->priority);
 		sc->nr_scanned = 0;
 		shrink_zones(zonelist, sc);
 
@@ -3825,7 +3831,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   bool may_swap)
+					   unsigned int reclaim_options)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -3838,7 +3844,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
-		.may_swap = may_swap,
+		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
+		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.37.0.rc0.161.g10f37bed90-goog

