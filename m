Return-Path: <cgroups+bounces-12020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40AC622F3
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C1C4ECBBC
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83325A2C6;
	Mon, 17 Nov 2025 03:01:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC238272E54;
	Mon, 17 Nov 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348512; cv=none; b=VjBAOGUdOdLpTf+8NPn9EklBktU551VToVuiyJv/DiT7hdMrvQuHOQE2e7eXVWH3phYa1LqXSEOkU1scn17Le9zxxabF+H/CTMDniSi4kdXyp+yGC43iuy3HQaHZRttbeIbTa03aeIx57o6x84RALb05nRAjZVQvEitLvujdJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348512; c=relaxed/simple;
	bh=lf4lED1RYWH5dHhWH7dsU3RsDjTPqcv3lhcqoEzlbG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7RFF5zjgvbk3mWEu9zCu5IQPO/1eXSVQgYyfPx5Bcyp/5YvuVnFcqMqThqTFFmjR0fDMCNHJc1g6o82UxnOJViPOtTy511y3sUovoBtuvXTUWAa3ugeX9FFh8qyV6IAHef/wLbSwBiXSvx2sUN6EoSLEyhm2LwDsQwx0CMeaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d8svL0kxZzYQtxf;
	Mon, 17 Nov 2025 11:01:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3A0641A13F5;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S20;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 18/21] cpuset: introduce validate_remote_partition
Date: Mon, 17 Nov 2025 02:46:24 +0000
Message-Id: <20251117024627.1128037-19-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117024627.1128037-1-chenridong@huaweicloud.com>
References: <20251117024627.1128037-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S20
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rtr15GF1fJF4rKry8Xwb_yoW3Kr4xpF
	y7Gr42grWUJr15C34DJan7uwn5KwsrtF9FywnxX3yfZFy2y34vyFyjk390ya4UW3srW34U
	Za90qr47WFy7AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
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
 kernel/cgroup/cpuset.c | 118 +++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b75d27a59ba9..8690f144b208 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1744,6 +1744,47 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
 	notify_partition_change(cs, old_prs);
 }
 
+/**
+ * validate_remote_partition - Validate for remote partition
+ * @cs: Target cpuset to validate
+ * @new_prs: New partition root state to validate
+ * @excpus: New exclusive effectuve CPUs mask to validate
+ * @add: exclusive CPUs to be added
+ * @del: exclusive CPUs to be deleted, can be NULL
+ *
+ * Return: PERR_NONE if validation passes, appropriate error code otherwise
+ */
+static enum prs_errcode validate_remote_partition(struct cpuset *cs,
+	int new_prs, struct cpumask *excpus, struct cpumask *add, struct cpumask *del)
+{
+	/*
+	 * The user must have sysadmin privilege.
+	 */
+	if (!cpumask_empty(add) && !capable(CAP_SYS_ADMIN))
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
+	if (cpumask_intersects(add, subpartitions_cpus) ||
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
+	return validate_partition(cs, new_prs, excpus, add, del);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
@@ -1757,31 +1798,15 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	/*
-	 * The user must have sysadmin privilege.
-	 */
-	if (!capable(CAP_SYS_ADMIN))
-		return PERR_ACCESS;
 
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
+	enum prs_errcode err;
+
 	compute_excpus(cs, tmp->new_cpus);
 	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
-	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
-	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
-		return PERR_INVCPUS;
-	if (((new_prs == PRS_ISOLATED) &&
-	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
-	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
-		return PERR_HKEEPING;
+	err = validate_remote_partition(cs, new_prs, tmp->new_cpus,
+					tmp->new_cpus, NULL);
+	if (err)
+		return err;
 
 	partition_enable(cs, NULL, new_prs, tmp->new_cpus);
 	/*
@@ -1801,15 +1826,16 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  *
  * cpuset_mutex must be held by the caller.
  */
-static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+static void remote_partition_disable(struct cpuset *cs,
+			enum prs_errcode prs_err, struct tmpmasks *tmp)
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
@@ -1831,39 +1857,19 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			       struct cpumask *excpus, struct tmpmasks *tmp)
 {
-	int prs = cs->partition_root_state;
+	enum prs_errcode err;
 
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
-		else if ((prs == PRS_ISOLATED) &&
-			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
-			cs->prs_err = PERR_HKEEPING;
-		if (cs->prs_err)
-			goto invalidate;
-	}
+	err = validate_remote_partition(cs, cs->partition_root_state, excpus,
+					tmp->addmask, tmp->delmask);
+	if (err)
+		return remote_partition_disable(cs, err, tmp);
 
 	partition_update(cs, cs->partition_root_state, xcpus, excpus, tmp);
 	/*
@@ -1872,9 +1878,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
 	return;
-
-invalidate:
-	remote_partition_disable(cs, tmp);
 }
 
 static bool is_user_xcpus_exclusive(struct cpuset *cs)
@@ -2456,11 +2459,11 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	prs_err = validate_partition(cs, trialcs->partition_root_state,
 			trialcs->effective_xcpus, trialcs->effective_xcpus, NULL);
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
@@ -3000,7 +3003,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * disables child partitions.
 		 */
 		if (is_remote_partition(cs))
-			remote_partition_disable(cs, &tmpmask);
+			remote_partition_disable(cs, PERR_NONE, &tmpmask);
 		else
 			local_partition_disable(cs, PERR_NONE, &tmpmask);
 		/*
@@ -3887,8 +3890,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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


