Return-Path: <cgroups+bounces-4421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7576295CA12
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0491C22577
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AD1891A9;
	Fri, 23 Aug 2024 10:09:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6A18308E;
	Fri, 23 Aug 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407743; cv=none; b=sKBGKYzuvYBiK9koKfTq2W5E61yOWKUN69EaazgLT3GmPKJJUtSzCAWTZ1cnienpJ1OnDFDMobf9s2TCg3gh7BexFoJxlRIUrHf1vIvSSXvtes4tT1gRqkQjdE4wNuppu1XZwCCNlz+fYsyn5bsjwlQcBAT2CZLmUnxELM8Mtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407743; c=relaxed/simple;
	bh=pUege3SH6tTL1nP/k0HJJetBAEz5VgLz4LVrqtfHZaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtedD1XdFeqUXxst/zvzBFJxgtU0cb9hmJ1kiclqwK6vYhpp71YH1Gj/rYl5JeZ31qsOaWetDmn3M4TuQM/Q2hHeTyLcXtv3x1w8CLVbZMAFhanRVEBtAhspV2K0uSd9pjeK8/IrAq8UD/fWbUh2q6AUPxPzqDorOOeGWP7MZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wqwl9389xz1j6hK;
	Fri, 23 Aug 2024 18:08:53 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 17E4614013B;
	Fri, 23 Aug 2024 18:08:58 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:57 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 09/11] cgroup/cpuset: move v1 interfaces to cpuset-v1.c
Date: Fri, 23 Aug 2024 10:01:08 +0000
Message-ID: <20240823100110.472120-10-chenridong@huawei.com>
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

Move legacy cpuset controller interfaces files and corresponding code
into cpuset-v1.c. 'update_flag', 'cpuset_write_resmask' and
'cpuset_common_seq_show' are also used for v1, so declare them in
cpuset-internal.h.

'cpuset_write_s64', 'cpuset_read_s64' and 'fmeter_getrate' are only used
cpuset-v1.c now, make it static.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |   9 +-
 kernel/cgroup/cpuset-v1.c       | 194 ++++++++++++++++++++++++++++++-
 kernel/cgroup/cpuset.c          | 195 +-------------------------------
 3 files changed, 199 insertions(+), 199 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 8df6d58673c0..36e9686c7bba 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -271,15 +271,16 @@ void callback_lock_irq(void);
 void callback_unlock_irq(void);
 void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
 void update_tasks_nodemask(struct cpuset *cs);
+int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on);
+ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes, loff_t off);
+int cpuset_common_seq_show(struct seq_file *sf, void *v);
 
 /*
  * cpuset-v1.c
  */
+extern struct cftype legacy_files[];
 void fmeter_init(struct fmeter *fmp);
-int fmeter_getrate(struct fmeter *fmp);
-int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
-			    s64 val);
-s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft);
 void cpuset_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk);
 void update_tasks_flags(struct cpuset *cs);
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 246fc962f549..ffb8711cc8fa 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -100,7 +100,7 @@ static void fmeter_markevent(struct fmeter *fmp)
 }
 
 /* Process any previous ticks, then return current value. */
-int fmeter_getrate(struct fmeter *fmp)
+static int fmeter_getrate(struct fmeter *fmp)
 {
 	int val;
 
@@ -161,7 +161,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
 	return 0;
 }
 
-int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
+static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 			    s64 val)
 {
 	struct cpuset *cs = css_cs(css);
@@ -187,7 +187,7 @@ int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
-s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
+static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
 	struct cpuset *cs = css_cs(css);
 	cpuset_filetype_t type = cft->private;
@@ -373,3 +373,191 @@ int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
 	return ret;
 }
 
