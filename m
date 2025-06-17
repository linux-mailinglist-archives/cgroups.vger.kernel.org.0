Return-Path: <cgroups+bounces-8555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBBBADC848
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106A77A2E48
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD128EA52;
	Tue, 17 Jun 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FluvXGux"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1320C48C;
	Tue, 17 Jun 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156205; cv=none; b=Hy0ZsYvWYOAskoWjsVIHrfQhmsGlI6M/0j3lAg0TmBMSprdEOzMs6Dep9K9R3gnLpZpoXEhrnck+SnJ4PHAbuRbAT0M1xECs5sud3zGN64LPiqYFMxELNNdhLFVIkJ8OtqFI1qL8VhVrW7ggfIn4LJi8t7oa4Yb5iHQRTVlWrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156205; c=relaxed/simple;
	bh=0josVr3dToefJa0ALd4XvK9OglMWxU3HRGLNYeQmXFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRkgAVFXEv6d9b1jeOUEU0AaLzs/JBV/6IwG5tBcFQ0vkWIlioOHeVwgzLeQJ0u+N/m+9p6mmZJ2FAHjM7FhpgOpph+OH2e9Bbmb4AfHY+G6htqvFQ6U8+WTLCs+VBw+sFRF/toRxIUfN5WTjorZcmghkLnSL+bJXNeWAn5ohHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FluvXGux; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156204; x=1781692204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0josVr3dToefJa0ALd4XvK9OglMWxU3HRGLNYeQmXFI=;
  b=FluvXGuxqxzyfCILZaucfV7UyfIZifwl+WB5+QFo/Io1BR1wbh2FriPx
   NlRXaAzKD6ABSurCT9u2muTZ5GmAxKGJ1BKwvB45bO7Dt7wU1ogg7VS1I
   JLpEFs3Crnoss7EM60nmjLtB2K4vTZtzqOHH4z73hUFZbUaV4L4WFAdIk
   RDHDOqaS5hic12IkeMqPjvotY96sezepuSkUCbkIG8udrTlSWx7Yt8GR2
   BPzxHAaqLqa0Yyauo4i8b2IDFJ/BINX199+d3qpDkj25UnnRqGXuavV+3
   B2HznFIY+QxbjQFT/kcGSyYZ8F3eX8Rve/3YJw6FTFrD7vSZfwC8b8Wlm
   w==;
X-CSE-ConnectionGUID: H+Kby7/MRoC5qklnabJdTA==
X-CSE-MsgGUID: G1DwRk6cRG29pObPuT0ysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="77725184"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="77725184"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:30:03 -0700
X-CSE-ConnectionGUID: D3GRBBTkQhGrIFi9R0265Q==
X-CSE-MsgGUID: N7+yvGrAQC+NvsAikXetjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153935947"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jun 2025 03:30:00 -0700
Received: from GK6031-HR8-NF5280M7-41522.igk.intel.com (GK6031-HR8-NF5280M7-41522.igk.intel.com [10.91.175.72])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E205627BBA;
	Tue, 17 Jun 2025 11:29:58 +0100 (IST)
From: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Subject: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Date: Tue, 17 Jun 2025 12:26:45 +0200
Message-ID: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel currently faces scalability issues when multiple userspace
programs attempt to read cgroup statistics concurrently.

The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
which prevents access and updates to the statistics
of the css from multiple CPUs in parallel.

Given that rstat operates on a per-CPU basis and only aggregates
statistics in the parent cgroup, there is no compelling reason
why these statistics cannot be atomic.
By eliminating the lock, each CPU can traverse its rstat hierarchy
independently, without blocking. Synchronization is achieved during
parent propagation through atomic operations.

This change significantly enhances performance in scenarios
where multiple CPUs access CPU rstat within a single cgroup hierarchy,
yielding a performance improvement of around 50 times compared
to the mainline version.
Notably, performance for memory and I/O rstats remains unchanged,
as these are managed in separate submodules.

Additionally, this patch addresses a race condition detectable
in the current mainline by KCSAN in __cgroup_account_cputime,
which occurs when attempting to read a single hierarchy
from multiple CPUs.

Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
---
Benchmark code: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da

Tested on Intel(R) Xeon(R) Platinum 8468V, 2s 48c 2tpc, 377GiB RAM, Fedora 41:
+--------+-------+
|Mainline|Patched|
+--------+-------+
|369.95s |6.52s  |
+--------+-------+

