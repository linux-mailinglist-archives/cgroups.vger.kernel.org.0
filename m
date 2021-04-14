Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610535EA4D
	for <lists+cgroups@lfdr.de>; Wed, 14 Apr 2021 03:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbhDNBV1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 21:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349000AbhDNBVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 21:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618363262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=QdR/wq0xqseV4lLF7yqZuKNGdvCcqiv/u3SIR9Qd35U=;
        b=JGE0oBxIJnbxpnj49hoeg574tMz7VQOtOPH/58GTr2jVXBq9lawN9SqzoExd7OxQjn8ICi
        18Xf5V5wonERY/wQAG36q93g1hGIH2ZyDPTgXuwpcaE/gSefGNuJj/Nal7SCaIKDYFxhbZ
        O87U4u3+F+jq1MdQmLJq1+fFwLnYc9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-rlg0yT7TPpGIsYCIn9XV8Q-1; Tue, 13 Apr 2021 21:20:59 -0400
X-MC-Unique: rlg0yT7TPpGIsYCIn9XV8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D945187A826;
        Wed, 14 Apr 2021 01:20:55 +0000 (UTC)
Received: from llong.com (ovpn-113-4.rdu2.redhat.com [10.10.113.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A300C1A7D9;
        Wed, 14 Apr 2021 01:20:53 +0000 (UTC)
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
Subject: [PATCH v3 4/5] mm/memcg: Separate out object stock data into its own struct
Date:   Tue, 13 Apr 2021 21:20:26 -0400
Message-Id: <20210414012027.5352-5-longman@redhat.com>
In-Reply-To: <20210414012027.5352-1-longman@redhat.com>
References: <20210414012027.5352-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The object stock data stored in struct memcg_stock_pcp are independent
of the other page based data stored there. Separating them out into
their own struct to highlight the independency.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 539c3b632e47..69f728383efe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2214,17 +2214,22 @@ void unlock_page_memcg(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-struct memcg_stock_pcp {
-	struct mem_cgroup *cached; /* this never be root cgroup */
-	unsigned int nr_pages;
-
+struct obj_stock {
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int vmstat_idx;
 	int vmstat_bytes;
+#else
+	int dummy[0];
 #endif
+};
+
+struct memcg_stock_pcp {
+	struct mem_cgroup *cached; /* this never be root cgroup */
+	unsigned int nr_pages;
+	struct obj_stock obj;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -2234,12 +2239,12 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static void drain_obj_stock(struct obj_stock *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
+static inline void drain_obj_stock(struct obj_stock *stock)
 {
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -2249,6 +2254,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 }
 #endif
 
+static inline struct obj_stock *current_obj_stock(void)
+{
+	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+
+	return &stock->obj;
+}
+
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2315,7 +2327,7 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(stock);
+	drain_obj_stock(&stock->obj);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
@@ -3177,13 +3189,13 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
-	struct memcg_stock_pcp *stock;
+	struct obj_stock *stock;
 	unsigned long flags;
 	bool ret = false;
 
 	local_irq_save(flags);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = current_obj_stock();
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
@@ -3194,7 +3206,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	return ret;
 }
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock)
+static void drain_obj_stock(struct obj_stock *stock)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
@@ -3242,8 +3254,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
-	if (stock->cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->cached_objcg);
+	if (stock->obj.cached_objcg) {
+		memcg = obj_cgroup_memcg(stock->obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3253,9 +3265,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 
 static void __refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
-	struct memcg_stock_pcp *stock;
+	struct obj_stock *stock = current_obj_stock();
 
-	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3280,7 +3291,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 static void __mod_obj_stock_state(struct obj_cgroup *objcg,
 				  struct pglist_data *pgdat, int idx, int nr)
 {
-	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
+	struct obj_stock *stock = current_obj_stock();
 
 	if (stock->cached_objcg != objcg) {
 		/* Output the current data as is */
-- 
2.18.1

