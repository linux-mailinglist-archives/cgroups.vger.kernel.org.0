Return-Path: <cgroups+bounces-9463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF71B39E41
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CA27AF9A0
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F962311588;
	Thu, 28 Aug 2025 13:11:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DD3101AA;
	Thu, 28 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386695; cv=none; b=MfrTzRCg0RFVmbNKhfFiwl7mPVaiLTrCQzX5W7QnqTkLYHsfbwFMaLSEAhZ0EQzzdD36ILyadgwUhg0beNnDbSbT3Vv647QPfyJvMDSRO/SbkEKwm0aY7W6h5buOlUz6BJBe5l6409P0Vh0+iltUh95wsZ2j0hlt++QG0LbU0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386695; c=relaxed/simple;
	bh=izjEMj9FZR8V5zy6TpVAeS7fL1Usj+cWPOFisPt6kmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbEXnsFTz4DRHXMFem9V+D+Djnd+JsvBJ5aRj6wxvgxLR8VDi2HLDnl/FkcNMCm4GXFbXI7R5/2odbJVTFbwIF52OFR1+HQF4PVYwpZE+1JnYbF0XM5UZCmPmFFpGYr9CNldre6uuqHpl4qtIdQJjVYPZ3JgoOeQ6/WHXSeWkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH924dTzYQvhJ;
	Thu, 28 Aug 2025 21:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C86991A1373;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S10;
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
Subject: [PATCH -next RFC 08/11] cpuset: refactor acpus_validate_change
Date: Thu, 28 Aug 2025 12:56:28 +0000
Message-Id: <20250828125631.1978176-9-chenridong@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy8ZryfJFWfJr13Xr4rGrg_yoWrtrWDpF
	y3Cr47JrWUJrWj9ayUJan2gry5Kwn7Xa4DtwnxJa4FkFy3K3ZFyF1jqa9IvFy3Xr9rWF48
	XanIyFZruFy7C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Refactor acpus_validate_change to handle the special case where
cpuset.cpus can be set even when violating partition sibling CPU
exclusivity rules. This differs from the general validation logic in
validate_change. Add a wrapper function to properly handle this
exceptional case.

Since partition invalidation status can be determined by trialcs->prs_err,
the local variable 'bool invalidate' can be removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 83 +++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71190f142700..75ad18ab40ae 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2410,43 +2410,11 @@ static bool invalidate_cs_partition(struct cpuset *cs)
 	return false;
 }
 
-/**
- * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
- * @cs: the cpuset to consider
- * @trialcs: trial cpuset
- * @buf: buffer of cpu numbers written to this cpuset
- */
-static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
-			  const char *buf)
+static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
+					struct tmpmasks *tmp)
 {
 	int retval;
-	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
-	bool invalidate = false;
-	bool force = false;
-	int old_prs = cs->partition_root_state;
-
-	retval = parse_cpulist(buf, trialcs->cpus_allowed);
-	if (retval < 0)
-		return retval;
-
-	/* Nothing to do if the cpus didn't change */
-	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
-		return 0;
-
-	if (alloc_tmpmasks(&tmp))
-		return -ENOMEM;
-
-	compute_trialcs_excpus(trialcs, cs);
-
-	invalidate = invalidate_cs_partition(trialcs);
-	cs->prs_err = trialcs->prs_err;
-
-	/*
-	 * Check all the descendants in update_cpumasks_hier() if
-	 * effective_xcpus is to be changed.
-	 */
-	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
 	retval = validate_change(cs, trialcs);
 
@@ -2461,7 +2429,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 * partition. However, any conflicting sibling partitions
 		 * have to be marked as invalid too.
 		 */
-		invalidate = true;
+		trialcs->prs_err = PERR_NOTEXCL;
 		rcu_read_lock();
 		cpuset_for_each_child(cp, css, parent) {
 			struct cpumask *xcpus = user_xcpus(trialcs);
@@ -2469,19 +2437,58 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, &tmp);
+				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
 				rcu_read_lock();
 			}
 		}
 		rcu_read_unlock();
 		retval = 0;
 	}
+	return retval;
+}
 
+/**
+ * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
+ * @cs: the cpuset to consider
+ * @trialcs: trial cpuset
+ * @buf: buffer of cpu numbers written to this cpuset
+ */
+static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
+			  const char *buf)
+{
+	int retval;
+	struct tmpmasks tmp;
+	bool force = false;
+	int old_prs = cs->partition_root_state;
+
+	retval = parse_cpulist(buf, trialcs->cpus_allowed);
 	if (retval < 0)
+		return retval;
+
+	/* Nothing to do if the cpus didn't change */
+	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
+		return 0;
+
+	if (alloc_tmpmasks(&tmp))
+		return -ENOMEM;
+
+	compute_trialcs_excpus(trialcs, cs);
+
+	trialcs->prs_err = PERR_NONE;
+	if (acpus_validate_change(cs, trialcs, &tmp) < 0)
 		goto out_free;
+	/*
+	 * Check all the descendants in update_cpumasks_hier() if
+	 * effective_xcpus is to be changed.
+	 */
+	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
+
+	invalidate_cs_partition(trialcs);
+	if (trialcs->prs_err)
+		cs->prs_err = trialcs->prs_err;
 
 	if (is_partition_valid(cs) ||
-	   (is_partition_invalid(cs) && !invalidate)) {
+	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
 		struct cpumask *xcpus = trialcs->effective_xcpus;
 
 		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
@@ -2492,7 +2499,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 */
 		if (is_remote_partition(cs))
 			remote_cpus_update(cs, NULL, xcpus, &tmp);
-		else if (invalidate)
+		else if (trialcs->prs_err)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
 		else
-- 
2.34.1


