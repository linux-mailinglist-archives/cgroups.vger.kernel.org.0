Return-Path: <cgroups+bounces-12424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB0DCC6B81
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743943043A9E
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13633D4EC;
	Wed, 17 Dec 2025 09:04:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A233B6FF;
	Wed, 17 Dec 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962294; cv=none; b=H5bYbQddEeSzB+bi+FijgPyOBe9pT7UwSFagvb2BKqM32BazhqzwnPr4gsMFsc/7naWXXKt9pUfsh6CJl9Vw0f3s0zYNtdeK1ZkR+UAOa1Up2/18p4t7WdaoKTg07TMJoizNa5Cu6a8ScO8VmIUE+pXLl6tciCgK7IILNrp16lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962294; c=relaxed/simple;
	bh=SxPe91eYHqVgGHDHcHMkJAiv90gJTjLwsD3VTLlQP9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLFGsaBhH5Nw+2sG7nEjhBOhJ77Wam8FeZfoxs1I6zzxDkT56syo0TX/iAW8/kr/dnHs/yXZP1NFiplv5FpFRM3CzDAR+ZT8gVxP2PJdTZFRZqdT/pZTD9SUhzMmLCwX/qoQAS65m7xQccBzFkfGF04y/CiRKmF3KpDXmb0f4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWSXd40yTzYQvG4;
	Wed, 17 Dec 2025 17:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 321FC40578;
	Wed, 17 Dec 2025 17:04:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvcackJp5AL6AQ--.18103S6;
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
Subject: [PATCH -next 4/6] cpuset: move update_domain_attr_tree to cpuset_v1.c
Date: Wed, 17 Dec 2025 08:49:40 +0000
Message-Id: <20251217084942.2666405-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHNvcackJp5AL6AQ--.18103S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWUWrW7Gr4DtF4xJF1xGrg_yoW7Cr17pF
	yrCay3Jw45JryUuwn5C34Uu3sagw18ta1Ut345K34rJF47ta4DuFyvvasI9Fy5AFyDCr47
	ZFsIv3y3u3WUtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPUUUUU
	=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Since relax_domain_level is only applicable to v1, move
update_domain_attr_tree() to cpuset-v1.c, which solely updates
relax_domain_level,

Additionally, relax_domain_level is now initialized in cpuset1_inited.
Accordingly, the initialization of relax_domain_level in top_cpuset is
removed. The unnecessary remote_partition initialization in top_cpuset
is also cleaned up.

As a result, relax_domain_level can be defined in cpuset only when
CONFIG_CPUSETS_V1=y.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h | 11 ++++++++---
 kernel/cgroup/cpuset-v1.c       | 28 ++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 31 -------------------------------
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index a32517da8231..677053ffb913 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -150,9 +150,6 @@ struct cpuset {
 	 */
 	int attach_in_progress;
 
-	/* for custom sched domain */
-	int relax_domain_level;
-
 	/* partition root state */
 	int partition_root_state;
 
@@ -182,6 +179,9 @@ struct cpuset {
 
 #ifdef CONFIG_CPUSETS_V1
 	struct fmeter fmeter;		/* memory_pressure filter */
+
+	/* for custom sched domain */
+	int relax_domain_level;
 #endif
 };
 
@@ -296,6 +296,8 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
 void cpuset1_init(struct cpuset *cs);
 void cpuset1_online_css(struct cgroup_subsys_state *css);
+void update_domain_attr_tree(struct sched_domain_attr *dattr,
+				    struct cpuset *root_cs);
 #else
 static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk) {}
@@ -307,6 +309,9 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
 static inline void cpuset1_init(struct cpuset *cs) {}
 static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
+static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
+				    struct cpuset *root_cs) {}
+
 #endif /* CONFIG_CPUSETS_V1 */
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 574df740f21a..95de6f2a4cc5 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -502,6 +502,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 void cpuset1_init(struct cpuset *cs)
 {
 	fmeter_init(&cs->fmeter);
+	cs->relax_domain_level = -1;
 }
 
 void cpuset1_online_css(struct cgroup_subsys_state *css)
@@ -552,6 +553,33 @@ void cpuset1_online_css(struct cgroup_subsys_state *css)
 	cpuset_callback_unlock_irq();
 }
 
+static void
+update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
+{
+	if (dattr->relax_domain_level < c->relax_domain_level)
+		dattr->relax_domain_level = c->relax_domain_level;
+}
+
+void update_domain_attr_tree(struct sched_domain_attr *dattr,
+				    struct cpuset *root_cs)
+{
+	struct cpuset *cp;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+	cpuset_for_each_descendant_pre(cp, pos_css, root_cs) {
+		/* skip the whole subtree if @cp doesn't have any CPU */
+		if (cpumask_empty(cp->cpus_allowed)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		if (is_sched_load_balance(cp))
+			update_domain_attr(dattr, cp);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e836a1f2b951..88ca8b40e01a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -215,8 +215,6 @@ static struct cpuset top_cpuset = {
 	.flags = BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
-	.relax_domain_level = -1,
-	.remote_partition = false,
 };
 
 /*
@@ -755,34 +753,6 @@ static int cpusets_overlap(struct cpuset *a, struct cpuset *b)
 	return cpumask_intersects(a->effective_cpus, b->effective_cpus);
 }
 
-static void
-update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
-{
-	if (dattr->relax_domain_level < c->relax_domain_level)
-		dattr->relax_domain_level = c->relax_domain_level;
-	return;
-}
-
-static void update_domain_attr_tree(struct sched_domain_attr *dattr,
-				    struct cpuset *root_cs)
-{
-	struct cpuset *cp;
-	struct cgroup_subsys_state *pos_css;
-
-	rcu_read_lock();
-	cpuset_for_each_descendant_pre(cp, pos_css, root_cs) {
-		/* skip the whole subtree if @cp doesn't have any CPU */
-		if (cpumask_empty(cp->cpus_allowed)) {
-			pos_css = css_rightmost_descendant(pos_css);
-			continue;
-		}
-
-		if (is_sched_load_balance(cp))
-			update_domain_attr(dattr, cp);
-	}
-	rcu_read_unlock();
-}
-
 /* Must be called with cpuset_mutex held.  */
 static inline int nr_cpusets(void)
 {
@@ -3603,7 +3573,6 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	cpuset1_init(cs);
-	cs->relax_domain_level = -1;
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cpuset_v2())
-- 
2.34.1


