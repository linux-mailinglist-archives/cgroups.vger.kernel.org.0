Return-Path: <cgroups+bounces-10838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19707BE894E
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70D1402417
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BB311955;
	Fri, 17 Oct 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCZUY45/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0C25B1DA
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704027; cv=none; b=Jj8auEacJXALJ1t7dQYZF1xA+JrFtz0UoizaD7u2orciEETVahbCx+9zY+ZkWF2oka1NF6xRBJqAB6NVb7wuuKPFFVzqMr3IUh/jMkzAeR7Ie/RCAInFFZVPui5VguAVGhqE+m8ie2FlTxuvrVignzbdGpdDpfkzW+Rm/JjGzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704027; c=relaxed/simple;
	bh=MA+ZFvNl4j2bqhlcFrUZEXBrhz0R4mtp8R9orXWBg+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBiZ57IPJIDa3Pzauf8cPeH5ENlbPDWt7hDD12Uxg9vP8zzqL267ijfD1/+++ZX8IqAyS9JnN0aWIT6RTaT7RMfmPpVKp6sCpBKGCJLDpgNdUhAgPLtPz2spuar2UMyZwvGXn4C0LPJ/Zoc7xtpsuBxedDkHRB1QNNL9O/hCiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCZUY45/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760704024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XQkmJKuk6FjrOcWrRKn1umJ+bry4bJqwXSlL2tail78=;
	b=XCZUY45/UR72IjeJikO00IQ17s69l7m9kdJwNumtLOZl51qNUOxMPKFnZE4NAL+zgwpVzo
	5sDuCKc3CkcQn62ux/fpyk79I2TrNCAjQXCvbER3aDS9ssj4N8UTSyF2giFYSN39zj0XsR
	vZ7zuOmJeVtUmoBfgwyxAg3em/C90Qo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-L9EMB0LGPqOlOz6ujHAB9w-1; Fri,
 17 Oct 2025 08:27:00 -0400
X-MC-Unique: L9EMB0LGPqOlOz6ujHAB9w-1
X-Mimecast-MFC-AGG-ID: L9EMB0LGPqOlOz6ujHAB9w_1760704018
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5F2818002DD;
	Fri, 17 Oct 2025 12:26:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.96])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E4971800446;
	Fri, 17 Oct 2025 12:26:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
Date: Fri, 17 Oct 2025 20:26:36 +0800
Message-ID: <20251017122636.17671-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When testing kexec-reboot on a 144 cpus machine with
isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
encounter the following bug:

