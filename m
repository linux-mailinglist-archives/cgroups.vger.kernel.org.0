Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EDEA4EB
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 21:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJ3Umw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Oct 2019 16:42:52 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49559 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfJ3Umw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Oct 2019 16:42:52 -0400
Received: by mail-qk1-f202.google.com with SMTP id d144so3318608qke.16
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2019 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4dygeh2iZiGXKLjzsumFt04L193TA2xYMuRz30FRIjM=;
        b=KJjbvv9JdsHOC1+VBzyZMKgf4nKhnjENRGCorWIcKQiV2CIw2DoTEoTnBNhIYLG9yB
         lAId6fGQSyE8UkT9YlJLubzYI7zABQy99MHUmvUk9c6zdPUTsEpzB6wJWG4EcTIma/89
         H74TVkQ291kTE0ZyKr8yo7acXvu1QJuM5hmIZHImqplx12Zdro08r3Qu/MdXrPR/46Yv
         fTqWN1/Y/+VWsbah3U5vTfTgiFOsQ7dZoTkKEFSIJK68/xhj8pA0Oc7itPv2Y2eKmfsf
         s0qISL0je+HKr3c+Be9uaVbnDj2K/R9/46CZi/NxzOc0x8axDJyRwH1eii9QLHe6NHpm
         HgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4dygeh2iZiGXKLjzsumFt04L193TA2xYMuRz30FRIjM=;
        b=H9f20bosEGylbqTCJZzVU2uBqQubm5OQAgoNlM+9Onvm8EHSJ9dXltGvfU6pofj0jV
         NgEkb384YB1i6cKW/Z8s+al5pYaaVirO6g0WVaGdOSz7ynkxyBIWoOnR0Knog9Es99u5
         dsPubhSy5Db8O1NLMS3kQol0Z4mGqn2maR4sBw45VjAbeqyfsEw6i0xwLLzegTv6LMxB
         zcwvHL+wt9mJZR5Aw9jKHxJYWzKYbgp/UChp7+9N3TgpsWHLaoFWwn/3nYdW05i57UWy
         mdESFFlJA2sOl8EgAGffcd4I+Agh0Cj9xaoyubJIyzeAO0uoCvz5r1BPdyYCjlYe9ZQ3
         B9fQ==
X-Gm-Message-State: APjAAAXMG7PHXlv81jf1A5Gm938StfOXQ6s+7AzWQbdHNiEf6Oxev2ZX
        JOBekYnbhZSwHkmSnGV2CgBrt8o6azpztg==
X-Google-Smtp-Source: APXvYqzrpiQHS+NjTfDDdxWRWUdhgaEjCi+F8Tz4h+0gAbf3UXOH1KtQScm8HASesUzzQg5CUo+/arSzArn7jg==
X-Received: by 2002:a05:6214:c9:: with SMTP id f9mr1051497qvs.216.1572468169607;
 Wed, 30 Oct 2019 13:42:49 -0700 (PDT)
