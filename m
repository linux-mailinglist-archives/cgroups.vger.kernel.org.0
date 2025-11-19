Return-Path: <cgroups+bounces-12087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F761C6DD6C
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 10:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2D18B2DD8B
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBA3451CC;
	Wed, 19 Nov 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6I1zBjX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C203321CD
	for <cgroups@vger.kernel.org>; Wed, 19 Nov 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546168; cv=none; b=C8kVyd0jnyP995ftticZ4/IZoq8o+XUCfjrtmmKztUAXKfJL3yCaiPfH569KhPnPxof2iR+2SwJ1XGBNhoa5x+oDQSUsExU3SjjOFVJcxvk+rLhp4OlHXGJ0m09kHLASst0AlVIcKyQUsq73p4uG8yLCZx82lkVB0p8Wb4v7bX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546168; c=relaxed/simple;
	bh=UgCUqkymhZ+rmMa555UKNFjPFwx6eolPXr/7CtqA/MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPRqj1jA4vQjoChoqa5KAqopCuUeTW8e3uNYhew/MJPwN49adOdRccSFtSGeM8Ll+YmK8BckTltIxPg9pPrkWudOFAOL2c0OcfVftQb64Faw/EIN0Hn6LgNtRaE99PwYLlixnF+SpINtUDoxgoAJMWTSAQVEp9cZBEwIm36z/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6I1zBjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763546165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9tuRk81dBfhNfeLrLSKOJE/gf6lbseEeNlG9tm14p4=;
	b=R6I1zBjXpqK6WtWoA5jyjBuSiTLQHHMdY1xKYBerG00TvTPn8OpP2pELZRhNbacZXPj9uT
	txFbpOUL+OtyiexPk7oLfewQHeS9mAL2WbWPfWR4/9k9TElNdGVg5nZ56N9TOqFRECrJeT
	DDGuxnilLNzuEXyClZhXOyMfJwo6xG0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-vBF4cGNCNTmTXumyMJR6Eg-1; Wed,
 19 Nov 2025 04:55:59 -0500
X-MC-Unique: vBF4cGNCNTmTXumyMJR6Eg-1
X-Mimecast-MFC-AGG-ID: vBF4cGNCNTmTXumyMJR6Eg_1763546158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECB7919560A3;
	Wed, 19 Nov 2025 09:55:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBFC8180049F;
	Wed, 19 Nov 2025 09:55:47 +0000 (UTC)
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
Subject: [PATCHv7 1/2] cgroup/cpuset: Introduce cpuset_cpus_allowed_locked()
Date: Wed, 19 Nov 2025 17:55:24 +0800
Message-ID: <20251119095525.12019-2-piliu@redhat.com>
In-Reply-To: <20251119095525.12019-1-piliu@redhat.com>
References: <20251119095525.12019-1-piliu@redhat.com>
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
 include/linux/cpuset.h |  9 +++++++-
 kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b51..a98d3330385c2 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
 extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
+extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern bool cpuset_cpu_is_isolated(int cpu);
@@ -195,10 +196,16 @@ static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
 
+static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
+					struct cpumask *mask)
+{
+	cpumask_copy(mask, task_cpu_possible_mask(p));
+}
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
-	cpumask_copy(mask, task_cpu_possible_mask(p));
+	cpuset_cpus_allowed_locked(p, mask);
 }
 
 static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
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


