Return-Path: <cgroups+bounces-12706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8BCDDC3A
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C796A30219C5
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472F303A05;
	Thu, 25 Dec 2025 12:45:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B01096F;
	Thu, 25 Dec 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666756; cv=none; b=YUdqrC1uPxe3C6159ppOniASL2Jp5IPPjonokYxzucaYNtJrmGbpUGYsu14grc76c+N9oRWcoc4ZkraFoEdXSGMN0EDts1DkNRmmul2PEd3RNW/enhcPPG05W4eDlzHppPeTqGJXiE80ago1YIemA6SCy2/2jWgXK9yyryFWTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666756; c=relaxed/simple;
	bh=p+wP1mMC8gaHmC7CnNCKb2rUi91QHEdpPXjVtJtCo8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlsNK4zG0yHSEbutHmhQS069qbIe92OgIBZAD2/DLLwvsadbUY51cjNGL1/DnxABNqusBCY7j/v/vIwBtdGa9I35aXonzkPnGTK6mNIDe5+0k8c/jqx5swS5gSqZwWMVs9x32OpyZbOvH5UFePBpEDqveqTJsx5igm2jicKm9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcT4B1ZBJzKHMj0;
	Thu, 25 Dec 2025 20:45:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8A21A40579;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S13;
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
Subject: [PATCH RESEND -next 11/21] cpuset: user local_partition_disable() to invalidate local partition
Date: Thu, 25 Dec 2025 12:30:48 +0000
Message-Id: <20251225123058.231765-12-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGw18Ar17AF18uF15Xw4fZrb_yoW5KFy5pF
	y3CrW7tayUGr15uasxXan2934FganrJa4qy3ZxXayrJFy7A3WvyF1jva9av345Xa4kGryU
	ZayYgr4fGFy7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbx9NDUU
	UUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Build on the local_partition_disable() infrastructure introduced in the
previous patch to handle local partition invalidation.

Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
when determining whether to transition an invalid partition root, the check
should be based on non-empty user_xcpus rather than non-empty
effective_xcpus. This correction addresses the scenario where
exclusive_cpus is not set but cpus_allowed is configured. In this case,
effective_xcpus may be empty even though the partition should be considered
for re-enablement. The user_xcpus based check ensures proper partition
state transitions under these conditions.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27179db4cd22..8f70867a9fe4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1874,22 +1874,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
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
@@ -2465,7 +2449,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
+				local_partition_disable(cp, PERR_NOTEXCL, tmp);
 				rcu_read_lock();
 			}
 		}
@@ -2505,8 +2489,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 					   trialcs->effective_xcpus, tmp);
 	} else {
 		if (trialcs->prs_err)
-			update_parent_effective_cpumask(cs, partcmd_invalidate,
-							NULL, tmp);
+			local_partition_disable(cs, trialcs->prs_err, tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
 							trialcs->effective_xcpus, tmp);
@@ -3916,18 +3899,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_local_partition(cs) &&
 	    (!is_partition_valid(parent) ||
 	     tasks_nocpu_error(parent, cs, &new_cpus) ||
-	     cpumask_empty(subpartitions_cpus)))
+	     cpumask_empty(subpartitions_cpus))) {
 		partcmd = partcmd_invalidate;
+		local_partition_disable(cs, cs->prs_err, tmp);
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


