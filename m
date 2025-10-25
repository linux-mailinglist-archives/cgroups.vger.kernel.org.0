Return-Path: <cgroups+bounces-11172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38061C08CD5
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51581C63BA4
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8F2E8B7D;
	Sat, 25 Oct 2025 07:04:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA52E264D;
	Sat, 25 Oct 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375843; cv=none; b=K9UAco76LnTEgUkGH4h1ihANgUCcbvmon1y9/0TnWnMKIJHk4K7htJlHtU54RzKLH0hpCsaVgj0FvxbE0ff4uWYwqgoqZyBN6hyXMdKlWKNhq/VUkKuaJHDoeVthbsHZvFVe4ZGumVsSaAkElaJeaWf6O1q7F5w5BT4lpxbodLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375843; c=relaxed/simple;
	bh=M2MxgyLz7vdl4OLwmIEwo8O1O9K0uKlkZr4W4clk+xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyzIBRluEMkN2NpR/MiUUS+RcyUsR0ZZumPWoMs6rjaK0mSfmICqNBqWKTZVGsBQiXxy1FA/F/PUdgsVFuSG5Wx5M/iP8sGmqOdO06j8k2V4X+CMim14hmC+jRgKruZJnnIJlDl8/6c7C3H+MxMIE+rofojtWK8a2hMWGgmTJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz4L11zYQtvr;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7F0DE1A19C0;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S14;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 12/22] cpuset: introduce local_partition_invalidate()
Date: Sat, 25 Oct 2025 06:48:34 +0000
Message-Id: <20251025064844.495525-13-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S14
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWrWryfZw15Jr4kKw1rWFg_yoW7Gw17pF
	y7CrW7t3yUJry5u343Jan7Zw4rKws7XasFywnxJayrJF17J3WvyF1jya9avw45WF98GryU
	ZayYgr4xGFy7A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Build on the partition_disable() infrastructure introduced in the previous
patch to handle local partition invalidation.

The local_partition_invalidate() function factors out the local partition
invalidation logic from update_parent_effective_cpumask(), which delegates
to partition_disable() to complete the invalidation process.

Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
when determining whether to transition an invalid partition root, the check
should be based on non-empty user_cpus rather than non-empty
effective_xcpus. This correction addresses the scenario where
exclusive_cpus is not set but cpus_allowed is configured - in this case,
effective_xcpus may be empty even though the partition should be considered
for re-enablement. The user_cpus-based check ensures proper partition state
transitions under these conditions.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f36d17a4d8cd..73a43ab58f72 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1914,6 +1914,40 @@ static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_err
 	}
 }
 
+/**
+ * local_partition_invalidate - Invalidate a local partition
+ * @cs: Target cpuset (local partition root) to invalidate
+ * @tmp: Temporary masks
+ */
+static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	struct cpumask *xcpus = user_xcpus(cs);
+	struct cpuset *parent = parent_cs(cs);
+	int new_prs = cs->partition_root_state;
+	bool cpumask_updated = false;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	if (!is_partition_valid(cs))
+		return;
+
+	/*
+	 * Make the current partition invalid.
+	 */
+	if (is_partition_valid(parent))
+		cpumask_updated = cpumask_and(tmp->addmask,
+					      xcpus, parent->effective_xcpus);
+	if (cs->partition_root_state > 0)
+		new_prs = -cs->partition_root_state;
+
+	partition_disable(cs, parent, new_prs, cs->prs_err);
+	if (cpumask_updated) {
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
+		update_sibling_cpumasks(parent, cs, tmp);
+	}
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1974,22 +2008,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
 
-	if (cmd == partcmd_invalidate) {
-		if (is_partition_invalid(cs))
-			return 0;
-
-		/*
-		 * Make the current partition invalid.
-		 */
-		if (is_partition_valid(parent))
-			adding = cpumask_and(tmp->addmask,
-					     xcpus, parent->effective_xcpus);
-		if (old_prs > 0)
-			new_prs = -old_prs;
-
-		goto write_error;
-	}
-
 	/*
 	 * The parent must be a partition root.
 	 * The new cpumask, if present, or the current cpus_allowed must
@@ -2553,7 +2571,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
+				local_partition_invalidate(cp, tmp);
 				rcu_read_lock();
 			}
 		}
@@ -2593,8 +2611,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 					   trialcs->effective_xcpus, tmp);
 	} else {
 		if (trialcs->prs_err)
-			update_parent_effective_cpumask(cs, partcmd_invalidate,
-							NULL, tmp);
+			local_partition_invalidate(cs, tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
 							trialcs->effective_xcpus, tmp);
@@ -4040,18 +4057,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 *    partitions.
 	 */
 	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
-				tasks_nocpu_error(parent, cs, &new_cpus)))
+				tasks_nocpu_error(parent, cs, &new_cpus))) {
 		partcmd = partcmd_invalidate;
+		local_partition_invalidate(cs, tmp);
+	}
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
-	 * back to a regular one with a non-empty effective xcpus.
+	 * back to a regular one with a non-empty user xcpus.
 	 */
 	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
-		 !cpumask_empty(cs->effective_xcpus))
+		 !cpumask_empty(user_xcpus(cs))) {
 		partcmd = partcmd_update;
+		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
+	}
 
 	if (partcmd >= 0) {
-		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
 		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
 			compute_partition_effective_cpumask(cs, &new_cpus);
 			cpuset_force_rebuild();
-- 
2.34.1


