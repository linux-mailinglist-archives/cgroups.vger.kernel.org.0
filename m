Return-Path: <cgroups+bounces-12709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941ACDDC55
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF26301C08C
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D918FDDE;
	Thu, 25 Dec 2025 12:45:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C031F92E;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666756; cv=none; b=Ij7WPzswNnql5QXhKwOTXcNISTx+/pTIwXVjgsQmt3Jg1NBkKTr3dLGIgYxffxW8ATX9PmpaNN6RUuRL/uqmOph8bekxfhHHtc5F3mbCo7ieqUfd1obPEzw/fdpeOGGdr916jdIku+obIW177D+7rYIeLpMSulZNNs02veMhEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666756; c=relaxed/simple;
	bh=BGDGcF2rAUB26YRz0BfZCQp/rHxFjlNPUGc40BkvS8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMRpoXEGyEcnq03TjCOFQCbKE7qpkghxG3RNmJjmg5VlbiU/3xTU/Tlc0lnvmzrVa7Jb3qKoEzlPAguGOKnmHQdaIeSSS4/JZFYs7sPHQ8FblCmk4wah4qsDxtCEWhvah9lH+Vo2NAQ49Dgsa2u3ZO+HAQd6nXeGFf2yMx4ORR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3p5FC7zYQv0M;
	Thu, 25 Dec 2025 20:45:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1683340590;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S4;
	Thu, 25 Dec 2025 20:45:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 02/21] cpuset: generalize the validate_partition() interface
Date: Thu, 25 Dec 2025 12:30:39 +0000
Message-Id: <20251225123058.231765-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225123058.231765-1-chenridong@huaweicloud.com>
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWfXrWDCF1DCryfXF1kKrg_yoWrZryrpF
	y5GrW7J3yUtryak34ktas7Cw1Y9wnrX3WDtwnxJ3WSvFy7t34qyFyj9ws0yryfX39rG34U
	ZanI9F4fWFy7C3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU1c_TUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Refactor validate_partition() to accept a more generic parameter set,
making the interface flexible enough to handle both local and remote
partition validation scenarios. Additionally, a check for whether
isolated CPUs can be updated has been added to validate_partition().

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 87 +++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ffc732adf9a3..4543c2452be0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1442,6 +1442,41 @@ static inline bool is_local_partition(struct cpuset *cs)
 	return is_partition_valid(cs) && !is_remote_partition(cs);
 }
 
+/**
+ * validate_partition - Validate a cpuset partition configuration
+ * @cs: The cpuset to validate
+ * @new_prs: The proposed new partition root state
+ * @new_excpus: The new effective exclusive CPUs mask to validate
+ * @add: exclusive CPUs to be added
+ * @del: exclusive CPUs to be deleted
+ *
+ * Return: PRS error code (0 if valid, non-zero error code if invalid)
+ */
+static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
+	struct cpumask *new_excpus, struct cpumask *add, struct cpumask *del)
+{
+	struct cpuset *parent = parent_cs(cs);
+	int parent_prs = parent->partition_root_state;
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
+	if ((new_prs == PRS_ISOLATED) && (new_prs != parent_prs) &&
+	    !isolated_cpus_can_update(add, del))
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
@@ -1718,22 +1753,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
-		if ((new_prs == PRS_ISOLATED) && (new_prs != parent_prs) &&
-		    !isolated_cpus_can_update(xcpus, NULL))
-			return PERR_HKEEPING;
-
-		if (tasks_nocpu_error(parent, cs, xcpus))
-			return PERR_NOCPUS;
+		part_error = validate_partition(cs, new_prs, xcpus, xcpus, NULL);
+		if (part_error)
+			return part_error;
 
 		/*
 		 * This function will only be called when all the preliminary
@@ -2294,36 +2316,6 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
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
@@ -2378,7 +2370,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs_is_member(cs))
 		return;
 
-	prs_err = validate_partition(cs, trialcs);
+	prs_err = validate_partition(cs, trialcs->partition_root_state,
+			trialcs->effective_xcpus, trialcs->effective_xcpus, NULL);
 	if (prs_err)
 		trialcs->prs_err = cs->prs_err = prs_err;
 
-- 
2.34.1


