Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD66D3AC
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2019 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbfGRSSZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jul 2019 14:18:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391129AbfGRSSZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Jul 2019 14:18:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915C728;
        Thu, 18 Jul 2019 11:18:24 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E04593F71A;
        Thu, 18 Jul 2019 11:18:21 -0700 (PDT)
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
Subject: [PATCH v12 4/6] sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
Date:   Thu, 18 Jul 2019 19:17:46 +0100
Message-Id: <20190718181748.28446-5-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718181748.28446-1-patrick.bellasi@arm.com>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a task specific clamp value is configured via sched_setattr(2), this
value is accounted in the corresponding clamp bucket every time the task is
{en,de}qeued. However, when cgroups are also in use, the task specific
clamp values could be restricted by the task_group (TG) clamp values.

Update uclamp_cpu_inc() to aggregate task and TG clamp values. Every time a
task is enqueued, it's accounted in the clamp bucket tracking the smaller
clamp between the task specific value and its TG effective value. This
allows to:

1. ensure cgroup clamps are always used to restrict task specific requests,
   i.e. boosted not more than its TG effective protection and capped at
   least as its TG effective limit.

2. implement a "nice-like" policy, where tasks are still allowed to request
   less than what enforced by their TG effective limits and protections

Do this by exploiting the concept of "effective" clamp, which is already
used by a TG to track parent enforced restrictions.

Apply task group clamp restrictions only to tasks belonging to a child
group. While, for tasks in the root group or in an autogroup, system
defaults are still enforced.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v12:
 Message-ID: <20190716143435.iwwd6fjr3udlqol4@e110439-lin>
 - remove not required and confusing sentence from the above changelog
---
 kernel/sched/core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9231b089d5c..426736b2c4d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -873,16 +873,42 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+static inline struct uclamp_se
+uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	struct uclamp_se uc_max;
+
+	/*
+	 * Tasks in autogroups or root task group will be
+	 * restricted by system defaults.
+	 */
+	if (task_group_is_autogroup(task_group(p)))
+		return uc_req;
+	if (task_group(p) == &root_task_group)
+		return uc_req;
+
+	uc_max = task_group(p)->uclamp[clamp_id];
+	if (uc_req.value > uc_max.value || !uc_req.user_defined)
+		return uc_max;
+#endif
+
+	return uc_req;
+}
+
 /*
  * The effective clamp bucket index of a task depends on, by increasing
  * priority:
  * - the task specific clamp value, when explicitly requested from userspace
+ * - the task group effective clamp value, for tasks not either in the root
+ *   group or in an autogroup
  * - the system default clamp value, defined by the sysadmin
  */
 static inline struct uclamp_se
 uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 {
-	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
 	struct uclamp_se uc_max = uclamp_default[clamp_id];
 
 	/* System default restrictions always apply */
-- 
2.22.0

