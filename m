Return-Path: <cgroups+bounces-12731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92580CDE28C
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 555BB30019EA
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0E1DF736;
	Thu, 25 Dec 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wylAyIn8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B32C11F5
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704915; cv=none; b=An2dFzEkHsTvhBcIWv2jEMdALemSlhc1QNt+GV/blafrPeLj2iGzRBl1LjCUpUnDWu6KRu/V0LVOfR3U7O56s7sh4Y0AUINOre6HEb40/rXV76B/vnBWwWA+bGVZ+lFtVYGxOtmNWJbbkbIHaugq+9+uJ4UVve1DRWzZHKxcdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704915; c=relaxed/simple;
	bh=el8HAB0sOOLSau6RTNfayIxRkLKv+Hwe1XlsZYDYSnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwhxAq9rI2TwtIfclmA8qwQufkW5B0r6Y5O8C8M14FSniu7FJC6kh9t0BhjxUrc/lJdclMz4Aug3NtAdeXBUMVF9w/U5d8Rczy0ooScZHz2YsACQTshSTp/HFvBCFB910t5/OSrsR671hVEpJ++zffYfy9Pk+vBgGKN6jWglznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wylAyIn8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHLUPExoPKnJu0oj7221nxhPbwe4fH4Njx6PIRBvWXw=;
	b=wylAyIn8SEF0kBQem+PiUWjgcrj8RTvksgBmWjmdsjlPCewjVoa5/4qRUwLPRZOatWv5DT
	PJJCCmjYTPrTF01gdMkY9TnG6ZoaVWfWaH6T+4WDk/wsvXmE1VTbhbXqBWcdN2+nYpJN7G
	h8VaIoHLozD6gKU1RUvpW2Aqci9G5P4=
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
Subject: [PATCH 4/8] memcg: use cgroup_id() instead of cgroup_ino() for memcg ID
Date: Thu, 25 Dec 2025 15:21:12 -0800
Message-ID: <20251225232116.294540-5-shakeel.butt@linux.dev>
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

Switch mem_cgroup_ino() from using cgroup_ino() to cgroup_id(). The
cgroup_ino() returns the kernfs inode number while cgroup_id() returns
the kernfs node ID. For 64-bit systems, they are the same. Also
cgroup_get_from_id() expects 64-bit node ID which is called by
mem_cgroup_get_from_ino().

Change the type from unsigned long to u64 to match cgroup_id()'s return
type, and update the format specifiers accordingly.

Note that the names mem_cgroup_ino() and mem_cgroup_get_from_ino() are
now misnomers since they deal with cgroup IDs rather than inode numbers.
A follow-up patch will rename them.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 10 +++++-----
 mm/memcontrol.c            |  2 +-
 mm/shrinker_debug.c        |  7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 77f32be26ea8..c823150ec288 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -836,12 +836,12 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
-static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+static inline u64 mem_cgroup_ino(struct mem_cgroup *memcg)
 {
-	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
+	return memcg ? cgroup_id(memcg->css.cgroup) : 0;
 }
 
-struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
+struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino);
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1306,12 +1306,12 @@ static inline struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return NULL;
 }
 
-static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+static inline u64 mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return 0;
 }
 
-static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+static inline struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
 {
 	return NULL;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 92beb74482fa..1ff2f9bd820c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3620,7 +3620,7 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return mem_cgroup_from_private_id(id);
 }
 
-struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+struct mem_cgroup *mem_cgroup_get_from_ino(u64 ino)
 {
 	struct cgroup *cgrp;
 	struct cgroup_subsys_state *css;
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 8aaeb8f5c3af..7ef16a0b2959 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -70,7 +70,7 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 					       memcg_aware ? memcg : NULL,
 					       count_per_node);
 		if (total) {
-			seq_printf(m, "%lu", mem_cgroup_ino(memcg));
+			seq_printf(m, "%llu", mem_cgroup_ino(memcg));
 			for_each_node(nid)
 				seq_printf(m, " %lu", count_per_node[nid]);
 			seq_putc(m, '\n');
@@ -106,7 +106,8 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 					   size_t size, loff_t *pos)
 {
 	struct shrinker *shrinker = file->private_data;
-	unsigned long nr_to_scan = 0, ino, read_len;
+	unsigned long nr_to_scan = 0, read_len;
+	u64 ino;
 	struct shrink_control sc = {
 		.gfp_mask = GFP_KERNEL,
 	};
@@ -119,7 +120,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EFAULT;
 	kbuf[read_len] = '\0';
 
-	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 3)
+	if (sscanf(kbuf, "%llu %d %lu", &ino, &nid, &nr_to_scan) != 3)
 		return -EINVAL;
 
 	if (nid < 0 || nid >= nr_node_ids)
-- 
2.47.3


