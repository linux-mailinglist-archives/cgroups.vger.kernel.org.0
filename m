Return-Path: <cgroups+bounces-8572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEBADDCC3
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 21:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97763BA134
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42B274FC8;
	Tue, 17 Jun 2025 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFrlZu7X"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3292F2706
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190273; cv=none; b=cBw6p9pDSqU9DFvrnxL3l0GAoWmH7XrcfH2zmPmfe9v6hBqqrfk4EC7u/0mf7DIlQcyLcSM81ERuJNEdONdiHpPdD6HaqVm/f76Bk1oeAYfugXc6oB15WLM7TVyN7bKPMHcHl8aGftPsccKDIwvM7unFnW75M103Ktwkgb7mbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190273; c=relaxed/simple;
	bh=Yi2J1zNhP9MEWYZYLjFvH++odVy25tiNSULt2DBo68U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJVSctsIrlb9c+jDPa2mP810Vd6YO5B2QIc2mp4DfSvPSnlL9Ani19SKSgDfPYBj6VT4hIzSRVx8/+XsAQjl5C3O99nYU8YCJjGRP+F/kwSo8hgRFyndV0dQroll0u9JolfW+NLB0Y+ge8GSeN8HSbSlgJkc8tG58ww+bRSLOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFrlZu7X; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750190269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOZQdqjTaj2ZWtoNQCZgZm9OalbP9EhjyF/kfQvNGpw=;
	b=JFrlZu7XSgyCbar/+PJF2y7CB1zhqzR74Aol+v6VK7/KW8ynmi3rnrA0IzJw96adMCbQ5F
	90gvb6Me5N+LwctMunixiAS3hR13g5wxv7szpIiAY0S97t7Nw0uMX1v83n9hj5CAGOpIcd
	JBKyEDmu3867f24tyU4UsAmp4wgD1d0=
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
Subject: [PATCH v3 3/4] cgroup: remove per-cpu per-subsystem locks
Date: Tue, 17 Jun 2025 12:57:24 -0700
Message-ID: <20250617195725.1191132-4-shakeel.butt@linux.dev>
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

The rstat update side used to insert the cgroup whose stats are updated
in the update tree and the read side flush the update tree to get the
latest uptodate stats. The per-cpu per-subsystem locks were used to
synchronize the update and flush side. However now the update side does
not access update tree but uses per-cpu lockless lists. So there is no
need for locks to synchronize update and flush side. Let's remove them.

Suggested-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h   |   7 ---
 include/trace/events/cgroup.h |  47 ----------------
 kernel/cgroup/rstat.c         | 100 ++--------------------------------
 3 files changed, 4 insertions(+), 150 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 04191d99228c..6b93a64115fe 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -375,12 +375,6 @@ struct css_rstat_cpu {
 	 * Child cgroups with stat updates on this cpu since the last read
 	 * are linked on the parent's ->updated_children through
 	 * ->updated_next. updated_children is terminated by its container css.
-	 *
-	 * In addition to being more compact, singly-linked list pointing to
-	 * the css makes it unnecessary for each per-cpu struct to point back
-	 * to the associated css.
-	 *
-	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
 	 */
 	struct cgroup_subsys_state *updated_children;
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
@@ -824,7 +818,6 @@ struct cgroup_subsys {
 	unsigned int depends_on;
 
 	spinlock_t rstat_ss_lock;
-	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
 	struct llist_head __percpu *lhead; /* lockless update list head */
 };
 
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 7d332387be6c..ba9229af9a34 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -257,53 +257,6 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
 	TP_ARGS(cgrp, cpu, contended)
 );
 
-/*
- * Related to per CPU locks:
- * global rstat_base_cpu_lock for base stats
- * cgroup_subsys::rstat_ss_cpu_lock for subsystem stats
- */
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended_fastpath,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_locked_fastpath,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_unlock_fastpath,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 823a4c7c3fea..c8a48cf83878 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -10,7 +10,6 @@
 #include <trace/events/cgroup.h>
 
 static DEFINE_SPINLOCK(rstat_base_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 static DEFINE_PER_CPU(struct llist_head, rstat_backlog_list);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
@@ -53,74 +52,6 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
 	return per_cpu_ptr(&rstat_backlog_list, cpu);
 }
 
