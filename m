Return-Path: <cgroups+bounces-8630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D973EAE69DB
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710C71C2533A
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C922D542B;
	Tue, 24 Jun 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCmN4VxZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F82D1319;
	Tue, 24 Jun 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776504; cv=none; b=kJDEHRlM2KOq7k3F/IPaJFq1QJjyReF4uBKtC8AcxQP49P07O5xHB86T4/TG846Oml3YQL0oLyLohllIcFa8K29WG5+JX281NkTt+wFCMo/trlq2Oj6jDIh+LptAZgfYecfm2dCFFht0LI0/kB9Eeux5lgMBLRCoF0TsDE4um5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776504; c=relaxed/simple;
	bh=Z+nk4rwXJWhPtBNlhy69LvN1DRujlzbkpTp1F8h3rr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyHUAiCsT9CtEPf5DRnsEnSjuzqite+7LmNWvcBPS1qCxfWF8IvhE/V3OiMBavk3fmg/bJE5G4l1GEBYe/pVzEESUYSXYn+XCtHBi74o0686JK+jzTgEMjGB8Bq9NLVKgwriidJJE22Z0bBFxHFcYUN4dh/mgnEECpPnMlrsnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCmN4VxZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750776502; x=1782312502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z+nk4rwXJWhPtBNlhy69LvN1DRujlzbkpTp1F8h3rr8=;
  b=GCmN4VxZriZJ506ozTO3bD+UwPUMWXAQM8po2jMFrOEk+34PW3SVqXnt
   H23iDKbIaamOOfo3JyZeY0S5r6ly2Ba3IJI6GU7hA16KvE4lIlAae29MK
   3SCwXUd0JOhz/zsI6lbyo5s6gVuAuR2vIrxIgOsojUmlZs84ceEMDhgOG
   QXscUOFluTzz5V/87fRRSpsyF/jY6EoiuAm5hyMf54EZpFMtqIfotbDov
   qntR5P2OVRMUYno8ogQ3hZcBgxOnxFan/HROKCuUNyc3egLKaQKa/dZbD
   gLNR07D1qjZkP+lA9HqFmHSDdqtxt31f5McCjFf48kOSuuupvwIrE2z+D
   w==;
X-CSE-ConnectionGUID: BfVhbIeiQFOLmcD8ireW9w==
X-CSE-MsgGUID: xcsbwDSuQn6AtgkEmrt2Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52136375"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52136375"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:48:21 -0700
X-CSE-ConnectionGUID: Zqa2psKQS5W4BZ6ezF6ofw==
X-CSE-MsgGUID: EGvis3SkQYWTDV5+XQvYNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182970929"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 24 Jun 2025 07:48:18 -0700
Received: from GK6031-HR8-NF5280M7-41522.igk.intel.com (GK6031-HR8-NF5280M7-41522.igk.intel.com [10.91.175.72])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 142CA33EBD;
	Tue, 24 Jun 2025 15:48:17 +0100 (IST)
From: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	inwardvessel@gmail.com,
	Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Subject: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Date: Tue, 24 Jun 2025 16:45:58 +0200
Message-ID: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel faces scalability issues when multiple userspace
programs attempt to read cgroup statistics concurrently.

The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
which prevents access and updates to the statistics
of the css from multiple CPUs in parallel.

Given that rstat operates on a per-CPU basis and only aggregates
statistics in the parent cgroup, there is no compelling reason
why these statistics cannot be atomic.
By eliminating the lock during CPU statistics access,
each CPU can traverse its rstat hierarchy independently, without blocking.
Synchronization is achieved during parent propagation through
atomic operations.

This change significantly enhances performance on commit
8dcb0ed834a3ec03 ("memcg: cgroup: call css_rstat_updated irrespective of in_nmi()")
in scenarios where multiple CPUs accessCPU rstat within a
single cgroup hierarchy, yielding a performance improvement of around 40 times.
Notably, performance for memory and I/O rstats remains unchanged,
as the lock remains in place for these usages.

