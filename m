Return-Path: <cgroups+bounces-16355-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH33HkgQF2o12wcAu9opvQ
	(envelope-from <cgroups+bounces-16355-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:39:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B431B5E703E
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7780C3012E59
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D4643C065;
	Wed, 27 May 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2iLgla2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32855439001
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896341; cv=none; b=Q0kWMu7p8NFozTOkoQmROcpDOqWtTbJdf7TNHI63lorl9tk4HeCbvf3h6c13ay3bmbox9LXWsPPh2aLrF8eAd4QCRJ4z88kfOQpIBxRFTX8vr6LVKbidx4bricayddEIpMCDOd3AsHiy3FoMvj6H1kQX9EwRsBSOoP2rBSSk6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896341; c=relaxed/simple;
	bh=dL4gdRYqnMCeb252iY/xIAcCW9yEioXpMDS7WqdE3UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S38mMvslOI4bTnXaW89zanRhx5DhSYTohY0fwDL+QLUDBSw4QvpwheZXmhNQynvq/097KxpxyosxzEuuriNsC3FpJ+tq4fyzc/KfcfoTHwlRLqoovpdmls9QHcUTwXR4U+9t9rnDjfagjurRLNfLhOzhQ4Nn65Y9MxSB6LY6unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2iLgla2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779896339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt9Ea54oKwKAM2FGP6dVWKvNbQSOMPo66Nt3+qrZN94=;
	b=S2iLgla2G97JSSa/uB/4x6UfZNQUypVvDsmC9hLWp4ntTnzD9J3+S/BygjRnF5nGc4N2zT
	1p+XmF/FBQffR2hyh5Da5oOEjY3mMYgE9MnFK+l2k2iNuhrglVFABXZcEGfGFBuXXgnFTJ
	UHFyicspr+SiMiqaq655GMz5KHqroH0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-77ppD__vMWiNB1sSipYC3w-1; Wed,
 27 May 2026 11:38:53 -0400
X-MC-Unique: 77ppD__vMWiNB1sSipYC3w-1
X-Mimecast-MFC-AGG-ID: 77ppD__vMWiNB1sSipYC3w_1779896332
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3931195605F;
	Wed, 27 May 2026 15:38:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 098231800465;
	Wed, 27 May 2026 15:38:49 +0000 (UTC)
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
Subject: [PATCH-next v3 4/5] cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
Date: Wed, 27 May 2026 11:37:59 -0400
Message-ID: <20260527153800.1557449-5-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-16355-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B431B5E703E
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
cpuset_attach_old_cs, attach_cpus_updated and attach_mems_updated will
also need to be updated in cpuset_fork().

Besides, the original code use cpuset_attach_nodemask_to for
both nodemask returned by guarantee_online_mems() used only by
cpuset_change_task_nodemask() and cs->effective_mems in all other cases.
Such dual use is now impractical by merging the two task iteration loops
into one. So keep cpuset_attach_nodemask_to for the nodemask returned
by guarantee_online_mems() and reference cs->effective_mems directly
in all the other cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 90 ++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b233a71f9b7c..7100575927f6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3149,9 +3149,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
@@ -3165,24 +3168,56 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
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
+					  &cs->effective_mems);
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
@@ -3190,53 +3225,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * in effective cpus and mems. In that case, we can optimize out
 	 * by skipping the task iteration and update.
 	 */
-	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
-		cpuset_attach_nodemask_to = cs->effective_mems;
+	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated)
 		goto out;
-	}
 
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
-	/*
-	 * Change mm for all threadgroup leaders. This is expensive and may
-	 * sleep and should be moved outside migration path proper. Skip it
-	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
-	 * not set.
-	 */
-	cpuset_attach_nodemask_to = cs->effective_mems;
-	if (!is_memory_migrate(cs) && !attach_mems_updated)
-		goto out;
-
-	cgroup_taskset_for_each_leader(leader, css, tset) {
-		struct mm_struct *mm = get_task_mm(leader);
-
-		if (mm) {
-			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
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
-	cs->old_mems_allowed = cpuset_attach_nodemask_to;
+	cs->old_mems_allowed = cs->effective_mems;
 
 	if (cs->nr_migrate_dl_tasks) {
 		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
@@ -3666,15 +3666,14 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
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
 
@@ -3686,7 +3685,12 @@ static void cpuset_fork(struct task_struct *task)
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	/* Assume CPUs and memory nodes are updated */
+	attach_cpus_updated = attach_mems_updated = true;
+	cpuset_attach_old_cs = oldcs;
+	oldcs->old_mems_allowed = oldcs->effective_mems;
 	cpuset_attach_task(cs, task);
+	attach_cpus_updated = attach_mems_updated = false;
 
 	dec_attach_in_progress_locked(cs);
 	mutex_unlock(&cpuset_mutex);
-- 
2.54.0


