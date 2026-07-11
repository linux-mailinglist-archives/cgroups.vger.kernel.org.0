Return-Path: <cgroups+bounces-17660-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WC8yJnilUWpMHAMAu9opvQ
	(envelope-from <cgroups+bounces-17660-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:07:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4173FFE1
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 04:07:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a8k7DeGc;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17660-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17660-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1393022631
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2026 02:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E12DE6E3;
	Sat, 11 Jul 2026 02:06:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DB2E7386
	for <cgroups@vger.kernel.org>; Sat, 11 Jul 2026 02:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735602; cv=none; b=oxjwiDrc6EHpMu963QO/QhodscG7hFXmuVCxxWHXcVuVv9IT01aCULe0iAVl409y+fgolZUwanzQFuVTzM8jfmf6Azb4nZpDY68HY8R0Z5MZYEyBm2k3T6etN0B02Rp0AKMaKlmBdoA97H2AGPYa2srUJ8bxBUvr0+dH4ZtQeyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735602; c=relaxed/simple;
	bh=d5x5hxSCNVRHC/vROq1y9apSYTx0rHEbfnGJ+dEkbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmvu5CXx6ykQ3+v8MMMpTf5hITS59WxXzQ1mJY2JnlcunrMa3VT32RgxMPLvSiyGbJNtushpxxTk88W1a8FuF5bj27Hq+o9GLzegOIITJOm4vtwYOCVMZTYih8bQNt45RE1JTXiCHw2/q14Yvfif5Soni3XF+NHsF6wuRlDXVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8k7DeGc; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783735596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7oN7C4SdS1DdzK7LkW8aF1xWEBreX2hjWsU9u4vHF0=;
	b=a8k7DeGcd1YNE+rbkXXECELZRw9whJoa5nRMpg08ZQ56gZv2v8BuQ+8eIBxbMRjtI0j5PL
	aLDeYzA70ygmoCj7c8mMlkksSHGmC+YhDD4Aw7nA5WwuRcgbSoCsjluh8bKT/KY4y2ArbQ
	vc9wD5MrE2yzZ1uVdPAgVHR5lgAMj98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-0Id7R01XOZiJ9jJf86e2XA-1; Fri,
 10 Jul 2026 22:06:32 -0400
X-MC-Unique: 0Id7R01XOZiJ9jJf86e2XA-1
X-Mimecast-MFC-AGG-ID: 0Id7R01XOZiJ9jJf86e2XA_1783735590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65FD1180025F;
	Sat, 11 Jul 2026 02:06:30 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.88.253])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03CF7195419F;
	Sat, 11 Jul 2026 02:06:28 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next 2/3] cgroup/cpuset: Support multiple destination cpusets for cpuset_*attach()
Date: Fri, 10 Jul 2026 22:05:39 -0400
Message-ID: <20260711020540.176740-3-longman@redhat.com>
In-Reply-To: <20260711020540.176740-1-longman@redhat.com>
References: <20260711020540.176740-1-longman@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17660-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00F4173FFE1

The only case where the cgroup_taskset structure requires task migration
to multiple cpusets is when enabling a cpuset controller in cgroup v2
where the newly created child cpusets inherits the same effective CPUs
and memory nodes from the parent. In that case, task migration can happen
directly with no update to tasks' CPU and memory nodes assignment and no
further work needed from the cpuset side except updating nr_deadline_tasks
when DL tasks are involved and setting old_mems_allowed in the child
cpusets.

Do that by tracking all the destination cpusets with a new dst_cs_head
singly linked list. The reset_migrate_dl_data() function is integrated
into clear_attach_data() so that it can be used for both source and
destination cpusets.

A warning will be printed if there are multiple destination cpusets but
it is not on default hierarchy or when the CPUs or memory nodes change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 99 ++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d99184ec60b5..68943671d97d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -366,10 +366,12 @@ static struct {
 	bool cpus_updated;
 	bool mems_updated;
 	bool task_work_queued;
+	bool many_dest_cs;	/* Have many destination cpusets */
 	struct cpuset *old_cs;	/* Source cpuset */
 	nodemask_t nodemask_to;
 } attach_ctx;
 static LLIST_HEAD(src_cs_head);
