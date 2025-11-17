Return-Path: <cgroups+bounces-12023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A887CC62314
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8F36211B
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB8286897;
	Mon, 17 Nov 2025 03:01:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B082765DC;
	Mon, 17 Nov 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348513; cv=none; b=LU2YMsAkGn47HzpsmGlkD3tph7wL3NoZrtM7IAfYsrRjMwdLzTyBHf3r7BhZGGTZgOtP/Eqad86e4ElT+2PT6pOAw4oFllzYCBwtfGoh5G4l8dRKOi7KyymStF3j4qAk2xmc8tP20lhT+d0BOFQB5Y1IkhI8OvRBbnq55LeEEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348513; c=relaxed/simple;
	bh=npe7iDFNvRqAJMwy4dV+slJiYVqy/J+R597kAkbNTcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBT02Ck/f74MMD4vGOmGPtImJcmTJIMcnbz7BaWarx0wrTEhsJZqTXPpcAJP5abgdjkM3VitRWEKaHErerzRkoICJ1yGsFC/HIPHEMPliKxaWQD9d2H30A+9HpCmo/OkJYgPITusu9U72uFq8Jo9qyi2COKd947aFTuMcRBrxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY262czKHMRk;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CA7DD1A1F2C;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S12;
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
Subject: [PATCH -next 10/21] cpuset: introduce local_partition_disable()
Date: Mon, 17 Nov 2025 02:46:16 +0000
Message-Id: <20251117024627.1128037-11-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xXw47CryxXFy8Kr43GFg_yoW5Aw4DpF
	y7GrW3K3yUXFy7ua9rJan7Aw1Fgws7JayxtwnrWayfXF17A3Wv9Fy0v39Yv3WjgFyDG347
	ZFn0qr4UWF1xArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The partition_disable() function introduced earlier can be extended to
handle local partition disablement.

The local_partition_disable() functions is introduced, which extracts the
local partition disable logic from update_parent_effective_cpumask(). It
calls partition_disable() to complete the disablement process.

This refactoring establishes a clear separation between local and remote
partition operations while promoting code reuse through the shared
partition_disable() infrastructure.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 43 ++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3c1e8431c234..fe166d7ed49d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1943,6 +1943,31 @@ static int local_partition_enable(struct cpuset *cs,
 	return 0;
 }
 
+/**
+ * local_partition_disable - Disable a local partition
+ * @cs: Target cpuset (local partition root) to disable
+ * @part_error: partition error when @cs is disabled
+ * @tmp: Temporary masks for CPU calculations
+ */
+static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_error,
+				    struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
+	int new_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	if (!is_partition_valid(cs))
+		return;
+
+	new_prs = part_error ? -cs->partition_root_state : 0;
+	partition_disable(cs, parent, new_prs, part_error);
+
+	cpuset_update_tasks_cpumask(parent, tmp->addmask);
+	update_sibling_cpumasks(parent, cs, tmp);
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -2033,19 +2058,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
-	if (cmd == partcmd_disable) {
-		/*
-		 * May need to add cpus back to parent's effective_cpus
-		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
-		 * for valid partition root. xcpus may contain CPUs that
-		 * shouldn't be removed from the two global cpumasks.
-		 */
-		if (is_partition_valid(cs)) {
-			cpumask_copy(tmp->addmask, cs->effective_xcpus);
-			adding = true;
-		}
-		new_prs = PRS_MEMBER;
-	} else if (newmask) {
+	if (newmask) {
 		/*
 		 * Empty cpumask is not allowed
 		 */
@@ -3188,9 +3201,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		if (is_remote_partition(cs))
 			remote_partition_disable(cs, &tmpmask);
 		else
-			update_parent_effective_cpumask(cs, partcmd_disable,
-							NULL, &tmpmask);
-
+			local_partition_disable(cs, PERR_NONE, &tmpmask);
 		/*
 		 * Invalidation of child partitions will be done in
 		 * update_cpumasks_hier().
-- 
2.34.1


