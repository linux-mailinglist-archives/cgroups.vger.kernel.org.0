Return-Path: <cgroups+bounces-3481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65591ECFF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4817C1C222EC
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5E101E4;
	Tue,  2 Jul 2024 02:35:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67750171BA;
	Tue,  2 Jul 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887711; cv=none; b=Yb7Zs0KoDXUxNaFHkf7EmPRP/mkdBycVzi9gpRxOKgr+Buv3W4AnUFc19YX2PmLJsr/aGOp0bQRKQHx0eiunI+EGkB/Xm3elq8dDTJxqN/6HMu0YKxrQNhIxGATOJPOn4F/dBLtinEwhAe5f6pXz7RGq1wZcGXOG/rnV0VfQHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887711; c=relaxed/simple;
	bh=duOE5/WUTmEt2OMV+3Ya1x3dxJYEKTpX14cmRqn2wUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nH/H6NqleSJFrIJT/aWbV7NX5KFWb+44B6GXNF5L1sXgjoBXRZaWE1p/aJwH+mihTisVDR7srzYqSoGDuGVzmiAxBLwENhC6fYBE3rwtkP957TdBD9f3GUSlkri0Me1RMIW6OlXNhfUzX8boc4mM5QuJ6d/Tz9Ln7u+WkbZIHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WCn2L3q1Qz1T4gb;
	Tue,  2 Jul 2024 10:30:34 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 17DA518007E;
	Tue,  2 Jul 2024 10:35:06 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 2 Jul
 2024 10:35:05 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup/rstat: add force idle show helper
Date: Tue, 2 Jul 2024 02:28:22 +0000
Message-ID: <20240702022822.1032693-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)

In the function cgroup_base_stat_cputime_show, there are five
instances of #ifdef, which makes the code not concise.
To address this, add the function cgroup_force_idle_show
to make the code more succinct.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/rstat.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..22bb4e9050f0 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -594,49 +594,47 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 	}
 }
 
+
+static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
+{
+#ifdef CONFIG_SCHED_CORE
+	u64 forceidle_time = bstat->forceidle_sum;
+
+	do_div(forceidle_time, NSEC_PER_USEC);
+	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+#endif
+}
+
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 	u64 usage, utime, stime;
 	struct cgroup_base_stat bstat;
-#ifdef CONFIG_SCHED_CORE
-	u64 forceidle_time;
-#endif
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
-#ifdef CONFIG_SCHED_CORE
-		forceidle_time = cgrp->bstat.forceidle_sum;
-#endif
+		bstat = cgrp->bstat;
 		cgroup_rstat_flush_release(cgrp);
 	} else {
 		root_cgroup_cputime(&bstat);
 		usage = bstat.cputime.sum_exec_runtime;
 		utime = bstat.cputime.utime;
 		stime = bstat.cputime.stime;
-#ifdef CONFIG_SCHED_CORE
-		forceidle_time = bstat.forceidle_sum;
-#endif
 	}
 
 	do_div(usage, NSEC_PER_USEC);
 	do_div(utime, NSEC_PER_USEC);
 	do_div(stime, NSEC_PER_USEC);
-#ifdef CONFIG_SCHED_CORE
-	do_div(forceidle_time, NSEC_PER_USEC);
-#endif
 
 	seq_printf(seq, "usage_usec %llu\n"
 		   "user_usec %llu\n"
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 
-#ifdef CONFIG_SCHED_CORE
-	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
-#endif
+	cgroup_force_idle_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.34.1


