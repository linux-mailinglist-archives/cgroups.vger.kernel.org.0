Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55DD4D1352
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiCHJ2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiCHJ1w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 04:27:52 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC34131E;
        Tue,  8 Mar 2022 01:26:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0V6e-tl1_1646731604;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6e-tl1_1646731604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 17:26:46 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [RFC PATCH v2 3/4] sched: Introduce group balancer
Date:   Tue,  8 Mar 2022 17:26:28 +0800
Message-Id: <20220308092629.40431-4-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
References: <20220308092629.40431-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Michael Wang <yun.wang@linux.alibaba.com>

Modern platform are growing fast on CPU numbers, multiple
apps sharing one box are very common, they used to have
exclusive cpu setting but nowadays things are changing.

To achieve better utility of CPU resource, multiple apps
are starting to sharing the CPUs. The CPU resources usually
overcommitted since app's workload are undulated.

This introduced problems on performance when share mode vs
exclusive mode, for eg with cgroup A,B and C deployed in
exclusive mode, it will be:

  CPU_X (100%)     CPU_Y (100%)     CPU_Z (50%)
  T_1_CG_A         T_1_CG_B         T_1_CG_C
  T_2_CG_A         T_2_CG_B         T_2_CG_C
  T_3_CG_A         T_3_CG_B
  T_4_CG_A         T_4_CG_B

while the share mode will be:

  CPU_X (100%)     CPU_Y (75%)     CPU_Z (75%)
  T_1_CG_A         T_2_CG_A         T_1_CG_B
  T_2_CG_B         T_3_CG_B         T_2_CG_C
  T_4_CG_B         T_4_CG_A         T_3_CG_A
  T_1_CG_C

As we can see, the confliction between groups on CPU
resources are now happening all over the CPUs.

The testing on sysbench-memory show 30+% drop on share
mode, and redis-benchmark show 10+% drop too, compared
to the exclusive mode.

However, despite of the performance drop, in real world
we still prefer share mode. The undulated workload can
make the exclusive mode so unefficient on CPU utilization,
for eg the next period, when CG_A become 'idle', exclusive
mode will like:

  CPU_X (0%)     CPU_Y (100%)     CPU_Z (50%)
                 T_1_CG_B         T_1_CG_C
                 T_2_CG_B         T_2_CG_C
                 T_3_CG_B
                 T_4_CG_B

while share mode like:

  CPU_X (50%)     CPU_Y (50%)     CPU_Z (50%)
  T_2_CG_B         T_1_CG_C        T_3_CG_B
  T_4_CG_B         T_1_CG_B        T_2_CG_C

The CPU_X is totally wasted in exclusive mode, the resource
efficiency are really poor.

Thus what we need, is a way to ease confliction in share mode,
make groups as exclusive as possible, to gain both performance
and resource efficiency.

The main idea of group balancer is to fulfill this requirement
by balancing groups of tasks among groups of CPUs, consider this
as a dynamic demi-exclusive mode. Task trigger work to settle it's
group into a proper partition (minimum predicted load), then try
migrate itself into it. To gradually settle groups into the most
exclusively partition.

Just like balance the task among CPUs, now with GB a user can
put CPU X,Y,Z into three partitions, and balance group A,B,C
into these partition, to make them as exclusive as possible.
GB can be seen as an optimize policy based on load balance,
it obeys the main idea of load balance and makes adjustment
based on that.

How to use:

First, make sure the children of your cgroup both enabling "cpu" and
"cpuset" subsys, because group balancer gather load info from task group
and partition info from cpuset group. So tasks should stay at the same
cgroup. Do this recursively if necessary:
  echo "+cpu +cpuset" > $CGROUP_PATH/cgroup.subtree_control

To create partition, for example run:
  echo "0-15;16-31;32-47;48-63;" > $CGROUP_PATH/cpuset.gb.partition

This will create 4 partitions contain CPUs 0-15,16-31,32-47 and
48-63 separately.

Then enable GB for your cgroup, run:
  echo 200000 > $CGROUP_PATH/cpuset.gb.period_us

