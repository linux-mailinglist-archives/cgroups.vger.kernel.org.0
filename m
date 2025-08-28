Return-Path: <cgroups+bounces-9468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D42B39E4B
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEABF16FAC3
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBE311C32;
	Thu, 28 Aug 2025 13:11:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621030F805;
	Thu, 28 Aug 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386696; cv=none; b=Gz9KvA1OBlRgW0VFV6B1FW8sEIXUUz9FJ1IhDwhmJlLegm5n5o2KzEVSpQzYBnTRwAHqQjvqGfM5GgQJTtQRL/dF9ywABAqcTR8nyfMtaGPeEz4lYjAYSTTyvF+9qgn+On6iBY0dNyXKuoP9iMWrP9hUrWQdmmsSHYJPjPFBh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386696; c=relaxed/simple;
	bh=0cmkGLsaUPbSHtF0suNjEpcR8ZtvKRkafFRm78wBGG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFXHbU8eDenlu0G62rUnf1fHYWpA1Vci4U8JMF0lyaICd0TQSctTuHNMh/4/BczdTuYnEf5v94ljKLFbB59AmvMhuAtv7nDAAXe7N4dq6L+/Z6SVLahCB9macgv+5pdnkbKxa/unMdDC67yQPYQLMyOrrznBwGOt+Ug4J9no9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH813hPzKHNKT;
	Thu, 28 Aug 2025 21:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D26871A1B0D;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S11;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
Date: Thu, 28 Aug 2025 12:56:29 +0000
Message-Id: <20250828125631.1978176-10-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828125631.1978176-1-chenridong@huaweicloud.com>
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S11
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4DuFWrtrW7Jr17uFy8Zrb_yoW5CF43pF
	y7Cr47trW5Jr1Y9a9xJan29w45K3Z7J3ZrtwnrJa4fGFy2v3sFyF1jy39avFy3X3srGry8
	Zan0vrWxWF97ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Refactor the partition_cpus_change function to handle both regular CPU
set updates and exclusive CPU modifications, either of which may trigger
partition state changes. This generalized function will also be utilized
for exclusive CPU updates in subsequent patches.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 75ad18ab40ae..e3eb87a33b12 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
 	return retval;
 }
 
+/**
+ * partition_cpus_change - Handle partition state changes due to CPU mask updates
+ * @cs: The target cpuset being modified
+ * @trialcs: The trial cpuset containing proposed configuration changes
+ * @tmp: Temporary masks for intermediate calculations
+ *
+ * This function handles partition state transitions triggered by CPU mask changes.
+ * CPU modifications may cause a partition to be disabled or require state updates.
+ */
+static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
+					struct tmpmasks *tmp)
+{
+	if (cs_is_member(cs))
+		return;
+
+	invalidate_cs_partition(trialcs);
+	if (trialcs->prs_err)
+		cs->prs_err = trialcs->prs_err;
+
+	if (is_remote_partition(cs)) {
+		if (trialcs->prs_err)
+			remote_partition_disable(cs, tmp);
+		else
+			remote_cpus_update(cs, trialcs->exclusive_cpus,
+					   trialcs->effective_xcpus, tmp);
+	} else {
+		if (trialcs->prs_err)
+			update_parent_effective_cpumask(cs, partcmd_invalidate,
+							NULL, tmp);
+		else
+			update_parent_effective_cpumask(cs, partcmd_update,
+							trialcs->effective_xcpus, tmp);
+	}
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
-	invalidate_cs_partition(trialcs);
-	if (trialcs->prs_err)
-		cs->prs_err = trialcs->prs_err;
-
-	if (is_partition_valid(cs) ||
-	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
-		struct cpumask *xcpus = trialcs->effective_xcpus;
-
-		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
-			xcpus = trialcs->cpus_allowed;
-
-		/*
-		 * Call remote_cpus_update() to handle valid remote partition
-		 */
-		if (is_remote_partition(cs))
-			remote_cpus_update(cs, NULL, xcpus, &tmp);
-		else if (trialcs->prs_err)
-			update_parent_effective_cpumask(cs, partcmd_invalidate,
-							NULL, &tmp);
-		else
-			update_parent_effective_cpumask(cs, partcmd_update,
-							xcpus, &tmp);
-	}
+	partition_cpus_change(cs, trialcs, &tmp);
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
-- 
2.34.1


