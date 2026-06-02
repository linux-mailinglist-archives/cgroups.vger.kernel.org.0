Return-Path: <cgroups+bounces-16543-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIefE/pAHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16543-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:33:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BAF62744B
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4179B301F817
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259D36A36B;
	Tue,  2 Jun 2026 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ponw4iZp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A97366DB9
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367555; cv=none; b=snX2sW1eBehvyx/CeQQ1ibAov/TXeOCaVbXCE0pAGcb+Kfv0ckZxBho6JUYluzOJoU2nS2P5kgtndkeOWk+BnevC0fwbSKEptKid1+aJaMC1SxOVQtAz4MzX+eyQBg5K1NHepNVDkoX847F6MFm0DiPD8AdUd7WKgh4Mfh5qcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367555; c=relaxed/simple;
	bh=XPphyOyhhTMw452KxBtqveVXGR7Wz64Yz9sfuyd9+Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntldcCOpIW5dnJ8F3UEoVVdgymfadEWy4NKpxTfTT02GlF5yBxrD6KCPALRJSCkErE7eBTe+L7fSX2XhoduG2vsWHqPT/04GvRs2sdMM6R4Ga48ty2lnkr5HvlDp7QwPeegkMaHeAiptnXhHltOpmrKy1hve7r5cXBOASSv8jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ponw4iZp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780367553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjQW84JAI0mOLGpS3lSQF9ZfsTcu2a2RFOFXnbAorQ8=;
	b=Ponw4iZpeoWd1SVl1X3f4Xmo4CnUC3tHDWoicFyeJpUvaQXw5Dw9gAJHuV2yFX9kpug0Vv
	s0Pd8mYAfcq44l5f1K2MXII+QQ9/rkxBajZFRq7lgV2uJ56tG97bRRG/p/epbO/DlHeVcH
	OGqT382FzPf5Hd8C7/PU/CEwy/FMVx4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-pyQcABZTPaynTzRvuCSnEg-1; Mon,
 01 Jun 2026 22:32:28 -0400
X-MC-Unique: pyQcABZTPaynTzRvuCSnEg-1
X-Mimecast-MFC-AGG-ID: pyQcABZTPaynTzRvuCSnEg_1780367547
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 084DB1800451;
	Tue,  2 Jun 2026 02:32:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 534AC19560A3;
	Tue,  2 Jun 2026 02:32:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v5 6/6] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Mon,  1 Jun 2026 22:32:03 -0400
Message-ID: <20260602023203.248077-7-longman@redhat.com>
In-Reply-To: <20260602023203.248077-1-longman@redhat.com>
References: <20260602023203.248077-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16543-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E1BAF62744B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With cgroup v2, the cgroup_taskset structure passed into the cgroup
can_attach() and attach() methods can contain task migration data with
multiple destination or source cpusets when the cpuset controller is
enabled or disabled respectively.

Since cpuset is threaded in both v1 and v2, another possible way to
cause many-to-one migration is to move the whole process with multiple
threads in different cpuset enabled threaded cgroups into another cpuset
enabled cgroup.

The current cpuset_can_attach() and cpuset_attach() functions still
expect task migration is from one source cpuset to one destination
cpuset. This has been the case since cpuset was enabled for cgroup v2
in commit 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default
hierarchy").

This problem is less an issue when enabling the cpuset controller as all
the newly created child cpusets will have exactly the same set of CPUs
and memory nodes except when deadline tasks are involved in migration
as the deadline task accounting data can be off.

It can be more problematic when the cpuset controller is disabled as
their set of CPUs and memory nodes may differ from their parent or with
the moving of multi-threaded process from different threaded cgroups.

Fix that by tracking the set of source (old) and destination cpusets
in singly linked lists and iterating them all to properly update the
internal data. Also keep the current cs and oldcs variables up-to-date
with the css and task iterators.

To ensure proper DL tasks accounting, the nr_migrate_dl_tasks in both
the source and destination cpusets are decremented/incremented with
their values added to nr_deadline_tasks when the migration is successful.

Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |   6 +
 kernel/cgroup/cpuset.c          | 208 ++++++++++++++++++++++++--------
 2 files changed, 164 insertions(+), 50 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index f7aaf01f7cd5..4c2772a7fd5e 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -161,6 +161,12 @@ struct cpuset {
 	 */
 	bool remote_partition;
 
+	/*
+	 * cpuset_can_attach() and cpuset_attach() specific data
+	 */
+	bool			attach_node_in_llist;
+	struct llist_node	attach_node;
+
 	/*
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
 	 * know when to rebuild associated root domain bandwidth information.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5b5352ec0e69..53a9d3cc8407 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
+#include <linux/llist.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -2983,6 +2984,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
  */
 static struct cpuset *cpuset_attach_old_cs;
+static LLIST_HEAD(src_cs_head);
+static LLIST_HEAD(dst_cs_head);
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
 
@@ -3005,6 +3008,15 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!oldcs)
 		return 0;
 