This will enable GB for all descendants of $CGROUP_PATH, EXCEPT itself.

Testing Results:
  In order to enlarge the differences, we do testing on ARM platform
  with 128 CPUs, create 8 partition according to cluster info.

  Since we pick benchmark which can gain benefit from exclusive mode,
  this is more like a functional testing rather than performance, to
  show that GB help winback the performance.

  Create 8 cgroup each running 'sysbench memory --threads=16 run',
  the output of share mode is:
    events/s (eps):                      4939865.8892
    events/s (eps):                      4699033.0351
    events/s (eps):                      4373262.0563
    events/s (eps):                      3534852.1000
    events/s (eps):                      4724359.4354
    events/s (eps):                      3438985.1082
    events/s (eps):                      3600268.9196
    events/s (eps):                      3782130.8202
  the output of gb mode is:
    events/s (eps):                      4919287.0608
    events/s (eps):                      5926525.9995
    events/s (eps):                      4933459.3272
    events/s (eps):                      5184040.1349
    events/s (eps):                      5030940.1116
    events/s (eps):                      5773255.0246
    events/s (eps):                      4649109.0129
    events/s (eps):                      5683217.7641

  Create 4 cgroup each running redis-server with 16 io threads,
  4 redis-benchmark per each server show average rps as:

                    share mode       gb mode
  PING_INLINE        45903.94        46529.9      1.36%
  PING_MBULK         48342.58        50881.99     5.25%
  SET                38681.95        42108.17     8.86%
  GET                46774.09        51067.99     9.18%
  INCR               46092.24        50543.98     9.66%
  LPUSH              41723.35        45464.73     8.97%
  RPUSH              42722.77        47667.76     11.57%
  LPOP               41010.75        45077.65     9.92%
  RPOP               43198.33        47248.05     9.37%
  SADD               44750.16        50253.79     12.30%
  HSET               44352           47940.12     8.09%
  SPOP               47436.64        51658.99     8.90%
  ZADD               43124.02        45992.96     6.65%
  ZPOPMIN            46854.7         51561.52     10.05%
  LPUSH              41723.35        45464.73     8.97%
  LRANGE_100         22411.47        23311.32     4.02%
  LRANGE_300         11323.8         11585.06     2.31%
  LRANGE_500         7516.12         7577.76      0.82%
  LRANGE_600         6632.1          6737.31      1.59%
  MSET               27945.01        29401.3      5.21%

Co-developed-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
Signed-off-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 include/linux/cpuset.h   |   5 +
 include/linux/sched.h    |   5 +
 include/linux/sched/gb.h |  10 +
 kernel/cgroup/cpuset.c   |  39 ++++
 kernel/sched/core.c      |   5 +
 kernel/sched/fair.c      |  26 ++-
 kernel/sched/gb.c        | 448 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h     |  10 +
 8 files changed, 547 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..3be2ab42bb98 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -178,6 +178,11 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+#ifdef CONFIG_GROUP_BALANCER
+struct gb_info *task_gi(struct task_struct *p, bool get_controller);
+cpumask_var_t *gi_cpus(struct gb_info *gi);
+#endif
+
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5e0b5b4a4c8f..fca655770925 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1289,6 +1289,11 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_GROUP_BALANCER
+	u64			gb_stamp;
+	struct callback_head		gb_work;
+#endif
+
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_sig;
diff --git a/include/linux/sched/gb.h b/include/linux/sched/gb.h
index b03a2b4ef4b7..7af91662b740 100644
--- a/include/linux/sched/gb.h
+++ b/include/linux/sched/gb.h
@@ -9,10 +9,14 @@
 
 #include <linux/sched.h>
 #include <linux/cpumask.h>
+#include <linux/seq_file.h>
+#include <linux/cgroup-defs.h>
 
 #define CPU_PART_MAX		32
 struct gb_part {
 	int id;
+	unsigned int mgrt_on;
+	u64 predict_load;
 	struct cpumask cpus;
 };
 