Additionally, this patch addresses a race condition detectable
in the current mainline by KCSAN in __cgroup_account_cputime,
which occurs when attempting to read a single hierarchy
from multiple CPUs.

Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
---
Changes from v1:
* reverted removal of rstat_ss_lock/css_base_lock
* ported patch on branch for-6.17
* surrounded pos->ss->css_rstat_flush(pos, cpu) call with
  css_rstat_lock to address concerns about potential
  race cond when calling io or memory rstat flush
* fixed issues reported by lkp

Benchmark code: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da

On branch for-6.17 (commit 8dcb0ed834a3ec03) the __cgroup_account_cputime
KCSAN error is still present:
[  734.729731] ==================================================================
[  734.731942] BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
[  734.733587]
[  734.734108] write to 0xffd1fffffee52090 of 8 bytes by task 1144 on cpu 57:
[  734.735678]  css_rstat_flush+0x1b0/0xed0
[  734.736657]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  734.737971]  cpu_stat_show+0x14/0x1a0
[  734.738945]  cgroup_seqfile_show+0xb0/0x150
[  734.739947]  kernfs_seq_show+0x93/0xb0
[  734.740838]  seq_read_iter+0x190/0x7d0
[  734.741913]  kernfs_fop_read_iter+0x23b/0x290
[  734.742949]  vfs_read+0x46b/0x5a0
[  734.743750]  ksys_read+0xa5/0x130
[  734.744625]  __x64_sys_read+0x3c/0x50
[  734.745626]  x64_sys_call+0x19e1/0x1c10
[  734.746657]  do_syscall_64+0xa2/0x200
[  734.747679]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  734.749021]
[  734.749441] read to 0xffd1fffffee52090 of 8 bytes by interrupt on cpu 41:
[  734.750996]  css_rstat_updated+0x8f/0x1a0
[  734.751943]  __cgroup_account_cputime+0x5d/0x90
[  734.752985]  update_curr+0x1bd/0x260
[  734.753837]  task_tick_fair+0x3b/0x130
[  734.754749]  sched_tick+0xa1/0x220
[  734.755705]  update_process_times+0x97/0xd0
[  734.756739]  tick_nohz_handler+0xfc/0x220
[  734.757845]  __hrtimer_run_queues+0x2a3/0x4b0
[  734.758954]  hrtimer_interrupt+0x1c6/0x3a0
[  734.759974]  __sysvec_apic_timer_interrupt+0x62/0x180
[  734.761195]  sysvec_apic_timer_interrupt+0x6b/0x80
[  734.762372]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  734.763663]  _raw_spin_unlock_irq+0x18/0x30
[  734.764737]  css_rstat_flush+0x5cd/0xed0
[  734.765776]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  734.766964]  cpu_stat_show+0x14/0x1a0
[  734.767827]  cgroup_seqfile_show+0xb0/0x150
[  734.768942]  kernfs_seq_show+0x93/0xb0
[  734.769842]  seq_read_iter+0x190/0x7d0
[  734.770801]  kernfs_fop_read_iter+0x23b/0x290
[  734.771972]  vfs_read+0x46b/0x5a0
[  734.772777]  ksys_read+0xa5/0x130
[  734.773664]  __x64_sys_read+0x3c/0x50
[  734.774714]  x64_sys_call+0x19e1/0x1c10
[  734.775727]  do_syscall_64+0xa2/0x200
[  734.776682]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  734.777952]
[  734.778393] value changed: 0x0000000000000000 -> 0xffd1fffffee52090
[  734.779942]
[  734.780375] Reported by Kernel Concurrency Sanitizer on:
[  734.781662] CPU: 41 UID: 0 PID: 1128 Comm: benchmark Not tainted 6.15.0-g633e6bad3124 #7 PREEMPT(voluntary)
[  734.784115] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[  734.786279] ==================================================================
[  738.533150] ==================================================================
[  738.534820] BUG: KCSAN: data-race in __cgroup_account_cputime / css_rstat_flush
[  738.536444]
[  738.536891] write to 0xffd1fffffe512010 of 8 bytes by interrupt on cpu 4:
[  738.538311]  __cgroup_account_cputime+0x4a/0x90
[  738.539311]  update_curr+0x1bd/0x260
[  738.540145]  task_tick_fair+0x3b/0x130
[  738.540961]  sched_tick+0xa1/0x220
[  738.541709]  update_process_times+0x97/0xd0
[  738.542642]  tick_nohz_handler+0xfc/0x220
[  738.543559]  __hrtimer_run_queues+0x2a3/0x4b0
[  738.544562]  hrtimer_interrupt+0x1c6/0x3a0
[  738.545480]  __sysvec_apic_timer_interrupt+0x62/0x180
[  738.546586]  sysvec_apic_timer_interrupt+0x6b/0x80
[  738.547660]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  738.548782]  _raw_spin_unlock_irq+0x18/0x30
[  738.549782]  css_rstat_flush+0x5cd/0xed0
[  738.550662]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  738.551757]  cpu_stat_show+0x14/0x1a0
[  738.552619]  cgroup_seqfile_show+0xb0/0x150
[  738.553552]  kernfs_seq_show+0x93/0xb0
[  738.554407]  seq_read_iter+0x190/0x7d0
[  738.555268]  kernfs_fop_read_iter+0x23b/0x290
[  738.556247]  vfs_read+0x46b/0x5a0
[  738.556983]  ksys_read+0xa5/0x130
[  738.557708]  __x64_sys_read+0x3c/0x50
[  738.558550]  x64_sys_call+0x19e1/0x1c10
[  738.559418]  do_syscall_64+0xa2/0x200
[  738.560258]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  738.561356]
[  738.561760] read to 0xffd1fffffe512010 of 8 bytes by task 1073 on cpu 85:
[  738.563221]  css_rstat_flush+0x717/0xed0
[  738.564106]  cgroup_base_stat_cputime_show+0x96/0x2f0
[  738.565202]  cpu_stat_show+0x14/0x1a0
[  738.571702]  cgroup_seqfile_show+0xb0/0x150
[  738.572661]  kernfs_seq_show+0x93/0xb0
[  738.573512]  seq_read_iter+0x190/0x7d0
[  738.574395]  kernfs_fop_read_iter+0x23b/0x290
[  738.575373]  vfs_read+0x46b/0x5a0
[  738.576161]  ksys_read+0xa5/0x130
[  738.576926]  __x64_sys_read+0x3c/0x50
[  738.577718]  x64_sys_call+0x19e1/0x1c10
[  738.578611]  do_syscall_64+0xa2/0x200
[  738.579454]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  738.580547]
[  738.580944] value changed: 0x0000003d5fa31114 -> 0x0000003d5fb77378
[  738.582262]
[  738.582657] Reported by Kernel Concurrency Sanitizer on:
[  738.583791] CPU: 85 UID: 0 PID: 1073 Comm: benchmark Not tainted 6.15.0-g633e6bad3124 #7 PREEMPT(voluntary)
[  738.585919] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[  738.587725] ==================================================================

