Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF236603A
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 21:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhDTTbK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 15:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233693AbhDTTbI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 15:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618947036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Bz04whKPCx0NxGxuKpnqxiSwkBGHYPOpV919ja4uyiE=;
        b=MzWhAQBwLVp40TKF+0oRcEjxBCW46DksRyWRNWetuhuE/HaxbDKKLpK3FwfH2ICsv278FP
        GYIpY8jiaAypfpnme9ueaiPshlb8xoKk/F8eUgI/cBaDfn4zByHRxVBlOw9019sR/6N2Ei
        5N0+wISWgVxVGIpKdTH7Wr4TrHARmhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-HwtuVzgHOwiJh6n-pmiSbA-1; Tue, 20 Apr 2021 15:29:49 -0400
X-MC-Unique: HwtuVzgHOwiJh6n-pmiSbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548371006C86;
        Tue, 20 Apr 2021 19:29:47 +0000 (UTC)
Received: from llong.com (ovpn-114-123.rdu2.redhat.com [10.10.114.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2170610F4;
        Tue, 20 Apr 2021 19:29:38 +0000 (UTC)
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
Subject: [PATCH-next v5 1/4] mm/memcg: Move mod_objcg_state() to memcontrol.c
Date:   Tue, 20 Apr 2021 15:29:04 -0400
Message-Id: <20210420192907.30880-2-longman@redhat.com>
In-Reply-To: <20210420192907.30880-1-longman@redhat.com>
References: <20210420192907.30880-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
so that further optimization can be done to it in later patches without
exposing unnecessary details to other mm components.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 13 +++++++++++++
 mm/slab.h       | 16 ++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..7cd7187a017c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -782,6 +782,19 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_unlock();
 }
 
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr)
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
 /**
  * __count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
diff --git a/mm/slab.h b/mm/slab.h
index a7268072f017..f1f26f22a94a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -242,6 +242,8 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page);
+void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
+		     enum node_stat_item idx, int nr);
 
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
@@ -286,20 +288,6 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
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