Date:   Wed, 30 Oct 2019 13:42:32 -0700
Message-Id: <20191030204232.139424-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2] mm: vmscan: memcontrol: remove mem_cgroup_select_victim_node()
From:   Shakeel Butt <shakeelb@google.com>
To:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 1ba6fc9af35b ("mm: vmscan: do not share cgroup iteration
between reclaimers"), the memcg reclaim does not bail out earlier based
on sc->nr_reclaimed and will traverse all the nodes. All the reclaimable
pages of the memcg on all the nodes will be scanned relative to the
reclaim priority. So, there is no need to maintain state regarding which
node to start the memcg reclaim from.

This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
memory from nodes in round-robin order") and commit 453a9bf347f1
("memcg: fix numa scan information update to be triggered by memory
event").

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v1:
- Added comment in vmscan on zonelist traversal.
- Removed reference to the KCSAN report.

 include/linux/memcontrol.h |   8 ---
 mm/memcontrol.c            | 112 -------------------------------------
 mm/vmscan.c                |  14 ++---
 3 files changed, 5 insertions(+), 129 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e82928deea88..239e752a7817 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -80,7 +80,6 @@ struct mem_cgroup_id {
 enum mem_cgroup_events_target {
 	MEM_CGROUP_TARGET_THRESH,
 	MEM_CGROUP_TARGET_SOFTLIMIT,
-	MEM_CGROUP_TARGET_NUMAINFO,
 	MEM_CGROUP_NTARGETS,
 };
 
@@ -312,13 +311,6 @@ struct mem_cgroup {
 	struct list_head kmem_caches;
 #endif
 
-	int last_scanned_node;
-#if MAX_NUMNODES > 1
-	nodemask_t	scan_nodes;
-	atomic_t	numainfo_events;
-	atomic_t	numainfo_updating;
-#endif
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head cgwb_list;
 	struct wb_domain cgwb_domain;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ea085877c548..aaa19bf5cf0f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -100,7 +100,6 @@ static bool do_memsw_account(void)
 
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
-#define NUMAINFO_EVENTS_TARGET	1024
 
 /*
  * Cgroups above their limits are maintained in a RB-Tree, independent of
@@ -869,9 +868,6 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 		case MEM_CGROUP_TARGET_SOFTLIMIT:
 			next = val + SOFTLIMIT_EVENTS_TARGET;
 			break;
-		case MEM_CGROUP_TARGET_NUMAINFO:
-			next = val + NUMAINFO_EVENTS_TARGET;
-			break;
 		default:
 			break;
 		}
@@ -891,21 +887,12 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
 		bool do_softlimit;
-		bool do_numainfo __maybe_unused;
 
 		do_softlimit = mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_SOFTLIMIT);
-#if MAX_NUMNODES > 1
-		do_numainfo = mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_NUMAINFO);
-#endif
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
 			mem_cgroup_update_tree(memcg, page);
-#if MAX_NUMNODES > 1
-		if (unlikely(do_numainfo))
-			atomic_inc(&memcg->numainfo_events);
-#endif
 	}
 }
 
@@ -1590,104 +1577,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return ret;
 }
 
-#if MAX_NUMNODES > 1
-
-/**
- * test_mem_cgroup_node_reclaimable
- * @memcg: the target memcg
- * @nid: the node ID to be checked.
- * @noswap : specify true here if the user wants flle only information.
- *
- * This function returns whether the specified memcg contains any
- * reclaimable pages on a node. Returns true if there are any reclaimable
- * pages in the node.
- */
-static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
-		int nid, bool noswap)
-{
-	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
-
-	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
-	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
-		return true;
-	if (noswap || !total_swap_pages)
-		return false;
-	if (lruvec_page_state(lruvec, NR_INACTIVE_ANON) ||
-	    lruvec_page_state(lruvec, NR_ACTIVE_ANON))
-		return true;
-	return false;
-
-}
-
-/*
- * Always updating the nodemask is not very good - even if we have an empty
- * list or the wrong list here, we can start from some node and traverse all
- * nodes based on the zonelist. So update the list loosely once per 10 secs.
- *
- */
-static void mem_cgroup_may_update_nodemask(struct mem_cgroup *memcg)
-{
-	int nid;
-	/*
-	 * numainfo_events > 0 means there was at least NUMAINFO_EVENTS_TARGET
-	 * pagein/pageout changes since the last update.
-	 */
-	if (!atomic_read(&memcg->numainfo_events))
-		return;
-	if (atomic_inc_return(&memcg->numainfo_updating) > 1)
-		return;
-
-	/* make a nodemask where this memcg uses memory from */
-	memcg->scan_nodes = node_states[N_MEMORY];
-
-	for_each_node_mask(nid, node_states[N_MEMORY]) {
-
-		if (!test_mem_cgroup_node_reclaimable(memcg, nid, false))
-			node_clear(nid, memcg->scan_nodes);
-	}
-
-	atomic_set(&memcg->numainfo_events, 0);
-	atomic_set(&memcg->numainfo_updating, 0);
-}
-
-/*
- * Selecting a node where we start reclaim from. Because what we need is just
- * reducing usage counter, start from anywhere is O,K. Considering
- * memory reclaim from current node, there are pros. and cons.
- *
- * Freeing memory from current node means freeing memory from a node which
- * we'll use or we've used. So, it may make LRU bad. And if several threads
- * hit limits, it will see a contention on a node. But freeing from remote
- * node means more costs for memory reclaim because of memory latency.
- *
- * Now, we use round-robin. Better algorithm is welcomed.
- */
-int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
-{
-	int node;
-
-	mem_cgroup_may_update_nodemask(memcg);
-	node = memcg->last_scanned_node;
-
-	node = next_node_in(node, memcg->scan_nodes);
-	/*
-	 * mem_cgroup_may_update_nodemask might have seen no reclaimmable pages
-	 * last time it really checked all the LRUs due to rate limiting.
-	 * Fallback to the current node in that case for simplicity.
-	 */
-	if (unlikely(node == MAX_NUMNODES))
-		node = numa_node_id();
-
-	memcg->last_scanned_node = node;
-	return node;
-}
-#else
-int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
-{
-	return 0;
-}
-#endif
-
 static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
 				   pg_data_t *pgdat,
 				   gfp_t gfp_mask,
@@ -5056,7 +4945,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 
 	INIT_WORK(&memcg->high_work, high_work_func);
-	memcg->last_scanned_node = MAX_NUMNODES;
 	INIT_LIST_HEAD(&memcg->oom_notify);
 	mutex_init(&memcg->thresholds_lock);
 	spin_lock_init(&memcg->move_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1154b3a2b637..0748ac915128 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3344,10 +3344,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   gfp_t gfp_mask,
 					   bool may_swap)
 {
-	struct zonelist *zonelist;
 	unsigned long nr_reclaimed;
 	unsigned long pflags;
-	int nid;
 	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
@@ -3360,16 +3358,14 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = may_swap,
 	};
-
-	set_task_reclaim_state(current, &sc.reclaim_state);
 	/*
-	 * Unlike direct reclaim via alloc_pages(), memcg's reclaim doesn't
-	 * take care of from where we get pages. So the node where we start the
-	 * scan does not need to be the current node.
+	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
+	 * equal pressure on all the nodes. This is based on the assumption that
+	 * the reclaim does not bail out early.
 	 */
-	nid = mem_cgroup_select_victim_node(memcg);
+	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
-	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
+	set_task_reclaim_state(current, &sc.reclaim_state);
 
 	trace_mm_vmscan_memcg_reclaim_begin(
 				cgroup_ino(memcg->css.cgroup),
-- 
2.24.0.rc0.303.g954a862665-goog

