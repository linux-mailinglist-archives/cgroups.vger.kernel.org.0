Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8235D372AE4
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhEDNZk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 09:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231186AbhEDNZj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 09:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620134684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lCli4beQJsOgvS4wIOFWCZuHcGJs2tYDZCu5/pA+CYY=;
        b=XKStkX6zN9yJ2FK1iMLSXTCwI+5R8+i93Q2kpROCb1O68n25DmQGFCyZ9SUbl6hV8E0voK
        GEJuwXXvVrgA5D/HEM/aKA+sglg6P5HXK/xeKvquUGQRmW94qIESZfE+m5bkYijey9FuSM
        I1BGOuAj+vqNe+MMGRWxn37/fSlN+nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-lyec8b8XP8O22Kj79W7RkQ-1; Tue, 04 May 2021 09:24:42 -0400
X-MC-Unique: lyec8b8XP8O22Kj79W7RkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56DAD818400;
        Tue,  4 May 2021 13:24:40 +0000 (UTC)
Received: from llong.com (ovpn-115-230.rdu2.redhat.com [10.10.115.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D23BC60939;
        Tue,  4 May 2021 13:24:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n> caches
Date:   Tue,  4 May 2021 09:23:50 -0400
Message-Id: <20210504132350.4693-3-longman@redhat.com>
In-Reply-To: <20210504132350.4693-1-longman@redhat.com>
References: <20210504132350.4693-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are currently two problems in the way the objcg pointer array
(memcg_data) in the page structure is being allocated and freed.

On its allocation, it is possible that the allocated objcg pointer
array comes from the same slab that requires memory accounting. If this
happens, the slab will never become empty again as there is at least
one object left (the obj_cgroup array) in the slab.

When it is freed, the objcg pointer array object may be the last one
in its slab and hence causes kfree() to be called again. With the
right workload, the slab cache may be set up in a way that allows the
recursive kfree() calling loop to nest deep enough to cause a kernel
stack overflow and panic the system.

One way to solve this problem is to split the kmalloc-<n> caches
(KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
(KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
the other caches can allow a mix of accounted and non-accounted objects.

With this change, all the objcg pointer array objects will come from
KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
both the recursive kfree() problem and non-freeable slab problem
are gone.

The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
will include the newly added caches without change.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/slab.h | 15 +++++++++++++++
 mm/slab_common.c     | 23 +++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..fca03c22ea7c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
 /*
  * Whenever changing this, take care of that kmalloc_type() and
  * create_kmalloc_caches() still work as intended.
+ *
+ * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
+ * is for accounted objects only. All the other kmem caches can have both
+ * accounted and non-accounted objects.
  */
 enum kmalloc_cache_type {
 	KMALLOC_NORMAL = 0,
+#ifdef CONFIG_MEMCG_KMEM
+	KMALLOC_CGROUP,
+#endif
 	KMALLOC_RECLAIM,
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
@@ -321,6 +328,14 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
 static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 {
+#ifdef CONFIG_MEMCG_KMEM
+	/*
+	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
+	 * accounting enabled.
+	 */
+	if ((flags & (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)) == __GFP_ACCOUNT)
+		return KMALLOC_CGROUP;
+#endif
 #ifdef CONFIG_ZONE_DMA
 	/*
 	 * The most common case is KMALLOC_NORMAL, so test for it
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f8833d3e5d47..d750e3ba7af5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -727,21 +727,25 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 }
 
 #ifdef CONFIG_ZONE_DMA
-#define INIT_KMALLOC_INFO(__size, __short_size)			\
-{								\
-	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
-	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
-	.name[KMALLOC_DMA]     = "dma-kmalloc-" #__short_size,	\
-	.size = __size,						\
-}
+#define KMALLOC_DMA_NAME(sz)	.name[KMALLOC_DMA] = "dma-kmalloc-" #sz,
+#else
+#define KMALLOC_DMA_NAME(sz)
+#endif
+
+#ifdef CONFIG_MEMCG_KMEM
+#define KMALLOC_CGROUP_NAME(sz)	.name[KMALLOC_CGROUP] = "kmalloc-cg-" #sz,
 #else
+#define KMALLOC_CGROUP_NAME(sz)
+#endif
+
 #define INIT_KMALLOC_INFO(__size, __short_size)			\
 {								\
 	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
 	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
+	KMALLOC_CGROUP_NAME(__short_size)			\
+	KMALLOC_DMA_NAME(__short_size)				\
 	.size = __size,						\
 }
-#endif
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
@@ -847,6 +851,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	int i;
 	enum kmalloc_cache_type type;
 
+	/*
+	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
+	 */
 	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
 			if (!kmalloc_caches[type][i])
-- 
2.18.1

