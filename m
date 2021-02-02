Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89B30CA99
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhBBSyt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbhBBSsf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E5C061793
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:47:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id s77so7428279qke.4
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZpcdqBIUeHuRA3ry6psqLVWAEi8jyTeTt09lQraF+c=;
        b=pFBlBbi+hJBi102ivz3tEHlSObS5vUVEGXyRbRzgummggVh/7m310IjtgC0c5SkxI4
         ZwBqqTyEwUsGjXo9z72N4yfm1lTy6QxlimLDLaKHCHpgbcd/5vWVSu0MD0EgclWQcusU
         sC8MZzqg/WGCEvGiILpsgFFvSVDcgpPyAfgoGtr6We7mC9PelfRoA4dkX3xwXXJURd+W
         C6dNlV3YKjirNjhViGWJiOmCS2m8poDXp150V4FPKtwVdXa8SLrGT/8oztQoZeZAhC0h
         spTzo+OGHgdYMWpheVyoIWntjh94cxkF2wMcEHJbfreYpDlVRxLvVDCtR3hlfhu19aer
         Munw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZpcdqBIUeHuRA3ry6psqLVWAEi8jyTeTt09lQraF+c=;
        b=gUiA4ccM7G0cNBrq0a3jHcP985MDP+nE46bQHsqDvZ7bPITHSXyRu4xpShZJHQw+D+
         jtJBGIMXWV/rS/a1JCUmjlZYiVVfgDcBBbAFqMF6rAoWQTvTTS+ltRtL3v8x4E9LkGmn
         Mk+yq2lMGCQgyqpjh3q+I9s3s/u58R7G8zD2ZjYbq3yLPel/0AR2R7yfBvIb8W9+Zk/c
         gOumuKKbTQG6WqxhjmrBlWEYEyqTHSbfiq+FxUGKhLlXDdw9v69HDfm3dYOkfekXUJFI
         OZn4l98VwPZNijqibjJqLksalbGlKHnkxZb7Jq6YJ2+NVxeGa6hzqNC7XxrN0ueu6fk/
         BWiQ==
X-Gm-Message-State: AOAM5324yvCIA+mqLxM1WtuQarMG7kx6MLW75XhYDjym6mguw9SLnPcy
        Zrz/rVn5c3p+ZxhYkzBuXvVVMg==
X-Google-Smtp-Source: ABdhPJzTsLutgDrMgCR1wRgt4p6a6DZOk6A1+uADXqy5GnX8nT8WQznWBU1eYUe6FosnWJkPulPg5Q==
X-Received: by 2002:a05:620a:16c9:: with SMTP id a9mr21724215qkn.41.1612291674776;
        Tue, 02 Feb 2021 10:47:54 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s15sm16545799qtn.35.2021.02.02.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:47:54 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] mm: memcontrol: kill mem_cgroup_nodeinfo()
Date:   Tue,  2 Feb 2021 13:47:41 -0500
Message-Id: <20210202184746.119084-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202184746.119084-1-hannes@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No need to encapsulate a simple struct member access.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  8 +-------
 mm/memcontrol.c            | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7a38a1517a05..c7f387a6233e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -602,12 +602,6 @@ void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
 
-static struct mem_cgroup_per_node *
-mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
-{
-	return memcg->nodeinfo[nid];
-}
-
 /**
  * mem_cgroup_lruvec - get the lru list vector for a memcg & node
  * @memcg: memcg of the wanted lruvec
@@ -631,7 +625,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	mz = memcg->nodeinfo[pgdat->node_id];
 	lruvec = &mz->lruvec;
 out:
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8120d565dd79..7e05a4ebf80f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -414,13 +414,14 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 					 int size, int old_size)
 {
 	struct memcg_shrinker_map *new, *old;
+	struct mem_cgroup_per_node *pn;
 	int nid;
 
 	lockdep_assert_held(&memcg_shrinker_map_mutex);
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+		pn = memcg->nodeinfo[nid];
+		old = rcu_dereference_protected(pn->shrinker_map, true);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -433,7 +434,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset(new->map, (int)0xff, old_size);
 		memset((void *)new->map + old_size, 0, size - old_size);
 
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		rcu_assign_pointer(pn->shrinker_map, new);
 		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
 	}
 
@@ -450,7 +451,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 		return;
 
 	for_each_node(nid) {
-		pn = mem_cgroup_nodeinfo(memcg, nid);
+		pn = memcg->nodeinfo[nid];
 		map = rcu_dereference_protected(pn->shrinker_map, true);
 		kvfree(map);
 		rcu_assign_pointer(pn->shrinker_map, NULL);
@@ -713,7 +714,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 	int nid;
 
 	for_each_node(nid) {
-		mz = mem_cgroup_nodeinfo(memcg, nid);
+		mz = memcg->nodeinfo[nid];
 		mctz = soft_limit_tree_node(nid);
 		if (mctz)
 			mem_cgroup_remove_exceeded(mz, mctz);
@@ -796,7 +797,7 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
 	parent = parent_mem_cgroup(pn->memcg);
 	if (!parent)
 		return NULL;
-	return mem_cgroup_nodeinfo(parent, nid);
+	return parent->nodeinfo[nid];
 }
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
@@ -1163,7 +1164,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (reclaim) {
 		struct mem_cgroup_per_node *mz;
 
-		mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
+		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
 
 		if (prev && reclaim->generation != iter->generation)
@@ -1265,7 +1266,7 @@ static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
 	int nid;
 
 	for_each_node(nid) {
-		mz = mem_cgroup_nodeinfo(from, nid);
+		mz = from->nodeinfo[nid];
 		iter = &mz->iter;
 		cmpxchg(&iter->position, dead_memcg, NULL);
 	}
@@ -2438,7 +2439,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 				struct mem_cgroup_per_node *pn;
 				long x;
 
-				pn = mem_cgroup_nodeinfo(memcg, nid);
+				pn = memcg->nodeinfo[nid];
 				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
 
 				x = lstatc->count[i];
@@ -4145,7 +4146,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		unsigned long file_cost = 0;
 
 		for_each_online_pgdat(pgdat) {
-			mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+			mz = memcg->nodeinfo[pgdat->node_id];
 
 			anon_cost += mz->lruvec.anon_cost;
 			file_cost += mz->lruvec.file_cost;
-- 
2.30.0

