Return-Path: <cgroups+bounces-2477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9A8A4732
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 05:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610261F219D2
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDF17BAA;
	Mon, 15 Apr 2024 03:11:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6631C36;
	Mon, 15 Apr 2024 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150710; cv=none; b=rpEi3uher3z2Teck2ojwNj/VKnzQx3aS24w+JQcNMAde0onkRwpzEk7jK9g4Xec4bmVEMCkoDhgNezWRWXIRaFM31d8DNpzG4CD8PcQdw12ZO2m1GRZtdm/rdSwKH6a2aGjLtmhUPV0ZGH9IP5KyZ7yFOt88ETfKz6rQIkBg8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150710; c=relaxed/simple;
	bh=3IvHce7lNC4S84RHDCeuNMMstEMBuQo+9+JntyZZ1Zs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=mM7ZeXIPSrppvAEplCHA1wb9pKVykMdAuWXE07TEU+G6Jv6KnDuffp89RNnN1gTBFodiYCMVv3qMVqfXlvqpY89Tbpw0qEx4Zd0SSKJ26tl11CH7LShwSoovnBXWqJ0OoTn0pc04kwjl08KeoKorAP0CEplzzZveswYEV4gyv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VHsdk2fWSz6G3wZ;
	Mon, 15 Apr 2024 11:11:38 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 43F3BMeA060726;
	Mon, 15 Apr 2024 11:11:22 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 15 Apr 2024 11:11:23 +0800 (CST)
Date: Mon, 15 Apr 2024 11:11:23 +0800 (CST)
X-Zmail-TransId: 2af9661c9adb5fc-0b588
X-Mailer: Zmail v1.0
Message-ID: <20240415111123924s9IbQkgHF8S4yZv4su8LI@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <v-songbaohua@oppo.com>, <mhocko@kernel.org>, <ryan.roberts@arm.com>,
        <david@redhat.com>
Cc: <roman.gushchin@linux.dev>, <shakeel.butt@linux.dev>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <lu.zhongjun@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBtbTogdGhwOiBtYWtlcyB0aGUgbWVtY2cgVEhQIGRlZmVycmVkIHNwbGl0IHNocmlua2VyIGF3YXJlIG9mCgogbm9kZV9pZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 43F3BMeA060726
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 661C9AEA.001/4VHsdk2fWSz6G3wZ

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since commit 87eaceb3faa5 ("mm: thp: make deferred split shrinker
memcg aware"), the THP deferred split queue is per memcg but not
per mem_cgroup_per_node. This has two aspects of impact:

Impact1: for kswapd reclaim
=====================
  kswapd
    balance_pgdat
      kswapd_shrink_node
        shrink_node(pgdat, sc);
          shrink_node_memcgs(pgdat, sc);
            shrink_slab(sc->gfp_mask, pgdat->node_id, memcg...);
  the parameter "pgdat->node_id"  does not take effectct for
  THP deferred_split_shrinker, as the deferred_split_queue of
  specified memcg is not for a certain numa node but for all the nodes.
  We want to makes the memcg THP deferred split shrinker aware of
  node_id.

Impact2: thp-deferred_split shrinker debugfs interface
=========================================
   for the "count" file:
   <cgroup inode id> <objects on node 0> <objects on node 1>
     the output is acctually the sum of all numa nodes.
   for the "scan" file:
   <cgroup inode id> <numa id> <number of objects to scan>
     Also the "numa id" input does not take effect here.

This patch makes memcg deferred_split_queue per mem_cgroup_per_node
so try to conform to semantic logic.

Reviewed-by: Lu Zhongjun <lu.zhongjun@zte.com.cn>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Cc: xu xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/memcontrol.h |  7 +++----
 mm/huge_memory.c           |  6 +++---
 mm/memcontrol.c            | 11 +++++------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 394fd0a887ae..7282861d5a5d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -130,6 +130,9 @@ struct mem_cgroup_per_node {
 	bool			on_tree;
 	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
 						/* use container_of	   */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct deferred_split deferred_split_queue;
+#endif
 };

 struct mem_cgroup_threshold {
@@ -327,10 +330,6 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct deferred_split deferred_split_queue;
-#endif
-
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
 	/* per-memcg mm_struct list */
 	struct lru_gen_mm_list mm_list;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..338d071070a6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -774,7 +774,7 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));

 	if (memcg)
-		return &memcg->deferred_split_queue;
+		return &memcg->nodeinfo[pgdat->node_id]->deferred_split_queue;
 	else
 		return &pgdat->deferred_split_queue;
 }
@@ -3305,7 +3305,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,

 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
+		ds_queue = &sc->memcg->nodeinfo[sc->nid]->deferred_split_queue;
 #endif
 	return READ_ONCE(ds_queue->split_queue_len);
 }
@@ -3322,7 +3322,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,

 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
+		ds_queue = &sc->memcg->nodeinfo[sc->nid]->deferred_split_queue;
 #endif

 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..cdf9f5fa3b8e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5445,7 +5445,11 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		kfree(pn);
 		return 1;
 	}
-
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock_init(&pn->deferred_split_queue.split_queue_lock);
+	INIT_LIST_HEAD(&pn->deferred_split_queue.split_queue);
+	pn->deferred_split_queue.split_queue_len = 0;
+#endif
 	lruvec_init(&pn->lruvec);
 	pn->memcg = memcg;

@@ -5545,11 +5549,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
 		memcg->cgwb_frn[i].done =
 			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
-	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
-	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
 	lru_gen_init_memcg(memcg);
 	return memcg;
-- 
2.15.2

