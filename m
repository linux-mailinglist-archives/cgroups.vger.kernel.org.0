Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE834D134B
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 10:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiCHJ1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 04:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbiCHJ1n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 04:27:43 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61940A1B;
        Tue,  8 Mar 2022 01:26:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0V6e-tjP_1646731598;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6e-tjP_1646731598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 17:26:40 +0800
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
Subject: [RFC PATCH v2 1/4] sched, cpuset: Introduce infrastructure of group balancer
Date:   Tue,  8 Mar 2022 17:26:26 +0800
Message-Id: <20220308092629.40431-2-dtcccc@linux.alibaba.com>
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

Introduce CONFIG and struct about group balancer.
Add a few interfaces on cpuset and debugfs to read&write params.

In detail:
cgroup:
  cpuset.gb.period_us:
    To control work period.
    Write a positive number to enable group balancer
    for all descendants EXCEPT itself.
    Write 0 to disable it.
    MAX 1000000. (1s)
    Can only write after partition info set.

  cpuset.gb.partition:
    Partition info used by group balancer.
    Tasks in child cgroups (EXCEPT itself) will try to
    settle at one of given partitions when gb enabled.

/sys/kernel/debug/sched/group_balancer/:
  settle_period_ms:
    Default settle period for each group.

  settle_period_max_ms:
    Max settle period for each group.

  global_settle_period_ms:
    Global settle period for all groups.
    For one group, the operation of settling must
    satisfy the periods of itself and global.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 include/linux/sched/gb.h |  29 +++++++++++
 init/Kconfig             |  12 +++++
 kernel/cgroup/cpuset.c   | 109 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/Makefile    |   1 +
 kernel/sched/debug.c     |  10 +++-
 kernel/sched/gb.c        |  14 +++++
 kernel/sched/sched.h     |   4 ++
 7 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sched/gb.h
 create mode 100644 kernel/sched/gb.c

diff --git a/include/linux/sched/gb.h b/include/linux/sched/gb.h
new file mode 100644
index 000000000000..63c14289a748
--- /dev/null
+++ b/include/linux/sched/gb.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Group Balancer header
+ *
+ *  Copyright (C) 2021 Alibaba, Inc., Michael Wang <yun.wang@linux.alibaba.com>
+ */
+#ifndef _LINUX_SCHED_GB_H
+#define _LINUX_SCHED_GB_H
+
+#include <linux/sched.h>
+
+struct gb_info {
+	/* ---for ancestor as controller--- */
+	/* Period(ns) for task work in task tick, 0 means disabled. */
+	u64 gb_period;
+
+	/* ---for descendants who scheduled by group balancer--- */
+	/* Period for settling to specific partition. */
+	unsigned long settle_period;
+
+	/* Stamp to record next settling. */
+	unsigned long settle_next;
+};
+
+#ifdef CONFIG_GROUP_BALANCER
+extern unsigned int sysctl_gb_settle_period;
+#endif
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index 8b79eda8e1d4..8f05e5e7e299 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1043,6 +1043,18 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config GROUP_BALANCER
+	bool "Group balancer support for SCHED_OTHER"
+	depends on (CGROUP_SCHED && SMP)
+	default CGROUP_SCHED
+	help
+	  This feature allow you to do load balance in group mode. In other
+	  word, balance groups of tasks among groups of CPUs.
+
+	  This can reduce the conflict between task groups and gain benefit
+	  from hot cache and affinity domain, usually for the cases when there
+	  are multiple apps sharing the same CPUs.
+
 endif #CGROUP_SCHED
 
 config UCLAMP_TASK_GROUP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ef88cc366bb8..0349f3f64e3d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -65,6 +65,7 @@
 #include <linux/mutex.h>
 #include <linux/cgroup.h>
 #include <linux/wait.h>
+#include <linux/sched/gb.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -170,6 +171,14 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+#ifdef CONFIG_GROUP_BALANCER
+	/* Partition info and configs of group balancer */
+	struct gb_info gi;
+
+	/* Point to the controller (in ancestor cgroup) who has partition info */
+	struct gb_info *control_gi;
+#endif
 };
 
 /*
@@ -215,6 +224,24 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+#ifdef CONFIG_GROUP_BALANCER
+static inline struct gb_info *cs_gi(struct cpuset *cs)
+{
+	return &cs->gi;
+}
+static struct gb_info *css_gi(struct cgroup_subsys_state *css, bool get_controller)
+{
+	struct cpuset *cs = css_cs(css);
+
+	return get_controller ? cs->control_gi : &cs->gi;
+}
+#else
+static inline struct gb_info *cs_gi(struct cpuset *cs)
+{
+	return NULL;
+}
+#endif /* CONFIG_GROUP_BALANCER */
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -2365,6 +2392,7 @@ typedef enum {
 	FILE_MEMORY_PRESSURE,
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
+	FILE_GB_CPULIST,
 } cpuset_filetype_t;
 
 static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
