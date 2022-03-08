Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C524F4D134C
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbiCHJ2G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbiCHJ1w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 04:27:52 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3F4132F;
        Tue,  8 Mar 2022 01:26:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0V6e-tlT_1646731606;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6e-tlT_1646731606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 17:26:48 +0800
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
Subject: [RFC PATCH v2 4/4] cpuset, gb: Add stat for group balancer
Date:   Tue,  8 Mar 2022 17:26:29 +0800
Message-Id: <20220308092629.40431-5-dtcccc@linux.alibaba.com>
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

When group balancer is enabled by:
  echo 200000 > $CGROUP_PATH/cpuset.gb.period_us

Then you can check:
  $CPU_CGROUP_PATH/childX/cpuset.gb.stat

which give output as:
  PART-0 0-15 1008 1086  *
  PART-1 16-31 0 2
  PART-2 32-47 0 0
  PART-3 48-63 0 1024

The partition ID followed by it's CPUs range, load of group, load
of partition and a star mark as preferred.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 include/linux/sched/gb.h |  2 ++
 kernel/cgroup/cpuset.c   | 24 ++++++++++++++++++++++++
 kernel/sched/gb.c        | 25 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/linux/sched/gb.h b/include/linux/sched/gb.h
index 7af91662b740..ec5a97d8160a 100644
--- a/include/linux/sched/gb.h
+++ b/include/linux/sched/gb.h
@@ -63,6 +63,8 @@ static inline struct cpumask *part_cpus(struct gb_part_info *pi, int id)
 
 #ifdef CONFIG_GROUP_BALANCER
 extern unsigned int sysctl_gb_settle_period;
+int gb_stat_show(struct seq_file *sf, struct cgroup_subsys_state *css,
+		 struct gb_info *gi, struct gb_part_info *pi);
 #endif
 
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index de13c22c1921..035606e8fa95 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2863,6 +2863,24 @@ static ssize_t gb_partition_write(struct kernfs_open_file *of, char *buf,
 	cpus_read_unlock();
 	return retval ?: nbytes;
 }
+
+static int gb_stat_seq_show(struct seq_file *sf, void *v)
+{
+	struct cgroup_subsys_state *css = seq_css(sf);
+	struct gb_info *control_gi;
+	int retval = -EINVAL;
+
+	rcu_read_lock();
+	control_gi = css_gi(css, true);
+	if (!control_gi || !control_gi->gb_period)
+		goto out_unlock;
+
+	retval = gb_stat_show(sf, css, css_gi(css, false), control_gi->part_info);
+
+out_unlock:
+	rcu_read_unlock();
+	return retval;
+}
 #else
 static inline void init_gb(struct cpuset *cs) { }
 static inline void remove_gb(struct cpuset *cs) { }
@@ -3179,6 +3197,12 @@ static struct cftype dfl_files[] = {
 		.max_write_len = (100U + 6 * NR_CPUS),
 		.private = FILE_GB_CPULIST,
 	},
+
+	{
+		.name = "gb.stat",
+		.seq_show = gb_stat_seq_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/gb.c b/kernel/sched/gb.c
index f7da96253ad0..8ae1db83b587 100644
--- a/kernel/sched/gb.c
+++ b/kernel/sched/gb.c
@@ -46,6 +46,31 @@ static u64 load_of_part(struct gb_part_info *pi, int id)
 	return load;
 }
 
+int gb_stat_show(struct seq_file *sf, struct cgroup_subsys_state *css,
+		 struct gb_info *gi, struct gb_part_info *pi)
+{
+	struct cgroup_subsys_state *tg_css;
+	struct task_group *tg;
+	int i;
+
+	tg_css = cgroup_e_css(css->cgroup, &cpu_cgrp_subsys);
+	/* Make sure that "cpu" and "cpuset" subsys belonging to the same cgroup. */
+	if (tg_css->cgroup != css->cgroup)
+		return -EINVAL;
+	tg = container_of(tg_css, struct task_group, css);
+
+	for_each_gbpart(i, pi) {
+		seq_printf(sf, "PART-%d ", i);
+		seq_printf(sf, "%*pbl ", cpumask_pr_args(part_cpus(pi, i)));
+		seq_printf(sf, "%llu ", tg_load_of_part(pi, tg, i));
+		seq_printf(sf, "%llu ", load_of_part(pi, i));
+		if (gi->gb_prefer == i)
+			seq_puts(sf, " *");
+		seq_putc(sf, '\n');
+	}
+	return 0;
+}
+
 static inline int part_mgrt_lock(struct gb_part_info *pi, int src, int dst)
 {
 	struct gb_part *src_part, *dst_part;
-- 
2.27.0

