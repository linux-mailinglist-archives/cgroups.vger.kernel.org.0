Return-Path: <cgroups+bounces-3466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2B91E1F6
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6521F2447D
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A216191E;
	Mon,  1 Jul 2024 14:11:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E23161339;
	Mon,  1 Jul 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843090; cv=none; b=ePoBcWsL3v6ArjKF7SlFTmkEw3y7/3eb/z24HNPQoC9spa9TDF148/gvEU9mjJ3rJVt7KltsUSvheW8DnbZI6bJaARPrYYjPeAkBrV9jrAdCAJwPBoWejCrol0krST9fJetyhG0IaGFvz7rtIjt/hZNzEkUPRBv4cRPsmlfzWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843090; c=relaxed/simple;
	bh=HAYSc1fN3J1cGo99xve+VO+idll9USDAhnBes8HToUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzeclwfOjQWathOEVx8jKJdq274WPez6wGgQOdf2QnAvdLkDY5OM+iYIe/epgoUZXsmBOY+jTQhwjq46px3jvEk5J/KcbEOg3j7oPx+x1BuV1IzHmWZes3YBy56qgrTjZZ4eCkzzrNNcg/pK2ievCOr5Z0lgqm+sr6zAGjxiDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WCSXL59DhzxTn2;
	Mon,  1 Jul 2024 22:06:58 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD8318006C;
	Mon,  1 Jul 2024 22:11:24 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 1 Jul
 2024 22:11:23 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/rstat: add force idle show helper
Date: Mon, 1 Jul 2024 14:04:41 +0000
Message-ID: <20240701140441.721997-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

In the function cgroup_base_stat_cputime_show, there are five
instances of #ifdef, which makes the code not concise.
To address this, add the function cgroup_force_idle_show
to make the code more succinct.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/rstat.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..71a887a051a6 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -594,40 +594,39 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 	}
 }
 
+#ifdef CONFIG_SCHED_CORE
+static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat bstat)
+{
+	u64 forceidle_time = bstat.forceidle_sum;
+
+	do_div(forceidle_time, NSEC_PER_USEC);
+	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+}
+#endif
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
+		stat = cgrp->bstat;
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
@@ -635,7 +634,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   usage, utime, stime);
 
 #ifdef CONFIG_SCHED_CORE
-	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+	cgroup_force_idle_show(seq, bstat);
 #endif
 }
 
-- 
2.34.1


