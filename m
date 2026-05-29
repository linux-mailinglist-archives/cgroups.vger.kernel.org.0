Return-Path: <cgroups+bounces-16468-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LZ8LV0FGmrK0ggAu9opvQ
	(envelope-from <cgroups+bounces-16468-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:30:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B555608E29
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43EA306E51E
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3323B47D7;
	Fri, 29 May 2026 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFVPKdFJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955B3B3883
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090138; cv=none; b=oaMmZvLr+BghGqVsz6md+X1TcwzIUN+IO5NksZFSpSwVFTB+0rtxqV/CIo7fsYNT1KFg+tI52mdDQe6ExENa0oLcmfx53l9xHZr85KP79A32r4dnIe0IW+Seie869Yf+R3Yuejt4bMG7q1MvYQ93BS6iHHbTh++CGY/ZGy78GfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090138; c=relaxed/simple;
	bh=QH1anqwkqXCmuzjztNL2pcLYHQUx6crv4qHp/ijamjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3GnMmPhP5Eh8GqGu5MLF5d1vso3D7GxDitMLkGrOwYIq98mVfyKGrRunoh1NsRaOaOoJ3YlOMkbjlI2H8rQFlrn/AKF7z6uILPsCJVsgL3qzSLXOvWX12cDirnqc0o1Mp9U7qtgrcjO/wCk5sz8vgaemcYnqNtClKBWer1uRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFVPKdFJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780090136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SMw7xQ5BsFrHaaGmk/pV3w+l6rWVP0mbQPQI/2QdkM=;
	b=QFVPKdFJRXsIQlWTOmxkF9CKwXDRFqjE12zumhxWaUpD+vSIFbcfbK3Ze4vwzYsXfyKuuJ
	1t8j9tIikwNO8ltI/tfHHGVu+67D8ePZujMVFPmpvQYKRbbD0SELDEgpHTE2FwwMt8xBbK
	oURY60Q4zSwqveR7T3ZNlTmM6fNB91U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-aeAr4rhzPsiRxzaBeVNT4w-1; Fri,
 29 May 2026 17:28:52 -0400
X-MC-Unique: aeAr4rhzPsiRxzaBeVNT4w-1
X-Mimecast-MFC-AGG-ID: aeAr4rhzPsiRxzaBeVNT4w_1780090131
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F344B18005BF;
	Fri, 29 May 2026 21:28:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A95C19560B2;
	Fri, 29 May 2026 21:28:49 +0000 (UTC)
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
Subject: [PATCH-next v4 3/6] cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
Date: Fri, 29 May 2026 17:21:05 -0400
Message-ID: <20260529212108.120506-4-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16468-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B555608E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expand the scope of cpuset_can_attach_check() by including the setting
of setsched flag inside cpuset_can_attach_check() with the new @oldcs
and @psetsched argument. As cpuset_can_attach_check() is also called
from cpuset_can_fork(), set the new arguments to NULL from that caller.

While at it, expose the source and destination cpuset cpu/memory check
results in the new attach_cpus_updated and attach_mems_updated static
flags so that these flags can be used directly from cpuset_attach()
without the need to do the same computations again.

Two new global attach related flags are added (attach_cpus_updated &
attach_mems_updated) which are set to indicate that CPUs or memory nodes
are updated. These 2 flags are set in cpuset_can_attach() and are used
in cpuset_attach() for optimization. Since cpuset_mutex will be released
between the 2 calls, it is possible that an intervening cpuset action
may change the CPU or node mask of the relevant cpusets, so check is
added to set these flags if the effective_cpus or effective_mems of
those cpusets is changed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 90 ++++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a6f191b48529..0f93f3d84494 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1108,6 +1108,14 @@ enum partition_cmd {
 static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 				    struct tmpmasks *tmp);
 
+/*
+ * cpuset_can_attach() and cpuset_attach() specific internal data
+ * Protected by cpuset_mutex
+ */
+static struct cpuset *cpuset_attach_old_cs;
+static bool attach_cpus_updated;
+static bool attach_mems_updated;
+
 /*
  * Update partition exclusive flag
  *
@@ -1192,6 +1200,8 @@ static void reset_partition_data(struct cpuset *cs)
 	}
 	if (!cpumask_and(cs->effective_cpus, parent->effective_cpus, cs->cpus_allowed))
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
+	if (cs->attach_in_progress)
+		attach_cpus_updated = true;
 }
 
 /*
@@ -1242,6 +1252,8 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
 				     xcpus);
 
 	cpumask_andnot(parent->effective_cpus, parent->effective_cpus, xcpus);
+	if (parent->attach_in_progress)
+		attach_cpus_updated = true;
 }
 
 /*
@@ -1269,6 +1281,8 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
 	cpumask_and(parent->effective_cpus, parent->effective_cpus, cpu_active_mask);
+	if (parent->attach_in_progress)
+		attach_cpus_updated = true;
 }
 
 /*
@@ -2217,6 +2231,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if (new_prs <= 0)
 			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
+		if (cp->attach_in_progress)
+			attach_cpus_updated = true;
 
 		notify_partition_change(cp, old_prs);
 
@@ -2720,6 +2736,8 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 		spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
 		spin_unlock_irq(&callback_lock);
+		if (cp->attach_in_progress)
+			attach_mems_updated = true;
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -2976,19 +2994,48 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
-static struct cpuset *cpuset_attach_old_cs;
-
 /*
  * Check to see if a cpuset can accept a new task
  * For v1, cpus_allowed and mems_allowed can't be empty.
  * For v2, effective_cpus can't be empty.
  * Note that in v1, effective_cpus = cpus_allowed.
+ *
+ * Also set the boolean flag passed in by @psetsched depending on if
+ * security_task_setscheduler() call is needed and @oldcs is not NULL.
  */
-static int cpuset_can_attach_check(struct cpuset *cs)
+static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
+				   bool *psetsched)
 {
 	if (cpumask_empty(cs->effective_cpus) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
+
+	if (!oldcs)
+		return 0;
+
+	/*
+	 * Update attach specific data
+	 */
+	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	/*
+	 * Skip rights over task setsched check in v2 when nothing changes,
+	 * migration permission derives from hierarchy ownership in
+	 * cgroup_procs_write_permission()).
+	 */
+	*psetsched = !cpuset_v2() || attach_cpus_updated || attach_mems_updated;
+
+	/*
+	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
+	 * brings the last online CPU offline as users are not allowed to empty
+	 * cpuset.cpus when there are active tasks inside. When that happens,
+	 * we should allow tasks to migrate out without security check to make
+	 * sure they will be able to run after migration.
+	 */
+	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
+		*psetsched = false;
+
 	return 0;
 }
 
@@ -3035,29 +3082,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * Skip rights over task setsched check in v2 when nothing changes,
-	 * migration permission derives from hierarchy ownership in
-	 * cgroup_procs_write_permission()).
-	 */
-	setsched_check = !cpuset_v2() ||
-		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
-		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
-
-	/*
-	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
-	 * brings the last online CPU offline as users are not allowed to empty
-	 * cpuset.cpus when there are active tasks inside. When that happens,
-	 * we should allow tasks to migrate out without security check to make
-	 * sure they will be able to run after migration.
-	 */
-	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
-		setsched_check = false;
-
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
@@ -3152,7 +3180,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
-	bool cpus_updated, mems_updated;
 	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
