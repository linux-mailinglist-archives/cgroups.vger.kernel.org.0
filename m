Return-Path: <cgroups+bounces-17305-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jc+OFoMMPmqU/AgAu9opvQ
	(envelope-from <cgroups+bounces-17305-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 07:22:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C294B6CA4CF
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 07:22:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="Q9d+PxB/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17305-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17305-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DAEE308F820
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 05:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9735AC12;
	Fri, 26 Jun 2026 05:19:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C90396D0D;
	Fri, 26 Jun 2026 05:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451182; cv=none; b=cAdwUhiTbY4hmbWtenHI3dO//fts67Gl0I6WzeZjAPhVjSfDZ5VwuN29lQb/s1INczhqg+HD3dzCX603EWS2zARq/3pG+nCfY4w/OH/v4V1bPDjjRo3abMa4g4oflJTqxWmtU8CAdo8YmKESXvnLds1dToHrdknd+2zLanAO6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451182; c=relaxed/simple;
	bh=W8BzGb2FcD0I19qOBWu9nbh+u4GBqhHLUMSCCd/l2q0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVLfopsvqJoPP7z0Yi80K1BqDWr02XasF3zZJj+5TzTeDA07XwALebnsCTsdY7je4B71aHfya8LsJN1nlm0AklMD2WTkaFCoP1BpcfuLTvPHzYYVUZxc+jYGo/xSWZJyZtfQP5hclQCQN/1j27jVy27ierL05B8PAxczxcAr1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q9d+PxB/; arc=none smtp.client-ip=52.35.192.45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782451181; x=1813987181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GxllBR+JzulmYQ8FCwnGzoicpgPU5G3UD+1kWGsNT4s=;
  b=Q9d+PxB/DgdSJM83ey0zg2L61AMOQTaKuieLWs9C1PLn6EJpVg+zZDCB
   oKLt2C/gIHVG+NX1dCD4RlldhUP+/My3sDaH/JMXBXvtMAIEglhE6HGQA
   MkopeswcOpYLdJfApooMqY9srLcf/gaJ7Is7eFNft0RpkhwwzwW1NLjd1
   pjU5LUkMonUBm7kYiphmUYXAKz6YOTphmbdwhW8SHtTazdxbuV5dr1oXB
   L8J4CgaGpVHlIeeorS7EWpsRynkz8lawycejQnxjnxX4jDQtBg3Y1RKAH
   Eli38ICSNd673k06rNhuLWxTfOD6vKgxNxtycGPWc4/A4VzKjT54STKAp
   A==;
X-CSE-ConnectionGUID: 1kyqx6/tSnihpLEJSh+ylw==
X-CSE-MsgGUID: J096OgYwTJyQaGCqUHa6CQ==
X-IronPort-AV: E=Sophos;i="6.24,225,1774310400"; 
   d="scan'208";a="22315685"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:19:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:24332]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id 99cfbc80-6ccf-4a71-9e57-fa332fdfedc1; Fri, 26 Jun 2026 05:19:40 +0000 (UTC)
X-Farcaster-Flow-ID: 99cfbc80-6ccf-4a71-9e57-fa332fdfedc1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 26 Jun 2026 05:19:40 +0000
Received: from dev-dsk-liuyuxua-1a-259f0406.eu-west-1.amazon.com
 (172.19.101.236) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Fri, 26 Jun 2026
 05:19:36 +0000
From: Yuxuan Liu <liuyuxua@amazon.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fernand Sieber <sieberf@amazon.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Alexander Graf <graf@amazon.de>, "Misha
 Karataiev" <karataev@amazon.com>, Lilit Janpoladyan <lilitj@amazon.de>,
	<nh-open-source@amazon.com>, Yuxuan Liu <liuyuxua@amazon.com>
