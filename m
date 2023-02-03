Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0768A6DD
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjBCXY3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 18:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjBCXYZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 18:24:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022BA6B95;
        Fri,  3 Feb 2023 15:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64CBDB82C3E;
        Fri,  3 Feb 2023 23:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9CBC4339C;
        Fri,  3 Feb 2023 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675466660;
        bh=5mfuvzilUAVBkGo0ZWPYhZeDAukGUsrghp/qA6pszYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkU0EAwRBbDobptNxdtqG8IUDyyAi6q32c/DJolHqOekQseebfUIRRFJBS+GrQqyQ
         6sMTnj7bjxABHFHiBDQndb7w4mdUsHNlO4HDXgmbJrhoMiOralMMO5k31g+dwO+1pc
         haJbl9dlKSwRRGM1KRrcLxemTHKZ/PUn0vFIEp+iTU1+w2zXQzBWx7jSinAs6UBQ85
         V3fasTjul1wWvhiHNJaebZ7ZmZ+jHqV6zYqkwLj0X0suT4jazhA5o+Kvd+Yh43WdfJ
         mpuwxhyG6tc2nyiAwk3CCjkwE68Xeya6xdqHSGYNov1LOfYYqFC3agQpsSNxUp+4MO
         R7W8hrXg5ov+w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] sched/isolation: Merge individual nohz_full features into a common housekeeping flag
Date:   Sat,  4 Feb 2023 00:24:08 +0100
Message-Id: <20230203232409.163847-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203232409.163847-1-frederic@kernel.org>
References: <20230203232409.163847-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The individual isolation features turned on by nohz_full were initially
split in order for each of them to be tunable through cpusets. However
plans have changed in favour of an interface (be it cpusets or sysctl)
grouping all these features to be turned on/off altogether. Then should
the need ever arise, the interface can still be expanded to handle the
individual isolation features.

Therefore the current isolation split between tick/timer/workqueue/rcu/
kthreads/misc doesn't make sense anymore. Gather them all into a common
flag gathering the kernel noise that is turned off through nohz_full=
and later runtime interface.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kvm/x86.c              |  2 +-
 drivers/char/random.c           |  2 +-
 drivers/pci/pci-driver.c        |  2 +-
 include/linux/sched/isolation.h |  7 +------
 include/net/ip_vs.h             |  4 ++--
 kernel/cpu.c                    |  4 ++--
 kernel/kthread.c                |  4 ++--
 kernel/rcu/tasks.h              |  2 +-
 kernel/rcu/tree_plugin.h        |  6 +++---
 kernel/sched/core.c             | 12 ++++++------
 kernel/sched/fair.c             |  6 +++---
 kernel/sched/isolation.c        | 22 ++++++----------------
 kernel/watchdog.c               |  2 +-
 kernel/workqueue.c              |  2 +-
 net/core/net-sysfs.c            |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c  |  2 +-
 16 files changed, 33 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index da4bbd043a7b..e3e989eed872 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9347,7 +9347,7 @@ int kvm_arch_init(void *opaque)
 	}
 
 	if (pi_inject_timer == -1)
-		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
+		pi_inject_timer = housekeeping_enabled(HK_TYPE_KERNEL_NOISE);
 #ifdef CONFIG_X86_64
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index ce3ccd172cc8..d6b2145712bd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1300,7 +1300,7 @@ static void __cold try_to_generate_entropy(void)
 			preempt_disable();
 
 			/* Only schedule callbacks on timer CPUs that are online. */
-			cpumask_and(&timer_cpus, housekeeping_cpumask(HK_TYPE_TIMER), cpu_online_mask);
+			cpumask_and(&timer_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE), cpu_online_mask);
 			num_cpus = cpumask_weight(&timer_cpus);
 			/* In very bizarre case of misconfiguration, fallback to all online. */
 			if (unlikely(num_cpus == 0)) {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a2ceeacc33eb..e8711ec206d9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -378,7 +378,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			goto out;
 		}
 		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_TYPE_WQ),
+			    housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
 			    housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 		cpu = cpumask_any_and(cpumask_of_node(node),
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed..b645cc81fe01 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -6,15 +6,10 @@
 #include <linux/tick.h>
 
 enum hk_type {
-	HK_TYPE_TIMER,
-	HK_TYPE_RCU,
-	HK_TYPE_MISC,
+	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_SCHED,
-	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
-	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KTHREAD,
 	HK_TYPE_MAX
 };
 
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index c6c61100d244..41773b13577b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1177,7 +1177,7 @@ static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
 	if (ipvs->est_cpulist_valid)
 		return ipvs->sysctl_est_cpulist;
 	else
-		return housekeeping_cpumask(HK_TYPE_KTHREAD);
+		return housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 }
 
 static inline int sysctl_est_nice(struct netns_ipvs *ipvs)
@@ -1284,7 +1284,7 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 
 static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
 {
-	return housekeeping_cpumask(HK_TYPE_KTHREAD);
+	return housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 }
 
 static inline int sysctl_est_nice(struct netns_ipvs *ipvs)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..023d5ef8f3fd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1524,8 +1524,8 @@ int freeze_secondary_cpus(int primary)
 	cpu_maps_update_begin();
 	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
