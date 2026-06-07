Return-Path: <cgroups+bounces-16686-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bwSoEt3hJGriAwIAu9opvQ
	(envelope-from <cgroups+bounces-16686-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 07 Jun 2026 05:13:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D364EBAB
	for <lists+cgroups@lfdr.de>; Sun, 07 Jun 2026 05:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=oXd9Ykke;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16686-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16686-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C637E300B9D4
	for <lists+cgroups@lfdr.de>; Sun,  7 Jun 2026 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171234887B;
	Sun,  7 Jun 2026 03:13:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39931C5F27
	for <cgroups@vger.kernel.org>; Sun,  7 Jun 2026 03:13:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780802009; cv=none; b=eNGnnnQ6Cws665R/lra8FzTZ483Z+ucBDW/9DJQezjOq60kHWln+2VJ7KlW7Fo+bvVMx6D4AIs3FtNfI1+woOj+dq0TA/GP7AwlUg3l5kbR58PrT/hCtKLM68PBfiTT86T2oOHroW4Pux0apqovO0p3XZOD3hRAXYKloBdggECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780802009; c=relaxed/simple;
	bh=lBDv9MRy7OSI0k/MWVjN1Ogvdd4Q43Q9++QERsbW/qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3cMSWwb7VYj/veRgkL1JdcJc8OSR/GFGNZ6DnNggM2SiC+vcSyCOPnp+WtVdA3gZPdkOD4sF6wq1FfreqzDS1zbsjTR9Ap8G2eJ5Au3r/FIe5fG1hF6UfU9vPk0y7riaflJGKhgvMln2qCh1bWJXNVP4e/oxXCfpTdrBpYJ6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oXd9Ykke; arc=none smtp.client-ip=95.215.58.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780802005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltdb1D/6DJwtSR9jPJtmnFCpcvyJ1KlqVebLfHCvHNY=;
	b=oXd9YkkeZ1U51QIciQWghD48eNBlJNgNidlcbIVHVBV+Pb7H7Y+smppJMskv3ViqvwLc9l
	wJokvr7J9kGOBiGe4tK9HDTSAycdi8abfBoIbgd+XJ70ulqn58Bl0cKWZPQYjdLB4Bjbmo
	d+JpYJQlQP76WTXYOOP2gouGtaRi6o8=
From: Ridong Chen <ridong.chen@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ridong Chen <ridong.chen@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: Support multiple source/destination cpusets using pids pattern
Date: Sun,  7 Jun 2026 11:12:59 +0800
Message-ID: <20260607031259.79541-1-ridong.chen@linux.dev>
In-Reply-To: <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
References: <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16686-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:ridong.chen@linux.dev,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 803D364EBAB

When the cpuset controller is enabled/disabled in a parent cgroup, tasks
from multiple child cpusets need to be migrated. The current code only
handles a single source/destination pair.

Support multiple source/destination cpusets by adopting the per-task
processing pattern similar to the pids controller:

1) Perform per-task DL bandwidth reservation (dl_bw_alloc) directly in
   cpuset_can_attach() instead of batching into sum_migrate_dl_bw. This
   eliminates the sum_migrate_dl_bw and dl_bw_cpu fields from the cpuset
   struct.

2) Track attach_in_progress per-task per-destination cpuset to properly
   guard all involved cpusets from having their cpus/mems zeroed.

3) Use a shared cpuset_undo_attach() helper for both rollback-on-error
   in cpuset_can_attach() and for cpuset_cancel_attach().

4) Detect many-source migrations and force cpus_updated/mems_updated
   to true so all tasks get properly updated during attach.

