Return-Path: <cgroups+bounces-4500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BB9601BB
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02891C22CF8
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2076198E74;
	Tue, 27 Aug 2024 06:29:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A20156237;
	Tue, 27 Aug 2024 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740150; cv=none; b=gYZf5Qb5E2Sx4ZISVijAM6zXWhMl5nzuXgUrf6muLhzB7qSusoYjSILQeyusFH6gpc9y4pLCoYgBKowsaPcOlOpD/bzoRXC/OmsWXWbFgOHG0+Tfybh6TXOvABp8xvn23fq85eEgfP8VU9QfVWIQlpKlKpVMJR+kVnCciqv5zIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740150; c=relaxed/simple;
	bh=jKjLN4ql16Ut8cf5/9ALUpUSkNjQfiCxijNdBjjqM6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eb6F/z0KzH+KaSiMgXvzCxLfiHjWCzD0iA+7E9Z1fBR6zaSUWEbR7rwwfr3aLHUWy/vRPsc3vTm+asrjDN7haWaP9cj0K0+yJSguqXvPwi8b5WFbJ7sJ+OdjlPy3jPhC763aDec5urEKrsK7Q/2I5ERJ8mmAIy5fOFObZt/qYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtHZ54WW5zQqrZ;
	Tue, 27 Aug 2024 14:24:13 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CD3B1800D3;
	Tue, 27 Aug 2024 14:29:02 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:29:01 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 11/12] cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
Date: Tue, 27 Aug 2024 06:21:10 +0000
Message-ID: <20240827062111.580296-12-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827062111.580296-1-chenridong@huawei.com>
References: <20240827062111.580296-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
user who adopted v2 don't have 'pay' for cpuset v1.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cpuset.h          |  4 ++++
 init/Kconfig                    | 13 +++++++++++++
 kernel/cgroup/Makefile          |  3 ++-
 kernel/cgroup/cpuset-internal.h | 12 ++++++++++++
 kernel/cgroup/cpuset.c          |  2 ++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2a6981eeebf8..835e7b793f6a 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -99,6 +99,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 					  const struct task_struct *tsk2);
 
+#ifdef CONFIG_CPUSETS_V1
 #define cpuset_memory_pressure_bump() 				\
 	do {							\
 		if (cpuset_memory_pressure_enabled)		\
@@ -106,6 +107,9 @@ extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 	} while (0)
 extern int cpuset_memory_pressure_enabled;
 extern void __cpuset_memory_pressure_bump(void);
+#else
+static inline void cpuset_memory_pressure_bump(void) { }
+#endif
 
 extern void cpuset_task_status_allowed(struct seq_file *m,
 					struct task_struct *task);
diff --git a/init/Kconfig b/init/Kconfig
index a465ea9525bd..8bf091354bea 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1143,6 +1143,19 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CPUSETS_V1
+	bool "Legacy cgroup v1 cpusets controller"
+	depends on CPUSETS
+	default n
+	help
+	  Legacy cgroup v1 cpusets controller which has been deprecated by
+	  cgroup v2 implementation. The v1 is there for legacy applications
+	  which haven't migrated to the new cgroup v2 interface yet. If you
+	  do not have any such application then you are completely fine leaving
+	  this option disabled.
+
+	  Say N if unsure.
+
 config PROC_PID_CPUSET
 	bool "Include legacy /proc/<pid>/cpuset file"
 	depends on CPUSETS
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 005ac4c675cb..a5c9359d516f 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -4,6 +4,7 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
-obj-$(CONFIG_CPUSETS) += cpuset.o cpuset-v1.o
+obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CPUSETS_V1) += cpuset-v1.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 683fcf8bc743..0474eeb13c34 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -279,6 +279,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v);
 /*
  * cpuset-v1.c
  */
+#ifdef CONFIG_CPUSETS_V1
 extern struct cftype legacy_files[];
 void cpuset1_fmeter_init(struct fmeter *fmp);
 void cpuset1_update_task_spread_flags(struct cpuset *cs,
@@ -288,5 +289,16 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
+#else
+static inline void cpuset1_fmeter_init(struct fmeter *fmp) {}
+static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk) {}
+static inline void cpuset1_update_tasks_flags(struct cpuset *cs) {}
+static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
+			    struct cpumask *new_cpus, nodemask_t *new_mems,
+			    bool cpus_updated, bool mems_updated) {}
+static inline int cpuset1_validate_change(struct cpuset *cur,
+				struct cpuset *trial) { return 0; }
+#endif /* CONFIG_CPUSETS_V1 */
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f215311eab62..7f82b8ed8fb3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3617,7 +3617,9 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.can_fork	= cpuset_can_fork,
 	.cancel_fork	= cpuset_cancel_fork,
 	.fork		= cpuset_fork,
+#ifdef CONFIG_CPUSETS_V1
 	.legacy_cftypes	= legacy_files,
+#endif
 	.dfl_cftypes	= dfl_files,
 	.early_init	= true,
 	.threaded	= true,
-- 
2.34.1