-static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
-{
-	if (ss)
-		return per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu);
-
-	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
-}
-
-/*
- * Helper functions for rstat per CPU locks.
- *
- * This makes it easier to diagnose locking issues and contention in
- * production environments. The parameter @fast_path determine the
- * tracepoints being added, allowing us to diagnose "flush" related
- * operations without handling high-frequency fast-path "update" events.
- */
-static __always_inline
-unsigned long _css_rstat_cpu_lock(struct cgroup_subsys_state *css, int cpu,
-		const bool fast_path)
-{
-	struct cgroup *cgrp = css->cgroup;
-	raw_spinlock_t *cpu_lock;
-	unsigned long flags;
-	bool contended;
-
-	/*
-	 * The _irqsave() is needed because the locks used for flushing are
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
-	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
-	 * kernel. The raw_spinlock_t below disables interrupts on both
-	 * configurations. The _irqsave() ensures that interrupts are always
-	 * disabled and later restored.
-	 */
-	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
-	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
-	if (contended) {
-		if (fast_path)
-			trace_cgroup_rstat_cpu_lock_contended_fastpath(cgrp, cpu, contended);
-		else
-			trace_cgroup_rstat_cpu_lock_contended(cgrp, cpu, contended);
-
-		raw_spin_lock_irqsave(cpu_lock, flags);
-	}
-
-	if (fast_path)
-		trace_cgroup_rstat_cpu_locked_fastpath(cgrp, cpu, contended);
-	else
-		trace_cgroup_rstat_cpu_locked(cgrp, cpu, contended);
-
-	return flags;
-}
-
-static __always_inline
-void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
-		unsigned long flags, const bool fast_path)
-{
-	struct cgroup *cgrp = css->cgroup;
-	raw_spinlock_t *cpu_lock;
-
-	if (fast_path)
-		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
-	else
-		trace_cgroup_rstat_cpu_unlock(cgrp, cpu, false);
-
-	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
-	raw_spin_unlock_irqrestore(cpu_lock, flags);
-}
-
 /**
  * css_rstat_updated - keep track of updated rstat_cpu
  * @css: target cgroup subsystem state
@@ -323,15 +254,12 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 {
 	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
-	unsigned long flags;
-
-	flags = _css_rstat_cpu_lock(root, cpu, false);
 
 	css_process_update_tree(root->ss, cpu);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
-		goto unlock_ret;
+		return NULL;
 
 	/*
 	 * Unlink @root from its parent. As the updated_children list is
@@ -363,8 +291,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 	rstatc->updated_children = root;
 	if (child != root)
 		head = css_rstat_push_children(head, child, cpu);
-unlock_ret:
-	_css_rstat_cpu_unlock(root, cpu, flags, false);
+
 	return head;
 }
 
@@ -560,34 +487,15 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 {
 	int cpu;
 
-#ifdef CONFIG_SMP
-	/*
-	 * On uniprocessor machines, arch_spinlock_t is defined as an empty
-	 * struct. Avoid allocating a size of zero by having this block
-	 * excluded in this case. It's acceptable to leave the subsystem locks
-	 * unitialized since the associated lock functions are no-ops in the
-	 * non-smp case.
-	 */
-	if (ss) {
-		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
-		if (!ss->rstat_ss_cpu_lock)
-			return -ENOMEM;
-	}
-#endif
-
 	if (ss) {
 		ss->lhead = alloc_percpu(struct llist_head);
-		if (!ss->lhead) {
-			free_percpu(ss->rstat_ss_cpu_lock);
+		if (!ss->lhead)
 			return -ENOMEM;
-		}
 	}
 
 	spin_lock_init(ss_rstat_lock(ss));
-	for_each_possible_cpu(cpu) {
-		raw_spin_lock_init(ss_rstat_cpu_lock(ss, cpu));
+	for_each_possible_cpu(cpu)
 		init_llist_head(ss_lhead_cpu(ss, cpu));
-	}
 
 	return 0;
 }
-- 
2.47.1


