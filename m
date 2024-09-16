Return-Path: <cgroups+bounces-4896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573E97A227
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D640B24C97
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429015665D;
	Mon, 16 Sep 2024 12:23:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B815749A;
	Mon, 16 Sep 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489428; cv=none; b=bFEOUdpVG9SyT0Gzc/pAY0Kx/e5l37O86hXy8aABzU6Gcj8E8NuXXF9XPy23byvHIH7Byt5O8r6rBnptEHQqMXXyeBBVpUmOuGZvaY0LrbDakRZjpfqcEcuECh80NgcWwLnbnqLFjrb+N45mX+vqzI9fVvCASOIGseNGucL4AjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489428; c=relaxed/simple;
	bh=P7LkNy+NZSM2MrtRwNsi5xmMBEBwBhE+EM+OKKDCbyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqKpRocMNnEwOuqqk3G0z2e+1sDoaQbvkt0eJzKaFhGIBGCuiQz1H3ApsSZbyIVvnkTyo+E10pgComo3OdyojDEfuoIDen67iikr4ISdygeX8jbkLvJYAOEBHl1XksWH671k+G0KFzuR2gdpYcRPjDXru1RnsDomUIXrHMpfpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so25771195e9.1;
        Mon, 16 Sep 2024 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489425; x=1727094225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDfojy5CrgHlgs0fxt38qSv2a++PUan1QC4a76dOnDc=;
        b=Jh1gqQ6xJ/fOufl1ZEIfxCwXW2+IwvDCljBHDirgOqkIx7mpQaHQwRRI1gAxnQGD/d
         SwgsbhmKZr2WF6pgf20N6stLqkn6HHlutkSatBHq6h1jVOmGPKWUeR06O56oMjxON8Mu
         nddAHn5n5D5VV6aMWXasmBpXPyTHZ76g+edUzi7tfTzKONoa8/ySJ8m6Aky9Cs8Ii5F1
         RMJiILtwULEyeQOH5QnOePuiOztiOoWYjRuL1MS1YCceqMEM/DM9yqguAwPqIJNEWIeM
         CPiXrJFtzu/B7XI6TUaJu2B5TKSClrwx0x+vW1y20oAwVNrPrH8OSr81huP/6Kh98wVq
         vy/g==
X-Forwarded-Encrypted: i=1; AJvYcCVymmR+XW2o0Hp1Q1jFN4u+hVQEIKQ01BvQJhlIHKf76s6ad1yzv/eiDglFKOMDN4AC+9YpdDqZmXw4M+Md@vger.kernel.org, AJvYcCWKP8KQNlSBxQ9gTNY9+vtCru7nIT8rXOa8K0RviQtduWLFYzBhaMb6C+E0BflPNv5ZywSsi0xM@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbfUEVEAs0gMVPNOgzkMuZPMI6zeYllZVME9oeLnZ//ABL8xL
	RywgkbXEPe4BSt2BwKGGI1420xSD5eNaqVSp+X5uu2ReelWuDTRf
X-Google-Smtp-Source: AGHT+IFx/jTnwae8GjD9s+HXc1nBltwBGmeNBzQI1ep4kLkettAY/xLPtxREJvJrF8iUt004m0leaQ==
X-Received: by 2002:a5d:4a52:0:b0:374:bde6:d375 with SMTP id ffacd0b85a97d-378d61f0d54mr5541099f8f.29.1726489424339;
        Mon, 16 Sep 2024 05:23:44 -0700 (PDT)
Received: from costa-tp.. ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800243sm7117272f8f.86.2024.09.16.05.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:23:43 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 2/3] genirq/cpuhotplug: Adjust managed irqs according to change of housekeeping CPU
Date: Mon, 16 Sep 2024 15:20:43 +0300
Message-ID: <20240916122044.3056787-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240916122044.3056787-1-costa.shul@redhat.com>
References: <20240916122044.3056787-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupts disturb real-time tasks on affined cpus.
To ensure CPU isolation for real-time tasks, interrupt handling must
be adjusted accordingly.
Non-managed interrupts can be configured from userspace,
while managed interrupts require adjustments in kernelspace.

Adjust status of managed interrupts according change
of housekeeping CPUs to support dynamic CPU isolation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

The following code is a proof of concept to validate
and review the correctness of the approach to solving the problem.

C++ comments denote temporary comments.

v2:
- refactor irq_affinity_adjust():
- add more comments
- add managed_irq_isolate() derived from migrate_one_irq(),
  irq_needs_fixup() and irq_fixup_move_pending()
- use irq_set_affinity() instead of irq_set_affinity_locked
- Addressed Gleixner's comments:
- use `struct cpumask *` instead of `cpumask_var_t` in function signature
- remove locking in irq_affinity_adjust()

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-5-costa.shul@redhat.com/
---
 include/linux/irq.h      |  2 +
 kernel/cgroup/cpuset.c   |  1 +
 kernel/irq/cpuhotplug.c  | 95 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c | 10 ++++-
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f80957b6..4eb2e765dbd95 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -619,6 +619,8 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 # define irq_affinity_online_cpu	NULL
 #endif
 
