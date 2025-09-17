Return-Path: <cgroups+bounces-10188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B46B7D303
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1091C01D0B
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153712F656A;
	Wed, 17 Sep 2025 06:20:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E12E8E07;
	Wed, 17 Sep 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090015; cv=none; b=ZTU20LqcQaRq/X5k+M/Esfo4CxezFS7jnnZLAzrRXl+10GCSfNDRX0YbmnjmDtP0OjgrYXqSok4vS0Bsd3HLvTIBH0vSTAJl8cgBU0cZhDEjXRiM43K86QJxyeRk/EgUDswnfbAWGMU/8AuxwCZoAAVC9lyTp3UFVmxr8Uoq1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090015; c=relaxed/simple;
	bh=OdCwsnGiK9JUAyZN3KpbJ0xnL0Qtf5E2htmZW3dqzUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTKxpKmOkuUXQGbMYDkNMyGSGy+DekKui35yPg1hpdJVvSibciOPv5MlEhCROOMCdRdb4y0fTaHtiip6J96B49FE0sHDwSHu5IgqZihoyF8vUym0VvF009Y4tMuFv2AXuVW2A1m5fhn1kpZoR7rB+ZhYAg8rQzyxB7ogHmPiV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCD5nMkzYQvWv;
	Wed, 17 Sep 2025 14:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68A281A14B2;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S7;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 05/11] cpuset: refactor CPU mask buffer parsing logic
Date: Wed, 17 Sep 2025 06:04:48 +0000
Message-Id: <20250917060454.2885698-6-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917060454.2885698-1-chenridong@huaweicloud.com>
References: <20250917060454.2885698-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1xtFW5urW3KF1rtF18Xwb_yoWruw4fpF
	yfCrW7JrWUtryFk39xtrnrWrn8Kw1vqa4Dt3sxJw1rCFy3C3Z2yr1Dta9xZFyfG34DGFWU
	Xa9IyrW29FnrArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The current implementation contains redundant handling for empty mask
inputs, as cpulist_parse() already properly handles these cases. This
refactoring introduces a new helper function parse_cpuset_cpulist() to
consolidate CPU list parsing logic and eliminate special-case checks for
empty inputs.

Additionally, the effective_xcpus computation for trial cpusets has been
simplified. Rather than computing effective_xcpus only when exclusive_cpus
is set or when the cpuset forms a valid partition, we now recalculate it
on every cpuset.cpus update. This approach ensures consistency and allows
removal of redundant effective_xcpus logic in subsequent patches.

The trial cpuset's effective_xcpus calculation follows two distinct cases:
1. For member cpusets: effective_xcpus is determined by the intersection
   of cpuset->exclusive_cpus and the parent's effective_xcpus.
2. For non-member cpusets: effective_xcpus is derived from the intersection
   of user_xcpus and the parent's effective_xcpus.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ddf69ac29e3f..a72b5eed4865 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -170,6 +170,11 @@ static inline bool is_partition_invalid(const struct cpuset *cs)
 	return cs->partition_root_state < 0;
 }
 
+static inline bool cs_is_member(const struct cpuset *cs)
+{
+	return cs->partition_root_state == PRS_MEMBER;
+}
+
 /*
  * Callers should hold callback_lock to modify partition_root_state.
  */
@@ -1479,7 +1484,13 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
 	struct cpuset *parent = parent_cs(trialcs);
 	struct cpumask *excpus = trialcs->effective_xcpus;
 
-	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
+	/* trialcs is member, cpuset.cpus has no impact to excpus */
+	if (cs_is_member(cs))
+		cpumask_and(excpus, trialcs->exclusive_cpus,
+				parent->effective_xcpus);
+	else
+		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
+
 	return rm_siblings_excl_cpus(parent, cs, excpus);
 }
 
@@ -2349,6 +2360,19 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	rcu_read_unlock();
 }
 
+static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
+{
+	int retval;
+
+	retval = cpulist_parse(buf, out_mask);
+	if (retval < 0)
+		return retval;
+	if (!cpumask_subset(out_mask, top_cpuset.cpus_allowed))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2365,34 +2389,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 
-	/*
-	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
-	 * Since cpulist_parse() fails on an empty mask, we special case
-	 * that parsing.  The validate_change() call ensures that cpusets
-	 * with tasks have cpus.
-	 */
-	if (!*buf) {
-		cpumask_clear(trialcs->cpus_allowed);
-		if (cpumask_empty(trialcs->exclusive_cpus))
-			cpumask_clear(trialcs->effective_xcpus);
-	} else {
-		retval = cpulist_parse(buf, trialcs->cpus_allowed);
-		if (retval < 0)
-			return retval;
-
-		if (!cpumask_subset(trialcs->cpus_allowed,
-				    top_cpuset.cpus_allowed))
-			return -EINVAL;
-
-		/*
-		 * When exclusive_cpus isn't explicitly set, it is constrained
-		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
-		 * trialcs->effective_xcpus is used as a temporary cpumask
-		 * for checking validity of the partition root.
-		 */
-		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
-			compute_trialcs_excpus(trialcs, cs);
-	}
+	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
+	if (retval < 0)
+		return retval;
 
 	/* Nothing to do if the cpus didn't change */
 	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
@@ -2401,6 +2400,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
+	compute_trialcs_excpus(trialcs, cs);
+
 	if (old_prs) {
 		if (is_partition_valid(cs) &&
 		    cpumask_empty(trialcs->effective_xcpus)) {
-- 
2.34.1


