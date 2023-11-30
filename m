Return-Path: <cgroups+bounces-704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B67FF3BC
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295381F20EFB
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA9524D7;
	Thu, 30 Nov 2023 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc/bfKmR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AB10E0;
	Thu, 30 Nov 2023 07:38:23 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d852e06b07so651365a34.3;
        Thu, 30 Nov 2023 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701358703; x=1701963503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD53ftY/yUsvZFmbSQF35aJZQqcYDgG+Hgt2jQSH4fA=;
        b=Nc/bfKmRSUmZOhunkHH/u279aD038jdaCRvE4XSnKK4JJtclTi/Le7ZqIGu1cZLJhI
         V4IvpQxazgvdo+liwsDog44i4ftaXX5n4Nn8vDlkP5J5IQV4ejePHmjoOtBOQnpY50wp
         QzdHcdUObVfv0fLnLsOfEp1nRVC2zoarH8sD98DZWr8prHJsYj1K3taJGPpipC2eKGTl
         bjkbrNx8V/0ysFsdXXcP0rDpsZ2K62R2gZs7NUi5zwQ4BEYlw0tFadO4UlPQ7xcvZZfe
         /sPBTa4NdpUU/Nl6EpwjWyXrc1T5E8zyFwDMAVmbms/RjcKXddClos/uagM089HR2ZC6
         EqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358703; x=1701963503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD53ftY/yUsvZFmbSQF35aJZQqcYDgG+Hgt2jQSH4fA=;
        b=rjorptlOtbNi4pfM3sZ8h+y76LpCTHhtAonxm7pKYHJrNaSGPxT/2S+/kJT64OG8Rm
         4WCrg6cZuoKMCZ/aN+MgezEN5Jm8ST/3dxRqvzx5ncOWnqa1Xx6xpm0gixwoT3a7JuCf
         lQA/pd8N0LYF8V1l2jsH1g4tbImK2i0Vhdpd8McnNNBfdavIJ1/0PH0HWwhL3/b36/mT
         sK6kuasvZDH40xPi9hZvvYhlUIWs3mQ69dwEGFOeILyEZ2KQ6ORJGdbg5XLlWRf/sHBj
         ENmFBxdVQLPubtY1NUPpKW8guTLHlLs6JANZ5HL83HfKkMSa6BzSCFFcbJsG51oMX/k9
         1fSg==
X-Gm-Message-State: AOJu0Yy1YQUYLQscT/SVshFfgYW+FeBiNCNoxQWak242uLr6oncEVSug
	e1geaoAl6H2U2PqBS1zoc28=
X-Google-Smtp-Source: AGHT+IGr5SX9jWRJyNlzTzhL/+Qe4hyEpSvcjizSBmvGiziK+hPA6OPpzFTVE6mc1PCtxIAryW3BWA==
X-Received: by 2002:a05:6830:1412:b0:6d7:f8f6:5406 with SMTP id v18-20020a056830141200b006d7f8f65406mr23629246otp.0.1701358703108;
        Thu, 30 Nov 2023 07:38:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::4:edc5])
        by smtp.gmail.com with ESMTPSA id r8-20020a0c8d08000000b0067a18167533sm592780qvb.83.2023.11.30.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:38:22 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	Huan Yang <link@vivo.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Date: Thu, 30 Nov 2023 07:36:54 -0800
Message-Id: <20231130153658.527556-2-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130153658.527556-1-schatzberg.dan@gmail.com>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
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
 include/linux/swap.h |  3 ++-
 mm/memcontrol.c      | 55 +++++++++++++++++++++++++++++++++++---------
 mm/vmscan.c          | 13 +++++++++--
 3 files changed, 57 insertions(+), 14 deletions(-)

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


