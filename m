Return-Path: <cgroups+bounces-912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1CD80CCE6
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FA7B20DCB
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C83482F9;
	Mon, 11 Dec 2023 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxcbH9TB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2D6580;
	Mon, 11 Dec 2023 06:04:39 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-42594f0ca09so21224911cf.0;
        Mon, 11 Dec 2023 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702303479; x=1702908279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjv3xaAwIYR0bV7vWv+aqP2iMgmrLsGsg7noubEWJU0=;
        b=AxcbH9TBcUyokcTyPFtqCWDBeAefxnzAVozu4LvhES6BsUVncMUiJaeRaIW4kkM4V6
         UxqvxjmHF6s0nIyVH+l0TydCOwywL8NdnZipiPyD0c3+mTbLmHGBlAlZaMs1f+HapbVV
         U10zSJknWLbNiOoaOuQvdqlBxnkPSgXvF29EV4dhHU4yxwtjXcgyHiXqatNHyDtciguy
         zFborbplN9SgizdkrseA0si74+GLLv/6a5/OWwyFTmHPtAu1vi5YV/UolMyjCPjbfRQV
         jSqlTCv6iOhqpo4kUzSgBKxo/YHjorZ2ZkJTtgO68+do35w8gnQ8GMUBAPITDbp+aGp8
         hzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303479; x=1702908279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjv3xaAwIYR0bV7vWv+aqP2iMgmrLsGsg7noubEWJU0=;
        b=cCpvOuNUTG+Z4CRgsGEIEObXBfiwmrCePgAWgA/R3U4yRxfZOhiN34QYgYKhTR1LSk
         Fo/Zkb1XatlCE7UXGu3z20UtgdR5SMF2y7Dv0Wc71SFgo73WMdm62tXqMRqgIQcXDEtm
         u26Ih6yV1B81n+iCaWTNi9tEw2qPhj83In5SRDMe/WlQlmvh15NWPHCywl5jPFzm9eWZ
         U/wzRfbtVsEOqxne2/EjYS3bwEjxSLp1a7MbnhcYKt9e9WdKZ0Ot7pM9H5+wXTQRP+dx
         WHKOQRv72rUSLo0Hl2tFQwY3Jw3r4a1BVLYkJccMYuaTJYeNHRrMBrZF3Mp1oLv3qa/a
         wu+A==
X-Gm-Message-State: AOJu0YyoyLXQnQ/CdOm34OSkKddQqnyaflpH52Y0tbRhkKXGCJR7BCG3
	1wx0V1XDB3d7bpMV+wCv+S4=
X-Google-Smtp-Source: AGHT+IF1HX3JHdwq2GaOCTk9P4s+U/GdIY1YVtlNRng0dWHJJC3DxlF+r8Rtb94zL7GDHDFVqmzLjQ==
X-Received: by 2002:a05:622a:1207:b0:425:a6dd:b997 with SMTP id y7-20020a05622a120700b00425a6ddb997mr2984093qtx.132.1702303478657;
        Mon, 11 Dec 2023 06:04:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:45f0])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b004257e4c5e21sm3201635qtr.28.2023.12.11.06.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:04:38 -0800 (PST)
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
	Chris Li <chrisl@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
Date: Mon, 11 Dec 2023 06:04:15 -0800
Message-Id: <20231211140419.1298178-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
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
index f6dd6575b905..ebc20d094609 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -410,7 +410,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
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
index 1c1061df9cd1..74598c17d3cc 100644
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
+							MEMCG_RECLAIM_MAY_SWAP, -1);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2740,7 +2741,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options, -1);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3660,7 +3661,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, -1)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3774,7 +3775,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP, -1))
 			nr_retries--;
 	}
 
@@ -6720,7 +6721,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, -1);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6769,7 +6770,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, -1))
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
+					swappiness);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 506f8220c5fe..a20965b20177 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -136,6 +136,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* Swappiness value for reclaim, if -1 use memcg/global value */
+	int swappiness;
+
 	/* Allocation order */
 	s8 order;
 
@@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
-	int swappiness = mem_cgroup_swappiness(memcg);
+	int swappiness = sc->swappiness != -1 ?
+		sc->swappiness : mem_cgroup_swappiness(memcg);
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
+	if (sc->swappiness != -1)
+		return sc->swappiness;
+
 	return mem_cgroup_swappiness(memcg);
 }
 
@@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   int swappiness)
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


