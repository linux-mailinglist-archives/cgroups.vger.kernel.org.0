Return-Path: <cgroups+bounces-16470-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEfrKcMFGmrK0ggAu9opvQ
	(envelope-from <cgroups+bounces-16470-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:31:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEA608E62
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E64830A5E23
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB63BA236;
	Fri, 29 May 2026 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkuBbYso"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F933B6C0C
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090146; cv=none; b=a+Sm7kRbveqWovhQsyj0GtlPYr9nHEyx4ehKUFNpJD9xagVQ0H5O/Bs2gHnCGV00eyAK7NAnB4N+yHmBtVxEoYBf9IAiwP+hVAHd84MvazonTsO24neNrgRY8QHKOki5zudU4DioZu7AFYFYOgMPFOc2T/l/zejuv0RTbxVKHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090146; c=relaxed/simple;
	bh=V9DFmSDhG43eGFNXkB+UQL0h3Yfa4lT/yeGDh7pikUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDh+wECdBYChvTK5svCugpST2g98C+u6ZvlPeXnujm6SNh61+rAVJLmk7+XCfIQ5lewrY+V1Nch9TBq7omn/RU3k4UfskXE3oKwfkbHIyZNXU4pqMBtK/Da7lFzEjSVnX6/H7kbmAgOD9lLi8A4yjmvjh0LY271Tdq5CjZBdl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkuBbYso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780090141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5q566hPmN0jAjitqvJNqIepGnvrcfqAOr2eXJQ++W8=;
	b=MkuBbYsoopBuciO4xTqwWKrNjXDJndoiQgZS1WzROTMLrDsL9i+AMxrSEBvnTFod7DgUhS
	Afis2EMGcBq8NpY+FkPU57BgQD4EHifPDXurdQr/H+sG3qmhwVBiV6o/FCszQipDMVRZGF
	6AE4JClIYuHFTF7WuohpY+4AVM/7oPk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-GdTFWSfDNUusJdRxjEUbBQ-1; Fri,
 29 May 2026 17:28:57 -0400
X-MC-Unique: GdTFWSfDNUusJdRxjEUbBQ-1
X-Mimecast-MFC-AGG-ID: GdTFWSfDNUusJdRxjEUbBQ_1780090136
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9240195608A;
	Fri, 29 May 2026 21:28:55 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B90819560B0;
	Fri, 29 May 2026 21:28:53 +0000 (UTC)
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
Subject: [PATCH-next v4 5/6] cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
Date: Fri, 29 May 2026 17:21:07 -0400
Message-ID: <20260529212108.120506-6-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16470-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 50DEA608E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cpuset_attach_task() was introduced in commit 42a11bf5c543
("cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
to enable the CLONE_INTO_CGROUP flag of clone(2) to behave more like
moving a task from one cpuset into another one. That commits didn't
move the mpol_rebind_mm() and cpuset_migrate_mm() calls for group leader
into cpuset_attach_task().

When the CLONE_INTO_CGROUP flag is used without CLONE_THREAD, the new
task is its own group leader. So it is still not equivalent to moving
task between cpusets in this case. Make CLONE_INTO_CGROUP behaves
more close to cpuset_attach() by moving the mpol_rebind_mm() and
cpuset_migrate_mm() calls inside cpuset_attach_task(). As a result,
the following static variables will have to be updated in cpuset_fork().
 - cpuset_attach_old_cs
 - attach_cpus_updated
 - attach_mems_updated
 - queue_task_work

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 89 ++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0bb63a9cda0b..a6506b94e60a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3171,9 +3171,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
  */
 static cpumask_var_t cpus_attach;
 static nodemask_t cpuset_attach_nodemask_to;
+static bool queue_task_work;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
+	struct mm_struct *mm;
+
 	lockdep_assert_cpuset_lock_held();
 
 	if (cs != &top_cpuset)
@@ -3187,24 +3190,56 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	 */
 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
+	if (cpuset_v2() && !attach_mems_updated)
+		return;
+
 	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 	cpuset1_update_task_spread_flags(cs, task);
+
+	if (task != task->group_leader)
+		return;
+
+	/*
+	 * Change mm for threadgroup leader. This is expensive and may
+	 * sleep and should be moved outside migration path proper.
+	 */
+	mm = get_task_mm(task);
+	if (mm) {
+		struct cpuset *oldcs = cpuset_attach_old_cs;
+
+		mpol_rebind_mm(mm, &cs->effective_mems);
+
+		/*
+		 * old_mems_allowed is the same with mems_allowed
+		 * here, except if this task is being moved
+		 * automatically due to hotplug.  In that case
+		 * @mems_allowed has been updated and is empty, so
+		 * @old_mems_allowed is the right nodesets that we
+		 * migrate mm from.
+		 */
+		if (is_memory_migrate(cs)) {
+			cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
+					  &cpuset_attach_nodemask_to);
+			queue_task_work = true;
+		} else {
+			mmput(mm);
+		}
+	}
 }
 
 static void cpuset_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
-	struct task_struct *leader;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct cpuset *oldcs = cpuset_attach_old_cs;
-	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
+	queue_task_work = false;
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3223,38 +3258,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
-	/*
-	 * Change mm for all threadgroup leaders. This is expensive and may
-	 * sleep and should be moved outside migration path proper. Skip it
-	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
-	 * not set.
-	 */
-	if (!is_memory_migrate(cs) && !attach_mems_updated)
-		goto out;
-
-	cgroup_taskset_for_each_leader(leader, css, tset) {
-		struct mm_struct *mm = get_task_mm(leader);
-
-		if (mm) {
-			mpol_rebind_mm(mm, &cs->effective_mems);
-
-			/*
-			 * old_mems_allowed is the same with mems_allowed
-			 * here, except if this task is being moved
-			 * automatically due to hotplug.  In that case
-			 * @mems_allowed has been updated and is empty, so
-			 * @old_mems_allowed is the right nodesets that we
-			 * migrate mm from.
-			 */
-			if (is_memory_migrate(cs)) {
-				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
-						  &cpuset_attach_nodemask_to);
-				queue_task_work = true;
-			} else
-				mmput(mm);
-		}
-	}
-
 out:
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
@@ -3688,15 +3691,14 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
  */
 static void cpuset_fork(struct task_struct *task)
 {
-	struct cpuset *cs;
-	bool same_cs;
+	struct cpuset *cs, *oldcs;
 
 	rcu_read_lock();
 	cs = task_cs(task);
-	same_cs = (cs == task_cs(current));
+	oldcs = task_cs(current);
 	rcu_read_unlock();
 
-	if (same_cs) {
+	if (cs == oldcs) {
 		if (cs == &top_cpuset)
 			return;
 
@@ -3708,7 +3710,18 @@ static void cpuset_fork(struct task_struct *task)
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	/*
+	 * Assume CPUs and memory nodes are updated
+	 * A CLONE_INTO_CGROUP operation should have taken the cgroup mutex
+	 * and so there shouldn't be a competing cpuset_attach() operation.
+	 */
+	attach_cpus_updated = attach_mems_updated = true;
+	queue_task_work = false;
+	cpuset_attach_old_cs = oldcs;
 	cpuset_attach_task(cs, task);
+	attach_cpus_updated = attach_mems_updated = false;
+	if (queue_task_work)
+		schedule_flush_migrate_mm();
 
 	dec_attach_in_progress_locked(cs);
 	mutex_unlock(&cpuset_mutex);
-- 
2.54.0


