Return-Path: <cgroups+bounces-16542-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKvhEERBHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16542-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:34:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DECD36274A7
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A79530819F8
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEB36A01A;
	Tue,  2 Jun 2026 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXGCdN4v"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B59367B90
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367552; cv=none; b=GMS525LutMFZH3Arb/+1US9ZlFU/5bbgp9lGdDcCiWAIjpGt3ztdkMF6pWP/7uGdu3sTIXCOZpL3G1mm9U0+XqFNODUje5tZdItjRv8tFYew4iusZ1iHZADULhcOCd3NGlh/vXVFpamq7txeYEBuRCHVRjX6XFIwk6BTUoT5M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367552; c=relaxed/simple;
	bh=HQCvVe56NaRzi12GaxnNyzC/7fVnERC1Knnay7jjn1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXBiRryODC7KdFsqO/zBvAdhaHBp2igVmsaLlDTWOA2p6F3vwsoqFudhB5J2UF19Q9nxm77hajrjLF0CINvlxAIEeN+8Ywrcj+SrVoYD8P+4jZbybBlwdNIyg7Q+Qr8acuuwAdDp8aBsttzfOBvPdn7gYqHdx2n9QzJ6VszN2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXGCdN4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780367550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPJhyuKyKW5m95bvMJtgDKchT6XlrtNxJvoZ3uaQdl8=;
	b=ZXGCdN4v55vHQtw5lZsLeCAhOQltx4gKy3xrlJiaZ0VWCyjZ6JBqczWMavzrJNtRHkvYMi
	N6eEWhKPVUBEyfI5ReL8NBDHxmf/bTUfXBMdLwUePOLKfffUCpDw4Xcg96YRe2YKwQqML+
	x2u1uQTimliyHEMrQQj21BXoar84JGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-PH8BRYIYMieaXaPmm2iOew-1; Mon,
 01 Jun 2026 22:32:26 -0400
X-MC-Unique: PH8BRYIYMieaXaPmm2iOew-1
X-Mimecast-MFC-AGG-ID: PH8BRYIYMieaXaPmm2iOew_1780367545
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 086E5195608F;
	Tue,  2 Jun 2026 02:32:25 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ADD419560A3;
	Tue,  2 Jun 2026 02:32:22 +0000 (UTC)
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
Subject: [PATCH-next v5 5/6] cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
Date: Mon,  1 Jun 2026 22:32:02 -0400
Message-ID: <20260602023203.248077-6-longman@redhat.com>
In-Reply-To: <20260602023203.248077-1-longman@redhat.com>
References: <20260602023203.248077-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16542-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DECD36274A7
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
 kernel/cgroup/cpuset.c | 103 ++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 60e8149cc907..5b5352ec0e69 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2978,8 +2978,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 /*
  * cpuset_can_attach() and cpuset_attach() specific internal data
  * Protected by cpuset_mutex
+ *
+ * The attach_cpus_updated/attach_mems_updated flags are set in either
+ * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
  */
 static struct cpuset *cpuset_attach_old_cs;
+static bool attach_cpus_updated;
+static bool attach_mems_updated;
 
 /*
  * Check to see if a cpuset can accept a new task
@@ -3157,9 +3162,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
@@ -3173,28 +3181,60 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	 */
 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
+	if (cpuset_v2() && !attach_mems_updated)
+		return;
+
 	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 	cpuset1_update_task_spread_flags(cs, task);
+
+	if ((task != task->group_leader) ||
+	    (!is_memory_migrate(cs) && !attach_mems_updated))
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
-	bool cpus_updated, mems_updated;
-	bool queue_task_work = false;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
-	cpus_updated = !cpumask_equal(cs->effective_cpus,
-				      oldcs->effective_cpus);
-	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	queue_task_work = false;
+
+	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3204,7 +3244,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 */
 	if (cpuset_v2()) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
-		if (!cpus_updated && !mems_updated)
+		if (!attach_cpus_updated && !attach_mems_updated)
 			goto out;
 	} else {
 		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
@@ -3213,38 +3253,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
-	/*
-	 * Change mm for all threadgroup leaders. This is expensive and may
-	 * sleep and should be moved outside migration path proper. Skip it
-	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
-	 * not set.
-	 */
-	if (!is_memory_migrate(cs) && !mems_updated)
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
@@ -3678,15 +3686,14 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
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
 
@@ -3698,7 +3705,17 @@ static void cpuset_fork(struct task_struct *task)
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
+	if (queue_task_work)
+		schedule_flush_migrate_mm();
 
 	dec_attach_in_progress_locked(cs);
 	mutex_unlock(&cpuset_mutex);
-- 
2.54.0


