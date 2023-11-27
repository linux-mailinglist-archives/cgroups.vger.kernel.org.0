Return-Path: <cgroups+bounces-563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3C7F9837
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD61C2085D
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30546BA;
	Mon, 27 Nov 2023 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJjeHxRI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3E12F
	for <cgroups@vger.kernel.org>; Sun, 26 Nov 2023 20:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701058841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAfo+PH8YddN+favmmuzXyUVuAnYnZIJF7f/6iibylI=;
	b=SJjeHxRIKGSDOjhqVxn2YWDwDVt/d6Xi1G4ZZx2ms9YPJ0pBbVl7lNXpKTT7FOW91wvIkz
	oaA22yhKl3CV4PtCZFuqGYgOHpTcD0s4ZkzHHAvZWaItdGOJ06jpIjgu6EMAHOpDhf1bQP
	qEkNXgu+R1pWQOW+m7Cl1ugHezOKBfg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-4Nw5EQhbM4S_rLoEBLAohg-1; Sun,
 26 Nov 2023 23:20:35 -0500
X-MC-Unique: 4Nw5EQhbM4S_rLoEBLAohg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74BC11C0433B;
	Mon, 27 Nov 2023 04:20:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.84])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C6A2D10E46;
	Mon, 27 Nov 2023 04:20:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 1/2] cgroup/cpuset: Make callback_lock a raw_spinlock_t
Date: Sun, 26 Nov 2023 23:19:55 -0500
Message-Id: <20231127041956.266026-2-longman@redhat.com>
In-Reply-To: <20231127041956.266026-1-longman@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

All the callback_lock critical sections are pretty small and there
shouldn't be much contention on that lock. Make it a raw_spinlock_t to
avoid additional locking overhead on PREEMPT_RT kernel.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 102 ++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2a16df86c55c..e34bbb0e2f24 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -445,7 +445,7 @@ void cpuset_unlock(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
-static DEFINE_SPINLOCK(callback_lock);
+static DEFINE_RAW_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
@@ -1588,7 +1588,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	if (cs->use_parent_ecpus) {
@@ -1597,7 +1597,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		cs->use_parent_ecpus = false;
 		parent->child_ecpus_count--;
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
@@ -1625,7 +1625,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, subpartitions_cpus));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
 					       NULL, tmp->new_cpus);
@@ -1633,7 +1633,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	if (!cs->prs_err)
 		cs->prs_err = PERR_INVCPUS;
 	reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
@@ -1680,12 +1680,12 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 		       cpumask_subset(top_cpuset.effective_cpus, tmp->addmask)))
 		goto invalidate;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (adding)
 		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
 		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
@@ -2034,7 +2034,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (old_prs != new_prs) {
 		cs->partition_root_state = new_prs;
 		if (new_prs <= 0)
@@ -2055,7 +2055,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		parent->nr_subparts += subparts_delta;
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
@@ -2134,11 +2134,11 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 			/*
 			 * Invalidate child partition
 			 */
-			spin_lock_irq(&callback_lock);
+			raw_spin_lock_irq(&callback_lock);
 			make_partition_invalid(child);
 			cs->nr_subparts--;
 			child->nr_subparts = 0;
-			spin_unlock_irq(&callback_lock);
+			raw_spin_unlock_irq(&callback_lock);
 			notify_partition_change(child, old_prs);
 			continue;
 		}
@@ -2195,9 +2195,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * The case when exclusive_cpus isn't set is handled later.
 		 */
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs)) {
-			spin_lock_irq(&callback_lock);
+			raw_spin_lock_irq(&callback_lock);
 			compute_effective_exclusive_cpumask(cp, NULL);
-			spin_unlock_irq(&callback_lock);
+			raw_spin_unlock_irq(&callback_lock);
 		}
 
 		old_prs = new_prs = cp->partition_root_state;
@@ -2295,7 +2295,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			new_prs = cp->partition_root_state;
 		}
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		/*
@@ -2307,7 +2307,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				    cp->cpus_allowed, parent->effective_xcpus);
 		else if (new_prs < 0)
 			reset_partition_data(cp);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
 
@@ -2536,12 +2536,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 				       trialcs->effective_cpus, &tmp);
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
 	if ((old_prs > 0) && !is_partition_valid(cs))
 		reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus/effective_xcpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, hier_flags);
@@ -2636,12 +2636,12 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		remote_partition_check(cs, trialcs->effective_xcpus,
 				       trialcs->effective_cpus, &tmp);
 	}
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->exclusive_cpus, trialcs->exclusive_cpus);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
 	if ((old_prs > 0) && !is_partition_valid(cs))
 		reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/*
 	 * Call update_cpumasks_hier() to update effective_cpus/effective_xcpus
@@ -2841,9 +2841,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -2913,9 +2913,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	check_insane_mems_config(&trialcs->mems_allowed);
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -3006,9 +3006,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
 		rebuild_sched_domains_locked();
@@ -3052,10 +3052,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * later if partition becomes invalid.
 	 */
 	if ((new_prs > 0) && cpumask_empty(cs->exclusive_cpus)) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cpumask_and(cs->effective_xcpus,
 			    cs->cpus_allowed, parent->effective_xcpus);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 	}
 
 	err = update_partition_exclusive(cs, new_prs);
@@ -3112,14 +3112,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		update_partition_exclusive(cs, new_prs);
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
 	else if (new_xcpus_state)
 		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(new_xcpus_state);
 
 	/* Force update if switching back to member */
@@ -3650,7 +3650,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -3681,7 +3681,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -4042,7 +4042,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
 	cpuset_inc();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
@@ -4062,7 +4062,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	    !is_sched_load_balance(parent))
 		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
 		goto out_unlock;
@@ -4089,12 +4089,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	}
 	rcu_read_unlock();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
@@ -4150,7 +4150,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	mutex_lock(&cpuset_mutex);
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -4162,7 +4162,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -4349,12 +4349,12 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 {
 	bool is_empty;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, new_cpus);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/*
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
@@ -4391,10 +4391,10 @@ hotplug_update_tasks(struct cpuset *cs,
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
 		update_tasks_cpumask(cs, new_cpus);
@@ -4597,7 +4597,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
@@ -4616,17 +4616,17 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 			}
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
 	}
 
 	/* synchronize mems_allowed to N_MEMORY */
 	if (mems_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		update_tasks_nodemask(&top_cpuset);
 	}
 
@@ -4726,7 +4726,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 	struct cpuset *cs;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 
 	cs = task_cs(tsk);
@@ -4750,7 +4750,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	}
 
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 /**
@@ -4821,11 +4821,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -4917,14 +4917,14 @@ bool cpuset_node_allowed(int node, gfp_t gfp_mask)
 		return true;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 	rcu_read_unlock();
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
-- 
2.39.3


