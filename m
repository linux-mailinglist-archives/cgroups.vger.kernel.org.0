Return-Path: <cgroups+bounces-11166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35394C08CB7
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF2F735132F
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A02DA769;
	Sat, 25 Oct 2025 07:04:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B332DECA5;
	Sat, 25 Oct 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375839; cv=none; b=n9KRQStkIPoqjmJUW3vP9C88sUMe4A8KDpjFnH/0IP81er0YXb7ncqs0w3ltDKS2Cw+lVaa1UTmNxrMc84bsszT2DN9CB9dgD+BQylErD8yiW589ntatAFz2yOgcsb3K4TiUV69CJYnggGLpKjgTKsmzCpaK1UnHNLnKmCOywpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375839; c=relaxed/simple;
	bh=SXlG+smGGhPTCCMpAUMihu+5fJdEffIfAjTzfT2qsHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3m4hm7uaPsYCzWTbAte5FrmS3zLwNrlUF1vUAV8gfo9I9lvm0iNhj7625Q1Qq+YpQ2ZNB6nXTP+oEo76mlajlA56Tge9Wi9uaZRzsH18Z8Oh+tH9KDMsecU/Ih1ZX5RzgEIT6AvVVhNkSQvs0DEQq+vxhCAjIWO5z0LO3odF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz1VYkzYQttg;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1A82E1A0E46;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S5;
	Sat, 25 Oct 2025 15:03:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 03/22] cpuset: generalize validate_partition() interface
Date: Sat, 25 Oct 2025 06:48:25 +0000
Message-Id: <20251025064844.495525-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4fCrWDCF1xZr17WFykKrg_yoW7Aw4rpF
	W5GrW7GrWUKry5C34kt3Z7Cw1YgwnrJ3Wqy3sxJ3WSvFy7tw1vyFyj939IyFyrW3srW3WU
	ZanI9F4fWFW7A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwhFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Refactor validate_partition() to accept a more generic parameter set,
making the interface flexible enough to handle local partition enablement
validation scenarios. This prepares the function for broader use cases
beyond its current validation scope while maintaining backward
compatibility with existing callers.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 117 +++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 64 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3ba9ca4e8f5e..493e094961da 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1521,6 +1521,54 @@ static inline bool is_local_partition(struct cpuset *cs)
 	return is_partition_valid(cs) && !is_remote_partition(cs);
 }
 
+/*
+ * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
+ * @prstate: partition root state to be checked
+ * @new_cpus: cpu mask
+ * Return: true if there is conflict, false otherwise
+ *
+ * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * isolated partition.
+ */
+static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
+{
+	if (!have_boot_isolcpus)
+		return false;
+
+	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
+		return true;
+
+	return false;
+}
+
+/**
+ * validate_partition - Validate a cpuset partition configuration
+ * @cs: The cpuset to validate
+ * @new_prs: The proposed new partition root state
+ * @new_excpus: The new effective exclusize CPUs mask to validate
+ *
+ * Return: PRS error code (0 if valid, non-zero error code if invalid)
+ */
+static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
+						 struct cpumask *new_excpus)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (new_prs == PRS_MEMBER)
+		return PERR_NONE;
+
+	if (cpumask_empty(new_excpus))
+		return PERR_INVCPUS;
+
+	if (prstate_housekeeping_conflict(new_prs, new_excpus))
+		return PERR_HKEEPING;
+
+	if (tasks_nocpu_error(parent, cs, new_excpus))
+		return PERR_NOCPUS;
+
+	return PERR_NONE;
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
@@ -1688,26 +1736,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
-/*
- * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
- * @prstate: partition root state to be checked
- * @new_cpus: cpu mask
- * Return: true if there is conflict, false otherwise
- *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
- * isolated partition.
- */
-static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
-{
-	if (!have_boot_isolcpus)
-		return false;
-
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
-		return true;
-
-	return false;
-}
-
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1809,19 +1837,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 
-		/*
-		 * Enabling partition root is not allowed if its
-		 * effective_xcpus is empty.
-		 */
-		if (cpumask_empty(xcpus))
-			return PERR_INVCPUS;
-
-		if (prstate_housekeeping_conflict(new_prs, xcpus))
-			return PERR_HKEEPING;
-
-		if (tasks_nocpu_error(parent, cs, xcpus))
-			return PERR_NOCPUS;
-
+		part_error = validate_partition(cs, new_prs, xcpus);
+		if (part_error)
+			return part_error;
 		/*
 		 * This function will only be called when all the preliminary
 		 * checks have passed. At this point, the following condition
@@ -2369,36 +2387,6 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
 	return 0;
 }
 
-/**
- * validate_partition - Validate a cpuset partition configuration
- * @cs: The cpuset to validate
- * @trialcs: The trial cpuset containing proposed configuration changes
- *
- * If any validation check fails, the appropriate error code is set in the
- * cpuset's prs_err field.
- *
- * Return: PRS error code (0 if valid, non-zero error code if invalid)
- */
-static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *trialcs)
-{
-	struct cpuset *parent = parent_cs(cs);
-
-	if (cs_is_member(trialcs))
-		return PERR_NONE;
-
-	if (cpumask_empty(trialcs->effective_xcpus))
-		return PERR_INVCPUS;
-
-	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
-					  trialcs->effective_xcpus))
-		return PERR_HKEEPING;
-
-	if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus))
-		return PERR_NOCPUS;
-
-	return PERR_NONE;
-}
-
 static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
 					struct tmpmasks *tmp)
 {
@@ -2453,7 +2441,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs_is_member(cs))
 		return;
 
-	prs_err = validate_partition(cs, trialcs);
+	prs_err = validate_partition(cs, trialcs->partition_root_state,
+				     trialcs->effective_xcpus);
 	if (prs_err)
 		trialcs->prs_err = cs->prs_err = prs_err;
 
-- 
2.34.1


