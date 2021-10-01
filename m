Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7D41F57F
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355576AbhJATMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 15:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355630AbhJATMC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 15:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633115417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=sFCP5YMQVpSD6yFGcGrxnQTLJHGtWuJlEliBV/TO+yU=;
        b=AKCyPD1VdJHPZK3bsmwPHUhCOd6YQ+oo77eHOuq4wQJf41w4Az6EjkUxbZ6w7KpPVIOY4V
        chHboZUSMGOPB2rZJR0HeMr+O0r0VG2+PRdHAtJ8zz1cqzzcpC3CNcV3yaUsELE/1HdtCu
        4GNmizsYQ1GrrIy+DR6NVKGLx11DZaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-_OTOcvk9PryE4TMuHiT51w-1; Fri, 01 Oct 2021 15:10:16 -0400
X-MC-Unique: _OTOcvk9PryE4TMuHiT51w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C5E107B0EF;
        Fri,  1 Oct 2021 19:10:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8003960BD8;
        Fri,  1 Oct 2021 19:10:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Date:   Fri,  1 Oct 2021 15:09:36 -0400
Message-Id: <20211001190938.14050-2-longman@redhat.com>
In-Reply-To: <20211001190938.14050-1-longman@redhat.com>
References: <20211001190938.14050-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When freeing a page associated with an offlined memcg, refill_stock()
will put it into local stock delaying its demise until another memcg
comes in to take its place in the stock. To avoid that, we now check
for offlined memcg and go directly in this case to the slowpath for
the uncharge via the repurposed cancel_charge() function.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b32896d87a2..4568363062c1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2167,6 +2167,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	return ret;
 }
 
+static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
+
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -2178,9 +2180,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock->nr_pages) {
-		page_counter_uncharge(&old->memory, stock->nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock->nr_pages);
+		cancel_charge(old, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
 
@@ -2219,6 +2219,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
+	/*
+	 * An offlined memcg shouldn't be put into stock.
+	 */
+	if (unlikely(memcg->kmem_state != KMEM_ONLINE)) {
+		cancel_charge(memcg, nr_pages);
+		return;
+	}
+
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2732,7 +2740,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
 static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (mem_cgroup_is_root(memcg))
@@ -2742,7 +2749,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
-#endif
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-- 
2.18.1

