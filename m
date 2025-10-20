Return-Path: <cgroups+bounces-10890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA8BEF16D
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 04:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D83E09BF
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B2C29B8E8;
	Mon, 20 Oct 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHvvc4u7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A429B20A
	for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927560; cv=none; b=KPA9RNZWZcakTzxBy0F941QbS2PtApk9Imj3SczD2Gn0w1U9jjk5JRugl5l5G/r4zj0XPdcZgCb8CCTLmGNgbCnpDBFmEvVyL03VmK3mWICuv02b1UlscX6EwHxpqtZI7PI3Bze0ynI91d0PtVwvhpPd/NlQ9IjHnD+g4OGmJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927560; c=relaxed/simple;
	bh=Qyu5x+rIDV9rj8o4/gyGLVDwjVhwowYPbcL/S9+e/tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpVT25YD8wu0DfXylzHUfWpw//AYl+TodgYXp7gnufPBALkOl45e9bT3AAWJisDijn+pjTTCG+TDO/LlA5j7qjp5sVCXdPvvH13gC610GyatsBJ6rmfGQGTk+fJ1LN7WAKJSP3KZo0kg1/ppGRE65sFK1ws0xqjWqIugb9LLtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHvvc4u7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760927557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jX5MTENNNovMHiufRZKIYxUV8K61rf34joxQCU3I40c=;
	b=UHvvc4u7KI/4pZhjXAzqYfhucinWcAO1V2cItgYWrJ9fg3QcXb58CG2s3alIZal9bC8YmM
	022hz/+FeWYRaDRRiGN/gHEYZo3RZKSGjZ66+q+XqlSxVx0QqY49J5fHeLEfN8ftHUYgWi
	ptIQTfDr2v6hFraLXAa5dP/hWdIxQew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-NsIHmlbxOjunld_qRoDm1w-1; Sun,
 19 Oct 2025 22:32:33 -0400
X-MC-Unique: NsIHmlbxOjunld_qRoDm1w-1
X-Mimecast-MFC-AGG-ID: NsIHmlbxOjunld_qRoDm1w_1760927552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2958E1956063;
	Mon, 20 Oct 2025 02:32:32 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA8BC180057E;
	Mon, 20 Oct 2025 02:32:29 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Change callback_lock to raw_spinlock_t
Date: Sun, 19 Oct 2025 22:32:07 -0400
Message-ID: <20251020023207.177809-3-longman@redhat.com>
In-Reply-To: <20251020023207.177809-1-longman@redhat.com>
References: <20251020023207.177809-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The callback_lock is acquired either to read a stable set of cpu
or node masks or to modify those masks when cpuset_mutex is also
acquired. Sometime, it may need to go up the cgroup hierarchy while
holding the lock to find the right set of masks to use. Assuming that
the depth of the cgroup hierarch is finite and typically small, the
lock hold time should be limited.

As a result, it can be converted to raw_spinlock_t to reduce overhead
in a PREEMPT_RT setting without introducing excessive latency.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 94 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7aef59ea9627..026eb1a17ad2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -285,16 +285,16 @@ void cpuset_full_unlock(void)
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
@@ -1552,11 +1552,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
@@ -1585,7 +1585,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
 					       NULL, cs->effective_xcpus);
@@ -1597,7 +1597,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	/* effective_xcpus may need to be changed */
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 
@@ -1654,7 +1654,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			goto invalidate;
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (adding)
 		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
@@ -1666,7 +1666,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	cpumask_copy(cs->effective_xcpus, excpus);
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
@@ -1995,7 +1995,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (old_prs != new_prs)
 		cs->partition_root_state = new_prs;
 
@@ -2010,7 +2010,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		isolcpus_updated += partition_xcpus_add(new_prs, parent,
 							tmp->delmask);
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
@@ -2091,9 +2091,9 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
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
@@ -2239,7 +2239,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			new_prs = cp->partition_root_state;
 		}
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
@@ -2254,7 +2254,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				    cp->cpus_allowed, parent->effective_xcpus);
 		else if (new_prs < 0)
 			reset_partition_data(cp);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		notify_partition_change(cp, old_prs);
 
@@ -2507,12 +2507,12 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
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
@@ -2572,12 +2572,12 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -2792,9 +2792,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -2849,9 +2849,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	check_insane_mems_config(&trialcs->mems_allowed);
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -2906,9 +2906,9 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed) {
 		if (cpuset_v2())
@@ -3021,14 +3021,14 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
@@ -3342,7 +3342,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -3373,7 +3373,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -3567,12 +3567,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
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
@@ -3599,12 +3599,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
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
@@ -3655,7 +3655,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	mutex_lock(&cpuset_mutex);
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -3667,7 +3667,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3831,10 +3831,10 @@ hotplug_update_tasks(struct cpuset *cs,
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
@@ -3996,7 +3996,7 @@ static void cpuset_handle_hotplug(void)
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
 		cpuset_force_rebuild();
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
@@ -4014,17 +4014,17 @@ static void cpuset_handle_hotplug(void)
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
 
@@ -4117,7 +4117,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 	struct cpuset *cs;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4139,7 +4139,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 /**
@@ -4210,9 +4210,9 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	guarantee_online_mems(task_cs(tsk), &mask);
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -4304,12 +4304,12 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
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
2.51.0


