Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884D146F962
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhLJC43 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Dec 2021 21:56:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236078AbhLJC42 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Dec 2021 21:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639104773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OvObI7nEXeJiZonfZvXDNg0asabJh1D86F98Up+TTk8=;
        b=XFbEN74WKqKzONMxzHNv8zI7D4VN2+nB/kKMke9VhQCSY4FptAWMqV+5R8MyE/mpuDBSw2
        xSq5d4M5sG6uAefJYvMryhwFjbAuCzYbW+r6l0zgQ/DCAnzujFIFcsfbAN2AJWbhG6I/R1
        TNU+IgJZp7ECEPcjvVSEd6rM4akh2tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-orEd3y_JP3aOQL36R6lfDw-1; Thu, 09 Dec 2021 21:52:47 -0500
X-MC-Unique: orEd3y_JP3aOQL36R6lfDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED35E190B2CA;
        Fri, 10 Dec 2021 02:52:45 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C00F100AE22;
        Fri, 10 Dec 2021 02:52:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-next v2] mm/memcg: Properly handle memcg_stock access for PREEMPT_RT
Date:   Thu,  9 Dec 2021 21:52:28 -0500
Message-Id: <20211210025228.158196-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Direct calls to local_irq_{save/restore}() and preempt_{enable/disable}()
are not appropriate for PREEMPT_RT. To provide better PREEMPT_RT support,
change local_irq_{save/restore}() to local_lock_irq{save/restore}() and
add a local_lock_t to struct memcg_stock_pcp.

Also disable the task and interrupt context optimization for obj_stock as
there will be no performance gain in the case of PREEMPT_RT. In this case,
task obj_stock will be there but remain unused.

Note that preempt_enable() and preempt_disable() in get_obj_stock() and
put_obj_stock() are not replaced by local_lock() and local_unlock() as it
is possible that a task accessing task_obj may get interrupted and then
access irq_obj concurrently. So using local_lock for task_obj access
may cause lockdep splat.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a09a7d2e0b1b..8bed8e2993e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2097,6 +2097,7 @@ struct obj_stock {
 };
 
 struct memcg_stock_pcp {
+	local_lock_t lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 	struct obj_stock task_obj;
@@ -2145,7 +2146,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -2153,7 +2154,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
 
 	return ret;
 }
@@ -2189,7 +2190,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(&stock->irq_obj);
@@ -2198,7 +2199,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
 }
 
 /*
@@ -2210,7 +2211,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -2223,7 +2224,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
 }
 
 /*
@@ -2779,29 +2780,28 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  * which is cheap in non-preempt kernel. The interrupt context object stock
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
+ *
+ * This task and interrupt context optimization is disabled for PREEMPT_RT
+ * as there is no performance gain in this case.
  */
 static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
 {
-	struct memcg_stock_pcp *stock;
-
-	if (likely(in_task())) {
+	if (likely(in_task()) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		*pflags = 0UL;
 		preempt_disable();
-		stock = this_cpu_ptr(&memcg_stock);
-		return &stock->task_obj;
+		return this_cpu_ptr(&memcg_stock.task_obj);
 	}
 
-	local_irq_save(*pflags);
-	stock = this_cpu_ptr(&memcg_stock);
-	return &stock->irq_obj;
+	local_lock_irqsave(&memcg_stock.lock, *pflags);
+	return this_cpu_ptr(&memcg_stock.irq_obj);
 }
 
 static inline void put_obj_stock(unsigned long flags)
 {
-	if (likely(in_task()))
+	if (likely(in_task()) && !IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
 	else
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&memcg_stock.lock, flags);
 }
 
 /*
@@ -7088,9 +7088,12 @@ static int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-	for_each_possible_cpu(cpu)
-		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_stock);
+	for_each_possible_cpu(cpu) {
+		struct memcg_stock_pcp *stock = per_cpu_ptr(&memcg_stock, cpu);
+
+		INIT_WORK(&stock->work, drain_local_stock);
+		local_lock_init(&stock->lock);
+	}
 
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
-- 
2.27.0

