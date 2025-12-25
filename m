Return-Path: <cgroups+bounces-12735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9DCDE29E
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 162113004F12
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DB1E3DED;
	Thu, 25 Dec 2025 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oRUyGsqf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428C2C032E
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766705010; cv=none; b=IQL5z6DnvPr2Oj0mdpbgwL+jjxjwXA6j2XAKh2wrEsUH03S3V181rrogG3jWqRjlWaaUXg7KiPzMMzYtwnhMSBa9rnB6QLhmHCpcinsCYlSS6QkWBJ4cCMsCWx6PqgLChIut6D5WiyLahLqGRW1cVg7ZJZ0b7MAw1xwm85zLf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766705010; c=relaxed/simple;
	bh=UuruIwdlaQWu4MKY5wBKcA32oRVtj1/hbo/JH66S8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/8VVo0u801obLzuwty0jZzHMxwJvNTqdHrkJCDUH8oaMc4oMxboYftORcC88Pre3QUillO84TRM4hWEcr/a/D4205WiwJOqFuFJx9mtB5avZNiOUIrMUj1k8G0Ud7v4CW2C9JJzIu0IqonfGngryV2CfA42qTf2wlm8cCpb1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oRUyGsqf; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766705007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ipsZ9pFNe593ot4ifmspllIFtIPZMuP1LeaIWTARIM=;
	b=oRUyGsqfO8oIu0XGd1vMKX/zDnb+h/rLJ2bnmz5ROXbpXWcqrk1YtqliVCg/prB5bSjhN+
	w9UrtORb08uds/G7Wk0VYMylP0zhakfDgUnt4d5VYs3HbRsKCYHo2q/BJCltTzf9lyK251
	VobCXnbIvW3KJuSDm0yEZWfPIvuFzRM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Date: Thu, 25 Dec 2025 15:21:16 -0800
Message-ID: <20251225232116.294540-9-shakeel.butt@linux.dev>
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename mem_cgroup_ino() to mem_cgroup_id() and mem_cgroup_get_from_ino()
to mem_cgroup_get_from_id(). These functions now use cgroup IDs (from
cgroup_id()) rather than inode numbers, so the names should reflect that.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  8 ++++----
 mm/damon/core.c            |  2 +-
 mm/damon/ops-common.c      |  2 +-
 mm/damon/sysfs-schemes.c   |  2 +-
 mm/memcontrol.c            |  2 +-
 mm/shrinker_debug.c        | 10 +++++-----
 mm/vmscan.c                |  6 +++---
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3e7d69020b39..5a1161cadb8d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -830,12 +830,12 @@ static inline unsigned short mem_cgroup_private_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id);
 
-static inline u64 mem_cgroup_ino(struct mem_cgroup *memcg)
+static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return memcg ? cgroup_id(memcg->css.cgroup) : 0;
 }
 
-struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino);
+struct mem_cgroup *mem_cgroup_get_from_id(u64 ino);
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1288,12 +1288,12 @@ static inline struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return NULL;
 }
 
-static inline u64 mem_cgroup_ino(struct mem_cgroup *memcg)
+static inline u64 mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return 0;
 }
 
-static inline struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
+static inline struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
 {
 	return NULL;
 }
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 23c44811ff7f..a2513db59aee 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2065,7 +2065,7 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
-	memcg = mem_cgroup_get_from_ino(goal->memcg_id);
+	memcg = mem_cgroup_get_from_id(goal->memcg_id);
 	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 			return 0;
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index dd81db95f901..a218d9922234 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -274,7 +274,7 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio)
 		if (!memcg)
 			matched = false;
 		else
-			matched = filter->memcg_id == mem_cgroup_ino(memcg);
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
 	case DAMOS_FILTER_TYPE_YOUNG:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 79aa917ab3c0..3beb4456aa51 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2511,7 +2511,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
 		if (!mem_cgroup_online(memcg))
 			continue;
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
-			*id = mem_cgroup_ino(memcg);
+			*id = mem_cgroup_id(memcg);
 			found = true;
 			break;
 		}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ede39dde05df..5b2925a68832 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3615,7 +3615,7 @@ struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return xa_load(&mem_cgroup_private_ids, id);
 }
 
-struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
+struct mem_cgroup *mem_cgroup_get_from_id(u64 ino)
 {
 	struct cgroup *cgrp;
 	struct cgroup_subsys_state *css;
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 7ef16a0b2959..affa64437302 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -70,7 +70,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 					       memcg_aware ? memcg : NULL,
 					       count_per_node);
 		if (total) {
-			seq_printf(m, "%llu", mem_cgroup_ino(memcg));
+			seq_printf(m, "%llu", mem_cgroup_id(memcg));
 			for_each_node(nid)
 				seq_printf(m, " %lu", count_per_node[nid]);
 			seq_putc(m, '\n');
@@ -107,7 +107,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 {
 	struct shrinker *shrinker = file->private_data;
 	unsigned long nr_to_scan = 0, read_len;
-	u64 ino;
+	u64 id;
 	struct shrink_control sc = {
 		.gfp_mask = GFP_KERNEL,
 	};
@@ -120,7 +120,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EFAULT;
 	kbuf[read_len] = '\0';
 
-	if (sscanf(kbuf, "%llu %d %lu", &ino, &nid, &nr_to_scan) != 3)
+	if (sscanf(kbuf, "%llu %d %lu", &id, &nid, &nr_to_scan) != 3)
 		return -EINVAL;
 
 	if (nid < 0 || nid >= nr_node_ids)
@@ -130,7 +130,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return size;
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		memcg = mem_cgroup_get_from_ino(ino);
+		memcg = mem_cgroup_get_from_id(id);
 		if (!memcg)
 			return -ENOENT;
 
@@ -138,7 +138,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 			mem_cgroup_put(memcg);
 			return -ENOENT;
 		}
-	} else if (ino != 0) {
+	} else if (id != 0) {
 		return -EINVAL;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d78043c7e4af..9ad2c2f06bfa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5426,7 +5426,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 		if (memcg)
 			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
 #endif
-		seq_printf(m, "memcg %llu %s\n", mem_cgroup_ino(memcg), path);
+		seq_printf(m, "memcg %llu %s\n", mem_cgroup_id(memcg), path);
 	}
 
 	seq_printf(m, " node %5d\n", nid);
@@ -5522,12 +5522,12 @@ static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
-		memcg = mem_cgroup_get_from_ino(memcg_id);
+		memcg = mem_cgroup_get_from_id(memcg_id);
 		if (!memcg)
 			return -EINVAL;
 	}
 
-	if (memcg_id != mem_cgroup_ino(memcg))
+	if (memcg_id != mem_cgroup_id(memcg))
 		goto done;
 
 	sc->target_mem_cgroup = memcg;
-- 
2.47.3


