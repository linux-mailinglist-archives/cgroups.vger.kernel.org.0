Return-Path: <cgroups+bounces-12733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 663E6CDE2A7
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEF7300796C
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0832561A2;
	Thu, 25 Dec 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpuglBuc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29FF292918
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704951; cv=none; b=AGrAkD8SevQzeUhg6muf+/mf85ONKyBTLnIDbuFbUGdyuxsJslTgJjAQ46U03YYvhUvEBrw2ophbqsrUtCGKSikePjET54nvQrlh9nfcw+u+I45hwMk+o/3/WS/+K4cB3bW774bzBYGa27xLWfQSiHpDZPy6XoaIxdSxQRKGsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704951; c=relaxed/simple;
	bh=6tIArGlSqpof+0rDw58wC/1JKZYFEvHKklYcbVdtYO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIgE0jr0fdvBxHFihxYZ8Bhtv7C5zUjYLdy+C/xgxSvBB5qD8XSzfkebKpuExBHthWFOQB7zX+asI6WKFrHpqHazB/hEcQ7eR5FR/bU0d8e41OvAGdzxDZqqUSyHFu4KOGwzkOy/5Nv24NGcL0DrtqYYSOO93EZOAtKwJLdaC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpuglBuc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Emeg4oe9Wf0hyjEB6RFxn5Oy5f9oafLtHS4W3VCookU=;
	b=lpuglBucsWYRiDV/OnmxWeINhdtMYGc0NTEFlwikXxPSs0ejEd4LObkAP9Ac3BAHuc+Fvd
	Nztz/FLx82sK4xM2VUmg1+MA78XKQUDuQTQFd7WgwRQRM9JF5YL33GsHMO0B+BFsWDHuL3
	ru71F8vValtJC/97v4Cc466P12Hpbzw=
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
Subject: [PATCH 6/8] mm/vmscan: use cgroup ID instead of private memcg ID in lru_gen interface
Date: Thu, 25 Dec 2025 15:21:14 -0800
Message-ID: <20251225232116.294540-7-shakeel.butt@linux.dev>
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

The LRU gen debugfs interface was using the internal private memcg ID
which is meant for tracking kernel objects that outlive their cgroup.
Switch to using the public cgroup ID instead.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmscan.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4b308a2f9ad..d78043c7e4af 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5426,7 +5426,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 		if (memcg)
 			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
 #endif
-		seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg), path);
+		seq_printf(m, "memcg %llu %s\n", mem_cgroup_ino(memcg), path);
 	}
 
 	seq_printf(m, " node %5d\n", nid);
@@ -5511,7 +5511,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 	return -EINTR;
 }
 
-static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
+static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 		   struct scan_control *sc, int swappiness, unsigned long opt)
 {
 	struct lruvec *lruvec;
@@ -5522,19 +5522,12 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
-		rcu_read_lock();
-
-		memcg = mem_cgroup_from_id(memcg_id);
-		if (!mem_cgroup_tryget(memcg))
-			memcg = NULL;
-
-		rcu_read_unlock();
-
+		memcg = mem_cgroup_get_from_ino(memcg_id);
 		if (!memcg)
 			return -EINVAL;
 	}
 
-	if (memcg_id != mem_cgroup_id(memcg))
+	if (memcg_id != mem_cgroup_ino(memcg))
 		goto done;
 
 	sc->target_mem_cgroup = memcg;
@@ -5601,7 +5594,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		int n;
 		int end;
 		char cmd, swap_string[5];
-		unsigned int memcg_id;
+		u64 memcg_id;
 		unsigned int nid;
 		unsigned long seq;
 		unsigned int swappiness;
@@ -5611,7 +5604,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		if (!*cur)
 			continue;
 
-		n = sscanf(cur, "%c %u %u %lu %n %4s %n %lu %n", &cmd, &memcg_id, &nid,
+		n = sscanf(cur, "%c %llu %u %lu %n %4s %n %lu %n", &cmd, &memcg_id, &nid,
 			   &seq, &end, swap_string, &end, &opt, &end);
 		if (n < 4 || cur[end]) {
 			err = -EINVAL;
-- 
2.47.3


