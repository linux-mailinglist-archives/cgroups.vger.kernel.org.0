Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE20375619
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhEFPBi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 11:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234999AbhEFPBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 May 2021 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620313236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lnZOGW2WXcr3CD7ZWYCiOFjkYlS6OpFlgmFtj2K0Q2g=;
        b=B/V9pqOWT8AKrBwHTvtya1quuvLdkWnwOxaXiZhtlYOcQqEbEL1OyZqkFHDbLRikXhtjuR
        Do/ybSNLYWui+tvuxq2x93ABPpnEyj+UjUX3Il9mPbE6B0AXZXxpIKD7GlPzhX3lyG7xWn
        8PVIIHdHM7q+TGEk/KySsRlaihQrer4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-N4ksTzjNOdyrNnbY4oBlPA-1; Thu, 06 May 2021 11:00:35 -0400
X-MC-Unique: N4ksTzjNOdyrNnbY4oBlPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA221009E20;
        Thu,  6 May 2021 15:00:32 +0000 (UTC)
Received: from llong.com (ovpn-114-62.rdu2.redhat.com [10.10.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03E6819100;
        Thu,  6 May 2021 15:00:29 +0000 (UTC)
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
Subject: [PATCH v6 3/4] mm/memcg: Improve refill_obj_stock() performance
Date:   Thu,  6 May 2021 11:00:06 -0400
Message-Id: <20210506150007.16288-4-longman@redhat.com>
In-Reply-To: <20210506150007.16288-1-longman@redhat.com>
References: <20210506150007.16288-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are two issues with the current refill_obj_stock() code. First of
all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
be used again which leads to another call to drain_obj_stock() and
obj_cgroup_get() as well as atomically retrieve the available byte from
obj_cgroup. That is costly. Instead, we should just uncharge the excess
pages, reduce the stock bytes and be done with it. The drain_obj_stock()
function should only be called when obj_cgroup changes.

Secondly, when charging an object of size not less than a page in
obj_cgroup_charge(), it is possible that the remaining bytes to be
refilled to the stock will overflow a page and cause refill_obj_stock()
to uncharge 1 page. To avoid the additional uncharge in this case, a new
allow_uncharge flag is added to refill_obj_stock() which will be set to
false when called from obj_cgroup_charge() so that an uncharge_pages()
call won't be issued right after a charge_pages() call unless the objcg
changes.

A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
96-thread x86-64 system with 96 testing threads were run.  Before this
patch, the total number of kilo kmalloc+kfree operations done for a 4k
large object by all the testing threads per second were 4,304 kops/s
(cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
represents a performance improvement of 1.10X (cgroup v1) and 49.3X
(cgroup v2).

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fbedfc55a248..513f3d56e89a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3281,10 +3281,12 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 	return false;
 }
 
-static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
+			     bool allow_uncharge)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
+	unsigned int nr_pages = 0;
 
 	local_irq_save(flags);
 
@@ -3293,14 +3295,21 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
-		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
+		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
 	stock->nr_bytes += nr_bytes;
 
-	if (stock->nr_bytes > PAGE_SIZE)
-		drain_obj_stock(stock);
+	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
+		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
+		stock->nr_bytes &= (PAGE_SIZE - 1);
+	}
 
 	local_irq_restore(flags);
+
+	if (nr_pages)
+		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -3312,14 +3321,27 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 		return 0;
 
 	/*
-	 * In theory, memcg->nr_charged_bytes can have enough
+	 * In theory, objcg->nr_charged_bytes can have enough
 	 * pre-charged bytes to satisfy the allocation. However,
-	 * flushing memcg->nr_charged_bytes requires two atomic
-	 * operations, and memcg->nr_charged_bytes can't be big,
-	 * so it's better to ignore it and try grab some new pages.
-	 * memcg->nr_charged_bytes will be flushed in
-	 * refill_obj_stock(), called from this function or
-	 * independently later.
+	 * flushing objcg->nr_charged_bytes requires two atomic
+	 * operations, and objcg->nr_charged_bytes can't be big.
+	 * The shared objcg->nr_charged_bytes can also become a
+	 * performance bottleneck if all tasks of the same memcg are
+	 * trying to update it. So it's better to ignore it and try
+	 * grab some new pages. The stock's nr_bytes will be flushed to
+	 * objcg->nr_charged_bytes later on when objcg changes.
+	 *
+	 * The stock's nr_bytes may contain enough pre-charged bytes
+	 * to allow one less page from being charged, but we can't rely
+	 * on the pre-charged bytes not being changed outside of
+	 * consume_obj_stock() or refill_obj_stock(). So ignore those
+	 * pre-charged bytes as well when charging pages. To avoid a
+	 * page uncharge right after a page charge, we set the
+	 * allow_uncharge flag to false when calling refill_obj_stock()
+	 * to temporarily allow the pre-charged bytes to exceed the page
+	 * size limit. The maximum reachable value of the pre-charged
+	 * bytes is (sizeof(object) + PAGE_SIZE - 2) if there is no data
+	 * race.
 	 */
 	nr_pages = size >> PAGE_SHIFT;
 	nr_bytes = size & (PAGE_SIZE - 1);
@@ -3329,14 +3351,14 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 
 	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
-		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
+		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, false);
 
 	return ret;
 }
 
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size);
+	refill_obj_stock(objcg, size, true);
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
-- 
2.18.1

