Return-Path: <cgroups+bounces-4415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7395CA06
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF028184F
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE9185B69;
	Fri, 23 Aug 2024 10:09:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE017E01E;
	Fri, 23 Aug 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407740; cv=none; b=A9j9u6YvNpLqgMjrijEQJ+3o82dZlvKq2A3AySWTJUQREK5xm0WIRTd5Yw33o2EO9ww+2+QdTeqBHDGF+J7aSg+VWAJZajrWqhZnxsdErMWPXlqNRK3ZRft5K6yA2pkHIiG/NvmxJNQw3cIPNN4ORJeMHQn1WEOMf//CAQXIseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407740; c=relaxed/simple;
	bh=5aPAk+Ngn87cPfNAlR/o+65FiDgX8uU/2SWXYcoKOR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHEUklYObuegDr7mJIH2tbUcB7Gujy4li5nUVN4gtmOxFKxVzY0spdg+5o39/hJR4wVYKNx55ZZ5cK2/iEMs6MJXlbfGCscZ0UCfaximikZHNrDHkB2Ewmdn3eUqQ9HlARrurHHQPyIpNQIcylfnKzfh+tLrSddV6um8D2U8b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WqwkQ5fNWz13w3M;
	Fri, 23 Aug 2024 18:08:14 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 54A59140155;
	Fri, 23 Aug 2024 18:08:56 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:55 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 05/11] cgroup/cpuset: move memory_spread to cpuset-v1.c
Date: Fri, 23 Aug 2024 10:01:04 +0000
Message-ID: <20240823100110.472120-6-chenridong@huawei.com>
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

'memory_spread' is only set in cpuset v1. move corresponding code into
cpuset-v1.c.

Currently, 'cpuset_update_task_spread_flags' and 'update_tasks_flags' are
exposed to cpuset.c.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  3 +++
 kernel/cgroup/cpuset-v1.c       | 42 +++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 42 ---------------------------------
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 634152630ab5..e5ab71d9d06f 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -248,5 +248,8 @@ int fmeter_getrate(struct fmeter *fmp);
 int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 			    s64 val);
 s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft);
+void cpuset_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk);
+void update_tasks_flags(struct cpuset *cs);
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 175638f2e7b7..320abd4bf2c3 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -195,3 +195,45 @@ s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
+/*
+ * update task's spread flag if cpuset's page/slab spread flag is set
+ *
+ * Call with callback_lock or cpuset_mutex held. The check can be skipped
+ * if on default hierarchy.
+ */
+void cpuset_update_task_spread_flags(struct cpuset *cs,
+					struct task_struct *tsk)
+{
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		return;
+
+	if (is_spread_page(cs))
+		task_set_spread_page(tsk);
+	else
+		task_clear_spread_page(tsk);
+
+	if (is_spread_slab(cs))
+		task_set_spread_slab(tsk);
+	else
+		task_clear_spread_slab(tsk);
+}
+
+/**
+ * update_tasks_flags - update the spread flags of tasks in the cpuset.
+ * @cs: the cpuset in which each task's spread flags needs to be changed
+ *
+ * Iterate through each task of @cs updating its spread flags.  As this
+ * function is called with cpuset_mutex held, cpuset membership stays
+ * stable.
+ */
+void update_tasks_flags(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+	while ((task = css_task_iter_next(&it)))
+		cpuset_update_task_spread_flags(cs, task);
+	css_task_iter_end(&it);
+}
+
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 552a190f553e..2b588ea47079 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -401,29 +401,6 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
 }
 
-/*
- * update task's spread flag if cpuset's page/slab spread flag is set
- *
- * Call with callback_lock or cpuset_mutex held. The check can be skipped
- * if on default hierarchy.
- */
-static void cpuset_update_task_spread_flags(struct cpuset *cs,
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
 /*
  * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
  *
@@ -2788,25 +2765,6 @@ bool current_cpuset_is_being_rebound(void)
 	return ret;
 }
 
-/**
- * update_tasks_flags - update the spread flags of tasks in the cpuset.
- * @cs: the cpuset in which each task's spread flags needs to be changed
- *
- * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_mutex held, cpuset membership stays
- * stable.
- */
-static void update_tasks_flags(struct cpuset *cs)
-{
-	struct css_task_iter it;
-	struct task_struct *task;
-
-	css_task_iter_start(&cs->css, 0, &it);
-	while ((task = css_task_iter_next(&it)))
-		cpuset_update_task_spread_flags(cs, task);
-	css_task_iter_end(&it);
-}
-
 /*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:		the bit to update (see cpuset_flagbits_t)
-- 
2.34.1


