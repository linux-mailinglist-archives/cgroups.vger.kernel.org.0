Return-Path: <cgroups+bounces-17352-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UtyUGzzHPmpQLgkAu9opvQ
	(envelope-from <cgroups+bounces-17352-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:38:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1633E6CFBB8
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:38:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Xpf4Lbg2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17352-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17352-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ABF73050BCE
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF43B9DBC;
	Fri, 26 Jun 2026 18:38:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6B3B993A
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 18:38:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499092; cv=none; b=lc1seXlNe3z1jEyxx4z5pjK9uqa1v1sNJjJq2IWVUVN3ldZzL9IVQhpfKYp0ODGrYJB3+3O/2fp+547ykAGrLdu/Q5DdyYvMcQq6qq933hSdBPvHAtE1R1nbRM9vyhD/ceYR27WUmtsFFkT+zJY72pU5mHbvbgccGWM6bs3Iznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499092; c=relaxed/simple;
	bh=li/4Wr7W4tQodPuAveYoyqxs9uPlTTT3aUy0GRkijgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGY8H2H/q0qUrhxUszKU++LlT5x1KL+9juukq7GUkYh5Cq+urP5ZZDly/2pmm7mKutRWcAlz7O6i/d424SRQGLhnjI7aBcpNFgaGo0LLfHnMeLdeHnpRcBe0Z7OL8jwok14Nz04UL5bFxbp3UKXbM4zVcyFJChaYDChG6dl6LnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xpf4Lbg2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782499089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy4bKJOUV/s6P7RHrDJS+mIwQbeYqorBagYZOVlLehE=;
	b=Xpf4Lbg2NvcssKzdnbOZY88mkDPPWF7ZKSopFo4nAvABKbTjuBIyLNSS9bAxMoEha5N7/L
	iIE3bZLp2pX23UMy0wlk6k7NBxhd/RGwXT2tFtKcqinb/DE+seW4IXVgvEO4Yf8Ij3T5Bn
	RmaENVaFITnR/p2GD/OFF++tMf1Y+kw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-MaULOmDGNwGWoNc1wMI-Ig-1; Fri,
 26 Jun 2026 14:38:06 -0400
X-MC-Unique: MaULOmDGNwGWoNc1wMI-Ig-1
X-Mimecast-MFC-AGG-ID: MaULOmDGNwGWoNc1wMI-Ig_1782499084
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B55D1956068;
	Fri, 26 Jun 2026 18:38:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3D419560A3;
	Fri, 26 Jun 2026 18:38:00 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v8 09/11] cgroup/cpuset: Support multiple source cpusets for cpuset_*attach()
Date: Fri, 26 Jun 2026 14:19:21 -0400
Message-ID: <20260626181923.133658-10-longman@redhat.com>
In-Reply-To: <20260626181923.133658-1-longman@redhat.com>
References: <20260626181923.133658-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17352-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1633E6CFBB8

There are 2 possible scenarios where the cgroup_taskset structure
passed into the cgroup can_attach() and attach() methods can contain
task migration data with multiple source cpusets.

 - A multithread application with threads in different cpusets is
   fully migrated into a new cpuset.
 - Disabling v2 cpuset controller will move all the tasks in child
   cpusets to the parent cpuset.

The current cpuset_can_attach() and cpuset_attach() functions still
expect task migration is from one source cpuset to one destination
cpuset.

Fix that by tracking the set of source (old) cpusets in singly linked
lists. The list will be iterated when necessary to properly update
internal data.

To ensure proper DL tasks accounting, the nr_migrate_dl_tasks in both
the source and destination cpusets are decremented/incremented with
their values added to nr_deadline_tasks when the migration is successful.

The setting of the global attach_ctx.cpus_updated and
attach_ctx.mems_updated flags are also moved from cpuset_attach()
to cpuset_can_attach() as the correct source cpuset can no longer be
determined in cpuset_attach() and cpuset states will not be changed
between cpuset_attach() and cpuset_can_attach() with an earlier patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  5 +++
 kernel/cgroup/cpuset.c          | 65 ++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 817b86ba7019..6636cf5ce326 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -145,6 +145,11 @@ struct cpuset {
 	 */
 	nodemask_t old_mems_allowed;
 
+	/*
+	 * For linking impacted cpusets during an attach operation.
+	 */
+	struct llist_node attach_node;
+
 	/* partition root state */
 	int partition_root_state;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ef14ee821b4b..e9e97c6765f0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
+#include <linux/llist.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -368,6 +369,7 @@ static struct {
 	struct cpuset *old_cs;	/* Source cpuset */
 	nodemask_t nodemask_to;
 } attach_ctx;
