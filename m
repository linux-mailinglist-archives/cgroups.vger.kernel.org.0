Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6344833CF6
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfFDB6g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 21:58:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53671 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbfFDB6g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 21:58:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTNnVwF_1559613512;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTNnVwF_1559613512)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jun 2019 09:58:33 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC PATCH 3/3] psi: add cgroup v1 interfaces
Date:   Tue,  4 Jun 2019 09:57:45 +0800
Message-Id: <20190604015745.78972-4-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
References: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For cgroup v1, interfaces are under each subsystem.
/sys/fs/cgroup/cpuacct/cpu.pressure
/sys/fs/cgroup/memory/memory.pressure
/sys/fs/cgroup/blkio/io.pressure

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-throttle.c   | 10 ++++++++++
 kernel/sched/cpuacct.c | 10 ++++++++++
 mm/memcontrol.c        | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9ea7c0ecad10..b802262ecf8a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1510,6 +1510,16 @@ static struct cftype throtl_legacy_files[] = {
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show = blkg_print_stat_ios_recursive,
 	},
+#ifdef CONFIG_PSI
+	{
+		.name = "io.pressure",
+		.flags = CFTYPE_NO_PREFIX,
+		.seq_show = cgroup_io_pressure_show,
+		.write = cgroup_io_pressure_write,
+		.poll = cgroup_pressure_poll,
+		.release = cgroup_pressure_release,
+	},
+#endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb10383434..58ccfaf996aa 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -327,6 +327,16 @@ static struct cftype files[] = {
 		.name = "stat",
 		.seq_show = cpuacct_stats_show,
 	},
+#ifdef CONFIG_PSI
+	{
+		.name = "cpu.pressure",
+		.flags = CFTYPE_NO_PREFIX,
+		.seq_show = cgroup_cpu_pressure_show,
+		.write = cgroup_cpu_pressure_write,
+		.poll = cgroup_pressure_poll,
+		.release = cgroup_pressure_release,
+	},
+#endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ca0bc6e6be13..4fc752719412 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4391,6 +4391,16 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+#ifdef CONFIG_PSI
+	{
+		.name = "memory.pressure",
+		.flags = CFTYPE_NO_PREFIX,
+		.seq_show = cgroup_memory_pressure_show,
+		.write = cgroup_memory_pressure_write,
+		.poll = cgroup_pressure_poll,
+		.release = cgroup_pressure_release,
+	},
+#endif /* CONFIG_PSI */
 	{ },	/* terminate */
 };
 
-- 
2.19.1.856.g8858448bb

