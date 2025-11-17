Return-Path: <cgroups+bounces-12022-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B159FC62338
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EC93B601E
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4C928641D;
	Mon, 17 Nov 2025 03:01:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B562765D4;
	Mon, 17 Nov 2025 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348513; cv=none; b=F/jfZL3QCCCf74Y/kXPolWjIan0LLeV2iueLlrL/fKqdtLG5NmvSLzVT0ej8nt+6oli0U61PJaeFEBMsvjlvQB1PPY2vTeQnYZHho0w0s0gNU7Dm3ilZMhwHzcXTt7O8QQWOnDEBVxTdeWEcxrWLvTUtA73T5pajd7xtAIX810E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348513; c=relaxed/simple;
	bh=wm+qU9+eoyiw4f9P/ciFTl/xoArmOY6deK0F2G1q+uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1fNGx3z+m1m7EtI09H1T6znqfpCaTrK8/rSDyzrANkuXN6IZkYtUeT6bLaSSflS+2vkttHe2lNyBDZw3Xd2bnPjNgBcMDnnE9GOJCkQzK7zqvqFbWxeayloHBm47GVukzW/oaUfi0n8+cZvgq9CAcSkTVkMrJ80X7PtHRsDB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY0TfQzKHMR8;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 92E911A1A52;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S7;
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
Subject: [PATCH -next 05/21] cpuset: introduce partition_update()
Date: Mon, 17 Nov 2025 02:46:11 +0000
Message-Id: <20251117024627.1128037-6-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Xw43ur1kCFWxWr4rKrg_yoW5Wr4UpF
	ykCr43XayUKr13u3sxJFs7uw4rKan2qF12ywnrXw1rJFy7t3W0v34vy3s8Jr1UX39rGry5
	XFsIqr4SgF13AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Introduce partition_update() to centralize updates to key cpuset structures
during a partition update, including:
1. effective_xcpus
2. exclusive_cpus

Key operations performed:
1. Adding and removing exclusive CPUs via partition_xcpus_add()/del()
2. Synchronizing the effective exclusive CPUs mask
3. Updating the exclusive CPUs mask when modification is required
4. Triggering necessary system updates and workqueue synchronization
5. Updating the partition's exclusive flag
6. Sending partition change notifications

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a85f9619c982..97e3bcd3d073 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1719,6 +1719,51 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 	notify_partition_change(cs, old_prs);
 }
 
+/**
+ * partition_update - Update an existing partition configuration
+ * @cs: The cpuset to update
+ * @prs: Partition root state (must be positive)
+ * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
+ * @excpus: New effective exclusive CPUs mask
+ * @tmp: Temporary masks
+ *
+ * Updates partition-related fields. The tmp->addmask is the CPU mask that
+ * will be added to the subpartitions_cpus and removed from parent's
+ * effective_cpus, and the tmp->delmask vice versa.
+ */
+static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
+				  struct cpumask *excpus, struct tmpmasks *tmp)
+{
+	struct cpuset *parent;
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(!cpuset_v2());
+	WARN_ON_ONCE(prs <= 0);
+
+	if (cpumask_empty(tmp->addmask) &&
+	    cpumask_empty(tmp->delmask))
+		return;
+
+	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
+	old_prs = cs->partition_root_state;
+	spin_lock_irq(&callback_lock);
+	partition_xcpus_add(prs, parent, tmp->addmask);
+	partition_xcpus_del(prs, parent, tmp->delmask);
+	/*
+	 * Need to update effective_xcpus and exclusive_cpus now as
+	 * update_sibling_cpumasks() below may iterate back to the same cs.
+	 */
+	cpumask_copy(cs->effective_xcpus, excpus);
+	if (xcpus)
+		cpumask_copy(cs->exclusive_cpus, xcpus);
+	spin_unlock_irq(&callback_lock);
+	update_isolation_cpumasks();
+	cpuset_force_rebuild();
+	update_partition_exclusive_flag(cs, prs);
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
-- 
2.34.1


