Return-Path: <cgroups+bounces-11177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC10C08CF0
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6641F1A670D3
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C42F6572;
	Sat, 25 Oct 2025 07:04:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171C2E5402;
	Sat, 25 Oct 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375844; cv=none; b=bd/2m5HwkX7U6Z2fZiMIQP0qE0G6i/nyX76sOuhIYSBQiK0yHGypGknAA8V4Y8eJIqWBD5bWOz/XrCGriTJKnCDp1VrBSfXbCzodDg7O61dkncB8bjr5aniHNLn5q1IrxVyIPOJViZhTjN/YkmO2OY1sLxeqyUGq/vKGbChz0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375844; c=relaxed/simple;
	bh=DccZ1hiEW4IpYDsTfTAR4e8w03cHnhw3plAqTpDQaSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnSuuCOBNJzDU5bh1WXlsOad1jXV1LKkhPBegGdR0iTIQQFigEEZlkqesoiSq5uZ8CFHiNod0CAMNS8fSYjxvtb17DkPbf2F2lUm65rZstWTGMg7UJOeD026EX6QrdUaqYsybtdBTymRgPiZRo8aQ1t1bnWEZLDdrAIl9mnbCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrM00lQpzYQtwW;
	Sat, 25 Oct 2025 15:02:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 040DD1A19E5;
	Sat, 25 Oct 2025 15:03:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S22;
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
Subject: [PATCH RFC v2 20/22] cpuset: introduce validate_remote_partition
Date: Sat, 25 Oct 2025 06:48:42 +0000
Message-Id: <20251025064844.495525-21-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S22
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4ruw45JF1fuF48Zw1fZwb_yoW3Zw4fpF
	y7Gr4IgrWUJr15C34DJan7uwn5KwsrtF9FywnxXa4fZFy2y34vyFyjk398Aa4UW3srW345
	Zas0qr47WF9rAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This introduces validate_remote_partition() to consolidate validation
logic for remote partition operations. It will be used by both
remote_partition_enable() and remote_partition_disable().

The new function performs the following checks:
1. Privilege requirement: only CAP_SYS_ADMIN can add CPUs to a
   remote partition.
2. Conflict check: ensure added CPUs are not in any existing
   sub-partitions and that there is at least one online CPU in the
   excluded mask.
3. Resource check: prevent allocating all top cpuset's effective CPUs
   to remote partitions.
4. Common partition validation.

Additionally, this patch adds error handling for remote_partition_disable()
so that cs->prs_err can be updated centrally.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 111 ++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 52 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index feb8413eaffa..52ef58e94926 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1679,6 +1679,46 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
 	return PERR_NONE;
 }
 