KCSAN error after benchmark run in mainline on Qemu VM:
[   70.614601] ==================================================================
[   70.615350] BUG: KCSAN: data-race in __cgroup_account_cputime / cgroup_base_stat_flush
[   70.616229]
[   70.616462] write to 0xffd1ffffffd82360 of 8 bytes by interrupt on cpu 7:
[   70.617155]  __cgroup_account_cputime+0x4f/0x90
[   70.617674]  update_curr+0x1c1/0x260
[   70.618081]  task_tick_fair+0x46/0x610
[   70.618538]  sched_tick+0xb2/0x280
[   70.618921]  update_process_times+0x9c/0xe0
[   70.619409]  tick_nohz_handler+0x101/0x230
[   70.619856]  __hrtimer_run_queues+0x21f/0x460
[   70.620364]  hrtimer_interrupt+0x1cb/0x3b0
[   70.620814]  __sysvec_apic_timer_interrupt+0x64/0x180
[   70.621368]  sysvec_apic_timer_interrupt+0x71/0x90
[   70.621867]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   70.622438]  _raw_spin_unlock_irq+0x15/0x30
[   70.622883]  css_rstat_flush+0x13b/0x280
[   70.623305]  cgroup_base_stat_cputime_show+0xa4/0x340
[   70.623819]  cpu_stat_show+0x19/0x1c0
[   70.624246]  cgroup_seqfile_show+0xc6/0x180
[   70.624686]  kernfs_seq_show+0x9b/0xb0
[   70.625096]  seq_read_iter+0x195/0x800
[   70.625542]  kernfs_fop_read_iter+0x70/0x80
[   70.625985]  vfs_read+0x473/0x5a0
[   70.626388]  ksys_read+0xaa/0x130
[   70.626756]  __x64_sys_read+0x41/0x50
[   70.627156]  x64_sys_call+0x19e1/0x1c10
[   70.627649]  do_syscall_64+0x84/0x210
[   70.628052]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   70.628598]
[   70.628811] read to 0xffd1ffffffd82360 of 8 bytes by task 347 on cpu 3:
[   70.629480]  cgroup_base_stat_flush+0xa7/0x9e0
[   70.629943]  css_rstat_flush+0x161/0x280
[   70.630396]  cgroup_base_stat_cputime_show+0xa4/0x340
[   70.630912]  cpu_stat_show+0x19/0x1c0
[   70.631343]  cgroup_seqfile_show+0xc6/0x180
[   70.631784]  kernfs_seq_show+0x9b/0xb0
[   70.632221]  seq_read_iter+0x195/0x800
[   70.632625]  kernfs_fop_read_iter+0x70/0x80
[   70.633070]  vfs_read+0x473/0x5a0
[   70.633472]  ksys_read+0xaa/0x130
[   70.633840]  __x64_sys_read+0x41/0x50
[   70.634242]  x64_sys_call+0x19e1/0x1c10
[   70.634655]  do_syscall_64+0x84/0x210
[   70.635056]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   70.635602]
[   70.635816] value changed: 0x0000000ac6ba8b3f -> 0x0000000ac6c9f1ed
[   70.636461]
[   70.636674] Reported by Kernel Concurrency Sanitizer on:
[   70.637233] CPU: 3 UID: 0 PID: 347 Comm: benchmark Not tainted 6.15.0+ #37 PREEMPT(lazy)
[   70.638042] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[   70.638942] ==================================================================
---
 include/linux/cgroup-defs.h   |  30 ++---
 include/linux/sched/types.h   |   6 +
 include/trace/events/cgroup.h |  26 ----
 kernel/cgroup/rstat.c         | 228 +++++++++++++---------------------
 4 files changed, 104 insertions(+), 186 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e61687d5e496..58c6086e49e0 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -233,16 +233,6 @@ struct cgroup_subsys_state {
 	 * Protected by cgroup_mutex.
 	 */
 	int nr_descendants;
-
-	/*
-	 * A singly-linked list of css structures to be rstat flushed.
-	 * This is a scratch field to be used exclusively by
-	 * css_rstat_flush().
-	 *
-	 * Protected by rstat_base_lock when css is cgroup::self.
-	 * Protected by css->ss->rstat_ss_lock otherwise.
-	 */
-	struct cgroup_subsys_state *rstat_flush_next;
 };
 
 /*
@@ -343,12 +333,12 @@ struct css_set {
 };
 
 struct cgroup_base_stat {
-	struct task_cputime cputime;
+	struct atomic_task_cputime cputime;
 
 #ifdef CONFIG_SCHED_CORE
-	u64 forceidle_sum;
+	atomic64_t forceidle_sum;
 #endif
-	u64 ntime;
+	atomic64_t ntime;
 };
 
 /*
@@ -384,6 +374,14 @@ struct css_rstat_cpu {
 	 */
 	struct cgroup_subsys_state *updated_children;
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
+	/*
+	 * A singly-linked list of css structures to be rstat flushed.
+	 * This is a scratch field to be used exclusively by
+	 * css_rstat_flush().
+	 *
+	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
+	 */
+	struct cgroup_subsys_state *rstat_flush_next;
 };
 
 /*
@@ -391,11 +389,6 @@ struct css_rstat_cpu {
  * top of it - bsync, bstat and last_bstat.
  */
 struct cgroup_rstat_base_cpu {
-	/*
-	 * ->bsync protects ->bstat.  These are the only fields which get
-	 * updated in the hot path.
-	 */
-	struct u64_stats_sync bsync;
 	struct cgroup_base_stat bstat;
 
 	/*
@@ -820,7 +813,6 @@ struct cgroup_subsys {
 	 */
 	unsigned int depends_on;
 
-	spinlock_t rstat_ss_lock;
 	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
 };
 
diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
index 969aaf5ef9d6..b2bc644192b1 100644
--- a/include/linux/sched/types.h
+++ b/include/linux/sched/types.h
@@ -20,4 +20,10 @@ struct task_cputime {
 	unsigned long long		sum_exec_runtime;
 };
 
+struct atomic_task_cputime {
+	atomic64_t stime;
+	atomic64_t utime;
+	atomic_long_t sum_exec_runtime;
+};
+
 #endif /* _LINUX_SCHED_TYPES_H */
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 7d332387be6c..baa96f86b040 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -231,32 +231,6 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 		  __entry->cpu, __entry->contended)
 );
 
-/*
- * Related to locks:
- * global rstat_base_lock for base stats
- * cgroup_subsys::rstat_ss_lock for subsystem stats
- */
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_locked,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
-DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
-
-	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
-
-	TP_ARGS(cgrp, cpu, contended)
-);
-
 /*
  * Related to per CPU locks:
  * global rstat_base_cpu_lock for base stats
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cbeaa499a96a..36af2b883440 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,7 +9,6 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(rstat_base_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
@@ -37,14 +36,6 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
 	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
 }
 
-static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
-{
-	if (ss)
-		return &ss->rstat_ss_lock;
-
-	return &rstat_base_lock;
-}
-
 static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
 {
 	if (ss) {
@@ -209,15 +200,7 @@ static struct cgroup_subsys_state *css_rstat_push_children(
 	struct cgroup_subsys_state *parent, *grandchild;
 	struct css_rstat_cpu *crstatc;
 
-	child->rstat_flush_next = NULL;
-
-	/*
-	 * The subsystem rstat lock must be held for the whole duration from
-	 * here as the rstat_flush_next list is being constructed to when
-	 * it is consumed later in css_rstat_flush().
-	 */
-	lockdep_assert_held(ss_rstat_lock(head->ss));
-
+	css_rstat_cpu(child, cpu)->rstat_flush_next = NULL;
 	/*
 	 * Notation: -> updated_next pointer
 	 *	     => rstat_flush_next pointer
@@ -237,19 +220,19 @@ static struct cgroup_subsys_state *css_rstat_push_children(
 next_level:
 	while (cnext) {
 		child = cnext;
-		cnext = child->rstat_flush_next;
+		cnext = css_rstat_cpu(child, cpu)->rstat_flush_next;
 		parent = child->parent;
 
 		/* updated_next is parent cgroup terminated if !NULL */
 		while (child != parent) {
-			child->rstat_flush_next = head;
+			css_rstat_cpu(child, cpu)->rstat_flush_next = head;
 			head = child;
 			crstatc = css_rstat_cpu(child, cpu);
 			grandchild = crstatc->updated_children;
 			if (grandchild != child) {
 				/* Push the grand child to the next level */
 				crstatc->updated_children = child;
-				grandchild->rstat_flush_next = ghead;
+				css_rstat_cpu(grandchild, cpu)->rstat_flush_next = ghead;
 				ghead = grandchild;
 			}
 			child = crstatc->updated_next;
@@ -288,9 +271,6 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 {
 	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
-	unsigned long flags;
-
-	flags = _css_rstat_cpu_lock(root, cpu, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -321,13 +301,12 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	/* Push @root to the list first before pushing the children */
 	head = root;
-	root->rstat_flush_next = NULL;
+	css_rstat_cpu(root, cpu)->rstat_flush_next = NULL;
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
 		head = css_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_css_rstat_cpu_unlock(root, cpu, flags, false);
 	return head;
 }
 
@@ -353,44 +332,6 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 
 __bpf_hook_end();
 
-/*
- * Helper functions for locking.
- *
- * This makes it easier to diagnose locking issues and contention in
- * production environments.  The parameter @cpu_in_loop indicate lock
- * was released and re-taken when collection data from the CPUs. The
- * value -1 is used when obtaining the main lock else this is the CPU
- * number processed last.
- */
-static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
-		int cpu_in_loop)
-	__acquires(ss_rstat_lock(css->ss))
-{
-	struct cgroup *cgrp = css->cgroup;
-	spinlock_t *lock;
-	bool contended;
-
-	lock = ss_rstat_lock(css->ss);
-	contended = !spin_trylock_irq(lock);
-	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(lock);
-	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
-}
-
-static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
-				      int cpu_in_loop)
-	__releases(ss_rstat_lock(css->ss))
-{
-	struct cgroup *cgrp = css->cgroup;
-	spinlock_t *lock;
-
-	lock = ss_rstat_lock(css->ss);
-	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(lock);
-}
-
 /**
  * css_rstat_flush - flush stats in @css's rstat subtree
  * @css: target cgroup subsystem state
@@ -419,11 +360,11 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	might_sleep();
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos;
+		unsigned long flags;
 
-		/* Reacquire for each CPU to avoid disabling IRQs too long */
-		__css_rstat_lock(css, cpu);
+		flags = _css_rstat_cpu_lock(css, cpu, false);
 		pos = css_rstat_updated_list(css, cpu);