Subject: [PATCH] sched/core: Add core_sibling_idle accounting
Date: Fri, 26 Jun 2026 05:19:30 +0000
Message-ID: <20260626051930.40415-1-liuyuxua@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17305-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:tj@kernel.org,m:lizefan.x@bytedance.com,m:hannes@cmpxchg.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:bristot@redhat.com,m:vschneid@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sieberf@amazon.com,m:dwmw@amazon.co.uk,m:graf@amazon.de,m:karataev@amazon.com,m:lilitj@amazon.de,m:nh-open-source@amazon.com,m:liuyuxua@amazon.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[liuyuxua@amazon.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuyuxua@amazon.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C294B6CA4CF

When a VM runs on one SMT thread and core scheduling leaves the sibling
idle because no compatible workload can share the core, existing metrics
(forced idle time) only report this cost if another task is actively
waiting. Without waiting tasks, the stranded capacity looks like free
capacity to external fleet management software, leading it to place
additional workloads onto hosts that are already effectively fully
loaded. Add core_sibling_idle to capture all idle time caused by core
scheduling constraints so orchestrators can make accurate placement
decisions.

To avoid redundant bookkeeping, forceidle and sibling_idle accounting
are consolidated into a single function __sched_core_account_idle().
Both metrics share a common timestamp (core_sibling_idle_start) and
occupation count (core_sibling_idle_occupation), replacing the separate
core_forceidle_start and core_forceidle_occupation fields. The
forceidle subset is derived from core_forceidle_count within the same
accounting pass.

The new metric is exposed as core_sched.sibling_idle_usec in cgroup v2
cpu.stat, alongside the existing core_sched.force_idle_usec. The
per-task core_sibling_idle_sum is also available via /proc/<pid>/sched
for debugging.

== Testing ==
Testing is done using QEMU.

=== Scenario 1: No CPU Contention ===
The system has 2 CPUs, with 1 VM (2 vCPUs) that uses core scheduling and
runs an infinite loop pinned to vCPU 0:
taskset -c 0 sh -c 'while true; do :; done' &

In the VM's cpu.stat, its core_sched.force_idle_usec is near 0 (199 us)
while core_sched.sibling_idle_usec (117796370 us) is identical to
usage_usec (123946273 us).

=== Scenario 2: With CPU Contention ===
Same setup as Scenario 1 except with 2 VMs (2 vCPUs each).

Both VMs have identical core_sched.force_idle_usec and
core_sched.sibling_idle_usec in their respective cpu.stat, with
sibling_idle_usec being slightly higher.

Signed-off-by: Yuxuan Liu <liuyuxua@amazon.com>
---
 include/linux/cgroup-defs.h |  1 +
 include/linux/kernel_stat.h |  2 ++
 include/linux/sched.h       |  1 +
 kernel/cgroup/rstat.c       | 11 ++++++
 kernel/sched/core.c         | 31 ++++++++---------
 kernel/sched/core_sched.c   | 67 +++++++++++++++++++++++++------------
 kernel/sched/cputime.c      | 12 +++++++
 kernel/sched/debug.c        |  1 +
 kernel/sched/sched.h        | 17 ++++++----
 9 files changed, 100 insertions(+), 43 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c0c2b26725d0f..b65c910cbd872 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -301,6 +301,7 @@ struct cgroup_base_stat {
 
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_sum;
+	u64 sibling_idle_sum;
 #endif
 };
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9e..0e1386a9816ff 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -30,6 +30,7 @@ enum cpu_usage_stat {
 	CPUTIME_GUEST_NICE,
 #ifdef CONFIG_SCHED_CORE
 	CPUTIME_FORCEIDLE,
+	CPUTIME_SIBLING_IDLE,
 #endif
 	NR_STATS,
 };
@@ -132,6 +133,7 @@ extern void account_idle_ticks(unsigned long ticks);
 
 #ifdef CONFIG_SCHED_CORE
 extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
+extern void __account_sibling_idle_time(struct task_struct *tsk, u64 delta);
 #endif
 
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fad3aad97c7b0..5b1a1c247b12a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -544,6 +544,7 @@ struct sched_statistics {
 
 #ifdef CONFIG_SCHED_CORE
 	u64				core_forceidle_sum;
+	u64				core_sibling_idle_sum;
 #endif
 #endif /* CONFIG_SCHEDSTATS */
 } ____cacheline_aligned;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c32439b855f5d..29ef399d1c7e7 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -326,6 +326,7 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
+	dst_bstat->sibling_idle_sum += src_bstat->sibling_idle_sum;
 #endif
 }
 
