Return-Path: <cgroups+bounces-1062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09B823183
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D931F24801
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B71BDF0;
	Wed,  3 Jan 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAK4DpB/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F81C6B6;
	Wed,  3 Jan 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2041c292da8so5611787fac.3;
        Wed, 03 Jan 2024 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300560; x=1704905360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3Trd70tjvozyYFyAqV83nWEjrGIqqcGlRP9h5UvVDg=;
        b=PAK4DpB/rykOxGRvha5MOOJ6NcjBGXrZwE8v5pWRrTS8xOoRECwUZ9CwdKIqhx8rAo
         aRFxd8JO3FsZsZd8GXpCneb3fbDKJ/h+6lth5HwhDlnHE2vjQz51CcuN4JRxYKtnyzFf
         ESXB/tsyj3Q3NCww3leAs7HAjz7nStV9OVc+xdJ1I97HGrobARwgETaSvnqYj8t626Z3
         LRXBDIR9r/J8jwPEJS3uJrAeHQQGVIOUTEDUYZjg57hpN/0cQVXRd5gSa0xSmrXYDPee
         QlrpEgQTI/G/wgHFaGgSzx5a/IWESjAJ+LkzpprEid0xKAAuRx0DRTj3+/NxgKpJMePZ
         J6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300560; x=1704905360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3Trd70tjvozyYFyAqV83nWEjrGIqqcGlRP9h5UvVDg=;
        b=roDRAGh0NKZOIB57xSZzmezCjrl2za+LZ04catF8dvup76dmYuiPuus55GS0z8grYh
         ZFuFUd0mkG7czF27b9JqcsY393On94RjSxB1ulb+D/DPWW/RiROBYbjXiQhHRPqtIerj
         6jEmNKozriOhuJcboPgJLVrL5MzpPpcyaVRlwQu9rjp8c1WmRduQQrsBVSpvObgFc/Js
         VkQoO63WdjljcUH2u3ZODNjbtR3tnVMY8qbNwBg3RDYj/XSNGQRLFExkVvunTy7aU8rV
         s+hJU8xO9cjukOpF8ii3tpa3uNHafNPGPZiQo2aXHSdqh+4ROWWIMSA49toaXjdMNJxh
         6qYg==
X-Gm-Message-State: AOJu0YxnTgmFyZjux+mxE0DfppJii004e1QwqzDrJrhF4RlKY5j4ZTAR
	hTsUss45m1GIi1pj2oJjo6QmaH2mI+bv8w==
X-Google-Smtp-Source: AGHT+IGWRB8L2IIvPf9EnZ4lUQJp6LGFWjdNsZAx9VXs2gk8qcsXnGn53Hz5bzHQNB+7UwxdKCkwhQ==
X-Received: by 2002:a05:6870:63a0:b0:204:4926:1824 with SMTP id t32-20020a05687063a000b0020449261824mr16093129oap.80.1704300560221;
        Wed, 03 Jan 2024 08:49:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:fcab])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b0077d84f46d65sm10296915qkp.37.2024.01.03.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:49:19 -0800 (PST)
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Chris Li <chrisl@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
Date: Wed,  3 Jan 2024 08:48:37 -0800
Message-Id: <20240103164841.2800183-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
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

Userspace proactive reclaimers use the memory.reclaim interface to
trigger reclaim. The memory.reclaim interface does not allow for any way
to effect the balance of file vs anon during proactive reclaim. The only
approach is to adjust the vm.swappiness setting. However, there are a
few reasons we look to control the balance of file vs anon during
proactive reclaim, separately from reactive reclaim:

* Swapout should be limited to manage SSD write endurance. In near-OOM
situations we are fine with lots of swap-out to avoid OOMs. As these are
typically rare events, they have relatively little impact on write
endurance. However, proactive reclaim runs continuously and so its
impact on SSD write endurance is more significant. Therefore it is
desireable to control swap-out for proactive reclaim separately from
reactive reclaim

* Some userspace OOM killers like systemd-oomd[1] support OOM killing on
swap exhaustion. This makes sense if the swap exhaustion is triggered
due to reactive reclaim but less so if it is triggered due to proactive
reclaim (e.g. one could see OOMs when free memory is ample but anon is
just particularly cold). Therefore, it's desireable to have proactive
reclaim reduce or stop swap-out before the threshold at which OOM
killing occurs.

