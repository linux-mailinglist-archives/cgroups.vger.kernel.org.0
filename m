Return-Path: <cgroups+bounces-4480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A995FD96
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 00:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EB51C21F37
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 22:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6519DF8C;
	Mon, 26 Aug 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A830W9ND"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1819DF6A;
	Mon, 26 Aug 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713110; cv=none; b=jifTco0yZhfzK17r5gUHio0GOsYZh5fmel2RAixtC7yqZ+aibzdiRHwFChxvqcHGBSXIDQOICRlX1T74wXSBgGziBjEK8XgkfXUM0u5pJrBcMCwz9kcwkAYjo7QED46Gelv1dLWmQVYYCRiA2vS09m5m24L/BcR/BHBNqDtAENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713110; c=relaxed/simple;
	bh=gV7sIRHEaSAiBoRmt+aS1DRnBxd+koYSvkRNXRiUBjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3N2XrfpXcHMzw2YYvrYBSQSFXRy8NzJJf9YjPPBmxQmabcuunsdr3r0voYM9816U3pwL260Ab875aC6Qu3oPKXc/3XNNUVYzRMymSeuD+7WRlI3JVXpD2fJQ0ZPWylJgHCqiwbt8p3uYjsfYu6sfeaOEJirsaj/xdeh60HtwEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A830W9ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DFC8B7AF;
	Mon, 26 Aug 2024 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724713110;
	bh=gV7sIRHEaSAiBoRmt+aS1DRnBxd+koYSvkRNXRiUBjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A830W9NDnnZVopRZEYOu85Gywn8obE/B3WAUShB+I1ASUzYBDZAVGmyl+PbH5R92I
	 dm2bajioP094Y/z6x+VuSh02K55RijmkGQTfjKEyUnAhr6a12CYLBkGqbr60IoioE8
	 FIWY4rvN3mETbfXmG6b3hJw8J5Ns/UpZLhKtw8CugID0h2hWdOO8cOixqSNjmw9zvW
	 xR1dMKydebEhrQcOIeEyb+G42dRWeOsLy9DAVzBetgUv5mQR35/l9vKcBNFN60vYL9
	 lzO0TEb0m1SK8Y0Dh3lA9E4Ipfm7nZVIqgqPi5w3TWFZ8D4l/kLzkDaEtPHubPF0Yw
	 JYV+dIfYXQ/yw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] sched: Introduce CONFIG_GROUP_SCHED_WEIGHT
Date: Mon, 26 Aug 2024 12:57:41 -1000
Message-ID: <20240826225822.791578-4-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext will soon add cgroup cpu.weigh support. The cgroup interface code
is currently gated behind CONFIG_FAIR_GROUP_SCHED. As the fair class and/or
SCX may implement the feature, put the interface code behind the new
CONFIG_CGROUP_SCHED_WEIGHT which is selected by CONFIG_FAIR_GROUP_SCHED.
This allows either sched class to enable the itnerface code without ading
more complex CONFIG tests.

When !CONFIG_FAIR_GROUP_SCHED, a dummy version of sched_group_set_shares()
is added to support later CONFIG_CGROUP_SCHED_WEIGHT &&
!CONFIG_FAIR_GROUP_SCHED builds.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 init/Kconfig         |  4 ++++
 kernel/sched/core.c  | 14 +++++++-------
 kernel/sched/sched.h |  4 +++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a465ea9525bd..84332d3594d0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1024,9 +1024,13 @@ menuconfig CGROUP_SCHED
 	  tasks.
 
 if CGROUP_SCHED
+config GROUP_SCHED_WEIGHT
+	def_bool n
+
 config FAIR_GROUP_SCHED
 	bool "Group scheduling for SCHED_OTHER"
 	depends on CGROUP_SCHED
+	select GROUP_SCHED_WEIGHT
 	default CGROUP_SCHED
 
 config CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4de62872a346..5cdf7b6a40f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9208,7 +9208,7 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
 	return scale_load_down(tg->shares);
@@ -9227,6 +9227,7 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 {
 	return tg_weight(css_tg(css));
 }
+#endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
@@ -9572,7 +9573,6 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
-#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
@@ -9600,7 +9600,7 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
@@ -9615,7 +9615,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 #endif
 
 static struct cftype cpu_legacy_files[] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
 		.name = "shares",
 		.read_u64 = cpu_shares_read_u64,
@@ -9725,7 +9725,7 @@ static int cpu_local_stat_show(struct seq_file *sf,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
@@ -9779,7 +9779,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
-#endif
+#endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
 						  long period, long quota)
@@ -9839,7 +9839,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 static struct cftype cpu_files[] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 07333c545ddc..b471fcd5950c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -484,7 +484,7 @@ struct task_group {
 
 };
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
 /*
@@ -576,6 +576,8 @@ extern void set_task_rq_fair(struct sched_entity *se,
 static inline void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next) { }
 #endif /* CONFIG_SMP */
+#else /* !CONFIG_FAIR_GROUP_SCHED */
+static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
-- 
2.46.0


