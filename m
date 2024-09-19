Return-Path: <cgroups+bounces-4908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FEB97CEE8
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E912846BA
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2024 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC718C33C;
	Thu, 19 Sep 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfS/rpgG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6024197A9B;
	Thu, 19 Sep 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782766; cv=none; b=kQ/Jaq1qSkAnDbmhdQ4jJP9IKcahTVwGB7yDfHC5rTLR2wwnXc5wLIMAvty8QDksa2V7JIwyauRV+Mt4Q7DkjgKhnWMsbC4a7LpDOHnmZhVJGl93l0TYOKx66yH98thb00TINxCZ5dJoZe9WxIPTLNWLXAFjD9Kfc2E92XPxsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782766; c=relaxed/simple;
	bh=qyOs0aZBTYslrbA17qV9cTYlXbol+LI0A8RI4+O0WKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug9AIu1RWY9w/swJkaEDRBc5yu/Z7BFtmaScTrGV3wBpfc88WjNPqh+aQJY5UWaNlmp4lXxVUjwxHTSJquAscraogmeL4TjpMLB1554zhYu8NzqqEblUNF4AItGKfXQw0eCZlUi/+uvxsBy/Fh93kDfG3iynnTFChHoYHF4js9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfS/rpgG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726782765; x=1758318765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyOs0aZBTYslrbA17qV9cTYlXbol+LI0A8RI4+O0WKw=;
  b=cfS/rpgG1V6G2RKATd0U0ZUeAcI1H2s+pBkZI1muL1hmwCHI6veTlJ35
   O3ize25O8HHsCRXL5xv4McQW9WNUKioA88XXIamPS0v1hH9n/03XyVvWY
   ntElBB2a8ipadiOPuYQEgAi0k0hqQOKQ8NF03uD8p/48BPyAI5+5fVDAb
   UU+GGj70NczCGceq4qaY5sjtykFIUUcmK1XAxP+hRaY3DV23w4svBdgnH
   ho55vo5/B45mR96/kBDOVRbbZCEKF47Yhquxf+IuI5Uc6Ukvy6k8PDDew
   FegG8ksLvSWG03+CyqAlh2uxJOxBPc9UrNTsfia2lWryTVH0ToDoYCxX8
   Q==;
X-CSE-ConnectionGUID: oYCJBcRaT9eT+EZOahnZvQ==
X-CSE-MsgGUID: Vt87eMYHR4e2GuAhnpWKTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25870779"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25870779"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:45 -0700
X-CSE-ConnectionGUID: AAGpMcFITHKVwwCl6Xg3rg==
X-CSE-MsgGUID: yAAnPFX+RXWmJ3nO+7qRJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74862583"
Received: from trevorcr-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.197])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:52:45 -0700
Date: Thu, 19 Sep 2024 14:52:43 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH RFC 2/2] cpu/bugs: cgroup: Add a cgroup knob to bypass CPU
 mitigations
Message-ID: <20240919-selective-mitigation-v1-2-1846cf41895e@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>

For cases where an admin wanting to bypass CPU mitigations for a specific
workload that they trust. Add a cgroup attribute "cpu.skip_mitigation" that
can only be set by a privileged user. When set, the CPU mitigations are
bypassed for all tasks in that cgroup.

Before setting this knob, the admin should be aware of possible security
risks like confused deputy attack on trusted interpreters, JIT engine,
etc.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/switch_to.h | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c       | 21 ++++++++++++++++++++
 include/linux/cgroup-defs.h      |  3 +++
 kernel/cgroup/cgroup.c           | 42 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c              |  2 +-
 5 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c3bd0c0758c9..7f32fd139644 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -46,6 +46,16 @@ struct fork_frame {
 	struct pt_regs regs;
 };
 
+extern inline void cpu_mitigation_skip(struct task_struct *prev, struct task_struct *next);
+
+#define prepare_arch_switch prepare_arch_switch
+
+static inline void prepare_arch_switch(struct task_struct *prev,
+				       struct task_struct *next)
+{
+	cpu_mitigation_skip(prev, next);
+}
+
 #define switch_to(prev, next, last)					\
 do {									\
 	((last) = __switch_to_asm((prev), (next)));			\
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45675da354f3..77eb4f6dc5c9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -128,6 +128,27 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
 
+inline void cpu_mitigation_skip(struct task_struct *prev,
+				struct task_struct *next)
+{
+	bool prev_skip = false, next_skip = false;
+
+	if (prev->mm)
+		prev_skip = task_dfl_cgroup(prev)->cpu_skip_mitigation;
+	if (next->mm)
+		next_skip = task_dfl_cgroup(next)->cpu_skip_mitigation;
+
+	if (!prev_skip && !next_skip)
+		return;
+	if (prev_skip == next_skip)
+		return;
+
+	if (next_skip)
+		wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64_unmitigated);
+	else
+		wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64_mitigated);
+}
+
 void __init cpu_select_mitigations(void)
 {
 	/*
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ae04035b6cbe..6a131a62f43c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -546,6 +546,9 @@ struct cgroup {
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
 #endif
 
+	/* Used to bypass the CPU mitigations for tasks in a cgroup */
+	bool cpu_skip_mitigation;
+
 	/* All ancestors including self */
 	struct cgroup *ancestors[];
 };
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..b745dbcb153e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2045,6 +2045,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	cgrp->dom_cgrp = cgrp;
 	cgrp->max_descendants = INT_MAX;
 	cgrp->max_depth = INT_MAX;
+	cgrp->cpu_skip_mitigation = 0;
 	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
 
@@ -3751,6 +3752,41 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+static int cpu_skip_mitigation_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	int ret = 0;
+
+	seq_printf(seq, "%d\n", cgrp->cpu_skip_mitigation);
+
+	return ret;
+}
+
+static ssize_t cgroup_skip_mitigation_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct cgroup *cgrp = of->kn->parent->priv;
+	struct cgroup_file_ctx *ctx = of->priv;
+	u64 skip_mitigation;
+	int ret;
+
+	/* Only privileged user in init namespace is allowed to set skip_mitigation */
+	if ((ctx->ns != &init_cgroup_ns) || !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = kstrtoull(buf, 0, &skip_mitigation);
+	if (ret)
+		return -EINVAL;
+
+	if (skip_mitigation > 1)
+		return -EINVAL;
+
+	cgrp->cpu_skip_mitigation = skip_mitigation;
+
+	return nbytes;
+}
+
 static int cpu_local_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
@@ -5290,6 +5326,12 @@ static struct cftype cgroup_base_files[] = {
 		.name = "cpu.stat.local",
 		.seq_show = cpu_local_stat_show,
 	},
+	{
+		.name = "cpu.skip_mitigation",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_skip_mitigation_show,
+		.write = cgroup_skip_mitigation_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..4b4109afbf7c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4994,7 +4994,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
-	prepare_arch_switch(next);
+	prepare_arch_switch(prev, next);
 }
 
 /**

-- 
2.34.1



