Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF06E707
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfGSOAd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 10:00:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51272 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfGSOAd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 10:00:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so28930393wma.1
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 07:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E9uANj2IysRXLtOvqOYKhP4ix/6by5NihptgXTQIZdk=;
        b=kzq02E+oBokyHtQuzB3V7kvfFgNzZVn86cW0xTV8RwM4sGxB3Bxwt2B4Q2z+hmbFAs
         vnFNPZK4kO+o48gB9eOjfQHq3hdlg8Kni+9FWFC7/+KGy1A0W93a80g8dB4GvjWUStRR
         cbk0LQD+Ew4nLQdUUsEA5BJHsaNduFgAKOdPRJBg4sPB25XSa82+4GcqGdrVtpArEDdZ
         NB86WT57OMjmmEoi1jwlLhkVq6cWlIp+dkse/g96q3+DUP2+sCfd+V1xlQG2cRShVwb6
         eGzTifGkl+xwtg+MrqzflXpb+tvjHcXkSNUaDP6Mf+Ru0cp5nI+r9SkZ33yRs4tHQ9Fu
         krLQ==
X-Gm-Message-State: APjAAAXBldsewowRnWstCe9lRPgV3IkVUTngxWUatNMvRtWUMyKJzKcE
        uMiiAp3yQBVhWVqCbaZNL630jQ==
X-Google-Smtp-Source: APXvYqy2HGHbbFJyHJ6cVdDfqOJJldi+1J7A710vGZV5KsFEDeC+gliEqGpoaTmlqKVBy0aHU+1SyQ==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr49947508wme.43.1563544830303;
        Fri, 19 Jul 2019 07:00:30 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:29 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting information
Date:   Fri, 19 Jul 2019 15:59:55 +0200
Message-Id: <20190719140000.31694-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the topology of root domains is modified by CPUset or CPUhotplug
operations information about the current deadline bandwidth held in the
root domain is lost.

This patch addresses the issue by recalculating the lost deadline
bandwidth information by circling through the deadline tasks held in
CPUsets and adding their current load to the root domain they are
associated with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cgroup.h         |  1 +
 include/linux/sched.h          |  5 +++
 include/linux/sched/deadline.h |  8 +++++
 kernel/cgroup/cgroup.c         |  2 +-
 kernel/cgroup/cpuset.c         | 64 +++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c        | 30 ++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 13 ++++++-
 8 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3745ecdad925..107b8d5943bc 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -150,6 +150,7 @@ struct task_struct *cgroup_taskset_first(struct cgroup_taskset *tset,
 struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 					struct cgroup_subsys_state **dst_cssp);
 
+void cgroup_enable_task_cg_lists(void);
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..f74738953e70 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -281,6 +281,11 @@ struct vtime {
 	u64			gtime;
 };
 
+#ifdef CONFIG_SMP
+extern struct root_domain def_root_domain;
+extern struct mutex sched_domains_mutex;
+#endif
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 0cb034331cbb..1aff00b65f3c 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -24,3 +24,11 @@ static inline bool dl_time_before(u64 a, u64 b)
 {
 	return (s64)(a - b) < 0;
 }
+
+#ifdef CONFIG_SMP
+
+struct root_domain;
+extern void dl_add_task_root_domain(struct task_struct *p);
+extern void dl_clear_root_domain(struct root_domain *rd);
+
+#endif /* CONFIG_SMP */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f582414e15ba..d356905044a2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1879,7 +1879,7 @@ static int cgroup_reconfigure(struct fs_context *fc)
  */
 static bool use_task_css_set_links __read_mostly;
 
-static void cgroup_enable_task_cg_lists(void)
+void cgroup_enable_task_cg_lists(void)
 {
 	struct task_struct *p, *g;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 95da64cc8732..48d29a6112cb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -45,6 +45,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/deadline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/seq_file.h>
@@ -947,6 +948,67 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
+static void update_tasks_root_domain(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while ((task = css_task_iter_next(&it)))
+		dl_add_task_root_domain(task);
+
+	css_task_iter_end(&it);
+}
+
+static void rebuild_root_domains(void)
+{
+	struct cpuset *cs = NULL;
+	struct cgroup_subsys_state *pos_css;
+
+	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&sched_domains_mutex);
+
+	cgroup_enable_task_cg_lists();
+
+	rcu_read_lock();
+
+	/*
+	 * Clear default root domain DL accounting, it will be computed again
+	 * if a task belongs to it.
+	 */
+	dl_clear_root_domain(&def_root_domain);
+
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+
+		if (cpumask_empty(cs->effective_cpus)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		css_get(&cs->css);
+
+		rcu_read_unlock();
+
+		update_tasks_root_domain(cs);
+
+		rcu_read_lock();
+		css_put(&cs->css);
+	}
+	rcu_read_unlock();
+}
+
+static void
+partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	rebuild_root_domains();
+	mutex_unlock(&sched_domains_mutex);
+}
+
 /*
  * Rebuild scheduler domains.
  *
@@ -984,7 +1046,7 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43901fa3f269..4cedcf8d6b03 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2283,6 +2283,36 @@ void __init init_sched_dl_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 }
 
+void dl_add_task_root_domain(struct task_struct *p)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	struct dl_bw *dl_b;
+
+	rq = task_rq_lock(p, &rf);
+	if (!dl_task(p))
+		goto unlock;
+
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+
+	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+
+	raw_spin_unlock(&dl_b->lock);
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+}
+
+void dl_clear_root_domain(struct root_domain *rd)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	rd->dl_bw.total_bw = 0;
+	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..8607ceb11e8a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -783,9 +783,6 @@ struct root_domain {
 	struct perf_domain __rcu *pd;
 };
 
-extern struct root_domain def_root_domain;
-extern struct mutex sched_domains_mutex;
-
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 362c383ec4bd..9fc6ad3c341f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2193,8 +2193,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j))
+			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
+				struct root_domain *rd;
+
+				/*
+				 * This domain won't be destroyed and as such
+				 * its dl_bw->total_bw needs to be cleared.  It
+				 * will be recomputed in function
+				 * update_tasks_root_domain().
+				 */
+				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
+				dl_clear_root_domain(rd);
 				goto match1;
+			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.17.2

