Return-Path: <cgroups+bounces-16471-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC0KONcFGmrK0ggAu9opvQ
	(envelope-from <cgroups+bounces-16471-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:32:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F515608E71
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9230030B1577
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DF3B895E;
	Fri, 29 May 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs14ckq0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2B3B5847
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090147; cv=none; b=D51FQpXkFS/8micLCyPn6zH4ou2yDl5qKaolVSnHv7N1dzmqweEdRgdygKueKXdKziFzTR5C3K74NIgYTpWjuVN5oYBq9vHPzKz1WsT0B9LBCu6QHqc2omg99WVYOjQd6yaJLbhUQ5yGOVtsiVGBATajAF99aw2iOzFTRj9+c1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090147; c=relaxed/simple;
	bh=NlzLK9zAqjVGDCFqIbUdMQMYBFaxjeIA5efE2gQ2PGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzRKCc8uvM3vYWhd+ID3w5Ys9f2yycaNe9wTA4vkxjjwGw9lfRSIpw+NE0KBkL8Rmo4pbjFDSGJSINxlYmB8Y12BDww36L3qA1YlbTClYZmbz0irhM9bKMmXD1eAr96hehdG9c2EnBEJdk1CqiJ0kzYvxXAkxZ8R+C8pz6TGjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs14ckq0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780090145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ2v4QCcizlgq/ZOIawQKANhucDm/iOepXOi14u0xVY=;
	b=cs14ckq0fjH8pO/M/37sY4q8WA/tdlboPFkc462gPSBeurt6mCTK+eAooDfUgoNiD0o+P3
	BaIRzd7kycznYHVJEsKUrf5qvLHN/Tgs2jqePpWJDGALcpZQf0CS+drxM3EHs2bZy/Zvx9
	HvIk+82QtftQyaM9ABsc/uEvbbywrvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-6kAdMXdxNRy0O8UV-2pWNw-1; Fri,
 29 May 2026 17:28:59 -0400
X-MC-Unique: 6kAdMXdxNRy0O8UV-2pWNw-1
X-Mimecast-MFC-AGG-ID: 6kAdMXdxNRy0O8UV-2pWNw_1780090138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE971195608B;
	Fri, 29 May 2026 21:28:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDAE919560A3;
	Fri, 29 May 2026 21:28:55 +0000 (UTC)
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
Subject: [PATCH-next v4 6/6] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Fri, 29 May 2026 17:21:08 -0400
Message-ID: <20260529212108.120506-7-longman@redhat.com>
In-Reply-To: <20260529212108.120506-1-longman@redhat.com>
References: <20260529212108.120506-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16471-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F515608E71
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
 kernel/cgroup/cpuset.c          | 204 ++++++++++++++++++++++++--------
 2 files changed, 158 insertions(+), 52 deletions(-)

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
index a6506b94e60a..2add658eb288 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
+#include <linux/llist.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -1127,6 +1128,8 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
  * matter which child cpuset is selected as cpuset_attach_old_cs.
  */
 static struct cpuset *cpuset_attach_old_cs;
+static LLIST_HEAD(src_cs_head);
+static LLIST_HEAD(dst_cs_head);
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
 
@@ -3017,9 +3020,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  * Also set the boolean flag passed in by @psetsched depending on if
  * security_task_setscheduler() call is needed and @oldcs is not NULL.
  */
-static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
-				   bool *psetsched)
+static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs, bool *psetsched)
 {
+	bool cpu_match, mem_match;
+
 	if (cpumask_empty(cs->effective_cpus) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
@@ -3030,15 +3034,34 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	/*
 	 * Update attach specific data
 	 */
-	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	if (!cs->attach_node_in_llist) {
+		llist_add(&cs->attach_node, &dst_cs_head);
+		cs->attach_node_in_llist = true;
+	}
+	if (!oldcs->attach_node_in_llist) {
+		llist_add(&oldcs->attach_node, &src_cs_head);
+		oldcs->attach_node_in_llist = true;
+	}
+
+	cpu_match = cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	mem_match = nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	/*
+	 * Set the updated flags whenever there is a mismatch in any of the
+	 * src/dst pairs.
+	 */
+	if (!attach_cpus_updated)
+		attach_cpus_updated = !cpu_match;
+
+	if (!attach_mems_updated)
+		attach_mems_updated = !mem_match;
 
 	/*
 	 * Skip rights over task setsched check in v2 when nothing changes,
 	 * migration permission derives from hierarchy ownership in
 	 * cgroup_procs_write_permission()).
 	 */
-	*psetsched = !cpuset_v2() || attach_cpus_updated || attach_mems_updated;
+	*psetsched = !cpuset_v2() || !cpu_match || !mem_match;
 
 	/*
 	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
@@ -3053,33 +3076,103 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	return 0;
 }
 
-static int cpuset_reserve_dl_bw(struct cpuset *cs)
+/*
+ * If reset_dl_bw is set, reset the previous dl_bw_alloc() call. Otherwise,
+ * update nr_deadline_tasks according to nr_migrate_dl_tasks in both source
+ * and destination cpusets.
+ */
+static void clear_attach_data(bool reset_dl_bw)
+{
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
+	attach_cpus_updated = false;
+	attach_mems_updated = false;
+}
+
+static int cpuset_reserve_dl_bw(void)
 {
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
@@ -3101,6 +3194,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
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
@@ -3122,23 +3225,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3153,14 +3252,8 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
 
@@ -3232,7 +3325,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
@@ -3245,32 +3337,40 @@ static void cpuset_attach(struct cgroup_taskset *tset)
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


