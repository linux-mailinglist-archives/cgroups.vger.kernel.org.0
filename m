Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39FD6D3B4
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2019 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391210AbfGRSSc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jul 2019 14:18:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391189AbfGRSSb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Jul 2019 14:18:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60A6128;
        Thu, 18 Jul 2019 11:18:30 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE2663F71A;
        Thu, 18 Jul 2019 11:18:27 -0700 (PDT)
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
Subject: [PATCH v12 6/6] sched/core: uclamp: always use enum uclamp_id for clamp_id values
Date:   Thu, 18 Jul 2019 19:17:48 +0100
Message-Id: <20190718181748.28446-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718181748.28446-1-patrick.bellasi@arm.com>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The supported clamp indexes are defined in enum clamp_id however, because
of the code logic in some of the first utilization clamping series version,
sometimes we needed to use unsigned int to represent indexes.

This is not more required since the final version of the uclamp_* APIs can
always use the proper enum uclamp_id type.

Fix it with a bulk rename now that we have all the bits merged.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v12:
 Message-ID: <20190716140319.hdmgcuevnpwdqobl@e110439-lin>
 - added in this series
---
 kernel/sched/core.c  | 38 +++++++++++++++++++-------------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26ac1cbec0be..1e6cf9499d49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
 	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
 }
 
-static inline unsigned int uclamp_none(int clamp_id)
+static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -826,7 +826,7 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se,
 }
 
 static inline unsigned int
-uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
+uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
 		  unsigned int clamp_value)
 {
 	/*
@@ -842,7 +842,7 @@ uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_none(UCLAMP_MIN);
 }
 
-static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 				     unsigned int clamp_value)
 {
 	/* Reset max-clamp retention only on idle exit */
@@ -853,8 +853,8 @@ static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
 }
 
 static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
-				 unsigned int clamp_value)
+enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	int bucket_id = UCLAMP_BUCKETS - 1;
@@ -874,7 +874,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 }
 
 static inline struct uclamp_se
-uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
+uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
@@ -906,7 +906,7 @@ uclamp_tg_restrict(struct task_struct *p, unsigned int clamp_id)
  * - the system default clamp value, defined by the sysadmin
  */
 static inline struct uclamp_se
-uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
+uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
 	struct uclamp_se uc_max = uclamp_default[clamp_id];
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 	return uc_req;
 }
 
-unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
+enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
@@ -942,7 +942,7 @@ unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
  * for each bucket when all its RUNNABLE tasks require the same clamp.
  */
 static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
-				    unsigned int clamp_id)
+				    enum uclamp_id clamp_id)
 {
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
@@ -980,7 +980,7 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
  * enforce the expected state and warn.
  */
 static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
-				    unsigned int clamp_id)
+				    enum uclamp_id clamp_id)
 {
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
@@ -1019,7 +1019,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
@@ -1034,7 +1034,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
@@ -1044,7 +1044,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 }
 
 static inline void
-uclamp_update_active(struct task_struct *p, unsigned int clamp_id)
+uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -1080,9 +1080,9 @@ static inline void
 uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 			   unsigned int clamps)
 {
+	enum uclamp_id clamp_id;
 	struct css_task_iter it;
 	struct task_struct *p;
-	unsigned int clamp_id;
 
 	css_task_iter_start(css, 0, &it);
 	while ((p = css_task_iter_next(&it))) {
@@ -1188,7 +1188,7 @@ static int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	/*
 	 * On scheduling class change, reset to default clamps for tasks
@@ -1225,7 +1225,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 
 static void uclamp_fork(struct task_struct *p)
 {
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
@@ -1247,7 +1247,7 @@ static void uclamp_fork(struct task_struct *p)
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 	int cpu;
 
 	mutex_init(&uclamp_mutex);
@@ -6851,7 +6851,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 					    struct task_group *parent)
 {
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	int clamp_id;
+	enum uclamp_id clamp_id;
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
@@ -7113,7 +7113,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	struct uclamp_se *uc_parent = NULL;
 	struct uclamp_se *uc_se = NULL;
 	unsigned int eff[UCLAMP_CNT];
-	unsigned int clamp_id;
+	enum uclamp_id clamp_id;
 	unsigned int clamps;
 
 	css_for_each_descendant_pre(css, top_css) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93a030321210..e230474c1548 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2276,7 +2276,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id);
+enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-- 
2.22.0

