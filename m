Return-Path: <cgroups+bounces-12559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E630BCD472F
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 00:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBDA0300A301
	for <lists+cgroups@lfdr.de>; Sun, 21 Dec 2025 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8C2877D2;
	Sun, 21 Dec 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbu3mm+W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692A2857F1
	for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360221; cv=none; b=rudI3bp8nppb+RC8mwni096jr5umOKVABCXZqonI9mpVdiLP7b5pjlwfMRjVWnuWD0XO2tX8YXtXgJ2OSMw4l0t3t/A9/cUQ1Gu1cfpFf1Ddxa6Dxy22dcukuBQ2Vw+4tQiSiDKDWQEWEuyg40BUIdLeylrIaf73Cbmth7P5XAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360221; c=relaxed/simple;
	bh=1qck0wUG8zkmGtpgeRMZgcBVUsA+HQYW7SICvmzdXCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RT/aIw6iki8Y9ZBSVT+tI6enK2M86W5jAWGVBo0mvwTkfyxHpGYIEhRBhydW7+q1l7pTwl8ZfXnz9nYZPfy9X7S38rgIGzpiaNKjDmlkQZpezSdTzn7I+h0ddRuTkDZJbc7Ay4Uri+NgGCR6POobkqf2f+zaUb5YzLsTn5AxiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbu3mm+W; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a09845b7faso50119895ad.3
        for <cgroups@vger.kernel.org>; Sun, 21 Dec 2025 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766360219; x=1766965019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOdI/BEkQBQWXUHyCrchJg6ArfOE4J8nqe0nfugUeYI=;
        b=fbu3mm+WTV1jyn6nFbXAyS/6B7ZaB4zF8QOlFKZBkVSiIfxuhcXM1uamp7A+ikSMld
         2AYaAjDP1rLhGL5XKRXFZPdYREg42T3vOyApj13W/SmA/CPflZq207q5lGm57nXVkY2v
         1DQoM1XOp81HgcEO7mfIVhaMbVZowUkIAyeJAyr6RwLOGFbZm9axkMKQyF4o5M5rjEFy
         CJ6TeCEG4LbXzI0OqtYrQxcBS/nVzRk3szLYHidz9mwjEsmRMcEASfq/Z/nkysgq4UAl
         3Q6uDC3AllQKRrYVTWEzWt4gYdQ2iwHP6k5CQ5I0INEhDJ411OxMG+SUyJj4IBNUQYVf
         +t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766360219; x=1766965019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOdI/BEkQBQWXUHyCrchJg6ArfOE4J8nqe0nfugUeYI=;
        b=IOIZgpw0jEZcAcqqwbHQwrGH0e5kMZjU+nDTigViPYYlhe7cXKqSSygx8xvpqvj9Aw
         JlLhbkCyx+M7ocsK/dVo/NdWyEqJia7FgcAGlcr1rG/NmbpbDbmBsIm1/UN1Klp8MhLq
         T+Tj1FZaooY6WuIdP/5U63M54ISGkgr/12L5K7LcLRbkGPWU86DRIB4cQoRsaMkW/LRq
         64DFUO9q4V28s6RYNkDOqJFoIW7mw3oguag/AjI6ubYwkqEfOrfSNEHidHGSMI3iCA/7
         1kGIh/05dygucQglbF+d6fhhowj9qV0dqt22tAWdQDSWlM/dmiLC9Uh2GLfUoW8aKkRt
         Y4+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIDoiJFHjhwnNPWttukzXb5VNcN41oy4VvyvhThT7zaozvFPesYQE8wByGvK5CuvuMwOUfp4gz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hw7A6UNWPwuasDPKkvAaBN33ofMelrKDy7Lw76dXeIKeWdM0
	+x7uad6Ga8z1PoDUR+HcdiIkVuQk3lYDHEC3c5xJbfAtkQvhXqt4j5J1d4ez4l7UvtppTGVmyGl
	c+XY38bQyUKuMsw==
X-Google-Smtp-Source: AGHT+IELZQMOEJm89X4TKV9M7co9XdZ3YqAhkiRqGdD+0QsqFHoJCcLn4TvuboqvIUgaBTBeBhEGNHBt5S4NeA==
X-Received: from dlbtk5.prod.google.com ([2002:a05:7022:fb05:b0:11e:3ea:a127])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3c06:b0:119:e569:f258 with SMTP id a92af1059eb24-121721acc08mr8626739c88.1.1766360218726;
 Sun, 21 Dec 2025 15:36:58 -0800 (PST)
