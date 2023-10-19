Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07C7D0521
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbjJSWyd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Oct 2023 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJSWyb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Oct 2023 18:54:31 -0400
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ce])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0E136
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 15:54:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697756066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dS7frJRdSMuPJ7DdWWAjQ+cQ8KaRwRE0njPFfiYUqhI=;
        b=swiyjDzbwvO1ryyH0LOxBsG3sRDrHo8MwhzTCH/GhQa+yLHgJt9YruoXPCzep7ToRdRcIe
        f2eQNq6gGnHGE7yLa7z373yvV6fk04/R4k49Aiuuzgl3U3AyV/OKYwgN/BLnwOmIAr+Hpk
        tNxwryf0vISlCXMm0JNVfO9Q0ZShvgY=
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
Subject: [PATCH v5 6/6] mm: kmem: reimplement get_obj_cgroup_from_current()
Date:   Thu, 19 Oct 2023 15:53:46 -0700
Message-ID: <20231019225346.1822282-7-roman.gushchin@linux.dev>
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

Reimplement get_obj_cgroup_from_current() using current_obj_cgroup().
get_obj_cgroup_from_current() and current_obj_cgroup() share 80% of
the code, so the new implementation is almost trivial.

get_obj_cgroup_from_current() is a convenient function used by the
bpf subsystem, so there is no reason to get rid of it completely.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 11 ++++++++++-
 mm/memcontrol.c            | 32 --------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a89df289144d..ef26551a633f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1778,9 +1778,18 @@ void __memcg_kmem_uncharge_page(struct page *page, int order);
  * needs to be used outside of the local scope.
  */
 struct obj_cgroup *current_obj_cgroup(void);
-struct obj_cgroup *get_obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio);
 
+static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg = current_obj_cgroup();
+
+	if (objcg)
+		obj_cgroup_get(objcg);
+
+	return objcg;
+}
+
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e3d4b7fabb7d..e13c10912c16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3056,38 +3056,6 @@ static struct obj_cgroup *current_objcg_update(void)
 	return objcg;
 }
 
-__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
-{
-	struct mem_cgroup *memcg;
-	struct obj_cgroup *objcg;
-
-	if (in_task()) {
-		memcg = current->active_memcg;
-		if (unlikely(memcg))
-			goto from_memcg;
-
-		objcg = READ_ONCE(current->objcg);
-		if (unlikely((unsigned long)objcg & CURRENT_OBJCG_UPDATE_FLAG))
-			objcg = current_objcg_update();
-
-		if (objcg) {
-			obj_cgroup_get(objcg);
-			return objcg;
-		}
-	} else {
-		memcg = this_cpu_read(int_active_memcg);
-		if (unlikely(memcg))
-			goto from_memcg;
-	}
-	return NULL;
-
-from_memcg:
-	rcu_read_lock();
-	objcg = __get_obj_cgroup_from_memcg(memcg);
-	rcu_read_unlock();
-	return objcg;
-}
-
 __always_inline struct obj_cgroup *current_obj_cgroup(void)
 {
 	struct mem_cgroup *memcg;
-- 
2.42.0

