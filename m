Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99637366035
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhDTTaz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 15:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233758AbhDTTaw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 15:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618947020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=leP7ynLW/Ya0OWUxwJ+81qaZKo2i+UvXWl8PamMADZY=;
        b=PARmr/G8zSJA5gp6e6K8Vb146eBxiXC3OK0E5Gh6wPyYxwkGjfMc+VchhLp02atCGZNXlh
        tMNFuEEEGMywO4l/tnMKzugr5UiF9BnFTSCleDLVfPGTTyKoWEL3sckmZ7iZvrkmNxEYU6
        o3jYtqMMYy16Eigqc6dgRAN82b9VWNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-yiUIPRpgPHOGXzsEGvQxhQ-1; Tue, 20 Apr 2021 15:29:52 -0400
X-MC-Unique: yiUIPRpgPHOGXzsEGvQxhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EAD08030DB;
        Tue, 20 Apr 2021 19:29:49 +0000 (UTC)
Received: from llong.com (ovpn-114-123.rdu2.redhat.com [10.10.114.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7878D610F3;
        Tue, 20 Apr 2021 19:29:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-next v5 2/4] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
Date:   Tue, 20 Apr 2021 15:29:05 -0400
Message-Id: <20210420192907.30880-3-longman@redhat.com>
In-Reply-To: <20210420192907.30880-1-longman@redhat.com>
References: <20210420192907.30880-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Before the new slab memory controller with per object byte charging,
charging and vmstat data update happen only when new slab pages are
allocated or freed. Now they are done with every kmem_cache_alloc()
and kmem_cache_free(). This causes additional overhead for workloads
that generate a lot of alloc and free calls.

The memcg_stock_pcp is used to cache byte charge for a specific
obj_cgroup to reduce that overhead. To further reducing it, this patch
makes the vmstat data cached in the memcg_stock_pcp structure as well
until it accumulates a page size worth of update or when other cached
data change. Caching the vmstat data in the per-cpu stock eliminates two
writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
specific vmstat data by a write to a hot local stock cacheline.

On a 2-socket Cascade Lake server with instrumentation enabled and this
patch applied, it was found that about 20% (634400 out of 3243830)
of the time when mod_objcg_state() is called leads to an actual call
to __mod_objcg_state() after initial boot. When doing parallel kernel
build, the figure was about 17% (24329265 out of 142512465). So caching
the vmstat data reduces the number of calls to __mod_objcg_state()
by more than 80%.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7cd7187a017c..292b4783b1a7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -782,8 +782,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_unlock();
 }
 
-void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
-		     enum node_stat_item idx, int nr)
+static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
+				     struct pglist_data *pgdat,
+				     enum node_stat_item idx, int nr)
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
@@ -791,7 +792,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	__mod_memcg_lruvec_state(lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
@@ -2059,7 +2060,10 @@ struct memcg_stock_pcp {
 
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
+	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
+	int nr_slab_reclaimable_b;
+	int nr_slab_unreclaimable_b;
 #endif
 
 	struct work_struct work;
@@ -3008,6 +3012,63 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr)
+{
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
+	int *bytes;
+
+	local_irq_save(flags);
+	stock = this_cpu_ptr(&memcg_stock);
+
+	/*
+	 * Save vmstat data in stock and skip vmstat array update unless
+	 * accumulating over a page of vmstat data or when pgdat or idx
+	 * changes.
+	 */
+	if (stock->cached_objcg != objcg) {
+		drain_obj_stock(stock);
+		obj_cgroup_get(objcg);
+		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+		stock->cached_objcg = objcg;
+		stock->cached_pgdat = pgdat;
+	} else if (stock->cached_pgdat != pgdat) {
+		/* Flush the existing cached vmstat data */
+		if (stock->nr_slab_reclaimable_b) {
+			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
+					  stock->nr_slab_reclaimable_b);
+			stock->nr_slab_reclaimable_b = 0;
+		}
+		if (stock->nr_slab_unreclaimable_b) {
+			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
+					  stock->nr_slab_unreclaimable_b);
+			stock->nr_slab_unreclaimable_b = 0;
+		}
+		stock->cached_pgdat = pgdat;
+	}
+
+	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
+					       : &stock->nr_slab_unreclaimable_b;
+	if (!*bytes) {
+		*bytes = nr;
+		nr = 0;
+	} else {
+		*bytes += nr;
+		if (abs(*bytes) > PAGE_SIZE) {
+			nr = *bytes;
+			*bytes = 0;
+		} else {
+			nr = 0;
+		}
+	}
+	if (nr)
+		mod_objcg_mlstate(objcg, pgdat, idx, nr);
+
+	local_irq_restore(flags);
+}
+
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
@@ -3055,6 +3116,25 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->nr_bytes = 0;
 	}
 
+	/*
+	 * Flush the vmstat data in current stock
+	 */
+	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
+		if (stock->nr_slab_reclaimable_b) {
+			mod_objcg_mlstate(old, stock->cached_pgdat,
+					  NR_SLAB_RECLAIMABLE_B,
+					  stock->nr_slab_reclaimable_b);
+			stock->nr_slab_reclaimable_b = 0;
+		}
+		if (stock->nr_slab_unreclaimable_b) {
+			mod_objcg_mlstate(old, stock->cached_pgdat,
+					  NR_SLAB_UNRECLAIMABLE_B,
+					  stock->nr_slab_unreclaimable_b);
+			stock->nr_slab_unreclaimable_b = 0;
+		}
+		stock->cached_pgdat = NULL;
+	}
+
 	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
 }
-- 
2.18.1

