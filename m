Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A3C35EA48
	for <lists+cgroups@lfdr.de>; Wed, 14 Apr 2021 03:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbhDNBVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 21:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348975AbhDNBVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 21:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618363257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=IlA+/38VRkCrVKRXGT1ylxCOiikwqFhWLtO/GPa0v/o=;
        b=H28DyfybBEaQpE/KJ9Scl8VF7ZotB9SWaoP1cBez0m+/HERhSTNXFUep25/udeO4/QDEEK
        i38J58LM/DgjCY3jp39AYDAKXCDBlcXNh1R13J8SV5Rs6PgtQP68TvsDGt1M24Y7fpbgWb
        14AQMK+0GNu7zuvUQ38eg/UyNVyK09o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-A8KEbP9BPAWyqCqxrT9Kxg-1; Tue, 13 Apr 2021 21:20:55 -0400
X-MC-Unique: A8KEbP9BPAWyqCqxrT9Kxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E58A10054F6;
        Wed, 14 Apr 2021 01:20:53 +0000 (UTC)
Received: from llong.com (ovpn-113-4.rdu2.redhat.com [10.10.113.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 527B71A7D9;
        Wed, 14 Apr 2021 01:20:51 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
Date:   Tue, 13 Apr 2021 21:20:25 -0400
Message-Id: <20210414012027.5352-4-longman@redhat.com>
In-Reply-To: <20210414012027.5352-1-longman@redhat.com>
References: <20210414012027.5352-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
data change.

On a 2-socket Cascade Lake server with instrumentation enabled and this
patch applied, it was found that about 17% (946796 out of 5515184) of the
time when __mod_obj_stock_state() is called leads to an actual call to
mod_objcg_state() after initial boot. When doing parallel kernel build,
the figure was about 16% (21894614 out of 139780628). So caching the
vmstat data reduces the number of calls to mod_objcg_state() by more
than 80%.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 78 +++++++++++++++++++++++++++++++++++++++++++------
 mm/slab.h       | 26 +++++++----------
 2 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b19100c68aa0..539c3b632e47 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2220,7 +2220,10 @@ struct memcg_stock_pcp {
 
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
+	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
+	int vmstat_idx;
+	int vmstat_bytes;
 #endif
 
 	struct work_struct work;
@@ -3157,6 +3160,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	css_put(&memcg->css);
 }
 
+static inline void mod_objcg_state(struct obj_cgroup *objcg,
+				   struct pglist_data *pgdat,
+				   enum node_stat_item idx, int nr)
+{
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec = NULL;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	if (pgdat)
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
+	rcu_read_unlock();
+}
+
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
@@ -3207,6 +3225,14 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->nr_bytes = 0;
 	}
 
+	if (stock->vmstat_bytes) {
+		mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
+				stock->vmstat_bytes);
+		stock->vmstat_bytes = 0;
+		stock->vmstat_idx = 0;
+		stock->cached_pgdat = NULL;
+	}
+
 	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
 }
@@ -3251,6 +3277,48 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	local_irq_restore(flags);
 }
 
+static void __mod_obj_stock_state(struct obj_cgroup *objcg,
+				  struct pglist_data *pgdat, int idx, int nr)
+{
+	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+
+	if (stock->cached_objcg != objcg) {
+		/* Output the current data as is */
+	} else if (!stock->vmstat_bytes) {
+		/* Save the current data */
+		stock->vmstat_bytes = nr;
+		stock->vmstat_idx = idx;
+		stock->cached_pgdat = pgdat;
+		nr = 0;
+	} else if ((stock->cached_pgdat != pgdat) ||
+		   (stock->vmstat_idx != idx)) {
+		/* Output the cached data & save the current data */
+		swap(nr, stock->vmstat_bytes);
+		swap(idx, stock->vmstat_idx);
+		swap(pgdat, stock->cached_pgdat);
+	} else {
+		stock->vmstat_bytes += nr;
+		if (abs(nr) > PAGE_SIZE) {
+			nr = stock->vmstat_bytes;
+			stock->vmstat_bytes = 0;
+		} else {
+			nr = 0;
+		}
+	}
+	if (nr)
+		mod_objcg_state(objcg, pgdat, idx, nr);
+}
+
+void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+			 int idx, int nr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_obj_stock_state(objcg, pgdat, idx, nr);
+	local_irq_restore(flags);
+}
+
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 {
 	struct mem_cgroup *memcg;
@@ -3300,18 +3368,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
 				   struct pglist_data *pgdat, int idx)
 {
 	unsigned long flags;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec = NULL;
 
 	local_irq_save(flags);
 	__refill_obj_stock(objcg, size);
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	if (pgdat)
-		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_memcg_lruvec_state(memcg, lruvec, idx, -(int)size);
-	rcu_read_unlock();
+	__mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
 	local_irq_restore(flags);
 }
 
diff --git a/mm/slab.h b/mm/slab.h
index 677cdc52e641..03bd9813422b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -239,6 +239,8 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page);
+void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+			 int idx, int nr);
 
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
@@ -283,20 +285,6 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	return true;
 }
 
-static inline void mod_objcg_state(struct obj_cgroup *objcg,
-				   struct pglist_data *pgdat,
-				   enum node_stat_item idx, int nr)
-{
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
-	rcu_read_unlock();
-}
-
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
 					      gfp_t flags, size_t size,
@@ -324,8 +312,9 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			off = obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
 			page_objcgs(page)[off] = objcg;
-			mod_objcg_state(objcg, page_pgdat(page),
-					cache_vmstat_idx(s), obj_full_size(s));
+			mod_obj_stock_state(objcg, page_pgdat(page),
+					    cache_vmstat_idx(s),
+					    obj_full_size(s));
 		} else {
 			obj_cgroup_uncharge(objcg, obj_full_size(s));
 		}
@@ -408,6 +397,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s,
 					void **p, int objects)
 {
 }
+
+static inline void mod_obj_stock_state(struct obj_cgroup *objcg,
+				       struct pglist_data *pgdat, int idx, int nr)
+{
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static inline struct kmem_cache *virt_to_cache(const void *obj)
-- 
2.18.1