+int managed_irq_affinity_adjust(struct cpumask *enable_mask);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bf60bdc973dd6..73b06b2cd91e3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -90,6 +90,7 @@ static struct list_head remote_children;
 #define HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER)  | BIT(HK_TYPE_RCU)  |\
 				 BIT(HK_TYPE_SCHED)  | BIT(HK_TYPE_MISC) |\
 				 BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_WQ)   |\
+				 BIT(HK_TYPE_MANAGED_IRQ) |\
 				 BIT(HK_TYPE_KTHREAD))
 
 /*
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index ec2cdcd20bee7..adbe1f3e5bd22 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -252,3 +252,98 @@ int irq_affinity_online_cpu(unsigned int cpu)
 
 	return 0;
 }
+
+/*
+ * managed_irq_isolate() - Deactivate managed interrupts if necessary
+ */
+// derived from migrate_one_irq, irq_needs_fixup, irq_fixup_move_pending
+static int managed_irq_isolate(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	const struct cpumask *a;
+	bool maskchip;
+	int err;
+
+	/*
+	 * Deactivate if:
+	 * - Interrupt is managed
+	 * - Interrupt is not per cpu
+	 * - Interrupt is started
+	 * - Effective affinity mask includes isolated CPUs
+	 */
+	if (!irqd_affinity_is_managed(d) || irqd_is_per_cpu(d) || !irqd_is_started(d)
+	    || cpumask_subset(irq_data_get_effective_affinity_mask(d),
+			      housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+		return 0;
+	// TBD: it is required?
+	/*
+	 * Complete an eventually pending irq move cleanup. If this
+	 * interrupt was moved in hard irq context, then the vectors need
+	 * to be cleaned up. It can't wait until this interrupt actually
+	 * happens and this CPU was involved.
+	 */
+	irq_force_complete_move(desc);
+
+	if (irqd_is_setaffinity_pending(d)) {
+		irqd_clr_move_pending(d);
+		if (cpumask_intersects(desc->pending_mask,
+		    housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+			a = irq_desc_get_pending_mask(desc);
+	} else {
+		a = irq_data_get_affinity_mask(d);
+	}
+
+	maskchip = chip->irq_mask && !irq_can_move_pcntxt(d) && !irqd_irq_masked(d);
+	if (maskchip)
+		chip->irq_mask(d);
+
+	if (!cpumask_intersects(a, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ))) {
+		/*
+		 * Shut managed interrupt down and leave the affinity untouched.
+		 * The effective affinity is reset to the first online CPU.
+		 */
+		irqd_set_managed_shutdown(d);
+		irq_shutdown_and_deactivate(desc);
+		return 0;
+	}
+
+	/*
+	 * Do not set the force argument of irq_do_set_affinity() as this
+	 * disables the masking of offline CPUs from the supplied affinity
+	 * mask and therefore might keep/reassign the irq to the outgoing
+	 * CPU.
+	 */
+	err = irq_do_set_affinity(d, a, false);
+	if (err)
+		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
+				    d->irq, err);
+
+	if (maskchip)
+		chip->irq_unmask(d);
+
+	return err;
+}
+
+/** managed_irq_affinity_adjust() - Deactivate of restore managed interrupts
+ * according to change of housekeeping cpumask.
+ *
+ * @enable_mask:	CPUs for which interrupts should be restored
+ */
+int managed_irq_affinity_adjust(struct cpumask *enable_mask)
+{
+	unsigned int irq;
+
+	for_each_active_irq(irq) {
+		struct irq_desc *desc = irq_to_desc(irq);
+		unsigned int cpu;
+
+		for_each_cpu(cpu, enable_mask)
+			irq_restore_affinity_of_irq(desc, cpu);
+		raw_spin_lock(&desc->lock);
+		managed_irq_isolate(desc);
+		raw_spin_unlock(&desc->lock);
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3f24921b929a0..cd72300ec8b99 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -130,6 +130,8 @@ static void __init housekeeping_setup_type(enum hk_type type,
  */
 static int housekeeping_update(enum hk_type type, const struct cpumask *update)
 {
+	int err = 0;
+
 	struct {
 		struct cpumask changed;
 		struct cpumask enable;
@@ -149,9 +151,15 @@ static int housekeeping_update(enum hk_type type, const struct cpumask *update)
 	if (!static_branch_unlikely(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
 
+	switch (type) {
+	case HK_TYPE_MANAGED_IRQ:
+		err = managed_irq_affinity_adjust(&masks->enable);
+		break;
+	default:
+	}
 	kfree(masks);
 
-	return 0;
+	return err;
 }
 
 static int __init housekeeping_setup(char *str, unsigned long flags)
-- 
2.45.0


