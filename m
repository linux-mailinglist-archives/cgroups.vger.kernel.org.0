Return-Path: <cgroups+bounces-6741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD3A49296
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC931888D57
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF21D9320;
	Fri, 28 Feb 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KVQzTsVV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F891D5CE8
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729520; cv=none; b=dOJNDvCrLB6Ym2HkK0GoLVKIhyGUsd6oiQiN5aZDni73+0HoUhw7oYCkFgeWUOYj5S8pkyn+ZsflSsBGoHRGSOulBU1yPe+hTLSa8wdscfDQ7DfRAbfnWNNMCHOPrJXg1IJwUcdfzzfgeKBqtQwPZXuYjxxGtmkvdWQb8pyqVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729520; c=relaxed/simple;
	bh=zA6PXsDktXbXxM6E2AG0NGTa/L70w9OXygFrIpQLjFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFtS15+gBLmUkfF8ueh5NYw7rEm7x/kWbh0mi7CiIVLM1F1TCoa713Q11eaCef94jMJ1GPgDlSDhQce2zx8hj6zcLYnhtBS6n2q4xgJnW+pTMBsFkXEOO9xjQe/1Isg9djvKcc0hR5yBGjrzEQsQbtKkNhkGSO6WBLmnwI6VClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KVQzTsVV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740729517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgR5BcL3MvfMipx+x4bMFzdCySvKkv9t6LJsU3AWxSI=;
	b=KVQzTsVVF++szQiHnUrzJKSOalzgMh4NejwrixnLYUQE8tb2MjSfqWnQ+d2+qFkNoVDAT3
	I84I69ippat79QUZDAFdLwExq1udUPcG/9iMdGZ65f8pjfBnsMXVjxE4uNRuUpXvaxUt94
	59CEZ1R0Z9C1uw+1ODGG9YuchIaZMT8=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/3] page_counter: track failcnt only for legacy cgroups
Date: Thu, 27 Feb 2025 23:58:07 -0800
Message-ID: <20250228075808.207484-3-shakeel.butt@linux.dev>
In-Reply-To: <20250228075808.207484-1-shakeel.butt@linux.dev>
References: <20250228075808.207484-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently page_counter tracks failcnt for counters used by v1 and v2
controllers. However failcnt is only exported for v1 deployment and thus
there is no need to maintain it in v2. The oom report does expose
failcnt for memory and swap in v2 but v2 already maintains MEMCG_MAX and
MEMCG_SWAP_MAX event counters which can be used.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/page_counter.h |  4 +++-
 mm/hugetlb_cgroup.c          | 31 ++++++++++++++-----------------
 mm/memcontrol.c              | 12 ++++++++++--
 mm/page_counter.c            |  4 +++-
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 46406f3fe34d..e4bd8fd427be 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -28,12 +28,13 @@ struct page_counter {
 	unsigned long watermark;
 	/* Latest cg2 reset watermark */
 	unsigned long local_watermark;
-	unsigned long failcnt;
+	unsigned long failcnt; /* v1-only field */
 
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
 
 	bool protection_support;
+	bool track_failcnt;
 	unsigned long min;
 	unsigned long low;
 	unsigned long high;
@@ -58,6 +59,7 @@ static inline void page_counter_init(struct page_counter *counter,
 	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
 	counter->protection_support = protection_support;
+	counter->track_failcnt = false;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index bb9578bd99f9..58e895f3899a 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -101,10 +101,9 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;
 
 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *fault_parent = NULL;
-		struct page_counter *rsvd_parent = NULL;
+		struct page_counter *fault, *fault_parent = NULL;
+		struct page_counter *rsvd, *rsvd_parent = NULL;
 		unsigned long limit;
-		int ret;
 
 		if (parent_h_cgroup) {
 			fault_parent = hugetlb_cgroup_counter_from_cgroup(
@@ -112,24 +111,22 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 			rsvd_parent = hugetlb_cgroup_counter_from_cgroup_rsvd(
 				parent_h_cgroup, idx);
 		}
-		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
-								     idx),
-				  fault_parent, false);
-		page_counter_init(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			rsvd_parent, false);
+		fault = hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx);
+		rsvd = hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx);
+
+		page_counter_init(fault, fault_parent, false);
+		page_counter_init(rsvd, rsvd_parent, false);
+
+		if (!cgroup_subsys_on_dfl(hugetlb_cgrp_subsys)) {
+			fault->track_failcnt = true;
+			rsvd->track_failcnt = true;
+		}
 
 		limit = round_down(PAGE_COUNTER_MAX,
 				   pages_per_huge_page(&hstates[idx]));
 
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
-			limit);
-		VM_BUG_ON(ret);
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			limit);
-		VM_BUG_ON(ret);
+		VM_BUG_ON(page_counter_set_max(fault, limit));
+		VM_BUG_ON(page_counter_set_max(rsvd, limit));
 	}
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36b2dfbc86c0..030fadbd5bf2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1572,16 +1572,23 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	/* Use static buffer, for the caller is holding oom_lock. */
 	static char buf[SEQ_BUF_SIZE];
 	struct seq_buf s;
+	unsigned long memory_failcnt;
 
 	lockdep_assert_held(&oom_lock);
 
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		memory_failcnt = atomic_long_read(&memcg->memory_events[MEMCG_MAX]);
+	else
+		memory_failcnt = memcg->memory.failcnt;
+
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
+		K((u64)READ_ONCE(memcg->memory.max)), memory_failcnt);
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->swap)),
-			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+			K((u64)READ_ONCE(memcg->swap.max)),
+			atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
 #ifdef CONFIG_MEMCG_V1
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
@@ -3622,6 +3629,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
+		memcg->memory.track_failcnt = !memcg_on_dfl;
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 		page_counter_init(&memcg->kmem, &parent->kmem, false);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem, false);
diff --git a/mm/page_counter.c b/mm/page_counter.c
index af23f927611b..661e0f2a5127 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -121,6 +121,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 {
 	struct page_counter *c;
 	bool protection = track_protection(counter);
+	bool track_failcnt = counter->track_failcnt;
 
 	for (c = counter; c; c = c->parent) {
 		long new;
@@ -146,7 +147,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 			 * inaccuracy in the failcnt which is only used
 			 * to report stats.
 			 */
-			data_race(c->failcnt++);
+			if (track_failcnt)
+				data_race(c->failcnt++);
 			*fail = c;
 			goto failed;
 		}
-- 
2.43.5


