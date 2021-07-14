Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732AC3C85AC
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhGNN5i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 09:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239474AbhGNN5h (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 664B3613BF;
        Wed, 14 Jul 2021 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626270886;
        bh=nN+laWYJ55VQlm+yl5T+0cjf8x5kqwjieMgSoGRktko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah7l3C8fRn/EWTF7/1PqXd0R79D0jxVbOHZn9cAnrLdaddRNkL4ZVFC0r5PUe5C5N
         9m5vNUkcHcDj12fLB5cvPgR1rTFRfp0iYYNICPnnTBEwP58pYO1xPm+QBhyLuAuFkv
         fzPZf0PLDGNeEUzyMFHpMTyIdEpNM897+zt/RjVxolEjOAXmAiPorrkS7krhZKCXKM
         aHsw1EEuYDGD/+2fxh7DKVlPoO1A/QqOhizV+GVNlX5J+He4vsLgqwKrqa2G1uZ0L7
         KgpLSaRWbiM+yWcb/9Ix1FiLHfFHAtHKI5L9KGESEAICTVpGbD2M028tLnZAi3Kzg5
         1tKeTVEDtTV9w==
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
Subject: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
Date:   Wed, 14 Jul 2021 15:54:20 +0200
Message-Id: <20210714135420.69624-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
References: <20210714135420.69624-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a new cpuset.isolation_mask file in order to be able to modify the
housekeeping cpumask for each individual isolation feature on runtime.
In the future this will include nohz_full, unbound timers,
unbound workqueues, unbound kthreads, managed irqs, etc...

Start with supporting domain exclusion and CPUs passed through
"isolcpus=".

The cpuset.isolation_mask defaults to 0. Setting it to 1 will exclude
the given cpuset from the domains (they will be attached to NULL domain).
As long as a CPU is part of any cpuset with cpuset.isolation_mask set to
1, it will remain isolated even if it overlaps with another cpuset that
has cpuset.isolation_mask  set to 0. The same applies to parent and
subdirectories.

If a cpuset is a subset of "isolcpus=", it automatically maps it and
cpuset.isolation_mask will be set to 1. This subset is then cleared from
the initial "isolcpus=" mask. The user is then free to override
cpuset.isolation_mask to 0 in order to revert the effect of "isolcpus=".

Here is an example of use where the CPU 7 has been isolated on boot and
get re-attached to domains later from cpuset:

	$ cat /proc/cmdline
		isolcpus=7
	$ cd /sys/fs/cgroup/cpuset
	$ mkdir cpu7
	$ cd cpu7
	$ cat cpuset.cpus
		0-7
	$ cat cpuset.isolation_mask
		0
	$ ls /sys/kernel/debug/domains/cpu7	# empty because isolcpus=7
	$ echo 7 > cpuset.cpus
	$ cat cpuset.isolation_mask	# isolcpus subset automatically mapped
		1
	$ echo 0 > cpuset.isolation_mask
	$ ls /sys/kernel/debug/domains/cpu7/
		domain0  domain1

CHECKME: Should we have individual cpuset.isolation.$feature files for
         each isolation feature instead of a single mask file?

CHECKME: The scheduler is unhappy when _every_ CPUs are isolated

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
 kernel/cgroup/cpuset.c | 111 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..ecb63be04408 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -82,6 +82,7 @@ struct cpuset {
 	struct cgroup_subsys_state css;
 
 	unsigned long flags;		/* "unsigned long" so bitops work */
+	unsigned long isol_flags;
 
 	/*
 	 * On default hierarchy:
@@ -258,6 +259,17 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_ISOL_DOMAIN,
+	CS_ISOL_MAX
+} isol_flagbits_t;
+
+static inline int is_isol_domain(const struct cpuset *cs)
+{
+	return test_bit(CS_ISOL_DOMAIN, &cs->isol_flags);
+}
+
 static inline int is_partition_root(const struct cpuset *cs)
 {
 	return cs->partition_root_state > 0;
@@ -269,6 +281,13 @@ static struct cpuset top_cpuset = {
 	.partition_root_state = PRS_ENABLED,
 };
 
+/*
+ * CPUs passed through "isolcpus=" on boot, waiting to be mounted
+ * as soon as we meet a cpuset directory whose cpus_allowed is a
+ * subset of "isolcpus="
+ */
+static cpumask_var_t unmounted_isolcpus_mask;
+
 /**
  * cpuset_for_each_child - traverse online children of a cpuset
  * @child_cs: loop cursor pointing to the current child
@@ -681,6 +700,39 @@ static inline int nr_cpusets(void)
 	return static_key_count(&cpusets_enabled_key.key) + 1;
 }
 
+static int update_domain_housekeeping_mask(void)
+{
+	struct cpuset *cp;	/* top-down scan of cpusets */
+	struct cgroup_subsys_state *pos_css;
+	cpumask_var_t domain_mask;
+
+	if (!zalloc_cpumask_var(&domain_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_andnot(domain_mask, cpu_possible_mask, unmounted_isolcpus_mask);
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
+		if (is_isol_domain(cp))
+			cpumask_andnot(domain_mask, domain_mask, cp->cpus_allowed);
+
+		if (cpumask_subset(cp->cpus_allowed, unmounted_isolcpus_mask)) {
+			unsigned long flags;
+			cpumask_andnot(unmounted_isolcpus_mask, unmounted_isolcpus_mask,
+				       cp->cpus_allowed);
+			spin_lock_irqsave(&callback_lock, flags);
+			cp->isol_flags |= BIT(CS_ISOL_DOMAIN);
+			spin_unlock_irqrestore(&callback_lock, flags);
+		}
+	}
+	rcu_read_unlock();
+
+	housekeeping_cpumask_set(domain_mask, HK_FLAG_DOMAIN);
+	free_cpumask_var(domain_mask);
+
+	return 0;
+}
+
 /*
  * generate_sched_domains()
  *
@@ -741,6 +793,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
 	int i, j, k;		/* indices for partition finding loops */
+	int err;
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -752,6 +805,10 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	dattr = NULL;
 	csa = NULL;
 
+	err = update_domain_housekeeping_mask();
+	if (err < 0)
+		pr_err("Can't update housekeeping cpumask\n");
+
 	/* Special case for the 99% of systems with one, full, sched domain */
 	if (root_load_balance && !top_cpuset.nr_subparts_cpus) {
 		ndoms = 1;
@@ -1449,7 +1506,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 		 * root as well.
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
-		    is_sched_load_balance(cp) &&
+		    (is_sched_load_balance(cp) || is_isol_domain(cs)) &&
 		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
 		    is_partition_root(cp)))
 			need_rebuild_sched_domains = true;
@@ -1935,6 +1992,30 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	return err;
 }
 
