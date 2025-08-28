Return-Path: <cgroups+bounces-9464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCCB39E42
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21EE1C28156
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4301311598;
	Thu, 28 Aug 2025 13:11:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DA3112BA;
	Thu, 28 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386695; cv=none; b=Gk8fybijlIsFD+Xih6kq1T9+CDqU1YwjR14Y4G2DbxNeffudqIzC9dd2zigKZitw0N4WXHMwaaAlEz4Vqh4p5JFXQJ/5hYpK0hRGO0OjzXAdJMKrDvvldebywElEkyB2Z5/9DvKmrQVl5795A2ajNQQHBv93m+3qONIALy2l2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386695; c=relaxed/simple;
	bh=R+N1MEoGYDz4Uj2LiTeq0csAp9xEMgV2pvdXOrmCZ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCnU+kS8M9yuRdNPEXGVDkAmj2IhZwa2lrDodcYXPeI8pGaxNXs6GZ6lFKyiMl9hrdpWJOPWFWC/t1FVuxw6edEy8eyxtBA8Xt2ovBLKyxW6VS8oxUNSHZrWVdRS+U6KVDchAf9L4KeZqMl50p/c8B89Uk4sDnQPd003Mz703as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH908xqzYQvh2;
	Thu, 28 Aug 2025 21:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 893C61A1AF1;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S6;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 04/11] cpuset: Refactor exclusive CPU mask computation logic
Date: Thu, 28 Aug 2025 12:56:24 +0000
Message-Id: <20250828125631.1978176-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828125631.1978176-1-chenridong@huaweicloud.com>
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S6
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8CF13tFykZryrAr1rCrg_yoWfXr17pF
	18GFW7XFWjqryrC398twn7Wrn3K3ykt3ZFywnrt34rCFy3C3W0yFyDJa9xAFyUGw4DuF15
	Aasxtr4SgasxCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current compute_effective_exclusive_cpumask function handles multiple
scenarios with different input parameters, making the code difficult to
follow. This patch refactors it into two separate functions:
compute_excpus and compute_trialcs_excpus.

The compute_excpus function calculates the exclusive CPU mask for a given
input and excludes exclusive CPUs from sibling cpusets when cs's
exclusive_cpus is not explicitly set.

The compute_trialcs_excpus function specifically handles exclusive CPU
computation for trial cpusets used during CPU mask configuration updates,
and always excludes exclusive CPUs from sibling cpusets.

This refactoring significantly improves code readability and clarity,
making it explicit which function to call for each use case and what
parameters should be provided.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 103 ++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 595a8346f823..fc367ae741cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1402,38 +1402,25 @@ bool cpuset_cpu_is_isolated(int cpu)
 }
 EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
 
-/*
- * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
- * @cs: cpuset
- * @xcpus: effective exclusive CPUs value to be set
- * @real_cs: the real cpuset (can be NULL)
- * Return: 0 if there is no sibling conflict, > 0 otherwise
+/**
+ * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
+ * @parent: Parent cpuset containing all siblings
+ * @cs: Current cpuset (will be skipped)
+ * @excpus:  exclusive effective CPU mask to modify
  *
- * If exclusive_cpus isn't explicitly set or a real_cs is provided, we have to
- * scan the sibling cpusets and exclude their exclusive_cpus or effective_xcpus
- * as well. The provision of real_cs means that a cpumask is being changed and
- * the given cs is a trial one.
+ * This function ensures the given @excpus mask doesn't include any CPUs that
+ * are exclusively allocated to sibling cpusets. It walks through all siblings
+ * of @cs under @parent and removes their exclusive CPUs from @excpus.
  */
-static int compute_effective_exclusive_cpumask(struct cpuset *cs,
-					       struct cpumask *xcpus,
-					       struct cpuset *real_cs)
+static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
+					struct cpumask *excpus)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *parent = parent_cs(cs);
 	struct cpuset *sibling;
 	int retval = 0;
 
