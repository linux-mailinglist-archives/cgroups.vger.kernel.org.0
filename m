Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27DB37561B
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhEFPBj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 11:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235007AbhEFPBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 May 2021 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620313236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=H/3pDryNy1ArKnAb9Y90Bdr4BPpK6TJxya/lPKfIzqo=;
        b=hnAw0oFGFqhhUC1U5XAtwDaO8DMmajKhHsqmFiWh3Rz/mqlYxofNf1jcxOukxIlXXLdwu/
        ddyYubn1LX49uG0E4qUhNrFUm3BmXoYY9hPNDsIyo31MOBPd8cIAJPei1sKF2WMVjv3Jb/
        kBJTNHIsQ4LrcyGSuxwcBNfsFsRtokA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-etnnmRpNOGeU5D3sBCSsdg-1; Thu, 06 May 2021 11:00:33 -0400
X-MC-Unique: etnnmRpNOGeU5D3sBCSsdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6EB38015F3;
        Thu,  6 May 2021 15:00:29 +0000 (UTC)
Received: from llong.com (ovpn-114-62.rdu2.redhat.com [10.10.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A0F19100;
        Thu,  6 May 2021 15:00:27 +0000 (UTC)
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
Subject: [PATCH v6 2/4] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
Date:   Thu,  6 May 2021 11:00:05 -0400
Message-Id: <20210506150007.16288-3-longman@redhat.com>
In-Reply-To: <20210506150007.16288-1-longman@redhat.com>
References: <20210506150007.16288-1-longman@redhat.com>
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
 mm/memcontrol.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 859f872b482e..fbedfc55a248 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -906,8 +906,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
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
@@ -915,7 +916,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	__mod_memcg_lruvec_state(lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
@@ -2183,7 +2184,10 @@ struct memcg_stock_pcp {
 
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
+	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
+	int nr_slab_reclaimable_b;
+	int nr_slab_unreclaimable_b;
 #endif
 
 	struct work_struct work;
@@ -3132,6 +3136,67 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
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
+	/*
+	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
+	 * cached locally at least once before pushing it out.
+	 */
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
@@ -3179,6 +3244,25 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
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

