Return-Path: <cgroups+bounces-3890-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1D93BA79
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 04:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CE41C217BC
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE14687;
	Thu, 25 Jul 2024 02:03:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C26AB9;
	Thu, 25 Jul 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872986; cv=none; b=amaFYAkA7EQq/ULitZ5fStEq0ouNQNwawFIDTknQVXvteGKQ0DaMgGM0kF7LeavLjcFiyiUJA2H6ZXhzZRHnhWmXOcMCAZbik5pDwQVRIgeAQvlKAKH3Csaqp/LUa61VR2kfu5cKzgdveKWbfbkk5Fg+k5Ioah5IpTBEVlR+Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872986; c=relaxed/simple;
	bh=zXJ/qunW4eTuu4JM78B4WR0/s8Z3lBRbGXhSXku0/FY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utugRMbHEBTHTFjq/2b7fxa+reBQb1Z6XzdLrRaGKBGix1bWSeelEyoOQbfSNJQKivOpPEkfXx0PoDcR0Kd7ST6hE6aDCXafHYaU9vG2yYquJNEQgRqKlQnTDb/8vsnBShF3cLLxAekctkT3XBywvkwuC35iwiqm3YkXEoydMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WTvJx6pzPzncP4;
	Thu, 25 Jul 2024 10:02:09 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id B02AB18006C;
	Thu, 25 Jul 2024 10:02:59 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 25 Jul
 2024 10:02:59 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: add dec_attach_in_progress helper
Date: Thu, 25 Jul 2024 01:55:51 +0000
Message-ID: <20240725015551.2221867-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
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

There are several functions to decrease attach_in_progress, and they
will wake up cpuset_attach_wq when attach_in_progress is zero. So,
add a helper to make it concise.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d4322619e59a..c241845694ac 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -490,6 +490,17 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 	}
 }
 
+/*
+ * decrease cs->attach_in_progress.
+ * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
+ */
+static inline void dec_attach_in_progress(struct cpuset *cs)
+{
+	cs->attach_in_progress--;
+	if (!cs->attach_in_progress)
+		wake_up(&cpuset_attach_wq);
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -3421,9 +3432,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
+	dec_attach_in_progress(cs);
 
 	if (cs->nr_migrate_dl_tasks) {
 		int cpu = cpumask_any(cs->effective_cpus);
@@ -3538,9 +3547,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		reset_migrate_dl_data(cs);
 	}
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
+	dec_attach_in_progress(cs);
 
 	mutex_unlock(&cpuset_mutex);
 }
@@ -4284,9 +4291,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
 		return;
 
 	mutex_lock(&cpuset_mutex);
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
+	dec_attach_in_progress(cs);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -4319,10 +4324,7 @@ static void cpuset_fork(struct task_struct *task)
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
-		wake_up(&cpuset_attach_wq);
-
+	dec_attach_in_progress(cs);
 	mutex_unlock(&cpuset_mutex);
 }
 
-- 
2.34.1


