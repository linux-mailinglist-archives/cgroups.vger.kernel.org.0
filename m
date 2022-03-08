Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFCD4D134D
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 10:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbiCHJ1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 04:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiCHJ1p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 04:27:45 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C941312;
        Tue,  8 Mar 2022 01:26:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0V6e-tkD_1646731601;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6e-tkD_1646731601)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 17:26:43 +0800
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
Subject: [RFC PATCH v2 2/4] cpuset: Handle input of partition info for group balancer
Date:   Tue,  8 Mar 2022 17:26:27 +0800
Message-Id: <20220308092629.40431-3-dtcccc@linux.alibaba.com>
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

Partition info is the key param of group balancer. It represents the
division of effective cpus. Cpus are divided into several parts, and
group balancer will select one part for each cgroup (called settle)
and try to gather all tasks of that cgroup running on the cpus of
selected part.

For example, the effective cpulist is "0-63". A valid input of partition
info can be "0-15;16-31;32-47;48-63;". This divide cpus into 4 parts,
each part with 16 cpus.
Intersections between parts or conflicts with effective cpus are not
allowd, e.g., "0-40;30-63" or "0-31;32-70;".

Once the partition info is set, the corresponding cgroup becomes a
controller. All descendants of it are managed by group balancer,
according to params set in this controller cgroup.
A cgroup can become a controller only when its ancestors and descendants
are not controller.

To unset a controller, write empty string to it.
(i.e., echo > cpuset.gb.partition)
This will clear its partition info and reset the relationship between
itself and its descendants.

Setting, modifying, or unsetting partition info must be done when group
balancer is disabled. (i.e., gb.period_us = 0.)

ROOT_CG
   |
   |
   |_________
   |         |
 CG_A       CG_B(controller, gb.partition = "...", gb.period_us > 0)
             |
             |
             |________________
             |                |
           CG_C(gb active)  CG_D(gb active)
               (prefer=0)       (prefer=3)

For example, if we input valid partition info "0-15;16-31;32-47;48-63;"
and positive period to CG_B, group balancer for all descendants of CG_B
is enabled. All tasks in CG_C will tend to run on cpus of part0 (0-15),
and all tasks in CG_D will tend to run on part3 (48-63).

After setting partition info, CG_B becomes a controller. So setting
another partition info in ROOT_CG, CG_C or CG_D is not allowed until
CG_B is disabled and unset. While CG_A can still be set.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 include/linux/sched/gb.h |  29 +++++
 kernel/cgroup/cpuset.c   | 245 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 267 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/gb.h b/include/linux/sched/gb.h
index 63c14289a748..b03a2b4ef4b7 100644
--- a/include/linux/sched/gb.h
+++ b/include/linux/sched/gb.h
@@ -8,9 +8,30 @@
 #define _LINUX_SCHED_GB_H
 
 #include <linux/sched.h>
+#include <linux/cpumask.h>
+
+#define CPU_PART_MAX		32
+struct gb_part {
+	int id;
+	struct cpumask cpus;
+};
+
+struct gb_part_info {
+	int nr_part;
+	struct rcu_head rcu_head;
+	struct gb_part parts[CPU_PART_MAX];
+	int ctop[NR_CPUS];
+};
 
 struct gb_info {
 	/* ---for ancestor as controller--- */
+	/*
+	 * Partition info. Non-NULL means this cgroup acting as a controller.
+	 * While otherwise, NULL means not a controller.
+	 * (Maybe a descendant of a controller, or not managed by gb at all.)
+	 */
+	struct gb_part_info *part_info;
+
 	/* Period(ns) for task work in task tick, 0 means disabled. */
 	u64 gb_period;
 
@@ -22,6 +43,14 @@ struct gb_info {
 	unsigned long settle_next;
 };
 
+#define for_each_gbpart(i, pi)			\
+	for (i = 0; i < (pi)->nr_part; i++)
+
+static inline struct cpumask *part_cpus(struct gb_part_info *pi, int id)
+{
+	return &pi->parts[id].cpus;
+}
+
 #ifdef CONFIG_GROUP_BALANCER
 extern unsigned int sysctl_gb_settle_period;
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0349f3f64e3d..4b456b379b87 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -683,13 +683,24 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	if (cur == &top_cpuset)
 		goto out;
 
+	ret = -EINVAL;
+
+#ifdef CONFIG_GROUP_BALANCER
+	/*
+	 * If group balancer part_info is set, this cgroup acts as a controller.
+	 * Not allow to change cpumask until unset it
+	 * by writing empty string to cpuset.gb.partition.
+	 */
+	if (cs_gi(cur)->part_info)
+		goto out;
+#endif
+
 	par = parent_cs(cur);
 
 	/*
 	 * If either I or some sibling (!= me) is exclusive, we can't
 	 * overlap
 	 */
-	ret = -EINVAL;
 	cpuset_for_each_child(c, css, par) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
 		    c != cur &&
@@ -2539,12 +2550,77 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 }
 
 #ifdef CONFIG_GROUP_BALANCER
