Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA0E93E9
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfJ2XsJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 19:48:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:57094 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2XsJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Oct 2019 19:48:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id v11so195911pfm.23
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2019 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y1mvRORhXt6pliM/V36JtmVvdeCpRhqAmZkwnp4wtqM=;
        b=ITxigb6hieadqKQRQTPvaJX6ZOQhSm7eZ6ab0yBzf7t88jFNGuy3Q9zh7xYpALWlS/
         yZVJCdhW8khrknEg8h0yZPtqW0omMVYk7lnwzIEZgmWHFGvumjl6+kTlbkI2CARkJboa
         i4h55EDVN3yhJEOUh0ikzg1VWnGRBjZx7PtEiTK8+vS1zswbPTpup0ZurJvD6vI9jvu6
         BdZj7fT7bUpLRPPsUkpkZKBulVOPCs+Rd3gfoaI8wACkSyd1rmCO1Gj7x4VvYyovdlyY
         WlmWbHcZZVV3O4RWmaj9uybf0RvpWoofgpC1H9lA1qVI10CQIwD7XBweDuNuwixM2HHQ
         UZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y1mvRORhXt6pliM/V36JtmVvdeCpRhqAmZkwnp4wtqM=;
        b=DyjlBEcl4cjJY5Y9wdCyUlY7ajgwjQ5mMLFivBe2aZEvuULI9OO3INlvV95GAh2XRG
         UUQURvA2pzJt+V2Y+Bl7QoWD+inIr8oyP3H55GgZE+KtiO8SfNDUVW1cV4t5A34edP4w
         PgMkesw+XkhkSsHAaAHvY8wzsLrYFn9x0bTJ36JxmFJZhMc9oasUMd/3Nce5LNcEmaT+
         kudjh/OkqFJ+pLLHFFSbvqPol9cq68iEUboJvmtcUbchPmSCuP9ocIJPbf6a4ZAQabAu
         PY0VbQ/v0zLtlkUAqVmFoCh0+NQuUIKgXM9YlbUK+TK43QqyyXleZ4vfIiCoQosztvdt
         xUHw==
X-Gm-Message-State: APjAAAVd+PF4XESXV8bAWGDNCd1Kvlsc9X2ajh6uBRKzjlm1J32vERhL
        76wiSlm7PfD4ysSU/SsT37PYD3Bc9JXN0A==
X-Google-Smtp-Source: APXvYqyyyHdCuMkx4yMoPYOcZPs2OmcCnT4jE21dUnuyFu6oMufhTkATsBGh8r/z8scjKIOn91RPUStxuwshbw==
X-Received: by 2002:a63:535a:: with SMTP id t26mr1385204pgl.215.1572392887712;
 Tue, 29 Oct 2019 16:48:07 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:47:53 -0700
Message-Id: <20191029234753.224143-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] mm: vmscan: memcontrol: remove mem_cgroup_select_victim_node()
From:   Shakeel Butt <shakeelb@google.com>
To:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
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
node to start the memcg reclaim from. Also KCSAN complains data races in
the code maintaining the state.

This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
memory from nodes in round-robin order") and the commit 453a9bf347f1
("memcg: fix numa scan information update to be triggered by memory
event").

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: <syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com>
---
 include/linux/memcontrol.h |   8 ---
 mm/memcontrol.c            | 112 -------------------------------------
 mm/vmscan.c                |  11 +---
 3 files changed, 1 insertion(+), 130 deletions(-)

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
index 1154b3a2b637..cb4dc52cfb88 100644
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
@@ -3360,16 +3358,9 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = may_swap,
 	};
+	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	/*
-	 * Unlike direct reclaim via alloc_pages(), memcg's reclaim doesn't
-	 * take care of from where we get pages. So the node where we start the
-	 * scan does not need to be the current node.
-	 */
-	nid = mem_cgroup_select_victim_node(memcg);
-
-	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
 
 	trace_mm_vmscan_memcg_reclaim_begin(
 				cgroup_ino(memcg->css.cgroup),
-- 
2.24.0.rc0.303.g954a862665-goog

