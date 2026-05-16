Return-Path: <cgroups+bounces-15994-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCYYJl/yB2qbQQMAu9opvQ
	(envelope-from <cgroups+bounces-15994-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:28:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488F55A2D0
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421B9302795B
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 04:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F252D3A60;
	Sat, 16 May 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIsyqFHL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4072242D6B
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905586; cv=none; b=Tw3JEOuZVmle0mzhyyZPplyTSYuVoJuL06IGiRhrVxrmWSqVVsUCpnFi3V/FAAajmWTaVTN9oKnfE5CAlLAjyvLF7t34xCqUV/9HovinjCLO7dic7/0xwsxHpmfkomUwfKxrCjQ6Y324jgicA0I2Ow1FMSmziGcx/qHY29QX+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905586; c=relaxed/simple;
	bh=RYqAPb+UVL2uAvnCHcK1rHa1Syzq493FwavoVozR4Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taAtEQ+Thfepem83/pk8p5yEWFc9uwMu2yOemGMl/pC1DAQEoTaED6W5OWMVV75GnkIIrzCmeBeoH8Dx2ZfBNm4SlDA93rOlE20TXDgOXL3fnGZqkq5bRO4qho3XRdpkJOPR0UTTpAuIm18tLb61E9AY+/MQptPV+sY9oN8nELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIsyqFHL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778905583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46zhY4m0IBo27ES4iopox1tGyl+dgQiIRjzfl6S0V+g=;
	b=YIsyqFHL2ese0WAE2HBnLu0oBJp1KM44c3n1PgEL7TrLiLtPBXhcPCoXr/eDKFDb+eFQDE
	38qvq+i7eyqztSEa19a8kLbjnMoNwY+QFlMy3421uBK4684Ly5WtFLVC2/nxnh9zBAgsf0
	Vlpvn1+vaTenPIS2Ffms3GpS2MjEUzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-7UHSvjMBMsi6VG5_EIAS0w-1; Sat,
 16 May 2026 00:25:43 -0400
X-MC-Unique: 7UHSvjMBMsi6VG5_EIAS0w-1
X-Mimecast-MFC-AGG-ID: 7UHSvjMBMsi6VG5_EIAS0w_1778905533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9826618002C7;
	Sat, 16 May 2026 04:25:32 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04DA51803A91;
	Sat, 16 May 2026 04:25:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next v2 4/5] cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
Date: Sat, 16 May 2026 00:24:47 -0400
Message-ID: <20260516042448.698216-5-longman@redhat.com>
In-Reply-To: <20260516042448.698216-1-longman@redhat.com>
References: <20260516042448.698216-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 0488F55A2D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15994-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The cpuset_attach_task() was introduced in commit 42a11bf5c543
("cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
to enable the CLONE_INTO_CGROUP flag of clone(2) to behave more like
moving a task from one cpuset into another one. That commits didn't
move the mpol_rebind_mm() and cpuset_migrate_mm() calls for group leader
into cpuset_attach_task().

When the CLONE_INTO_CGROUP flag is used without CLONE_THREAD, the
new task is its own group leader. So it is still not equivalent to
moving task between cpusets in this case. Make CLONE_INTO_CGROUP
behaves more close to cpuset_attach() by moving the mpol_rebind_mm()
and cpuset_migrate_mm() calls inside cpuset_attach_task().

Besides, the original code use cpuset_attach_nodemask_to for
both nodemask returned by guarantee_online_mems() used only by
cpuset_change_task_nodemask() and cs->effective_mems in all other cases.
Such dual use is now impractical by merging the two task iteration loops
into one. So keep cpuset_attach_nodemask_to for the nodemask returned
by guarantee_online_mems() and reference cs->effective_mems directly
in all the other cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 82 ++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fc632370d07c..ab9fcc001f79 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3130,9 +3130,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
@@ -3146,17 +3149,48 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
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
+		struct cpuset *oldcs = task->attach_old_cs;
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
+		if (oldcs && is_memory_migrate(cs)) {
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
 	struct cpuset *cs, *oldcs;
-	bool queue_task_work = false;
 
 	task = cgroup_taskset_first(tset, &css);
 	oldcs = task->attach_old_cs;
@@ -3164,6 +3198,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
+	queue_task_work = false;
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3171,53 +3206,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
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
@@ -3667,7 +3667,11 @@ static void cpuset_fork(struct task_struct *task)
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	/* Assume CPUs and memory nodes are updated */
+	attach_cpus_updated = attach_mems_updated = true;
+	task->attach_old_cs = task_cs(current);
 	cpuset_attach_task(cs, task);
+	attach_cpus_updated = attach_mems_updated = false;
 
 	dec_attach_in_progress_locked(cs);
 	mutex_unlock(&cpuset_mutex);
-- 
2.54.0


