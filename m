Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB97B07B4
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjI0PJG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjI0PJC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 11:09:02 -0400
Received: from out-193.mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929F19E
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 08:09:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695827339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJPTphOT9Ah3iL7MZ9KbERD0ROIs5HQQzvQjuLNJnns=;
        b=pNocy6o9sigu+gpBp2nZU0nrp9UmQjhqPdMh8hND8MX7ixqhRzLWJmdV9/s/k8Rs1A5Qa5
        6IMESlh4qTyehhfmr0rDc9in0xsrFhOJIDRwOsOUFW2sCFbjw/rB+qADTL7a3cw1BDr2Zq
        iq5OmF6L+8t6+ySa0+DaftZUm1opJI4=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 3/5] mm: kmem: make memcg keep a reference to the original objcg
Date:   Wed, 27 Sep 2023 08:08:30 -0700
Message-ID: <20230927150832.335132-4-roman.gushchin@linux.dev>
In-Reply-To: <20230927150832.335132-1-roman.gushchin@linux.dev>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
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
index 84425bfe4124..412ff0e8694d 100644
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
index 7f33a503d600..4815f897758c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3803,6 +3803,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
+	obj_cgroup_get(objcg);
+	memcg->orig_objcg = objcg;
 
 	static_branch_enable(&memcg_kmem_online_key);
 
@@ -5297,6 +5299,9 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
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

