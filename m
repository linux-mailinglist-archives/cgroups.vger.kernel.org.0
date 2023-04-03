Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC136D5470
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjDCWEF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjDCWDq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 18:03:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079E3AAC
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 15:03:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e5-20020a17090301c500b001a1aa687e4bso18250312plh.17
        for <cgroups@vger.kernel.org>; Mon, 03 Apr 2023 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF9j9xhVt+HAtgUv/sW6MmUPAVRA6NHiHn3mXAJRGAA=;
        b=QZZrc3A9Ala3Y1fUrUeH9aHQEpEHIm56zSkCNE0A0d2CfnkVvyEn83miymwgAbVi5v
         9d0zVCVjgbHefP1pXO+Nwo1Ul1PtmNl2tpG2LpPChio/My4WZElf1o1jchSNOgvJZUsW
         WbV5lrmHTcH3fAqoJ7gZenJSRA3/dWbn3kNYUTeryGOWXdDf83/N+i1IFVKcpHglHDCj
         nH4nWeMmhgItD/X0NlX5brqxxgrkgNj//KowEl9SOf+dOa58iks3E9glke7V87blHVFo
         T2x7kiC5rzRzeUUzMZ/tXlij1MqA5Wi+XXZnHplS+57XrL+yaVLwig14jPX/om3gIc+M
         IAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kF9j9xhVt+HAtgUv/sW6MmUPAVRA6NHiHn3mXAJRGAA=;
        b=udHvjbnKerP4EHdlaL2/iJaqGCVMd+qNxpLDWcIAIAcXIIB3Bmpn48YbMRwLj/8hap
         pGTbEM4uhwu/DnJayAetbChEjbJXqbJgPOpFvlSRRNPp2mVd1vQ1RK5q/xJHQGaVZOmH
         wOAMHUkL5rpCz2Bi//A8C/yGT5680jGWXtgUM8lFi62bnizkVaB4H6T3mMbdJbajF+YL
         8CB7FFJYGEUINl6+g6f0h7gLHOMOUl63155wxI9KAFcoFdVsh6ASkqbm37JuSa+ha8/X
         LmPJyy4BmKvj/LRDtcCRdKub1kFkZP/O6fEhNPMPq+TZjBQgGLmTTMbQsZLtwU52MDKC
         TwuQ==
X-Gm-Message-State: AAQBX9c7MjSMEeAhx0uW/LsJoNiA+fWMmWnzZudup5kvI/YLxbrI1FpA
        SqSm91kT0BKRrNavfgeVzU7E2qQwSuJoapsX
X-Google-Smtp-Source: AKy350Y61C08ugQDQ0T+NdoZquMxt4ZL2sOiJByhoRsOjzxwb2aWtKxGtikw0lJtgE93Bg+tt+KjbLE8KoMgZHnh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:2301:0:b0:503:91ff:8dd8 with SMTP
 id j1-20020a632301000000b0050391ff8dd8mr27700pgj.4.1680559424700; Mon, 03 Apr
 2023 15:03:44 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:35 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-4-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 3/5] memcg: calculate root usage from global state
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, we approximate the root usage by adding the memcg stats for
anon, file, and conditionally swap (for memsw). To read the memcg stats
we need to invoke an rstat flush. rstat flushes can be expensive, they
scale with the number of cpus and cgroups on the system.

mem_cgroup_usage() is called by memcg_events()->mem_cgroup_threshold()
with irqs disabled, so such an expensive operation with irqs disabled
can cause problems.

Instead, approximate the root usage from global state. This is not 100%
accurate, but the root usage has always been ill-defined anyway.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bdd52fe9e7e4b..e7fe18c0c0ef2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3698,27 +3698,13 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 
 	if (mem_cgroup_is_root(memcg)) {
 		/*
-		 * We can reach here from irq context through:
-		 * uncharge_batch()
-		 * |--memcg_check_events()
-		 *    |--mem_cgroup_threshold()
-		 *       |--__mem_cgroup_threshold()
-		 *          |--mem_cgroup_usage
-		 *
-		 * rstat flushing is an expensive operation that should not be
-		 * done from irq context; use stale stats in this case.
-		 * Arguably, usage threshold events are not reliable on the root
-		 * memcg anyway since its usage is ill-defined.
-		 *
-		 * Additionally, other call paths through memcg_check_events()
-		 * disable irqs, so make sure we are flushing stats atomically.
+		 * Approximate root's usage from global state. This isn't
+		 * perfect, but the root usage was always an approximation.
 		 */
-		if (in_task())
-			mem_cgroup_flush_stats_atomic();
-		val = memcg_page_state(memcg, NR_FILE_PAGES) +
-			memcg_page_state(memcg, NR_ANON_MAPPED);
+		val = global_node_page_state(NR_FILE_PAGES) +
+			global_node_page_state(NR_ANON_MAPPED);
 		if (swap)
-			val += memcg_page_state(memcg, MEMCG_SWAP);
+			val += total_swap_pages - get_nr_swap_pages();
 	} else {
 		if (!swap)
 			val = page_counter_read(&memcg->memory);
-- 
2.40.0.348.gf938b09366-goog