Results benchmark on Qemu:
               +---------+---------+
     mean (s)  |8dcb0ed8 | patched |
+--------------+---------+---------+
|cpu, KCSAN on |borked*  |4.52     |
+--------------+---------+---------+
|cpu, KCSAN off|87.32    |2.21     |
+--------------+---------+---------+
|memory        |2.17     |2.23     |
+--------------+---------+---------+
* was spammed by KCSAN errors so the result is non conclusive

ext4 raw image with debian:
qemu-system-x86_64 -enable-kvm -cpu host -smp 102 -m 16G -kernel linux-cgroup/arch/x86/boot/bzImage -drive file=rootfs.ext4,if=virtio,format=raw -append "rootwait root=/dev/vda console=tty1 console=ttyS0 nokaslr cgroup_enable=memory cgroup_memory=1" -net nic,model=virtio -net user -nographic

During runs KCSAN detected the bug which seems unrelated to change:
[  105.806835] ==================================================================
[  105.810667] BUG: KCSAN: data-race in _find_next_bit+0x37/0xb0
[  105.812128]
[  105.812531] race at unknown origin, with read to 0xffffffff8444b080 of 8 bytes by interrupt on cpu 0:
[  105.814616]  _find_next_bit+0x37/0xb0
[  105.815495]  _nohz_idle_balance.isra.0+0x10e/0x360
[  105.816599]  handle_softirqs+0xcd/0x280
[  105.817500]  irq_exit_rcu+0x89/0xb0
[  105.818330]  sysvec_call_function_single+0x6b/0x80
[  105.819400]  asm_sysvec_call_function_single+0x1a/0x20
[  105.820561]  pv_native_safe_halt+0xf/0x20
[  105.821475]  default_idle+0x9/0x10
[  105.822287]  default_idle_call+0x2b/0x100
[  105.823214]  do_idle+0x1ca/0x230
[  105.823964]  cpu_startup_entry+0x24/0x30
[  105.824826]  rest_init+0x101/0x110
[  105.825600]  start_kernel+0x95e/0x960
[  105.826500]  x86_64_start_reservations+0x24/0x30
[  105.827540]  x86_64_start_kernel+0xc5/0xd0
[  105.828465]  common_startup_64+0x13e/0x148
[  105.829408]
[  105.829838] value changed: 0xf99dad734a1de4fd -> 0xf99fad734a1de4fd
[  105.831191]
[  105.831586] Reported by Kernel Concurrency Sanitizer on:
[  105.832775] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-gd5b739bb486e #10 PREEMPT(voluntary)
[  105.834791] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[  105.836624] ==================================================================