+/**
+ * validate_remote_partition - Validate for remote partition
+ * @cs: Target cpuset to validate
+ * @new_prs: New partition root state to validate
+ * @excpus: New exclusive effectuve CPUs mask to validate
+ * @addmask: New CPU mask to be added to exclusive CPUs
+ *
+ * Return: PERR_NONE if validation passes, appropriate error code otherwise
+ */
+static enum prs_errcode validate_remote_partition(struct cpuset *cs,
+			int new_prs, struct cpumask *excpus, struct cpumask *addmask)
+{
+	/*
+	 * The user must have sysadmin privilege.
+	 */
+	if (!cpumask_empty(addmask) && !capable(CAP_SYS_ADMIN))
+		return PERR_ACCESS;
+
+	/*
+	 * Additions of remote CPUs is only allowed if those CPUs are
+	 * not allocated to other partitions and there are effective_cpus
+	 * left in the top cpuset.
+	 *
+	 * The effective_xcpus mask can contain offline CPUs, but there must
+	 * be at least one or more online CPUs present before it can be enabled.
+	 */
+	if (cpumask_intersects(addmask, subpartitions_cpus) ||
+	    !cpumask_intersects(excpus, cpu_active_mask))
+		return PERR_INVCPUS;
+
+	/*
+	 * It is not allowed that all effective_cpus of top_cpuset are
+	 * distributed remote partition
+	 */
+	if (cpumask_subset(top_cpuset.effective_cpus, excpus))
+		return PERR_NOCPUS;
+
+	return validate_partition(cs, new_prs, excpus);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
@@ -1692,27 +1732,13 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	/*
-	 * The user must have sysadmin privilege.
-	 */
-	if (!capable(CAP_SYS_ADMIN))
-		return PERR_ACCESS;
+	enum prs_errcode err;
 
-	/*
-	 * The requested exclusive_cpus must not be allocated to other
-	 * partitions and it can't use up all the root's effective_cpus.
-	 *
-	 * The effective_xcpus mask can contain offline CPUs, but there must
-	 * be at least one or more online CPUs present before it can be enabled.
-	 *
-	 * Note that creating a remote partition with any local partition root
-	 * above it or remote partition root underneath it is not allowed.
-	 */
 	compute_excpus(cs, tmp->new_cpus);
 	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
-	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
-	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
-		return PERR_INVCPUS;
+	err = validate_remote_partition(cs, new_prs, tmp->new_cpus, tmp->new_cpus);
+	if (err)
+		return err;
 
 	partition_enable(cs, NULL, new_prs, tmp->new_cpus);
 	/*
@@ -1726,21 +1752,23 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 /*
  * remote_partition_disable - Remove current cpuset from remote partition list
  * @cs: the cpuset to update
+ * @prs_err: partition error when @cs is disabled
  * @tmp: temporary masks
  *
  * The effective_cpus is also updated.
  *
  * cpuset_mutex must be held by the caller.
  */
-static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+static void remote_partition_disable(struct cpuset *cs,
+			 enum prs_errcode prs_err, struct tmpmasks *tmp)
 {
 	int new_prs;
 
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	new_prs = cs->prs_err ? -cs->partition_root_state : PRS_MEMBER;
-	partition_disable(cs, NULL, new_prs, cs->prs_err);
+	new_prs = prs_err ? -cs->partition_root_state : PRS_MEMBER;
+	partition_disable(cs, NULL, new_prs, prs_err);
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
@@ -1761,34 +1789,18 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			       struct cpumask *excpus, struct tmpmasks *tmp)
 {
+	enum prs_errcode err;
+
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
 
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
-
-	if (cpumask_empty(excpus)) {
-		cs->prs_err = PERR_CPUSEMPTY;
-		goto invalidate;
-	}
-
 	cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
 	cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
-
-	/*
-	 * Additions of remote CPUs is only allowed if those CPUs are
-	 * not allocated to other partitions and there are effective_cpus
-	 * left in the top cpuset.
-	 */
-	if (!cpumask_empty(tmp->addmask)) {
-		WARN_ON_ONCE(cpumask_intersects(tmp->addmask, subpartitions_cpus));
-		if (!capable(CAP_SYS_ADMIN))
-			cs->prs_err = PERR_ACCESS;
-		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
-			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
-			cs->prs_err = PERR_NOCPUS;
-		if (cs->prs_err)
-			goto invalidate;
-	}
+	err = validate_remote_partition(cs, cs->partition_root_state,
+					excpus, tmp->addmask);
+	if (err)
+		return remote_partition_disable(cs, err, tmp);
 
 	partition_update(cs, cs->partition_root_state, xcpus, excpus, tmp);
 	/*
@@ -1796,10 +1808,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	 */
 	cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
-	return;
-
-invalidate:
-	remote_partition_disable(cs, tmp);
 }
 
 static bool is_user_cpus_exclusive(struct cpuset *cs)
@@ -2408,11 +2416,11 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	prs_err = validate_partition(cs, trialcs->partition_root_state,
 				     trialcs->effective_xcpus);
 	if (prs_err)
-		trialcs->prs_err = cs->prs_err = prs_err;
+		trialcs->prs_err = prs_err;
 
 	if (is_remote_partition(cs)) {
 		if (trialcs->prs_err)
-			remote_partition_disable(cs, tmp);
+			remote_partition_disable(cs, trialcs->prs_err, tmp);
 		else
 			remote_cpus_update(cs, trialcs->exclusive_cpus,
 					   trialcs->effective_xcpus, tmp);
@@ -2952,7 +2960,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * disables child partitions.
 		 */
 		if (is_remote_partition(cs))
-			remote_partition_disable(cs, &tmpmask);
+			remote_partition_disable(cs, PERR_NONE, &tmpmask);
 		else
 			local_partition_disable(cs, PERR_NONE, &tmpmask);
 		/*
@@ -3841,8 +3849,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		compute_partition_effective_cpumask(cs, &new_cpus);
 		if (cpumask_empty(&new_cpus) &&
 		    partition_is_populated(cs, NULL)) {
-			cs->prs_err = PERR_HOTPLUG;
-			remote_partition_disable(cs, tmp);
+			remote_partition_disable(cs, PERR_HOTPLUG, tmp);
 			compute_effective_cpumask(&new_cpus, cs, parent);
 		}
 		goto update_tasks;
-- 
2.34.1


