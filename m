Return-Path: <cgroups+bounces-15947-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG+6En0ABmrFdwIAu9opvQ
	(envelope-from <cgroups+bounces-15947-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:03:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5017B5450EC
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 808E6301F2AF
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877093890F7;
	Thu, 14 May 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWp9TbH6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA448386C2D
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778205; cv=none; b=j52OG9Ao4cvOwsoQv2kdRfm3ea3RsznY1AjFBMhwuIErqGkOhKshssjKAiwpsynDC1XFWqHooHnJ6AdXCfUf2op2CL9uaOi5pETAysgr2C1+4NmzQFisSwPK59Jz/bOb71dCctUeghiajN4N1KdvA34mgd1mKNMJfAq3r677Np4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778205; c=relaxed/simple;
	bh=pYjUD22+aWQilVYJfFcAADyBmIDGS4OKvDVmoamoZ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmZUFjBkntAfOGTL5qR1f5JnWoKyDnWMHNlEpOgxw5aOgIg7vHCz/pDiNQ/yUTU8XomBb2AHlQkiymMeODeutTJT/JnOHZeBDZurNneabWtRnbjaxaeEp9f+TZi2snE2hwJrgTteAOBfPidSxVgxRDQgBbtszi5zGCL5ktrdiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWp9TbH6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778778203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quk631IVTLhhlacI05pnzuPc48gNliQ5Sn1YUb7VsWc=;
	b=JWp9TbH6k2/ixShJeXSKKyi1lH1qjphB14Sn/feTSpnD4JAA9JvSF99Xl4sFR3SUwqpvp+
	P5UnJn4PGsSf38zaTmpgqdg8Dj5QHCxnojx8cIDNd61gluKRkdg2c3L1EOr+M9kWjEu90l
	HYWtVbUhH2Blc4mQaO9yXJ+p+WVpCYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680--KosFqCZPk2ycu5uzgzJ5A-1; Thu,
 14 May 2026 13:03:19 -0400
X-MC-Unique: -KosFqCZPk2ycu5uzgzJ5A-1
X-Mimecast-MFC-AGG-ID: -KosFqCZPk2ycu5uzgzJ5A_1778778198
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DEA11956080;
	Thu, 14 May 2026 17:03:17 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.73])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8661130002DC;
	Thu, 14 May 2026 17:03:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next 2/4] cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
Date: Thu, 14 May 2026 13:02:38 -0400
Message-ID: <20260514170240.575156-3-longman@redhat.com>
In-Reply-To: <20260514170240.575156-1-longman@redhat.com>
References: <20260514170240.575156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 5017B5450EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15947-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Expand the scope of cpuset_can_attach_check() by including the setting
of setsched flag inside cpuset_can_attach_check() with the new @oldcs
and @psetsched argument. As cpuset_can_attach_check() is also called
from cpuset_can_fork(), set the new arguments to NULL from that caller.

While at it, expose the source and destination cpuset cpu/memory check
results in the new attach_cpus_updated and attach_mems_updated static
flags so that these flags can be used directly from cpuset_attach()
without the need to do the same computations again.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9de3c907436f..68392cf6429b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2964,19 +2964,55 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
+/*
+ * cpuset_can_attach() and cpuset_attach() specific internal data
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
 
@@ -3023,29 +3059,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -3139,7 +3156,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
-	bool cpus_updated, mems_updated;
 	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
@@ -3147,9 +3163,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
-	cpus_updated = !cpumask_equal(cs->effective_cpus,
-				      oldcs->effective_cpus);
-	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3157,7 +3170,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * in effective cpus and mems. In that case, we can optimize out
 	 * by skipping the task iteration and update.
 	 */
-	if (cpuset_v2() && !cpus_updated && !mems_updated) {
+	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
 		goto out;
 	}
@@ -3174,7 +3187,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * not set.
 	 */
 	cpuset_attach_nodemask_to = cs->effective_mems;
-	if (!is_memory_migrate(cs) && !mems_updated)
+	if (!is_memory_migrate(cs) && !attach_mems_updated)
 		goto out;
 
 	cgroup_taskset_for_each_leader(leader, css, tset) {
@@ -3589,7 +3602,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, NULL, NULL);
 	if (ret)
 		goto out_unlock;
 
-- 
2.54.0