---
 include/linux/cgroup-defs.h |  29 ++---
 include/linux/sched/types.h |   6 ++
 kernel/cgroup/rstat.c       | 205 ++++++++++++++++++------------------
 3 files changed, 119 insertions(+), 121 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..c5d883be422c 100644
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
@@ -378,6 +368,14 @@ struct css_rstat_cpu {
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
 
 	struct llist_node lnode;		/* lockless list for update */
 	struct cgroup_subsys_state *owner;	/* back pointer */
@@ -388,11 +386,6 @@ struct css_rstat_cpu {
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
diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
index 969aaf5ef9d6..dab61f7099f6 100644
--- a/include/linux/sched/types.h
+++ b/include/linux/sched/types.h
@@ -20,4 +20,10 @@ struct task_cputime {
 	unsigned long long		sum_exec_runtime;
 };
 
+struct atomic_task_cputime {
+	atomic64_t			stime;
+	atomic64_t			utime;
+	atomic_long_t			sum_exec_runtime;
+};
+
 #endif /* _LINUX_SCHED_TYPES_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c8a48cf83878..14c12da11930 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -175,14 +175,7 @@ static struct cgroup_subsys_state *css_rstat_push_children(
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
+	css_rstat_cpu(child, cpu)->rstat_flush_next = NULL;
 
 	/*
 	 * Notation: -> updated_next pointer
@@ -203,19 +196,19 @@ static struct cgroup_subsys_state *css_rstat_push_children(
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
@@ -286,7 +279,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	/* Push @root to the list first before pushing the children */
 	head = root;
-	root->rstat_flush_next = NULL;
+	css_rstat_cpu(root, cpu)->rstat_flush_next = NULL;
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
@@ -383,19 +376,18 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	might_sleep();
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos;
-
-		/* Reacquire for each CPU to avoid disabling IRQs too long */
-		__css_rstat_lock(css, cpu);
 		pos = css_rstat_updated_list(css, cpu);
-		for (; pos; pos = pos->rstat_flush_next) {
+		for (; pos; pos = css_rstat_cpu(pos, cpu)->rstat_flush_next) {
 			if (is_self) {
 				cgroup_base_stat_flush(pos->cgroup, cpu);
 				bpf_rstat_flush(pos->cgroup,
 						cgroup_parent(pos->cgroup), cpu);
-			} else
+			} else {
+				__css_rstat_lock(css, cpu);
 				pos->ss->css_rstat_flush(pos, cpu);
+				__css_rstat_unlock(css, cpu);
+			}
 		}
-		__css_rstat_unlock(css, cpu);
 		if (!cond_resched())
 			cpu_relax();
 	}
@@ -434,13 +426,6 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
 		rstatc->owner = rstatc->updated_children = css;
 		init_llist_node(&rstatc->lnode);
-
-		if (is_self) {
-			struct cgroup_rstat_base_cpu *rstatbc;
-
-			rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
-			u64_stats_init(&rstatbc->bsync);
-		}
 	}
 
 	return 0;
