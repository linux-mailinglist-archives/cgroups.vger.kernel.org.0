Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303C0172DC7
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2020 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgB1BCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 20:02:04 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55496 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1BCE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 20:02:04 -0500
Received: by mail-pf1-f201.google.com with SMTP id 63so782012pfw.22
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2020 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WvkEd8G1uoC4CrLmTdWM5lVBdiBoTiZC+H1EO+F8jJA=;
        b=ZQBwITVscjb6xlgMwrzq27SqCSzIloefJ153ty5a8pKGJyH6k1lapILVpRMdU2W0+P
         Il1cD8VOJBPNWBTz7iVVGsimBrahvvXFkpZlWijythJxwZC2g20OTDAIz2duXdjMYRIu
         94FKqPxG9es/UFwqm58QroRzhvLUTiG6odi1emI7+ch9MPCxMyehTOUAViRxOhm68wuo
         m9O6TSPp+ewk6DIEkwY/l1kVtGIt5Xri6ZGHv8zr9PUAtpjqkI2Zl2nj0gcZ7YzvSfWu
         sIyABv6hjYYPAeGRLUBZrdYQEZa6glzfhqe44IP5PGd4DNGIDtU1ePZocu77mxn303Xd
         SJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WvkEd8G1uoC4CrLmTdWM5lVBdiBoTiZC+H1EO+F8jJA=;
        b=RpDJ1D3/7sUks05+dkXMVfpgQeJ8q/Jwiaa0Wr66tgQh1VdqNZM+wyw8yohmCm1o3m
         7+rjaBnQIQmr4bbrMF3pOf/W40HT2E0Q9wvMSzyflCsNHJ4hh+I+FhdPBOXF6INV8oEx
         MQ+zeWFA1okN7yYGHvRKgfGJtSFCVKz/n47Vaaxb8XLuJu/Tn32g5+EDvjH0tTz5QnhU
         fnTC0vjYIqXFt28DIx6ufYm9tmKQbauvS36JZyJtmUS9eoXkFzQ3PcqXJfpTQCZkYdac
         GUnOzUBEeRLGimYQK7GW62Ec9c6vfjEAfr8yecKJzOHQwdhEL6Re/7unw1jnabnz9tM8
         bGPg==
X-Gm-Message-State: APjAAAUBsWRjAYS6e5Bk90gWeVhJUBvnL5FZ+hpbTGndu12+DNzI9qJd
        B56sz+UKfGQWfSQzbiaEgcUcb9a6uPvT
X-Google-Smtp-Source: APXvYqzPSnGRGLIga7Fjqtb63nBWd6ORkLDSyJ1+BvBOoJTuIejeKklPGKlZY2K1a4YvynWxpdpYi78RMLaG
X-Received: by 2002:a63:7e09:: with SMTP id z9mr1979768pgc.383.1582851722395;
 Thu, 27 Feb 2020 17:02:02 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:01:34 -0800
Message-Id: <20200228010134.42866-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] sched/cpuset: distribute tasks within affinity masks
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Paul Turner <pjt@google.com>

Currently, when updating the affinity of tasks via either cpusets.cpus,
or, sched_setaffinity(); tasks not currently running within the newly
specified CPU will be arbitrarily assigned to the first CPU within the
mask.

This (particularly in the case that we are restricting masks) can
result in many tasks being assigned to the first CPUs of their new
masks.

This:
 1) Can induce scheduling delays while the load-balancer has a chance to
    spread them between their new CPUs.
 2) Can antogonize a poor load-balancer behavior where it has a
    difficult time recognizing that a cross-socket imbalance has been
    forced by an affinity mask.

With this change, tasks are distributed ~evenly across the new mask.  We
may intentionally move tasks already running on a CPU within the mask to
avoid edge cases in which a CPU is already overloaded (or would be
assigned to more times than is desired).

We specifically apply this behavior to the following cases:
- modifying cpuset.cpus
- when tasks join a cpuset
- when modifying a task's affinity via sched_setaffinity(2)