@@ -41,6 +45,12 @@ struct gb_info {
 
 	/* Stamp to record next settling. */
 	unsigned long settle_next;
+
+	/*
+	 * Record preferred partition (in part_info of controller) of this cgroup.
+	 * Default -1.
+	 */
+	int gb_prefer;
 };
 
 #define for_each_gbpart(i, pi)			\
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4b456b379b87..de13c22c1921 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -235,6 +235,20 @@ static struct gb_info *css_gi(struct cgroup_subsys_state *css, bool get_controll
 
 	return get_controller ? cs->control_gi : &cs->gi;
 }
+
+struct gb_info *task_gi(struct task_struct *p, bool get_controller)
+{
+	struct cpuset *cs = task_cs(p);
+
+	return cs ? css_gi(&cs->css, get_controller) : NULL;
+}
+
+cpumask_var_t *gi_cpus(struct gb_info *gi)
+{
+	struct cpuset *cs = container_of(gi, struct cpuset, gi);
+
+	return &cs->effective_cpus;
+}
 #else
 static inline struct gb_info *cs_gi(struct cpuset *cs)
 {
@@ -2572,6 +2586,21 @@ static inline void update_child_gb_controller(struct cpuset *cs, struct gb_info
 	rcu_read_unlock();
 }
 
+static inline void reset_child_gb_prefer(struct cpuset *cs)
+{
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		if (cp == cs)
+			continue;
+
+		cs_gi(cp)->gb_prefer = -1;
+	}
+	rcu_read_unlock();
+}
+
 static inline void update_gb_part_info(struct cpuset *cs, struct gb_part_info *new)
 {
 	struct gb_info *gi = cs_gi(cs);
@@ -2606,6 +2635,7 @@ static inline void init_gb(struct cpuset *cs)
 
 	gi->settle_period = msecs_to_jiffies(sysctl_gb_settle_period);
 	gi->settle_next = jiffies + gi->settle_period;
+	gi->gb_prefer = -1;
 
 	/* Search upwards to find any existing controller. */
 	for (css = cs->css.parent; css; css = css->parent) {
@@ -2637,6 +2667,7 @@ static int gb_period_write_u64(struct cgroup_subsys_state *css, struct cftype *c
 	struct cpuset *cs = css_cs(css);
 	struct gb_info *gi = cs_gi(cs);
 	int retval = -EINVAL;
+	bool reset;
 
 	if (val > MAX_GB_PERIOD)
 		return retval;
@@ -2650,9 +2681,17 @@ static int gb_period_write_u64(struct cgroup_subsys_state *css, struct cftype *c
 	if (!gi->part_info)
 		goto out_unlock;
 
+	/* gb_period = 0 means disabling group balancer. */
+	reset = gi->gb_period && !val;
+
 	gi->gb_period = val * NSEC_PER_USEC;
 	retval = 0;
 
+	if (reset) {
+		synchronize_rcu();
+		reset_child_gb_prefer(cs);
+	}
+
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
 	return retval;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e5365755bdd..d57d6210bcfc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4484,6 +4484,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_GROUP_BALANCER
+	p->gb_stamp = 0;
+	p->gb_work.next = &p->gb_work;
+	init_task_work(&p->gb_work, group_balancing_work);
 #endif
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 10c8dc9b7494..c1bd3f62e39c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1609,6 +1609,9 @@ static void update_numa_stats(struct task_numa_env *env,
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
 				continue;
 
+			if (group_hot(env->p, env->src_cpu, cpu) == 0)
+				continue;
+
 			if (ns->idle_cpu == -1)
 				ns->idle_cpu = cpu;
 
@@ -1944,6 +1947,9 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+		if (group_hot(env->p, env->src_cpu, cpu) == 0)
+			continue;
+
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -6050,8 +6056,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	if (target == nr_cpumask_bits) {
+		if (group_hot(p, prev_cpu, this_cpu) == 1)
+			return this_cpu;
 		return prev_cpu;
+	}
 
 	schedstat_inc(sd->ttwu_move_affine);
 	schedstat_inc(p->stats.nr_wakeups_affine);
@@ -7846,6 +7855,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+	tsk_cache_hot = group_hot(p, env->src_cpu, env->dst_cpu);
+	if (tsk_cache_hot != -1)
+		return tsk_cache_hot;
+
 	/*
 	 * Aggressive migration if:
 	 * 1) active balance
@@ -8266,6 +8279,15 @@ static unsigned long task_h_load(struct task_struct *p)
 	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
+
+#ifdef CONFIG_GROUP_BALANCER
+unsigned long cfs_h_load(struct cfs_rq *cfs_rq)
+{
+	update_cfs_rq_h_load(cfs_rq);
+	return cfs_rq->h_load;
+}
+#endif
+
 #else
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
@@ -11213,6 +11235,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	task_tick_gb(rq, curr);
+
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
 
diff --git a/kernel/sched/gb.c b/kernel/sched/gb.c
index 4a2876ec1cca..f7da96253ad0 100644
--- a/kernel/sched/gb.c
+++ b/kernel/sched/gb.c
@@ -8,7 +8,455 @@
 
 #include "sched.h"
 
+#define DECAY_PERIOD		HZ
+
 /* Params about settle period. (ms) */
 unsigned int sysctl_gb_settle_period = 200;
 unsigned int sysctl_gb_settle_period_max = 10000;
 unsigned int sysctl_gb_global_settle_period = 200;
+
+static unsigned long global_settle_next;
+static unsigned long predict_period_stamp;
+DEFINE_SPINLOCK(settle_lock);
+
+static inline int ctop(struct gb_part_info *pi, int cpu)
+{
+	return pi->ctop[cpu];
+}
+
+static u64 tg_load_of_part(struct gb_part_info *pi, struct task_group *tg, int id)
+{
+	int i;
+	u64 load = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		load += cfs_h_load(tg->cfs_rq[i]);
+
+	return load;
+}
+
+static u64 load_of_part(struct gb_part_info *pi, int id)
+{
+	int i;
+	u64 load = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		load += cpu_rq(i)->cfs.avg.load_avg;
+
+	return load;
+}
+
+static inline int part_mgrt_lock(struct gb_part_info *pi, int src, int dst)
+{
+	struct gb_part *src_part, *dst_part;
+
+	if (src != -1) {
+		src_part = &pi->parts[src];
+		if (READ_ONCE(src_part->mgrt_on))
+			return 0;
+	}
+
+	if (dst != -1) {
+		dst_part = &pi->parts[dst];
+		if (READ_ONCE(dst_part->mgrt_on))
+			return 0;
+	}
+
+	if (src != -1 && xchg(&src_part->mgrt_on, 1))
+		return 0;
+
+	if (dst != -1 && xchg(&dst_part->mgrt_on, 1)) {
+		WRITE_ONCE(src_part->mgrt_on, 0);
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline void part_mgrt_unlock(struct gb_part_info *pi, int src, int dst)
+{
+	struct gb_part *src_part, *dst_part;
+
+	if (src != -1) {
+		src_part = &pi->parts[src];
+		WRITE_ONCE(src_part->mgrt_on, 0);
+	}
+
+	if (dst != -1) {
+		dst_part = &pi->parts[dst];
+		WRITE_ONCE(dst_part->mgrt_on, 0);
+	}
+}
+
+static u64 cap_of_part(struct gb_part_info *pi, int id)
+{
+	int i;
+	u64 cap = 0;
+
+	for_each_cpu(i, part_cpus(pi, id))
+		cap += cpu_rq(i)->cpu_capacity;
+
+	return cap;
+}
+
+static inline void predict_load_add(struct gb_part_info *pi, int id, u64 load)
+{
+	pi->parts[id].predict_load += load;
+}
+
+static void predict_load_decay(struct gb_part_info *pi)
+{
+	int i, fact, passed;
+
+	passed = jiffies - global_settle_next + predict_period_stamp;
+	predict_period_stamp = passed % DECAY_PERIOD;
+	fact = passed / DECAY_PERIOD;
+
+	if (!fact)
+		return;
+
+	for_each_gbpart(i, pi) {
+		struct gb_part *gp = &pi->parts[i];
+
+		/*
+		 * Decay NICE_0_LOAD into zero after 10 seconds
+		 */
+		if (fact > 10)
+			gp->predict_load = 0;
+		else
+			gp->predict_load >>= fact;
+	}
+}
+
+static int try_to_settle(struct gb_part_info *pi, struct gb_info *gi, struct task_group *tg)
+{
+	int i, src, dst, ret;
+	u64 mgrt_load, tg_load, min_load, src_load, dst_load;
+	cpumask_var_t *effective_cpus = gi_cpus(gi);
+
+	src = dst = -1;
+	min_load = U64_MAX;
+	tg_load = 0;
+	for_each_gbpart(i, pi) {
+		u64 mgrt, load;
+
+		/* DO NOT settle in parts out of effective_cpus. */
+		if (!cpumask_intersects(part_cpus(pi, i), effective_cpus[0]))
+			continue;
+
+		mgrt = tg_load_of_part(pi, tg, i);
+		load = load_of_part(pi, i);
+		/* load after migration */
+		if (load > mgrt)
+			load -= mgrt;
+		else
+			load = 0;
+
+		/*
+		 * Try to find out the partition contain
+		 * minimum load, and the load of this task
+		 * group is excluded on comparison.
+		 *
+		 * This help to prevent that a partition
+		 * full of the tasks from this task group was
+		 * considered as busy.
+		 *
+		 * As for the prediction load, the partition
+		 * this group preferred will be excluded, since
+		 * these prediction load could be introduced by
+		 * itself.
+		 *
+		 * This is not precise, but it serves the idea
+		 * to prefer a partition as long as possible,
+		 * to save the cost of resettle as much as
+		 * possible.
+		 */
+		if (i == gi->gb_prefer) {
+			src = i;
+			src_load = load + mgrt;
+			mgrt_load = mgrt;
+		} else
+			load += pi->parts[i].predict_load;
+
+		if (load < min_load) {
+			dst = i;
+			min_load = load;
+			dst_load = load + mgrt;
+		}
+
+		tg_load += mgrt;
+	}
+
+	if (!tg_load)
+		return 0;
+
+	ret = 0;
+	gi->settle_period *= 2;
+	if (src == -1) {
+		/* First settle */
+		gi->gb_prefer = dst;
+		predict_load_add(pi, dst, tg_load);
+		ret = 1;
+	} else if (src != dst) {
+		/* Resettle will cost, be careful */
+		long dst_imb, src_imb, dst_cap, src_cap;
+
+		src_cap = cap_of_part(pi, src);
+		dst_cap = cap_of_part(pi, dst);
+
+		/*
+		 * src_load        dst_load
+		 * ------------ vs ---------
+		 * src_capacity    dst_capacity
+		 *
+		 * Should not cause further imbalancing after
+		 * resettle.
+		 */
+		src_imb = abs(src_load * dst_cap - dst_load * src_cap);
+		dst_imb = abs((src_load - mgrt_load) * dst_cap - (dst_load + mgrt_load) * src_cap);
+
+		if (dst_imb <= src_imb) {
+			gi->gb_prefer = dst;
+			predict_load_add(pi, dst, tg_load);
+			gi->settle_period = msecs_to_jiffies(sysctl_gb_settle_period) * 2;
+			ret = 1;
+		}
+	}
+
+	if (gi->settle_period > msecs_to_jiffies(sysctl_gb_settle_period_max))
+		gi->settle_period = msecs_to_jiffies(sysctl_gb_settle_period_max);
+
+	return ret;
+}
+
+/*
+ * group_hot() will tell us which cpu is contained in the
+ * preferred CPU partition of the task group of a task.
+ *
+ * return 1 if prefer dst_cpu
+ * return 0 if prefer src_cpu
+ * return -1 if prefer either or neither
+ */
+int group_hot(struct task_struct *p, int src_cpu, int dst_cpu)
+{
+	int ret = -1;
+	struct task_group *tg;
+	struct gb_info *gi, *control_gi;
+	struct gb_part_info *pi;
+
+	rcu_read_lock();
+
+	control_gi = task_gi(p, true);
+
+	if (!control_gi || !control_gi->gb_period)
+		goto out_unlock;
+
+	gi = task_gi(p, false);
+	pi = control_gi->part_info;
+	tg = task_group(p);
+	if (gi->gb_prefer != -1 && ctop(pi, src_cpu) != ctop(pi, dst_cpu))
+		ret = (gi->gb_prefer == ctop(pi, dst_cpu));
+
+out_unlock:
+	rcu_read_unlock();
+	return ret;
+}
+
+void task_tick_gb(struct rq *rq, struct task_struct *curr)
+{
+	struct callback_head *work = &curr->gb_work;
+	struct gb_info *gi, *control_gi;
+	struct gb_part_info *pi;
+	u64 period, now;
+
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+		return;
+
+	rcu_read_lock();
+
+	control_gi = task_gi(curr, true);
+
+	if (!control_gi || !control_gi->gb_period)
+		goto unlock;
+
+	gi = task_gi(curr, false);
+	pi = control_gi->part_info;
+
+	/* Save it when already satisfied. */
+	if (gi->gb_prefer != -1 &&
+	    gi->gb_prefer == ctop(pi, task_cpu(curr)))
+		goto unlock;
+
+	now = curr->se.sum_exec_runtime;
+	period = control_gi->gb_period;
+
+	if (now > curr->gb_stamp + period) {
+		curr->gb_stamp = now;
+		task_work_add(curr, work, TWA_RESUME);
+	}
+
+unlock:
+	rcu_read_unlock();
+}
+
+void group_balancing_work(struct callback_head *work)
+{
+	int cpu, this_cpu, this_part, this_prefer, best_cpu;
+	struct task_group *this_tg;
+	struct gb_info *this_gi, *control_gi;
+	struct gb_part_info *pi;
+	struct task_struct *best_task;
+	struct cpumask cpus;
+
+	SCHED_WARN_ON(current != container_of(work, struct task_struct, gb_work));
+
+	work->next = work;
+	if (current->flags & PF_EXITING)
+		return;
+
+	rcu_read_lock();
+	/*
+	 * We build group balancer on "cpuset" subsys, and gather load info from
+	 * "cpu" subsys. So we need to ensure these two subsys belonging to
+	 * the same cgroup.
+	 */
+	if (task_cgroup(current, cpuset_cgrp_id) != task_group(current)->css.cgroup)
+		goto unlock;
+
+	control_gi = task_gi(current, true);
+
+	if (!control_gi || !control_gi->gb_period)
+		goto unlock;
+
+	this_gi = task_gi(current, false);
+	pi = control_gi->part_info;
+	this_tg = task_group(current);
+
+	/*
+	 * Settle task group one-by-one help prevent the
+	 * situation when multiple group try to settle the
+	 * same partition at the same time.
+	 *
+	 * However, when bunch of groups trying to settle at
+	 * the same time, there are no guarantee on the
+	 * fairness, some of them may get more chances and
+	 * settle sooner than the others.
+	 *
+	 * So one trick here is to grow the cg_settle_period
+	 * of settled group, to make sure they yield the
+	 * next chances to others.
+	 *
+	 * Another trick here is about prediction, as settle
+	 * group will followed by bunch of task migration,
+	 * the current load of CPU partition can't imply it's
+	 * busyness in future, and we may pick a busy one in
+	 * the end.
+	 *
+	 * Thus we maintain the predict load after each settle,
+	 * so next try will be able to do the prediction and
+	 * avoid to pick those which is already busy enough.
+	 */
+	if (spin_trylock(&settle_lock)) {
+		if (time_after(jiffies, global_settle_next) &&
+		    time_after(jiffies, this_gi->settle_next)) {
+			predict_load_decay(pi);
+
+			global_settle_next = jiffies;
+			if (try_to_settle(pi, this_gi, this_tg))
+				global_settle_next +=
+					msecs_to_jiffies(sysctl_gb_global_settle_period);
+
+			this_gi->settle_next = jiffies + this_gi->settle_period;
+		}
+		spin_unlock(&settle_lock);
+	}
+
+	this_cpu = task_cpu(current);
+	this_prefer = this_gi->gb_prefer;
+	this_part = ctop(pi, this_cpu);
+	if (this_prefer == -1 ||
+	    this_part == this_prefer ||
+	    !part_mgrt_lock(pi, this_part, this_prefer)) {
+		goto unlock;
+	}
+
+	cpumask_copy(&cpus, part_cpus(pi, this_prefer));
+
+	/*
+	 * We arrived here when current task A don't prefer
+	 * it's current CPU, but prefer CPUs of partition Y.
+	 *
+	 * In other word, if task A could run on CPUs of
+	 * partition Y, it have good chance to reduce conflict
+	 * with the tasks from other groups, and share hot
+	 * cache with the tasks from the same group.
+	 *
+	 * So here is the main logical of group balancer to
+	 * achieve it's purpose, make sure groups of tasks
+	 * are balanced into groups of CPUs.
+	 *
+	 * If A's current CPU belong to CPU partition X,
+	 * try to find a CPU from partition Y, which is
+	 * running a task prefer partition X, and swap them.
+	 *
+	 * Otherwise, or if can't find such CPU and task,
+	 * just find an idle CPU from partition Y, and do
+	 * migration.
+	 *
+	 * Ideally the migration and swap work will finally
+	 * put the tasks into right places, but the wakeup
+	 * stuff can easily break that by locate an idle CPU
+	 * out of the range.
+	 *
+	 * However, since the whole idea is to gain cache
+	 * benefit and reduce conflict between groups, if
+	 * there are enough idle CPU out there then every
+	 * thing just fine, so let it go.
+	 */
+
+	best_cpu = -1;
+	best_task = NULL;
+	for_each_cpu_and(cpu, &cpus, current->cpus_ptr) {
+		struct task_struct *p;
+
+		WARN_ON(cpu == this_cpu);
+
+		if (available_idle_cpu(cpu)) {
+			best_cpu = cpu;
+			continue;
+		}
+
+		if (this_part == -1)
+			continue;
+
+		p = rcu_dereference(cpu_rq(cpu)->curr);
+
+		if (!p || (p->flags & PF_EXITING) || is_idle_task(p)
+		    || p == current || task_gi(p, true) != control_gi)
+			continue;
+
+		if (task_cpu(p) == cpu &&
+		    this_part == task_gi(p, false)->gb_prefer &&
+		    cpumask_test_cpu(this_cpu, p->cpus_ptr)) {
+			get_task_struct(p);
+			best_task = p;
+			best_cpu = cpu;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	if (best_task) {
+		migrate_swap(current, best_task, best_cpu, this_cpu);
+		put_task_struct(best_task);
+	} else if (best_cpu != -1) {
+		migrate_task_to(current, best_cpu);
+	}
+
+	part_mgrt_unlock(pi, this_part, this_prefer);
+	return;
+
+unlock:
+	rcu_read_unlock();
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d6555aacdf78..97c621bcded3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3148,3 +3148,13 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#ifdef CONFIG_GROUP_BALANCER
+extern unsigned long cfs_h_load(struct cfs_rq *cfs_rq);
+extern int group_hot(struct task_struct *p, int src_cpu, int dst_cpu);
+extern void task_tick_gb(struct rq *rq, struct task_struct *curr);
+extern void group_balancing_work(struct callback_head *work);
+#else
+static inline int group_hot(struct task_struct *p, int src_cpu, int dst_cpu) { return -1; }
+static inline void task_tick_gb(struct rq *rq, struct task_struct *curr) {};
+static inline void group_balancing_work(struct callback_head *work) {};
+#endif
-- 
2.27.0

