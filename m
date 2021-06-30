Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34E3B7C5A
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhF3EGU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhF3EGU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A3C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=61msnB23CZehcqWgrUMdSZxzGrV4zpn68Z+u3tCZTOE=; b=uNMObRprg4+OmqsxA0UfUTIJkx
        c3zHhQf7t6L2nqJM4ojCzgrX6z24uOr/+MKd0azZ+sbs5dGRWZhqPoJjcWYddv4WD+F4FP/P+y0OT
        aybe9mP3u9dHSn3FWQJLveBE6zgBPuYzcnC01BdfugK6Juqj1IDJv4ZcTWC9bmBvSuEC9gdaf4KbK
        T0BPioCtVfEbHk//sTi07twwcr7MBIHZbpvb53MPhg8lyjbqTg4GpP9PpcZm6gEwWIRWXBfgl1YG7
        nAX/VHI0UR6VhYXq2Fbn279d6pDKESdnAmreE7QLhovuKPtBdXCMDSyvYsHUAIWM6xmBAieKk9eJo
        bMi4fGhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRQx-004qr9-Fv; Wed, 30 Jun 2021 04:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 03/18] mm/memcg: Use the node id in mem_cgroup_update_tree()
Date:   Wed, 30 Jun 2021 05:00:19 +0100
Message-Id: <20210630040034.1155892-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

By using the node id in mem_cgroup_update_tree(), we can delete
soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
bytes of kernel text on my config.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25cad0fb7d4e..29b28a050707 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -446,28 +446,12 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static struct mem_cgroup_per_node *
-mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return memcg->nodeinfo[nid];
-}
-
 static struct mem_cgroup_tree_per_node *
 soft_limit_tree_node(int nid)
 {
 	return soft_limit_tree.rb_tree_per_node[nid];
 }
 
-static struct mem_cgroup_tree_per_node *
-soft_limit_tree_from_page(struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return soft_limit_tree.rb_tree_per_node[nid];
-}
-
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
@@ -538,13 +522,13 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
+static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	mctz = soft_limit_tree_from_page(page);
+	mctz = soft_limit_tree_node(nid);
 	if (!mctz)
 		return;
 	/*
@@ -552,7 +536,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
 	 * because their event counter is not touched.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = mem_cgroup_page_nodeinfo(memcg, page);
+		mz = memcg->nodeinfo[nid];
 		excess = soft_limit_excess(memcg);
 		/*
 		 * We have to update the tree if mz is on RB-tree or
@@ -879,7 +863,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, page);
+			mem_cgroup_update_tree(memcg, page_to_nid(page));
 	}
 }
 
-- 
2.30.2