+static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct cpuset *cs = css_cs(css);
+	cpuset_filetype_t type = cft->private;
+
+	switch (type) {
+	case FILE_CPU_EXCLUSIVE:
+		return is_cpu_exclusive(cs);
+	case FILE_MEM_EXCLUSIVE:
+		return is_mem_exclusive(cs);
+	case FILE_MEM_HARDWALL:
+		return is_mem_hardwall(cs);
+	case FILE_SCHED_LOAD_BALANCE:
+		return is_sched_load_balance(cs);
+	case FILE_MEMORY_MIGRATE:
+		return is_memory_migrate(cs);
+	case FILE_MEMORY_PRESSURE_ENABLED:
+		return cpuset_memory_pressure_enabled;
+	case FILE_MEMORY_PRESSURE:
+		return fmeter_getrate(&cs->fmeter);
+	case FILE_SPREAD_PAGE:
+		return is_spread_page(cs);
+	case FILE_SPREAD_SLAB:
+		return is_spread_slab(cs);
+	default:
+		BUG();
+	}
+
+	/* Unreachable but makes gcc happy */
+	return 0;
+}
+
+static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			    u64 val)
+{
+	struct cpuset *cs = css_cs(css);
+	cpuset_filetype_t type = cft->private;
+	int retval = 0;
+
+	cpus_read_lock();
+	cpuset_lock();
+	if (!is_cpuset_online(cs)) {
+		retval = -ENODEV;
+		goto out_unlock;
+	}
+
+	switch (type) {
+	case FILE_CPU_EXCLUSIVE:
+		retval = update_flag(CS_CPU_EXCLUSIVE, cs, val);
+		break;
+	case FILE_MEM_EXCLUSIVE:
+		retval = update_flag(CS_MEM_EXCLUSIVE, cs, val);
+		break;
+	case FILE_MEM_HARDWALL:
+		retval = update_flag(CS_MEM_HARDWALL, cs, val);
+		break;
+	case FILE_SCHED_LOAD_BALANCE:
+		retval = update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
+		break;
+	case FILE_MEMORY_MIGRATE:
+		retval = update_flag(CS_MEMORY_MIGRATE, cs, val);
+		break;
+	case FILE_MEMORY_PRESSURE_ENABLED:
+		cpuset_memory_pressure_enabled = !!val;
+		break;
+	case FILE_SPREAD_PAGE:
+		retval = update_flag(CS_SPREAD_PAGE, cs, val);
+		break;
+	case FILE_SPREAD_SLAB:
+		retval = update_flag(CS_SPREAD_SLAB, cs, val);
+		break;
+	default:
+		retval = -EINVAL;
+		break;
+	}
+out_unlock:
+	cpuset_unlock();
+	cpus_read_unlock();
+	return retval;
+}
+
+/*
+ * for the common functions, 'private' gives the type of file
+ */
+
+struct cftype legacy_files[] = {
+	{
+		.name = "cpus",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_CPULIST,
+	},
+
+	{
+		.name = "mems",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.max_write_len = (100U + 6 * MAX_NUMNODES),
+		.private = FILE_MEMLIST,
+	},
+
+	{
+		.name = "effective_cpus",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_EFFECTIVE_CPULIST,
+	},
+
+	{
+		.name = "effective_mems",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_EFFECTIVE_MEMLIST,
+	},
+
+	{
+		.name = "cpu_exclusive",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_CPU_EXCLUSIVE,
+	},
+
+	{
+		.name = "mem_exclusive",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_MEM_EXCLUSIVE,
+	},
+
+	{
+		.name = "mem_hardwall",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_MEM_HARDWALL,
+	},
+
+	{
+		.name = "sched_load_balance",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_SCHED_LOAD_BALANCE,
+	},
+
+	{
+		.name = "sched_relax_domain_level",
+		.read_s64 = cpuset_read_s64,
+		.write_s64 = cpuset_write_s64,
+		.private = FILE_SCHED_RELAX_DOMAIN_LEVEL,
+	},
+
+	{
+		.name = "memory_migrate",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_MEMORY_MIGRATE,
+	},
+
+	{
+		.name = "memory_pressure",
+		.read_u64 = cpuset_read_u64,
+		.private = FILE_MEMORY_PRESSURE,
+	},
+
+	{
+		.name = "memory_spread_page",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_SPREAD_PAGE,
+	},
+
+	{
+		/* obsolete, may be removed in the future */
+		.name = "memory_spread_slab",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_SPREAD_SLAB,
+	},
+
+	{
+		.name = "memory_pressure_enabled",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_MEMORY_PRESSURE_ENABLED,
+	},
+
+	{ }	/* terminate */
+};
+
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6b150f9d7e95..903e7bab399a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1107,8 +1107,6 @@ enum partition_cmd {
 	partcmd_invalidate,	/* Make partition invalid	  */
 };
 
-static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
-		       int turning_on);
 static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 				    struct tmpmasks *tmp);
 
@@ -2703,7 +2701,7 @@ bool current_cpuset_is_being_rebound(void)
  * Call with cpuset_mutex held.
  */
 
-static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
+int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		       int turning_on)
 {
 	struct cpuset *trialcs;
@@ -3088,59 +3086,10 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
-static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
-			    u64 val)
-{
-	struct cpuset *cs = css_cs(css);
-	cpuset_filetype_t type = cft->private;
-	int retval = 0;
-
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-	if (!is_cpuset_online(cs)) {
-		retval = -ENODEV;
-		goto out_unlock;
-	}
-
-	switch (type) {
-	case FILE_CPU_EXCLUSIVE:
-		retval = update_flag(CS_CPU_EXCLUSIVE, cs, val);
-		break;
-	case FILE_MEM_EXCLUSIVE:
-		retval = update_flag(CS_MEM_EXCLUSIVE, cs, val);
-		break;
-	case FILE_MEM_HARDWALL:
-		retval = update_flag(CS_MEM_HARDWALL, cs, val);
-		break;
-	case FILE_SCHED_LOAD_BALANCE:
-		retval = update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
-		break;
-	case FILE_MEMORY_MIGRATE:
-		retval = update_flag(CS_MEMORY_MIGRATE, cs, val);
-		break;
-	case FILE_MEMORY_PRESSURE_ENABLED:
-		cpuset_memory_pressure_enabled = !!val;
-		break;
-	case FILE_SPREAD_PAGE:
-		retval = update_flag(CS_SPREAD_PAGE, cs, val);
-		break;
-	case FILE_SPREAD_SLAB:
-		retval = update_flag(CS_SPREAD_SLAB, cs, val);
-		break;
-	default:
-		retval = -EINVAL;
-		break;
-	}
-out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
-	return retval;
-}
-
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
-static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
+ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	struct cpuset *cs = css_cs(of_css(of));
@@ -3215,7 +3164,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
  * and since these maps can change value dynamically, one could read
  * gibberish by doing partial reads while a list was changing.
  */