-		if (!housekeeping_cpu(primary, HK_TYPE_TIMER))
-			primary = housekeeping_any_cpu(HK_TYPE_TIMER);
+		if (!housekeeping_cpu(primary, HK_TYPE_KERNEL_NOISE))
+			primary = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
 	} else {
 		if (!cpu_online(primary))
 			primary = cpumask_first(cpu_online_mask);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..0e52ae05fdba 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -355,7 +355,7 @@ static int kthread(void *_create)
 	 * back to default in case they have been changed.
 	 */
 	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
-	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -722,7 +722,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fe9840d90e96..e2f74ace62a2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -537,7 +537,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_tasks *rtp = arg;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_TYPE_RCU);
+	housekeeping_affine(current, HK_TYPE_KERNEL_NOISE);
 	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7b0fe741a088..29276afeb8d3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1241,9 +1241,9 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
 			cpumask_set_cpu(cpu, cm);
-	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 	if (cpumask_empty(cm)) {
-		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
+		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 		if (outgoingcpu >= 0)
 			cpumask_clear_cpu(outgoingcpu, cm);
 	}
@@ -1301,5 +1301,5 @@ static void rcu_bind_gp_kthread(void)
 {
 	if (!tick_nohz_full_enabled())
 		return;
-	housekeeping_affine(current, HK_TYPE_RCU);
+	housekeeping_affine(current, HK_TYPE_KERNEL_NOISE);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..d4b822c8387f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1067,13 +1067,13 @@ int get_nohz_timer_target(void)
 	struct sched_domain *sd;
 	const struct cpumask *hk_mask;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TIMER)) {
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
 		if (!idle_cpu(cpu))
 			return cpu;
 		default_cpu = cpu;
 	}
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
@@ -1089,7 +1089,7 @@ int get_nohz_timer_target(void)
 	}
 
 	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+		default_cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
 	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
@@ -5553,7 +5553,7 @@ void scheduler_tick(void)
 	unsigned long thermal_pressure;
 	u64 resched_latency;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
 	sched_clock_tick();
@@ -5679,7 +5679,7 @@ static void sched_tick_start(int cpu)
 	int os;
 	struct tick_work *twork;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -5700,7 +5700,7 @@ static void sched_tick_stop(int cpu)
 	struct tick_work *twork;
 	int os;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..03f70ee6314f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11021,7 +11021,7 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notice that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED not set
+ * - HK_TYPE_KERNEL_NOISE CPUs are used for this task, because HK_TYPE_SCHED not set
  *   anywhere yet.
  */
 
@@ -11030,7 +11030,7 @@ static inline int find_new_ilb(void)
 	int ilb;
 	const struct cpumask *hk_mask;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
 
@@ -11046,7 +11046,7 @@ static inline int find_new_ilb(void)
 
 /*
  * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
- * idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * idle CPU in the HK_TYPE_KERNEL_NOISE housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..2353ec381c96 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,15 +9,10 @@
  */
 
 enum hk_flags {
-	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
-	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
-	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
+	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 	HK_FLAG_SCHED		= BIT(HK_TYPE_SCHED),
-	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -88,7 +83,7 @@ void __init housekeeping_init(void)
 
 	static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping.flags & HK_FLAG_TICK)
+	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
 		sched_tick_offload_init();
 
 	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
@@ -111,7 +106,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	int err = 0;
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 			pr_warn("Housekeeping: nohz unsupported."
 				" Build with CONFIG_NO_HZ_FULL\n");
@@ -163,7 +158,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			housekeeping_setup_type(type, housekeeping_staging);
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE))
 		tick_nohz_full_setup(non_housekeeping_mask);
 
 	housekeeping.flags |= flags;
@@ -179,12 +174,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 
 static int __init housekeeping_nohz_full_setup(char *str)
 {
-	unsigned long flags;
-
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
-
-	return housekeeping_setup(str, flags);
+	return housekeeping_setup(str, HK_FLAG_KERNEL_NOISE);
 }
 __setup("nohz_full=", housekeeping_nohz_full_setup);
 
@@ -198,7 +188,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK;
+			flags |= HK_FLAG_KERNEL_NOISE;
 			continue;
 		}
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..fc40a0ed8d04 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -859,7 +859,7 @@ void __init lockup_detector_init(void)
 		pr_info("Disabling watchdog on nohz_full cores by default\n");
 
 	cpumask_copy(&watchdog_cpumask,
-		     housekeeping_cpumask(HK_TYPE_TIMER));
+		     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 
 	if (!watchdog_nmi_probe())
 		nmi_watchdog_available = true;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895deca271..f58b4544e7f7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6003,7 +6003,7 @@ void __init workqueue_init_early(void)
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
+	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca55dd747d6c..4cd630884201 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -853,7 +853,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 
 	if (!cpumask_empty(mask)) {
 		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
 			return -EINVAL;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 2a5ed71c82c3..2896ad3d8b59 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1991,7 +1991,7 @@ static int ipvs_proc_est_cpumask_get(struct ctl_table *table, void *buffer,
 	if (ipvs->est_cpulist_valid)
 		mask = *valp;
 	else
-		mask = (struct cpumask *)housekeeping_cpumask(HK_TYPE_KTHREAD);
+		mask = (struct cpumask *)housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 	ret = scnprintf(buffer, size, "%*pbl\n", cpumask_pr_args(mask));
 
 	mutex_unlock(&ipvs->est_mutex);
-- 
2.34.1

