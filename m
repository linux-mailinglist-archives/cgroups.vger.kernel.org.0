Return-Path: <cgroups+bounces-12039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9ABC632EF
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97D3A3521ED
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A3324B12;
	Mon, 17 Nov 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmI0+Rw2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C22D7DC7
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371696; cv=none; b=UMAs/malIO42mtikirGqd249kvAt3ouUDvrm4lplWLQtYPspAUDosLYcPOoeKKC/l9tTWsfLu6CqEMWXg9qXDxPBH6vLXDixtv5OMcaK8sj+ha/g8kNOmOqE/EIdjNZraA6/62KkfFwy0hBk10ymPdLBXTJ4wdFk3+FU4Fm8RvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371696; c=relaxed/simple;
	bh=4Te2EtSm1ueCKdeoglHqlSeKWpspfzVInGuwXeRdm7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJZ3UGnP4LnYS5Ixh4g9ipAOrQsbpkyf5o7dPjYz449D6BRSuzZ7OS6bZIkVprfcOBY/VDylAHD4pVNFZekDUAeGpmf8pjb8gSHrB9hB89xKWy8BENH265nsDX6pgR7yMibloslPBcVDctjjRrnE0MlLCt2PLN/kdXVmwhpviYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmI0+Rw2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763371694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZI9zpWbGqqo4WXZPPGTq/VaKcUpiraFMcHRZHNRlMc=;
	b=TmI0+Rw2uX5KUbpz9IaVcKPwmJD2syGmM4iMcDuZnSuABd9aUOIjEFKv53xG51RlLgWSYJ
	bOlOxd4qESN/iE86+qQM9BWOMepGQXbCyQM5kX0wQXL6kebFFF8RTj0wxlA735FDrBH62T
	bcDrtDhlURoYZC2Tzjkkx1WQIVhOV84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-HNlWH55ANS64yQYssugxOA-1; Mon,
 17 Nov 2025 04:28:09 -0500
X-MC-Unique: HNlWH55ANS64yQYssugxOA-1
X-Mimecast-MFC-AGG-ID: HNlWH55ANS64yQYssugxOA_1763371687
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7144A19560A7;
	Mon, 17 Nov 2025 09:28:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.46])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76348180049F;
	Mon, 17 Nov 2025 09:27:56 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: cgroups@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 1/2] cgroup/cpuset: Introduce cpuset_cpus_allowed_locked()
Date: Mon, 17 Nov 2025 17:27:30 +0800
Message-ID: <20251117092732.16419-2-piliu@redhat.com>
In-Reply-To: <20251117092732.16419-1-piliu@redhat.com>
References: <20251117092732.16419-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

cpuset_cpus_allowed() uses a reader lock that is sleepable under RT,
which means it cannot be called inside raw_spin_lock_t context.

Introduce a new cpuset_cpus_allowed_locked() helper that performs the
same function as cpuset_cpus_allowed() except that the caller must have
acquired the cpuset_mutex so that no further locking will be needed.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org
To: cgroups@vger.kernel.org
---
 include/linux/cpuset.h |  1 +
 kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b51..e057a3123791e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -75,6 +75,7 @@ extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
+extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a3..7a179a1a2e30a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4116,24 +4116,13 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
-/**
- * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
- * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
- * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
- *
- * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
- * attached to the specified @tsk.  Guaranteed to return some non-empty
- * subset of cpu_active_mask, even if this means going outside the
- * tasks cpuset, except when the task is in the top cpuset.
- **/
-
-void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
+/*
+ * Return cpus_allowed mask from a task's cpuset.
+ */
+static void __cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask *pmask)
 {
-	unsigned long flags;
 	struct cpuset *cs;
 
-	spin_lock_irqsave(&callback_lock, flags);
-
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
 		guarantee_active_cpus(tsk, pmask);
@@ -4153,7 +4142,39 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 		if (!cpumask_intersects(pmask, cpu_active_mask))
 			cpumask_copy(pmask, possible_mask);
 	}
+}
 
+/**
+ * cpuset_cpus_allowed_locked - return cpus_allowed mask from a task's cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
+ *
+ * Similir to cpuset_cpus_allowed() except that the caller must have acquired
+ * cpuset_mutex.
+ */
+void cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask *pmask)
+{
+	lockdep_assert_held(&cpuset_mutex);
+	__cpuset_cpus_allowed_locked(tsk, pmask);
+}
+
+/**
+ * cpuset_cpus_allowed - return cpus_allowed mask from a task's cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
+ *
+ * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
+ * attached to the specified @tsk.  Guaranteed to return some non-empty
+ * subset of cpu_active_mask, even if this means going outside the
+ * tasks cpuset, except when the task is in the top cpuset.
+ **/
+
+void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&callback_lock, flags);
+	__cpuset_cpus_allowed_locked(tsk, pmask);
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
-- 
2.49.0


