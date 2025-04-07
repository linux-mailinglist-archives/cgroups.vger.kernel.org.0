Return-Path: <cgroups+bounces-7399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09EAA7EFBD
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E72C189550A
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0C223335;
	Mon,  7 Apr 2025 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPkWt9uM"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255521ABB7
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060931; cv=none; b=X7bY9hubqrTOJM17zk3dKm/NInLqlIxK/qeYNWAnDf8EcjgjFdDOj9c7FLDl5jzGxgmSoKACLlY8MQ694aeEWacmiIHi9AUyPk28MGy4dY9NHY+Yj63NWNnI6MGhy2U34F1MkqBBmMjTMWuaRu7Ylm2LD8Ysj/PBvZlTnVPrh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060931; c=relaxed/simple;
	bh=YH2klgv1+YNmSwKYe294v1zMFm+mJ3i/FYBHzY7qVpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmQvwAefXZ30PC8fP/vSbybqloeT695PuGTnwNQu2tQXBRDWVecvFitMqmq8q0VlQMfauUSS2kA5zXTibTFKxVRTKMqyhpU8yR0AUDaBZZ+ucRw3MgDAQvfTXogyDmKfh19TeE3EsUMkVdCwEhu8UboxiC6OcO1TW7rE3fqfMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPkWt9uM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744060928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvQBB32oIWPf4vbhux4hr6gO5yAT1ux/syBLJoggcGc=;
	b=NPkWt9uMVbiM8MqCAwVTPbBuWlPtPKQISp7jmYqX9JT9lsWFyquAENOrPonuM/lKIUcL0I
	KhKpiyOSoox5N9rGOF/JMXa9EwcFgNfdOaf0rNETNJMl1HhtvPhVSmyt15/eeSz8Chm7OP
	FSFgOMZJAnNKnVEPRh8lJTAJSJNOHmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-cE3b0L5DOp61xUvvCScDnA-1; Mon,
 07 Apr 2025 17:22:06 -0400
X-MC-Unique: cE3b0L5DOp61xUvvCScDnA-1
X-Mimecast-MFC-AGG-ID: cE3b0L5DOp61xUvvCScDnA_1744060925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03B78180899B;
	Mon,  7 Apr 2025 21:22:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B23C8180B487;
	Mon,  7 Apr 2025 21:22:03 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] cgroup/cpuset: Always use cpu_active_mask
Date: Mon,  7 Apr 2025 17:21:03 -0400
Message-ID: <20250407212127.1534285-2-longman@redhat.com>
In-Reply-To: <20250407212127.1534285-1-longman@redhat.com>
References: <20250407212127.1534285-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The current cpuset code uses both cpu_active_mask and cpu_online_mask
and it can be confusing which one should be used if we need to update
the code.

The top_cpuset is always synchronized to cpu_active_mask and we should
avoid using cpu_online_mask as much as possible. An active CPU is always
an online CPU, but not vice versa. cpu_active_mask and cpu_online_mask
can differ during hotplug operations.

A CPU is marked active at the last stage of CPU bringup (CPUHP_AP_ACTIVE).
It is also the stage where cpuset hotplug code will be called to update
the sched domains so that the scheduler can move a normal task to a
newly active CPU or remove tasks away from a newly inactivated CPU. The
online bit is set much earlier in the CPU bringup process and cleared
much later in CPU teardown.

If cpu_online_mask is used while a hotunplug operation is happening in
parallel, we may leave an offline CPU in cpu_allowed or have a higher
chance of leaving an offline CPU in some other masks.  Avoid this
problem by always using cpu_active_mask in the cpuset code and leave
a comment as to why the use of cpu_online_mask is discouraged.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 306b60430091..583f20942802 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -192,6 +192,20 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
 		WRITE_ONCE(cs->prs_err, PERR_NONE);
 }
 
+/*
+ * The top_cpuset is always synchronized to cpu_active_mask and we should avoid
+ * using cpu_online_mask as much as possible. An active CPU is always an online
+ * CPU, but not vice versa. cpu_active_mask and cpu_online_mask can differ
+ * during hotplug operations. A CPU is marked active at the last stage of CPU
+ * bringup (CPUHP_AP_ACTIVE). It is also the stage where cpuset hotplug code
+ * will be called to update the sched domains so that the scheduler can move
+ * a normal task to a newly active CPU or remove tasks away from a newly
+ * inactivated CPU. The online bit is set much earlier in the CPU bringup
+ * process and cleared much later in CPU teardown.
+ *
+ * If cpu_online_mask is used while a hotunplug operation is happening in
+ * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
+ */
 static struct cpuset top_cpuset = {
 	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
@@ -355,18 +369,18 @@ static inline bool partition_is_populated(struct cpuset *cs,
  * appropriate cpus.
  *
  * One way or another, we guarantee to return some non-empty subset
- * of cpu_online_mask.
+ * of cpu_active_mask.
  *
  * Call with callback_lock or cpuset_mutex held.
  */
-static void guarantee_online_cpus(struct task_struct *tsk,
+static void guarantee_active_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
 {
 	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
 	struct cpuset *cs;
 
-	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
-		cpumask_copy(pmask, cpu_online_mask);
+	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_active_mask)))
+		cpumask_copy(pmask, cpu_active_mask);
 
 	rcu_read_lock();
 	cs = task_cs(tsk);
@@ -2263,7 +2277,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
-	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
+	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
 	if (cs == &top_cpuset)
 		return -EACCES;
 
@@ -3082,7 +3096,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	lockdep_assert_held(&cpuset_mutex);
 
 	if (cs != &top_cpuset)
-		guarantee_online_cpus(task, cpus_attach);
+		guarantee_active_cpus(task, cpus_attach);
 	else
 		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
 			       subpartitions_cpus);
@@ -4026,7 +4040,7 @@ void __init cpuset_init_smp(void)
  *
  * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
  * attached to the specified @tsk.  Guaranteed to return some non-empty
- * subset of cpu_online_mask, even if this means going outside the
+ * subset of cpu_active_mask, even if this means going outside the
  * tasks cpuset, except when the task is in the top cpuset.
  **/
 
@@ -4040,7 +4054,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
-		guarantee_online_cpus(tsk, pmask);
+		guarantee_active_cpus(tsk, pmask);
 	/*
 	 * Tasks in the top cpuset won't get update to their cpumasks
 	 * when a hotplug online/offline event happens. So we include all
@@ -4054,7 +4068,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 		 * allowable online cpu left, we fall back to all possible cpus.
 		 */
 		cpumask_andnot(pmask, possible_mask, subpartitions_cpus);
-		if (!cpumask_intersects(pmask, cpu_online_mask))
+		if (!cpumask_intersects(pmask, cpu_active_mask))
 			cpumask_copy(pmask, possible_mask);
 	}
 
-- 
2.48.1


