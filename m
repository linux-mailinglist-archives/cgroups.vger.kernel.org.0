Return-Path: <cgroups+bounces-3542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5129277C6
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD135281AB9
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455431AED5A;
	Thu,  4 Jul 2024 14:08:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6701ABC25;
	Thu,  4 Jul 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102091; cv=none; b=cx0g6UfyiG1IF/wQ+6TVmqHYMpppipA79A5DClrpye+kxrb1IFpDxcVFleSZsTq6TJoV1zURayI0sQwMP6o1/z2wanFHbUVA2XZ6siJxNfHgwyH+PWLRxbeYLxGhJ62XalM6Qo0DdeTOjfvZAqGzKKDd1AEcIL1EK5zvmiJjwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102091; c=relaxed/simple;
	bh=5vauRKs+mI0HCOqYXSQH5t3rrarEc79hnDKBjFJzNNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMnbZDswAcVYZjTD8bOYQzZjB+DvCO/DHmbMp+t8Jk48h0xK6ZfO32m8WWA1mixIrgzMKFDIT4xITlaCiMnAiNdWcOcS9uP/ybNy2dHNmZvwixxklOQpFMAvAwHAJCM5OfxCRk+Wi7NJf+ta3MtMqgSs8Iv4iFoK1YIAZT7m19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WFJPs288yznYT3;
	Thu,  4 Jul 2024 22:07:45 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id DD69C140417;
	Thu,  4 Jul 2024 22:08:03 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 4 Jul
 2024 22:08:03 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 -next] cgroup/rstat: add force idle show helper
Date: Thu, 4 Jul 2024 14:01:19 +0000
Message-ID: <20240704140119.1423196-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
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

In the function cgroup_base_stat_cputime_show, there are five
instances of #ifdef, which makes the code not concise.
To address this, add the function cgroup_force_idle_show
to make the code more succinct.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/rstat.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..a06b45272411 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -594,49 +594,46 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
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
-	struct cgroup_base_stat bstat;
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
 		cgroup_rstat_flush_release(cgrp);
 	} else {
-		root_cgroup_cputime(&bstat);
-		usage = bstat.cputime.sum_exec_runtime;
-		utime = bstat.cputime.utime;
-		stime = bstat.cputime.stime;
-#ifdef CONFIG_SCHED_CORE
-		forceidle_time = bstat.forceidle_sum;
-#endif
+		/* cgrp->bstat of root is not actually used, reuse it */
+		root_cgroup_cputime(&cgrp->bstat);
+		usage = cgrp->bstat.cputime.sum_exec_runtime;
+		utime = cgrp->bstat.cputime.utime;
+		stime = cgrp->bstat.cputime.stime;
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
+	cgroup_force_idle_show(seq, &cgrp->bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-- 
2.34.1


