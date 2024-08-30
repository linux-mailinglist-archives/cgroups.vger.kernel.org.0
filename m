Return-Path: <cgroups+bounces-4612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BCB965E0B
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CCDB213E1
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAE188A3C;
	Fri, 30 Aug 2024 10:10:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21B17B519;
	Fri, 30 Aug 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012626; cv=none; b=TLSc5NQAcOquC/px1hrjJLRIyJPkmKUmyLcD5N0JqwRpH3hv6pD5Q03FGb37YN4J6tWrQ2ZgnM0r8RMT4VSCQe8zL9F6SMZycuUpMZBvUEVdT3YGM4PtjBy7l7XYw6cxqx6QLnfj/ZsqEE5WSpQde1LPTPGW6hNeiailAXUpJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012626; c=relaxed/simple;
	bh=mT+yLokB11/Kfjm1yH0B+Yo4vpPzCV+366q6bCf47qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN0VIvaLT09ZO/De6wlj+cUcaKB/vlei0qDpbXvOBEHT9318Sy0rWb6HN7+pYSOJY98hYH3c7ZVtRGYVI4plhvfDU8Nf4UEaw4qU22W4xtS4eCaNRNJ9RxAbF321T2K86sh6cqOgrDgZILJQki5VnztF91u/y8TRjt+/WorOGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WwDRN1V9dz1S9Vm;
	Fri, 30 Aug 2024 18:10:08 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 82DB2140360;
	Fri, 30 Aug 2024 18:10:21 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:20 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 05/12] cgroup/cpuset: move memory_spread to cpuset-v1.c
Date: Fri, 30 Aug 2024 10:02:22 +0000
Message-ID: <20240830100229.953012-6-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
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
index 1058a45f05ec..02c4b0c74fa9 100644
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
index c7b321029cbb..ca973b4de38a 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -194,3 +194,45 @@ s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	/* Unreachable but makes gcc happy */
 	return 0;
 }
+
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
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 45031a17e068..0a3347e4dddc 100644
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


