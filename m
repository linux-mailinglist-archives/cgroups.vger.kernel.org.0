Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63877D0510
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjJSWyR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 18:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbjJSWyR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 18:54:17 -0400
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755C115
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 15:54:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697756054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1KwfJjJzwSt9NrrtAyc2/Wpa50oBD8kLBiaGTTPdeA=;
        b=tDTOjE7DTyy4cSZ1350GJsSA3an2i9cqKy1Q4g2SjTywV4u7mYWzqZBqKvIOjqWS/umloV
        Nq23nSYhq58l4XAmk6FYdMmmNVtkWSCRU7hLVRIZugprr05e2F0LexTYgAcqIDzRXPLir3
        PMy2G1M3GhmwtZ5YIE+BY24OtDtLYO8=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v5 1/6] mm: kmem: optimize get_obj_cgroup_from_current()
Date:   Thu, 19 Oct 2023 15:53:41 -0700
Message-ID: <20231019225346.1822282-2-roman.gushchin@linux.dev>
In-Reply-To: <20231019225346.1822282-1-roman.gushchin@linux.dev>
References: <20231019225346.1822282-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Manually inline memcg_kmem_bypass() and active_memcg() to speed up
get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
and active_memcg() readings.

Also add a likely() macro to __get_obj_cgroup_from_memcg():
obj_cgroup_tryget() should succeed at almost all times except a very
unlikely race with the memcg deletion path.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9741d62d0424..16ac2a5838fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1068,19 +1068,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
-static __always_inline bool memcg_kmem_bypass(void)
-{
-	/* Allow remote memcg charging from any context. */
-	if (unlikely(active_memcg()))
-		return false;
-
-	/* Memcg to charge can't be determined. */
-	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
-		return true;
-
-	return false;
-}
-
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -3007,7 +2994,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		objcg = rcu_dereference(memcg->objcg);
-		if (objcg && obj_cgroup_tryget(objcg))
+		if (likely(objcg && obj_cgroup_tryget(objcg)))
 			break;
 		objcg = NULL;
 	}
@@ -3016,16 +3003,23 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
-	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
-	if (memcg_kmem_bypass())
-		return NULL;
+	if (in_task()) {
+		memcg = current->active_memcg;
+
+		/* Memcg to charge can't be determined. */
+		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
+			return NULL;
+	} else {
+		memcg = this_cpu_read(int_active_memcg);
+		if (likely(!memcg))
+			return NULL;
+	}
 
 	rcu_read_lock();
-	if (unlikely(active_memcg()))
-		memcg = active_memcg();
-	else
+	if (!memcg)
 		memcg = mem_cgroup_from_task(current);
 	objcg = __get_obj_cgroup_from_memcg(memcg);
 	rcu_read_unlock();
-- 
2.42.0

