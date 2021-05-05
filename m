Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A665373EE3
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhEEPsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 11:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233666AbhEEPsb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 11:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620229654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=FV79wzI0ybKmDD4PCzgFiPvPREI8TgBBCI9BsjVwJeA=;
        b=QoIaLUYgMlbBRHFjemPqIpmE4snF8i4nTXvZJ6yFwqY38qtmh9h2vDX/Hj5TZ6AOlwwbKA
        vB56VYnBpFWdW9BiLPefFqyBVdKIXWPW/i1AiKvwUpNEHx8E6/oY++zFX5nwvimepfWaLX
        A3wor9MIvlztsY9oKszBTOaQ7kH954M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-93TtN9YIMPyJlUmUItQirw-1; Wed, 05 May 2021 11:47:30 -0400
X-MC-Unique: 93TtN9YIMPyJlUmUItQirw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 039E5835DE3;
        Wed,  5 May 2021 15:47:27 +0000 (UTC)
Received: from llong.com (ovpn-117-4.rdu2.redhat.com [10.10.117.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17C345D6AC;
        Wed,  5 May 2021 15:47:25 +0000 (UTC)
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
Subject: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n> caches
Date:   Wed,  5 May 2021 11:46:13 -0400
Message-Id: <20210505154613.17214-3-longman@redhat.com>
In-Reply-To: <20210505154613.17214-1-longman@redhat.com>
References: <20210505154613.17214-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
the other caches can still allow a mix of accounted and non-accounted
objects.

With this change, all the objcg pointer array objects will come from
KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
both the recursive kfree() problem and non-freeable slab problem are
gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
have mixed accounted and unaccounted objects, this will slightly reduce
the number of objcg pointer arrays that need to be allocated and save
a bit of memory.

The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
will include the newly added caches without change.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
 mm/slab_common.c     | 23 +++++++++++++++--------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..f2d9ebc34f5c 100644
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
@@ -315,28 +322,47 @@ enum kmalloc_cache_type {
 	NR_KMALLOC_TYPES
 };
 
+#ifndef CONFIG_MEMCG_KMEM
+#define KMALLOC_CGROUP	KMALLOC_NORMAL
+#endif
+#ifndef CONFIG_ZONE_DMA
+#define KMALLOC_DMA	KMALLOC_NORMAL
+#endif
+
 #ifndef CONFIG_SLOB
 extern struct kmem_cache *
 kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
+/*
+ * Define gfp bits that should not be set for KMALLOC_NORMAL.
+ */
+#define KMALLOC_NOT_NORMAL_BITS					\
+	(__GFP_RECLAIMABLE |					\
+	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
+	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
+
 static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 {
-#ifdef CONFIG_ZONE_DMA
 	/*
 	 * The most common case is KMALLOC_NORMAL, so test for it
 	 * with a single branch for both flags.
 	 */
-	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
+	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
 		return KMALLOC_NORMAL;
 
 	/*
-	 * At least one of the flags has to be set. If both are, __GFP_DMA
-	 * is more important.
+	 * At least one of the flags has to be set. Their priorities in
+	 * decreasing order are:
+	 *  1) __GFP_DMA
+	 *  2) __GFP_RECLAIMABLE
+	 *  3) __GFP_ACCOUNT
 	 */
-	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
-#else
-	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
-#endif
+	if (IS_ENABLED(CONFIG_ZONE_DMA) && (flags & __GFP_DMA))
+		return KMALLOC_DMA;
+	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || (flags & __GFP_RECLAIMABLE))
+		return KMALLOC_RECLAIM;
+	else
+		return KMALLOC_CGROUP;
 }
 
 /*
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

