Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F326410C1
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiLBWhS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiLBWhQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:37:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90338EC0AE
        for <cgroups@vger.kernel.org>; Fri,  2 Dec 2022 14:37:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b17-20020a25b851000000b006e32b877068so6620359ybm.16
        for <cgroups@vger.kernel.org>; Fri, 02 Dec 2022 14:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+RO437GEZ+WElFZehPW6Ok02BB1y3djf+6Wg2yQ+h9s=;
        b=LHn2nRg2oFSaB0dJIO0yooCpv3dQ9QXMByKCwdl+egE/WOxwP4FVQGWDYz6Y9tkPE5
         Jgp0CK7S4yTl0+kb59ClT1OaReoxyzdt+FA3VldMFUb3CnSkvhWbbGUhX/Xy35QjivbK
         TO20TuKzlLUlQOLWrz0krvOhwUBh7koeYBCRszO+0ZfI78AbvD3Oqx3YxjNGYNKY5M87
         9/Vr//ig9WyTbABAr+ryFE+y1QKpod6J16FyKzolUGaMMhBukvF/UQe6iw3yqO5cm5hD
         Dlel/jBqm1zRF7mqaUmelu3Yt6iL0EO5IjYDyTYElc9xM5l/JhwKJVbiEHqf4k/4b4Gn
         ursQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RO437GEZ+WElFZehPW6Ok02BB1y3djf+6Wg2yQ+h9s=;
        b=sCTRQeKcJceXUFteBemhG8ugO9j4yYB27Q17lMvqrLFWGzFL06HfA85SNr8+a7UGrC
         fNuu03WJQstWavKH1c7FSXhTqe7xILxIXmyeeJKzTUQAJ5iBBJhvXeEU6PHtvrcLxlzn
         wvqobOQfyKD+0Hu4F6ULvMm362U7iFup2UgwLMow9wVLFBhpg6x55/YMQlNYNcI/+BFe
         5rfNeQk1aqo2moTq06yKnLCnGqodDQ1Ak2Ek3aZ+kWhpulbBQKetAnn5t2LZoguAItCZ
         Yla76om6x/1TwdzgjiMnG7Hn7sZ4iFzlt/kp2aByYMYCdzKDQ9ZZlamwYi2DbfwmJGXS
         Wa9w==
X-Gm-Message-State: ANoB5pkJwrsu20bqFLCS6AEWfCk3Q6CbbKfQIiLRNKwrRzG2rzXOwxHN
        wXP8Km9K03zucFnEG3XlKiZ0MwfJu6bqZiOXWA==
X-Google-Smtp-Source: AA0mqf4PIdv0aQLEqmeEeWbJELak73oDPHmxGVKwPDJayj60lAtluQD5SfzgXdsUavXKcKM8KW79xWNR2mzBs49Dfg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:e655:31e2:2ad4:2421])
 (user=almasrymina job=sendgmr) by 2002:a81:fe09:0:b0:3b0:b9aa:46eb with SMTP
 id j9-20020a81fe09000000b003b0b9aa46ebmr44197742ywn.150.1670020633813; Fri,
 02 Dec 2022 14:37:13 -0800 (PST)
Date:   Fri,  2 Dec 2022 14:35:31 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202223533.1785418-1-almasrymina@google.com>
Subject: [PATCH v3] mm: Add nodes= arg to memory.reclaim
From:   Mina Almasry <almasrymina@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, bagasdotme@gmail.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

The nodes= arg instructs the kernel to only scan the given nodes for
proactive reclaim. For example use cases, consider a 2 tier memory system:

nodes 0,1 -> top tier
nodes 2,3 -> second tier

$ echo "1m nodes=0" > memory.reclaim

This instructs the kernel to attempt to reclaim 1m memory from node 0.
Since node 0 is a top tier node, demotion will be attempted first. This
is useful to direct proactive reclaim to specific nodes that are under
pressure.

$ echo "1m nodes=2,3" > memory.reclaim

This instructs the kernel to attempt to reclaim 1m memory in the second tier,
since this tier of memory has no demotion targets the memory will be
reclaimed.

$ echo "1m nodes=0,1" > memory.reclaim

Instructs the kernel to reclaim memory from the top tier nodes, which can
be desirable according to the userspace policy if there is pressure on
the top tiers. Since these nodes have demotion targets, the kernel will
attempt demotion first.

Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
reclaim""), the proactive reclaim interface memory.reclaim does both
reclaim and demotion. Reclaim and demotion incur different latency costs
to the jobs in the cgroup. Demoted memory would still be addressable
by the userspace at a higher latency, but reclaimed memory would need to
incur a pagefault.

