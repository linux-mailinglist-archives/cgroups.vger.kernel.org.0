Return-Path: <cgroups+bounces-10538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88FBB79EF
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E519E6D63
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963862D6603;
	Fri,  3 Oct 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r0z0oIlk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556262D47F5
	for <cgroups@vger.kernel.org>; Fri,  3 Oct 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510467; cv=none; b=YIAP839jTh//1aWyYhFqFlDeW5Q9HCrqKgINQccbDV1Mn+DFgbE01c1+Ilfb425Z6zlcWqCYgcar7b1v+sMf4esed7h7cdFlEjkOdo52O0HRCfFDetiogARQCt5fHTiEUb0Kf22X0L0CaugjKkNpZIO/p+1ejV6NjAQD0YAIXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510467; c=relaxed/simple;
	bh=gGObfY2cbQ9aZ/mSVqPAUZ/j599TeVs4OpA7s7nw2vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwEZQv2V++8P95hoMvMpfCQ7suetARirwpUUwDysjgIWu1NETN1oVmAdlHgnr6I3xvnRvHWog41THSH7AXE5Qo/EhnYOGT32iqeqIcxhyBmeg9740YtTKFHU1gdIptbfw1GN3xiqMdo/wm7xhbwfa6rxI3bj7R+sazGgU875niY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r0z0oIlk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759510462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdGXwz8RCfksNzwLXFncQFeyfM2HiWcY9u8nErU1OTQ=;
	b=r0z0oIlk6NWImBasOPaB45bfsCP/wLTIrAznY5ImxqWU+ydf9O7stq0NWg5zUK/FRqv0IT
	fuIPOjhoJYLpCcJNYEWJ73dEWb6jtcUkUNJkdLAATVEtCzcJU32ysHe7GQkZ+Hy2h7UzcZ
	ND2kxJvX3NuIM9ClxdK4PhOYE/4+U6c=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 4/4] mm: thp: reparent the split queue during memcg offline
Date: Sat,  4 Oct 2025 00:53:18 +0800
Message-ID: <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1759510072.git.zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Similar to list_lru, the split queue is relatively independent and does
not need to be reparented along with objcg and LRU folios (holding
objcg lock and lru lock). So let's apply the similar mechanism as list_lru
to reparent the split queue separately when memcg is offine.

This is also a preparation for reparenting LRU folios.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/huge_mm.h |  4 +++
 mm/huge_memory.c        | 54 +++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c         |  1 +
 3 files changed, 59 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f327d62fc9852..0c211dcbb0ec1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -417,6 +417,9 @@ static inline int split_huge_page(struct page *page)
 	return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
+#ifdef CONFIG_MEMCG
+void reparent_deferred_split_queue(struct mem_cgroup *memcg);
+#endif
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
@@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
 }
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
+static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 59ddebc9f3232..b5eea2091cdf6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1099,6 +1099,11 @@ static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memc
 {
 	return memcg ? &memcg->deferred_split_queue : split_queue_node(nid);
 }
+
+static bool memcg_is_dying(struct mem_cgroup *memcg)
+{
+	return memcg ? css_is_dying(&memcg->css) : false;
+}
 #else
 static inline
 struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
@@ -1111,14 +1116,30 @@ static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memc
 {
 	return split_queue_node(nid);
 }
+
+static bool memcg_is_dying(struct mem_cgroup *memcg)
+{
+	return false;
+}
 #endif
 
 static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg)
 {
 	struct deferred_split *queue;
 
+retry:
 	queue = memcg_split_queue(nid, memcg);
 	spin_lock(&queue->split_queue_lock);
+	/*
+	 * There is a period between setting memcg to dying and reparenting
+	 * deferred split queue, and during this period the THPs in the deferred
+	 * split queue will be hidden from the shrinker side.
+	 */
+	if (unlikely(memcg_is_dying(memcg))) {
+		spin_unlock(&queue->split_queue_lock);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -1128,8 +1149,14 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
 {
 	struct deferred_split *queue;
 
+retry:
 	queue = memcg_split_queue(nid, memcg);
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+	if (unlikely(memcg_is_dying(memcg))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -4271,6 +4298,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	return split;
 }
 
+#ifdef CONFIG_MEMCG
+void reparent_deferred_split_queue(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
+	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
+	int nid;
+
+	spin_lock_irq(&ds_queue->split_queue_lock);
+	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
+
+	if (!ds_queue->split_queue_len)
+		goto unlock;
+
+	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
+	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
+	ds_queue->split_queue_len = 0;
+
+	for_each_node(nid)
+		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
+
+unlock:
+	spin_unlock(&parent_ds_queue->split_queue_lock);
+	spin_unlock_irq(&ds_queue->split_queue_lock);
+}
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 static void split_huge_pages_all(void)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f41..2acb53fd7f71e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3888,6 +3888,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	zswap_memcg_offline_cleanup(memcg);
 
 	memcg_offline_kmem(memcg);
+	reparent_deferred_split_queue(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
-- 
2.20.1


