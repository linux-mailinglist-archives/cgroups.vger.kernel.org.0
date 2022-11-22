Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61606634865
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiKVUjW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 15:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiKVUjS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 15:39:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD6697EB
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:39:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b17-20020a25b851000000b006e32b877068so14688640ybm.16
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSER/B4DnSDEXzptnYVRvY0Bxd0pX06XJiUIMZfJs1c=;
        b=Q8CGtJa+O00lg9Tqtd2xc0jsOMGOiJJRQKDl+HbQ4+RJuR4NE+I2vLParTPRJyK9dV
         HeSYxODpIYH636a5cGLJjdX3SPGMLDqJjaFcJ39VsuEELq4DgDIZX//2wGqsFd51QSJ+
         AZM/FTrtKnbmUqDMcYElZ3IbHtiXrin84UOmwRdMpGISPBEI8woUDxAgbVU4ym/RyNK7
         VWuGFbedYwWGh89zIthlnJvT8GU/8qlI9jP4fZERGstjvqu1lGm4VzeB6c1hICq2esGq
         a6HaxwII49NO4LMfOWNuAy3MP55sIxndD9RIDojCzutzGpi9VdKps5EppZgBJUct3an9
         k1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSER/B4DnSDEXzptnYVRvY0Bxd0pX06XJiUIMZfJs1c=;
        b=Ww+Bfytgau7Tp1bkEn9MWTbmv79OjB0PHQFxMVP+f6icjHxOrO37n1wXycXoPa72hY
         gVNYT4arDkF22yYi69RpJ1h7TMl0WZRcpmEQv0hZpaeNvOxdusNvaiCfxJZKjqqQY6FF
         2kxuwmjpKxXnuT6c58O2j6IfbSwQR5Vn6IKmxkbXaAfazOU84d1L030jWSEIsDvVycRy
         u+QMn/wv63ROQaHmws6kEAAG9sAronYLEtBfm3wQfWxcZG2YyWT27r52LmvLGZ4Ke31u
         fM2JcyQhJ4xa5K3j9f4R2wTPJVR3Dqt/Y7zsSf1vfjbmpY0km4qjkNWBc31xqKLEusIu
         ziNw==
X-Gm-Message-State: ANoB5plwHURitYf1YPcUY0VOkXo1Vhcqj+7xBmI07ZdcuIvUSqr57EQm
        N4qXAg+DmEKNAoySQbKbKajgn1CPaSnrxyBUpg==
X-Google-Smtp-Source: AA0mqf4rBzz34OSjlmhy6Kp1YPYM6391YLcoHMTdxwaIamF8cf36s4tqpIAJnSTaCKofEyXGnjd+9drhPZkA134Pwg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:b7d0:497d:abe4:3e6f])
 (user=almasrymina job=sendgmr) by 2002:a25:7450:0:b0:6ee:8d5a:3bca with SMTP
 id p77-20020a257450000000b006ee8d5a3bcamr4305851ybc.300.1669149555882; Tue,
 22 Nov 2022 12:39:15 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:38:48 -0800
In-Reply-To: <20221122203850.2765015-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122203850.2765015-4-almasrymina@google.com>
Subject: [RFC PATCH v1 4/4] mm: Add nodes= arg to memory.demote
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The nodes= arg instructs the kernel to only scan the given nodes for
demotion. For example use cases, consider a 3 tier memory system:

nodes 0,1 -> top tier
nodes 2,3 -> second tier
nodes 4,5 -> third tier

echo "1m nodes=2,3" > memory.demote

This instructs the kernel to attempt to demote 1m memory in the second tier
to the third, which can be desirable according to the userspace policy
if the second tier is filling up and there is available memory on the
third tier.

echo "1m" > memory.demote

Instructs the kernel to attempt to demote 1m of memory (regardless of
which tier the memory is currently on).

echo "1m nodes=0,1"

Instructs the kernel to demote memory from the top tier nodes, which can
be desirable according to the userspace policy if there is pressure on
the top tiers.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/swap.h |  3 ++-
 mm/memcontrol.c      | 64 ++++++++++++++++++++++++++++++++++++--------
 mm/vmscan.c          |  4 ++-
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f768171c2dc2..e195ee5f8efb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -425,7 +425,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
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
index 427c79e467eb..cce446348358 100644
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
-							MEMCG_RECLAIM_DEFAULT);
+							MEMCG_RECLAIM_DEFAULT,
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
@@ -3504,7 +3507,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
 					memsw ? MEMCG_RECLAIM_NO_SWAP :
-						MEMCG_RECLAIM_DEFAULT)) {
+						MEMCG_RECLAIM_DEFAULT,
+						NODE_MASK_ALL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3615,7 +3619,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_DEFAULT))
+						  MEMCG_RECLAIM_DEFAULT,
+						  NODE_MASK_ALL))
 			nr_retries--;
 	}

@@ -6408,7 +6413,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}

 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT);
+					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT,
+					NODE_MASK_ALL);

 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6457,7 +6463,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,

 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT))
+					GFP_KERNEL, MEMCG_RECLAIM_DEFAULT,
+					NODE_MASK_ALL))
 				nr_reclaims--;
 			continue;
 		}
@@ -6612,7 +6619,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,

 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 						nr_to_reclaim - nr_reclaimed,
-						GFP_KERNEL, reclaim_options);
+						GFP_KERNEL, reclaim_options,
+						NODE_MASK_ALL);

 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
@@ -6623,6 +6631,16 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }

+enum {
+	MEMORY_DEMOTE_NODES = 0,
+	MEMORY_DEMOTE_NULL,
+};
+
+static const match_table_t if_tokens = {
+	{ MEMORY_DEMOTE_NODES, "nodes=%s" },
+	{ MEMORY_DEMOTE_NULL, NULL },
+};
+
 static ssize_t memory_demote(struct kernfs_open_file *of, char *buf,
 			     size_t nbytes, loff_t off)
 {
@@ -6631,11 +6649,35 @@ static ssize_t memory_demote(struct kernfs_open_file *of, char *buf,
 	unsigned long nr_to_demote, nr_demoted = 0;
 	unsigned int reclaim_options = MEMCG_RECLAIM_ONLY_DEMOTE;
 	int err;
+	char *old_buf, *start;
+	substring_t args[MAX_OPT_ARGS];
+	int token;
+	char value[256];
+	nodemask_t nodemask = NODE_MASK_ALL;

 	buf = strstrip(buf);
-	err = page_counter_memparse(buf, "", &nr_to_demote);
-	if (err)
-		return err;
+	old_buf = buf;
+	nr_to_demote = memparse(buf, &buf) / PAGE_SIZE;
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
+		case MEMORY_DEMOTE_NODES:
+			err = nodelist_parse(value, nodemask);
+			if (err < 0)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}

 	while (nr_demoted < nr_to_demote) {
 		unsigned long demoted;
@@ -6645,7 +6687,7 @@ static ssize_t memory_demote(struct kernfs_open_file *of, char *buf,

 		demoted = try_to_free_mem_cgroup_pages(
 			memcg, nr_to_demote - nr_demoted, GFP_KERNEL,
-			reclaim_options);
+			reclaim_options, nodemask);

 		if (!demoted && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d7e509b3f07f..df5ade259b3a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6719,7 +6719,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   nodemask_t nodemask)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6734,6 +6735,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.nodemask = &nodemask,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
--
2.38.1.584.g0f3c55d4c2-goog
