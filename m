Return-Path: <cgroups+bounces-12732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB63CCDE2A4
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695623011A5B
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3102C11CA;
	Thu, 25 Dec 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZjyiY2h"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E901DF736
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704922; cv=none; b=mtBLXH73mTgqiVEr9vQKpxhe7P6UWADxK4SGx8zT634ryHYtqiIDfvwI0osITz+YuPNTnWSogi4JKMplIy46bCx/MVOXx+WJN8l/Py1iu7VW1ecaDu0BcyxVz11D4x2jK2SvMAZ9mlbwaFGMBHu1rk5kgW827n7B6c9D+S12lDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704922; c=relaxed/simple;
	bh=9D3i4WtWKzPbxlmFJZLWRQmSpACn15plQ0XMaWdeqbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKDQqx/sFfBgnjto4Xj2P9SBTLWwVkXjm3KfcDL0exis8wvAoz5OfAQaRoSZdqAJ0hfeBBYbDHhYYC5rs+eabLvMalkqw5Pq/jJwhBcXeEs2NGoH38hevrX9lliW1sQTxdY786GH4dsE6GTeGnT6AQbwkQaIPVJ+QaWYlLoHrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZjyiY2h; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVIJLlIoVbyUjgLSsqavcZQWB6x8jtRLfTLva9jt/vw=;
	b=fZjyiY2hlAllu5kswXjcYSVUkUmBMWZCRsfjEqoVAjBblu5dGNfXelxww+eCnEshWI70uw
	b/2xwUsmF3rHJrEjUhxXwBBbuAWCNXmH26YcV+Wfwc6l2oZEEZmcISR5N+INT3oxtY27Bp
	vkF++kZgRyutqRzDdIJyUXsiWdhq5XQ=
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
Subject: [PATCH 5/8] mm/damon: use cgroup ID instead of private memcg ID
Date: Thu, 25 Dec 2025 15:21:13 -0800
Message-ID: <20251225232116.294540-6-shakeel.butt@linux.dev>
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

DAMON was using the internal private memcg ID which is meant for
tracking kernel objects that outlive their cgroup. Switch to using the
public cgroup ID instead.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/damon.h    | 4 ++--
 mm/damon/core.c          | 7 ++-----
 mm/damon/ops-common.c    | 2 +-
 mm/damon/sysfs-schemes.c | 8 ++++----
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a67292a2f09d..650e7ecfa32b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -203,7 +203,7 @@ struct damos_quota_goal {
 		u64 last_psi_total;
 		struct {
 			int nid;
-			unsigned short memcg_id;
+			u64 memcg_id;
 		};
 	};
 	struct list_head list;
@@ -419,7 +419,7 @@ struct damos_filter {
 	bool matching;
 	bool allow;
 	union {
-		unsigned short memcg_id;
+		u64 memcg_id;
 		struct damon_addr_range addr_range;
 		int target_idx;
 		struct damon_size_range sz_range;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2d3e8006db50..23c44811ff7f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2065,16 +2065,13 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
-	rcu_read_lock();
-	memcg = mem_cgroup_from_id(goal->memcg_id);
-	if (!memcg || !mem_cgroup_tryget(memcg)) {
-		rcu_read_unlock();
+	memcg = mem_cgroup_get_from_ino(goal->memcg_id);
+	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 			return 0;
 		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
 			return 10000;
 	}
-	rcu_read_unlock();
 
 	mem_cgroup_flush_stats(memcg);
 	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index a218d9922234..dd81db95f901 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -274,7 +274,7 @@ bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio)
 		if (!memcg)
 			matched = false;
 		else
-			matched = filter->memcg_id == mem_cgroup_id(memcg);
+			matched = filter->memcg_id == mem_cgroup_ino(memcg);
 		rcu_read_unlock();
 		break;
 	case DAMOS_FILTER_TYPE_YOUNG:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e198234f0763..79aa917ab3c0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2492,7 +2492,7 @@ static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
 	return false;
 }
 
-static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
+static int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
 {
 	struct mem_cgroup *memcg;
 	char *path;
@@ -2507,11 +2507,11 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 
 	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
 			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
-		/* skip removed memcg */
-		if (!mem_cgroup_id(memcg))
+		/* skip offlined memcg */
+		if (!mem_cgroup_online(memcg))
 			continue;
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
-			*id = mem_cgroup_id(memcg);
+			*id = mem_cgroup_ino(memcg);
 			found = true;
 			break;
 		}
-- 
2.47.3