+/*
+ * update_isol_flags - read a 0 or a 1 in a file and update associated isol flag
+ * mask:	the new mask value to apply (see isol_flagbits_t)
+ * cs:		the cpuset to update
+ *
+ * Call with cpuset_mutex held.
+ */
+static int update_isol_flags(struct cpuset *cs, u64 mask)
+{
+	unsigned long old_mask = cs->isol_flags;
+
+	if (mask & ~(BIT_ULL(CS_ISOL_MAX) - 1))
+		return -EINVAL;
+
+	spin_lock_irq(&callback_lock);
+	cs->isol_flags = (unsigned long)mask;
+	spin_unlock_irq(&callback_lock);
+
+	if (mask ^ old_mask)
+		rebuild_sched_domains_locked();
+
+	return 0;
+}
+
 /*
  * update_prstate - update partititon_root_state
  * cs:	the cpuset to update
@@ -2273,6 +2354,9 @@ typedef enum {
 	FILE_MEMORY_PRESSURE,
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
+//CHECKME: should we have individual cpuset.isolation.$feature files
+//instead of a mask of features in a single file?
+	FILE_ISOLATION_MASK,
 } cpuset_filetype_t;
 
 static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
@@ -2314,6 +2398,9 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	case FILE_SPREAD_SLAB:
 		retval = update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
+	case FILE_ISOLATION_MASK:
+		retval = update_isol_flags(cs, val);
+		break;
 	default:
 		retval = -EINVAL;
 		break;
@@ -2481,6 +2568,8 @@ static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 		return is_spread_page(cs);
 	case FILE_SPREAD_SLAB:
 		return is_spread_slab(cs);
+	case FILE_ISOLATION_MASK:
+		return cs->isol_flags;
 	default:
 		BUG();
 	}
@@ -2658,6 +2747,13 @@ static struct cftype legacy_files[] = {
 		.private = FILE_MEMORY_PRESSURE_ENABLED,
 	},
 
+	{
+		.name = "isolation_mask",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_ISOLATION_MASK,
+	},
+
 	{ }	/* terminate */
 };
 
@@ -2834,9 +2930,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	if (is_partition_root(cs))
 		update_prstate(cs, 0);
 
-	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    is_sched_load_balance(cs))
-		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
+		if (is_sched_load_balance(cs))
+			update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+		if (is_isol_domain(cs))
+			update_isol_flags(cs, cs->isol_flags & ~BIT(CS_ISOL_DOMAIN));
+	}
 
 	if (cs->use_parent_ecpus) {
 		struct cpuset *parent = parent_cs(cs);
@@ -2873,6 +2972,9 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
+	cpumask_andnot(unmounted_isolcpus_mask, cpu_possible_mask,
+		       housekeeping_cpumask(HK_FLAG_DOMAIN));
+
 	spin_unlock_irq(&callback_lock);
 	percpu_up_write(&cpuset_rwsem);
 }
@@ -2932,6 +3034,7 @@ int __init cpuset_init(void)
 	top_cpuset.relax_domain_level = -1;
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&unmounted_isolcpus_mask, GFP_KERNEL));
 
 	return 0;
 }
-- 
2.25.1