-		for (; pos; pos = pos->rstat_flush_next) {
+		for (; pos; pos = css_rstat_cpu(pos, cpu)->rstat_flush_next) {
 			if (is_self) {
 				cgroup_base_stat_flush(pos->cgroup, cpu);
 				bpf_rstat_flush(pos->cgroup,
@@ -431,7 +372,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 			} else
 				pos->ss->css_rstat_flush(pos, cpu);
 		}
-		__css_rstat_unlock(css, cpu);
+		_css_rstat_cpu_unlock(css, cpu, flags, false);
 		if (!cond_resched())
 			cpu_relax();
 	}
@@ -474,7 +415,6 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 			struct cgroup_rstat_base_cpu *rstatbc;
 
 			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
-			u64_stats_init(&rstatbc->bsync);
 		}
 	}
 
@@ -532,7 +472,6 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 			return -ENOMEM;
 	}
 
-	spin_lock_init(ss_rstat_lock(ss));
 	for_each_possible_cpu(cpu)
 		raw_spin_lock_init(ss_rstat_cpu_lock(ss, cpu));
 
@@ -544,46 +483,58 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
  * rstat.
  */
 static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
-				 struct cgroup_base_stat *src_bstat)
+				struct cgroup_base_stat *src_bstat)
 {
-	dst_bstat->cputime.utime += src_bstat->cputime.utime;
-	dst_bstat->cputime.stime += src_bstat->cputime.stime;
-	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
+	atomic64_add(atomic64_read(&src_bstat->cputime.utime), &dst_bstat->cputime.utime);
+	atomic64_add(atomic64_read(&src_bstat->cputime.stime), &dst_bstat->cputime.stime);
+	atomic_long_add(atomic_long_read(&src_bstat->cputime.sum_exec_runtime),
+			&dst_bstat->cputime.sum_exec_runtime);
 #ifdef CONFIG_SCHED_CORE
-	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
+	atomic64_add(atomic64_read(&src_bstat->forceidle_sum), &dst_bstat->forceidle_sum);
 #endif
-	dst_bstat->ntime += src_bstat->ntime;
+	atomic64_add(atomic64_read(&src_bstat->ntime), &dst_bstat->ntime);
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
-				 struct cgroup_base_stat *src_bstat)
+				struct cgroup_base_stat *src_bstat)
 {
-	dst_bstat->cputime.utime -= src_bstat->cputime.utime;
-	dst_bstat->cputime.stime -= src_bstat->cputime.stime;
-	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
+	atomic64_sub(atomic64_read(&src_bstat->cputime.utime), &dst_bstat->cputime.utime);
+	atomic64_sub(atomic64_read(&src_bstat->cputime.stime), &dst_bstat->cputime.stime);
+	atomic_long_sub(atomic_long_read(&src_bstat->cputime.sum_exec_runtime),
+			&dst_bstat->cputime.sum_exec_runtime);
 #ifdef CONFIG_SCHED_CORE
-	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
+	atomic64_sub(atomic64_read(&src_bstat->forceidle_sum), &dst_bstat->forceidle_sum);
 #endif
-	dst_bstat->ntime -= src_bstat->ntime;
+	atomic64_sub(atomic64_read(&src_bstat->ntime), &dst_bstat->ntime);
 }
 
