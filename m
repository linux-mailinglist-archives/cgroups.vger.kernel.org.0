Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB43153F4
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhBIQeh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbhBIQeQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:34:16 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DF5C06178A
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:31 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e11so13355580qtg.6
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4R65KE0u5JIY01fjm4wgVu+gu5q/lvBl+LPH4oeHXQ=;
        b=Qx1hsNIBKzPGS5WVp3uPVWOgmopu/NZpQU4ukJDvflvwPNsDFADDbI29Hl7diG7zNW
         4zyEsfd1/hFlF2CdIg9JLdL/DDxuPMPk6ezPNlI76GiQs9VLyPa2ncWtGG6Zd2nxMDyn
         KPDKF6bBe7CKRU9u3u31mSENocHiAwJBbECTFbx2GFt29+pp/oJHT9RR6cf+9vCJvBai
         PXgDhlJsS30qrNHQ1OIex6lex782vvKQWOmTykOaCpgR1kPOOGVlqBUctNY6yKov3EM7
         dOzSEBcvX32urg0+9MAvnFczOMDgHR059MT21DN3AQrz90HikGRPm9RpqBaITUe3Iteg
         m6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4R65KE0u5JIY01fjm4wgVu+gu5q/lvBl+LPH4oeHXQ=;
        b=iboGeTC1h/WpW7ZmahVXnvtbe4boXDbukoDuAm2IhAfMKnVNvV7JKziXKuhyfQdfIb
         mcQ8I+QzW1nH2EHVzDyFV5zPsuRUv4/cYCsihM48wEiKOLk5CFMED8LuXswizgnBrj5q
         lwdqCO8riTeLGG666oBLQ+lxI9a8y7lX04VHRoHK/iYVEFpqGCZ56/V1fzfa74/HC6lw
         wVHoPF+RZ/h7JsOPlKFkOQUPv/FxDxFe07czH2CJEWvNOIZpX8kS5fKJlXTWxVucXNHS
         lUQNAOCPM3ctkTCsppyKjMpuy8U2ZA4kraWlSgF0nkNDt+/oCPZOS261/XqAX1yp2oOa
         yCeQ==
X-Gm-Message-State: AOAM530V4UV2OKnvfiZxOIJ7bkU1JjUxQcAnTIXpvbkqWtZl9IFqOJUr
        Z1DPgzoXMcydeBBwqS7zUcR6AA==
X-Google-Smtp-Source: ABdhPJybWumFl8xAwwiSRdUaXNW8WC6Cef2ZBtzgaYfL207iVM8rgncYinREVJoDW/70i1KVZrNB+A==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr21872039qtq.330.1612888410221;
        Tue, 09 Feb 2021 08:33:30 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id f26sm7099548qkh.80.2021.02.09.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:29 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 2/8] mm: memcontrol: kill mem_cgroup_nodeinfo()
Date:   Tue,  9 Feb 2021 11:32:58 -0500
Message-Id: <20210209163304.77088-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
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

