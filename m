Return-Path: <cgroups+bounces-11848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE98C50761
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96FB18962CA
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DC2C21DD;
	Wed, 12 Nov 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaWNtN1g"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3B207A20
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919925; cv=none; b=SrhJGcMBPcbKsSrE/EoH4yC6EQ2eiRk0NcXGvSvO46PolUYlNtLWnsqFF10yEYiQAXVQ6AID4J7hHI8iP1tWRg9cj3elVq4Kidv44eK+fSegQArw//SgzR3IZ7QlDd07HOvEKwjTrHvZgYJBc7mkmdDBcGkq1K6D8fUcvWRQFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919925; c=relaxed/simple;
	bh=c/h+aA41Clq7jcaacbawmPY+fy/4YciowdLYV+X/BAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKY9O9oNEKrHvG/ku7+AkIYRIH6zJqRRJDG0WD55VbLClRlQYRMGQEg1aLPiiROhPWZU2nWhdaCIYPymp81aHwWaWvj2D6vbqw2DGkb25twRee1E0G+6j0WD3o2aFILni98+v6kJ2JjKklemCBWIoD2gd0z48btgI393Ga1nU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaWNtN1g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762919921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVGjzJVLKYy854UeaTbnQV8hoz0i2+ZeLSoZeWbkDos=;
	b=aaWNtN1gNKj51ml/fWNk7ss7AxZg6NT99gtQLozzm68NVcGs3K6Ks/VcIoOeCIWSmrAOzS
	nTa+HzT/S8lR9PWwfURn30iHOM6bhv5x9u3eBshQgEsc0i06Prhby3QD24u3CR/ywKOeg3
	wnzk8+sZnsZYmiKs5v32iowmoXzeHG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-r370gV40O42hI_X01s8uVg-1; Tue,
 11 Nov 2025 22:58:38 -0500
X-MC-Unique: r370gV40O42hI_X01s8uVg-1
X-Mimecast-MFC-AGG-ID: r370gV40O42hI_X01s8uVg_1762919917
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8233F19560B0;
	Wed, 12 Nov 2025 03:58:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E70E81800451;
	Wed, 12 Nov 2025 03:58:32 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Pingfan Liu <piliu@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a raw_spinlock_t
Date: Tue, 11 Nov 2025 22:57:59 -0500
Message-ID: <20251112035759.1162541-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The callback_lock is a spinlock_t which is acquired either to read
a stable set of cpu or node masks or to modify those masks when
cpuset_mutex is also acquired. Sometime it may need to go up the
cgroup hierarchy while holding the lock to find the right set of masks
to use. Assuming that the depth of the cgroup hierarch is finite and
typically small, the lock hold time should be limited.

Some externally callable cpuset APIs like cpuset_cpus_allowed() and
cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
stable cpuset data. These APIs currently have the restriction that they
can't be called when a raw spinlock is being held. This is needed to
work correctly in a PREEMPT_RT kernel. This requires additional code
changes to work around this limitation. See [1] for a discussion of that.

Make these external cpuset APIs more useful by changing callback_lock
to a raw_spinlock_t to remove this limitation so that they can be called
from within other raw spinlock critical sections if needed.

[1] https://lore.kernel.org/lkml/20251110014706.8118-1-piliu@redhat.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 94 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 976bce6e5673..7b3a0345ee76 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -289,16 +289,16 @@ void cpuset_full_unlock(void)
 	cpus_read_unlock();
 }
 
-static DEFINE_SPINLOCK(callback_lock);
+static DEFINE_RAW_SPINLOCK(callback_lock);
 
 void cpuset_callback_lock_irq(void)
 {
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 }
 
 void cpuset_callback_unlock_irq(void)
 {
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 }
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
@@ -1616,11 +1616,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
 		return PERR_HKEEPING;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	cs->remote_partition = true;
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
@@ -1647,7 +1647,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->remote_partition = false;
 	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
 	if (cs->prs_err)
@@ -1658,7 +1658,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	/* effective_xcpus may need to be changed */
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
 	cpuset_force_rebuild();
 
@@ -1717,7 +1717,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			goto invalidate;
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (adding)
 		partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
@@ -1729,7 +1729,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	cpumask_copy(cs->effective_xcpus, excpus);
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
 	if (adding || deleting)
 		cpuset_force_rebuild();
@@ -2060,7 +2060,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (old_prs != new_prs)
 		cs->partition_root_state = new_prs;
 
@@ -2073,7 +2073,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	if (deleting)
 		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
@@ -2154,9 +2154,9 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 			/*
 			 * Invalidate child partition
 			 */
-			spin_lock_irq(&callback_lock);
+			raw_spin_lock_irq(&callback_lock);
 			make_partition_invalid(child);
-			spin_unlock_irq(&callback_lock);
+			raw_spin_unlock_irq(&callback_lock);
 			notify_partition_change(child, old_prs);
 			continue;
 		}
@@ -2301,7 +2301,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			new_prs = cp->partition_root_state;
 		}
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
@@ -2316,7 +2316,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				    cp->cpus_allowed, parent->effective_xcpus);
 		else if (new_prs < 0)
 			reset_partition_data(cp);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
 
@@ -2566,12 +2566,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	partition_cpus_change(cs, trialcs, &tmp);
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
 	cpumask_copy(cs->effective_xcpus, trialcs->effective_xcpus);
 	if ((old_prs > 0) && !is_partition_valid(cs))
 		reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus/effective_xcpus will be updated here */
 	update_cpumasks_hier(cs, &tmp, force);
@@ -2631,12 +2631,12 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	trialcs->prs_err = PERR_NONE;
 	partition_cpus_change(cs, trialcs, &tmp);
 
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
@@ -2851,9 +2851,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -2906,9 +2906,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	check_insane_mems_config(&trialcs->mems_allowed);
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -2962,9 +2962,9 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed) {
 		if (cpuset_v2())
@@ -3082,14 +3082,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		update_partition_exclusive_flag(cs, new_prs);
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
 
 	/* Force update if switching back to member & update effective_xcpus */
@@ -3403,7 +3403,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -3434,7 +3434,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -3627,12 +3627,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
 	cpuset_inc();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
 		goto out_unlock;
@@ -3659,12 +3659,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
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
 	cpuset_full_unlock();
 	return 0;
@@ -3715,7 +3715,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	mutex_lock(&cpuset_mutex);
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -3727,7 +3727,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3890,10 +3890,10 @@ hotplug_update_tasks(struct cpuset *cs,
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
 		cpuset_update_tasks_cpumask(cs, new_cpus);
@@ -4055,7 +4055,7 @@ static void cpuset_handle_hotplug(void)
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
 		cpuset_force_rebuild();
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
@@ -4073,17 +4073,17 @@ static void cpuset_handle_hotplug(void)
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
 		cpuset_update_tasks_nodemask(&top_cpuset);
 	}
 
@@ -4176,7 +4176,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 	struct cpuset *cs;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4198,7 +4198,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 /**
@@ -4269,9 +4269,9 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	guarantee_online_mems(task_cs(tsk), &mask);
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -4363,12 +4363,12 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 		return true;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
-- 
2.51.1