@@ -507,25 +492,48 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 				 struct cgroup_base_stat *src_bstat)
 {
-	dst_bstat->cputime.utime += src_bstat->cputime.utime;
-	dst_bstat->cputime.stime += src_bstat->cputime.stime;
-	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
+	atomic64_add(atomic64_read(&src_bstat->cputime.utime),
+		     &dst_bstat->cputime.utime);
+	atomic64_add(atomic64_read(&src_bstat->cputime.stime),
+		     &dst_bstat->cputime.stime);
+	atomic_long_add(atomic_long_read(&src_bstat->cputime.sum_exec_runtime),
+			&dst_bstat->cputime.sum_exec_runtime);
 #ifdef CONFIG_SCHED_CORE
-	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
+	atomic64_add(atomic64_read(&src_bstat->forceidle_sum),
+		     &dst_bstat->forceidle_sum);
 #endif
-	dst_bstat->ntime += src_bstat->ntime;
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 				 struct cgroup_base_stat *src_bstat)
 {
-	dst_bstat->cputime.utime -= src_bstat->cputime.utime;
-	dst_bstat->cputime.stime -= src_bstat->cputime.stime;
-	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
+	atomic64_sub(atomic64_read(&src_bstat->cputime.utime),
+		     &dst_bstat->cputime.utime);
+	atomic64_sub(atomic64_read(&src_bstat->cputime.stime),
+		     &dst_bstat->cputime.stime);
+	atomic_long_sub(atomic_long_read(&src_bstat->cputime.sum_exec_runtime),
+			&dst_bstat->cputime.sum_exec_runtime);
 #ifdef CONFIG_SCHED_CORE
-	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
+	atomic64_sub(atomic64_read(&src_bstat->forceidle_sum),
+		     &dst_bstat->forceidle_sum);
 #endif
-	dst_bstat->ntime -= src_bstat->ntime;
+	atomic64_sub(atomic64_read(&src_bstat->ntime), &dst_bstat->ntime);
+}
+
+static void cgroup_base_stat_copy(struct cgroup_base_stat *dst_bstat,
+				  struct cgroup_base_stat *src_bstat)
+{
+	atomic64_set(&dst_bstat->cputime.stime,
+		     atomic64_read(&src_bstat->cputime.stime));
+	atomic64_set(&dst_bstat->cputime.utime,
+		     atomic64_read(&src_bstat->cputime.utime));
+	atomic_long_set(&dst_bstat->cputime.sum_exec_runtime,
+			atomic_long_read(&src_bstat->cputime.sum_exec_runtime));
+#ifdef CONFIG_SCHED_CORE
+	atomic64_set(&dst_bstat->forceidle_sum,
+		     atomic64_read(&src_bstat->forceidle_sum));
+#endif
+	atomic64_set(&dst_bstat->ntime, atomic64_read(&src_bstat->ntime));
 }
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
@@ -534,17 +542,12 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_base_cpu *prstatbc;
 	struct cgroup_base_stat delta;
-	unsigned seq;
 
 	/* Root-level stats are sourced from system-wide CPU stats */
 	if (!parent)
 		return;
 
-	/* fetch the current per-cpu values */
-	do {
-		seq = __u64_stats_fetch_begin(&rstatbc->bsync);
-		delta = rstatbc->bstat;
-	} while (__u64_stats_fetch_retry(&rstatbc->bsync, seq));
+	cgroup_base_stat_copy(&delta, &rstatbc->bstat);
 
 	/* propagate per-cpu delta to cgroup and per-cpu global statistics */
 	cgroup_base_stat_sub(&delta, &rstatbc->last_bstat);
@@ -554,12 +557,12 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 
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
@@ -567,65 +570,43 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	}
 }
 
