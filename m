Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE768C934
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 23:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFWOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 17:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBFWOy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 17:14:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBA17CD9
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 14:14:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so38492601ejc.2
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhiw+jubOvq1uJrkxqi7dpXCXQ7Pp14PB3qH+9iBvvk=;
        b=XGaKPmbL+LPNdhbIZ8gNyg5YsQ/9NfkANkq1Me2iOAgz6kMhGtq9KP5uTuMro2fsKV
         97wXmiwNztvKIsr1w/ZNLTY5Gxg9oylT/9WKs2eqsl0zM4DsMM/35gAcHEhazexIXZUH
         q+FmIXOW0ikTvR28HeB44B2X3kIRUiiMExS+6DuZddUMzM+b9pl8aVFA8kg5Z5mAPHuJ
         YMz3p9zhVUF2cfceZu5ZHiPpL1+PIriVHBvo6xZGr+WDk4CoPD8yCCr5snlJ4xcbN6W1
         HRrAJXhuQPMssea8gyc/xy8fY2rMbGRa+gRmRJOhSlD413QLVPC5z5mxDYDQMKX6CIBs
         Tmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhiw+jubOvq1uJrkxqi7dpXCXQ7Pp14PB3qH+9iBvvk=;
        b=1YvhIoGwy0vay0cKVbyOrEuvi19A5VhcXdf+N2ikHCA+EGJuV5teyDQdgbr6eBrlGq
         iiFZ+/5exITa74HEDrY8rXboW6gibf+8BCU+1K+15WihL3Dg75dxRP0rJ4KWc4pvf3yo
         4clNcnBXuYuyk5xcS+a+1zfbVuHqXmj19Km8AWIs6u1uXUNkxzihjLonIDhib7HrRITf
         sUevYGtQRxS9xqmtG3otdSVtknpBX3ji7aplHfYQMSU6b2k9Irpa1KrgYpx8hjM7qTYS
         gN9r1xVXqvxl0pfmGEDk30Kju8vs2qrfzrevDKfdonkAAlaDtmo6wXAhoabEOPpFboep
         rKEA==
X-Gm-Message-State: AO0yUKU5RAjWhg5zdHUX8XKZfg/8f6ayQwCPpf3DNwS73z8wYplsiPEz
        y0l0OxRropQP32N3hQmy9xPKkw==
X-Google-Smtp-Source: AK7set8nKifNoixIO1OR95D5ZT8RG9QYxkX7/QXPPznwnhZLt79MFEjgvQVv8RVJTucYIQ9//VQNzg==
X-Received: by 2002:a17:906:5013:b0:883:5b33:e019 with SMTP id s19-20020a170906501300b008835b33e019mr845210ejj.61.1675721690843;
        Mon, 06 Feb 2023 14:14:50 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906348400b007add62dafbasm5974260ejb.157.2023.02.06.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:14:50 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
Date:   Mon,  6 Feb 2023 22:14:28 +0000
Message-Id: <20230206221428.2125324-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
enabled rebuilding root domain on cpuset and hotplug operations to
correct deadline accounting.

Rebuilding root domain is a slow operation and we see 10+ of ms delays
on suspend-resume because of that (worst case captures 20ms which
happens often).

Since nothing is expected to change on suspend-resume operation; skip
rebuilding the root domains to regain the some of the time lost.

Achieve this by refactoring the code to pass whether dl accoutning needs
an update to rebuild_sched_domains(). And while at it, rename
rebuild_root_domains() to update_dl_rd_accounting() which I believe is
a more representative name since we are not really rebuilding the root
domains, but rather updating dl accounting at the root domain.

Some users of rebuild_sched_domains() will skip dl accounting update
now:

	* Update sched domains when relaxing the domain level in cpuset
	  which only impacts searching level in load balance
	* update sched domains when cpufreq governor changes and we need
	  to create the perf domains

Users in arch/x86 and arch/s390 are left with the old behavior.

Debugged-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Changes in v3:

	* Change the logic to avoid using cpuhp_tasks_frozen which can be racy
	  and have dependency on context
	* Refactor the code to pass whether dl accounting needs to be updated
	  down the call chain
	* Teach cpuset_force_rebuild() to take a reason argument and convert
	  the variable into int
	* Rename rebuild_root_domains() into update_dl_rd_accounting() as
	  that's what I believe it's only doing

