Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A031F3B7C5D
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 06:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhF3EGp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhF3EGp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 00:06:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B73C061760
        for <cgroups@vger.kernel.org>; Tue, 29 Jun 2021 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PwsSA74q8jzQkF60ZcOSZIYYGpRCVr7nhS/J6QbnC8s=; b=Qi1z/+jkseioZ7eFE1HwqIaJK7
        mRtcW1jc9s+65POwMrRHHKi6gRQ5P0x5/+G5inWeDfLGFPlWY2MP05cZzdXhew6BePbvBgc10D4l9
        f3d2tAYn2pSFaRv3TyqN3ilt0S+1QtHjAZSg5CdYmgPiSB2BnkyUMG2CL/9r3A0KZh7EbSY/DK3Ir
        /JLUFlWTLEHs8AB1JzUHs9Pg7W+Yz4EPmaF0+Kfrohbnpu6jvWPUdsMQ/JMchFIFVjuluVXz8VdkN
        CaP7bYSyzrpr1/S1AXn8vwZlB49O+pCzeEVJUGzYMGTXSWQaxUW12rIG+HJCYQhM9dQJ9pCsWcHG2
        wB/w9Wug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyRRS-004qt4-CH; Wed, 30 Jun 2021 04:03:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH v3 04/18] mm/memcg: Remove soft_limit_tree_node()
Date:   Wed, 30 Jun 2021 05:00:20 +0100
Message-Id: <20210630040034.1155892-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630040034.1155892-1-willy@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Opencode this one-line function in its three callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29b28a050707..29fdb70dca42 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -446,12 +446,6 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static struct mem_cgroup_tree_per_node *
-soft_limit_tree_node(int nid)
-{
-	return soft_limit_tree.rb_tree_per_node[nid];
-}
-
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
@@ -528,7 +522,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	mctz = soft_limit_tree_node(nid);
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
 	if (!mctz)
 		return;
 	/*
@@ -567,7 +561,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		mz = memcg->nodeinfo[nid];
-		mctz = soft_limit_tree_node(nid);
+		mctz = soft_limit_tree.rb_tree_per_node[nid];
 		if (mctz)
 			mem_cgroup_remove_exceeded(mz, mctz);
 	}
@@ -3415,7 +3409,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	if (order > 0)
 		return 0;
 
-	mctz = soft_limit_tree_node(pgdat->node_id);
+	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
 
 	/*
 	 * Do not even bother to check the largest node if the root
-- 
2.30.2