+	if (!cs->attach_node_in_llist) {
+		llist_add(&cs->attach_node, &dst_cs_head);
+		cs->attach_node_in_llist = true;
+	}
+	if (!oldcs->attach_node_in_llist) {
+		llist_add(&oldcs->attach_node, &src_cs_head);
+		oldcs->attach_node_in_llist = true;
+	}
+
 	/*
 	 * Skip rights over task setsched check in v2 when nothing changes,
 	 * migration permission derives from hierarchy ownership in
@@ -3027,33 +3039,101 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	return 0;
 }
 
-static int cpuset_reserve_dl_bw(struct cpuset *cs)
+/*
+ * If reset_dl_bw is set, reset the previous dl_bw_alloc() call. Otherwise,
+ * update nr_deadline_tasks according to nr_migrate_dl_tasks in both source
+ * and destination cpusets.
+ */
+static void clear_attach_data(bool reset_dl_bw)
 {
+	struct cpuset *cs, *next;
+
+	llist_for_each_entry_safe(cs, next, src_cs_head.first, attach_node) {
+		cs->attach_node.next = NULL;
+		cs->attach_node_in_llist = false;
+		if (cs->nr_migrate_dl_tasks && !reset_dl_bw)
+			cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		cs->nr_migrate_dl_tasks = 0;
+	}
+
+	llist_for_each_entry_safe(cs, next, dst_cs_head.first, attach_node) {
+		cs->attach_node.next = NULL;
+		cs->attach_node_in_llist = false;
+		if (reset_dl_bw && cs->dl_bw_cpu >= 0)
+			dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
+		if (cs->nr_migrate_dl_tasks && !reset_dl_bw)
+			cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		cs->nr_migrate_dl_tasks = 0;
+		cs->sum_migrate_dl_bw = 0;
+		cs->dl_bw_cpu = -1;
+	}
+
+	src_cs_head.first = NULL;
+	dst_cs_head.first = NULL;
+}
+
+static int cpuset_reserve_dl_bw(void)
+{
+	struct cpuset *cs;
 	int cpu, ret;
 
-	if (!cs->sum_migrate_dl_bw)
-		return 0;
+	llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
+		if (!cs->sum_migrate_dl_bw)
+			continue;
 
-	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-	if (unlikely(cpu >= nr_cpu_ids))
-		return -EINVAL;
+		cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+		if (unlikely(cpu >= nr_cpu_ids))
+			return -EINVAL;
 
-	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-	if (ret)
-		return ret;
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret)
+			return ret;
 
-	cs->dl_bw_cpu = cpu;
+		cs->dl_bw_cpu = cpu;
+	}
 	return 0;
 }
 
-static void reset_migrate_dl_data(struct cpuset *cs)
+static void set_attach_in_progress(void)
 {
-	cs->nr_migrate_dl_tasks = 0;
-	cs->sum_migrate_dl_bw = 0;
-	cs->dl_bw_cpu = -1;
+	struct cpuset *cs;
+
+	/*
+	 * Mark attach is in progress.  This makes validate_change() fail
+	 * changes which zero cpus/mems_allowed.
+	 */
+	llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+		cs->attach_in_progress++;
+}
+
+static void reset_attach_in_progress(void)
+{
+	struct cpuset *cs;
+
+	llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+		dec_attach_in_progress_locked(cs);
 }
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
+/*
+ * Called by cgroups to determine if a cpuset is usable; cpuset_mutex held.
+ *
+ * With cgroup v2, enabling of cpuset controller in a cgroup subtree can
+ * cause @tset to contain task migration data from one parent cpuset to multiple
+ * child cpusets. Not much is needed to be done here other than tracking the
+ * number of DL tasks in each cpuset as the CPUs and memory nodes of the child
+ * cpusets are exactly the same as the parent.
+ *
+ * Conversely, disabling of cpuset controller can cause @tset to contain task
+ * migration data from multiple child cpusets to one parent cpuset. Here, the
+ * CPUs and memory nodes of the child cpusets may be different from the parent,
+ * but must be a subset of its parent.
+ *
+ * Another possible many-to-one migration is the moving of the whole
+ * multithreaded process with threads in different cpusets to another cpuset.
+ *
+ * For all other use cases, @tset task migration data should be from one source
+ * cpuset to one destination cpuset.
+ */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -3092,6 +3172,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * selected as cpuset_attach_old_cs.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *newcs = css_cs(css);
+		struct cpuset *new_oldcs = task_cs(task);
+
+		if ((newcs != cs) || (new_oldcs != oldcs)) {
+			cs = newcs;
+			oldcs = new_oldcs;
+			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
+			if (ret)
+				goto out_unlock;
+		}
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
@@ -3113,23 +3203,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			 * contribute to sum_migrate_dl_bw.
 			 */
 			cs->nr_migrate_dl_tasks++;