v2 discussion: https://lore.kernel.org/lkml/20230120194822.962958-1-qyousef@layalina.io/
v1 discussion: https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/

 arch/s390/kernel/topology.c  |  2 +-
 arch/x86/kernel/itmt.c       |  6 ++---
 drivers/base/arch_topology.c |  2 +-
 include/linux/cpuset.h       | 12 ++++++----
 kernel/cgroup/cpuset.c       | 43 ++++++++++++++++++++----------------
 kernel/sched/core.c          |  2 +-
 kernel/sched/topology.c      |  2 +-
 7 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..29d57154a3f1 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -333,7 +333,7 @@ int arch_update_cpu_topology(void)
 
 static void topology_work_fn(struct work_struct *work)
 {
-	rebuild_sched_domains();
+	rebuild_sched_domains(true);
 }
 
 void topology_schedule_update(void)
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9ff480e94511..6f1446223697 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -56,7 +56,7 @@ static int sched_itmt_update_handler(struct ctl_table *table, int write,
 
 	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
 		x86_topology_update = true;
-		rebuild_sched_domains();
+		rebuild_sched_domains(true);
 	}
 
 	mutex_unlock(&itmt_update_mutex);
@@ -125,7 +125,7 @@ int sched_set_itmt_support(void)
 	sysctl_sched_itmt_enabled = 1;
 
 	x86_topology_update = true;
-	rebuild_sched_domains();
+	rebuild_sched_domains(true);
 
 	mutex_unlock(&itmt_update_mutex);
 
@@ -161,7 +161,7 @@ void sched_clear_itmt_support(void)
 		/* disable sched_itmt if we are no longer ITMT capable */
 		sysctl_sched_itmt_enabled = 0;
 		x86_topology_update = true;
-		rebuild_sched_domains();
+		rebuild_sched_domains(true);
 	}
 
 	mutex_unlock(&itmt_update_mutex);
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7d6e6657ffa..90d8a42335e6 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -253,7 +253,7 @@ int topology_update_cpu_topology(void)
 static void update_topology_flags_workfn(struct work_struct *work)
 {
 	update_topology = 1;
-	rebuild_sched_domains();
+	rebuild_sched_domains(true);
 	pr_debug("sched_domain hierarchy rebuilt, flags updated\n");
 	update_topology = 0;
 }
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..e30d4cd35ef7 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -18,6 +18,10 @@
 #include <linux/mmu_context.h>
 #include <linux/jump_label.h>
 
+#define CPUSET_FORCE_REBUILD_RESET		0
+#define CPUSET_FORCE_REBUILD_SUSPEND_RESUME	1
+#define CPUSET_FORCE_REBUILD_PRS_ERROR		2
+
 #ifdef CONFIG_CPUSETS
 
 /*
@@ -68,7 +72,7 @@ static inline bool cpusets_insane_config(void)
 
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
-extern void cpuset_force_rebuild(void);
+extern void cpuset_force_rebuild(int reason);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_read_lock(void);
@@ -132,7 +136,7 @@ static inline int cpuset_do_slab_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
-extern void rebuild_sched_domains(void);
+extern void rebuild_sched_domains(bool update_dl_accounting);
 
 extern void cpuset_print_current_mems_allowed(void);
 
@@ -187,7 +191,7 @@ static inline bool cpusets_insane_config(void) { return false; }
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_init_smp(void) {}
 
-static inline void cpuset_force_rebuild(void) { }
+static inline void cpuset_force_rebuild(int reason) { }
 
 static inline void cpuset_update_active_cpus(void)
 {
@@ -276,7 +280,7 @@ static inline bool current_cpuset_is_being_rebound(void)
 	return false;
 }
 
-static inline void rebuild_sched_domains(void)
+static inline void rebuild_sched_domains(bool update_dl_accounting)
 {
 	partition_sched_domains(1, NULL, NULL);
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706b..e5ddc8e11e5d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1079,7 +1079,7 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void update_dl_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
@@ -1117,11 +1117,13 @@ static void rebuild_root_domains(void)
 
 static void
 partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
+				    struct sched_domain_attr *dattr_new,
+				    bool update_dl_accounting)
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	if (update_dl_accounting)
+		update_dl_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
@@ -1136,7 +1138,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  *
  * Call with cpuset_rwsem held.  Takes cpus_read_lock().
  */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(bool update_dl_accounting)
 {
 	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
@@ -1185,19 +1187,19 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_and_rebuild_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr, update_dl_accounting);
 }
 #else /* !CONFIG_SMP */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(bool update_dl_accounting)
 {
 }
 #endif /* CONFIG_SMP */
 
