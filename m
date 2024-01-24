Return-Path: <cgroups+bounces-1229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC683A62C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB551F22932
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AA182BB;
	Wed, 24 Jan 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3IgeYbF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A82182C5
	for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090428; cv=none; b=VdAk9aStUBnJZsDAXDiIGAYk42nUwW8gIw9PeAdCnVGDi1Y+VUqb8nnVwBCy+lncxYEkOznroNYOhBJvbTyzDwWmXHeStDqIMExDOgJWWpG7NhKgE5VkQ8zAC9QMNeud0iyNZxawMW9oiEmdGvuDk1WyR6F6Huv73S7ddUcLXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090428; c=relaxed/simple;
	bh=891w0zQHfb16Qwem9jKX/4xM+JuEJjYspwRsDJ/qiT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TMtz/vd4HRE68kHYlOxWrWz0ivzBIwnspQb+XrHSunVVJzHYvI1mu9r4JfOSAsOeM/wTZkd8Z5n+JxfUYjLtjzYmQJZ4mf/oyv1d13S0jN3xUN33+lq0WvsUmMNlM8GmnKVYwAr7ZjrhUmGYE0xm2J1e3jXZYuKUCER24bXeM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3IgeYbF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc24de01bd9so9459196276.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706090425; x=1706695225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKHi8mwFd4NN6LHc1BfTFS1XT0Ge9Y10ExrRil/WNW0=;
        b=Z3IgeYbFvC3Jyo0M4FY54tru5li1uTx4xRy9y4iy1Z75U+tPN0U8q0yxOSh6J2Nc30
         CwuSAr3yjw4iepnu7UnbhBRNf8PpxOhZurb8m5AObt1CqgK5TKhOJ/gKWCOAnhKVlX2z
         Mr8nCPm3/XqIEsdarRPqvfSD2ZNdOMNT91k/xbMRAbkct3jb3bF0J8z/W4afXZ7k5JQi
         O5jJrh6q21lLFpHlMpSRJs8en09zr/J6yc4AusHRsJnHv9EmQFHzrWXgZLl3bK0cRkN+
         Tfr8huaQWeJq3U/lwR9czJXbLRRg31CVc64hFwQs10FfkUNWLSKeXvedC/mkUdV7Ibjc
         OmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090425; x=1706695225;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKHi8mwFd4NN6LHc1BfTFS1XT0Ge9Y10ExrRil/WNW0=;
        b=ExfQS7+2S85azkocOzCalFUCRyxerkPR3N/vbBaYv8UUUB8wupjaHSQEnuFvkx6e6w
         eXSvFXjNU1NH/Dc7KcysRHtCOb1fPkT8o0T4QXb8wGnnuclD157WMU0uBNfJunCm5j3R
         4/84i8x2UWojVLsui1742UkZPjZg33VVrt2gISQ3dDAQoQr1MdpicfrNiLb+b5/OqrOQ
         vtjE0+HWDPLG2S5Ba8VUPN2c/z+1brrzDBM6M5ARllRjcxy5Ewg6i7qiuTS5jlqdYimE
         kenKz09TCTRkHU7sNkienZAGt4THKjTH8fG4s3Gvs70Kyj9tpVwuT7XSrqv+drhFdQz4
         yxdg==
X-Gm-Message-State: AOJu0Yx6w3rGd9GN20IlG8rqnzVnHnmTX7Sp/qlLKXDVLWCxmxBTefwn
	gRasTisYYsKotgYJ9XkJhxvX8917y1oTI2BxPK3Akcpo7FayzuKFL6iuyd735bkHS8o8rSt4/XP
	gWGuxkiOe6k8pJk9//Q==
X-Google-Smtp-Source: AGHT+IH+naeLZo53W3VMEsSmdD2T5eoHGPmFtrvozwAy527oihSlzU23jzmkJorcxjJPT4nBLW9hb0QygfTJ6Sl9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2412:b0:dc2:4cf5:9ed0 with
 SMTP id dr18-20020a056902241200b00dc24cf59ed0mr272945ybb.5.1706090425470;
 Wed, 24 Jan 2024 02:00:25 -0800 (PST)
Date: Wed, 24 Jan 2024 10:00:22 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124100023.660032-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: optimize parent iteration in memcg_rstat_updated()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

In memcg_rstat_updated(), we iterate the memcg being updated and its
parents to update memcg->vmstats_percpu->stats_updates in the fast path
(i.e. no atomic updates). According to my math, this is 3 memory loads
(and potentially 3 cache misses) per memcg:
- Load the address of memcg->vmstats_percpu.
- Load vmstats_percpu->stats_updates (based on some percpu calculation).
- Load the address of the parent memcg.

Avoid most of the cache misses by caching a pointer from each struct
memcg_vmstats_percpu to its parent on the corresponding CPU. In this
case, for the first memcg we have 2 memory loads (same as above):
- Load the address of memcg->vmstats_percpu.
- Load vmstats_percpu->stats_updates (based on some percpu calculation).

Then for each additional memcg, we need a single load to get the
parent's stats_updates directly. This reduces the number of loads from
O(3N) to O(2+N) -- where N is the number of memcgs we need to iterate.