-static struct cgroup_rstat_base_cpu *
-cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
-{
-	struct cgroup_rstat_base_cpu *rstatbc;
-
-	rstatbc = get_cpu_ptr(cgrp->rstat_base_cpu);
-	*flags = u64_stats_update_begin_irqsave(&rstatbc->bsync);
-	return rstatbc;
-}
-
-static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_base_cpu *rstatbc,
-						 unsigned long flags)
-{
-	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
-	css_rstat_updated(&cgrp->self, smp_processor_id());
-	put_cpu_ptr(rstatbc);
-}
-
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct cgroup_rstat_base_cpu *rstatbc;
-	unsigned long flags;
-
-	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
-	rstatbc->bstat.cputime.sum_exec_runtime += delta_exec;
-	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
+	struct cgroup_rstat_base_cpu *rstatbc =
+		get_cpu_ptr(cgrp->rstat_base_cpu);
+	atomic_long_add(delta_exec, &rstatbc->bstat.cputime.sum_exec_runtime);
+	put_cpu_ptr(rstatbc);
 }
 
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
 
-	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
+	put_cpu_ptr(rstatbc);
 }
 
 /*
@@ -636,7 +617,7 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
  */
 static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 {
-	struct task_cputime *cputime = &bstat->cputime;
+	struct atomic_task_cputime *cputime = &bstat->cputime;
 	int i;
 
 	memset(bstat, 0, sizeof(*bstat));
@@ -650,20 +631,19 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
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
+		atomic_long_add(sys + user, &cputime->sum_exec_runtime);
 
 #ifdef CONFIG_SCHED_CORE
-		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
+		atomic64_add(cpustat[CPUTIME_FORCEIDLE], &bstat->forceidle_sum);
 #endif
-		bstat->ntime += cpustat[CPUTIME_NICE];
+		atomic64_add(cpustat[CPUTIME_NICE], &bstat->ntime);
 	}
 }
 
@@ -671,7 +651,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
 {
 #ifdef CONFIG_SCHED_CORE
-	u64 forceidle_time = bstat->forceidle_sum;
+	u64 forceidle_time = atomic64_read(&bstat->forceidle_sum);
 
 	do_div(forceidle_time, NSEC_PER_USEC);
 	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
@@ -682,31 +662,50 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	struct cgroup_base_stat bstat;
+	unsigned long long sum_exec_runtime;
+	u64 utime, stime, ntime;
 
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
+		cputime_adjust(&cputime, &cgrp->prev_cputime, &cputime.utime,
+			       &cputime.stime);
+		atomic64_set(&bstat.cputime.utime, cputime.utime);
+		atomic64_set(&bstat.cputime.stime, cputime.stime);
+	} else
 		root_cgroup_cputime(&bstat);
-	}
 
-	do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
-	do_div(bstat.cputime.utime, NSEC_PER_USEC);
-	do_div(bstat.cputime.stime, NSEC_PER_USEC);
-	do_div(bstat.ntime, NSEC_PER_USEC);
-
-	seq_printf(seq, "usage_usec %llu\n"
-			"user_usec %llu\n"
-			"system_usec %llu\n"
-			"nice_usec %llu\n",
-			bstat.cputime.sum_exec_runtime,
-			bstat.cputime.utime,
-			bstat.cputime.stime,
-			bstat.ntime);
+	sum_exec_runtime = atomic_long_read(&bstat.cputime.sum_exec_runtime);
+
+	do_div(sum_exec_runtime, NSEC_PER_USEC);
+
+	utime = atomic64_read(&bstat.cputime.utime);
+
+	do_div(utime, NSEC_PER_USEC);
+
+	stime = atomic64_read(&bstat.cputime.stime);
+
+	do_div(stime, NSEC_PER_USEC);
+
+	ntime = atomic64_read(&bstat.ntime);
+
+	do_div(ntime, NSEC_PER_USEC);
+
+	seq_printf(seq,
+		   "usage_usec %llu\n"
+		   "user_usec %llu\n"
+		   "system_usec %llu\n"
+		   "nice_usec %llu\n",
+		   sum_exec_runtime,
+		   utime,
+		   stime,
+		   ntime);
 
 	cgroup_force_idle_show(seq, &bstat);
 }
-- 
2.49.0