@@ -337,6 +338,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
+	dst_bstat->sibling_idle_sum -= src_bstat->sibling_idle_sum;
 #endif
 }
 
@@ -430,6 +432,9 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	case CPUTIME_FORCEIDLE:
 		rstatc->bstat.forceidle_sum += delta_exec;
 		break;
+	case CPUTIME_SIBLING_IDLE:
+		rstatc->bstat.sibling_idle_sum += delta_exec;
+		break;
 #endif
 	default:
 		break;
@@ -472,6 +477,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
+		bstat->sibling_idle_sum += cpustat[CPUTIME_SIBLING_IDLE];
 #endif
 	}
 }
@@ -483,6 +489,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	struct cgroup_base_stat bstat;
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_time;
+	u64 sibling_idle_time;
 #endif
 
 	if (cgroup_parent(cgrp)) {
@@ -492,6 +499,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 			       &utime, &stime);
 #ifdef CONFIG_SCHED_CORE
 		forceidle_time = cgrp->bstat.forceidle_sum;
+		sibling_idle_time = cgrp->bstat.sibling_idle_sum;
 #endif
 		cgroup_rstat_flush_release();
 	} else {
@@ -501,6 +509,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		stime = bstat.cputime.stime;
 #ifdef CONFIG_SCHED_CORE
 		forceidle_time = bstat.forceidle_sum;
+		sibling_idle_time = bstat.sibling_idle_sum;
 #endif
 	}
 
@@ -509,6 +518,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	do_div(stime, NSEC_PER_USEC);
 #ifdef CONFIG_SCHED_CORE
 	do_div(forceidle_time, NSEC_PER_USEC);