@@ -3160,9 +3187,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
-	cpus_updated = !cpumask_equal(cs->effective_cpus,
-				      oldcs->effective_cpus);
-	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3172,7 +3196,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 */
 	if (cpuset_v2()) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
-		if (!cpus_updated && !mems_updated)
+		if (!attach_cpus_updated && !attach_mems_updated)
 			goto out;
 	} else {
 		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
@@ -3187,7 +3211,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
 	 * not set.
 	 */
-	if (!is_memory_migrate(cs) && !mems_updated)
+	if (!is_memory_migrate(cs) && !attach_mems_updated)
 		goto out;
 
 	cgroup_taskset_for_each_leader(leader, css, tset) {
@@ -3602,7 +3626,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, NULL, NULL);
 	if (ret)
 		goto out_unlock;
 
@@ -3742,6 +3766,8 @@ hotplug_update_tasks(struct cpuset *cs,
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
 	spin_unlock_irq(&callback_lock);
+	if (cs->attach_in_progress)
+		attach_cpus_updated = attach_mems_updated = true;
 
 	if (cpus_updated)
 		cpuset_update_tasks_cpumask(cs, new_cpus);
@@ -3927,6 +3953,8 @@ static void cpuset_handle_hotplug(void)
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
 		spin_unlock_irq(&callback_lock);
+		if (top_cpuset.attach_in_progress)
+			attach_cpus_updated = true;
 		/* we don't mess with cpumasks of tasks in top_cpuset */
 	}
 
@@ -3937,6 +3965,8 @@ static void cpuset_handle_hotplug(void)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
 		spin_unlock_irq(&callback_lock);
+		if (top_cpuset.attach_in_progress)
+			attach_mems_updated = true;
 		cpuset_update_tasks_nodemask(&top_cpuset);
 	}
 
-- 
2.54.0


