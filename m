Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354507BEF81
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbjJJAKK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379158AbjJJAKH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:10:07 -0400
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42819AF
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 17:10:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696896604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfnE2/YTK2KTtvwJ+nJA5/HU7PGBa8pUnySPUFyhBIQ=;
        b=qLsl13mTbXz/4i7wT4UNbU/Yuhrs6p0pMqUkgW5cQutUavEUX53hOM0UdEJeTs+zo2p5sJ
        GQojwhgKw9URgh6Cnj8JskC/4by4Jp7qKD398cvjsd/sOFJjD43axUombC6Fgh4TUL5CuQ
        PNw7ZFBmb9QNHRWuBYOV43b0EnZyUDM=
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
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 3/5] mm: kmem: make memcg keep a reference to the original objcg
Date:   Mon,  9 Oct 2023 17:09:27 -0700
Message-ID: <20231010000929.450702-4-roman.gushchin@linux.dev>
In-Reply-To: <20231010000929.450702-1-roman.gushchin@linux.dev>
References: <20231010000929.450702-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Keep a reference to the original objcg object for the entire life
of a memcg structure.

This allows to simplify the synchronization on the kernel memory
allocation paths: pinning a (live) memcg will also pin the
corresponding objcg.

The memory overhead of this change is minimal because object cgroups
usually outlive their corresponding memory cgroups even without this
change, so it's only an additional pointer per memcg.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 8 +++++++-
 mm/memcontrol.c            | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab94ad4597d0..277690af383d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -299,7 +299,13 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	struct obj_cgroup __rcu *objcg;
+	/*
+	 * memcg->objcg is wiped out as a part of the objcg repaprenting
+	 * process. memcg->orig_objcg preserves a pointer (and a reference)
+	 * to the original objcg until the end of live of memcg.
+	 */
+	struct obj_cgroup __rcu	*objcg;
+	struct obj_cgroup	*orig_objcg;
 	/* list of inherited objcgs, protected by objcg_lock */
 	struct list_head objcg_list;
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a2efeea43058..490c5f67be79 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3808,6 +3808,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
+	obj_cgroup_get(objcg);
+	memcg->orig_objcg = objcg;
 
 	static_branch_enable(&memcg_kmem_online_key);
 
@@ -5302,6 +5304,9 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int node;
 
+	if (memcg->orig_objcg)
+		obj_cgroup_put(memcg->orig_objcg);
+
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	kfree(memcg->vmstats);
-- 
2.42.0

