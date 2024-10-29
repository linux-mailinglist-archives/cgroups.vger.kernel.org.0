Return-Path: <cgroups+bounces-5312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1A9B492E
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2541F2419B
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A00206045;
	Tue, 29 Oct 2024 12:10:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7F188CDC;
	Tue, 29 Oct 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203855; cv=none; b=bnF++LE9F9OhPLoIB66UBryFcS4ekzPKqXD35FUPZdDOtz7Hp8wsCsKctCty4bCE5s0g5Tr2ofXEd0ugHSVFor4i+nKJKPMCP6xTRA9bnBDU4sPwEx9fyMpPvwb4FO8ofNpt+eAlDMTCqoVZVziXlMQ2C1JDsxzHd2WEnXPoOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203855; c=relaxed/simple;
	bh=MbiK1bw0FS9qEgaVNQZCV2l0di8Aj9ncVei+cS34qE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUI4XUvVvRaY5QdJ/x1aTulcvGK322zbVWBnC5RWVcxfOfoiqzA3JgoG1XybBI5DcF5V9c5Wn2HGJBWbeeiupYRSm9uQwWDQoahK/P/syNHkcGvHp8/dDmgv+t0TX3L97APalppPMcTQUt2Cmn70EtD15G5kKsKfv4sdp0tqQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d51055097so3548193f8f.3;
        Tue, 29 Oct 2024 05:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203851; x=1730808651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP5DVUrc3kFalHBStDqduUrggU9TQbXPQshmhYZ4DAc=;
        b=amDPXiYCPnEfKai71Eheksgp9RlvZt0Q/aeCssd0Ta7dS6uSwLoeMw4qLxj/9cN51F
         WV/WLA008BQ94z7SveOsYMySRyfGE8n0ucNuJJUyVzv8BLjbuxfjce/o5mMD/atIjyod
         eC1sqDw3rTc9zV5EZp3bsUFaQKhlptHbLgAJxWbTsesyK0qsZr5BzZK3oluGt5hHj+R5
         UU6Tu7WG2wlea4RWhH7cEOLM2/0zxoCo6hzh8R/v8sLzTFDxNRrEAzbNuKphbqprwiwy
         09IdtBZtc5fIR+sHpOSQvQuqo/7awdOMDHjJRRpvk0xAS2mUXNl2UYOqii9Rg8OZEJKu
         bjRw==
X-Forwarded-Encrypted: i=1; AJvYcCUoOoX7GPr5iWC1IhzpKlm+COqqmQ3emFfVT8OVbBWnjEeb3TVu12njPwiZwIwp3XODevl7ZXMkF6TFOwo=@vger.kernel.org, AJvYcCX/Dk1cwcvzRdEO4+8P8gX7yPUISarAJmLK2e3HCi6/g7ApxwPPFVfod6xBTmwt8JG6ovItqiW9O8byOt18@vger.kernel.org, AJvYcCXbPvirFGVfSsKOe7gGB45Cbk9N96A5cRQelDiM7mbGDXBaPE8ZeSJBdPGaYNVGG88nCFPcHd44@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOStuHo+RF6Wk++iL1bMUOuC8nguDxE3SZCh++c/EN7HoLRLA
	VLAURwbSy1vsNgHwKyRkpD2hscyuEkDBoRRNCvx6bwpFuSk5rni9
X-Google-Smtp-Source: AGHT+IHMVJkI1Udd91JsboiPCQJSBz+lKnfqwcr6OTXouH5yCazFegWgELWV2xXzwGKTHyyOf4yozg==
X-Received: by 2002:adf:e34b:0:b0:37d:498a:a23f with SMTP id ffacd0b85a97d-380611f58e4mr8657943f8f.53.1730203851307;
        Tue, 29 Oct 2024 05:10:51 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13309sm12362152f8f.3.2024.10.29.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:10:50 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 3/3] genirq/cpuhotplug: Adjust managed irqs according to change of housekeeping CPU
Date: Tue, 29 Oct 2024 14:05:34 +0200
Message-ID: <20241029120534.3983734-4-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029120534.3983734-1-costa.shul@redhat.com>
References: <20241029120534.3983734-1-costa.shul@redhat.com>
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

v3:
- rename `int managed_irq_affinity_adjust()`
  to `void managed_irq_adjust_activity()`