+static LLIST_HEAD(dst_cs_head);
 
 /*
  * Wait if task attach is in progress until it is done and then acquire
@@ -3052,6 +3054,9 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!llist_on_list(&oldcs->attach_node))
 		llist_add(&oldcs->attach_node, &src_cs_head);
 
+	if (!llist_on_list(&cs->attach_node))
+		llist_add(&cs->attach_node, &dst_cs_head);
+
 	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
@@ -3080,35 +3085,31 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	return 0;
 }
 
-static int cpuset_reserve_dl_bw(struct cpuset *cs)
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
-{
-	cs->nr_migrate_dl_tasks = 0;
-	cs->sum_migrate_dl_bw = 0;
-	cs->dl_bw_cpu = -1;
-}
-
 /*
  * Clear and optionally apply (@cancel is false) the attach related data in the
- * source cpusets.
+ * source or destination cpuset.
  */
 static void clear_attach_data(struct llist_head *head, bool cancel)
 {
@@ -3120,7 +3121,11 @@ static void clear_attach_data(struct llist_head *head, bool cancel)
 		if (cs->nr_migrate_dl_tasks) {
 			if (!cancel)
 				atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
+			else if (cs->dl_bw_cpu >= 0) /* && cacnel */
+				dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
 			cs->nr_migrate_dl_tasks = 0;
+			cs->sum_migrate_dl_bw = 0;
+			cs->dl_bw_cpu = -1;
 		}
 	}
 }
@@ -3142,6 +3147,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 	attach_ctx.cpus_updated = false;
 	attach_ctx.mems_updated = false;
+	attach_ctx.many_dest_cs = false;
 
 	/*
 	 * The attach_ctx.old_cs is used mainly by cpuset_migrate_mm() to get
@@ -3166,9 +3172,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * actual migration wrt cpuset.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *new_cs = css_cs(css);
 		struct cpuset *new_oldcs = task_cs(task);
 
-		if (new_oldcs != oldcs) {
+		if ((new_oldcs != oldcs) || (new_cs != cs)) {
+			if (new_cs != cs)
+				attach_ctx.many_dest_cs = true;
+			cs = new_cs;
 			oldcs = new_oldcs;
 			if (oldcs == cs)
 				continue;
@@ -3207,12 +3217,28 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 	}
 
-	ret = cpuset_reserve_dl_bw(cs);
+	/*
+	 * The only case where there are multiple destination cpusets for
+	 * task migration is when enabling a v2 cpuset controllers where
+	 * tasks will be migrated to multiple child cpusets from a parent
+	 * cpuset with the same effective CPUs and memory nodes. IOW,
+	 * both attach_cpus_updated and attach_mems_updated should be false.
+	 * If not, it is a condition that the current code cannot handle.
+	 * Print a warning and abort the attach operation as further code
+	 * change may be needed.
+	 */
+	if (WARN_ON_ONCE(attach_ctx.many_dest_cs && (!cpuset_v2() ||
+			 attach_ctx.cpus_updated || attach_ctx.mems_updated))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = cpuset_reserve_dl_bw();
 
 out_unlock:
 	if (ret) {
-		reset_migrate_dl_data(cs); /* Destination cpuset only */
 		clear_attach_data(&src_cs_head, true);
+		clear_attach_data(&dst_cs_head, true);
 	} else {
 		attach_ctx.in_progress++;
 	}
@@ -3223,22 +3249,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
-	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
-
-	cgroup_taskset_first(tset, &css);
-	cs = css_cs(css);
-
 	mutex_lock(&cpuset_mutex);
 	dec_attach_in_progress_locked();
 	clear_attach_data(&src_cs_head, true);
-
-	if (cs->dl_bw_cpu >= 0)
-		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
-
-	if (cs->nr_migrate_dl_tasks)
-		reset_migrate_dl_data(cs);
-
+	clear_attach_data(&dst_cs_head, true);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3321,25 +3335,24 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * In the default hierarchy, enabling cpuset in the child cgroups
 	 * will trigger a cpuset_attach() call with no change in effective cpus
 	 * and mems. In that case, we can optimize out by skipping the task
-	 * iteration and update.
+	 * iteration and the destination cpuset list is iterated to set
+	 * old_mems_allowed.
 	 */
-	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated)
+	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated) {
+		llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+			cs->old_mems_allowed = attach_ctx.nodemask_to;
 		goto out;
+	}
 
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
-out:
 	if (attach_ctx.task_work_queued)
 		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = attach_ctx.nodemask_to;
-
-	if (cs->nr_migrate_dl_tasks) {
-		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
-		reset_migrate_dl_data(cs);
-	}
-
+out:
 	clear_attach_data(&src_cs_head, false);
+	clear_attach_data(&dst_cs_head, false);
 	dec_attach_in_progress_locked();
 
 	mutex_unlock(&cpuset_mutex);
-- 
2.55.0