Additionally, stash a pointer to memcg->vmstats in each struct
memcg_vmstats_percpu such that we can access the atomic counter that all
CPUs fold into, memcg->vmstats->stats_updates.
memcg_should_flush_stats() is changed to memcg_vmstats_needs_flush() to
accept a struct memcg_vmstats pointer accordingly.

In struct memcg_vmstats_percpu, make sure both pointers together with
stats_updates live on the same cacheline. Finally, update
mem_cgroup_alloc() to take in a parent pointer and initialize the new
cache pointers on each CPU. The percpu loop in mem_cgroup_alloc() may
look concerning, but there are multiple similar loops in the cgroup
creation path (e.g. cgroup_rstat_init()), most of which are hidden
within alloc_percpu().

According to Oliver's testing [1], this fixes multiple 30-38%
regressions in vm-scalability, will-it-scale-tlb_flush2, and
will-it-scale-fallocate1. This comes at a cost of 2 more pointers per
CPU (<2KB on a machine with 128 CPUs).

[1] https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/

Fixes: 8d59d2214c23 ("mm: memcg: make stats flushing threshold per-memcg")
Tested-by: kernel test robot <oliver.sang@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@intel.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

The only noticeable change I made after Oliver's testing is adding the
cacheline padding in struct memcg_vmstats_percpu. In my config, the
added pointers happen to be on the same cacheline as stats_updates, and
I assume with Oliver's testing given the results. However, this can
change on different configs and as new stats are added, so I added the
cacheline padding to make sure they are always on the same cachline.

---
 mm/memcontrol.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85c..868da91cceb48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -633,8 +633,15 @@ struct memcg_vmstats_percpu {
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
 
+	/* Fit members below in a single cacheline for memcg_rstat_updated() */
+	CACHELINE_PADDING(_pad1_);
+
 	/* Stats updates since the last flush */
 	unsigned int		stats_updates;
+
+	/* Cached pointers for fast iteration in memcg_rstat_updated() */
+	struct memcg_vmstats_percpu	*parent;
+	struct memcg_vmstats		*vmstats;
 };
 
 struct memcg_vmstats {
@@ -698,36 +705,35 @@ static void memcg_stats_unlock(void)
 }
 
 
-static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
+static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 {
-	return atomic64_read(&memcg->vmstats->stats_updates) >
+	return atomic64_read(&vmstats->stats_updates) >
 		MEMCG_CHARGE_BATCH * num_online_cpus();
 }
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	struct memcg_vmstats_percpu *statc;
 	int cpu = smp_processor_id();
-	unsigned int x;
 
 	if (!val)
 		return;
 
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
-
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		x = __this_cpu_add_return(memcg->vmstats_percpu->stats_updates,
-					  abs(val));
-
-		if (x < MEMCG_CHARGE_BATCH)
+	statc = this_cpu_ptr(memcg->vmstats_percpu);
+	for (; statc; statc = statc->parent) {
+		statc->stats_updates += abs(val);
+		if (statc->stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
 		/*
 		 * If @memcg is already flush-able, increasing stats_updates is
 		 * redundant. Avoid the overhead of the atomic update.
 		 */
-		if (!memcg_should_flush_stats(memcg))
-			atomic64_add(x, &memcg->vmstats->stats_updates);
-		__this_cpu_write(memcg->vmstats_percpu->stats_updates, 0);
+		if (!memcg_vmstats_needs_flush(statc->vmstats))
+			atomic64_add(statc->stats_updates,
+				     &statc->vmstats->stats_updates);
+		statc->stats_updates = 0;
 	}
 }
 
@@ -756,7 +762,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	if (memcg_should_flush_stats(memcg))
+	if (memcg_vmstats_needs_flush(memcg->vmstats))
 		do_flush_stats(memcg);
 }
 
@@ -770,7 +776,7 @@ void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	/*
-	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
+	 * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
 	do_flush_stats(root_mem_cgroup);
@@ -5456,10 +5462,11 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 	__mem_cgroup_free(memcg);
 }
 
-static struct mem_cgroup *mem_cgroup_alloc(void)
+static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
+	struct memcg_vmstats_percpu *statc, *pstatc;
 	struct mem_cgroup *memcg;
-	int node;
+	int node, cpu;
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
@@ -5483,6 +5490,14 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg->vmstats_percpu)
 		goto fail;
 
+	for_each_possible_cpu(cpu) {
+		if (parent)
+			pstatc = per_cpu_ptr(parent->vmstats_percpu, cpu);
+		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
+		statc->parent = parent ? pstatc : NULL;
+		statc->vmstats = memcg->vmstats;
+	}
+
 	for_each_node(node)
 		if (alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;
@@ -5528,7 +5543,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	struct mem_cgroup *memcg, *old_memcg;
 
 	old_memcg = set_active_memcg(parent);
-	memcg = mem_cgroup_alloc();
+	memcg = mem_cgroup_alloc(parent);
 	set_active_memcg(old_memcg);
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
-- 
2.43.0.429.g432eaa2c6b-goog


