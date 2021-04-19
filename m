Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85613638A2
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 02:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhDSAB0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Apr 2021 20:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231489AbhDSAB0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Apr 2021 20:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618790457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pIzly3xuH0PWUBWjBoEugIWAN5rcOKgjj+f+nKIsmUw=;
        b=hqXB6RPSkNQBVtYHQ2WDTQkkwm6PKA5N6Bf+Q08Q1cazdWSP0ROuaixUKICd15mtNZQuHT
        hWbt3rqG2Ii8xDBhTWr/q90xs8Y1Y/ii64Wxx1unNaEe6Ow5s7/OY1+wRCKrmAS1eW8fh6
        9utXLP3N+cPcx8h2kX2M8wQloKa/bq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-dpTpdBMuMd-VridQre62gg-1; Sun, 18 Apr 2021 20:00:53 -0400
X-MC-Unique: dpTpdBMuMd-VridQre62gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 779BF501F9;
        Mon, 19 Apr 2021 00:00:50 +0000 (UTC)
Received: from llong.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 874B25D741;
        Mon, 19 Apr 2021 00:00:47 +0000 (UTC)
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
Subject: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
Date:   Sun, 18 Apr 2021 20:00:28 -0400
Message-Id: <20210419000032.5432-2-longman@redhat.com>
In-Reply-To: <20210419000032.5432-1-longman@redhat.com>
References: <20210419000032.5432-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
so that further optimization can be done to it in later patches without
exposing unnecessary details to other mm components.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 13 +++++++++++++
 mm/slab.h       | 16 ++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d850a..dc9032f28f2e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	css_put(&memcg->css);
 }
 
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr)
+{
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec = NULL;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
+	rcu_read_unlock();
+}
+
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..ae8b85875426 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -239,6 +239,8 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page);
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr);
 
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
-	mod_memcg_lruvec_state(lruvec, idx, nr);
-	rcu_read_unlock();
-}
-
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
 					      gfp_t flags, size_t size,
-- 
2.18.1

