Return-Path: <cgroups+bounces-12373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445ECC07B6
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 02:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE6730124E6
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0224E4C6;
	Tue, 16 Dec 2025 01:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9C22D7A5;
	Tue, 16 Dec 2025 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849417; cv=none; b=ob+aBc54Z66LHlyg9/EmWQyH63FrET6amfYCtylK2xD4+4U3oWs9C0+WN7+ZZb2Ed2DPD6BDUMvMOu1tZSjFIltZuG6ZNZrDYUWOxCVyRROjBASwJwEoBp4a4VO1x8r4NDnNbquTc7b0uKMgdVVxlXrr9yW7Z10Y4oMXlZawQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849417; c=relaxed/simple;
	bh=eC2gKU3ZvkOuIQunNbISfnCG5cMhEpjOAQeCFzf6L1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pfc+j22cgQ+1tDLCklZN9MLjcj0bnpeiNx6vsGn4LlHOLdQRsV/BGjR2yLVFK9lLTQhH2xGSyg+uxX2yFzjJomY/oxcJyX5/BaFIDrsuf0ji3ATR9ahMc8l3Iqwoykm4IHV+kbmWVMrcbdMY/ICmT3inc+xASebfZ7KGjj/smBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVfp33RGkzYQtkR;
	Tue, 16 Dec 2025 09:43:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF4761A11F3;
	Tue, 16 Dec 2025 09:43:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHKPlBuUBpkwNeAQ--.37515S2;
	Tue, 16 Dec 2025 09:43:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next] cpuset: add cpuset1_online_css helper for v1-specific operations
Date: Tue, 16 Dec 2025 01:28:45 +0000
Message-Id: <20251216012845.2437419-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKPlBuUBpkwNeAQ--.37515S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1UtFWxXFW7AryfuF4DJwb_yoWxJryrpF
	1UCa43JayUJFyUu3yfJ34DWrZ3Kw40qa15tF95Ca4rJFy3AF1j9F1kZas8Xry5JFyDCrWU
	Xan0y3yS9a4qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
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
 kernel/cgroup/cpuset-v1.c       | 46 +++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 39 +---------------------------
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 01976c8e7d49..d3bde90ac6f3 100644
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
+static inline void  cpuset1_online_css(struct cgroup_subsys_state *css) {}
 #endif /* CONFIG_CPUSETS_V1 */
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 12e76774c75b..1d83c2b26ff0 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -499,6 +499,52 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
+/* v1-specific operation — caller must hold cpuset_full_lock. */
+void cpuset1_online_css(struct cgroup_subsys_state *css)
+{
+	struct cpuset *tmp_cs;
+	struct cgroup_subsys_state *pos_css;
+	struct cpuset *cs = css_cs(css);
+	struct cpuset *parent = parent_cs(cs);
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
index fea577b4016a..ba645ba09a25 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3611,17 +3611,11 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
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
@@ -3636,39 +3630,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
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