- Addresses Thomas Gleixner's comments:
- add locking to managed_irq_adjust_activity()
- add blk_mq_flush_on_cpu() to flush queues associated
  with isolated interrupts.
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
 block/blk-mq.c           | 19 ++++++++
 include/linux/blk-mq.h   |  2 +
 include/linux/cpu.h      |  4 ++
 include/linux/irq.h      |  2 +
 kernel/cgroup/cpuset.c   |  1 +
 kernel/cpu.c             |  2 +-
 kernel/irq/cpuhotplug.c  | 99 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c | 14 ++++--
 8 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2909c51a13bd..484b6488739b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3756,6 +3756,25 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/*
+ * Draft function to flush data in
+ * block multi-queues to perform isolation
+ * of specified cpu from managed interrupts.
+ */
+void blk_mq_flush_on_cpu(int cpu)
+{
+	// TODO: Thoroughly test this code with high test coverage.
+	/* Calling:
+	 * - blk_mq_hctx_notify_offline()
+	 * - blk_mq_hctx_notify_dead()
+	 * - bio_cpu_dead()
+	 */
+	cpuhp_invoke_callback(cpu, CPUHP_AP_BLK_MQ_ONLINE, false, NULL, NULL);
+	cpuhp_invoke_callback(cpu, CPUHP_BLK_MQ_DEAD, false, NULL, NULL);
+	cpuhp_invoke_callback(cpu, CPUHP_BIO_DEAD, false, NULL, NULL);
+	blk_softirq_cpu_dead(cpu);
+}
+
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
 	if (!(hctx->flags & BLK_MQ_F_STACKING))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131f..286cd2a0ba84 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -929,6 +929,8 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
+void blk_mq_flush_on_cpu(int cpu);
+
 bool __blk_should_fake_timeout(struct request_queue *q);
 static inline bool blk_should_fake_timeout(struct request_queue *q)
 {
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index bdcec1732445..f4504b3c129a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -203,4 +203,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
+				 bool bringup, struct hlist_node *node,
+				 struct hlist_node **lastp);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d73bbb7797d0..3974f95c1783 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -619,6 +619,8 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 # define irq_affinity_online_cpu	NULL
 #endif
 
+void managed_irq_adjust_activity(struct cpumask *enable_mask);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5066397899c9..8364369976e4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -95,6 +95,7 @@ static struct list_head remote_children;
 #define HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER)  | BIT(HK_TYPE_RCU)  |\
 				 BIT(HK_TYPE_SCHED)  | BIT(HK_TYPE_MISC) |\
 				 BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_WQ)   |\
+				 BIT(HK_TYPE_MANAGED_IRQ) |\
 				 BIT(HK_TYPE_KTHREAD))
 
 /*
diff --git a/kernel/cpu.c b/kernel/cpu.c
index afc920116d42..44c7da0e1b8d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -171,7 +171,7 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
  *
  * Return: %0 on success or a negative errno code
  */
-static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
+int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 				 bool bringup, struct hlist_node *node,
 				 struct hlist_node **lastp)
 {
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index b92cf6a76351..9233694d541a 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -279,3 +279,102 @@ int irq_affinity_online_cpu(unsigned int cpu)
 
 	return 0;
 }
+
+/*
+ * managed_irq_isolate() - Deactivate managed interrupts if necessary
+ */
+// derived from migrate_one_irq(), irq_needs_fixup(), irq_fixup_move_pending().
+// Finally, this function can be considered for
+// merging back with migrate_one_irq().
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
+	 * mask and therefore might keep/reassign the irq to the isolated
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
+/** managed_irq_adjust_activity() - Deactivate of restore managed interrupts
+ * according to change of housekeeping cpumask.
+ *
+ * @enable_mask:	CPUs for which interrupts should be restored
+ */
+void managed_irq_adjust_activity(struct cpumask *enable_mask)
+{
+	unsigned int irq;
+
+	for_each_active_irq(irq) {
+		struct irq_desc *desc = irq_to_desc(irq);
+		unsigned long flags;
+		unsigned int cpu;
+
+		if (!desc)
+			continue;
+
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		for_each_cpu(cpu, enable_mask)
+			irq_restore_affinity_of_irq(desc, cpu);
+		managed_irq_isolate(desc);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	}
+}
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ebbb215505e8..d1a0f1b104da 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <linux/blk-mq.h>
+
 #undef pr_fmt
 #define pr_fmt(fmt)    "%s:%d: %s " fmt, __FILE__, __LINE__, __func__
 
@@ -152,10 +154,16 @@ static int housekeeping_update(enum hk_type type, const struct cpumask *update)
 	if (!static_branch_unlikely(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
 
-	/* Add here code to update dependent subsystems with
-	 * changes of the housekeeping masks.
-	 */
+	switch (type) {
+	case HK_TYPE_MANAGED_IRQ:
+		int cpu;
 
+		for_each_cpu(cpu, &masks->disable)
+			blk_mq_flush_on_cpu(cpu);
+		managed_irq_adjust_activity(&masks->enable);
+		break;
+	default:
+	}
 	kfree(masks);
 
 	return 0;
-- 
2.47.0


