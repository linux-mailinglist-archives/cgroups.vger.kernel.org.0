Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFF26F2B6
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgIRDBT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98299C061756
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:17 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so3457645qky.0
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=quTmQKmvj9k24MCP9HJuhYxbIPALZEbg5rUE1WUWNzk=;
        b=TqxUT8oYt7IQQ4RmJjkJOpm1JWoqZxlnUXsXQgBh+egnzkelbzRTLgjNf9GOR+cEcG
         bonHmsrnPcNfGIyqGwpPwKHY5FuxXVCCSLArnZ9/aEuOrhgHyRudqGSiNfAo7+L4tdtt
         3nn0MhJDTVjNFI3ZmkmUcsqcJBB+CkGnyvl/QeqxULujicPL/JiQAEGNTFfDarxeH1tr
         P98fUXdsYPYz5+aTCuRwmwZBmBNltOwhJOidu4RN6Ts640bsPEJxMClpKt4LCEzlD6So
         eOJZVlXgnUMC8IDAM+Hqn96bifT33u18qim9fQjIRHmiVkhHylMD3k5rXKA8aUFKcm+n
         VYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quTmQKmvj9k24MCP9HJuhYxbIPALZEbg5rUE1WUWNzk=;
        b=rSmSe+lLQgECFzoukm8g88/Y9v/BWJF5yJoA3sDOyCIEOfeZvlBy85IZ0Wk+6MMFKz
         Pu8i6IaGqx7taxlNqYQ87O266ndzn611OMoifxHpNzt9LejsV0RdKwAx/Y+wjhq2oOhJ
         2D+nONGDQHyS83cfeQhMfA1lfB1U/5v1jSfk/b5gvV4KwasvGcTmvXn6mw3fWdgfiuCB
         3Wpa2KSpqngZUAp8UU4RDpRpONGLnM4q0Sq9egaiuyhbT3Nf9WKN93pP+Earg1eP1tHF
         rwye/9ZkMXrlkdix8dzDWUdQFTzqDG/sueYZjpkZDRldPDvFJNBrIW3p866LXRKOugF2
         fXvw==
X-Gm-Message-State: AOAM531iZlNw4kjD0JzMm4pr/MXhQMSKUvmrN5o06nseWPS05p5oF/pe
        GZijCaNKUt0r1oKEGd3Pz/polZGpt5Y=
X-Google-Smtp-Source: ABdhPJx8Iy0UQqYwOk32k7vXKcaC3dm456ghlzIfQzdm4d+sSvCnRGu8u56jTkTxqUgi68jHOAURiox/7Hw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:ad4:5745:: with SMTP id q5mr31480664qvx.29.1600398076756;
 Thu, 17 Sep 2020 20:01:16 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:51 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-14-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 13/13] mm: enlarge the int parameter of update_lru_size()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In update_lru_sizes(), we call update_lru_size() with a long
argument, whereas the callee only takes an int parameter. Though this
isn't causing any overflow I'm aware of, it's not a good idea to
go through the truncation since the underlying counters are already
in long.

This patch enlarges all relevant parameters on the path to the final
underlying counters:
	update_lru_size(int -> long)
		if memcg:
			__mod_lruvec_state(int -> long)
				if smp:
					__mod_node_page_state(long)
				else:
					__mod_node_page_state(int -> long)
			__mod_memcg_lruvec_state(int -> long)
				__mod_memcg_state(int -> long)
		else:
			__mod_lruvec_state(int -> long)
				if smp:
					__mod_node_page_state(long)
				else:
					__mod_node_page_state(int -> long)

		__mod_zone_page_state(long)

		if memcg:
			mem_cgroup_update_lru_size(int -> long)

Note that __mod_node_page_state() for the smp case and
__mod_zone_page_state() already use long. So this change also fixes
the inconsistency.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/memcontrol.h | 14 +++++++-------
 include/linux/mm_inline.h  |  2 +-
 include/linux/vmstat.h     |  2 +-
 mm/memcontrol.c            | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..fcd1829f8382 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -621,7 +621,7 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
 
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
-		int zid, int nr_pages);
+		int zid, long nr_pages);
 
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
@@ -707,7 +707,7 @@ static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
 	return x;
 }
 
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
+void __mod_memcg_state(struct mem_cgroup *memcg, int idx, long val);
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
@@ -790,9 +790,9 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val);
+			      long val);
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			int val);
+			long val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 
 void mod_memcg_obj_state(void *p, int idx, int val);
@@ -1166,7 +1166,7 @@ static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
 
 static inline void __mod_memcg_state(struct mem_cgroup *memcg,
 				     int idx,
-				     int nr)
+				     long nr)
 {
 }
 
@@ -1201,12 +1201,12 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
-					    enum node_stat_item idx, int val)
+					    enum node_stat_item idx, long val)
 {
 }
 
 static inline void __mod_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx, int val)
+				      enum node_stat_item idx, long val)
 {
 	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..18e85071b44a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -26,7 +26,7 @@ static inline int page_is_file_lru(struct page *page)
 
 static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
-				int nr_pages)
+				long nr_pages)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 91220ace31da..2ae35e8c45f0 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -310,7 +310,7 @@ static inline void __mod_zone_page_state(struct zone *zone,
 }
 
 static inline void __mod_node_page_state(struct pglist_data *pgdat,
-			enum node_stat_item item, int delta)
+			enum node_stat_item item, long delta)
 {
 	node_page_state_add(delta, pgdat, item);
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cfa6cbad21d5..11bc4bb36882 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -774,7 +774,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
+void __mod_memcg_state(struct mem_cgroup *memcg, int idx, long val)
 {
 	long x, threshold = MEMCG_CHARGE_BATCH;
 
@@ -812,7 +812,7 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
 }
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val)
+			      long val)
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
@@ -853,7 +853,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
  * change of state at this level: per-node, per-cgroup, per-lruvec.
  */
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			int val)
+			long val)
 {
 	/* Update node */
 	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
@@ -1354,7 +1354,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
  * so as to allow it to check that lru_size 0 is consistent with list_empty).
  */
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
-				int zid, int nr_pages)
+				int zid, long nr_pages)
 {
 	struct mem_cgroup_per_node *mz;
 	unsigned long *lru_size;
@@ -1371,7 +1371,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 
 	size = *lru_size;
 	if (WARN_ONCE(size < 0,
-		"%s(%p, %d, %d): lru_size %ld\n",
+		"%s(%p, %d, %ld): lru_size %ld\n",
 		__func__, lruvec, lru, nr_pages, size)) {
 		VM_BUG_ON(1);
 		*lru_size = 0;
-- 
2.28.0.681.g6f77f65b4e-goog

