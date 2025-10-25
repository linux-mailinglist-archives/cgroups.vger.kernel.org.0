Return-Path: <cgroups+bounces-11157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0EC08C93
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 09:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57524350DF5
	for <lists+cgroups@lfdr.de>; Sat, 25 Oct 2025 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD22DC337;
	Sat, 25 Oct 2025 07:03:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D614A8E;
	Sat, 25 Oct 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375834; cv=none; b=PI/4Zbaw1zf5VInBLcg8Oe1HVMBJwBWruRuWRvhJyUWIk3t9h02eHamc7uAOPrf4e8WvmMeR7Hnw09Iygja83GMHqUuhOmQgRZxB3o3dGweX6JTIMT69dU0Mcsw+rpgs2LL35zUYW8pteWa4pyO2rXpMG3evaUbBS6DasoFXFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375834; c=relaxed/simple;
	bh=zMj8din3XlIKqBsiahbYfolQGDG/Oh3hfi+F58U+smw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIESNPFEH8ao6pzIE0Wb6s1wacFzz15fDrfXVYFPkDhVsWhI2RtnGhd3vRB0dzc5wXDeIKiBUebb+IGifhNtJV5EjiAHiS+HWXXTC8BxbjS9HCryvkKAD1mKN8L8rTnMNCbDqafGx7oXZXj8DLCdBAplR5tYuv5dCifQnG4W2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctrM63xwzzKHMZC;
	Sat, 25 Oct 2025 15:02:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7536C1A19C8;
	Sat, 25 Oct 2025 15:03:50 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHKUJGdvxovSssBg--.49460S13;
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
Subject: [PATCH RFC v2 11/22] cpuset: introduce local_partition_disable()
Date: Sat, 25 Oct 2025 06:48:33 +0000
Message-Id: <20251025064844.495525-12-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHKUJGdvxovSssBg--.49460S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xXw47CryxXFy8tFWxXrb_yoW5trW5pr
	y7GrW3K3yUXF1xu3y3Jan7Aw1rKws7Jayxt3sxWayfJFy7A3Wv9Fy0va9Yv3WUWFyDGFy7
	ZF90qr4UWF17ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
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
 kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b308d9f80eef..f36d17a4d8cd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1877,6 +1877,43 @@ static int local_partition_enable(struct cpuset *cs,
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
+	bool cpumask_updated = false;
+	int new_prs;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	if (!is_partition_valid(cs))
+		return;
+
+	new_prs = part_error ? -cs->partition_root_state : 0;
+	/*
+	 * May need to add cpus back to parent's effective_cpus
+	 * (and maybe removed from subpartitions_cpus/isolated_cpus)
+	 * for valid partition root. xcpus may contain CPUs that
+	 * shouldn't be removed from the two global cpumasks.
+	 */
+	if (is_partition_valid(parent))
+		cpumask_updated = !cpumask_empty(cs->effective_xcpus);
+
+	partition_disable(cs, parent, new_prs, part_error);
+
+	if (cpumask_updated) {
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
+		update_sibling_cpumasks(parent, cs, tmp);
+	}
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1967,19 +2004,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
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
@@ -3110,9 +3135,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
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