-static inline void init_gb(struct cpuset *cs)
+static void free_gb_part_info(struct rcu_head *rcu_head)
+{
+	struct gb_part_info *pi = container_of(rcu_head, struct gb_part_info, rcu_head);
+
+	kfree(pi);
+}
+
+static inline void update_child_gb_controller(struct cpuset *cs, struct gb_info *gi)
+{
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		if (cp == cs)
+			continue;
+
+		cp->control_gi = gi;
+	}
+	rcu_read_unlock();
+}
+
+static inline void update_gb_part_info(struct cpuset *cs, struct gb_part_info *new)
 {
 	struct gb_info *gi = cs_gi(cs);
+	struct gb_part_info *old;
+
+	if (gi->part_info && !new) {
+		/*
+		 * We are clearing partition info.
+		 * This cgroup is no longer a controller.
+		 * Reset all descendants.
+		 */
+		update_child_gb_controller(cs, NULL);
+	}
+
+	old = xchg(&gi->part_info, new);
+
+	if (old) {
+		call_rcu(&old->rcu_head, free_gb_part_info);
+	} else if (new) {
+		/*
+		 * This cgroup is newly becoming a controller.
+		 * Set relationship between cs and descendants.
+		 */
+		update_child_gb_controller(cs, gi);
+	}
+}
+
+static inline void init_gb(struct cpuset *cs)
+{
+	struct gb_info *gi = cs_gi(cs), *gi_iter;
+	struct cgroup_subsys_state *css;
 
 	gi->settle_period = msecs_to_jiffies(sysctl_gb_settle_period);
 	gi->settle_next = jiffies + gi->settle_period;
+
+	/* Search upwards to find any existing controller. */
+	for (css = cs->css.parent; css; css = css->parent) {
+		gi_iter = css_gi(css, false);
+		if (gi_iter->part_info) {
+			cs->control_gi = gi_iter;
+			break;
+		}
+	}
+}
+
+static inline void remove_gb(struct cpuset *cs)
+{
+	if (cs_gi(cs)->part_info)
+		update_gb_part_info(cs, NULL);
 }
 
 static u64 gb_period_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
