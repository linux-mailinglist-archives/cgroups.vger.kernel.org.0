Return-Path: <cgroups+bounces-9470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E761CB39E4D
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 15:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A81C28287
	for <lists+cgroups@lfdr.de>; Thu, 28 Aug 2025 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52475312814;
	Thu, 28 Aug 2025 13:11:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652C3112CF;
	Thu, 28 Aug 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386696; cv=none; b=sEnDA3iM7yBt9+11Tl7NR5PbLTh/YpqI5TFv3g2o5pbO5DZnOKzxIeaQaox3VhtA9uePd6wq1aaw+KERlorrbR+8OBaw8sVWcF8BgpG+PhJrCKTlBY/Z8UHZ4LRrcVZwqMTCDR3nH/CPM+jY0KTMXm+Ge3nS1gNMm+KLgaFAEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386696; c=relaxed/simple;
	bh=plsoyBQFtI79lcByY2/D/G2dDLxAIukZoCJAO6HNkWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAjgvEpw5H6FLSts06kE73rkkjWSu0PXDS58U7phMK3ZQn2IEc3uUzYGuNDrA0Ch0AeJ9VJKVQfAseB0cxlu4K3krjIfBs2yi4a/BZjA6/lKo3WsXjpQzS1iDJUccuz4SqvOIs2mgkhTFxG4k0jEk4NUYZc6G+b3FNykv6aaHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCMH806mKzKHNHs;
	Thu, 28 Aug 2025 21:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B0E021A0F73;
	Thu, 28 Aug 2025 21:11:31 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBX8mlsVbBoQsxPAg--.40352S9;
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
Subject: [PATCH -next RFC 07/11] cpuset: refactor out invalidate_cs_partition
Date: Thu, 28 Aug 2025 12:56:27 +0000
Message-Id: <20250828125631.1978176-8-chenridong@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBX8mlsVbBoQsxPAg--.40352S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4kXr1UAr4xGw1ktF18Krg_yoW5GF4fpF
	43Kr43X3y5tF17u3s3t3929w1rKwn7X3Zrtr9xJ3WftF17KF4qyF1j9wsIvr1fJr98Ww17
	Xa1Yvr429asrA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Refactor the invalidate_cs_partition function to handle cpuset partition
invalidation when modifying cpuset.cpus. This refactoring also makes the
function reusable for handling cpuset.cpus.exclusive updates in subsequent
patches.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 49 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5cfc53fe717c..71190f142700 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2376,6 +2376,40 @@ static int parse_cpulist(const char *buf, struct cpumask *out_mask)
 	return 0;
 }
 
+/**
+ * invalidate_cs_partition - Validate and mark the validity of a cpuset partition configuration
+ * @cs: The cpuset to validate
+ * This function checks multiple constraints for a cpuset partition configuration.
+ * If any check fails, it sets the appropriate error code in the cpuset and returns true.
+ * Mainly used to ensure correctness and consistency of partition configurations.
+ * Return: true if the configuration is invalid, false if valid.
+ */
+static bool invalidate_cs_partition(struct cpuset *cs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (cs_is_member(cs))
+		return false;
+
+	if (cpumask_empty(cs->effective_xcpus)) {
+		cs->prs_err = PERR_INVCPUS;
+		return true;
+	}
+
+	if (prstate_housekeeping_conflict(cs->partition_root_state,
+					  cs->effective_xcpus)) {
+		cs->prs_err = PERR_HKEEPING;
+		return true;
+	}
+
+	if (tasks_nocpu_error(parent, cs, cs->effective_xcpus)) {
+		cs->prs_err = PERR_NOCPUS;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2405,19 +2439,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	compute_trialcs_excpus(trialcs, cs);
 
-	if (old_prs) {
-		if (is_partition_valid(cs) &&
-		    cpumask_empty(trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_INVCPUS;
-		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_HKEEPING;
-		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_NOCPUS;
-		}
-	}
+	invalidate = invalidate_cs_partition(trialcs);
+	cs->prs_err = trialcs->prs_err;
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
-- 
2.34.1