-void rebuild_sched_domains(void)
+void rebuild_sched_domains(bool update_dl_accounting)
 {
 	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
-	rebuild_sched_domains_locked();
+	rebuild_sched_domains_locked(update_dl_accounting);
 	percpu_up_write(&cpuset_rwsem);
 	cpus_read_unlock();
 }
@@ -1681,7 +1683,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	rcu_read_unlock();
 
 	if (need_rebuild_sched_domains)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(true);
 }
 
 /**
@@ -2136,7 +2138,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
 		cs->relax_domain_level = val;
 		if (!cpumask_empty(cs->cpus_allowed) &&
 		    is_sched_load_balance(cs))
-			rebuild_sched_domains_locked();
+			rebuild_sched_domains_locked(false);
 	}
 
 	return 0;
@@ -2202,7 +2204,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(true);
 
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
@@ -2315,7 +2317,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
 
 	if (!sched_domain_rebuilt)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(true);
 out:
 	/*
 	 * Make partition invalid if an error happen
@@ -3389,11 +3391,11 @@ hotplug_update_tasks(struct cpuset *cs,
 		update_tasks_nodemask(cs);
 }
 
-static bool force_rebuild;
+static int force_rebuild;
 
-void cpuset_force_rebuild(void)
+void cpuset_force_rebuild(int reason)
 {
-	force_rebuild = true;
+	force_rebuild = reason;
 }
 
 /**
@@ -3489,7 +3491,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
 			notify_partition_change(cs, old_prs);
 		}
-		cpuset_force_rebuild();
+		cpuset_force_rebuild(CPUSET_FORCE_REBUILD_PRS_ERROR);
 	}
 
 	/*
@@ -3499,7 +3501,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	else if (is_partition_valid(parent) && is_partition_invalid(cs)) {
 		update_parent_subparts_cpumask(cs, partcmd_update, NULL, tmp);
 		if (is_partition_valid(cs))
-			cpuset_force_rebuild();
+			cpuset_force_rebuild(CPUSET_FORCE_REBUILD_PRS_ERROR);
 	}
 
 update_tasks:
@@ -3626,8 +3628,11 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 
 	/* rebuild sched domains if cpus_allowed has changed */
 	if (cpus_updated || force_rebuild) {
-		force_rebuild = false;
-		rebuild_sched_domains();
+		bool update_dl_accounting = cpus_updated ||
+				force_rebuild == CPUSET_FORCE_REBUILD_PRS_ERROR;
+
+		force_rebuild = CPUSET_FORCE_REBUILD_RESET;
+		rebuild_sched_domains(update_dl_accounting);
 	}
 
 	free_cpumasks(NULL, ptmp);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4580fe3e1d0c..d68eac04c851 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9485,7 +9485,7 @@ static void cpuset_cpu_active(void)
 		 * restore the original sched domains by considering the
 		 * cpuset configurations.
 		 */
-		cpuset_force_rebuild();
+		cpuset_force_rebuild(CPUSET_FORCE_REBUILD_SUSPEND_RESUME);
 	}
 	cpuset_update_active_cpus();
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d93c3379e901..bf33b84c511a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -214,7 +214,7 @@ void rebuild_sched_domains_energy(void)
 {
 	mutex_lock(&sched_energy_mutex);
 	sched_energy_update = true;
-	rebuild_sched_domains();
+	rebuild_sched_domains(false);
 	sched_energy_update = false;
 	mutex_unlock(&sched_energy_mutex);
 }
-- 
2.25.1

