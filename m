Return-Path: <cgroups+bounces-10186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC08B7D309
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293E51C01CD8
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DD2F6171;
	Wed, 17 Sep 2025 06:20:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28722EA14E;
	Wed, 17 Sep 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090015; cv=none; b=UOytzX+GRARZBRGlBv9jZAGIn4/DH/koP0jXluQXshpC4V4ukSHpo2KbmtqwZRoFcIjOsYH6G+RevGNFN7h/YbiwvA+9d+oxUj0fzit0tfPneYCwkqnVCyp9w8rZhXGs5luOvFkN7kCDvvp2fQysYYnkj+mOl/qELb0BqGjmZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090015; c=relaxed/simple;
	bh=YktGUToia4YkHyBKbzYhR1W4xyYUA2YG2fcypizzwXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAQomxh9kYVJbywwuNIXvHr4ab7RKdetnE/PgofeSFj2TbebrOb44nMRu/RHnoUY5vSOcr7TTJlbYO0uGlQK9kchBY91cdEUvFvO2KD+UprngeLHQb5C3wjuJQ/uT0d+gmng1mYPL1OGmcvVvQwYRzq40xw73Mf42/t6TdozqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCF06hKzYQvY5;
	Wed, 17 Sep 2025 14:20:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 983171A1880;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S11;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 09/11] cpuset: introduce partition_cpus_change
Date: Wed, 17 Sep 2025 06:04:52 +0000
Message-Id: <20250917060454.2885698-10-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917060454.2885698-1-chenridong@huaweicloud.com>
References: <20250917060454.2885698-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCw18KF1UuF4DtrW5tF15XFb_yoWrAr15pF
	y7Cw42qrWUJryYka9xXrs29w45K3Z7X3WDtwnrJa4fWFy2q3sFvFy7t39avFy3Wr9ruFy8
	Zan0qrZ7WFZrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Introduce the partition_cpus_change function to handle both regular CPU
set updates and exclusive CPU modifications, either of which may trigger
partition state changes. This generalized function will also be utilized
for exclusive CPU updates in subsequent patches.

With the introduction of compute_trialcs_excpus in a previous patch,
the trialcs->effective_xcpus field is now consistently computed and
maintained. Consequently, the legacy logic which assigned
**trialcs->allowed_cpus to a local 'xcpus' variable** when
trialcs->effective_xcpus was empty has been removed.

This removal is safe because when trialcs is not a partition member,
trialcs->effective_xcpus is now correctly populated with the intersection
of user_xcpus and the parent's effective_xcpus. This calculation inherently
covers the scenario previously handled by the removed code.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ab8572038fce..6107f657bf35 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2454,6 +2454,43 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 	return retval;
 }
 
+/**
+ * partition_cpus_change - Handle partition state changes due to CPU mask updates
+ * @cs: The target cpuset being modified
+ * @trialcs: The trial cpuset containing proposed configuration changes
+ * @tmp: Temporary masks for intermediate calculations
+ *
+ * This function handles partition state transitions triggered by CPU mask changes.
+ * CPU modifications may cause a partition to be disabled or require state updates.
+ */
+static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
+					struct tmpmasks *tmp)
+{
+	enum prs_errcode prs_err;
+
+	if (cs_is_member(cs))
+		return;
+
+	prs_err = validate_partition(cs, trialcs);
+	if (prs_err)
+		trialcs->prs_err = cs->prs_err = prs_err;
+
+	if (is_remote_partition(cs)) {
+		if (trialcs->prs_err)
+			remote_partition_disable(cs, tmp);
+		else
+			remote_cpus_update(cs, trialcs->exclusive_cpus,
+					   trialcs->effective_xcpus, tmp);
+	} else {
+		if (trialcs->prs_err)
+			update_parent_effective_cpumask(cs, partcmd_invalidate,
+							NULL, tmp);
+		else
+			update_parent_effective_cpumask(cs, partcmd_update,
+							trialcs->effective_xcpus, tmp);
+	}
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2467,7 +2504,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	bool force = false;
 	int old_prs = cs->partition_root_state;
-	enum prs_errcode prs_err;
 
 	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
 	if (retval < 0)
@@ -2492,31 +2528,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
-	prs_err = validate_partition(cs, trialcs);
-	if (prs_err) {
-		trialcs->prs_err = prs_err;
-		cs->prs_err = prs_err;
-	}
-
-	if (is_partition_valid(cs) ||
-	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
-		struct cpumask *xcpus = trialcs->effective_xcpus;
-
-		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
-			xcpus = trialcs->cpus_allowed;
-
-		/*
-		 * Call remote_cpus_update() to handle valid remote partition
-		 */
-		if (is_remote_partition(cs))
-			remote_cpus_update(cs, NULL, xcpus, &tmp);
-		else if (trialcs->prs_err)
-			update_parent_effective_cpumask(cs, partcmd_invalidate,
-							NULL, &tmp);
-		else
-			update_parent_effective_cpumask(cs, partcmd_update,
-							xcpus, &tmp);
-	}
+	partition_cpus_change(cs, trialcs, &tmp);
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-- 
2.34.1


