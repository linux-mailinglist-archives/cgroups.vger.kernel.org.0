Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AB634860
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 21:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiKVUjA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 15:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKVUjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 15:39:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E96B5ADD7
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:38:59 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso9150379pgc.14
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCk7crVpHsoWjxoXg4k9Oe7oFJlX0XDRsq0chOvtH5k=;
        b=QLu2jTs+mXtjASsq5OzlqjbcvjHSntYcmXW5BeZ8EGTqfTk5VuRmfXcPpBa0L8tqf/
         bFlbRqiqbUbz/1+E/2bUfGTCJGmdPok9Q0swfO4WvYL6CcTBwSXb6nWrLg8NPH4JZ7DU
         J7zHtdY8JXGB2nmGkOsailBGhkdUMh2IXXQ94bzwKtwoBvglzRDNL27AHzpxuZVROun7
         jnaGaCnYOGlJIJXLqCBKXYcQVMZfbTAcy6TeuM6HKS6F4d0BGHbSYgT1wtMpvbnh08vD
         A50llXpkM7AX0OQmXUjKQyWpBPEoGm7+N/GAuIJLLu0porn9xtSY79p1BXcyvyjW+vAK
         UdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCk7crVpHsoWjxoXg4k9Oe7oFJlX0XDRsq0chOvtH5k=;
        b=rkYJfZnRRBB5HE90MfcaGVpkWKAdSDZyR1awwsz5VhOColHGNL8LSnYh/l4rOXJIsq
         2ZslxZBvvxIdRmtceODIOC3uwh7nEp1wFnUV3+LixcgBr5VhcqLyzjtD9NvBUzZHB02g
         nh7YL6s+5q119oYshwcefEAxVCoMrmZNBPKRNLRQ6Z5JfHPeHur9aoc1fF1iTiDWF7/B
         hsgMEWZM71by5jYplr4TXEvX9va52IwKpcCejMHRE7FrXI6UYtaWhDGJJr+cAL0XYg6A
         mmFQEsPjVqd61F4Ewo04F0t0JpY20gtWeG2dNvkgkG/YleMmOH3kdOR3zDaoVl9/uOZv
         LsCQ==
X-Gm-Message-State: ANoB5pmH043lBbuAxPO9JK9SUDAPA2Liydoul4Wj6NzUv67IiPYbpKsS
        GBP+Mwcds2RYVS0e3KzbFg+pMUw12cW1OgmKEw==
X-Google-Smtp-Source: AA0mqf7JVRwZjTH2qF1roqexXA9Lp5dWIvMNfnFMyaaNEXsV0n4N6GJN2mLIFPAONnS+SuXgvUK2QAtLed9LHtiwdQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:b7d0:497d:abe4:3e6f])
 (user=almasrymina job=sendgmr) by 2002:a63:1801:0:b0:45f:a78b:f905 with SMTP
 id y1-20020a631801000000b0045fa78bf905mr14719607pgl.296.1669149538565; Tue,
 22 Nov 2022 12:38:58 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:38:45 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122203850.2765015-1-almasrymina@google.com>
Subject: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
From:   Mina Almasry <almasrymina@google.com>
To:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
reclaim""), the proactive reclaim interface memory.reclaim does both
reclaim and demotion. This is likely fine for us for latency critical
jobs where we would want to disable proactive reclaim entirely, and is
also fine for latency tolerant jobs where we would like to both
proactively reclaim and demote.

However, for some latency tiers in the middle we would like to demote but
not reclaim. This is because reclaim and demotion incur different latency
costs to the jobs in the cgroup. Demoted memory would still be addressable
by the userspace at a higher latency, but reclaimed memory would need to
incur a pagefault.

To address this, I propose having reclaim-only and demotion-only
mechanisms in the kernel. There are a couple possible
interfaces to carry this out I considered:

1. Disable demotion in the memory.reclaim interface and add a new
   demotion interface (memory.demote).
2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
   behavior in the kernel like so:
   	- demote=0 would disable demotion from this call.
	- demote=1 would allow the kernel to demote if it desires.
	- demote=2 would only demote if possible but not attempt any
	  other form of reclaim.

