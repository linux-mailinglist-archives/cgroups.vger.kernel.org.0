Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407C64E8EF
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiLPJyo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiLPJyU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 04:54:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB04A584;
        Fri, 16 Dec 2022 01:54:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3080D33E77;
        Fri, 16 Dec 2022 09:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671184457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o617ymahCBDUwg/ibQ5ik0Q09yiBjUX5QeeGEwl2TXE=;
        b=lCWlA0AXi7lajIa0bWupQp2+/gi28z78NIK2swJw8lh8KpFjPTZ4ZaTk0mK112E7+MSsPI
        OB20DoDFdf6gY9J7upFs2toz4RTqUkFiL5AxM14paMqtlMWvhuUOCfiwX8VCHM1thSf3Ca
        WzqdvrrfEz6HD+wF3xSOGC/66X4SKxs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DA20138F0;
        Fri, 16 Dec 2022 09:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bA9rBklAnGOkWgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 16 Dec 2022 09:54:17 +0000
Date:   Fri, 16 Dec 2022 10:54:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
Message-ID: <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrew,
I have noticed that the patch made it into Linus tree already. Can we
please revert it because the semantic is not really clear and we should
really not create yet another user API maintenance problem. I am
proposing to revert the nodemask extension for now before we grow any
upstream users. Deeper in the email thread are some proposals how to
move forward with that.
--- 
From 7c5285f1725d5abfcae5548ab0d73be9ceded2a1 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 16 Dec 2022 10:46:33 +0100
Subject: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"

This reverts commit 12a5d3955227b0d7e04fb793ccceeb2a1dd275c5.

Although it is recognized that a finer grained pro-active reclaim is
something we need and want the semantic of this implementation is really
ambiguous.

From a follow up discussion it became clear that there are two essential
usecases here. One is to use memory.reclaim to pro-actively reclaim
memory and expectation is that the requested and reported amount of memory is
uncharged from the memcg. Another usecase focuses on pro-active demotion
when the memory is merely shuffled around to demotion targets while the
overall charged memory stays unchanged.

The current implementation considers demoted pages as reclaimed and that
break both usecases. [1] has tried to address the reporting part but
there are more issues with that summarized in [2] and follow up emails.

Let's revert the nodemask based extension of the memcg pro-active
reclaim for now until we settle with a more robust semantic.

[1] http://lkml.kernel.org/r/http://lkml.kernel.org/r/20221206023406.3182800-1-almasrymina@google.com
[2] http://lkml.kernel.org/r/Y5bsmpCyeryu3Zz1@dhcp22.suse.cz
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 +++---
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 67 +++++--------------------
 mm/vmscan.c                             |  4 +-
 4 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c8ae7c897f14..74cec76be9f2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1245,13 +1245,17 @@ PAGE_SIZE multiple when read back.
 	This is a simple interface to trigger memory reclaim in the
 	target cgroup.
 
-	This file accepts a string which contains the number of bytes to
-	reclaim.
+	This file accepts a single key, the number of bytes to reclaim.
+	No nested keys are currently supported.
 
 	Example::
 
 	  echo "1G" > memory.reclaim
 
+	The interface can be later extended with nested keys to
+	configure the reclaim behavior. For example, specify the
+	type of memory to reclaim from (anon, file, ..).
+
 	Please note that the kernel can over or under reclaim from
 	the target cgroup. If less bytes are reclaimed than the
 	specified amount, -EAGAIN is returned.
@@ -1263,13 +1267,6 @@ PAGE_SIZE multiple when read back.
 	This means that the networking layer will not adapt based on
 	reclaim induced by memory.reclaim.
 
-	This file also allows the user to specify the nodes to reclaim from,
-	via the 'nodes=' key, for example::
-
-	  echo "1G nodes=0,1" > memory.reclaim
-
-	The above instructs the kernel to reclaim memory from nodes 0,1.
-
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2787b84eaf12..0ceed49516ad 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -418,8 +418,7 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  unsigned int reclaim_options,
-						  nodemask_t *nodemask);
+						  unsigned int reclaim_options);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab..73afff8062f9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,7 +63,6 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
-#include <linux/parser.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2393,8 +2392,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP,
-							NULL);
+							MEMCG_RECLAIM_MAY_SWAP);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2685,8 +2683,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options,
-						    NULL);
+						    gfp_mask, reclaim_options);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3506,8 +3503,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
-					NULL)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3618,8 +3614,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP,
-						  NULL))
+						  MEMCG_RECLAIM_MAY_SWAP))
 			nr_retries--;
 	}
 
@@ -6429,8 +6424,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
-					NULL);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6479,8 +6473,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
-					NULL))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
 				nr_reclaims--;
 			continue;
 		}
@@ -6603,54 +6596,21 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
-enum {
-	MEMORY_RECLAIM_NODES = 0,
-	MEMORY_RECLAIM_NULL,
-};
-
-static const match_table_t if_tokens = {
-	{ MEMORY_RECLAIM_NODES, "nodes=%s" },
-	{ MEMORY_RECLAIM_NULL, NULL },
-};
-
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
-	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
-				       MEMCG_RECLAIM_PROACTIVE;
-	char *old_buf, *start;
-	substring_t args[MAX_OPT_ARGS];
-	int token;
-	char value[256];
-	nodemask_t nodemask = NODE_MASK_ALL;
-
-	buf = strstrip(buf);
-
-	old_buf = buf;
-	nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
-	if (buf == old_buf)
-		return -EINVAL;
+	unsigned int reclaim_options;
+	int err;
 
 	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "", &nr_to_reclaim);
+	if (err)
+		return err;
 
-	while ((start = strsep(&buf, " ")) != NULL) {
-		if (!strlen(start))
-			continue;
-		token = match_token(start, if_tokens, args);
-		match_strlcpy(value, args, sizeof(value));
-		switch (token) {
-		case MEMORY_RECLAIM_NODES:
-			if (nodelist_parse(value, nodemask) < 0)
-				return -EINVAL;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
+	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;
 
@@ -6667,8 +6627,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, reclaim_options,
-						&nodemask);
+						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index aba991c505f1..546540bc770a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6757,8 +6757,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options,
-					   nodemask_t *nodemask)
+					   unsigned int reclaim_options)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6773,7 +6772,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
-		.nodemask = nodemask,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.30.2

-- 
Michal Hocko
SUSE Labs
