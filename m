Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0832B310FF3
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhBEQuD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 11:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhBEQrv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:47:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDEC06121F
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:29 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t17so5691362qtq.2
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4R65KE0u5JIY01fjm4wgVu+gu5q/lvBl+LPH4oeHXQ=;
        b=2GoTFtEowqrMcE/2JXvhPu/VJNSggY8k2YXKw+oBnF8qVqSj6nFZJeXkZSmQvh8Chb
         iKccOdyZsvW9v8jznhdC39v/OqbplLGxQ115ICBCsWhCh6GUT5AItWlGkMnzetbPVRL4
         VlU94D2Rl6GaGRw4lAd6FsE25kmQ7ni7w3piepIbRGd4Jts5HY0bjVyLY1Mer5oD7HHr
         tN3uEwpoJoGGutOMcv2OHRj9Yw2D8DxYUTpqeFsShqs6/jsKScTJxsrn6XlRoYE9R85e
         35x/epOpQ3YVQmPBd9A3QMw5J03QfaPF6YSrE2LfOJkkOZzB+3UoHW/aBkLkQEMw6b20
         9KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4R65KE0u5JIY01fjm4wgVu+gu5q/lvBl+LPH4oeHXQ=;
        b=F8FGZgXngXHJHXSDLxnC0khmut+0rhA49YQYh+LGOs0jJA5oP/7KVZ7t0QPnDBf5pW
         j86Pjmvtd5hyC5H4sC7z2QjCvuAHftzTQR5TmaH/TZ7R0QzOFPv+MtidJg8QmwNg6JIV
         d1SCqZItV6cWinXpWrN2rfOsi9b592cEEAsQtDcpdr+2upt0DQSeVGNefsQhwExX+vI0
         GpfiIZ6KQZivQ7Zt8LYi015xAcq9+YAL3Y1mLbw2TrACgnLhkd2Sp5835ieqGkF/MXwp
         MBXMXfq6mjp5YxWEhfd8u7yYCpHx3G9ovSmXpuNOciOsNOGUBoXzJA3imwIrAHdIdezE
         pHVQ==
X-Gm-Message-State: AOAM532TwIrgjb/y7KNbTZdaBNmLrtdY3SWGMJrG46Hxh7Rk4Lx7ZJ6h
        nvad3Sv+aospD1mcZeZlAoY933h1+BI1QQ==
X-Google-Smtp-Source: ABdhPJxskLL12QuPeM80alts2Ieohd4DWn8gwtbIQhntDTTUcKmLwiiV5MLgVvq2UCooCL7jTMQRbg==
X-Received: by 2002:aed:2090:: with SMTP id 16mr5283187qtb.265.1612549708373;
        Fri, 05 Feb 2021 10:28:28 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h5sm9029066qti.22.2021.02.05.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:27 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/8] mm: memcontrol: kill mem_cgroup_nodeinfo()
Date:   Fri,  5 Feb 2021 13:28:00 -0500
Message-Id: <20210205182806.17220-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No need to encapsulate a simple struct member access.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
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