Signed-off-by: Paul Turner <pjt@google.com>
Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/sched.h  |  8 +++++
 kernel/cgroup/cpuset.c |  5 +--
 kernel/sched/core.c    | 81 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..a2aab6a8a794 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1587,6 +1587,8 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern int set_cpus_allowed_ptr_distribute(struct task_struct *p,
+				const struct cpumask *new_mask);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
@@ -1597,6 +1599,12 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 		return -EINVAL;
 	return 0;
 }
+
+static inline int set_cpus_allowed_ptr_distribute(struct task_struct *p,
+					const struct cpumask *new_mask)
+{
+	return set_cpus_allowed_ptr(p, new_mask);
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073acff7..69960cae92e2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1035,7 +1035,7 @@ static void update_tasks_cpumask(struct cpuset *cs)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		set_cpus_allowed_ptr(task, cs->effective_cpus);
+		set_cpus_allowed_ptr_distribute(task, cs->effective_cpus);
 	css_task_iter_end(&it);
 }
 
@@ -2185,7 +2185,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
 		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+		WARN_ON_ONCE(
+			set_cpus_allowed_ptr_distribute(task, cpus_attach));
 
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..2336d6d66016 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1612,6 +1612,32 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_next_task(rq, p);
 }
 
+static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
+
+/*
+ * Returns an arbitrary cpu within *srcp1 & srcp2
+ *
+ * Iterated calls using the same srcp1 and srcp2, passing the previous cpu each
+ * time, will be distributed within their intersection.
+ */
+static int distribute_to_new_cpumask(const struct cpumask *src1p,
+				     const struct cpumask *src2p)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next_and(prev, src1p, src2p);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first_and(src1p, src2p);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1621,11 +1647,11 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  * task must not exit() & deallocate itself prematurely. The
  * call is not atomic; no spinlocks may be held.
  */
-static int __set_cpus_allowed_ptr(struct task_struct *p,
+static int __set_cpus_allowed_ptr(struct task_struct *p, bool distribute_cpus,
 				  const struct cpumask *new_mask, bool check)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
-	unsigned int dest_cpu;
+	unsigned int dest_cpu, prev_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
 	int ret = 0;
@@ -1652,8 +1678,33 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_equal(p->cpus_ptr, new_mask))
 		goto out;
 
-	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
-	if (dest_cpu >= nr_cpu_ids) {
+	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	prev_cpu = task_cpu(p);
+	if (distribute_cpus) {
+		dest_cpu = distribute_to_new_cpumask(new_mask,
+						     cpu_valid_mask);
+	} else {
+		/*
+		 * Can the task run on the task's current CPU? If so, we're
+		 * done.
+		 *
+		 * We only enable this short-circuit in the case that we're
+		 * not trying to distribute tasks.  As we may otherwise not
+		 * distribute away from a loaded CPU, or make duplicate
+		 * assignments to it.
+		 */
+		if (cpumask_test_cpu(prev_cpu, new_mask))
+			dest_cpu = prev_cpu;
+		else
+			dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
+	}
+
+	/* May have raced with cpu_down */
+	if (unlikely(dest_cpu >= nr_cpu_ids)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1670,8 +1721,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask))
+	if (dest_cpu == prev_cpu)
 		goto out;
 
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
@@ -1695,10 +1745,21 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, false, new_mask, false);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+/*
+ * Each repeated call will attempt to distribute tasks to a new cpu.  As a
+ * result, singular calls will also use a more "random" cpu than the first
+ * allowed in the mask.
+ */
+int set_cpus_allowed_ptr_distribute(struct task_struct *p,
+				    const struct cpumask *new_mask)
+{
+	return __set_cpus_allowed_ptr(p, true, new_mask, false);
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -2160,7 +2221,9 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 #else
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask, bool check)
+					 bool distribute_cpus,
+					 const struct cpumask *new_mask,
+					 bool check)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
@@ -5456,7 +5519,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, true, new_mask, true);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
-- 
2.25.1.481.gfbce0eb801-goog