+	do_div(sibling_idle_time, NSEC_PER_USEC);
 #endif
 
 	seq_printf(seq, "usage_usec %llu\n"
@@ -518,6 +528,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 
 #ifdef CONFIG_SCHED_CORE
 	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+	seq_printf(seq, "core_sched.sibling_idle_usec %llu\n", sibling_idle_time);
 #endif
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d558e43aedcf2..ba2b7b15d871d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -369,7 +369,7 @@ static void __sched_core_flip(bool enabled)
 		for_each_cpu(t, smt_mask)
 			cpu_rq(t)->core_enabled = enabled;
 
-		cpu_rq(cpu)->core->core_forceidle_start = 0;
+		cpu_rq(cpu)->core->core_sibling_idle_start = 0;
 
 		sched_core_unlock(cpu, &flags);
 
@@ -6124,18 +6124,19 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
-	if (rq->core->core_forceidle_count) {
+	if (rq->core->core_sibling_idle_occupation) {
 		if (!core_clock_updated) {
 			update_rq_clock(rq->core);
 			core_clock_updated = true;
 		}
-		sched_core_account_forceidle(rq);
-		/* reset after accounting force idle */
-		rq->core->core_forceidle_start = 0;
-		rq->core->core_forceidle_count = 0;
-		rq->core->core_forceidle_occupation = 0;
+		sched_core_account_idle(rq);
+		rq->core->core_sibling_idle_start = 0;
+		rq->core->core_sibling_idle_occupation = 0;
+	}
+	if (rq->core->core_forceidle_count) {
 		need_sync = true;
 		fi_before = true;
+		rq->core->core_forceidle_count = 0;
 	}
 
 	/*
@@ -6221,9 +6222,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
-	if (schedstat_enabled() && rq->core->core_forceidle_count) {
-		rq->core->core_forceidle_start = rq_clock(rq->core);
-		rq->core->core_forceidle_occupation = occ;
+	if (schedstat_enabled() && occ < cpumask_weight(smt_mask)) {
+		rq->core->core_sibling_idle_start = rq_clock(rq->core);
+		rq->core->core_sibling_idle_occupation = occ;
 	}
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;
@@ -6480,14 +6481,14 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	core_rq->core_cookie               = rq->core_cookie;
 	core_rq->core_forceidle_count      = rq->core_forceidle_count;
 	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
-	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
 
 	/*
-	 * Accounting edge for forced idle is handled in pick_next_task().
+	 * Accounting edge for sibling idle is handled in pick_next_task().
 	 * Don't need another one here, since the hotplug thread shouldn't
 	 * have a cookie.
 	 */
-	core_rq->core_forceidle_start = 0;
+	core_rq->core_sibling_idle_occupation = rq->core_sibling_idle_occupation;
+	core_rq->core_sibling_idle_start = 0;
 
 	/* install new leader */
 	for_each_cpu(t, smt_mask) {
@@ -10071,8 +10072,8 @@ void __init sched_init(void)
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle_count = 0;
-		rq->core_forceidle_occupation = 0;
-		rq->core_forceidle_start = 0;
+		rq->core_sibling_idle_occupation = 0;
+		rq->core_sibling_idle_start = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498f..f9aa119b52afd 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -237,38 +237,59 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 #ifdef CONFIG_SCHEDSTATS
 
 /* REQUIRES: rq->core's clock recently updated. */
-void __sched_core_account_forceidle(struct rq *rq)
+/*
+ * Account core scheduling idle cost.  Both forceidle (idle sibling has
+ * waiting tasks) and sibling_idle (any idle sibling) are derived from
+ * the same time delta and scaled by their respective idle counts.
+ * A single loop charges both metrics to each running cookied task.
+ */
+void __sched_core_account_idle(struct rq *rq)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
+	unsigned int occ = rq->core->core_sibling_idle_occupation;
+	unsigned int fi_count = rq->core->core_forceidle_count;
+	unsigned int smt_width, idle_count;
 	u64 delta, now = rq_clock(rq->core);
+	u64 fi_delta = 0, si_delta = 0;
 	struct rq *rq_i;
 	struct task_struct *p;
 	int i;
 
 	lockdep_assert_rq_held(rq);
 
-	WARN_ON_ONCE(!rq->core->core_forceidle_count);
-
-	if (rq->core->core_forceidle_start == 0)
+	if (rq->core->core_sibling_idle_start == 0)
 		return;
 
-	delta = now - rq->core->core_forceidle_start;
+	delta = now - rq->core->core_sibling_idle_start;
 	if (unlikely((s64)delta <= 0))
 		return;
 
-	rq->core->core_forceidle_start = now;
+	if (WARN_ON_ONCE(!occ))
+		return;
 
-	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
-		/* can't be forced idle without a running task */
-	} else if (rq->core->core_forceidle_count > 1 ||
-		   rq->core->core_forceidle_occupation > 1) {
-		/*
-		 * For larger SMT configurations, we need to scale the charged
-		 * forced idle amount since there can be more than one forced
-		 * idle sibling and more than one running cookied task.
-		 */
-		delta *= rq->core->core_forceidle_count;
-		delta = div_u64(delta, rq->core->core_forceidle_occupation);
+	smt_width = cpumask_weight(smt_mask);
+	idle_count = smt_width - occ;
+	if (!idle_count)
+		return;
+
+	rq->core->core_sibling_idle_start = now;
+
+	/*
+	 * For SMT-2 with one idle sibling (the common case), both
+	 * idle_count and occ are 1, so si_delta == fi_delta == delta
+	 * with no division needed.  For larger SMT configurations, we
+	 * scale by the respective idle count / occupation since there
+	 * can be more than one idle sibling and more than one running
+	 * cookied task.
+	 */
+	si_delta = delta;
+	if (idle_count > 1 || occ > 1)
+		si_delta = div_u64(delta * idle_count, occ);
+
+	if (fi_count) {
+		fi_delta = delta;
+		if (fi_count > 1 || occ > 1)
+			fi_delta = div_u64(delta * fi_count, occ);
 	}
 
 	for_each_cpu(i, smt_mask) {
@@ -279,22 +300,24 @@ void __sched_core_account_forceidle(struct rq *rq)
 			continue;
 
 		/*
-		 * Note: this will account forceidle to the current cpu, even
-		 * if it comes from our SMT sibling.
+		 * Note: this will account idle time to the current cpu,
+		 * even if it comes from our SMT sibling.
 		 */
-		__account_forceidle_time(p, delta);
+		__account_sibling_idle_time(p, si_delta);
+		if (fi_delta)
+			__account_forceidle_time(p, fi_delta);
 	}
 }
 
 void __sched_core_tick(struct rq *rq)
 {
-	if (!rq->core->core_forceidle_count)
+	if (!rq->core->core_sibling_idle_occupation)
 		return;
 
 	if (rq != rq->core)
 		update_rq_clock(rq->core);
 
-	__sched_core_account_forceidle(rq);
+	__sched_core_account_idle(rq);
 }
 
 #endif /* CONFIG_SCHEDSTATS */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b453f8a6a7c76..2a3500323c3c4 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -243,6 +243,18 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
 
 	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
 }
+
+/*
+ * Account for sibling idle time due to core scheduling.
+ *
+ * REQUIRES: schedstat is enabled.
+ */
+void __account_sibling_idle_time(struct task_struct *p, u64 delta)
+{
+	__schedstat_add(p->stats.core_sibling_idle_sum, delta);
+
+	task_group_account_field(p, CPUTIME_SIBLING_IDLE, delta);
+}
 #endif
 
 /*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 115e266db76bf..2c3bf256308dc 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1059,6 +1059,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 #ifdef CONFIG_SCHED_CORE
 		PN_SCHEDSTAT(core_forceidle_sum);
+		PN_SCHEDSTAT(core_sibling_idle_sum);
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65ff0254659ac..c52effdb2e172 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1156,8 +1156,13 @@ struct rq {
 	unsigned long		core_cookie;
 	unsigned int		core_forceidle_count;
 	unsigned int		core_forceidle_seq;
-	unsigned int		core_forceidle_occupation;
-	u64			core_forceidle_start;
+	/*
+	 * Shared start timestamp and occupation for both forceidle and
+	 * sibling_idle accounting.  Set whenever occupation < SMT width
+	 * (any sibling is idle), not just when core_forceidle_count > 0.
+	 */
+	unsigned int		core_sibling_idle_occupation;
+	u64			core_sibling_idle_start;
 #endif
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
@@ -1966,12 +1971,12 @@ static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 
 #if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
 
-extern void __sched_core_account_forceidle(struct rq *rq);
+extern void __sched_core_account_idle(struct rq *rq);
 
-static inline void sched_core_account_forceidle(struct rq *rq)
+static inline void sched_core_account_idle(struct rq *rq)
 {
 	if (schedstat_enabled())
-		__sched_core_account_forceidle(rq);
+		__sched_core_account_idle(rq);
 }
 
 extern void __sched_core_tick(struct rq *rq);
@@ -1984,7 +1989,7 @@ static inline void sched_core_tick(struct rq *rq)
 
 #else
 
-static inline void sched_core_account_forceidle(struct rq *rq) {}
+static inline void sched_core_account_idle(struct rq *rq) {}
 
 static inline void sched_core_tick(struct rq *rq) {}
 
-- 
2.47.3