5) Defer nr_deadline_tasks updates to cpuset_attach() (after migration
   is committed) to avoid a race with dl_rebuild_rd_accounting() that
   could see inconsistent values between can_attach and attach.

Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
---
 kernel/cgroup/cpuset-internal.h |   7 --
 kernel/cgroup/cpuset.c          | 167 ++++++++++++++++----------------
 2 files changed, 84 insertions(+), 90 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index f7aaf01f7cd5..8f32cb97eb94 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -167,13 +167,6 @@ struct cpuset {
 	 */
 	int nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
-	/* DL bandwidth that needs destination reservation for this attach. */
-	u64 sum_migrate_dl_bw;
-	/*
-	 * CPU used for temporary DL bandwidth allocation during attach;
-	 * -1 if no DL bandwidth was allocated in the current attach.
-	 */
-	int dl_bw_cpu;
 
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e52a5a40d607..a6d96a39cdb1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -288,7 +288,6 @@ struct cpuset top_cpuset = {
 	.flags = BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
-	.dl_bw_cpu = -1,
 };
 
 /**
@@ -580,8 +579,6 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
 	if (!trial)
 		return NULL;
 
-	trial->dl_bw_cpu = -1;
-
 	/* Setup cpumask pointer array */
 	cpumask_var_t *pmask[4] = {
 		&trial->cpus_allowed,
@@ -3026,31 +3023,36 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	return 0;
 }
 
-static int cpuset_reserve_dl_bw(struct cpuset *cs)
+/*
+ * Undo DL bandwidth reservations and attach_in_progress increments done
+ * in cpuset_can_attach(). Used for both rollback on error and cancel_attach.
+ * If @stop_at is non-NULL, undo only for tasks before @stop_at in the tset.
+ */
+static void cpuset_undo_attach(struct cgroup_taskset *tset,
+			       struct task_struct *stop_at)
 {
-	int cpu, ret;
-
-	if (!cs->sum_migrate_dl_bw)
-		return 0;
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
 
-	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-	if (unlikely(cpu >= nr_cpu_ids))
-		return -EINVAL;
+	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *cs = css_cs(css);
 
-	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-	if (ret)
-		return ret;
+		if (task == stop_at)
+			break;
 
-	cs->dl_bw_cpu = cpu;
-	return 0;
+		if (dl_task(task)) {
+			cs->nr_migrate_dl_tasks--;
+			if (dl_task_needs_bw_move(task, cs->effective_cpus)) {
+				int cpu = cpumask_any_and(cpu_active_mask,
+							 cs->effective_cpus);
+				dl_bw_free(cpu, task->dl.dl_bw);
+			}
+		}
+		dec_attach_in_progress_locked(cs);
+	}
 }
 
-static void reset_migrate_dl_data(struct cpuset *cs)
-{
-	cs->nr_migrate_dl_tasks = 0;
-	cs->sum_migrate_dl_bw = 0;
-	cs->dl_bw_cpu = -1;
-}
+static bool attach_many_sources;
 
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
@@ -3067,90 +3069,73 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
+	attach_many_sources = false;
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() to get
-	 * the old_mems_allowed value. There are two ways that many-to-one
-	 * cpuset migration can happen:
-	 * 1) A multithread application with threads in different cpusets is
-	 *    wholely migrated to a new cpuset.
-	 * 2) Disabling v2 cpuset controller will move all the tasks in child
-	 *    cpusets to the parent cpuset.
-	 *
-	 * In the former case, it is the mm setting of the group leader that
-	 * really matters. So cpuset_attach_old_cs should track the oldcs of the
-	 * group leader. It falls back to the oldcs of the first task if there
-	 * is no group leader in the taskset. In the latter case, effective_mems
-	 * of child cpusets must always be a subset of the parent. So no real
-	 * page migration will be necessary no matter which child cpuset is
-	 * selected as cpuset_attach_old_cs.
-	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *newcs = css_cs(css);
+		struct cpuset *new_oldcs = task_cs(task);
+
+		if (newcs != cs || new_oldcs != oldcs) {
+			if (new_oldcs != oldcs)
+				attach_many_sources = true;
+			cs = newcs;
+			oldcs = new_oldcs;
+			ret = cpuset_can_attach_check(cs, oldcs,
+						      &setsched_check);
+			if (ret)
+				goto out_rollback;
+		}
+
 		ret = task_can_attach(task);
 		if (ret)
