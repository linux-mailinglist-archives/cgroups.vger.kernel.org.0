Return-Path: <cgroups+bounces-3661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C09304A5
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441BA1F219A5
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2444C8C;
	Sat, 13 Jul 2024 09:07:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3551B960;
	Sat, 13 Jul 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861671; cv=none; b=mirZ4RISdAhNeo/S8zV6XiLdp0pVnmiA1q/9ZvSVcBVi/3ygDIkXr6mhCGC1PtRPbpWWJTkaT+v8YxQ4jsHwMTBcLmPu3urfG6RLn8S8yQ7qIX+NzaJ0MSqo3K9HJDZ0VwKbE9pwlaROlkSB+t5HmAmdJqb/ubaUQ+Gevu0VCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861671; c=relaxed/simple;
	bh=DAc0LCoKc97LeuhxpZsAmFYJzmv0SdzD/etRfRJRSEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m+gEl32Y+f4pdcdrThfaCBwTMhGtVwuNTebvT6F56lHya9GBjvIvgxk3cVYtxnZO/6jRr7IT72wyZUYkhLyZIuklSOF9W5TNSndLR1aT5qfvsPgR9+OpP88qmMhbrWs6CEIuS7S4VIwN2kDu48oNVkjYHm0j0zkRLdYfQnnrATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WLjDz4ZPYzQl1c;
	Sat, 13 Jul 2024 17:03:47 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id AD560180088;
	Sat, 13 Jul 2024 17:07:46 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 17:07:46 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <longman@redhat.com>, <lizefan.x@bytedance.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: Remove cpuset_slab_spread_rotor
Date: Sat, 13 Jul 2024 08:59:16 +0000
Message-ID: <20240713085916.3373085-1-xiujianfeng@huawei.com>
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
 dggpeml500023.china.huawei.com (7.185.36.114)

Since the SLAB implementation was removed in v6.8, so the
cpuset_slab_spread_rotor is no longer used and can be removed.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/cpuset.h |  6 ------
 include/linux/sched.h  |  1 -
 kernel/cgroup/cpuset.c | 13 -------------
 kernel/fork.c          |  1 -
 4 files changed, 21 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index de4cf0ee96f7..2a6981eeebf8 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -113,7 +113,6 @@ extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *tsk);
 
 extern int cpuset_mem_spread_node(void);
-extern int cpuset_slab_spread_node(void);
 
 static inline int cpuset_do_page_mem_spread(void)
 {
@@ -246,11 +245,6 @@ static inline int cpuset_mem_spread_node(void)
 	return 0;
 }
 
-static inline int cpuset_slab_spread_node(void)
-{
-	return 0;
-}
-
 static inline int cpuset_do_page_mem_spread(void)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75138bf70da3..e151da1675fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1248,7 +1248,6 @@ struct task_struct {
 	/* Sequence number to catch updates: */
 	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
-	int				cpuset_slab_spread_rotor;
 #endif
 #ifdef CONFIG_CGROUPS
 	/* Control Group info protected by css_set_lock: */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..ba7f7f967565 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -5028,19 +5028,6 @@ int cpuset_mem_spread_node(void)
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
-/**
- * cpuset_slab_spread_node() - On which node to begin search for a slab page
- */
-int cpuset_slab_spread_node(void)
-{
-	if (current->cpuset_slab_spread_rotor == NUMA_NO_NODE)
-		current->cpuset_slab_spread_rotor =
-			node_random(&current->mems_allowed);
-
-	return cpuset_spread_node(&current->cpuset_slab_spread_rotor);
-}
-EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
-
 /**
  * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
  * @tsk1: pointer to task_struct of some task.
diff --git a/kernel/fork.c b/kernel/fork.c
index 08e13b919d80..559e8df1672a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2313,7 +2313,6 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
-	p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
 	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.34.1


