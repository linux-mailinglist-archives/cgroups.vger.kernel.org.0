Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC763CD19
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiK3CDi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 21:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiK3CDh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 21:03:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5327173
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 18:03:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n141-20020a254093000000b006eacc13c38eso14879027yba.0
        for <cgroups@vger.kernel.org>; Tue, 29 Nov 2022 18:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qySU/YYSJyV1Gig5PuzcugPI3DQny2PGxjqX/sS0z2A=;
        b=a7ok51aioMeHNiJSu7WtcVreWg/hIHdE7BTzM7xqt0k47iaIVEw0p+PKilUz+Z5Tsl
         2bQOfpVf6meh/wYFWCctnSFxSpCbqFFPHBt5Nx0JBytQZ0/IliRi6rBDoMjhvyJd7AhH
         ztB6iXeQE6BMroMQu8TBfxxXA2Ppm6c6oqSaNqTXvTK7OFI0mKSXpd38JrYmZBxE0Fct
         EHaaFE7e+qLy5rV6dHmXgMmqwzhxz5EJdyUk4lQL8I6UEpKrA0X0yTgSHiZiWUr/rorG
         O94Fpmf4kbvmxVvBMTIu7yKpC7llbZOk/E1EWf8UhfpN5UlttHcJCrkpJLwc8P352EeK
         IYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qySU/YYSJyV1Gig5PuzcugPI3DQny2PGxjqX/sS0z2A=;
        b=6+BDWdtMIZz/aRaabjWZDVyhp1Z62oqCWvvgMwM9rbybNc5lrMMWD7THca6+WQ4MSJ
         TwJ4XaOYFvQUc+CC57vGgWPnqxkOPrGMPMBmEFR3Qb35XI+gWq+ZxK9g9Uy6JZue/33C
         taWIuJaK9PLi8zqCX8lgog8vAJ20LR27Rq6NhnwzCC5lcMzHqb78ZmHmMChmE7BGT+S/
         ALcRPxvqGbDleQ4f2g6uVVXIZMArS+Uqn1mvIxpAu04OW3/5AWCO/2VLW81Jcy3RUfjG
         8xEgzLKITw+h63pS6I/UggfF0JSOcupHlczc2OIK/bFEdD7zk50TzS/Em86/34SW1U0+
         AV/Q==
X-Gm-Message-State: ANoB5pmgjsF3tPS+7ht6P7RZCFHemqxSUberugTeUt42zVIRxF0R8Xzr
        TbYbQZQSA1/Qi5RS4Gx6nCAPikGV9pOT1SplSg==
X-Google-Smtp-Source: AA0mqf7g8lJGoWb8KEPiq3MhQbh+oBKm+lFB3ObIBN3lGaF8mBPfoAWa/O48jVf8luC/UX/oIap+IknPhLZDdG+NAg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:5ef5:d4df:2c34:14d1])
 (user=almasrymina job=sendgmr) by 2002:a25:ba92:0:b0:6d3:66bb:786b with SMTP
 id s18-20020a25ba92000000b006d366bb786bmr58770981ybg.459.1669773814553; Tue,
 29 Nov 2022 18:03:34 -0800 (PST)
Date:   Tue, 29 Nov 2022 18:03:27 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130020328.1009347-1-almasrymina@google.com>
Subject: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
From:   Mina Almasry <almasrymina@google.com>
To:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 +++---
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 67 ++++++++++++++++++++-----
 mm/vmscan.c                             |  4 +-
 4 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 74cec76be9f2..ac5fcbcd5ae6 100644
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
+	via the 'nodes=' key, example::
+
+	  echo "1G nodes=0,1" > memory.reclaim
+
+	The above instructs the kernel to reclaim memory from nodes 0,1.
+
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b61e2007d156..f542c114dffd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -419,7 +419,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  unsigned int reclaim_options);
+						  unsigned int reclaim_options,
+						  nodemask_t nodemask);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23750cec0036..a0d7850173a9 100644
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
+							NODE_MASK_ALL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2683,7 +2685,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,

 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options,
+						    NODE_MASK_ALL);
 	psi_memstall_leave(&pflags);

 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3503,7 +3506,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
+					NODE_MASK_ALL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3614,7 +3618,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP,
+						  NODE_MASK_ALL))
 			nr_retries--;
 	}

@@ -6407,7 +6412,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}

 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NODE_MASK_ALL);

 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6456,7 +6462,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,

 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NODE_MASK_ALL))
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
+						nodemask);

 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b8e8e43806b..23fc5b523764 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   nodemask_t nodemask)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6750,6 +6751,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.nodemask = &nodemask,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
--
2.38.1.584.g0f3c55d4c2-goog
