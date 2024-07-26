Return-Path: <cgroups+bounces-3904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CD93CC44
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 03:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3447A1F218DA
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426BA34;
	Fri, 26 Jul 2024 01:12:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0CB662;
	Fri, 26 Jul 2024 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956336; cv=none; b=Tk/7dpexvzBwnxOuo7qcvYKiGd5Iqvt//18dKZDLQU4nWvWNPrhvNTStJTjmLbOgrqoCbb7O+6T5ksyPVAuFsGX2Q8dcG3MjewAg4wdCxKjf81Nyf4O8hrRWNzONj0Ie/bIqksVTGqv0GKcTVH0WaISYj9pKHsnTPZr99d/CFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956336; c=relaxed/simple;
	bh=d5Hj+nrO74nTVvvjKvO/ZB1w8fGxAzGorbFlfqvUFs8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSvV08HSfyZ3GWHPI1vgC/n0sekb20Y2ffXDvkbqI7G0aJUGMeleGglxj4pJcjRQ1Klq2xcmE9985qM4K4WSlZUxDjLoTkTprctswuI12bE6v+ePDOUef4dLzOeov6dG1DEvketB7s9PRrYdi8XX/w8mptVX1kEDvZTLYOOd6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WVV6l2rMnzMrG2;
	Fri, 26 Jul 2024 09:10:23 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 486E0180AE3;
	Fri, 26 Jul 2024 09:12:11 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 26 Jul
 2024 09:12:10 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup/cpuset: add decrease attach_in_progress helpers
Date: Fri, 26 Jul 2024 01:05:02 +0000
Message-ID: <20240726010502.2226806-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

There are several functions to decrease attach_in_progress, and they
will wake up cpuset_attach_wq when attach_in_progress is zero. So,
add a helper to make it concise.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d4322619e59a..fa0c2fc5d383 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -490,6 +490,26 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 	}
 }
 
+/*
+ * decrease cs->attach_in_progress.
+ * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
+ */
+static inline void dec_attach_in_progress_locked(struct cpuset *cs)
+{
+	lockdep_assert_held(&cpuset_mutex);
+
+	cs->attach_in_progress--;
+	if (!cs->attach_in_progress)
+		wake_up(&cpuset_attach_wq);
+}
+
+static inline void dec_attach_in_progress(struct cpuset *cs)
+{
+	mutex_lock(&cpuset_mutex);
+	dec_attach_in_progress_locked(cs);
+	mutex_unlock(&cpuset_mutex);
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -3421,9 +3441,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
+	dec_attach_in_progress_locked(cs);
 
 	if (cs->nr_migrate_dl_tasks) {
 		int cpu = cpumask_any(cs->effective_cpus);
@@ -3538,9 +3556,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		reset_migrate_dl_data(cs);
 	}
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
+	dec_attach_in_progress_locked(cs);
 
 	mutex_unlock(&cpuset_mutex);
 }
@@ -4283,11 +4299,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
 	if (same_cs)
 		return;
 
-	mutex_lock(&cpuset_mutex);
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
-	mutex_unlock(&cpuset_mutex);
+	dec_attach_in_progress(cs);
 }
 
 /*
@@ -4319,10 +4331,7 @@ static void cpuset_fork(struct task_struct *task)
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
-
+	dec_attach_in_progress_locked(cs);
 	mutex_unlock(&cpuset_mutex);
 }
 
-- 
2.34.1