+static void cgroup_base_stat_copy(struct cgroup_base_stat *dst_bstat,
+				struct cgroup_base_stat *src_bstat)
+{
+		atomic64_set(&dst_bstat->cputime.stime, atomic64_read(&src_bstat->cputime.stime));
+		atomic64_set(&dst_bstat->cputime.utime, atomic64_read(&src_bstat->cputime.utime));
+		atomic_long_set(&dst_bstat->cputime.sum_exec_runtime,
+			atomic_long_read(&src_bstat->cputime.sum_exec_runtime));
+#ifdef CONFIG_SCHED_CORE
+		atomic64_set(&dst_bstat->forceidle_sum, atomic64_read(&src_bstat->forceidle_sum));
+#endif
+		atomic64_set(&dst_bstat->ntime, atomic64_read(&src_bstat->ntime));
+}
+
+
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
 	struct cgroup_rstat_base_cpu *rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_base_cpu *prstatbc;
 	struct cgroup_base_stat delta;
-	unsigned seq;
 
 	/* Root-level stats are sourced from system-wide CPU stats */
 	if (!parent)
 		return;
 
 	/* fetch the current per-cpu values */
-	do {
-		seq = __u64_stats_fetch_begin(&rstatbc->bsync);
-		delta = rstatbc->bstat;
-	} while (__u64_stats_fetch_retry(&rstatbc->bsync, seq));
+	cgroup_base_stat_copy(&delta, &rstatbc->bstat);
 
 	/* propagate per-cpu delta to cgroup and per-cpu global statistics */
 	cgroup_base_stat_sub(&delta, &rstatbc->last_bstat);
@@ -593,12 +544,12 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 
 	/* propagate cgroup and per-cpu global delta to parent (unless that's root) */
 	if (cgroup_parent(parent)) {
-		delta = cgrp->bstat;
+		cgroup_base_stat_copy(&delta, &cgrp->bstat);
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
-		delta = rstatbc->subtree_bstat;
+		cgroup_base_stat_copy(&delta, &rstatbc->subtree_bstat);
 		prstatbc = cgroup_rstat_base_cpu(parent, cpu);
 		cgroup_base_stat_sub(&delta, &rstatbc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatbc->subtree_bstat, &delta);
@@ -606,65 +557,44 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	}
 }
 
-static struct cgroup_rstat_base_cpu *
-cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
+void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
 	struct cgroup_rstat_base_cpu *rstatbc;
 
 	rstatbc = get_cpu_ptr(cgrp->rstat_base_cpu);
-	*flags = u64_stats_update_begin_irqsave(&rstatbc->bsync);
-	return rstatbc;
-}
-
-static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_base_cpu *rstatbc,
-						 unsigned long flags)
-{
-	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
+	atomic_long_add(delta_exec, &rstatbc->bstat.cputime.sum_exec_runtime);
 	css_rstat_updated(&cgrp->self, smp_processor_id());
 	put_cpu_ptr(rstatbc);
 }
 
-void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
-{
-	struct cgroup_rstat_base_cpu *rstatbc;
-	unsigned long flags;
-
-	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
-	rstatbc->bstat.cputime.sum_exec_runtime += delta_exec;
-	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
-}
-
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
 	struct cgroup_rstat_base_cpu *rstatbc;
-	unsigned long flags;
 
-	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
+	rstatbc = get_cpu_ptr(cgrp->rstat_base_cpu);
 
 	switch (index) {
 	case CPUTIME_NICE:
-		rstatbc->bstat.ntime += delta_exec;
+		atomic64_add(delta_exec, &rstatbc->bstat.ntime);
 		fallthrough;
 	case CPUTIME_USER:
-		rstatbc->bstat.cputime.utime += delta_exec;
+		atomic64_add(delta_exec, &rstatbc->bstat.cputime.utime);
 		break;
 	case CPUTIME_SYSTEM:
 	case CPUTIME_IRQ:
 	case CPUTIME_SOFTIRQ:
-		rstatbc->bstat.cputime.stime += delta_exec;
+		atomic64_add(delta_exec, &rstatbc->bstat.cputime.stime);
 		break;
 #ifdef CONFIG_SCHED_CORE
 	case CPUTIME_FORCEIDLE:
-		rstatbc->bstat.forceidle_sum += delta_exec;
+		atomic64_add(delta_exec, &rstatbc->bstat.forceidle_sum);
 		break;
 #endif
 	default:
 		break;
 	}
