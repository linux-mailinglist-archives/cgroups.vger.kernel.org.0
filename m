Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927BC6E70F
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGSOAr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfGSOAk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so29181575wrm.8
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsvQwVtOgqTUPEZWlzxyNtyD9+2FMdmqdnW4Yq0lblc=;
        b=nK7fiYsPm3WWBMX7KIb90THrGWREVWQGyMSbqUOgabXWihe89q8cFCKn1/97oPQV7i
         BkLFOCyVt15BxSyeJXk0d+m4wpary21r1a8vhuA0rJMRCAZ1+0cNrtS3v+SScVUi1wXA
         kSJx2nUuRZzBJQwU3I5jsjfcz2bPywtY37VhOnkOQJxJJ4hy3DOIMV0hhyy+Tj+UVPU0
         noFzIYHzWTf5Tk5L/oLsqlJpEMV3+C7bk+IIu76Mv/tYp7zNluCDeAB95NXx+HtxbzJQ
         lOn8vOIWuVT86bydAYZb2ElMvX4SADERMhNFUvaAPGAkTnT2bRqsS9z81aQvO4Wn2V2a
         jZSw==
X-Gm-Message-State: APjAAAW+VqVy60E5iFl634N67hcDlTexNIK7uGHCTvyyNhiZllB2FVOS
        i/bDlB9mtZXDCkEJDnCCti4+3w==
X-Google-Smtp-Source: APXvYqzSBmD3MlViISjR5eO2sNm4aBb2z24XYj7Sx+4ZvTUQDCsTaNLIALe5WYSOTXmeVW+jwd9RIA==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr31931061wrj.256.1563544837883;
        Fri, 19 Jul 2019 07:00:37 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:37 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 8/8] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date:   Fri, 19 Jul 2019 16:00:00 +0200
Message-Id: <20190719140000.31694-9-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No synchronisation mechanism exists between the cpuset subsystem and
calls to function __sched_setscheduler(). As such, it is possible that
new root domains are created on the cpuset side while a deadline
acceptance test is carried out in __sched_setscheduler(), leading to a
potential oversell of CPU bandwidth.

Grab cpuset_rwsem read lock from core scheduler, so to prevent
situations such as the one described above from happening.

The only exception is normalize_rt_tasks() which needs to work under
tasklist_lock and can't therefore grab cpuset_rwsem. We are fine with
this, as this function is only called by sysrq and, if that gets
triggered, DEADLINE guarantees are already gone out of the window
anyway.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

v8 -> v9:
 - Add comment in changelog regarding normalize_rt_tasks() (Peter)
---
 include/linux/cpuset.h |  5 +++++
 kernel/cgroup/cpuset.c | 11 +++++++++++
 kernel/sched/core.c    | 33 ++++++++++++++++++++++++++-------
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 7f1478c26a33..04c20de66afc 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void cpuset_read_lock(void);
+extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -176,6 +178,9 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void cpuset_read_lock(void) { }
+static inline void cpuset_read_unlock(void) { }
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 93414ea63252..d16e160a3b35 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -334,6 +334,17 @@ static struct cpuset top_cpuset = {
  */
 
 DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+
+void cpuset_read_lock(void)
+{
+	percpu_down_read(&cpuset_rwsem);
+}
+
+void cpuset_read_unlock(void)
+{
+	percpu_up_read(&cpuset_rwsem);
+}
+
 static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index acd6a9fe85bc..18e151c6b48d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4208,6 +4208,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (pi)
+		cpuset_read_lock();
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -4280,6 +4283,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
+		if (pi)
+			cpuset_read_unlock();
 		goto recheck;
 	}
 
@@ -4338,8 +4343,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_disable();
 	task_rq_unlock(rq, p, &rf);
 
-	if (pi)
+	if (pi) {
+		cpuset_read_unlock();
 		rt_mutex_adjust_pi(p);
+	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
 	balance_callback(rq);
@@ -4349,6 +4356,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
+	if (pi)
+		cpuset_read_unlock();
 	return retval;
 }
 
@@ -4433,10 +4442,15 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setscheduler(p, policy, &lparam);
+	if (!p) {
+		rcu_read_unlock();
+		goto exit;
+	}
+	get_task_struct(p);
 	rcu_read_unlock();
-
+	retval = sched_setscheduler(p, policy, &lparam);
+	put_task_struct(p);
+exit:
 	return retval;
 }
 
@@ -4564,10 +4578,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setattr(p, &attr);
+	if (!p) {
+		rcu_read_unlock();
+		goto exit;
+	}
+	get_task_struct(p);
 	rcu_read_unlock();
-
+	retval = sched_setattr(p, &attr);
+	put_task_struct(p);
+exit:
 	return retval;
 }
 
-- 
2.17.2

