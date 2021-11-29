Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6B461BA1
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 17:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbhK2QRd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 11:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhK2QPc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 11:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638202334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iTSHlGaC4RwA82Y9GrcD/zJlYkWwy778pvuaQM45jus=;
        b=JllfkNeQ3GhfLCw/4Lo3Kc3MQAedErEK3e7dGxogUT4kmyP5NiQ3X69vWroyN+amP5dzRR
        8anKzamUI+BcUVDcP77LyW4WBS9IndcuRO8UtXQfFM1FqNvIIzXDKVww3kYmwITlYQX4u8
        qSVPHQTH91JBnuNhegluwhF9KEl6U88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-KOZkUan0Mj6OLbQmUCVLiA-1; Mon, 29 Nov 2021 11:12:11 -0500
X-MC-Unique: KOZkUan0Mj6OLbQmUCVLiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307DA1898292;
        Mon, 29 Nov 2021 16:12:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235DD45D61;
        Mon, 29 Nov 2021 16:12:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/memcg: Relocate mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()
Date:   Mon, 29 Nov 2021 11:11:40 -0500
Message-Id: <20211129161140.306488-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

All the calls to mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()
are done by functions defined within the same "#ifdef CONFIG_MEMCG_KMEM"
compilation block. When CONFIG_MEMCG_KMEM isn't defined, the following
compilation warnings will be issued [1] and [2].

  mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
  mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'

Fix these warning by moving those functions to under the same
CONFIG_MEMCG_KMEM compilation block. There is no functional change.

[1] https://lore.kernel.org/lkml/202111272014.WOYNLUV6-lkp@intel.com/
[2] https://lore.kernel.org/lkml/202111280551.LXsWYt1T-lkp@intel.com/

Fixes: 559271146efc ("mm/memcg: optimize user context object stock access")
Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 106 ++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6863a834ed42..2ed5f2a0879d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -776,24 +776,6 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_unlock();
 }
 
-/*
- * mod_objcg_mlstate() may be called with irq enabled, so
- * mod_memcg_lruvec_state() should be used.
- */
-static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
-				     struct pglist_data *pgdat,
-				     enum node_stat_item idx, int nr)
-{
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
-	rcu_read_unlock();
-}
-
 /**
  * __count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
@@ -2137,41 +2119,6 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 }
 #endif
 
-/*
- * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
- * sequence used in this case to access content from object stock is slow.
- * To optimize for user context access, there are now two object stocks for
- * task context and interrupt context access respectively.
- *
- * The task context object stock can be accessed by disabling preemption only
- * which is cheap in non-preempt kernel. The interrupt context object stock
- * can only be accessed after disabling interrupt. User context code can
- * access interrupt object stock, but not vice versa.
- */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
-{
-	struct memcg_stock_pcp *stock;
-
-	if (likely(in_task())) {
-		*pflags = 0UL;
-		preempt_disable();
-		stock = this_cpu_ptr(&memcg_stock);
-		return &stock->task_obj;
-	}
-
-	local_irq_save(*pflags);
-	stock = this_cpu_ptr(&memcg_stock);
-	return &stock->irq_obj;
-}
-
-static inline void put_obj_stock(unsigned long flags)
-{
-	if (likely(in_task()))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-}
-
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2816,6 +2763,59 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
 
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
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+{
+	struct memcg_stock_pcp *stock;
+
+	if (likely(in_task())) {
+		*pflags = 0UL;
+		preempt_disable();
+		stock = this_cpu_ptr(&memcg_stock);
+		return &stock->task_obj;
+	}
+
+	local_irq_save(*pflags);
+	stock = this_cpu_ptr(&memcg_stock);
+	return &stock->irq_obj;
+}
+
+static inline void put_obj_stock(unsigned long flags)
+{
+	if (likely(in_task()))
+		preempt_enable();
+	else
+		local_irq_restore(flags);
+}
+
+/*
+ * mod_objcg_mlstate() may be called with irq enabled, so
+ * mod_memcg_lruvec_state() should be used.
+ */
+static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
+				     struct pglist_data *pgdat,
+				     enum node_stat_item idx, int nr)
+{
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
+	rcu_read_unlock();
+}
+
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
 {
-- 
2.27.0

