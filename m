Return-Path: <cgroups+bounces-12016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7972C622F8
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 04:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6C3AA023
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59A2741DF;
	Mon, 17 Nov 2025 03:01:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E86241695;
	Mon, 17 Nov 2025 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348509; cv=none; b=CG2rmAoDzWfhDnSBHuxuWa5HRSze8SyOvheipjtwG7GebbhuFpJo/A45/FRm/itq3K8VlZwFx6Ys4RKlT15t2kr2Ba+hHDKQgTjSoeFFk1b+NCKONk5zeXwHqBWlz4ytFa6urfex/wUTIkOXm2g1XWGxBuW0q1UdsmP3EnI/ymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348509; c=relaxed/simple;
	bh=4lB97ZpdlsEoc5IRIjC3KTpVgYeFKUaNHSdlOk91siI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5nsDqwQ/mTHnav2lpj00dg9R32iTNw2d76wLk8Eq/3J4hChp2gmOsCWREShRin5RQ9V3ftKg3CJ51bH/eRPYIjKGBIs+houcd6IiBQn3ZFXDPq1OJ0hz68cm8c6G1+m2QODa2PWlUb7MXbjPK2kQP2O4rnlN3VZjUiwTYtLsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8svY0FjKzKHMR8;
	Mon, 17 Nov 2025 11:01:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8949D1A07C0;
	Mon, 17 Nov 2025 11:01:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHr5jxpp+kwRBA--.27716S6;
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
Subject: [PATCH -next 04/21] cpuset: introduce partition_disable()
Date: Mon, 17 Nov 2025 02:46:10 +0000
Message-Id: <20251117024627.1128037-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA3lHr5jxpp+kwRBA--.27716S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUtryUuF13Zr1kJF4fXwb_yoW8Kw43pF
	1kCr43G3yYgr13u3sxJan7uw4rKa1kXFy7tw17Xw1rJFy7Aa4qva4vk39Iv3WUXrWDW345
	ZanIqr4xWF17A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add partition_disable() to consolidate updates to key cpuset structures
during partition disablement, including:
1. remote_partition
2. effective_xcpus
3. partition_root_state
4. prs_err

Key operations performed:
1. Cleaning up remote_partition
2. Removing exclusive CPUs via partition_xcpus_del()
3. Recomputing effective exclusive CPUs mask
4. Updating partition state and error status
5. Triggering required scheduler domain rebuilds
6. Clear exclusive flag.
7. Sends partition change notifications

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b917f2c55767..a85f9619c982 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1686,6 +1686,39 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
 	notify_partition_change(cs, old_prs);
 }
 
+/**
+ * partition_disable - Disable partition root state for a cpuset
+ * @cs: The cpuset to disable partition for
+ * @parent: Parent cpuset of @cs, NULL for remote parent
+ * @new_prs: New partition root state (should be non-positive)
+ * @prs_err: Error code to set if disabling due to validation failure
+ */
+static void partition_disable(struct cpuset *cs, struct cpuset *parent,
+			      int new_prs, enum prs_errcode prs_err)
+{
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs > 0);
+	WARN_ON_ONCE(!cpuset_v2());
+
+	old_prs = cs->partition_root_state;
+	spin_lock_irq(&callback_lock);
+	cs->remote_partition = false;
+	/* disable a partition should only delete exclusive cpus */
+	partition_xcpus_del(cs->partition_root_state,
+			    parent, cs->effective_xcpus);
+	/* effective_xcpus may need to be changed */
+	compute_excpus(cs, cs->effective_xcpus);
+	partition_state_update(cs, new_prs, prs_err);
+	spin_unlock_irq(&callback_lock);
+	update_isolation_cpumasks();
+	cpuset_force_rebuild();
+	/* Clear exclusive flag; no errors are expected */
+	update_partition_exclusive_flag(cs, new_prs);
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
-- 
2.34.1


