Return-Path: <cgroups+bounces-12467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDECCA106
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70BD301D670
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899342D29B7;
	Thu, 18 Dec 2025 02:14:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A202C11EE;
	Thu, 18 Dec 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024090; cv=none; b=fckYInm8uipMnKW/D2UyseMkwEG7mOSh5d+/MKqT3AHd6Xe1zGRDhFUTmSyTyDE+dFYaT48MX2hoF3JyDAl00WuVlhKJBJSrESotNbbOb5iv8nMsaTEnDGK77qwJg5DpNfcbSKD5E5PveYfwSxd2lizGLu/9c6zpXBFbI8RZSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024090; c=relaxed/simple;
	bh=AGtIt/h7j5t7ydj+SdmpwUfnqANNLRl1jKikZSpt7fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcINLBHEtU4XpRUaQJJYpYNuQO9pv9PwWah5qEnNlLtQGXG2hGyo/JaFP25T/Y5yx8hZ+BnJ1GSbPLBU/0ANzAA//k5xOicBasKFqWXlG3mUgRM7d1bTifDhQ1o8CBBjT5TaoJj6JM1LVLmq83cvSXHbe+z7fynh1iFWX1ihKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dWvPQ63S5zKHLw0;
	Thu, 18 Dec 2025 10:14:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CA31F4056D;
	Thu, 18 Dec 2025 10:14:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgD3D3+KY0NpieZGAg--.21752S2;
	Thu, 18 Dec 2025 10:14:44 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2] cpuset: fix warning when disabling remote partition
Date: Thu, 18 Dec 2025 01:59:50 +0000
Message-Id: <20251218015950.2667813-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3D3+KY0NpieZGAg--.21752S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw17Jr1UXr4rXw17urW3Jrb_yoWrKry3pF
	yUKr4UGrW0gr15Cay3JF4xZw1rKan7AFW2yrnrG34rJF17A3WvkFyjk398J34UWrWDGry7
	ZayDur4FqF9rAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A warning was triggered as follows:

WARNING: kernel/cgroup/cpuset.c:1651 at remote_partition_disable+0xf7/0x110
RIP: 0010:remote_partition_disable+0xf7/0x110
RSP: 0018:ffffc90001947d88 EFLAGS: 00000206
RAX: 0000000000007fff RBX: ffff888103b6e000 RCX: 0000000000006f40
RDX: 0000000000006f00 RSI: ffffc90001947da8 RDI: ffff888103b6e000
RBP: ffff888103b6e000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: ffff88810b2e2728 R12: ffffc90001947da8
R13: 0000000000000000 R14: ffffc90001947da8 R15: ffff8881081f1c00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f55c8bbe0b2 CR3: 000000010b14c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 update_prstate+0x2d3/0x580
 cpuset_partition_write+0x94/0xf0
 kernfs_fop_write_iter+0x147/0x200
 vfs_write+0x35d/0x500
 ksys_write+0x66/0xe0
 do_syscall_64+0x6b/0x390
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f55c8cd4887

Reproduction steps (on a 16-CPU machine):

        # cd /sys/fs/cgroup/
        # mkdir A1
        # echo +cpuset > A1/cgroup.subtree_control
        # echo "0-14" > A1/cpuset.cpus.exclusive
        # mkdir A1/A2
        # echo "0-14" > A1/A2/cpuset.cpus.exclusive
        # echo "root" > A1/A2/cpuset.cpus.partition
        # echo 0 > /sys/devices/system/cpu/cpu15/online
        # echo member > A1/A2/cpuset.cpus.partition

When CPU 15 is offlined, subpartitions_cpus gets cleared because no CPUs
remain available for the top_cpuset, forcing partitions to share CPUs with
the top_cpuset. In this scenario, disabling the remote partition triggers
a warning stating that effective_xcpus is not a subset of
subpartitions_cpus. Partitions should be invalidated in this case to
inform users that the partition is now invalid(cpus are shared with
top_cpuset).

To fix this issue:
1. Only emit the warning only if subpartitions_cpus is not empty and the
   effective_xcpus is not a subset of subpartitions_cpus.
2. During the CPU hotplug process, invalidate partitions if
   subpartitions_cpus is empty.

Fixes: f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---

v2:
1. update the fixes commit id.

 kernel/cgroup/cpuset.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3e3468d928f3..77ca77e79da9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1502,7 +1502,14 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
 	WARN_ON_ONCE(!is_remote_partition(cs));
-	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
+	/*
+	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
+	 * which should clear subpartitions_cpus. We should not emit a warning for this
+	 * scenario: the hierarchy is updated from top to bottom, so subpartitions_cpus
+	 * may already be cleared when disabling the partition.
+	 */
+	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus) &&
+		     !cpumask_empty(subpartitions_cpus));
 
 	spin_lock_irq(&callback_lock);
 	cs->remote_partition = false;
@@ -3772,8 +3779,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
 		compute_partition_effective_cpumask(cs, &new_cpus);
 
-	if (remote && cpumask_empty(&new_cpus) &&
-	    partition_is_populated(cs, NULL)) {
+	if (remote && (cpumask_empty(subpartitions_cpus) ||
+			(cpumask_empty(&new_cpus) &&
+			 partition_is_populated(cs, NULL)))) {
 		cs->prs_err = PERR_HOTPLUG;
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
@@ -3786,9 +3794,12 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * 1) empty effective cpus but not valid empty partition.
 	 * 2) parent is invalid or doesn't grant any cpus to child
 	 *    partitions.
+	 * 3) subpartitions_cpus is empty.
 	 */
-	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
-				tasks_nocpu_error(parent, cs, &new_cpus)))
+	if (is_local_partition(cs) &&
+	    (!is_partition_valid(parent) ||
+	     tasks_nocpu_error(parent, cs, &new_cpus) ||
+	     cpumask_empty(subpartitions_cpus)))
 		partcmd = partcmd_invalidate;
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
-- 
2.34.1


