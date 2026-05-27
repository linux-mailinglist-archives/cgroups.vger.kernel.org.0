Return-Path: <cgroups+bounces-16353-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EDQEhQSF2o12wcAu9opvQ
	(envelope-from <cgroups+bounces-16353-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:47:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734A5E7240
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2180304551B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6074F436355;
	Wed, 27 May 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP5YW84I"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137742EEA7
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896335; cv=none; b=W7DTYP+AjspglHSsHxWb1rXyv9DBwpLpcL+mu0g4Rspl8ITNovwaNwyLb7YbpyhBiv8KPmiL5H9BMEWf1TC65bY52NEr11xMlvwzupG+xeD1yBTsBnHvkseIBULnOzTcaiH/zLg4jFvWTj8FqydmUzHhlRa+P7EwKHl3jcY/Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896335; c=relaxed/simple;
	bh=vXaHGpo/cOpKoi25nWttdUbf6C9e0+GWhw1wTzmdFDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZmkwFtd2GrMfOBORZ3R4FHfKEt/CMh8K6Z8VLspQgMonlzmCmO5uXUEcFP3/EjSkx6P1OVj+FAiQnh2ao8s0TIwcaPbbYtsAnaW6RP0kWrz9BFZX7K5Y9CFwba+yHf3CnAio4SsYt1D5OGMSuVNb7gsLn3d8XiEw1bUk54oNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP5YW84I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779896332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7MH3OtjWXO3O907SYH4/EiI2G1a5AP5AYerCApbaVM=;
	b=UP5YW84IWI6HVs2T8aJfrFE4DN0Nl0rgQ5bL0s6OgK7kEnWZhrRRfFFkOEGaEP6kfC5liF
	BA2DYcmrd1bs/8IbPyRTBBhCJZ6IAjmV5vn4O4bspKjNcj3TXNfq9NBVmP0TySrMDBNNqK
	luHELDiT8Ap1i+a9Sp3XnfDFvPHjUSc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-kxy6W9r-OXG8Mbocx97J9w-1; Wed,
 27 May 2026 11:38:49 -0400
X-MC-Unique: kxy6W9r-OXG8Mbocx97J9w-1
X-Mimecast-MFC-AGG-ID: kxy6W9r-OXG8Mbocx97J9w_1779896328
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACB051956096;
	Wed, 27 May 2026 15:38:47 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20D961800465;
	Wed, 27 May 2026 15:38:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v3 2/5] cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
Date: Wed, 27 May 2026 11:37:57 -0400
Message-ID: <20260527153800.1557449-3-longman@redhat.com>
In-Reply-To: <20260527153800.1557449-1-longman@redhat.com>
References: <20260527153800.1557449-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-16353-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Queue-Id: 1734A5E7240
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

No functional change is expected.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 70 +++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d720bcc7ef83..4457c4f11fce 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2964,19 +2964,56 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
+/*
+ * cpuset_can_attach() and cpuset_attach() specific internal data
+ * Protected by cpuset_mutex
+ */
 static struct cpuset *cpuset_attach_old_cs;
+static bool attach_cpus_updated;
+static bool attach_mems_updated;
 
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
 
@@ -3023,29 +3060,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3140,7 +3158,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
-	bool cpus_updated, mems_updated;
 	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
@@ -3148,9 +3165,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
-	cpus_updated = !cpumask_equal(cs->effective_cpus,
-				      oldcs->effective_cpus);
-	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3158,7 +3172,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * in effective cpus and mems. In that case, we can optimize out
 	 * by skipping the task iteration and update.
 	 */
-	if (cpuset_v2() && !cpus_updated && !mems_updated) {
+	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
 		goto out;
 	}
@@ -3175,7 +3189,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * not set.
 	 */
 	cpuset_attach_nodemask_to = cs->effective_mems;
-	if (!is_memory_migrate(cs) && !mems_updated)
+	if (!is_memory_migrate(cs) && !attach_mems_updated)
 		goto out;
 
 	cgroup_taskset_for_each_leader(leader, css, tset) {
@@ -3590,7 +3604,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, NULL, NULL);
 	if (ret)
 		goto out_unlock;
 
-- 
2.54.0


