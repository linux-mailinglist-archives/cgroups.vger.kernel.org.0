Return-Path: <cgroups+bounces-868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208D8074F5
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 17:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ADD1F2127E
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824247772;
	Wed,  6 Dec 2023 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN87Stqd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444218D;
	Wed,  6 Dec 2023 08:29:34 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f37772ab6so18406785a.0;
        Wed, 06 Dec 2023 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880173; x=1702484973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwZWXH9p+0yJMhMBcVvnwovBBLZBIMZ/gK454l8lM54=;
        b=eN87Stqdk0xTY199iNxX2W06S+DqBvTtXgBJmQyKamhbagGrqppT3QBN6ISTexmy+Y
         CMEjL/R5EqJvNvS3ep8tkEy2X8VIXOFRHYJAe3p4JB30w1UBsGQrZ3hS/tY662pmeN6x
         FilaZH4t4sW4+cQ7PEY9KweWRSZHQQE3+f0LuGPIidlAO1QJXR2//tJBeIVtcu3Q3vja
         GLWY/LFElUPp1oaRj76w2tUFlNV5DOYbvfi9wayqzhpXyzc/r7BdveImadxDefwi2ePz
         PB7EHWtOZ2SCcZPM0wlc9Zp+kDFYyGRFCKIIz2g3KEbb4uJOVjnAkYO6axZ2OI5/Z3FG
         EZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880173; x=1702484973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwZWXH9p+0yJMhMBcVvnwovBBLZBIMZ/gK454l8lM54=;
        b=J9LETmCD09XRUtYgCx7SfcyNucAgfq8j8/eV+Ko5f1QlX9FMQNUnO0KTiaCFk+AIM8
         VaAFu3ST+V2AI8FLRJA4lNYdz4+4r82N8AfOWRrWmiVAVvC9CRBfKBHE2GK0z2oGZGa+
         y7w8k+GAfegPHSDOalxmenzZY8XekXjb/ahO1BlVuwsuQQjWfW2jKa4hvDk3XY9JJV26
         7cHk8rJcLw8ylUiSvH1/3YJYFxLCg9C7dgCKdXVHc/lpoZvHEA8pToM6y0qEmG4/FVeq
         Pw1/gU5BmEKTF0V4Oj+feIaIYrgghUb0KkCPcpkYtx5k3zVavi3SPLOLS7jhlm1NRxqV
         V9Cw==
X-Gm-Message-State: AOJu0Yxa8SP2lj7g/wM98duA7AIEHBErxMclof3o3wSOaCxVUimJCg/e
	XOQoLKcs9tNxt+BR4dKpkTE=
X-Google-Smtp-Source: AGHT+IGx8a7EzNCQyfTSNswNgSliYrYf9H/wfyFTvaT8dR4sDl26fZNTIsdIibcVYXFPjl6D4wV8QA==
X-Received: by 2002:a05:620a:66c:b0:77e:fba3:81e5 with SMTP id a12-20020a05620a066c00b0077efba381e5mr1148000qkh.123.1701880173098;
        Wed, 06 Dec 2023 08:29:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6:c65f])
        by smtp.gmail.com with ESMTPSA id br32-20020a05620a462000b0077dd520f844sm65807qkb.84.2023.12.06.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:29:32 -0800 (PST)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Date: Wed,  6 Dec 2023 08:28:56 -0800
Message-Id: <20231206162900.1571025-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206162900.1571025-1-schatzberg.dan@gmail.com>
References: <20231206162900.1571025-1-schatzberg.dan@gmail.com>
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
 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++-
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 55 ++++++++++++++++++++-----
 mm/vmscan.c                             | 13 +++++-
 4 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..fc2b379dbd0f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1282,8 +1282,8 @@ PAGE_SIZE multiple when read back.
 	This is a simple interface to trigger memory reclaim in the
 	target cgroup.
 
-	This file accepts a single key, the number of bytes to reclaim.
-	No nested keys are currently supported.
+	This file accepts a string which containers thhe number of bytes
+	to reclaim.
 
 	Example::
 
@@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
 	This means that the networking layer will not adapt based on
 	reclaim induced by memory.reclaim.
 
+	This file also allows the user to specify the swappiness value
+	to be used for the reclaim. For example:
+
+	  echo "1G swappiness=60" > memory.reclaim
+
+	The above instructs the kernel to perform the reclaim with
+	a swappiness value of 60. Note that this has the same semantics
+	as the vm.swappiness sysctl - it sets the relative IO cost of
+	reclaiming anon vs file memory but does not allow for reclaiming
+	specific amounts of anon or file memory.
+
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f6dd6575b905..c6e309199f10 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -410,7 +410,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  unsigned int reclaim_options);
+						  unsigned int reclaim_options,
+						  int *swappiness);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1c1061df9cd1..ba1c89455ab0 100644
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
@@ -2449,7 +2450,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP);
+							MEMCG_RECLAIM_MAY_SWAP, NULL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2740,7 +2741,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options, NULL);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3660,7 +3661,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3774,7 +3775,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP, NULL))
 			nr_retries--;
 	}
 
@@ -6720,7 +6721,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6769,7 +6770,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
 				nr_reclaims--;
 			continue;
 		}
@@ -6895,6 +6896,16 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+enum {
+	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_NULL,
+};
+
+static const match_table_t if_tokens = {
+	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_NULL, NULL },
+};
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6902,12 +6913,33 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	unsigned int reclaim_options;
-	int err;
+	char *old_buf, *start;
+	substring_t args[MAX_OPT_ARGS];
+	int swappiness = -1;
 
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
+		switch (match_token(start, if_tokens, args)) {
+		case MEMORY_RECLAIM_SWAPPINESS:
+			if (match_int(&args[0], &swappiness))
+				return -EINVAL;
+			if (swappiness < 0 || swappiness > 200)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
@@ -6926,7 +6958,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+					GFP_KERNEL, reclaim_options,
+					swappiness == -1 ? NULL : &swappiness);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 506f8220c5fe..546704ea01e1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -136,6 +136,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* Swappiness value for reclaim, if NULL use memcg/global value */
+	int *swappiness;
+
 	/* Allocation order */
 	s8 order;
 
@@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
-	int swappiness = mem_cgroup_swappiness(memcg);
+	int swappiness = sc->swappiness ?
+		*sc->swappiness : mem_cgroup_swappiness(memcg);
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
+	if (sc->swappiness)
+		return *sc->swappiness;
+
 	return mem_cgroup_swappiness(memcg);
 }
 
@@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   int *swappiness)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.swappiness = swappiness,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
-- 
2.34.1