+			oldcs->nr_migrate_dl_tasks--;
 			if (dl_task_needs_bw_move(task, cs->effective_cpus))
 				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
-	ret = cpuset_reserve_dl_bw(cs);
+	ret = cpuset_reserve_dl_bw();
 
 out_unlock:
-	if (ret) {
-		reset_migrate_dl_data(cs);
-	} else {
-		/*
-		 * Mark attach is in progress.  This makes validate_change() fail
-		 * changes which zero cpus/mems_allowed.
-		 */
-		cs->attach_in_progress++;
-	}
+	if (ret)
+		clear_attach_data(true);
+	else
+		set_attach_in_progress();
 
 	mutex_unlock(&cpuset_mutex);
 	return ret;
@@ -3144,14 +3230,8 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	dec_attach_in_progress_locked(cs);
-
-	if (cs->dl_bw_cpu >= 0)
-		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
-
-	if (cs->nr_migrate_dl_tasks)
-		reset_migrate_dl_data(cs);
-
+	reset_attach_in_progress();
+	clear_attach_data(true);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3224,48 +3304,76 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
+	bool many_cs_to_one = !!src_cs_head.first->next;
 
 	cgroup_taskset_first(tset, &css);
-	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
 	queue_task_work = false;
 
-	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	/*
+	 * attach_cpus_updated/attach_mems_updated can be set to false if
+	 * source and destination masks are the same and there is only one
+	 * source cpuset. IOW, a many-cs-to-one migration is always treated as
+	 * updated as the tasks to old cpuset mapping is lost.
+	 */
+	if (many_cs_to_one) {
+		attach_cpus_updated = true;
+		attach_mems_updated = true;
+	} else {
+		/* one_cs_to_one or one_cs_to_many */
+		struct cpuset *oldcs = cpuset_attach_old_cs;
 
+		attach_cpus_updated = false;
+		attach_mems_updated = false;
+		llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
+			attach_cpus_updated |= !cpumask_equal(cs->effective_cpus,
+							      oldcs->effective_cpus);
+			attach_mems_updated |= !nodes_equal(cs->effective_mems,
+							    oldcs->effective_mems);
+		}
+	}
+
+	cs = css_cs(css);
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
 	 * will trigger a cpuset_attach() call with no change in effective cpus
 	 * and mems. In that case, we can optimize out by skipping the task
-	 * iteration and update.
+	 * iteration and update, but the destination cpuset list is iterated to
+	 * set old_mems_sllowed.
 	 */
 	if (cpuset_v2()) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
-		if (!attach_cpus_updated && !attach_mems_updated)
+		if (!attach_cpus_updated && !attach_mems_updated) {
+			llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+				cs->old_mems_allowed = cs->effective_mems;
 			goto out;
+		}
 	} else {
 		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	}
 
-	cgroup_taskset_for_each(task, css, tset)
+	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *newcs = css_cs(css);
+
+		if (newcs != cs) {
+			cs->old_mems_allowed = cpuset_attach_nodemask_to;
+			cs = newcs;
+			if (cpuset_v2())
+				cpuset_attach_nodemask_to = cs->effective_mems;
+			else
+				guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+		}
 		cpuset_attach_task(cs, task);
+	}
 
-out:
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
-
-	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
-		reset_migrate_dl_data(cs);
-	}
-
-	dec_attach_in_progress_locked(cs);
-
+out:
+	reset_attach_in_progress();
+	clear_attach_data(false);
 	mutex_unlock(&cpuset_mutex);
 }
 
-- 
2.54.0