I've implemented option #1 in this RFC to demonstrate a sample and would
love feedback on the usecase and approach.

Additionally, when triggering proactive demotion it is preferrable to have
a nodelist argument that allows the userspace to proactively demote from
specific memory tiers according to its policy. The userspace may want
to demote from specific nodes that are under pressure, and may want to
demote from specific tiers that are under pressure. An example of this
use case would be in a 3 memory tier system, the userspace may want to
demote from the second tier without disturbing the hot memory in the top
tier.

The current RFC series is missing updates to docs and selftests, but if
the general approach and usecase is acceptable I plan to add these with
a PATCH V1 review.

First patch in this series disables demotion from the proactive reclaim
interface memory.reclaim. Follow up patches in the series implement the
memory.demote interface and its nodeslist arg.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/swap.h |  6 ++++++
 mm/memcontrol.c      | 16 +++++++++-------
 mm/vmscan.c          | 21 +++++++++++++++++----
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index fec6647a289a..f768171c2dc2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -416,6 +416,12 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,

 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MEMCG_RECLAIM_MAY_DEMOTE (1 << 3)
+#define MEMCG_RECLAIM_ONLY_DEMOTE (1 << 4)
+#define MEMCG_RECLAIM_DEFAULT \
+	(MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_MAY_DEMOTE)
+#define MEMCG_RECLAIM_NO_SWAP (MEMCG_RECLAIM_DEFAULT & ~MEMCG_RECLAIM_MAY_SWAP)
+
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f412c903ee4f..fd4ff1c865a2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2392,7 +2392,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP);
+							MEMCG_RECLAIM_DEFAULT);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2637,7 +2637,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
-	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	unsigned int reclaim_options = MEMCG_RECLAIM_DEFAULT;
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
@@ -3503,7 +3503,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? MEMCG_RECLAIM_NO_SWAP :
+						MEMCG_RECLAIM_DEFAULT)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3614,7 +3615,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_DEFAULT))
 			nr_retries--;
 	}

@@ -6407,7 +6408,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}

 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT);

 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6456,7 +6457,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,

 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT))
 				nr_reclaims--;
 			continue;
 		}
@@ -6593,7 +6594,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	if (err)
 		return err;

-	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	reclaim_options = MEMCG_RECLAIM_DEFAULT | MEMCG_RECLAIM_PROACTIVE;
+	reclaim_options &= ~MEMCG_RECLAIM_MAY_DEMOTE;
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8751e403599..dea05ad8ece5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -132,8 +132,14 @@ struct scan_control {
 	/* The file folios on the current node are dangerously low */
 	unsigned int file_is_tiny:1;

-	/* Always discard instead of demoting to lower tier memory */
-	unsigned int no_demotion:1;
+	/*
+	 * Configure discard instead of demoting to lower tier memory:
+	 *
+	 * demotion = 0 -> no demotion
+	 * demotion = 1 -> may demote
+	 * demotion = 2 -> only demote
+	 */
+	unsigned int demotion;

 #ifdef CONFIG_LRU_GEN
 	/* help kswapd make better choices among multiple memcgs */
@@ -542,7 +548,7 @@ static bool can_demote(int nid, struct scan_control *sc)
 {
 	if (!numa_demotion_enabled)
 		return false;
-	if (sc && sc->no_demotion)
+	if (sc && !sc->demotion)
 		return false;
 	if (next_demotion_node(nid) == NUMA_NO_NODE)
 		return false;
@@ -2674,7 +2680,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
-		.no_demotion = 1,
+		.demotion = 0,
 	};

 	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
@@ -6726,6 +6732,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	 */
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);

+	if (reclaim_options & MEMCG_RECLAIM_ONLY_DEMOTE)
+		sc.demotion = 2;
+	else if (reclaim_options & MEMCG_RECLAIM_MAY_DEMOTE)
+		sc.demotion = 1;
+	else
+		sc.demotion = 0;
+
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
--
2.38.1.584.g0f3c55d4c2-goog
