Return-Path: <cgroups+bounces-982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F2C81A26D
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFA1C23421
	for <lists+cgroups@lfdr.de>; Wed, 20 Dec 2023 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11440BE7;
	Wed, 20 Dec 2023 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6CZhDbZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583445C00;
	Wed, 20 Dec 2023 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f6739d7acso6682886d6.1;
        Wed, 20 Dec 2023 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086032; x=1703690832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGeG3BQJs8KXUJq1DB8Qp/yk33MHWE5qrkTbzfRxpso=;
        b=B6CZhDbZTssf4dr4OT2r7iR0IoEynblvXqPPLCFPYid+uXotPw+21bK2ekzxE9t84N
         hCouCGQgwMQmObDMfRJX5JZDLy7KG8jp5HAjNrHFRuyclnaFqAmInY20wJoW+NsMqOLM
         WBQ+0m7Vhkf+PbRkHKjAxh7xjNmEaSq3nWnLHk2SvIy4CCtk2Ws3oYGkL01/Iq4k8Bg9
         rMAH8Ppy03a5fErrIGuZCdQslSBQdwdXaXmt8ja+m0kwONhtZsopZ2bJoaUh2VVtsVUj
         peaQ1scaOXkw4Y+9zu/tR14AK6YKXe2FuTHk0QMl24XDxyketBvwb43isBS3BjvszBGG
         a4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086032; x=1703690832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGeG3BQJs8KXUJq1DB8Qp/yk33MHWE5qrkTbzfRxpso=;
        b=QDEoBJaAvmkjSac7DWCKiOoHaq+iwfd/4EwF1pSr2UFjVJZxmaBhh9Um8tzfF9gf0J
         n71tbPkYZK7y2mEBCI1Xw4BpXqYEx7YJ4iE3F9XZNG1XqIhQqFL1gNGcSkGvsD24OC12
         dXnKld947SaWFGqLygOFgHFeM06Mn676ps4wAUVmgG0S/MVz5YRhc5VF9EfSlBaIYn1p
         eoSlpWxR4DXP/t1qVrxVH4KqjPdGeXr3C8lTwIrgHkFVs2Eb79CMtC7iFmO3q8QkJTx3
         1A3IQeNlAs6ub+cxt/da3j1Mv+ZMOU+wFj1GZ0hvRrU3JDzo4SLzGlygn8jTyWbH0+Hk
         Jimw==
X-Gm-Message-State: AOJu0YzvCyri1FzOYAXBwgw7mKWNzyuJjlXwdlHF8dhs5mSqXPp5jv8W
	0bjKebZu8iPID8QjaFWSTgQ=
X-Google-Smtp-Source: AGHT+IEzkCtuXKrCGnKuBmzDm+mPo6Gt/cgqwgYPQEwzS5DMjQVntJCFa2a9HakWaD1ykKsbxKhg2A==
X-Received: by 2002:a05:6214:1d0a:b0:67f:4c93:6f16 with SMTP id e10-20020a0562141d0a00b0067f4c936f16mr4682609qvd.27.1703086032331;
        Wed, 20 Dec 2023 07:27:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:1124])
        by smtp.gmail.com with ESMTPSA id m14-20020a0ce8ce000000b0067f19f17629sm4991299qvo.82.2023.12.20.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:27:12 -0800 (PST)
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
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yue Zhao <findns94@gmail.com>
Subject: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Date: Wed, 20 Dec 2023 07:26:51 -0800
Message-Id: <20231220152653.3273778-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
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
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
 include/linux/swap.h                    |  3 +-
 mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
 mm/vmscan.c                             | 13 +++++-
 4 files changed, 69 insertions(+), 21 deletions(-)

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
index d91963e2d47f..aa5666842c49 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -92,6 +92,9 @@ struct scan_control {
 	unsigned long	anon_cost;
 	unsigned long	file_cost;
 
+	/* Swappiness value for reclaim. NULL will fall back to per-memcg/global value */
+	int *swappiness;
+
 	/* Can active folios be deactivated as part of reclaim? */
 #define DEACTIVATE_ANON 1
 #define DEACTIVATE_FILE 2
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
 
@@ -6463,12 +6470,14 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
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
+		.swappiness = swappiness,
 		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
 				(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK),
 		.reclaim_idx = MAX_NR_ZONES - 1,
-- 
2.39.3