Date: Sun, 21 Dec 2025 23:36:35 +0000
In-Reply-To: <20251221233635.3761887-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251220061022.2726028-1-bingjiao@google.com> <20251221233635.3761887-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251221233635.3761887-3-bingjiao@google.com>
Subject: [PATCH v2 2/2] mm/vmscan: check all allowed targets in can_demote()
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, cgroups@vger.kernel.org, Bing Jiao <bingjiao@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to
can_demote(). However, it checks only the nodes in the immediate next
demotion hierarchy and does not check all allowed demotion targets.
This can cause pages to never be demoted if the nodes in the next
demotion hierarchy are not set in mems_effective.

To address the bug, use mem_cgroup_filter_mems_allowed() to filter
out allowed targets obtained from node_get_allowed_targets(). Also
remove some unused functions.

Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 include/linux/cpuset.h     |  6 ------
 include/linux/memcontrol.h |  7 -------
 kernel/cgroup/cpuset.c     | 28 ++++------------------------
 mm/memcontrol.c            |  5 -----
 mm/vmscan.c                | 14 ++++++++------
 5 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 0e94548e2d24..ed7c27276e71 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -174,7 +174,6 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
 extern void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask);
 #else /* !CONFIG_CPUSETS */
 
@@ -302,11 +301,6 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
-{
-	return true;
-}
-
 static inline void cpuset_node_filter_allowed(struct cgroup *cgroup,
 					      nodemask_t *mask)
 {
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7cfd71c57caa..41aab33499b5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1740,8 +1740,6 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
-
 void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask);
 
 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
@@ -1813,11 +1811,6 @@ static inline ino_t page_cgroup_ino(struct page *page)
 	return 0;
 }
 
-static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
-{
-	return true;
-}
-
 static inline bool mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg,
 						  nodemask_t *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2925bd6bca91..339779571508 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4416,11 +4416,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }
 
-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	bool allowed;
 
 	/*
 	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
@@ -4428,15 +4427,15 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * so return true to avoid taking a global lock on the empty check.
 	 */
 	if (!cpuset_v2())
-		return true;
+		return;
 
 	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
 	if (!css)
-		return true;
+		return;
 
 	/*
 	 * Normally, accessing effective_mems would require the cpuset_mutex
-	 * or callback_lock - but node_isset is atomic and the reference
+	 * or callback_lock - but it is acceptable and the reference
 	 * taken via cgroup_get_e_css is sufficient to protect css.
 	 *
 	 * Since this interface is intended for use by migration paths, we
@@ -4447,25 +4446,6 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
-	css_put(css);
-	return allowed;
-}
-
-void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
-{
-	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
-
-	if (!cpuset_v2())
-		return;
-
-	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
-	if (!css)
-		return;
-
-	/* Follows the same assumption in cpuset_node_allowed() */
-	cs = container_of(css, struct cpuset, css);
 	nodes_and(*mask, *mask, cs->effective_mems);
 	css_put(css);
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f414653867de..ebf5df3c8ca1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5597,11 +5597,6 @@ subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
 
-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
-{
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
-}
-
 void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
 {
 	if (memcg)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4d23c491e914..fa4d51af7f44 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -344,19 +344,21 @@ static void flush_reclaim_state(struct scan_control *sc)
 static bool can_demote(int nid, struct scan_control *sc,
 		       struct mem_cgroup *memcg)
 {
-	int demotion_nid;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	nodemask_t allowed_mask;
 
-	if (!numa_demotion_enabled)
+	if (!pgdat || !numa_demotion_enabled)
 		return false;
 	if (sc && sc->no_demotion)
 		return false;
 
-	demotion_nid = next_demotion_node(nid);
-	if (demotion_nid == NUMA_NO_NODE)
+	node_get_allowed_targets(pgdat, &allowed_mask);
+	if (nodes_empty(allowed_mask))
 		return false;
 
-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	/* Filter the given nmask based on cpuset.mems.allowed */
+	mem_cgroup_filter_mems_allowed(memcg, &allowed_mask);
+	return !nodes_empty(allowed_mask);
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-- 
2.52.0.351.gbe84eed79e-goog


