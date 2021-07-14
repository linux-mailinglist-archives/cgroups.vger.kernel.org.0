Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419D3C85A8
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhGNN5c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 09:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239428AbhGNN5c (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62533613C5;
        Wed, 14 Jul 2021 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270880;
        bh=CR7ZCJ2MCtQ/AkMPzJGPaJM3pFUk31mYc16dvoRJiAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD0/+ICSzE5NIOrIG3LjIIgCE6LrPX3Fzkl+8nVpGdsy8KGxMbSqk7zL5T8AvuG5v
         Gdik/IpLItXSl1IyH0qvJ1JtBN7Vf4oI+0Xt5zrwFxx3Ktfy0nw2eI5k1gdoOSVA3J
         c/tvNoJm71k9ceSW7w99H61ZTwdxlIVbMoZy+y+bBuR/QsZuzdoYdYQvTWFcbSaLdZ
         xtBVPCPEZ9aLov/9JBi+OR3wcOxnM8O8kfB6Bl8T8+1wsAjqtddX2ClyRkoyhacGLR
         05zedSjxA8DzhJCtcSA3PoFHp/mBymQElOOW33n6BfkvBY3o+6PKUFTIgis1sEVX7n
         fxEBm7Z2IvCAg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: [RFC PATCH 4/6] sched/isolation: Split domain housekeeping mask from the rest
Date:   Wed, 14 Jul 2021 15:54:18 +0200
Message-Id: <20210714135420.69624-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
References: <20210714135420.69624-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, move HK_FLAG_DOMAIN to its own cpumask. This will allow
to modify the set passed through "isolcpus=" kernel boot parameter on
runtime.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 kernel/sched/isolation.c | 54 +++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..c2bdf7e6dc39 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -12,6 +12,7 @@
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 static cpumask_var_t housekeeping_mask;
+static cpumask_var_t hk_domain_mask;
 static unsigned int housekeeping_flags;
 
 bool housekeeping_enabled(enum hk_flags flags)
@@ -26,7 +27,7 @@ int housekeeping_any_cpu(enum hk_flags flags)
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping_flags & flags) {
-			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
+			cpu = sched_numa_find_closest(housekeeping_cpumask(flags), smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
@@ -39,9 +40,13 @@ EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 
 const struct cpumask *housekeeping_cpumask(enum hk_flags flags)
 {
-	if (static_branch_unlikely(&housekeeping_overridden))
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		WARN_ON_ONCE((flags & HK_FLAG_DOMAIN) && (flags & ~HK_FLAG_DOMAIN));
+		if (housekeeping_flags & HK_FLAG_DOMAIN)
+			return hk_domain_mask;
 		if (housekeeping_flags & flags)
 			return housekeeping_mask;
+	}
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
@@ -50,7 +55,7 @@ void housekeeping_affine(struct task_struct *t, enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping_flags & flags)
-			set_cpus_allowed_ptr(t, housekeeping_mask);
+			set_cpus_allowed_ptr(t, housekeeping_cpumask(flags));
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
@@ -58,11 +63,13 @@ bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping_flags & flags)
-			return cpumask_test_cpu(cpu, housekeeping_mask);
+			return cpumask_test_cpu(cpu, housekeeping_cpumask(flags));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+
+
 void __init housekeeping_init(void)
 {
 	if (!housekeeping_flags)
@@ -91,28 +98,57 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 
 	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
-		alloc_bootmem_cpumask_var(&housekeeping_mask);
-		cpumask_andnot(housekeeping_mask,
-			       cpu_possible_mask, non_housekeeping_mask);
+		if (flags & ~HK_FLAG_DOMAIN) {
+			alloc_bootmem_cpumask_var(&housekeeping_mask);
+			cpumask_andnot(housekeeping_mask,
+				       cpu_possible_mask, non_housekeeping_mask);
+		}
+
+		if (flags & HK_FLAG_DOMAIN) {
+			alloc_bootmem_cpumask_var(&hk_domain_mask);
+			cpumask_andnot(hk_domain_mask,
+				       cpu_possible_mask, non_housekeeping_mask);
+		}
 
 		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
 		if (cpumask_empty(tmp)) {
 			pr_warn("Housekeeping: must include one present CPU, "
 				"using boot CPU:%d\n", smp_processor_id());
-			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			if (flags & ~HK_FLAG_DOMAIN)
+				__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			if (flags & HK_FLAG_DOMAIN)
+				__cpumask_set_cpu(smp_processor_id(), hk_domain_mask);
 			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		}
 	} else {
+		struct cpumask *prev;
+
 		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
 		if (cpumask_empty(tmp))
 			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
-		if (!cpumask_equal(tmp, housekeeping_mask)) {
+
+		if (housekeeping_flags == HK_FLAG_DOMAIN)
+			prev = hk_domain_mask;
+		else
+			prev = housekeeping_mask;
+
+		if (!cpumask_equal(tmp, prev)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
 			free_bootmem_cpumask_var(tmp);
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
+
+		if ((housekeeping_flags & HK_FLAG_DOMAIN) && (flags & ~HK_FLAG_DOMAIN)) {
+			alloc_bootmem_cpumask_var(&housekeeping_mask);
+			cpumask_copy(housekeeping_mask, hk_domain_mask);
+		}
+
+		if ((housekeeping_flags & ~HK_FLAG_DOMAIN) && (flags & HK_FLAG_DOMAIN)) {
+			alloc_bootmem_cpumask_var(&hk_domain_mask);
+			cpumask_copy(hk_domain_mask, housekeeping_mask);
+		}
 	}
 	free_bootmem_cpumask_var(tmp);
 
-- 
2.25.1

