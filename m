Return-Path: <cgroups+bounces-8569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5BADDCBB
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEC23B4105
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2382ECD19;
	Tue, 17 Jun 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JfWvQNsF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F525B69B
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190268; cv=none; b=VtD1iXM6LopcmzyZ2lIXC8rtO+thjXsladt7kOvG6aqaIoWjBg9kaOP5NIIMzyjW/DTBTYiU9q5Y9ec1oTHEsBKDQ6e6mQLT5A/80eETMckHYMlGTMeK4l8C0Vfc9c4JYJ+CBSP3hTFjg3Gf0lOfc4Jm8Mro0DVMZZE3ADi1OyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190268; c=relaxed/simple;
	bh=h8hq0p2dZBv6qJAjPSpvjNxUtC7lPFwmOicHH46sW0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDRwT9BcZUJkuJgMXxtcMiW2DuaZVEDdWXT1Pu+7YEUyW0Os/qEXTUQQN5bLZo6D4IV+1NA/eav2KplDnxHw8LMYkDnD/0JAwtPlyM+lTX4f6Eb1x0pE8rzE/BwPn2Sspa3D4JreNJR9SOWcXiJ5Mb0SmM5uPVtOU720fJDjOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfWvQNsF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750190263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5TXDBw9Xo7tr3SlWqr0OfIqU9MzSK+Y6l/L2II+x8M=;
	b=JfWvQNsFMHlcWXPiNFz9kQfC63FW8AGYVgK/Xp8MLPSR2ujSzfDWMWB+0h+Rl/BNxUgSa4
	pUDk1xLeZZfR+7Xu1TxHBtUpuIE/PXSyVS1XeGthj7REdEW4+FcJja6Jm4o5kN6uTmKU5Y
	DgxUfa/z5Z/Mi2TkY3N0ZF0PnuoU6Og=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 2/4] cgroup: make css_rstat_updated nmi safe
Date: Tue, 17 Jun 2025 12:57:23 -0700
Message-ID: <20250617195725.1191132-3-shakeel.butt@linux.dev>
In-Reply-To: <20250617195725.1191132-1-shakeel.butt@linux.dev>
References: <20250617195725.1191132-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make css_rstat_updated() able to safely run in nmi context, let's
move the rstat update tree creation at the flush side and use per-cpu
lockless lists in struct cgroup_subsys to track the css whose stats are
updated on that cpu.

The struct cgroup_subsys_state now has per-cpu lnode which needs to be
inserted into the corresponding per-cpu lhead of struct cgroup_subsys.
Since we want the insertion to be nmi safe, there can be multiple
inserters on the same cpu for the same lnode. Here multiple inserters
are from stacked contexts like softirq, hardirq and nmi.

The current llist does not provide function to protect against the
scenario where multiple inserters can use the same lnode. So, using
llist_node() out of the box is not safe for this scenario.

However we can protect against multiple inserters using the same lnode
by using the fact llist node points to itself when not on the llist and
atomically reset it and select the winner as the single inserter.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 65 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index bfa6366d2325..823a4c7c3fea 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -126,13 +126,16 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
  * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
- * rstat_cpu->updated_children list. See the comment on top of
- * css_rstat_cpu definition for details.
+ * Atomically inserts the css in the ss's llist for the given cpu. This is
+ * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
+ * will be processed at the flush time to create the update tree.
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	unsigned long flags;
+	struct llist_head *lhead;
+	struct css_rstat_cpu *rstatc;
+	struct css_rstat_cpu __percpu *rstatc_pcpu;
+	struct llist_node *self;
 
 	/*
 	 * Since bpf programs can call this function, prevent access to
@@ -141,19 +144,44 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (!css_uses_rstat(css))
 		return;
 
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * For archs withnot nmi safe cmpxchg or percpu ops support, ignore
+	 * the requests from nmi context.
+	 */
+	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
+	     !IS_ENABLED(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS)) && in_nmi())
+		return;
+
+	rstatc = css_rstat_cpu(css, cpu);
+	/* If already on list return. */
+	if (llist_on_list(&rstatc->lnode))
+		return;
+
 	/*
-	 * Speculative already-on-list test. This may race leading to
-	 * temporary inaccuracies, which is fine.
+	 * This function can be renentered by irqs and nmis for the same cgroup
+	 * and may try to insert the same per-cpu lnode into the llist. Note
+	 * that llist_add() does not protect against such scenarios.
 	 *
-	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @css is on the list by
-	 * testing the next pointer for NULL.
+	 * To protect against such stacked contexts of irqs/nmis, we use the
+	 * fact that lnode points to itself when not on a list and then use
+	 * this_cpu_cmpxchg() to atomically set to NULL to select the winner
+	 * which will call llist_add(). The losers can assume the insertion is
+	 * successful and the winner will eventually add the per-cpu lnode to
+	 * the llist.
 	 */
-	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
+	self = &rstatc->lnode;
+	rstatc_pcpu = css->rstat_cpu;
+	if (this_cpu_cmpxchg(rstatc_pcpu->lnode.next, self, NULL) != self)
 		return;
 
-	flags = _css_rstat_cpu_lock(css, cpu, true);
+	lhead = ss_lhead_cpu(css->ss, cpu);
+	llist_add(&rstatc->lnode, lhead);
+}
 
+static void __css_process_update_tree(struct cgroup_subsys_state *css, int cpu)
+{
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
@@ -179,8 +207,19 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
 		css = parent;
 	}
+}
+
+static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
+{
+	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
+	struct llist_node *lnode;
+
+	while ((lnode = llist_del_first_init(lhead))) {
+		struct css_rstat_cpu *rstatc;
 
-	_css_rstat_cpu_unlock(css, cpu, flags, true);
+		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
+		__css_process_update_tree(rstatc->owner, cpu);
+	}
 }
 
 /**
@@ -288,6 +327,8 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	flags = _css_rstat_cpu_lock(root, cpu, false);
 
+	css_process_update_tree(root->ss, cpu);
+
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		goto unlock_ret;
-- 
2.47.1