@@ -2510,6 +2538,69 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	return retval ?: nbytes;
 }
 
+#ifdef CONFIG_GROUP_BALANCER
+static inline void init_gb(struct cpuset *cs)
+{
+	struct gb_info *gi = cs_gi(cs);
+
+	gi->settle_period = msecs_to_jiffies(sysctl_gb_settle_period);
+	gi->settle_next = jiffies + gi->settle_period;
+}
+
+static u64 gb_period_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct gb_info *gi = css_gi(css, false);
+
+	return gi->gb_period / NSEC_PER_USEC;
+}
+
+#define MAX_GB_PERIOD USEC_PER_SEC /* 1s */
+
+static int gb_period_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct cpuset *cs = css_cs(css);
+	struct gb_info *gi = cs_gi(cs);
+
+	if (val > MAX_GB_PERIOD)
+		return -EINVAL;
+
+	percpu_down_write(&cpuset_rwsem);
+
+	gi->gb_period = val * NSEC_PER_USEC;
+
+	percpu_up_write(&cpuset_rwsem);
+	return 0;
+}
+
+static void gb_partition_read(struct seq_file *sf, struct gb_info *gi)
+{
+	seq_putc(sf, '\n');
+}
+
+static ssize_t gb_partition_write(struct kernfs_open_file *of, char *buf,
+				     size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct cpuset *cs = css_cs(css);
+	int retval = -ENODEV;
+
+	cpus_read_lock();
+	percpu_down_write(&cpuset_rwsem);
+	if (!is_cpuset_online(cs))
+		goto out_unlock;
+
+	retval = 0;
+
+out_unlock:
+	percpu_up_write(&cpuset_rwsem);
+	cpus_read_unlock();
+	return retval ?: nbytes;
+}
+#else
+static inline void init_gb(struct cpuset *cs) { }
+static inline void gb_partition_read(struct seq_file *sf, struct gb_info *gi) { }
+#endif /* CONFIG_GROUP_BALANCER */
+
 /*
  * These ascii lists should be read in a single call, by using a user
  * buffer large enough to hold the entire map.  If read in smaller
@@ -2542,6 +2633,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_SUBPARTS_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->subparts_cpus));
 		break;
+	case FILE_GB_CPULIST:
+		gb_partition_read(sf, cs_gi(cs));
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -2803,7 +2897,21 @@ static struct cftype dfl_files[] = {
 		.private = FILE_SUBPARTS_CPULIST,
 		.flags = CFTYPE_DEBUG,
 	},
+#ifdef CONFIG_GROUP_BALANCER
+	{
+		.name = "gb.period_us",
+		.read_u64 = gb_period_read_u64,
+		.write_u64 = gb_period_write_u64,
+	},
 
+	{
+		.name = "gb.partition",
+		.seq_show = cpuset_common_seq_show,
+		.write = gb_partition_write,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_GB_CPULIST,
+	},
+#endif
 	{ }	/* terminate */
 };
 
@@ -2870,6 +2978,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
+		init_gb(cs);
 	}
 	spin_unlock_irq(&callback_lock);
 
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c83b37af155b..cb5b86bb161e 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_GROUP_BALANCER) += gb.o
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 102d6f70e84d..1800bdfe1d61 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -299,7 +299,7 @@ static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
 {
-	struct dentry __maybe_unused *numa;
+	struct dentry __maybe_unused *numa, *gb;
 
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
@@ -336,6 +336,14 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
 #endif
 
+#ifdef CONFIG_GROUP_BALANCER
+	gb = debugfs_create_dir("group_balancer", debugfs_sched);
+
+	debugfs_create_u32("settle_period_ms", 0644, gb, &sysctl_gb_settle_period);
+	debugfs_create_u32("settle_period_max_ms", 0644, gb, &sysctl_gb_settle_period_max);
+	debugfs_create_u32("global_settle_period_ms", 0644, gb, &sysctl_gb_global_settle_period);
+#endif
+
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	return 0;
diff --git a/kernel/sched/gb.c b/kernel/sched/gb.c
new file mode 100644
index 000000000000..4a2876ec1cca
--- /dev/null
+++ b/kernel/sched/gb.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Group Balancer code
+ *
+ *  Copyright (C) 2021 Alibaba, Inc., Michael Wang <yun.wang@linux.alibaba.com>
+ */
+#include <linux/sched/gb.h>
+
+#include "sched.h"
+
+/* Params about settle period. (ms) */
+unsigned int sysctl_gb_settle_period = 200;
+unsigned int sysctl_gb_settle_period_max = 10000;
+unsigned int sysctl_gb_global_settle_period = 200;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ac1f9470c617..d6555aacdf78 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2433,6 +2433,10 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+
+extern unsigned int sysctl_gb_settle_period;
+extern unsigned int sysctl_gb_settle_period_max;
+extern unsigned int sysctl_gb_global_settle_period;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
-- 
2.27.0

