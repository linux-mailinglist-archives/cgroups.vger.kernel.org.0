Return-Path: <cgroups+bounces-12496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59321CCB3E3
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1F65301A9A9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A90331A6B;
	Thu, 18 Dec 2025 09:46:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CA3328F6;
	Thu, 18 Dec 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051206; cv=none; b=HlOCIsthzaCqBaXka6Wyjkn1ME/YSnBdgBBGmR77cifOMglAw9SJYF7837zYeF0By/euJkZnYwxXgDT0sAjZzo6CXkG2i8BHZynNVEQmXvfRPNVqfCZxa+dscfSWLr4b7xc72ChDJ96HlJhQ1qVMRuELtmWvqcLtEpF8NkkWtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051206; c=relaxed/simple;
	bh=n5y+c/A74XVvbdJLbrBLOd3u4NopT0CCszElgJPaD2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LF50Gvqn9+X20bEChopHdQR+voGofXCsYj+IVX328f3m7gcVe7x0pQ9RXyJiFev1lLtsgFWnK+CWNKkhUdmycS4FHXcxGEuEtq5sCfsjBF6pzYOpTuxm7SCMWG7FUWnzZb/S5vtHKpfuwA6JKTqAUJJVbYxjaERcS5pbnP+yrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX5QS3ZYVzYQv7j;
	Thu, 18 Dec 2025 17:46:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D2E8F40577;
	Thu, 18 Dec 2025 17:46:36 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA35vZxzUNpHcJzAg--.22754S4;
	Thu, 18 Dec 2025 17:46:36 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 2/6] cpuset: add cpuset1_online_css helper for v1-specific operations
Date: Thu, 18 Dec 2025 09:31:37 +0000
Message-Id: <20251218093141.2687291-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218093141.2687291-1-chenridong@huaweicloud.com>
References: <20251218093141.2687291-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vZxzUNpHcJzAg--.22754S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1UtFWkKFy5JFWUZryUGFg_yoWxJryfpF
	18CFy3JayUJFyUu3yfJa4DWrZ3Kw40qF45KF95Ca4rJFy3AF1j9F1kZas8XFy5JFyDCrWU
	Xan0y3yS9a4qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUFoGdUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This commit introduces the cpuset1_online_css helper to centralize
v1-specific handling during cpuset online. It performs operations such as
updating the CS_SPREAD_PAGE, CS_SPREAD_SLAB, and CGRP_CPUSET_CLONE_CHILDREN
flags, which are unique to the cpuset v1 control group interface.

The helper is now placed in cpuset-v1.c to maintain clear separation
between v1 and v2 logic.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  2 ++
 kernel/cgroup/cpuset-v1.c       | 48 +++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 39 +--------------------------
 3 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 01976c8e7d49..6c03cad02302 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -293,6 +293,7 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
+void cpuset1_online_css(struct cgroup_subsys_state *css);
 #else
 static inline void fmeter_init(struct fmeter *fmp) {}
 static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
@@ -303,6 +304,7 @@ static inline void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    bool cpus_updated, bool mems_updated) {}
 static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
+static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
 #endif /* CONFIG_CPUSETS_V1 */
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..c296ce47616a 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -499,6 +499,54 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
+void cpuset1_online_css(struct cgroup_subsys_state *css)
+{
+	struct cpuset *tmp_cs;
+	struct cgroup_subsys_state *pos_css;
+	struct cpuset *cs = css_cs(css);
+	struct cpuset *parent = parent_cs(cs);
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_cpuset_lock_held();
+
+	if (is_spread_page(parent))
+		set_bit(CS_SPREAD_PAGE, &cs->flags);
+	if (is_spread_slab(parent))
+		set_bit(CS_SPREAD_SLAB, &cs->flags);
+
+	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
+		return;
+
+	/*
+	 * Clone @parent's configuration if CGRP_CPUSET_CLONE_CHILDREN is
+	 * set.  This flag handling is implemented in cgroup core for
+	 * historical reasons - the flag may be specified during mount.
+	 *
+	 * Currently, if any sibling cpusets have exclusive cpus or mem, we
+	 * refuse to clone the configuration - thereby refusing the task to
+	 * be entered, and as a result refusing the sys_unshare() or
+	 * clone() which initiated it.  If this becomes a problem for some
+	 * users who wish to allow that scenario, then this could be
+	 * changed to grant parent->cpus_allowed-sibling_cpus_exclusive
+	 * (and likewise for mems) to the new cgroup.
+	 */
+	rcu_read_lock();
+	cpuset_for_each_child(tmp_cs, pos_css, parent) {
+		if (is_mem_exclusive(tmp_cs) || is_cpu_exclusive(tmp_cs)) {
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+
+	cpuset_callback_lock_irq();
+	cs->mems_allowed = parent->mems_allowed;
+	cs->effective_mems = parent->mems_allowed;
+	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
+	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
+	cpuset_callback_unlock_irq();
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4fa3080da3be..5d9dbd1aeed3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3616,17 +3616,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 	struct cpuset *parent = parent_cs(cs);
-	struct cpuset *tmp_cs;
-	struct cgroup_subsys_state *pos_css;
 
 	if (!parent)
 		return 0;
 
 	cpuset_full_lock();
-	if (is_spread_page(parent))
-		set_bit(CS_SPREAD_PAGE, &cs->flags);
-	if (is_spread_slab(parent))
-		set_bit(CS_SPREAD_SLAB, &cs->flags);
 	/*
 	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
 	 */
@@ -3641,39 +3635,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cs->effective_mems = parent->effective_mems;
 	}
 	spin_unlock_irq(&callback_lock);
+	cpuset1_online_css(css);
 
-	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
-		goto out_unlock;
-
-	/*
-	 * Clone @parent's configuration if CGRP_CPUSET_CLONE_CHILDREN is
-	 * set.  This flag handling is implemented in cgroup core for
-	 * historical reasons - the flag may be specified during mount.
-	 *
-	 * Currently, if any sibling cpusets have exclusive cpus or mem, we
-	 * refuse to clone the configuration - thereby refusing the task to
-	 * be entered, and as a result refusing the sys_unshare() or
-	 * clone() which initiated it.  If this becomes a problem for some
-	 * users who wish to allow that scenario, then this could be
-	 * changed to grant parent->cpus_allowed-sibling_cpus_exclusive
-	 * (and likewise for mems) to the new cgroup.
-	 */
-	rcu_read_lock();
-	cpuset_for_each_child(tmp_cs, pos_css, parent) {
-		if (is_mem_exclusive(tmp_cs) || is_cpu_exclusive(tmp_cs)) {
-			rcu_read_unlock();
-			goto out_unlock;
-		}
-	}
-	rcu_read_unlock();
-
-	spin_lock_irq(&callback_lock);
-	cs->mems_allowed = parent->mems_allowed;
-	cs->effective_mems = parent->mems_allowed;
-	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
-	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
-	spin_unlock_irq(&callback_lock);
-out_unlock:
 	cpuset_full_unlock();
 	return 0;
 }
-- 
2.34.1