[   97.114759] psci: CPU142 killed (polled 0 ms)
[   97.333236] Failed to offline CPU143 - error=-16
[   97.333246] ------------[ cut here ]------------
[   97.342682] kernel BUG at kernel/cpu.c:1569!
[   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
[   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
[   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
[   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
[   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
[   97.438028] sp : ffff800097c6b9a0
[   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
[   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
[   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
[   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
[   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
[   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
[   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
[   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
[   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
[   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
[   97.514379] Call trace:
[   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
[   97.521769]  machine_shutdown+0x20/0x38
[   97.525693]  kernel_kexec+0xc4/0xf0
[   97.529260]  __do_sys_reboot+0x24c/0x278
[   97.533272]  __arm64_sys_reboot+0x2c/0x40
[   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
[   97.542179]  do_el0_svc+0xb0/0xe8
[   97.545562]  el0_svc+0x44/0x1d0
[   97.548772]  el0t_64_sync_handler+0x120/0x130
[   97.553222]  el0t_64_sync+0x1a4/0x1a8
[   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
[   97.563191] ---[ end trace 0000000000000000 ]---
[   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
[   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
[   97.608502] PHYS_OFFSET: 0x80000000
[   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
[   97.617580] Memory Limit: none
[   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]

Tracking down this issue, I found that dl_bw_deactivate() returned
-EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
When a CPU is inactive, its rd is set to def_root_domain. For an
blocked-state deadline task (in this case, "cppc_fie"), it was not
migrated to CPU0, and its task_rq() information is stale. As a result,
its bandwidth is wrongly accounted into def_root_domain during domain
rebuild.

The key point is that root_domain is only tracked through active rq->rd.
To avoid using a global data structure to track all root_domains in the
system, we need a way to locate an active CPU within the corresponding
root_domain.

The following rules stand for deadline sub-system and help locating the
active cpu
  -1.any cpu belongs to a unique root domain at a given time
  -2.DL bandwidth checker ensures that the root domain has active cpus.

Now, let's examine the blocked-state task P.
If P is attached to a cpuset that is a partition root, it is
straightforward to find an active CPU.
If P is attached to a cpuset that has changed from 'root' to 'member',
the active CPUs are grouped into the parent root domain. Naturally, the
CPUs' capacity and reserved DL bandwidth are taken into account in the
ancestor root domain. (In practice, it may be unsafe to attach P to an
arbitrary root domain, since that domain may lack sufficient DL
bandwidth for P.) Again, it is straightforward to find an active CPU in
the ancestor root domain.

This patch groups CPUs into isolated and housekeeping sets. For the
housekeeping group, it walks up the cpuset hierarchy to find active CPUs
in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: cgroups@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 include/linux/cpuset.h  | 18 ++++++++++++++++++
 kernel/cgroup/cpuset.c  | 27 +++++++++++++++++++++++++++
 kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b51..7c00ebcdf85d9 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
 extern void cpuset_reset_sched_domains(void);
+extern void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -276,6 +277,23 @@ static inline void cpuset_reset_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline void task_get_rd_effective_cpus(struct task_struct *p,
+		struct cpumask *cpus)
+{
+	const struct cpumask *hk_msk;
+	struct cpumask msk;
+
+	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
+		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
+			/* isolated cpus belong to a root domain */
+			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
+			return;
+		}
+	}
+	cpumask_and(cpus, cpu_active_mask, hk_msk);
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675d..f7b18892ed093 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1102,6 +1102,33 @@ void cpuset_reset_sched_domains(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/* caller hold RCU read lock */
+void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus)
+{
+	const struct cpumask *hk_msk;
+	struct cpumask msk;
+	struct cpuset *cs;
+
+	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
+		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
+			/* isolated cpus belong to a root domain */
+			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
+			return;
+		}
+	}
+	/* In HK_TYPE_DOMAIN, cpuset can be applied */
+	cs = task_cs(p);
+	while (cs != &top_cpuset) {
+		if (is_sched_load_balance(cs))
+			break;
+		cs = parent_cs(cs);
+	}
+
+	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
+	cpumask_and(cpus, cs->effective_cpus, hk_msk);
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c75..0a35b165d42a0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq_flags rf;
 	struct rq *rq;
 	struct dl_bw *dl_b;
+	unsigned int cpu;
+	struct cpumask msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	rq = __task_rq_lock(p, &rf);
-
+	/* prevent race among cpu hotplug, changing of partition_root_state */
+	lockdep_assert_cpus_held();
+	/*
+	 * If @p is in blocked state, task_cpu() may be not active. In that
+	 * case, rq->rd does not trace a correct root_domain. On the other hand,
+	 * @p must belong to an root_domain at any given time, which must have
+	 * active rq, whose rq->rd traces the valid root domain.
+	 */
+	task_get_rd_effective_cpus(p, &msk);
+	cpu = cpumask_first_and(cpu_active_mask, &msk);
+	/*
+	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
+	 * check prevents CPU hot removal from deactivating all CPUs in that
+	 * domain.
+	 */
+	BUG_ON(cpu >= nr_cpu_ids);
+	rq = cpu_rq(cpu);
+	/*
+	 * This point is under the protection of cpu_hotplug_lock. Hence
+	 * rq->rd is stable.
+	 */
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
-
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-
 	raw_spin_unlock(&dl_b->lock);
-
-	task_rq_unlock(rq, p, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
 void dl_clear_root_domain(struct root_domain *rd)
-- 
2.49.0