@@ -2560,28 +2636,156 @@ static int gb_period_write_u64(struct cgroup_subsys_state *css, struct cftype *c
 {
 	struct cpuset *cs = css_cs(css);
 	struct gb_info *gi = cs_gi(cs);
+	int retval = -EINVAL;
 
 	if (val > MAX_GB_PERIOD)
-		return -EINVAL;
+		return retval;
 
 	percpu_down_write(&cpuset_rwsem);
 
+	/*
+	 * Cannot enable group balancer on cgroups
+	 * whose partition info not set.
+	 */
+	if (!gi->part_info)
+		goto out_unlock;
+
 	gi->gb_period = val * NSEC_PER_USEC;
+	retval = 0;
 
+out_unlock:
 	percpu_up_write(&cpuset_rwsem);
-	return 0;
+	return retval;
 }
 
 static void gb_partition_read(struct seq_file *sf, struct gb_info *gi)
 {
+	struct gb_part_info *pi = gi->part_info;
+	int i;
+
+	if (!pi)
+		return;
+
+	for_each_gbpart(i, pi)
+		seq_printf(sf, "%*pbl;", cpumask_pr_args(part_cpus(pi, i)));
+
 	seq_putc(sf, '\n');
 }
 
+static void build_gb_partition(struct cpumask *cpus_allowed, struct gb_part_info *pi, int id)
+{
+	int i;
+	struct gb_part *part = &pi->parts[id];
+
+	part->id = id;
+	cpumask_copy(&part->cpus, cpus_allowed);
+
+	for_each_cpu(i, &part->cpus)
+		pi->ctop[i] = id;
+}
+
+static int __gb_partition_write(struct cpuset *cs, char *buf, size_t nbytes)
+{
+	struct gb_part_info *new_pi;
+	bool should_stop = false;
+	int ret, retval = -EINVAL, id = 0;
+	char *start, *end;
+	cpumask_var_t summask, cpus_allowed;
+
+	/*
+	 * Write empty string to clear partition info.
+	 * Then this cgroup is not a controller.
+	 */
+	if (nbytes < 2) {
+		update_gb_part_info(cs, NULL);
+		retval = 0;
+		goto out;
+	}
+
+	retval = -ENOMEM;
+	if (!zalloc_cpumask_var(&summask, GFP_KERNEL))
+		goto out;
+	if (!zalloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		goto out_free_cpumask;
+	new_pi = kzalloc(sizeof(*new_pi), GFP_KERNEL);
+	if (!new_pi)
+		goto out_free_cpumask2;
+
+	buf = strstrip(buf);
+	memset(new_pi->ctop, -1, sizeof(int) * num_possible_cpus());
+	start = buf;
+	end = strchr(start, ';');
+	retval = -EINVAL;
+
+	/* Handle user input in format of "cpulist1;cpulist2;...;cpulistN;" */
+	for (;;) {
+		if (!end)
+			should_stop = true;
+		else
+			*end = '\0';
+
+		if (*start == '\0')
+			goto next;
+
+		if (new_pi->nr_part >= CPU_PART_MAX) {
+			pr_warn("part number should be no larger than %d\n", CPU_PART_MAX);
+			goto out_free_pi;
+		}
+
+		ret = cpulist_parse(start, cpus_allowed);
+		if (ret || cpumask_empty(cpus_allowed)) {
+			pr_warn("invalid cpulist: %s\n", start);
+			goto out_free_pi;
+		}
+
+		/* There should not be intersections betweem partitions. */
+		if (cpumask_intersects(summask, cpus_allowed)) {
+			pr_warn("%*pbl intersect with others\n", cpumask_pr_args(cpus_allowed));
+			goto out_free_pi;
+		}
+
+		cpumask_or(summask, summask, cpus_allowed);
+
+		build_gb_partition(cpus_allowed, new_pi, id);
+		id++;
+		new_pi->nr_part++;
+next:
+		if (should_stop)
+			break;
+
+		start = end + 1;
+		end = strchr(start, ';');
+	}
+
+	/*
+	 * Check whether the input is valid.
+	 * Should not conflict with effective_cpus.
+	 */
+	if (!cpumask_subset(summask, cs->effective_cpus) || new_pi->nr_part < 2) {
+		pr_warn("invalid cpulist\n");
+		goto out_free_pi;
+	}
+
+	update_gb_part_info(cs, new_pi);
+
+	retval = 0;
+	goto out_free_cpumask2;
+
+out_free_pi:
+	kfree(new_pi);
+out_free_cpumask2:
+	free_cpumask_var(cpus_allowed);
+out_free_cpumask:
+	free_cpumask_var(summask);
+out:
+	return retval;
+}
+
 static ssize_t gb_partition_write(struct kernfs_open_file *of, char *buf,
 				     size_t nbytes, loff_t off)
 {
-	struct cgroup_subsys_state *css = of_css(of);
-	struct cpuset *cs = css_cs(css);
+	struct cgroup_subsys_state *css = of_css(of), *pos_css;
+	struct cpuset *cs = css_cs(css), *cp;
 	int retval = -ENODEV;
 
 	cpus_read_lock();
@@ -2589,7 +2793,31 @@ static ssize_t gb_partition_write(struct kernfs_open_file *of, char *buf,
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
-	retval = 0;
+	retval = -EINVAL;
+	/* Cannot change gb partition during enabling. */
+	if (cs_gi(cs)->gb_period)
+		goto out_unlock;
+
+	/*
+	 * Cannot set gb partitons on cgroup whose
+	 * ancestor or descendant has been set.
+	 */
+	if (css_gi(css, true))
+		goto out_unlock;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
+		if (cp == cs)
+			continue;
+
+		if (cs_gi(cp)->part_info) {
+			rcu_read_unlock();
+			goto out_unlock;
+		}
+	}
+	rcu_read_unlock();
+
+	retval = __gb_partition_write(cs, buf, nbytes);
 
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
@@ -2598,6 +2826,7 @@ static ssize_t gb_partition_write(struct kernfs_open_file *of, char *buf,
 }
 #else
 static inline void init_gb(struct cpuset *cs) { }
+static inline void remove_gb(struct cpuset *cs) { }
 static inline void gb_partition_read(struct seq_file *sf, struct gb_info *gi) { }
 #endif /* CONFIG_GROUP_BALANCER */
 
@@ -3051,6 +3280,8 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 		parent->child_ecpus_count--;
 	}
 
+	remove_gb(cs);
+
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-- 
2.27.0