+static LLIST_HEAD(src_cs_head);
 
 static inline void check_insane_mems_config(nodemask_t *nodes)
 {
@@ -596,6 +598,7 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
 		return NULL;
 
 	trial->dl_bw_cpu = -1;
+	init_llist_node(&trial->attach_node);
 
 	/* Setup cpumask pointer array */
 	cpumask_var_t *pmask[4] = {
@@ -3013,6 +3016,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 				   bool *psetsched)
 {
+	bool cpus_updated, mems_updated;
+
 	if (cpumask_empty(cs->effective_cpus) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
@@ -3020,14 +3025,23 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!oldcs)
 		return 0;
 
+	if (!llist_on_list(&oldcs->attach_node))
+		llist_add(&oldcs->attach_node, &src_cs_head);
+
+	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	if (cpus_updated)
+		attach_ctx.cpus_updated = true;
+	if (mems_updated)
+		attach_ctx.mems_updated = true;
+
 	/*
 	 * Skip rights over task setsched check in v2 when nothing changes,
 	 * migration permission derives from hierarchy ownership in
 	 * cgroup_procs_write_permission()).
 	 */
-	*psetsched = !cpuset_v2() ||
-		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
-		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	*psetsched = !cpuset_v2() || cpus_updated || mems_updated;
 
 	/*
 	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
@@ -3068,6 +3082,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
 	cs->dl_bw_cpu = -1;
 }
 
+/*
+ * Clear and optionally apply (@cancel is false) the attach related data in the
+ * source cpusets.
+ */
+static void clear_attach_data(struct llist_head *head, bool cancel)
+{
+	struct cpuset *cs, *next;
+	struct llist_node *lnode = __llist_del_all(head);
+
+	llist_for_each_entry_safe(cs, next, lnode, attach_node) {
+		init_llist_node(&cs->attach_node);
+		if (cs->nr_migrate_dl_tasks) {
+			if (!cancel)
+				cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+			cs->nr_migrate_dl_tasks = 0;
+		}
+	}
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
@@ -3083,6 +3116,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
+	attach_ctx.cpus_updated = false;
+	attach_ctx.mems_updated = false;
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
@@ -3107,6 +3142,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * selected as attach_ctx.old_cs.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *new_oldcs = task_cs(task);
+
+		if (new_oldcs != oldcs) {
+			oldcs = new_oldcs;
+			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
+			if (ret)
+				goto out_unlock;
+		}
+
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
@@ -3128,6 +3172,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			 * contribute to sum_migrate_dl_bw.
 			 */
 			cs->nr_migrate_dl_tasks++;
+			oldcs->nr_migrate_dl_tasks--;
 			if (dl_task_needs_bw_move(task, cs->effective_cpus))
 				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
@@ -3136,10 +3181,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	ret = cpuset_reserve_dl_bw(cs);
 
 out_unlock:
-	if (ret)
+	if (ret) {
 		reset_migrate_dl_data(cs);
-	else
+		clear_attach_data(&src_cs_head, true);
+	} else {
 		attach_ctx.in_progress++;
+	}
 
 	mutex_unlock(&cpuset_mutex);
 	return ret;
@@ -3155,6 +3202,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 
 	mutex_lock(&cpuset_mutex);
 	dec_attach_in_progress_locked();
+	clear_attach_data(&src_cs_head, true);
 
 	if (cs->dl_bw_cpu >= 0)
 		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
@@ -3232,7 +3280,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = attach_ctx.old_cs;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
@@ -3240,9 +3287,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
 	attach_ctx.task_work_queued = false;
-
-	attach_ctx.cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	attach_ctx.mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
 
 	/*
@@ -3264,10 +3308,10 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	if (cs->nr_migrate_dl_tasks) {
 		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
 		reset_migrate_dl_data(cs);
 	}
 
+	clear_attach_data(&src_cs_head, false);
 	dec_attach_in_progress_locked();
 
 	mutex_unlock(&cpuset_mutex);
@@ -3785,6 +3829,7 @@ int __init cpuset_init(void)
 	cpumask_setall(top_cpuset.effective_xcpus);
 	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
+	init_llist_node(&top_cpuset.attach_node);
 
 	cpuset1_init(&top_cpuset);
 
-- 
2.54.0


