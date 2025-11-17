Return-Path: <cgroups+bounces-12026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05656C62317
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 646FE4EBDAB
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875C28C84D;
	Mon, 17 Nov 2025 03:01:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062C27602F;
	Mon, 17 Nov 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348514; cv=none; b=IHou8gYY2TReTOTedBUHErjvOYiLLQ9/Nfs58kwHy1n6teOvMNnNLQD9gVJcbyD9mRmRIa5eQQMP4ir6koeJHydrP66w2yoOw/P/HrcWZMAdOyuivggYrc5OD2dVghJM99X5o21YPoTQKIMJglZEm3nFBhyK+CnqcpUS4RXDoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348514; c=relaxed/simple;
	bh=cbdF7qXf0N1mRyT2Rnfsaxne9+GY6KwN4y4cBQTdpQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDxDY8NsSlDQskLCZBEPnY72Eoq00xngBmqVUbcBu6K2AZA5Jnr21EIDD+eCXD/kKrbmW5vt8hifw7yrK3iO7TiiGZ3FYFJkrvcQ5Uj2MV5o2btQLScX+Iu6IvYekKMdGrdNg/4iOOCBy5eQV1YAXdCdlDdu5BT9bQ1SEL0QFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY3xXtzKHMV2;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 187A81A1F09;
	Mon, 17 Nov 2025 11:01:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S17;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 15/21] cpuset: simplify partition update logic for hotplug tasks
Date: Mon, 17 Nov 2025 02:46:21 +0000
Message-Id: <20251117024627.1128037-16-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S17
X-Coremail-Antispam: 1UD129KBjvJXoWxXr47ZFy3tryrKrWxJr18Zrb_yoW7JryDpF
	y3CrW7tayUGr15u3sxJFs7A3yrKws7JFyjy3ZxJ3yrJF17Z3WvyFyjk395ZayYqryDXry7
	Za4qgr4xJF17ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 kernel/cgroup/cpuset.c | 64 +++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 43d5ea7d84a4..4e68e8edc827 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1237,17 +1237,6 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
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
 
@@ -3893,8 +3882,6 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
-	bool remote;
-	int partcmd = -1;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -3921,16 +3908,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * Compute effective_cpus for valid partition root, may invalidate
 	 * child partition roots if necessary.
 	 */
-	remote = is_remote_partition(cs);
-	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
+	if (is_remote_partition(cs)) {
 		compute_partition_effective_cpumask(cs, &new_cpus);
-
-	if (remote && cpumask_empty(&new_cpus) &&
-	    partition_is_populated(cs, NULL)) {
-		cs->prs_err = PERR_HOTPLUG;
-		remote_partition_disable(cs, tmp);
-		compute_effective_cpumask(&new_cpus, cs, parent);
-		remote = false;
+		if (cpumask_empty(&new_cpus) &&
+		    partition_is_populated(cs, NULL)) {
+			cs->prs_err = PERR_HOTPLUG;
+			remote_partition_disable(cs, tmp);
+			compute_effective_cpumask(&new_cpus, cs, parent);
+		}
+		goto update_tasks;
 	}
 
 	/*
@@ -3938,29 +3924,25 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * the following conditions hold:
 	 * 1) empty effective cpus but not valid empty partition.
 	 * 2) parent is invalid or doesn't grant any cpus to child
-	 *    partitions.
-	 */
-	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
-				tasks_nocpu_error(parent, cs, &new_cpus))) {
-		partcmd = partcmd_invalidate;
-		local_partition_disable(cs, cs->prs_err, tmp);
-	}
-	/*
+	 *  partitions.
+	 *
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one with a non-empty user xcpus.
+	 *
+	 * local_partition_update can handle these cases.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
-		 !cpumask_empty(user_xcpus(cs))) {
-		partcmd = partcmd_update;
-		local_partition_update(cs, tmp);
-	}
+	local_partition_update(cs, tmp);
+
+	/*
+	 * Recompute effective CPU mask after partition state update:
+	 * - For valid partitions: calculate partition-specific effective CPUs
+	 * - For invalid partitions: compute member effective CPU mask
+	 */
+	if (is_partition_valid(cs))
+		compute_partition_effective_cpumask(cs, &new_cpus);
+	else
+		compute_effective_cpumask(&new_cpus, cs, parent);
 
-	if (partcmd >= 0) {
-		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
-			compute_partition_effective_cpumask(cs, &new_cpus);
-			cpuset_force_rebuild();
-		}
-	}
 
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
-- 
2.34.1