In the case of Meta's Senpai proactive reclaimer, we adjust
vm.swappiness before writes to memory.reclaim[2]. This has been in
production for nearly two years and has addressed our needs to control
proactive vs reactive reclaim behavior but is still not ideal for a
number of reasons:

* vm.swappiness is a global setting, adjusting it can race/interfere
with other system administration that wishes to control vm.swappiness.
In our case, we need to disable Senpai before adjusting vm.swappiness.

* vm.swappiness is stateful - so a crash or restart of Senpai can leave
a misconfigured setting. This requires some additional management to
record the "desired" setting and ensure Senpai always adjusts to it.

With this patch, we avoid these downsides of adjusting vm.swappiness
globally.

[1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
[2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/Senpai.cpp#L585-L598

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
 mm/vmscan.c                             | 25 +++++++++--
 4 files changed, 80 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..ee42f74e0765 100644
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
@@ -1304,6 +1297,17 @@ PAGE_SIZE multiple when read back.
 	This means that the networking layer will not adapt based on
 	reclaim induced by memory.reclaim.
 
+The following nested keys are defined.
+
+	  ==========            ================================
+	  swappiness            Swappiness value to reclaim with
+	  ==========            ================================
+
+	Specifying a swappiness value instructs the kernel to perform
+	the reclaim with that swappiness value. Note that this has the
+	same semantics as vm.swappiness applied to memcg reclaim with
+	all the existing limitations and potential future extensions.
+
   memory.peak
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e2ab76c25b4a..8afdec40efe3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -412,7 +412,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
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
index fbe9f02dd206..6d627a754851 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -52,6 +52,7 @@
 #include <linux/sort.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/parser.h>
 #include <linux/vmpressure.h>
 #include <linux/memremap.h>
 #include <linux/mm_inline.h>
@@ -2449,7 +2450,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP);
+							MEMCG_RECLAIM_MAY_SWAP,
+							NULL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2740,7 +2742,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options);
+						    gfp_mask, reclaim_options, NULL);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -3660,7 +3662,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
+					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -3774,7 +3776,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP))
+						  MEMCG_RECLAIM_MAY_SWAP, NULL))
 			nr_retries--;
 	}
 
@@ -6720,7 +6722,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -6769,7 +6771,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
 				nr_reclaims--;
 			continue;
 		}
@@ -6895,19 +6897,50 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
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
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
+	int swappiness = -1;
 	unsigned int reclaim_options;
-	int err;
+	char *old_buf, *start;
+	substring_t args[MAX_OPT_ARGS];
 
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
@@ -6926,7 +6959,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
 					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+					GFP_KERNEL, reclaim_options,
+					swappiness == -1 ? NULL : &swappiness);
 
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d91963e2d47f..394e0dd46b2e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -92,6 +92,11 @@ struct scan_control {
 	unsigned long	anon_cost;
 	unsigned long	file_cost;
 
+#ifdef CONFIG_MEMCG
+	/* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
+	int *proactive_swappiness;
+#endif
+
 	/* Can active folios be deactivated as part of reclaim? */
 #define DEACTIVATE_ANON 1
 #define DEACTIVATE_FILE 2
@@ -227,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #endif
 	return false;
 }
+
+static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
+{
+	if (sc->proactive && sc->proactive_swappiness)
+		return *sc->proactive_swappiness;
+	return mem_cgroup_swappiness(memcg);
+}
 #else
 static bool cgroup_reclaim(struct scan_control *sc)
 {
@@ -242,6 +254,11 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
 }
+
+static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
+{
+	return READ_ONCE(vm_swappiness);
+}
 #endif
 
 static void set_task_reclaim_state(struct task_struct *task,
@@ -2327,7 +2344,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
-	int swappiness = mem_cgroup_swappiness(memcg);
+	int swappiness = sc_swappiness(sc, memcg);
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -2608,7 +2625,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
-	return mem_cgroup_swappiness(memcg);
+	return sc_swappiness(sc, memcg);
 }
 
 static int get_nr_gens(struct lruvec *lruvec, int type)
@@ -6463,12 +6480,14 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   unsigned int reclaim_options)
+					   unsigned int reclaim_options,
+					   int *swappiness)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
+		.proactive_swappiness = swappiness,
 		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
 				(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK),
 		.reclaim_idx = MAX_NR_ZONES - 1,
-- 
2.39.3


