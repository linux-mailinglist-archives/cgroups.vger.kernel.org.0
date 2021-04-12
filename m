Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C056535D38A
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbhDLWz7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 18:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343910AbhDLWz4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 18:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618268137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=x9sOHgVsi/JZH5ao8kUPYU6FS5v/REIN9a6IWHWDaPc=;
        b=PIqeN+StABj5rS0BB/etLm3+pmNTllH1pFg8KDLmHMq1XFxbA6A4E2jVJ2eqDCr1pT060v
        CDpYIGQhq8+pjgMDcA2NnwZ2B+P0QKUC1RPEo1phdWP+2Hkp0BiFj9fyhj4AGRN5hYokCF
        qOhnwVm/9igVOeZHTE91PXgO5ChSiDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-m1nKxJdYMfuZaHkW4x29oQ-1; Mon, 12 Apr 2021 18:55:35 -0400
X-MC-Unique: m1nKxJdYMfuZaHkW4x29oQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BABA801814;
        Mon, 12 Apr 2021 22:55:33 +0000 (UTC)
Received: from llong.com (ovpn-114-18.rdu2.redhat.com [10.10.114.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBF1E5D6D1;
        Mon, 12 Apr 2021 22:55:30 +0000 (UTC)
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
Subject: [PATCH v2 5/5] mm/memcg: Optimize user context object stock access
Date:   Mon, 12 Apr 2021 18:55:03 -0400
Message-Id: <20210412225503.15119-6-longman@redhat.com>
In-Reply-To: <20210412225503.15119-1-longman@redhat.com>
References: <20210412225503.15119-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Most kmem_cache_alloc() calls are from user context. With instrumentation
enabled, the measured amount of kmem_cache_alloc() calls from non-task
context was about 0.01% of the total.

The irq disable/enable sequence used in this case to access content
from object stock is slow.  To optimize for user context access, there
are now two object stocks for task context and interrupt context access
respectively.

The task context object stock can be accessed after disabling preemption
which is cheap in non-preempt kernel. The interrupt context object stock
can only be accessed after disabling interrupt. User context code can
access interrupt object stock, but not vice versa.

The mod_objcg_state() function is also modified to make sure that memcg
and lruvec stat updates are done with interrupted disabled.

The downside of this change is that there are more data stored in local
object stocks and not reflected in the charge counter and the vmstat
arrays.  However, this is a small price to pay for better performance.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 73 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69f728383efe..29f2df76644a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2229,7 +2229,8 @@ struct obj_stock {
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
-	struct obj_stock obj;
+	struct obj_stock task_obj;
+	struct obj_stock irq_obj;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -2254,11 +2255,48 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 }
 #endif
 
+/*
+ * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
+ * sequence used in this case to access content from object stock is slow.
+ * To optimize for user context access, there are now two object stocks for
+ * task context and interrupt context access respectively.
+ *
+ * The task context object stock can be accessed by disabling preemption only
+ * which is cheap in non-preempt kernel. The interrupt context object stock
+ * can only be accessed after disabling interrupt. User context code can
+ * access interrupt object stock, but not vice versa.
+ */
 static inline struct obj_stock *current_obj_stock(void)
 {
 	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
 
-	return &stock->obj;
+	return in_task() ? &stock->task_obj : &stock->irq_obj;
+}
+
+#define get_obj_stock(flags)				\
+({							\
+	struct memcg_stock_pcp *stock;			\
+	struct obj_stock *obj_stock;			\
+							\
+	if (in_task()) {				\
+		preempt_disable();			\
+		(flags) = -1L;				\
+		stock = this_cpu_ptr(&memcg_stock);	\
+		obj_stock = &stock->task_obj;		\
+	} else {					\
+		local_irq_save(flags);			\
+		stock = this_cpu_ptr(&memcg_stock);	\
+		obj_stock = &stock->irq_obj;		\
+	}						\
+	obj_stock;					\
+})
+
+static inline void put_obj_stock(unsigned long flags)
+{
+	if (flags == -1L)
+		preempt_enable();
+	else
+		local_irq_restore(flags);
 }
 
 /**
@@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->obj);
+	drain_obj_stock(&stock->irq_obj);
+	if (in_task())
+		drain_obj_stock(&stock->task_obj);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
@@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
 	memcg = obj_cgroup_memcg(objcg);
 	if (pgdat)
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
+	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
@@ -3193,7 +3233,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_irq_save(flags);
+	stock = get_obj_stock(flags);
 
 	stock = current_obj_stock();
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
@@ -3201,7 +3241,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	put_obj_stock(flags);
 
 	return ret;
 }
@@ -3254,8 +3294,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
-	if (stock->obj.cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->obj.cached_objcg);
+	if (in_task() && stock->task_obj.cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
+		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
+			return true;
+	}
+	if (stock->irq_obj.cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3283,9 +3328,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	get_obj_stock(flags);
 	__refill_obj_stock(objcg, nr_bytes);
-	local_irq_restore(flags);
+	put_obj_stock(flags);
 }
 
 static void __mod_obj_stock_state(struct obj_cgroup *objcg,
@@ -3325,9 +3370,9 @@ void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	get_obj_stock(flags);
 	__mod_obj_stock_state(objcg, pgdat, idx, nr);
-	local_irq_restore(flags);
+	put_obj_stock(flags);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -3380,10 +3425,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	get_obj_stock(flags);
 	__refill_obj_stock(objcg, size);
 	__mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
-	local_irq_restore(flags);
+	put_obj_stock(flags);
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
-- 
2.18.1