-			goto out_unlock;
+			goto out_rollback;
 
-		/* Update cpuset_attach_old_cs to the latest group leader */
 		if (task == task->group_leader)
 			cpuset_attach_old_cs = task_cs(task);
 
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-				goto out_unlock;
+				goto out_rollback;
 		}
 
 		if (dl_task(task)) {
-			/*
-			 * Count all migrating DL tasks for cpuset task accounting.
-			 * Only tasks that need a root-domain bandwidth move
-			 * contribute to sum_migrate_dl_bw.
-			 */
 			cs->nr_migrate_dl_tasks++;
-			if (dl_task_needs_bw_move(task, cs->effective_cpus))
-				cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			if (dl_task_needs_bw_move(task, cs->effective_cpus)) {
+				int cpu = cpumask_any_and(cpu_active_mask,
+							 cs->effective_cpus);
+				if (unlikely(cpu >= nr_cpu_ids)) {
+					ret = -EINVAL;
+					goto out_rollback;
+				}
+				ret = dl_bw_alloc(cpu, task->dl.dl_bw);
+				if (ret)
+					goto out_rollback;
+			}
 		}
-	}
-
-	ret = cpuset_reserve_dl_bw(cs);
 
-out_unlock:
-	if (ret) {
-		reset_migrate_dl_data(cs);
-	} else {
-		/*
-		 * Mark attach is in progress.  This makes validate_change() fail
-		 * changes which zero cpus/mems_allowed.
-		 */
 		cs->attach_in_progress++;
 	}
 
+	goto out_unlock;
+
+out_rollback:
+	cpuset_undo_attach(tset, task);
+
+out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
-	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
-
-	cgroup_taskset_first(tset, &css);
-	cs = css_cs(css);
-
 	mutex_lock(&cpuset_mutex);
-	dec_attach_in_progress_locked(cs);
-
-	if (cs->dl_bw_cpu >= 0)
-		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
-
-	if (cs->nr_migrate_dl_tasks)
-		reset_migrate_dl_data(cs);
-
+	cpuset_undo_attach(tset, NULL);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3232,8 +3217,15 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 	queue_task_work = false;
 
-	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	if (attach_many_sources) {
+		attach_cpus_updated = true;
+		attach_mems_updated = true;
+	} else {
+		attach_cpus_updated = !cpumask_equal(cs->effective_cpus,
+						    oldcs->effective_cpus);
+		attach_mems_updated = !nodes_equal(cs->effective_mems,
+						   oldcs->effective_mems);
+	}
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3250,20 +3242,29 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	}
 
 	cgroup_taskset_for_each(task, css, tset)
-		cpuset_attach_task(cs, task);
+		cpuset_attach_task(css_cs(css), task);
 
 out:
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
-	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
-		reset_migrate_dl_data(cs);
-	}
+	/*
+	 * Update nr_deadline_tasks now that migration is committed.
+	 * nr_migrate_dl_tasks was accumulated per-dst in can_attach but
+	 * nr_deadline_tasks is deferred to here to avoid a race with
+	 * dl_rebuild_rd_accounting() between can_attach and attach.
+	 */
+	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *dst_cs = css_cs(css);
 
-	dec_attach_in_progress_locked(cs);
+		if (dst_cs->nr_migrate_dl_tasks) {
+			dst_cs->nr_deadline_tasks += dst_cs->nr_migrate_dl_tasks;
+			oldcs->nr_deadline_tasks -= dst_cs->nr_migrate_dl_tasks;
+			dst_cs->nr_migrate_dl_tasks = 0;
+		}
+		dec_attach_in_progress_locked(dst_cs);
+	}
 
 	mutex_unlock(&cpuset_mutex);
 }
-- 
2.43.0