-static int cpuset_common_seq_show(struct seq_file *sf, void *v)
+int cpuset_common_seq_show(struct seq_file *sf, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(sf));
 	cpuset_filetype_t type = seq_cft(sf)->private;
@@ -3256,37 +3205,6 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	return ret;
 }
 
-static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
-{
-	struct cpuset *cs = css_cs(css);
-	cpuset_filetype_t type = cft->private;
-	switch (type) {
-	case FILE_CPU_EXCLUSIVE:
-		return is_cpu_exclusive(cs);
-	case FILE_MEM_EXCLUSIVE:
-		return is_mem_exclusive(cs);
-	case FILE_MEM_HARDWALL:
-		return is_mem_hardwall(cs);
-	case FILE_SCHED_LOAD_BALANCE:
-		return is_sched_load_balance(cs);
-	case FILE_MEMORY_MIGRATE:
-		return is_memory_migrate(cs);
-	case FILE_MEMORY_PRESSURE_ENABLED:
-		return cpuset_memory_pressure_enabled;
-	case FILE_MEMORY_PRESSURE:
-		return fmeter_getrate(&cs->fmeter);
-	case FILE_SPREAD_PAGE:
-		return is_spread_page(cs);
-	case FILE_SPREAD_SLAB:
-		return is_spread_slab(cs);
-	default:
-		BUG();
-	}
-
-	/* Unreachable but makes gcc happy */
-	return 0;
-}
-
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
@@ -3350,113 +3268,6 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	return retval ?: nbytes;
 }
 
-/*
- * for the common functions, 'private' gives the type of file
- */
-
-static struct cftype legacy_files[] = {
-	{
-		.name = "cpus",
-		.seq_show = cpuset_common_seq_show,
-		.write = cpuset_write_resmask,
-		.max_write_len = (100U + 6 * NR_CPUS),
-		.private = FILE_CPULIST,
-	},
-
-	{
-		.name = "mems",
-		.seq_show = cpuset_common_seq_show,
-		.write = cpuset_write_resmask,
-		.max_write_len = (100U + 6 * MAX_NUMNODES),
-		.private = FILE_MEMLIST,
-	},
-
-	{
-		.name = "effective_cpus",
-		.seq_show = cpuset_common_seq_show,
-		.private = FILE_EFFECTIVE_CPULIST,
-	},
-
-	{
-		.name = "effective_mems",
-		.seq_show = cpuset_common_seq_show,
-		.private = FILE_EFFECTIVE_MEMLIST,
-	},
-
-	{
-		.name = "cpu_exclusive",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_CPU_EXCLUSIVE,
-	},
-
-	{
-		.name = "mem_exclusive",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_MEM_EXCLUSIVE,
-	},
-
-	{
-		.name = "mem_hardwall",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_MEM_HARDWALL,
-	},
-
-	{
-		.name = "sched_load_balance",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_SCHED_LOAD_BALANCE,
-	},
-
-	{
-		.name = "sched_relax_domain_level",
-		.read_s64 = cpuset_read_s64,
-		.write_s64 = cpuset_write_s64,
-		.private = FILE_SCHED_RELAX_DOMAIN_LEVEL,
-	},
-
-	{
-		.name = "memory_migrate",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_MEMORY_MIGRATE,
-	},
-
-	{
-		.name = "memory_pressure",
-		.read_u64 = cpuset_read_u64,
-		.private = FILE_MEMORY_PRESSURE,
-	},
-
-	{
-		.name = "memory_spread_page",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_SPREAD_PAGE,
-	},
-
-	{
-		/* obsolete, may be removed in the future */
-		.name = "memory_spread_slab",
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_SPREAD_SLAB,
-	},
-
-	{
-		.name = "memory_pressure_enabled",
-		.flags = CFTYPE_ONLY_ON_ROOT,
-		.read_u64 = cpuset_read_u64,
-		.write_u64 = cpuset_write_u64,
-		.private = FILE_MEMORY_PRESSURE_ENABLED,
-	},
-
-	{ }	/* terminate */
-};
-
 /*
  * This is currently a minimal set for the default hierarchy. It can be
  * expanded later on by migrating more features and control files from v1.
-- 
2.34.1


