Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295CA7EFFA
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfHBJJR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 05:09:17 -0400
Received: from foss.arm.com ([217.140.110.172]:47094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390876AbfHBJJQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 05:09:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD64F1596;
        Fri,  2 Aug 2019 02:09:15 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2987A3F575;
        Fri,  2 Aug 2019 02:09:13 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH v13 3/6] sched/core: uclamp: Propagate system defaults to root group
Date:   Fri,  2 Aug 2019 10:08:50 +0100
Message-Id: <20190802090853.4810-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802090853.4810-1-patrick.bellasi@arm.com>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The clamp values are not tunable at the level of the root task group.
That's for two main reasons:

 - the root group represents "system resources" which are always
   entirely available from the cgroup standpoint.

 - when tuning/restricting "system resources" makes sense, tuning must
   be done using a system wide API which should also be available when
   control groups are not.

When a system wide restriction is available, cgroups should be aware of
its value in order to know exactly how much "system resources" are
available for the subgroups.

Utilization clamping supports already the concepts of:

 - system defaults: which define the maximum possible clamp values
   usable by tasks.

 - effective clamps: which allows a parent cgroup to constraint (maybe
   temporarily) its descendants without losing the information related
   to the values "requested" from them.

Exploit these two concepts and bind them together in such a way that,
whenever system default are tuned, the new values are propagated to
(possibly) restrict or relax the "effective" value of nested cgroups.

When cgroups are in use, force an update of all the RUNNABLE tasks.
Otherwise, keep things simple and do just a lazy update next time each
task will be enqueued.
Do that since we assume a more strict resource control is required when
cgroups are in use. This allows also to keep "effective" clamp values
updated in case we need to expose them to user-space.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v13:
 Message-ID: <20190725114126.GA4130@blackbody.suse.cz>
 - comment rewording: update all RUNNABLE tasks on system default
   changes only when cgroups are in use.
---
 kernel/sched/core.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de8886ce0f65..5683c8639b4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1017,10 +1017,30 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css);
+static void uclamp_update_root_tg(void)
+{
+	struct task_group *tg = &root_task_group;
+
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
+		      sysctl_sched_uclamp_util_min, false);
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
+		      sysctl_sched_uclamp_util_max, false);
+
+	rcu_read_lock();
+	cpu_util_update_eff(&root_task_group.css);
+	rcu_read_unlock();
+}
+#else
+static void uclamp_update_root_tg(void) { }
+#endif
+
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void __user *buffer, size_t *lenp,
 				loff_t *ppos)
 {
+	bool update_root_tg = false;
 	int old_min, old_max;
 	int result;
 
@@ -1043,16 +1063,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
+		update_root_tg = true;
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
 			      sysctl_sched_uclamp_util_max, false);
+		update_root_tg = true;
 	}
 
+	if (update_root_tg)
+		uclamp_update_root_tg();
+
 	/*
-	 * Updating all the RUNNABLE task is expensive, keep it simple and do
-	 * just a lazy update at each next enqueue time.
+	 * We update all RUNNABLE tasks only when task groups are in use.
+	 * Otherwise, keep it simple and do just a lazy update at each next
+	 * task enqueue time.
 	 */
+
 	goto done;
 
 undo:
-- 
2.22.0

