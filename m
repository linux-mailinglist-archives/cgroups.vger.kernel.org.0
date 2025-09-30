Return-Path: <cgroups+bounces-10496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73815BAC5D2
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA49321079
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE722F6181;
	Tue, 30 Sep 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="23ROBQGn"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C32F49E9;
	Tue, 30 Sep 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225911; cv=none; b=tlaRP8xQ6jrjLZgPBu/gmmOLgLTjL8qI1/XlYI0n/oRDMJuYTJ2+ppVzcpK243z6faOmc23D5wEKi6ThHcuVG+oMNCZF73qeb1Zx8FOfQ72g/rDQm6L7lyaY9MG3xqbDxyorszwTMtn3O1KKBgzapjDGft3vp0MlEEfQi5qaY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225911; c=relaxed/simple;
	bh=x7Id5DG1Gvh1nnM7iNE69cNV11ZPlgRAvu1SfoGs8Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2qzQ0xqSBrdP4nktPEeI75Nqhf0FN2el98E+vIjCpS+DmjNddjRYserd5SoosM5r0cNRfJwSxfQn+fg7zr4oMFs/ZCakXnoo+kJKEjA1geB0m6IBSD4pwQrg5pYrMFCfuS/RTIpJ86Z7LtjMOoLm2rrbFs8YkQxdjk57lKg2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=23ROBQGn; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AVQPy+HohPr3jU4NpICUKr1ZYJBDFO9T4nJPPnVLWA4=;
	b=23ROBQGnTjBadUVzvPVBuUuqVjClyAv93Tub6pi3KFnV/cvtwxZLYHcyAzFbJpz93fbkDsEnI
	wH+LIuJr9S1NxSZoCiZfTb9E11+Q2keFnJ93zImr4a2QjyFuorTlGsCdbbY0IYakJPWfFCw8r48
	UL3Xnkr6ZTdX+wci9Y61WmQ=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cbYGr41fhzpT0Q;
	Tue, 30 Sep 2025 17:51:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 75BE51402F6;
	Tue, 30 Sep 2025 17:51:45 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:45 +0800
Received: from hulk-cxc.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:51:44 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <llong@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>, <caixinchen1@huawei.com>
Subject: [PATCH -next RFC 1/2] cpuset: Move cpuset1_update_spread_flag to cpuset
Date: Tue, 30 Sep 2025 09:35:51 +0000
Message-ID: <20250930093552.2842885-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200017.china.huawei.com (7.202.195.228)

To add cpuset.mems.spread_flag to cgroup v2
Move cpuset1_update_spread_flag to cpuset.c
Remove check for cgroup v2 and remove memory_spread_slab update
because it is useless now.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  6 ++----
 kernel/cgroup/cpuset-v1.c       | 25 +------------------------
 kernel/cgroup/cpuset.c          | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 337608f408ce..1cd1795729c7 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -273,6 +273,8 @@ void cpuset_callback_unlock_irq(void);
 void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
 void cpuset_update_tasks_nodemask(struct cpuset *cs);
 int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on);
+void cpuset_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk);
 ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off);
 int cpuset_common_seq_show(struct seq_file *sf, void *v);
@@ -285,8 +287,6 @@ void cpuset_full_unlock(void);
 #ifdef CONFIG_CPUSETS_V1
 extern struct cftype cpuset1_files[];
 void fmeter_init(struct fmeter *fmp);
-void cpuset1_update_task_spread_flags(struct cpuset *cs,
-					struct task_struct *tsk);
 void cpuset1_update_tasks_flags(struct cpuset *cs);
 void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
@@ -294,8 +294,6 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
 #else
 static inline void fmeter_init(struct fmeter *fmp) {}
-static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
-					struct task_struct *tsk) {}
 static inline void cpuset1_update_tasks_flags(struct cpuset *cs) {}
 static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..bcd20f198a0d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -203,29 +203,6 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
-/*
- * update task's spread flag if cpuset's page/slab spread flag is set
- *
- * Call with callback_lock or cpuset_mutex held. The check can be skipped
- * if on default hierarchy.
- */
-void cpuset1_update_task_spread_flags(struct cpuset *cs,
-					struct task_struct *tsk)
-{
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
-		return;
-
-	if (is_spread_page(cs))
-		task_set_spread_page(tsk);
-	else
-		task_clear_spread_page(tsk);
-
-	if (is_spread_slab(cs))
-		task_set_spread_slab(tsk);
-	else
-		task_clear_spread_slab(tsk);
-}
-
 /**
  * cpuset1_update_tasks_flags - update the spread flags of tasks in the cpuset.
  * @cs: the cpuset in which each task's spread flags needs to be changed
@@ -241,7 +218,7 @@ void cpuset1_update_tasks_flags(struct cpuset *cs)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		cpuset1_update_task_spread_flags(cs, task);
+		cpuset_update_task_spread_flags(cs, task);
 	css_task_iter_end(&it);
 }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..3a0d443180c6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3205,7 +3205,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
 	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
-	cpuset1_update_task_spread_flags(cs, task);
+	cpuset_update_task_spread_flags(cs, task);
 }
 
 static void cpuset_attach(struct cgroup_taskset *tset)
@@ -3447,6 +3447,20 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	return retval ?: nbytes;
 }
 
+/*
+ * update task's spread flag if cpuset's page spread flag is set
+ *
+ * Call with callback_lock or cpuset_mutex held.
+ */
+void cpuset_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk)
+{
+	if (is_spread_page(cs))
+		task_set_spread_page(tsk);
+	else
+		task_clear_spread_page(tsk);
+}
+
 /*
  * This is currently a minimal set for the default hierarchy. It can be
  * expanded later on by migrating more features and control files from v1.
-- 
2.34.1


