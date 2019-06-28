Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02C59598
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1IGq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 04:06:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfF1IGq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 04:06:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so3381506wrl.11
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 01:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XK0rmw3TRvyFu6q2ZzeV9ctx1JYPjrgUFwlyn6Ylmt0=;
        b=oQGDRAaFehGixzcfm7Kb1ir2NeFdgkzMf+PFlo69IKPYH9kvVrKQTdOYxQ8B9dSYe9
         buBwKJssBjrL6c24gwk92vwQu/p+HOvP+GYkpdL3z3O8Uq8W66ThXbXkQ0HDqGPjGNgA
         DBnJXxLutEQYwqCavGmP56UPqP/ETiDByAAGZ5RiYtyjKN6yWAyIqt3t5WGSo+bIlHU5
         +IRN2Dii7rBUQeJkusEAV2bTjkN9JSj/nJXadQqaiT/uqfPjb19Z5DGZmoBodbIMgg+n
         yhI8RBEW+PPOW52aKVXyBwvimuRouVdNsf6hBnqhKhwRiT21BQkt3OuiSOBALE5oqPHm
         lJYQ==
X-Gm-Message-State: APjAAAXhcIu8kadjsSSBn4FYiQ4JVu0EaUjxda5yfQBIFaKl+LPGDZrF
        TV3npesV2HjA4BdZLlujsjuCBw==
X-Google-Smtp-Source: APXvYqyUcVBU2757Aiq/oZgeZXK15E2by++ZZM7xg8VM22JD2aUmQlxlo9LzXJrJNt/nrKiti9ZdXw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr6676645wrs.209.1561709203910;
        Fri, 28 Jun 2019 01:06:43 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:43 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 7/8] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date:   Fri, 28 Jun 2019 10:06:17 +0200
Message-Id: <20190628080618.522-8-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
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

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

v7->v8: use a percpu_rwsem read lock to avoid hotpath bottleneck issues
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
index d92b351f89e3..f47b5c5c3c8b 100644
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

