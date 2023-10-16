Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968437CB67D
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 00:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjJPWTi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjJPWTg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 18:19:36 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [IPv6:2001:41d0:203:375::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00DFA
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 15:19:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697494772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ij7CcCAZNuMmzhQYGZQhCh1ZAw1S65+h3j6CiMYYH1k=;
        b=qe61nNJWgfKNPHV4MWaSLxAEqEn1iXauirsmpPoVE9GASZahjTRawLqTlqdTbyG4eiukfY
        Lq6KFaL1MtAZvkYpGyYNft0nl3lKbvNndKBxJreTEgFopeQTbNfb5AL+9pAMbJkrsLR2M1
        Rt53tdYfBOdP5StnaeY5MmTpUf7UHGw=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Shakeel@vger.kernel.org,
        Butt@vger.kernel.org, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 4/5] mm: kmem: scoped objcg protection
Date:   Mon, 16 Oct 2023 15:18:59 -0700
Message-ID: <20231016221900.4031141-5-roman.gushchin@linux.dev>
In-Reply-To: <20231016221900.4031141-1-roman.gushchin@linux.dev>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  9 ++++++++
 include/linux/sched/mm.h   |  4 ++++
 mm/memcontrol.c            | 47 ++++++++++++++++++++++++++++++++++++--
 mm/slab.h                  | 15 ++++++------
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 277690af383d..a89df289144d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1769,6 +1769,15 @@ bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+/*
+ * The returned objcg pointer is safe to use without additional
+ * protection within a scope. The scope is defined either by
+ * the current task (similar to the "current" global variable)
+ * or by set_active_memcg() pair.
+ * Please, use obj_cgroup_get() to get a reference if the pointer
+ * needs to be used outside of the local scope.
+ */
+struct obj_cgroup *current_obj_cgroup(void);
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio);
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 8d89c8c4fac1..9a19f1b42f64 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -403,6 +403,10 @@ DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
  * __GFP_ACCOUNT allocations till the end of the scope will be charged to the
  * given memcg.
  *
+ * Please, make sure that caller has a reference to the passed memcg structure,
+ * so its lifetime is guaranteed to exceed the scope between two
+ * set_active_memcg() calls.
+ *
  * NOTE: This function can nest. Users must save the return value and
  * reset the previous value after their own charging scope is over.
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d90cc19e4113..852fe6918f82 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3079,6 +3079,49 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
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
+		if (unlikely((unsigned long)objcg & CURRENT_OBJCG_UPDATE_FLAG))
+			objcg = current_objcg_update();
+		/*
+		 * Objcg reference is kept by the task, so it's safe
+		 * to use the objcg by the current task.
+		 */
+		return objcg;
+	}
+
+	memcg = this_cpu_read(int_active_memcg);
+	if (unlikely(memcg))
+		goto from_memcg;
+
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
@@ -3173,15 +3216,15 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
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
index 799a315695c6..3d07fb428393 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -484,7 +484,12 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	if (!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT))
 		return true;
 
-	objcg = get_obj_cgroup_from_current();
+	/*
+	 * The obtained objcg pointer is safe to use within the current scope,
+	 * defined by current task or set_active_memcg() pair.
+	 * obj_cgroup_get() is used to get a permanent reference.
+	 */
+	objcg = current_obj_cgroup();
 	if (!objcg)
 		return true;
 
@@ -497,17 +502,14 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
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
@@ -542,7 +544,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			obj_cgroup_uncharge(objcg, obj_full_size(s));
 		}
 	}
-	obj_cgroup_put(objcg);
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-- 
2.42.0