-	if (!xcpus)
-		xcpus = cs->effective_xcpus;
-
-	cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
-
-	if (!real_cs) {
-		if (!cpumask_empty(cs->exclusive_cpus))
-			return 0;
-	} else {
-		cs = real_cs;
-	}
+	if (cpumask_empty(excpus))
+		return retval;
 
 	/*
 	 * Exclude exclusive CPUs from siblings
@@ -1443,20 +1430,60 @@ static int compute_effective_exclusive_cpumask(struct cpuset *cs,
 		if (sibling == cs)
 			continue;
 
-		if (cpumask_intersects(xcpus, sibling->exclusive_cpus)) {
-			cpumask_andnot(xcpus, xcpus, sibling->exclusive_cpus);
+		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
+			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
 			retval++;
 			continue;
 		}
-		if (cpumask_intersects(xcpus, sibling->effective_xcpus)) {
-			cpumask_andnot(xcpus, xcpus, sibling->effective_xcpus);
+		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
+			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
 			retval++;
 		}
 	}
 	rcu_read_unlock();
+
 	return retval;
 }
 
+/*
+ * compute_excpus - compute effective exclusive CPUs
+ * @cs: cpuset
+ * @xcpus: effective exclusive CPUs value to be set
+ * Return: 0 if there is no sibling conflict, > 0 otherwise
+ *
+ * If exclusive_cpus isn't explicitly set , we have to scan the sibling cpusets
+ * and exclude their exclusive_cpus or effective_xcpus as well.
+ */
+static int compute_excpus(struct cpuset *cs, struct cpumask *excpus)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	cpumask_and(excpus, user_xcpus(cs), parent->effective_xcpus);
+
+	if (!cpumask_empty(cs->exclusive_cpus))
+		return 0;
+
+	return rm_siblings_excl_cpus(parent, cs, excpus);
+}
+
+/*
+ * compute_trialcs_excpus - Compute effective exclusive CPUs for a trial cpuset
+ * @trialcs: The trial cpuset containing the proposed new configuration
+ * @cs: The original cpuset that the trial configuration is based on
+ * Return: 0 if successful with no sibling conflict, >0 if a conflict is found
+ *
+ * Computes the effective_xcpus for a trial configuration. @cs is provided to represent
+ * the real cs.
+ */
+static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(trialcs);
+	struct cpumask *excpus = trialcs->effective_xcpus;
+
+	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
+	return rm_siblings_excl_cpus(parent, cs, excpus);
+}
+
 static inline bool is_remote_partition(struct cpuset *cs)
 {
 	return !list_empty(&cs->remote_sibling);
@@ -1498,7 +1525,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * Note that creating a remote partition with any local partition root
 	 * above it or remote partition root underneath it is not allowed.
 	 */
-	compute_effective_exclusive_cpumask(cs, tmp->new_cpus, NULL);
+	compute_excpus(cs, tmp->new_cpus);
 	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
@@ -1547,7 +1574,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 		cs->partition_root_state = PRS_MEMBER;
 
 	/* effective_xcpus may need to be changed */
-	compute_effective_exclusive_cpumask(cs, NULL, NULL);
+	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
@@ -1748,12 +1775,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
 		/*
-		 * Need to call compute_effective_exclusive_cpumask() in case
+		 * Need to call compute_excpus() in case
 		 * exclusive_cpus not set. Sibling conflict should only happen
 		 * if exclusive_cpus isn't set.
 		 */
 		xcpus = tmp->delmask;
-		if (compute_effective_exclusive_cpumask(cs, xcpus, NULL))
+		if (compute_excpus(cs, xcpus))
 			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
 
 		/*
@@ -2035,7 +2062,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	 *  2) All the effective_cpus will be used up and cp
 	 *     has tasks
 	 */
-	compute_effective_exclusive_cpumask(cs, new_ecpus, NULL);
+	compute_excpus(cs, new_ecpus);
 	cpumask_and(new_ecpus, new_ecpus, cpu_active_mask);
 
 	rcu_read_lock();
@@ -2114,7 +2141,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * its value is being processed.
 		 */
 		if (remote && (cp != cs)) {
-			compute_effective_exclusive_cpumask(cp, tmp->new_cpus, NULL);
+			compute_excpus(cp, tmp->new_cpus);
 			if (cpumask_equal(cp->effective_xcpus, tmp->new_cpus)) {
 				pos_css = css_rightmost_descendant(pos_css);
 				continue;
@@ -2216,7 +2243,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
 		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
-			compute_effective_exclusive_cpumask(cp, NULL, NULL);
+			compute_excpus(cp, cp->effective_xcpus);
 
 		/*
 		 * Make sure effective_xcpus is properly set for a valid
@@ -2365,7 +2392,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * for checking validity of the partition root.
 		 */
 		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
-			compute_effective_exclusive_cpumask(trialcs, NULL, cs);
+			compute_trialcs_excpus(trialcs, cs);
 	}
 
 	/* Nothing to do if the cpus didn't change */
@@ -2501,7 +2528,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * Reject the change if there is exclusive CPUs conflict with
 		 * the siblings.
 		 */
-		if (compute_effective_exclusive_cpumask(trialcs, NULL, cs))
+		if (compute_trialcs_excpus(trialcs, cs))
 			return -EINVAL;
 	}
 
-- 
2.34.1


