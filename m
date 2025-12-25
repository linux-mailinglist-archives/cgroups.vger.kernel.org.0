Return-Path: <cgroups+bounces-12715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7DCDDC8A
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F9E3089457
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4F325733;
	Thu, 25 Dec 2025 12:46:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC82322DD4;
	Thu, 25 Dec 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666761; cv=none; b=ttecN13eFJmVhBojTTcuWyYZs1iDtW0jtTZcaXhC/Imp2O0+5Nappfiebo81AaB2r0rfU39eu8SPg2+DkFP4G6ASf5tBk4ZLdYzQ+dN/RvY/K+bH6OkjzVLH9Z9eHdJ2jizIod9ncPKRaXzsSplHhD3+Jl4JUTFe3/GC7rOfh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666761; c=relaxed/simple;
	bh=AmkywKE1kek5N/SO7TNWTpG/4hYPc6YpRyDpYrbl9X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKbdJhrCpgerKFA4D+2D4h9c6FSqTQsHiA8u60lKWwExjy1WTHuiF2RG8hdS1W+kFJTs9yD6Juq0F+C7W4nZWWuOcWDh9lmcAg3zvipkokHTeVR/1ZLcHu6FpvM5bod7ZHRZcxwaSAMG3V2SrQWv2MYD7/hBtLUYZLHqnp05tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcT3q0mxQzYQv60;
	Thu, 25 Dec 2025 20:45:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 722584056F;
	Thu, 25 Dec 2025 20:45:51 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfb1MU1pT76_BQ--.27441S11;
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
Subject: [PATCH RESEND -next 09/21] cpuset: introduce local_partition_enable()
Date: Thu, 25 Dec 2025 12:30:46 +0000
Message-Id: <20251225123058.231765-10-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225123058.231765-1-chenridong@huaweicloud.com>
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfb1MU1pT76_BQ--.27441S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUXw4Dtry8tr48XF43Wrg_yoWruw1DpF
	y7GrZFqFWjqryrC39xJan7Cw1rKws8tFZFywnxX34rXFy7Aw4vyFy0y39xtFyjgayDury5
	Za9Fqr4xWFyUArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbx9NDUU
	UUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The partition_enable() function introduced in the previous patch can be
reused to enable local partitions.

The local_partition_enable() function is introduced, which factors out the
local partition enablement logic from update_parent_effective_cpumask().
After passing local partition validation checks, it delegates to
partition_enable() to complete the partition setup.

This refactoring creates a clear separation between local and remote
partition operations while maintaining code reuse through the shared
partition_enable() infrastructure.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 86 ++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 73d9a8df3072..4146e9e7d104 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1743,6 +1743,52 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
+/**
+ * local_partition_enable - Enable local partition for a cpuset
+ * @cs: Target cpuset to become a local partition root
+ * @new_prs: New partition root state to apply
+ * @tmp: Temporary masks for CPU calculations
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int local_partition_enable(struct cpuset *cs,
+				int new_prs, struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
+	enum prs_errcode err;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	/*
+	 * The parent must be a partition root.
+	 * The new cpumask, if present, or the current cpus_allowed must
+	 * not be empty.
+	 */
+	if (!is_partition_valid(parent)) {
+		return is_partition_invalid(parent)
+			? PERR_INVPARENT : PERR_NOTPART;
+	}
+
+	/*
+	 * Need to call compute_excpus() in case
+	 * exclusive_cpus not set. Sibling conflict should only happen
+	 * if exclusive_cpus isn't set.
+	 */
+	if (compute_excpus(cs, tmp->new_cpus))
+		WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
+
+	err = validate_partition(cs, new_prs, tmp->new_cpus, tmp->new_cpus, NULL);
+	if (err)
+		return err;
+
+	partition_enable(cs, parent, new_prs, tmp->new_cpus);
+
+	cpuset_update_tasks_cpumask(parent, tmp->addmask);
+	update_sibling_cpumasks(parent, cs, tmp);
+	return 0;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1833,35 +1879,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
-	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
-		/*
-		 * Need to call compute_excpus() in case
-		 * exclusive_cpus not set. Sibling conflict should only happen
-		 * if exclusive_cpus isn't set.
-		 */
-		xcpus = tmp->delmask;
-		if (compute_excpus(cs, xcpus))
-			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
-		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
-
-		part_error = validate_partition(cs, new_prs, xcpus, xcpus, NULL);
-		if (part_error)
-			return part_error;
-
-		/*
-		 * This function will only be called when all the preliminary
-		 * checks have passed. At this point, the following condition
-		 * should hold.
-		 *
-		 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
-		 *
-		 * Warn if it is not the case.
-		 */
-		cpumask_and(tmp->new_cpus, xcpus, cpu_active_mask);
-		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
-
-		deleting = true;
-	} else if (cmd == partcmd_disable) {
+	if (cmd == partcmd_disable) {
 		/*
 		 * May need to add cpus back to parent's effective_cpus
 		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
@@ -2993,14 +3011,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
 		 */
-		if (is_partition_valid(parent)) {
-			enum partition_cmd cmd = (new_prs == PRS_ROOT)
-					       ? partcmd_enable : partcmd_enablei;
-
-			err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
-		} else {
+		if (is_partition_valid(parent))
+			err = local_partition_enable(cs, new_prs, &tmpmask);
+		else
 			err = remote_partition_enable(cs, new_prs, &tmpmask);
-		}
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
-- 
2.34.1


