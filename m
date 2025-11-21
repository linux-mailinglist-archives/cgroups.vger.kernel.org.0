Return-Path: <cgroups+bounces-12147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3BBC773A1
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 05:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id DDEFD29104
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 04:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B92E1F08;
	Fri, 21 Nov 2025 04:07:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7192D7398;
	Fri, 21 Nov 2025 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763698020; cv=none; b=UW3FIdBlhsLrZOIC+GWWUHKlS4dtHUTR1uZT4F719oJ4TJzSqcPp9HBuZzOuZpkzqyfoxSIdBCKtuf8LZuqz4xxv90cehRLhkg1PcbniqMloRX0oKFh64Roz0sMGWkQS6iYsZ3vmvfCA03K2sjbcB91nLvV2LnC7PDzf4BZTQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763698020; c=relaxed/simple;
	bh=gDmGQjmlP+mFE3sO3gDTPk54MKTO9RjdwSAw2R/xDCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdpee9krbZfo7j2nGJk8aIG+RCx1BmGTPkQI1U3V2cgIay8Yy9qrVS8vGiVVn74zw7Hr7MZvd/392x3c9TUBEoqWEqcj36W44gyxVW8Jem96T7kf8vELA1+DAi84UNABgQPcqbXMb9sVx/bradc53YSMMacsqdViYvA4vs5PQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id A34448B2A15; Fri, 21 Nov 2025 12:06:56 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cgroups@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH v2] cgroup: Add preemption protection to css_rstat_updated()
Date: Fri, 21 Nov 2025 12:06:55 +0800
Message-ID: <20251121040655.89584-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs do not disable preemption, they only disable migration.
Therefore, when running the cgroup_hierarchical_stats selftest, a
warning [1] is generated.

The css_rstat_updated() function is lockless and reentrant. However,
as Tejun pointed out [2], preemption-related considerations need to
be considered. Since css_rstat_updated() can be called from BPF where
preemption is not disabled by its framework and it has already been
exposed as a kfunc to BPF programs, introducing a new kfunc like bpf_xx
will break existing uses. Thus, we directly make css_rstat_updated()
preempt-safe here.

[1]:
~/tools/testing/selftests/bpf$
test_progs -a cgroup_hierarchical_stats

...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 382 at kernel/cgroup/rstat.c:84
Modules linked in:
RIP: 0010:css_rstat_updated+0x9d/0x160
...
PKRU: 55555554
Call Trace:
 <TASK>
 bpf_prog_16a1c2d081688506_counter+0x143/0x14e
 bpf_trampoline_6442524909+0x4b/0xb7
 cgroup_attach_task+0x5/0x330
 ? __cgroup_procs_write+0x1d7/0x2f0
 cgroup_procs_write+0x17/0x30
 cgroup_file_write+0xa6/0x2d0
 kernfs_fop_write_iter+0x188/0x240
 vfs_write+0x2da/0x5a0
 ksys_write+0x77/0x100
 __x64_sys_write+0x19/0x30
 x64_sys_call+0x79/0x26a0
 do_syscall_64+0x89/0x790
 ? irqentry_exit+0x77/0xb0
 ? __this_cpu_preempt_check+0x13/0x20
 ? lockdep_hardirqs_on+0xce/0x170
 ? irqentry_exit_to_user_mode+0xf2/0x290
 ? irqentry_exit+0x77/0xb0
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
---[ end trace 0000000000000000 ]---

[2]: https://lore.kernel.org/cgroups/445b0d155b7a3cb84452aa7010669e293e8c37db@linux.dev/T/

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1 -> v2: Add preemption protection instread of dropping preemption
          assert
v1: https://lore.kernel.org/cgroups/445b0d155b7a3cb84452aa7010669e293e8c37db@linux.dev/T/
---
 kernel/cgroup/rstat.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a198e40c799b..ec68c653545c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -52,22 +52,7 @@ static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
 	return per_cpu_ptr(&rstat_backlog_list, cpu);
 }
 
-/**
- * css_rstat_updated - keep track of updated rstat_cpu
- * @css: target cgroup subsystem state
- * @cpu: cpu on which rstat_cpu was updated
- *
- * Atomically inserts the css in the ss's llist for the given cpu. This is
- * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
- * will be processed at the flush time to create the update tree.
- *
- * NOTE: if the user needs the guarantee that the updater either add itself in
- * the lockless list or the concurrent flusher flushes its updated stats, a
- * memory barrier is needed before the call to css_rstat_updated() i.e. a
- * barrier after updating the per-cpu stats and before calling
- * css_rstat_updated().
- */
-__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+static void __css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	struct llist_head *lhead;
 	struct css_rstat_cpu *rstatc;
@@ -122,6 +107,28 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	llist_add(&rstatc->lnode, lhead);
 }
 
+/**
+ * css_rstat_updated - keep track of updated rstat_cpu
+ * @css: target cgroup subsystem state
+ * @cpu: cpu on which rstat_cpu was updated
+ *
+ * Atomically inserts the css in the ss's llist for the given cpu. This is
+ * reentrant safe i.e. safe against softirq, hardirq and nmi. The ss's llist
+ * will be processed at the flush time to create the update tree.
+ *
+ * NOTE: if the user needs the guarantee that the updater either add itself in
+ * the lockless list or the concurrent flusher flushes its updated stats, a
+ * memory barrier is needed before the call to css_rstat_updated() i.e. a
+ * barrier after updating the per-cpu stats and before calling
+ * css_rstat_updated().
+ */
+__bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+{
+	preempt_disable();
+	__css_rstat_updated(css, cpu);
+	preempt_enable();
+}
+
 static void __css_process_update_tree(struct cgroup_subsys_state *css, int cpu)
 {
 	/* put @css and all ancestors on the corresponding updated lists */
-- 
2.43.0


