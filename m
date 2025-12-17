Return-Path: <cgroups+bounces-12422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A209CC6B7B
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A25F930088E5
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206813385A7;
	Wed, 17 Dec 2025 09:04:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06A33B94B;
	Wed, 17 Dec 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962293; cv=none; b=f9s7aM/sRF6YyURpHFvAd4nTVY68SjKHFF4bIScZvrv91GLY2JkKN3Dog+ixGbVE6Uq2fumF+3PHUNPhpaWSY1UmEJYs/s+Pxhi7LZi3WkGDPpxUhahXClwDmMwCW5pv4HxZNXydDum+cSAhdx34qYzN7CYNukylzzd2L7nNFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962293; c=relaxed/simple;
	bh=4nWJI8tRYu5Iat/NIOHpqLp1IJCwosnDDk2mrwaZr6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CIsWzWusYI00Rn/LtllUyjMZsu2hscIkQC/D4N5anD0DaTs4DM0WMc+YvPvHiB59QTiWfQC6SCAG3RElR9uKLLft0I9gxWJljVrlSR7NhShAj2PdP1NtEjDyrCnpcEYmNiN3hWWJlQv4QwozxBpMUohWx2bKJ5i5bV4H3ANeAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWSXd3c88zYQvFy;
	Wed, 17 Dec 2025 17:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24EF240570;
	Wed, 17 Dec 2025 17:04:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvcackJp5AL6AQ--.18103S5;
	Wed, 17 Dec 2025 17:04:44 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next 3/6] cpuset: add cpuset1_init helper for v1 initialization
Date: Wed, 17 Dec 2025 08:49:39 +0000
Message-Id: <20251217084942.2666405-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217084942.2666405-1-chenridong@huaweicloud.com>
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHNvcackJp5AL6AQ--.18103S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAry5ZF15Zr15CFWkCr17ZFb_yoWrCryfpF
	y8Ca4Ut3y5JF1xu34kA3yDu393Kwn7tFy7Kr98K34rXF47tF4UuF1kXwn8Zry5tFWDur43
	ZFs2yw43uF1qyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9J5rUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch introduces the cpuset1_init helper in cpuset_v1.c to initialize
v1-specific fields, including the fmeter and relax_domain_level members.

The relax_domain_level related code will be moved to cpuset_v1.c in a
subsequent patch. After this move, v1-specific members will only be
visible when CONFIG_CPUSETS_V1=y.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h | 10 ++++++----
 kernel/cgroup/cpuset-v1.c       |  7 ++++++-
 kernel/cgroup/cpuset.c          |  4 ++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 6c03cad02302..a32517da8231 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -144,8 +144,6 @@ struct cpuset {
 	 */
 	nodemask_t old_mems_allowed;
 
-	struct fmeter fmeter;		/* memory_pressure filter */
-
 	/*
 	 * Tasks are being attached to this cpuset.  Used to prevent
 	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
@@ -181,6 +179,10 @@ struct cpuset {
 
 	/* Used to merge intersecting subsets for generate_sched_domains */
 	struct uf_node node;
+
+#ifdef CONFIG_CPUSETS_V1
+	struct fmeter fmeter;		/* memory_pressure filter */
+#endif
 };
 
 static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
@@ -285,7 +287,6 @@ void cpuset_full_unlock(void);
  */
 #ifdef CONFIG_CPUSETS_V1
 extern struct cftype cpuset1_files[];
-void fmeter_init(struct fmeter *fmp);
 void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk);
 void cpuset1_update_tasks_flags(struct cpuset *cs);
@@ -293,9 +294,9 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
+void cpuset1_init(struct cpuset *cs);
 void cpuset1_online_css(struct cgroup_subsys_state *css);
 #else
-static inline void fmeter_init(struct fmeter *fmp) {}
 static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk) {}
 static inline void cpuset1_update_tasks_flags(struct cpuset *cs) {}
@@ -304,6 +305,7 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    bool cpus_updated, bool mems_updated) {}
 static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
+static inline void cpuset1_init(struct cpuset *cs) {}
 static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
 #endif /* CONFIG_CPUSETS_V1 */
 
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 650028ee250b..574df740f21a 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -62,7 +62,7 @@ struct cpuset_remove_tasks_struct {
 #define FM_SCALE 1000		/* faux fixed point scale */
 
 /* Initialize a frequency meter */
-void fmeter_init(struct fmeter *fmp)
+static void fmeter_init(struct fmeter *fmp)
 {
 	fmp->cnt = 0;
 	fmp->val = 0;
@@ -499,6 +499,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
+void cpuset1_init(struct cpuset *cs)
+{
+	fmeter_init(&cs->fmeter);
+}
+
 void cpuset1_online_css(struct cgroup_subsys_state *css)
 {
 	struct cpuset *tmp_cs;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f74da3086120..e836a1f2b951 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3602,7 +3602,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 
 	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
-	fmeter_init(&cs->fmeter);
+	cpuset1_init(cs);
 	cs->relax_domain_level = -1;
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
@@ -3836,7 +3836,7 @@ int __init cpuset_init(void)
 	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
 
-	fmeter_init(&top_cpuset.fmeter);
+	cpuset1_init(&top_cpuset);
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-- 
2.34.1


