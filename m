Return-Path: <cgroups+bounces-10184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6F7B7D186
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA0A7A8B79
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C492BDC23;
	Wed, 17 Sep 2025 06:20:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4621B9FD;
	Wed, 17 Sep 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090012; cv=none; b=rBNVN/AlUsDStyVjAmvjXHCTnY+LNDE3Jpc3GHEaGhd4zdnfzxgTN/ohnhIy35qxqWSLtD7zT6BEWdrjRRhnJqy28aIM+/10jbjLkI11WPz3XH7OyuJ8/nbmc28QorjR8KRFTxvpzlMsnp/4fVTVOenpdWE3wb6OXDv+3L+E1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090012; c=relaxed/simple;
	bh=xGrjnkivB4XsiE5jj7oDHPkmb4r0RQcD2sk8/e5k6JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hfe7KR8i6KJlzu0X+KktHe0gKfDh8hEjb8uFDPxO2GPwHCg35+uV/Ovx/Rvyktq62g0cAWvtpbuNKpxP1zc75e3eKBCT2AAjBHbDaaWrnCWm5G6PXok3s5qIxe3i5EyGtesUX3QKs7LQQ+bTT74d5RuSedxDrGBzZvwS7warWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCB5jN5zKHN5m;
	Wed, 17 Sep 2025 14:20:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 81BD11A131C;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S9;
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
Subject: [PATCH -next 07/11] cpuset: refactor out validate_partition
Date: Wed, 17 Sep 2025 06:04:50 +0000
Message-Id: <20250917060454.2885698-8-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW5Xw13WFWDXrWfCr1kGrg_yoW5Wry8pF
	W5Cr43W3y5try29393t397uw15Kwn7XasrtrnxJa4S9Fy7tF1qyF1jgwsIvr1fXr9xG3W8
	Za9I9r4agF9FywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Refactor the validate_partition function to handle cpuset partition
validation when modifying cpuset.cpus. This refactoring also makes the
function reusable for handling cpuset.cpus.exclusive updates in subsequent
patches.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 48 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8e9727352a5d..aaf8244b3cea 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2387,6 +2387,37 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
 	return 0;
 }
 
+/**
+ * validate_partition - Validate a cpuset partition configuration
+ * @cs: The cpuset to validate
+ * @trialcs: The trial cpuset containing proposed configuration changes
+ *
+ * If any validation check fails, the appropriate error code is set in the
+ * cpuset's prs_err field.
+ *
+ * Return: PRS error code (0 if valid, non-zero error code if invalid)
+ */
+static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *trialcs)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (cs_is_member(trialcs))
+		return PERR_NONE;
+
+	if (cpumask_empty(trialcs->effective_xcpus))
+		return PERR_INVCPUS;
+
+	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
+					  trialcs->effective_xcpus))
+		return PERR_HKEEPING;
+
+	if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus))
+		return PERR_NOCPUS;
+
+	return PERR_NONE;
+}
+
+
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
  * @cs: the cpuset to consider
@@ -2402,6 +2433,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	bool invalidate = false;
 	bool force = false;
 	int old_prs = cs->partition_root_state;
+	enum prs_errcode prs_err;
 
 	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
 	if (retval < 0)
@@ -2416,18 +2448,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
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
+	prs_err = validate_partition(cs, trialcs);
+	if (prs_err) {
+		invalidate = true;
+		cs->prs_err = prs_err;
 	}
 
 	/*
-- 
2.34.1


