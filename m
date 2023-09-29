Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A86B7B395B
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjI2SBr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjI2SBk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 14:01:40 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFB1BF
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 11:01:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696010485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/HghY6af2rzSMfJ7xP4DH1sDr9DxTKbSixxOwxk1Wc=;
        b=reulyu8BPJ63WGorYfZOnZ+y3TQQyJvBgiYOWl05pCLFalHnzIPEPs/r+T2JEd8zTAmV+5
        xq4tlzloY5TTOTNFcVw0n7ImC8bEtRN2wTux41sKvpuWQw+ZJwVV9YgZkFzFehUsdj59fc
        /cKiihLvc8ycwOyaCRkSf2htJ6JeWMI=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 4/5] mm: kmem: scoped objcg protection
Date:   Fri, 29 Sep 2023 11:00:54 -0700
Message-ID: <20230929180056.1122002-5-roman.gushchin@linux.dev>
In-Reply-To: <20230929180056.1122002-1-roman.gushchin@linux.dev>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Switch to a scope-based protection of the objcg pointer on slab/kmem
allocation paths. Instead of using the get_() semantics in the
pre-allocation hook and put the reference afterwards, let's rely
on the fact that objcg is pinned by the scope.

It's possible because:
1) if the objcg is received from the current task struct, the task is
   keeping a reference to the objcg.
2) if the objcg is received from an active memcg (remote charging),
   the memcg is pinned by the scope and has a reference to the
   corresponding objcg.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  6 +++++
 mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++--
 mm/slab.h                  | 10 +++------
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e59dea9d8666..5a52327ab09a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1779,6 +1779,12 @@ bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+/*
+ * The returned objcg pointer is safe to use without additional
+ * protection within a scope, refer to the implementation for the
+ * additional details.
+ */
+struct obj_cgroup *current_obj_cgroup(void);
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e9890f6e4da7..78ab36b5899f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3074,6 +3074,48 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	return objcg;
 }
 
+__always_inline struct obj_cgroup *current_obj_cgroup(void)
+{
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
+
+	if (in_task()) {
+		memcg = current->active_memcg;
+		if (unlikely(memcg))
+			goto from_memcg;
+
+		objcg = READ_ONCE(current->objcg);
+		if (unlikely(current_objcg_needs_update(objcg)))
+			objcg = current_objcg_update(objcg);
+		/*
+		 * Objcg reference is kept by the task, so it's safe
+		 * to use the objcg by the current task.
+		 */
+		return objcg;
+	} else {
+		memcg = this_cpu_read(int_active_memcg);
+		if (unlikely(memcg))
+			goto from_memcg;
+	}
+	return NULL;
+
+from_memcg:
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+		/*
+		 * Memcg pointer is protected by scope (see set_active_memcg())
+		 * and is pinning the corresponding objcg, so objcg can't go
+		 * away and can be used within the scope without any additional
+		 * protection.
+		 */
+		objcg = rcu_dereference_check(memcg->objcg, 1);
+		if (likely(objcg))
+			break;
+		objcg = NULL;
+	}
+
+	return objcg;
+}
+
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	struct obj_cgroup *objcg;
@@ -3168,15 +3210,15 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	struct obj_cgroup *objcg;
 	int ret = 0;
 
-	objcg = get_obj_cgroup_from_current();
+	objcg = current_obj_cgroup();
 	if (objcg) {
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
+			obj_cgroup_get(objcg);
 			page->memcg_data = (unsigned long)objcg |
 				MEMCG_DATA_KMEM;
 			return 0;
 		}
-		obj_cgroup_put(objcg);
 	}
 	return ret;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 799a315695c6..8cd3294fedf5 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -484,7 +484,7 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
 		return true;
 
-	objcg = get_obj_cgroup_from_current();
+	objcg = current_obj_cgroup();
 	if (!objcg)
 		return true;
 
@@ -497,17 +497,14 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 		css_put(&memcg->css);
 
 		if (ret)
-			goto out;
+			return false;
 	}
 
 	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
-		goto out;
+		return false;
 
 	*objcgp = objcg;
 	return true;
-out:
-	obj_cgroup_put(objcg);
-	return false;
 }
 
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
@@ -542,7 +539,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			obj_cgroup_uncharge(objcg, obj_full_size(s));
 		}
 	}
-	obj_cgroup_put(objcg);
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-- 
2.42.0

