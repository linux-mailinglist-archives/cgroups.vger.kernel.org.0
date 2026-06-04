Return-Path: <cgroups+bounces-16648-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ldF5Oj6XIWoTJgEAu9opvQ
	(envelope-from <cgroups+bounces-16648-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:18:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F43641595
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:18:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Du7h62FI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16648-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16648-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1312E313F41A
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE135E1A2;
	Thu,  4 Jun 2026 15:03:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6D356765
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 15:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585398; cv=none; b=W2RLSoKR8ivfAbTUpheVcgxB5+ChYiK6yyisizvIDBZmRJiy+S/58g83v1fOmFSsxPo/W0W1umTTU1xfZrJIQNiMGTA5656uWVNUyAgTuqg6vb/D1uj4b/LSiDfKTHh+c0m+6X4hKy1ycN7l9UCVyJcooqwKcGLU1ltAVzFrKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585398; c=relaxed/simple;
	bh=9VJj+oBaynIvLfUtNkLOHvAHD6LQQFW2lzJiYG4MD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km0k5f+PyOrVRZwzYPNWU51pKjT3yHG1TFp9IXHRluch5iArgOcJL+yBRXNLarr6STUUBsBKIXsSy0Lka1ZboFEHQ4W40JrZcZi+sb/YsC2pOYHxfp1DUQLj/Xm0+D81mhX0GTR+MD2+rApWQyRLw1o6BNaSPdnhIJCswbRMdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Du7h62FI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2G0yOtxTEFcsRk3EJ7heasRynQmxfGwehRgDqz1xesw=;
	b=Du7h62FIViWbA+Yn1Q30O8hIPJrlWpdhHYajLnbRZNDVlIwQHL+EgWl5bYfoFzoDp4LE6W
	IioR6lnbuT45UQkcpoIOkB7f1BmZaV8/XOQ0tfQ+uAsxM+P6fBFvCAGVnlmbHYMcpVxUDf
	zOpaBCURSPjrH/oMQr77ZJnNuR9/7V4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-4wZsULbJOrqs6NFHC-nkXg-1; Thu,
 04 Jun 2026 11:03:11 -0400
X-MC-Unique: 4wZsULbJOrqs6NFHC-nkXg-1
X-Mimecast-MFC-AGG-ID: 4wZsULbJOrqs6NFHC-nkXg_1780585389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0FB1956053;
	Thu,  4 Jun 2026 15:03:09 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF662195608E;
	Thu,  4 Jun 2026 15:03:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v6 6/6] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Thu,  4 Jun 2026 11:02:29 -0400
Message-ID: <20260604150229.414135-7-longman@redhat.com>
In-Reply-To: <20260604150229.414135-1-longman@redhat.com>
References: <20260604150229.414135-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16648-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72F43641595

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

This commit assumes that the set of source and destination cpusets
are distnct. IOW, the cgroup core shouldn't move a task from a given
cpuset back to itself. So a given cpuset cannot be both a source and a
destination cpuset. Running an experiment by moving a multithreaded
process with threads in multiple cpusets in threaded cgroups back to
its domain cgroup confirms that only threads that need to be moved
are included into the cgroup_taskset passed to cpuset_can_attach(). A
WARN_ON_ONCE() is added to cpuset_can_attach_check() to make sure that
this should always be the case.

To ensure proper DL tasks accounting, the nr_migrate_dl_tasks in both
the source and destination cpusets are decremented/incremented with
their values added to nr_deadline_tasks when the migration is successful.

Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |   6 +
 kernel/cgroup/cpuset.c          | 216 ++++++++++++++++++++++++--------
 2 files changed, 172 insertions(+), 50 deletions(-)

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
index 1142d5eba58d..d624cd0a1e04 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
+#include <linux/llist.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -2986,8 +2987,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
  */
 static struct cpuset *cpuset_attach_old_cs;
+static LLIST_HEAD(src_cs_head);
+static LLIST_HEAD(dst_cs_head);
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
+static bool attach_conflict;
 
 /*
  * Check to see if a cpuset can accept a new task
@@ -3008,6 +3012,23 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!oldcs)
 		return 0;
 
+	/*
+	 * The cgroup core shouldn't migrate a task to its original cpuset.
+	 * In the unlikely event that it happens, it will be treated as a
+	 * destination cpuset only and the attach_conflict flag will be set.
+	 */
+	if (WARN_ON_ONCE(cs == oldcs))
+		attach_conflict = true;
+
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
@@ -3030,33 +3051,101 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
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
 }
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
+static void reset_attach_in_progress(void)
+{
+	struct cpuset *cs;
+
+	llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+		dec_attach_in_progress_locked(cs);
+}
+
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
@@ -3069,6 +3158,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	oldcs = cpuset_attach_old_cs;
 	cs = css_cs(css);
+	attach_conflict = false;
 
 	mutex_lock(&cpuset_mutex);
 
@@ -3095,6 +3185,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3116,23 +3216,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3147,14 +3243,8 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
 
@@ -3227,48 +3317,74 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
+	bool many_sources = src_cs_head.first && src_cs_head.first->next;
 
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
+	 * source cpuset with attach_conflict flag unset. IOW, a task migration
+	 * with many source cpusets is always treated as updated as the tasks
+	 * to old cpuset mapping is lost.
+	 */
+	if (many_sources || attach_conflict) {
+		attach_cpus_updated = true;
+		attach_mems_updated = true;
+	} else {
+		/* Only one source cpuset */
+		struct cpuset *oldcs = cpuset_attach_old_cs;
+
+		attach_cpus_updated = false;
+		attach_mems_updated = false;
+		llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
+			attach_cpus_updated |= !cpumask_equal(cs->effective_cpus,
+							      oldcs->effective_cpus);
+			attach_mems_updated |= !nodes_equal(cs->effective_mems,
+							    oldcs->effective_mems);
+		}
+	}
 
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
+			guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
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


