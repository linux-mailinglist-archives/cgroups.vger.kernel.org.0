Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1A2F34CA
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 16:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404718AbhALPzx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 10:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404757AbhALPzw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 10:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610466865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVTn9uzhFOad5xyTB/kfLY4qPum0kGTy6dbZu/jw7w0=;
        b=bLbLI+IVdlk7mRAY7Jsd2PuyAjz+F1goXQ7CN7rwillHPWutdi3iAAU+Pv/y9wAJYFJOaU
        bA0MfPgpYX0MR7207oQSjVLcX3J6PWnr+nRLnW3CreX8uih6oWutydUN6bU78+UFx6R8D7
        xSW7S565Tlixj0xv1BM6jpHtPwUxpbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-D-f8BIJNMMWJUnHnqRIyiQ-1; Tue, 12 Jan 2021 10:54:23 -0500
X-MC-Unique: D-f8BIJNMMWJUnHnqRIyiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90FA21005D51;
        Tue, 12 Jan 2021 15:54:21 +0000 (UTC)
Received: from x1.com (ovpn-113-251.rdu2.redhat.com [10.10.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C4E5D9CD;
        Tue, 12 Jan 2021 15:54:08 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 2/6] sched/deadline: Inform dl_task_can_attach() if the cpuset is exclusive
Date:   Tue, 12 Jan 2021 16:53:41 +0100
Message-Id: <2c971b6bfb1b674968a0dc522c686f731f7b5c74.1610463999.git.bristot@redhat.com>
In-Reply-To: <cover.1610463999.git.bristot@redhat.com>
References: <cover.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In preparation for blocking SCHED_DEADLINE tasks on non-exclusive cpuset
if bandwidth control is enabled.

No functional changes.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 include/linux/sched.h   | 2 +-
 kernel/cgroup/cpuset.c  | 5 ++++-
 kernel/sched/core.c     | 4 ++--
 kernel/sched/deadline.c | 3 ++-
 kernel/sched/sched.h    | 2 +-
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 942b87f80cc7..9525fbe032c9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1654,7 +1654,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed, int exclusive);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 53c70c470a38..c6513dfabd3d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2132,6 +2132,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
 	struct task_struct *task;
+	int exclusive;
 	int ret;
 
 	/* used later by cpuset_attach() */
@@ -2146,8 +2147,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
 		goto out_unlock;
 
+	exclusive = is_cpu_exclusive(cs);
+
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->cpus_allowed);
+		ret = task_can_attach(task, cs->cpus_allowed, exclusive);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f4aede34449c..5961a97541c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7124,7 +7124,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_cpus_allowed)
+		    const struct cpumask *cs_cpus_allowed, int exclusive)
 {
 	int ret = 0;
 
@@ -7143,7 +7143,7 @@ int task_can_attach(struct task_struct *p,
 	}
 
 	if (dl_task(p))
-		ret = dl_task_can_attach(p, cs_cpus_allowed);
+		ret = dl_task_can_attach(p, cs_cpus_allowed, exclusive);
 
 out:
 	return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c97d2c707b98..943aa32cc1bc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2862,7 +2862,8 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 }
 
 #ifdef CONFIG_SMP
-int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed)
+int dl_task_can_attach(struct task_struct *p,
+		const struct cpumask *cs_cpus_allowed, int exclusive)
 {
 	unsigned long flags, cap;
 	unsigned int dest_cpu;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c5ce49..54881d99cebd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -337,7 +337,7 @@ extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
 extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
-extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed, int exclusive);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern bool dl_cpu_busy(unsigned int cpu);
 
-- 
2.29.2