-
-	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
+	put_cpu_ptr(rstatbc);
 }
 
 /*
@@ -675,7 +605,7 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
  */
 static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 {
-	struct task_cputime *cputime = &bstat->cputime;
+	struct atomic_task_cputime *cputime = &bstat->cputime;
 	int i;
 
 	memset(bstat, 0, sizeof(*bstat));
@@ -689,20 +619,19 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 		user += cpustat[CPUTIME_USER];
 		user += cpustat[CPUTIME_NICE];
-		cputime->utime += user;
+		atomic64_add(user, &cputime->utime);
 
 		sys += cpustat[CPUTIME_SYSTEM];
 		sys += cpustat[CPUTIME_IRQ];
 		sys += cpustat[CPUTIME_SOFTIRQ];
-		cputime->stime += sys;
+		atomic64_add(sys, &cputime->stime);
 
-		cputime->sum_exec_runtime += user;
-		cputime->sum_exec_runtime += sys;
+		atomic64_add(sys + user, &cputime->sum_exec_runtime);
 
 #ifdef CONFIG_SCHED_CORE
-		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
+		atomic64_add(cpustat[CPUTIME_FORCEIDLE], &bstat->forceidle_sum);
 #endif
-		bstat->ntime += cpustat[CPUTIME_NICE];
+		atomic64_add(cpustat[CPUTIME_NICE], &bstat->ntime);
 	}
 }
 
@@ -710,7 +639,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
 {
 #ifdef CONFIG_SCHED_CORE
-	u64 forceidle_time = bstat->forceidle_sum;
+	s64 forceidle_time = atomic64_read(&bstat->forceidle_sum);
 
 	do_div(forceidle_time, NSEC_PER_USEC);
 	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
@@ -721,31 +650,48 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	struct cgroup_base_stat bstat;
+	unsigned long long sum_exec_runtime;
+	s64 utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
 		css_rstat_flush(&cgrp->self);
-		__css_rstat_lock(&cgrp->self, -1);
-		bstat = cgrp->bstat;
-		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
-			       &bstat.cputime.utime, &bstat.cputime.stime);
-		__css_rstat_unlock(&cgrp->self, -1);
-	} else {
+		cgroup_base_stat_copy(&bstat, &cgrp->bstat);
+		struct task_cputime cputime = {
+			.stime = atomic64_read(&bstat.cputime.stime),
+			.utime = atomic64_read(&bstat.cputime.utime),
+			.sum_exec_runtime = atomic_long_read(
+				&bstat.cputime.sum_exec_runtime)
+		};
+		cputime_adjust(&cputime, &cgrp->prev_cputime,
+			       &cputime.utime, &cputime.stime);
+		atomic64_set(&bstat.cputime.utime, cputime.utime);
+		atomic64_set(&bstat.cputime.stime, cputime.stime);
+	} else
 		root_cgroup_cputime(&bstat);
-	}
+	sum_exec_runtime = atomic_long_read(&bstat.cputime.sum_exec_runtime);
+
+	do_div(sum_exec_runtime, NSEC_PER_USEC);
+
+	utime = atomic64_read(&bstat.cputime.utime);
+
+	do_div(utime, NSEC_PER_USEC);
+
+	stime =	atomic64_read(&bstat.cputime.stime);
+
+	do_div(stime, NSEC_PER_USEC);
+
+	ntime = atomic64_read(&bstat.ntime);
 
-	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
-	do_div(bstat.cputime.utime, NSEC_PER_USEC);
-	do_div(bstat.cputime.stime, NSEC_PER_USEC);
-	do_div(bstat.ntime, NSEC_PER_USEC);
+	do_div(ntime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
 			"user_usec %llu\n"
 			"system_usec %llu\n"
 			"nice_usec %llu\n",
-			bstat.cputime.sum_exec_runtime,
-			bstat.cputime.utime,
-			bstat.cputime.stime,
-			bstat.ntime);
+			sum_exec_runtime,
+			utime,
+			stime,
+			ntime);
 
 	cgroup_force_idle_show(seq, &bstat);
 }
-- 
2.49.0


