Return-Path: <cgroups+bounces-931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF18107C5
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 02:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F14E282384
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8DECA;
	Wed, 13 Dec 2023 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwnO7soV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE1710A;
	Tue, 12 Dec 2023 17:38:59 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b9ef61b6b8so3762595b6e.3;
        Tue, 12 Dec 2023 17:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702431539; x=1703036339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auvI36LUE8ejZAXPToUPGGocmqelYA9bY8VJoyIN2tw=;
        b=IwnO7soVBEqSAkQjjLNK/g5JAiebyrJxg7X998cLfg5aD/GClhDXTHiD+e+R//4Mc+
         SJNnItClH9NV/Vjs9btJBOsFuZSCd+5arXhHGX+OOCFLX8iO+fIgMDzZOtvtLuaX9k2K
         zEC2j0QZqrIphcStjf3yGlSWZAke+dOjJ6Cq7je5xxGBOuZ4S6yL8Z2ukJniH1/VwiVL
         iIOICXpQjWFFQhLOi3E+cEh96bEwK8nl7KsXix4oVuRBgc/RyI6NRYCINfXZo4zmQr4z
         c/LvduMGEbuWPtDNmwAW7GbKYIAktnb3DDyl3M8DXUBummVp6sceg9Ok2yrbCaZawq2K
         VRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431539; x=1703036339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auvI36LUE8ejZAXPToUPGGocmqelYA9bY8VJoyIN2tw=;
        b=IwNGIVy6yqFOw+ZT2Dri6dJg8I7ijvMMugou754jYQve0Brtq8cMxSsW7DcCYGW7f4
         qbv6STlF8IiNclzXzpaRg+dGXVNTG3dwo1l2zSVXaxyaCU9qdUWjAQDqbNpBWlLwYLqY
         CuQb+Wuj7buMREYmjFgbsz3GyPDnZa49u26XwR+ATzhbd/1wBNtcZSCJeBq81nG3UueV
         B8ltUvwYPzvZan1MQ/roNC1JDKr6F16mxgLNHPDYDEJQCBU7Qf2sbHdVdlZahmV2cxFf
         x4bNLLURh2IcTni2APfDw8DcOlRrn1pH5PFyih0lE05Luk2r2RjSHS0Ilzix8ybo+xWr
         PIWg==
X-Gm-Message-State: AOJu0YzsB6AJD2SezbDTJQG18jGVhWRcxevpFKbgUukb5LuczGEurMNc
	4gm/FVQMhA/zqv3myhvqsLRQbG3AMSKhYw==
X-Google-Smtp-Source: AGHT+IEPRFFkdSriOP29xRP3FC7OLv6jCpNAM8KRiqnpSneN+mERl09dXemtdfLzfx721QtwIbEe3Q==
X-Received: by 2002:a05:6808:1998:b0:3b9:de63:f514 with SMTP id bj24-20020a056808199800b003b9de63f514mr9078746oib.12.1702431538693;
        Tue, 12 Dec 2023 17:38:58 -0800 (PST)
Received: from localhost ([2620:10d:c090:500::7:1c76])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709028f8300b001d0242c0471sm9256526plo.224.2023.12.12.17.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:38:58 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Date: Tue, 12 Dec 2023 17:38:03 -0800
Message-Id: <20231213013807.897742-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213013807.897742-1-schatzberg.dan@gmail.com>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow proactive reclaimers to submit an additional swappiness=<val>
argument to memory.reclaim. This overrides the global or per-memcg
swappiness setting for that reclaim attempt.

For example:

echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim

will perform reclaim on the rootcg with a swappiness setting of 0 (no
swap) regardless of the vm.swappiness sysctl setting.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 19 +++++---
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 61 ++++++++++++++++++++-----
 mm/vmscan.c                             | 11 +++--
 4 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..06319349c072 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1282,17 +1282,10 @@ PAGE_SIZE multiple when read back.
 	This is a simple interface to trigger memory reclaim in the
 	target cgroup.
 
-	This file accepts a single key, the number of bytes to reclaim.
-	No nested keys are currently supported.
-
 	Example::
 
 	  echo "1G" > memory.reclaim
 
-	The interface can be later extended with nested keys to
-	configure the reclaim behavior. For example, specify the
-	type of memory to reclaim from (anon, file, ..).
-
 	Please note that the kernel can over or under reclaim from
 	the target cgroup. If less bytes are reclaimed than the
 	specified amount, -EAGAIN is returned.
@@ -1304,6 +1297,18 @@ PAGE_SIZE multiple when read back.
 	This means that the networking layer will not adapt based on
 	reclaim induced by memory.reclaim.
 
+The following nested keys are defined.
+
+	  ==========		================================
+	  swappiness		Swappiness value to reclaim with
+	  ==========		================================
+
+	Specifying a swappiness value instructs the kernel to perform
+	the reclaim with that swappiness value. Note that this has the
+	same semantics as the vm.swappiness sysctl - it sets the
+	relative IO cost of reclaiming anon vs file memory but does
+	not allow for reclaiming specific amounts of anon or file memory.
+
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e2ab76c25b4a..690898c347de 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -412,7 +412,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  unsigned int reclaim_options);
+						  unsigned int reclaim_options,
+						  int swappiness);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9748a6b88bb8..be3d5797d9df 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/parser.h>
 #include <linux/sched/isolation.h>
 #include "internal.h"
 #include <net/sock.h>
@@ -2449,7 +2450,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP);
+							MEMCG_RECLAIM_MAY_SWAP,
+							mem_cgroup_swappiness(memcg));
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2740,7 +2742,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options,
+						    mem_cgroup_swappiness(memcg));
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3660,7 +3663,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
+					mem_cgroup_swappiness(memcg))) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3774,7 +3778,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP,
+						  mem_cgroup_swappiness(memcg)))
 			nr_retries--;
 	}
 
@@ -6720,7 +6725,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					mem_cgroup_swappiness(memcg));
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6769,7 +6775,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					mem_cgroup_swappiness(memcg)))
 				nr_reclaims--;
 			continue;
 		}
@@ -6895,6 +6902,16 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+enum {
+	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_NULL,
+};
+
+static const match_table_t tokens = {
+	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_NULL, NULL },
+};
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6902,12 +6919,33 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	unsigned int reclaim_options;
-	int err;
+	char *old_buf, *start;
+	substring_t args[MAX_OPT_ARGS];
+	int swappiness = mem_cgroup_swappiness(memcg);
 
 	buf = strstrip(buf);
-	err = page_counter_memparse(buf, "", &nr_to_reclaim);
-	if (err)
-		return err;
+
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
+		switch (match_token(start, tokens, args)) {
+		case MEMORY_RECLAIM_SWAPPINESS:
+			if (match_int(&args[0], &swappiness))
+				return -EINVAL;
+			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
@@ -6926,7 +6964,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+					GFP_KERNEL, reclaim_options,
+					swappiness);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2aa671fe938b..cfef06c7c23f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -136,6 +136,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* Swappiness value for reclaim */
+	int swappiness;
+
 	/* Allocation order */
 	s8 order;
 
@@ -2327,7 +2330,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
-	int swappiness = mem_cgroup_swappiness(memcg);
+	int swappiness = sc->swappiness;
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -2608,7 +2611,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
-	return mem_cgroup_swappiness(memcg);
+	return sc->swappiness;
 }
 
 static int get_nr_gens(struct lruvec *lruvec, int type)
@@ -6433,7 +6436,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   int swappiness)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6448,6 +6452,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.swappiness = swappiness,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.34.1


