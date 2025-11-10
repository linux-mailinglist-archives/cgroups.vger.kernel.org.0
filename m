Return-Path: <cgroups+bounces-11767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23EC49BAF
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 00:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFD4EE250
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E630101B;
	Mon, 10 Nov 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmWY40qN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774F2EAB61
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816877; cv=none; b=iIDSfddGheeB2kyzV1YCmtD2spEEUK0Q37aVEsuQhe3qjJpVkfds++EeV9OFtujRByO9AhHJclG2UChlSoEGKOS6OSD75ha401vqgZi9wmRL4V8vOem+/pHTHVpazjXozwkRIo5HPesviDpzlF5K11Y/y0XDPdVhpk3siqH5eoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816877; c=relaxed/simple;
	bh=IAf0KX2uEXPUE/F1NX4jaitahNH53U3qnBwckd/2Mjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUU6DJyi1j/W/AyxlAuEAqyN/Inv0JWJSJsxnPAIM4R78j5Tkq6ygp23OlVaA1FxtnJZVd2Tmypj/CKC5ufNUw9EHwB0xiEWzS7oL20K1eTLBfLlyFc6h60oOiDWZX8riQeREtj9RRVm2YULmrl5UkmkEvsExKaNtB8zvXyM+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mmWY40qN; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762816874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46TR/sEczQ+2endRnnVwUIJHB5dy7B94vjCFZXto+D4=;
	b=mmWY40qN6VIF9ZxDo3HqTObvI92nLXnIOdn9QVUEniqCl+Q/AcuqeInjI3fOW+Drh5TLpA
	amlVqxwCPeEVsVDwCDbuiPFQpFlv30CJHJtBjDcnshma286fhPwsh3aiYmvELvFdy2MXDd
	R9Mv7CVSiOawTROCn3U/VA4oK9rpYgE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/4] memcg: remove __mod_lruvec_kmem_state
Date: Mon, 10 Nov 2025 15:20:06 -0800
Message-ID: <20251110232008.1352063-3-shakeel.butt@linux.dev>
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The __mod_lruvec_kmem_state is already safe against irqs, so there is no
need to have a separate interface (i.e. mod_lruvec_kmem_state) which
wraps calls to it with irq disabling and reenabling. Let's rename
__mod_lruvec_kmem_state to mod_lruvec_kmem_state.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 28 +++++-----------------------
 mm/memcontrol.c            |  2 +-
 mm/workingset.c            |  2 +-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f82fac2fd988..1384a9d305e1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -957,17 +957,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
-void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
-
-static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
-					 int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_lruvec_kmem_state(p, idx, val);
-	local_irq_restore(flags);
-}
+void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
 
 void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			unsigned long count);
@@ -1403,14 +1393,6 @@ static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 }
 
-static inline void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
-					   int val)
-{
-	struct page *page = virt_to_head_page(p);
-
-	mod_node_page_state(page_pgdat(page), idx, val);
-}
-
 static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 					 int val)
 {
@@ -1470,14 +1452,14 @@ struct slabobj_ext {
 #endif
 } __aligned(8);
 
-static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
+static inline void inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
-	__mod_lruvec_kmem_state(p, idx, 1);
+	mod_lruvec_kmem_state(p, idx, 1);
 }
 
-static inline void __dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
+static inline void dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
-	__mod_lruvec_kmem_state(p, idx, -1);
+	mod_lruvec_kmem_state(p, idx, -1);
 }
 
 static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f4b8a6414ed3..3a59d3ee92a7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -799,7 +799,7 @@ void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 }
 EXPORT_SYMBOL(__lruvec_stat_mod_folio);
 
-void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
+void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 {
 	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
 	struct mem_cgroup *memcg;
diff --git a/mm/workingset.c b/mm/workingset.c
index d32dc2e02a61..892f6fe94ea9 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -749,7 +749,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
 	xa_delete_node(node, workingset_update_node);
-	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
+	inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.47.3


