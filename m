Return-Path: <cgroups+bounces-4422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1F95CA13
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4672B1C20F5C
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844C1891DE;
	Fri, 23 Aug 2024 10:09:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AC17E8E2;
	Fri, 23 Aug 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407743; cv=none; b=m+e+tw5+NDzBPZt8kc/+vPhn6AAexH5m2MmIe/dryVqhiojOgrjpCcXr0fXk+GclN2KsxmXNJJXA2nKbMZE9IhoaM3gZXU9/Jt7Z4BYTCx6GRhvto6sh9WyuNiLRg2SiITFbYb/0J2nhtmRQLPE1IXJuPBNPRHTrh5cGDpuj53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407743; c=relaxed/simple;
	bh=c4Q2Uv7KKoSJwkaAhXsAhyeXjXFF2Mn4vpzjATfVVK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL9vJTvt4YkIWYKJ9YECCjENVe1o5jihJDEHmDtnNUfSgc6COszHcnX8uvE5dmx/Ime+hmvAvJfCbUDr8vAFq7PJBmlTwxZhkuDbP1brtf6p5L0DpU73Rh1VxeW5zTyu1k+XkkBSkXMWAYpMGIIASfBHd3Rb5KXSRUdmQ45m0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wqwj311dHz1xvw8;
	Fri, 23 Aug 2024 18:07:03 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8602414013B;
	Fri, 23 Aug 2024 18:08:58 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:57 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 10/11] cgroup/cpuset: guard cpuset-v1 code under CONFIG_CPUSETS_V1
Date: Fri, 23 Aug 2024 10:01:09 +0000
Message-ID: <20240823100110.472120-11-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823100110.472120-1-chenridong@huawei.com>
References: <20240823100110.472120-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
user who adopted v2 don't have 'pay' for cpuset v1.
Besides, to make code succinct, rename '__cpuset_memory_pressure_bump()'
to 'cpuset_memory_pressure_bump()', and expose it to the world, which
takes place of the old mocro 'cpuset_memory_pressure_bump'.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cpuset.h          |  8 +-------
 init/Kconfig                    | 13 +++++++++++++
 kernel/cgroup/Makefile          |  3 ++-
 kernel/cgroup/cpuset-internal.h | 15 +++++++++++++++
 kernel/cgroup/cpuset-v1.c       | 10 ++++++----
 kernel/cgroup/cpuset.c          |  2 ++
 6 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2a6981eeebf8..f91f1f61f482 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -99,13 +99,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 					  const struct task_struct *tsk2);
 
-#define cpuset_memory_pressure_bump() 				\
-	do {							\
-		if (cpuset_memory_pressure_enabled)		\
-			__cpuset_memory_pressure_bump();	\
-	} while (0)
-extern int cpuset_memory_pressure_enabled;
-extern void __cpuset_memory_pressure_bump(void);
+extern void cpuset_memory_pressure_bump(void);
 
 extern void cpuset_task_status_allowed(struct seq_file *m,
 					struct task_struct *task);
diff --git a/init/Kconfig b/init/Kconfig
index b9ec6b6ef3a5..369941de9c2c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1144,6 +1144,19 @@ config CPUSETS
 
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
index 36e9686c7bba..9ccc4f54eefd 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -279,6 +279,7 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v);
 /*
  * cpuset-v1.c
  */
+#ifdef CONFIG_CPUSETS_V1
 extern struct cftype legacy_files[];
 void fmeter_init(struct fmeter *fmp);
 void cpuset_update_task_spread_flags(struct cpuset *cs,
@@ -288,5 +289,19 @@ void hotplug_update_tasks_legacy(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int validate_change_legacy(struct cpuset *cur, struct cpuset *trial);
+void cpuset_memory_pressure_bump(void);
+
+#else
+static inline void fmeter_init(struct fmeter *fmp) {}
+static inline void cpuset_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk) {}
+static inline void update_tasks_flags(struct cpuset *cs) {}
+static inline void hotplug_update_tasks_legacy(struct cpuset *cs,
+			    struct cpumask *new_cpus, nodemask_t *new_mems,
+			    bool cpus_updated, bool mems_updated) {}
+static inline int validate_change_legacy(struct cpuset *cur,
+				struct cpuset *trial) { return 0; }
+void cpuset_memory_pressure_bump(void) {}
 
+#endif /* CONFIG_CPUSETS_V1 */
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ffb8711cc8fa..efa5ab0167b6 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -137,11 +137,13 @@ int cpuset_memory_pressure_enabled __read_mostly;
  * (direct) page reclaim by any task attached to the cpuset.
  */
 
-void __cpuset_memory_pressure_bump(void)
+void cpuset_memory_pressure_bump(void)
 {
-	rcu_read_lock();
-	fmeter_markevent(&task_cs(current)->fmeter);
-	rcu_read_unlock();
+	if (cpuset_memory_pressure_enabled) {
+		rcu_read_lock();
+		fmeter_markevent(&task_cs(current)->fmeter);
+		rcu_read_unlock();
+	}
 }
 
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 903e7bab399a..658a9e00671b 100644
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


