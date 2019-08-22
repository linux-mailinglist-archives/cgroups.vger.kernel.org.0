Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7999503
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbfHVN2d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 09:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:45820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730723AbfHVN2a (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Aug 2019 09:28:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE87715A2;
        Thu, 22 Aug 2019 06:28:29 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FF973F706;
        Thu, 22 Aug 2019 06:28:26 -0700 (PDT)
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
Subject: [PATCH v14 2/6] sched/core: uclamp: Propagate parent clamps
Date:   Thu, 22 Aug 2019 14:28:07 +0100
Message-Id: <20190822132811.31294-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190822132811.31294-1-patrick.bellasi@arm.com>
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are locally consistent and constrained based on parent's
assigned resources. This requires to properly propagate and aggregate
parent attributes down to its descendants.

Implement this mechanism by adding a new "effective" clamp value for each
task group. The effective clamp value is defined as the smaller value
between the clamp value of a group and the effective clamp value of its
parent. This is the actual clamp value enforced on tasks in a task group.

Since it's possible for a cpu.uclamp.min value to be bigger than the
cpu.uclamp.max value, ensure local consistency by restricting each
"protection" (i.e. min utilization) with the corresponding "limit"
(i.e. max utilization).

Do that at effective clamps propagation to ensure all user-space write
never fails while still always tracking the most restrictive values.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Michal Koutny <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7b610e1a4cda..8dab64247597 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1166,6 +1166,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6824,6 +6825,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
 	}
 #endif
 }
@@ -7070,6 +7072,45 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_parent = NULL;
+	struct uclamp_se *uc_se = NULL;
+	unsigned int eff[UCLAMP_CNT];
+	unsigned int clamp_id;
+	unsigned int clamps;
+
+	css_for_each_descendant_pre(css, top_css) {
+		uc_parent = css_tg(css)->parent
+			? css_tg(css)->parent->uclamp : NULL;
+
+		for_each_clamp_id(clamp_id) {
+			/* Assume effective clamps matches requested clamps */
+			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
+			/* Cap effective clamps with parent's effective clamps */
+			if (uc_parent &&
+			    eff[clamp_id] > uc_parent[clamp_id].value) {
+				eff[clamp_id] = uc_parent[clamp_id].value;
+			}
+		}
+		/* Ensure protection is always capped by limit */
+		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
+
+		/* Propagate most restrictive effective clamps */
+		clamps = 0x0;
+		uc_se = css_tg(css)->uclamp;
+		for_each_clamp_id(clamp_id) {
+			if (eff[clamp_id] == uc_se[clamp_id].value)
+				continue;
+			uc_se[clamp_id].value = eff[clamp_id];
+			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
+			clamps |= (0x1 << clamp_id);
+		}
+		if (!clamps)
+			css = css_rightmost_descendant(css);
+	}
+}
 
 #define _POW10(exp) ((unsigned int)1e##exp)
 #define POW10(exp) _POW10(exp)
@@ -7133,6 +7174,9 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	 */
 	tg->uclamp_pct[clamp_id] = req.percent;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of));
+
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ae1be61fb279..5b343112a47b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -397,6 +397,8 @@ struct task_group {
 	unsigned int		uclamp_pct[UCLAMP_CNT];
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a task group */
+	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
 };
-- 
2.22.0

