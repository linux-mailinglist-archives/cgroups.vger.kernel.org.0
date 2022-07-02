Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E026563E09
	for <lists+cgroups@lfdr.de>; Sat,  2 Jul 2022 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiGBDfg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 23:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 23:35:35 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA521264;
        Fri,  1 Jul 2022 20:35:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656732927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5sJ9uAjGXNyMkD0Jws/tWJBNd8knl6wtG6bq/f3YA7w=;
        b=sN8WCsmhKE0KUzCtuUtNjLT4uIP1cnh0sTirAyamJQmyquM0V+MwIleKB6UgonvFvXJ5vb
        RDMTVlTI0VPdjJnoYpUPGnl0prK2MNe9fEzyVUAY8oSVt0YAAKW9L5g0shONzuv5aqN7Ir
        726K4nIwztR3n+CltroepxVNRkuXoYw=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
Date:   Fri,  1 Jul 2022 20:35:21 -0700
Message-Id: <20220702033521.64630-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yafang Shao reported an issue related to the accounting of bpf
memory: if a bpf map is charged indirectly for memory consumed
from an interrupt context and allocations are enforced, MEMCG_MAX
events are not raised.

It's not/less of an issue in a generic case because consequent
allocations from a process context will trigger the reclaim and
MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
memory cgroup, so it might never happen. So the cgroup can
significantly exceed the memory.max limit without even triggering
MEMCG_MAX events.

Fix this by making sure that we never enforce allocations without
raising a MEMCG_MAX event.

Reported-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: bpf@vger.kernel.org
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 655c09393ad5..eb383695659a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2577,6 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool passed_oom = false;
 	bool may_swap = true;
 	bool drained = false;
+	bool raised_max_event = false;
 	unsigned long pflags;
 
 retry:
@@ -2616,6 +2617,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto nomem;
 
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	raised_max_event = true;
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
@@ -2682,6 +2684,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
 		return -ENOMEM;
 force:
+	/*
+	 * If the allocation has to be enforced, don't forget to raise
+	 * a MEMCG_MAX event.
+	 */
+	if (!raised_max_event)
+		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+
 	/*
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit
-- 
2.36.1

