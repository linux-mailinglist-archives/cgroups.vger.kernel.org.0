Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCDF3638AD
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhDSABh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Apr 2021 20:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236772AbhDSABg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Apr 2021 20:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618790467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=udyNofiZcHz7UO2SxlIdvfmO6jGmZBxtXk0/dOlByNE=;
        b=M0NCrbB6CMD9xHp80cLUPpk4u8BvvgE9hCFbebU5G5hJ6vxe4FFvqBi1hc1sUgjFsjfLaC
        /mS91OmOYfAkAcHIPPrvSTXIhbGb8unJ84GXl7sVODtRgpI3RK3VmKSGTS4NBU2kbwo2q/
        ugywsvng37/Zds+SJulB79kp6ZkcyOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-fCyT3D2AOVOHipPLvx_x-g-1; Sun, 18 Apr 2021 20:01:03 -0400
X-MC-Unique: fCyT3D2AOVOHipPLvx_x-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F961898296;
        Mon, 19 Apr 2021 00:01:00 +0000 (UTC)
Received: from llong.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECA865D741;
        Mon, 19 Apr 2021 00:00:57 +0000 (UTC)
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
Subject: [PATCH v4 5/5] mm/memcg: Improve refill_obj_stock() performance
Date:   Sun, 18 Apr 2021 20:00:32 -0400
Message-Id: <20210419000032.5432-6-longman@redhat.com>
In-Reply-To: <20210419000032.5432-1-longman@redhat.com>
References: <20210419000032.5432-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
to uncharge 1 page. To avoid the additional uncharge in this case,
a new overfill flag is added to refill_obj_stock() which will be set
when called from obj_cgroup_charge().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a6dd18f6d8a8..d13961352eef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3357,23 +3357,34 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 	return false;
 }
 
-static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
+			     bool overfill)
 {
 	unsigned long flags;
 	struct obj_stock *stock = get_obj_stock(&flags);
+	unsigned int nr_pages = 0;
 
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		if (stock->cached_objcg)
+			drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
 	}
 	stock->nr_bytes += nr_bytes;
 
-	if (stock->nr_bytes > PAGE_SIZE)
-		drain_obj_stock(stock);
+	if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
+		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
+		stock->nr_bytes &= (PAGE_SIZE - 1);
+	}
 
 	put_obj_stock(flags);
+
+	if (nr_pages) {
+		rcu_read_lock();
+		__memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
+		rcu_read_unlock();
+	}
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -3410,7 +3421,7 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 
 	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
 	if (!ret && nr_bytes)
-		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
+		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, true);
 
 	css_put(&memcg->css);
 	return ret;
@@ -3418,7 +3429,7 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
 
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_obj_stock(objcg, size);
+	refill_obj_stock(objcg, size, false);
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
-- 
2.18.1

