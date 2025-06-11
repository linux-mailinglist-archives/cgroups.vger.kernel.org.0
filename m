Return-Path: <cgroups+bounces-8492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E126DAD6248
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D91BC075D
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4804252288;
	Wed, 11 Jun 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8xikJAU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869724BD04
	for <cgroups@vger.kernel.org>; Wed, 11 Jun 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680183; cv=none; b=bRRXZs/6264XqyH+25y21T1GMzEwp8t6CG7qLKYIGSxFizt4eNGpygVog6Yo4RKO9mR0Wy4hE5yHruiyPhlTOuE2h+taXSjzxr/KthHCXRKkDj4H1DBp0Q9wDoBSze0/0p9qm0K3wl3upbGTG7Iig8NIkrZHmF3UZnAarctGFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680183; c=relaxed/simple;
	bh=RfPByibffsHxwyyKyWbhjhMeyyMJgchWlrqNxxph5bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4dtXWhqsv794mSt+Ny6Pq/JnE/XFReN7d+VKLHbq/oSMBs+6fovh9nzP4AfvJkHqHyZf26WwjqBlsyYFT5U5vPsCM/4FQ3tU5CgyT9P1Z7W2WRPzGkyFtGhwwpPOY6juJr7ZVksd4tyyS4YzmDk8fltcR3LNq6AYRbMcohVsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8xikJAU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749680168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFFIt1y9IJBu59K3m1CLaEDnhewuqL+3YiQDRhpGo1g=;
	b=M8xikJAUUp+5J+F6OXGY0j/RY1qIO7AN56Jrj0EoxB1JNdEk94Lk3WEPxO+EEQox5EItzf
	F/9mmpwEXB4Xucz2AYFR/V85LFzRwMYlMwM9IfQ/X2f0py38EnvGCHyh/qF6pgZgi5cLIj
	aOJVeh4ieT280EVlpAUexdDUv1wLz9k=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: JP Kobryn <inwardvessel@gmail.com>,
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
Subject: [PATCH v2 2/4] cgroup: make css_rstat_updated nmi safe
Date: Wed, 11 Jun 2025 15:15:30 -0700
Message-ID: <20250611221532.2513772-3-shakeel.butt@linux.dev>
In-Reply-To: <20250611221532.2513772-1-shakeel.butt@linux.dev>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
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
Changes since v1:
- More clear code comment as suggested by Tejun.

 kernel/cgroup/rstat.c | 65 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a5608ae2be27..a7550961dd12 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -138,13 +138,16 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
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
@@ -153,19 +156,44 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
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
@@ -191,8 +219,19 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
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
@@ -300,6 +339,8 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	flags = _css_rstat_cpu_lock(root, cpu, false);
 
+	css_process_update_tree(root->ss, cpu);
+
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		goto unlock_ret;
-- 
2.47.1


