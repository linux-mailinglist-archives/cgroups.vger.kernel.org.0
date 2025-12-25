Return-Path: <cgroups+bounces-12721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9041CDDC72
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DFE0301B11B
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6B3277B8;
	Thu, 25 Dec 2025 12:46:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731C2AD2C;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666762; cv=none; b=tlfszMXno2h+xg59ZclrQcmT2arGl8fW8vY0EoLgwIpCUDT/0iTLGJ7l57bzNZGFjLjnhkjn6rWn9aM6vNx9GTzDvZFN6oNhnx6YO8igP/kNqLuRSwXnKw6uFCtprITKmy4cl7AA8Hd3Uw8jG8KYvQHYrgigWayo8E2ZwO+kNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666762; c=relaxed/simple;
	bh=dDqQHo/kcKiA+eNZqCMpoFB91WRsN40u0+GqFcg8384=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4TMVDIHlOo2zHHw+Y8yM7kC08GwEPLpqx+1vA7deM6vrNRiqdhbusM4ZTqXFG9kH2wbcVnSDeZrj4HF2c9VBNekTjoLCDgJ6AEEOfTie9J1xXPtpMXEMoecohJCoykwy/6HiN11jKytpORWeRxMYH4YDuwRqAERnwL8CZVthas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3q3sHMzYQv6Q;
	Thu, 25 Dec 2025 20:45:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB0FD40575;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S17;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH RESEND -next 15/21] cpuset: simplify partition update logic for hotplug tasks
Date: Thu, 25 Dec 2025 12:30:52 +0000
Message-Id: <20251225123058.231765-16-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S17
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr48Gw18GrWUtr4DWw48JFb_yoW7WFWfpF
	y3CrW7tayUGr1YkasxJFs7A3yrKwn7JF1qy3ZxJ3yrJF17Zw1vyFyjk395Zay5X34DXryU
	Za4DWr4xXF17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPU
	UUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Simplify the partition update logic in cpuset_hotplug_update_tasks() by
calling the unified local_partition_update() interface.

For local partitions, the previous patch introduced local_partition_update
which handles both validation state transitions:
- Invalidates local partitions that fail validation checks
- Transitions invalid partitions to valid state when no errors are detected

This eliminates the need for separate transition logic
in cpuset_hotplug_update_tasks(), which can now simply call
local_partition_update() to handle all local partition changes.

For remote partitions, the logic is adjusted to always proceed to
update_tasks regardless of whether the partition was disabled, as the
original skip condition was not valid for remote partitions. This change
maintains existing functionality while simplifying the code path.

The partition_cmd emum type can now be safely removed as it is no longer
referenced by any code paths after the partition update logic
simplification.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 75 ++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a1df78a75575..99413472a0fb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1072,17 +1072,6 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
 	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
 }
 
-/*
- * Commands for update_parent_effective_cpumask
- */
-enum partition_cmd {
-	partcmd_enable,		/* Enable partition root	  */
-	partcmd_enablei,	/* Enable isolated partition root */
-	partcmd_disable,	/* Disable partition root	  */
-	partcmd_update,		/* Update parent's effective_cpus */
-	partcmd_invalidate,	/* Make partition invalid	  */
-};
-
 static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 				    struct tmpmasks *tmp);
 
@@ -3701,8 +3690,6 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
-	bool remote;
-	int partcmd = -1;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -3729,50 +3716,38 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * Compute effective_cpus for valid partition root, may invalidate
 	 * child partition roots if necessary.
 	 */
-	remote = is_remote_partition(cs);
-	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
+	if (is_remote_partition(cs)) {
 		compute_partition_effective_cpumask(cs, &new_cpus);
-
-	if (remote && (cpumask_empty(subpartitions_cpus) ||
-			(cpumask_empty(&new_cpus) &&
-			 partition_is_populated(cs, NULL)))) {
-		cs->prs_err = PERR_HOTPLUG;
-		remote_partition_disable(cs, tmp);
-		compute_effective_cpumask(&new_cpus, cs, parent);
-		remote = false;
+		if (cpumask_empty(subpartitions_cpus) ||
+		    (cpumask_empty(&new_cpus) &&
+		     partition_is_populated(cs, NULL))) {
+			cs->prs_err = PERR_HOTPLUG;
+			remote_partition_disable(cs, tmp);
+			compute_effective_cpumask(&new_cpus, cs, parent);
+		}
+		goto update_tasks;
 	}
 
 	/*
-	 * Force the partition to become invalid if either one of
-	 * the following conditions hold:
-	 * 1) empty effective cpus but not valid empty partition.
-	 * 2) parent is invalid or doesn't grant any cpus to child
-	 *    partitions.
-	 * 3) subpartitions_cpus is empty.
-	 */
-	if (is_local_partition(cs) &&
-	    (!is_partition_valid(parent) ||
-	     tasks_nocpu_error(parent, cs, &new_cpus) ||
-	     cpumask_empty(subpartitions_cpus))) {
-		partcmd = partcmd_invalidate;
-		local_partition_disable(cs, cs->prs_err, tmp);
-	}
-	/*
-	 * On the other hand, an invalid partition root may be transitioned
-	 * back to a regular one with a non-empty user xcpus.
+	 * The subpartitions_cpus may be cleared if no CPUs remain available for
+	 * the top_cpuset. In this case, disable the local partition directly.
+	 * Otherwise, local_partition_update will handle the automatic transition
+	 * between valid and invalid partition states.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
-		 !cpumask_empty(user_xcpus(cs))) {
-		partcmd = partcmd_update;
+	if (is_local_partition(cs) && cpumask_empty(subpartitions_cpus))
+		local_partition_disable(cs, PERR_HOTPLUG, tmp);
+	else
 		local_partition_update(cs, tmp);
-	}
 
-	if (partcmd >= 0) {
-		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
-			compute_partition_effective_cpumask(cs, &new_cpus);
-			cpuset_force_rebuild();
-		}
-	}
+	/*
+	 * Recompute effective CPU mask after partition state update:
+	 * - For valid partitions: calculate partition-specific effective CPUs
+	 * - For invalid partitions: compute member effective CPU mask
+	 */
+	if (is_partition_valid(cs))
+		compute_partition_effective_cpumask(cs, &new_cpus);
+	else
+		compute_effective_cpumask(&new_cpus, cs, parent);
 
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
-- 
2.34.1


