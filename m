Return-Path: <cgroups+bounces-13245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF41D23FCF
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 11:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2686830869C7
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016336C0AA;
	Thu, 15 Jan 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wjil01Sl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52936BCDC
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473750; cv=none; b=BA4kI7y4sS3+R0F8ydEtE3pEK5gEo/f3GNu1W1q5Yd280dh5Dl3af/xV6ExkzYn3EhA0EJ6QLm2rhGRQJsVYIhH8C0N61a+9VQoDzgG6c2T6kznweSPUjW3JsQG5b73kRTk6shpgsLaiTeXb+WtqhRxLLhTtq84rzmUCLwMyDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473750; c=relaxed/simple;
	bh=iIesyBXtdQ65YAAFaKdmM1zXogdCBJafql7Y94TavGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXR+Vzvh4D+fg0RR4fvM2PMix1od3GNsmtfDq7mbpPkJNXfl+dfD20wrygf5RI8EOK/M2BljF5dl9IbeBCFdyHulqqgAnATIBFLQ6gLdh5V5a0gJTTw41PvsSrv1Xl5ZA2PT3+5KiHk5IoLHAOTlx/AmhLNwYFAi53mRVfRg6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wjil01Sl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768473736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35UwOuLDsnd+wCybJPYIumYnuCDYEBE4kSwMd4EKtLc=;
	b=Wjil01SlR/oO7ddWVF49DyCoOjfKHh07SUGNGDI5HCIsrjvSeoqifmv9AxWbx4+r/9Accg
	xm/7eIh6IpHq1vGFGhm+D736fbxhaDbjIzkk4sdm67r6ezQZNKn6v6uQFw4duXQqns8ZX+
	5kRtoV8q19bi9FkiFYCz+UndmsiMrCc=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix lruvec_stats->state_local reparenting
Date: Thu, 15 Jan 2026 18:41:38 +0800
Message-ID: <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
In-Reply-To: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |  2 --
 mm/memcontrol-v1.c         |  8 --------
 mm/memcontrol-v1.h         |  5 ++++-
 mm/memcontrol.c            | 19 ++++++++-----------
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1fe554eec1e25..e0b84b109b7ac 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -944,8 +944,6 @@ bool memcg_vm_event_item_valid(enum vm_event_item idx);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
-void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
-				       struct mem_cgroup *parent, int idx);
 
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 03b924920d6a5..daf9bad8c45ea 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1909,14 +1909,6 @@ void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *pa
 		reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
 }
 
-void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
-		reparent_memcg_lruvec_state_local(memcg, parent, memcg1_stats[i]);
-}
-
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	unsigned long memory, memsw;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 45528195d3578..5b1188f3d4173 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -75,7 +75,6 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
-void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
@@ -116,6 +115,10 @@ static inline void memcg1_uncharge_batch(struct mem_cgroup *memcg,
 
 static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
 
+static inline void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+}
+
 static inline void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages) {}
 static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg) { return false; }
 static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7333a37830051..b7b35143d4d2d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -225,13 +225,13 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
 	return objcg;
 }
 
-#ifdef CONFIG_MEMCG_V1
+static void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+					      struct mem_cgroup *parent, int idx);
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
 
 static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
-	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return;
+	int i;
 
 	synchronize_rcu();
 
@@ -239,13 +239,10 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
 
 	/* The following counts are all non-hierarchical and need to be reparented. */
 	reparent_memcg1_state_local(memcg, parent);
-	reparent_memcg1_lruvec_state_local(memcg, parent);
-}
-#else
-static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
-{
+
+	for (i = 0; i < NR_LRU_LISTS; i++)
+		reparent_memcg_lruvec_state_local(memcg, parent, i);
 }
-#endif
 
 static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
@@ -510,8 +507,8 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
-				       struct mem_cgroup *parent, int idx)
+static void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+					      struct mem_cgroup *parent, int idx)
 {
 	int i = memcg_stats_index(idx);
 	int nid;
-- 
2.20.1


