Return-Path: <cgroups+bounces-11165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97905C08CED
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0343AD6B6
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005402E06C9;
	Sat, 25 Oct 2025 07:03:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449022DEA93;
	Sat, 25 Oct 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375839; cv=none; b=bl6urNDRrKEKfDS9EnTezlDE3gKSXETALuvMbQUQfwy/3J7wLPbDQqn6a/5nCxcHJvnISGsYecLLZB8zNe0DozrIJA1QqQIGnBsNuIQrl7041EtJKGgpMOdiZ5zepOPcqpt6xg1EYD/cKVNY1cZIoNstb4TCRSdrWmv+RNZxMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375839; c=relaxed/simple;
	bh=kLTVlC4HH/nUSUlQoROhHNgSYIxw9RkDR6ebBrUsYLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvshtJ1t8TLhDz3IyM37ZHH8GzsnkSpyD2bLDo1JLQYcGsDNABAU5F30PGq9NPuIR/xlSxCvEL+dm2afOhddSv/8Mzw8tfkANVAq1GXJv0u94mTmu4aJLgd02G5/fHwXFHaHcWDB2M9GIAIn5rjyZJDjnWJ4iC8sKiQmTIGTMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrLz1qfYzYQtv9;
	Sat, 25 Oct 2025 15:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 262521A0E4A;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S6;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH RFC v2 04/22] cpuset: introduce partition_enable()
Date: Sat, 25 Oct 2025 06:48:26 +0000
Message-Id: <20251025064844.495525-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025064844.495525-1-chenridong@huaweicloud.com>
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47WF4DWw43tF47JrW3Awb_yoW5Aw4xpF
	n8Cr4fGayUtry3C3sxJFs7uw4Fgan7XF1UtwnxX34rXF17Ja4qka4jk39xta1UXryDGry5
	ZFsIqr4xWF47AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add partition_enable() to consolidate updates to key cpuset structures
during partition enablement, including:
- remote_sibling
- effective_xcpus
- partition_root_state
- prs_err

Key operations performed:
- Invokes partition_xcpus_add() to assign exclusive CPUs
- Maintains remote partition sibling links
- Syncs the effective_xcpus mask
- Updates partition_root_state and prs_err
- Triggers scheduler domain rebuilds
- Sends partition change notifications

This helper enables transitions between root and isolated states. All
fields except remote_sibling are reassigned during the transition.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 493e094961da..c767d1be6bbb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1521,6 +1521,55 @@ static inline bool is_local_partition(struct cpuset *cs)
 	return is_partition_valid(cs) && !is_remote_partition(cs);
 }
 
+static void partition_state_update(struct cpuset *cs, int new_prs,
+				   enum prs_errcode prs_err)
+{
+	lockdep_assert_held(&callback_lock);
+
+	cs->partition_root_state = new_prs;
+	WRITE_ONCE(cs->prs_err, prs_err);
+	if (!is_partition_valid(cs))
+		reset_partition_data(cs);
+}
+
+/**
+ * partition_enable - Transitions a cpuset to a partition root
+ * @cs: The cpuset to enable partition for
+ * @parent: Parent cpuset of @cs, NULL for remote parent
+ * @new_prs: New partition state to set
+ * @new_excpus: New effective exclusive CPUs mask for the partition
+ *
+ * Transitions a cpuset to a partition root, only for v2.
+ * It supports the transition between root and isolated partition.
+ */
+static void partition_enable(struct cpuset *cs, struct cpuset *parent,
+			     int new_prs, struct cpumask *new_excpus)
+{
+	bool isolcpus_updated;
+	int old_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs <= 0);
+	WARN_ON_ONCE(!cpuset_v2());
+
+	if (cs->partition_root_state == new_prs)
+		return;
+
+	old_prs = cs->partition_root_state;
+	spin_lock_irq(&callback_lock);
+	/* enable partition should only add exclusive cpus */
+	isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
+	/* enable remote partition */
+	if (!parent && list_empty(&cs->remote_sibling))
+		list_add(&cs->remote_sibling, &remote_children);
+	cpumask_copy(cs->effective_xcpus, new_excpus);
+	partition_state_update(cs, new_prs, PERR_NONE);
+	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cpuset_force_rebuild();
+	notify_partition_change(cs, old_prs);
+}
+
 /*
  * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
  * @prstate: partition root state to be checked
-- 
2.34.1


