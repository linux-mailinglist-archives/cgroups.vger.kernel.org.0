Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB7372D78
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEDQCr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 12:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhEDQCq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 12:02:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72B2FAFDC;
        Tue,  4 May 2021 16:01:50 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210504132350.4693-1-longman@redhat.com>
 <20210504132350.4693-3-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3c952b24-94e4-3c54-b668-cac778ff5a77@suse.cz>
Date:   Tue, 4 May 2021 18:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504132350.4693-3-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/4/21 3:23 PM, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
> 
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
> 
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
> 
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can allow a mix of accounted and non-accounted objects.
> 
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem
> are gone.
> 
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.

Great, thanks I hope there would be also benefits to objcg arrays not
created for all the normal caches anymore (possibly poorly used due to
mix of accounted and non-accounted objects in the same cache) and perhaps
it's possible for you to quantify the reduction of those?

> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>

...

> @@ -321,6 +328,14 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  
>  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  {
> +#ifdef CONFIG_MEMCG_KMEM
> +	/*
> +	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
> +	 * accounting enabled.
> +	 */
> +	if ((flags & (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)) == __GFP_ACCOUNT)
> +		return KMALLOC_CGROUP;
> +#endif

This function was designed so that KMALLOC_NORMAL would be the first tested and
returned possibility, as it's expected to be the most common. What about the
following on top?

----8<----
diff --git a/include/linux/slab.h b/include/linux/slab.h
index fca03c22ea7c..418c5df0305b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -328,30 +328,40 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
 static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 {
-#ifdef CONFIG_MEMCG_KMEM
 	/*
-	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
-	 * accounting enabled.
+	 * The most common case is KMALLOC_NORMAL, so test for it
+	 * with a single branch for all flags that might affect it
 	 */
-	if ((flags & (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)) == __GFP_ACCOUNT)
-		return KMALLOC_CGROUP;
+	if (likely((flags & (__GFP_RECLAIMABLE
+#ifdef CONFIG_MEMCG_KMEM
+			     | __GFP_ACCOUNT
 #endif
 #ifdef CONFIG_ZONE_DMA
-	/*
-	 * The most common case is KMALLOC_NORMAL, so test for it
-	 * with a single branch for both flags.
-	 */
-	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
+			     | __GFP_DMA
+#endif
+			    )) == 0))
 		return KMALLOC_NORMAL;
 
+#ifdef CONFIG_MEMCG_KMEM
 	/*
-	 * At least one of the flags has to be set. If both are, __GFP_DMA
-	 * is more important.
+	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
+	 * accounting enabled.
 	 */
-	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
-#else
-	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
+	if ((flags & (__GFP_ACCOUNT | __GFP_RECLAIMABLE
+#ifdef CONFIG_ZONE_DMA
+		      | __GFP_DMA
+#endif
+		     )) == __GFP_ACCOUNT)
+		return KMALLOC_CGROUP;
 #endif
+
+#ifdef CONFIG_ZONE_DMA
+	if (flags & __GFP_DMA)
+		return KMALLOC_DMA;
+#endif
+
+	/* if we got here, it has to be __GFP_RECLAIMABLE */
+	return KMALLOC_RECLAIM;
 }
 
 /*