The 'nodes' arg is useful to allow the userspace to control demotion
and reclaim independently according to its policy: if the memory.reclaim
is called on a node with demotion targets, it will attempt demotion first;
if it is called on a node without demotion targets, it will only attempt
reclaim.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v3:
- Dropped RFC tag from subject.
- Added Michal's Ack
- Applied some of Bagas's comment suggestions.
- Converted try_to_fre_mem_cgorup_pages() to take nodemask_t* instead of
  nodemask_t as Shakeel and Muchun suggested.

Cc: bagasdotme@gmail.com

Thanks for the comments and reviews.
---
 Documentation/admin-guide/cgroup-v2.rst | 15 +++---
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 67 ++++++++++++++++++++-----
 mm/vmscan.c                             |  4 +-
 4 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 74cec76be9f2..c8ae7c897f14 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1245,17 +1245,13 @@ PAGE_SIZE multiple when read back.
 	This is a simple interface to trigger memory reclaim in the
 	target cgroup.

-	This file accepts a single key, the number of bytes to reclaim.
-	No nested keys are currently supported.
+	This file accepts a string which contains the number of bytes to
+	reclaim.

 	Example::

 	  echo "1G" > memory.reclaim

-	The interface can be later extended with nested keys to
-	configure the reclaim behavior. For example, specify the
-	type of memory to reclaim from (anon, file, ..).
-
 	Please note that the kernel can over or under reclaim from
 	the target cgroup. If less bytes are reclaimed than the
 	specified amount, -EAGAIN is returned.
@@ -1267,6 +1263,13 @@ PAGE_SIZE multiple when read back.
 	This means that the networking layer will not adapt based on
 	reclaim induced by memory.reclaim.

+	This file also allows the user to specify the nodes to reclaim from,
+	via the 'nodes=' key, for example::
+
+	  echo "1G nodes=0,1" > memory.reclaim
+
+	The above instructs the kernel to reclaim memory from nodes 0,1.
+
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ceed49516ad..2787b84eaf12 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -418,7 +418,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  unsigned int reclaim_options);
+						  unsigned int reclaim_options,
+						  nodemask_t *nodemask);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23750cec0036..0f02f47a87e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/parser.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2392,7 +2393,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP);
+							MEMCG_RECLAIM_MAY_SWAP,
+							NULL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2683,7 +2685,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,

 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options,
+						    NULL);
 	psi_memstall_leave(&pflags);

 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3503,7 +3506,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
+					NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3614,7 +3618,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP,
+						  NULL))
 			nr_retries--;
 	}

@@ -6407,7 +6412,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}

 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL);

 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6456,7 +6462,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,

 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL))
 				nr_reclaims--;
 			continue;
 		}
@@ -6579,21 +6586,54 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }

+enum {
+	MEMORY_RECLAIM_NODES = 0,
+	MEMORY_RECLAIM_NULL,
+};
+
+static const match_table_t if_tokens = {
+	{ MEMORY_RECLAIM_NODES, "nodes=%s" },
+	{ MEMORY_RECLAIM_NULL, NULL },
+};
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
-	unsigned int reclaim_options;
-	int err;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
+				       MEMCG_RECLAIM_PROACTIVE;
+	char *old_buf, *start;
+	substring_t args[MAX_OPT_ARGS];
+	int token;
+	char value[256];
+	nodemask_t nodemask = NODE_MASK_ALL;

 	buf = strstrip(buf);
-	err = page_counter_memparse(buf, "", &nr_to_reclaim);
-	if (err)
-		return err;

-	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	old_buf = buf;
+	nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
+	if (buf == old_buf)
+		return -EINVAL;
+
+	buf = strstrip(buf);
+
+	while ((start = strsep(&buf, " ")) != NULL) {
+		if (!strlen(start))
+			continue;
+		token = match_token(start, if_tokens, args);
+		match_strlcpy(value, args, sizeof(value));
+		switch (token) {
+		case MEMORY_RECLAIM_NODES:
+			if (nodelist_parse(value, nodemask) < 0)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;

@@ -6610,7 +6650,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,

 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, reclaim_options);
+						GFP_KERNEL, reclaim_options,
+						&nodemask);

 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b8e8e43806b..62b0c9b46bd2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   nodemask_t *nodemask)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6750,6 +6751,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.nodemask = nodemask,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
--
2.39.0.rc0.267.gcb52ba06e7-goog
