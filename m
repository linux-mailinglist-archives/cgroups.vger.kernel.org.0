Return-Path: <cgroups+bounces-9802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB8B4A049
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 05:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA794E7F80
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D132FB0B8;
	Tue,  9 Sep 2025 03:48:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD82EB858;
	Tue,  9 Sep 2025 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389684; cv=none; b=gfTfd65/gZYYMnPOsQAWb6Iw2323+BPvBd7H5h+sENYvRwi+DUY1FjvM3IS99waXbTPHpPn6tnyylvBFhe8u7grLotqjdFXd1Fr4cz7/CMyIw0EL5/9OtM5dvFxwI9yher8qFpNzx8AwG8ypL+/s9qToHeBV+JxOxjfOW/E0Y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389684; c=relaxed/simple;
	bh=w+rwObG2eUmsq7nsPUsXbAbFvyP428z6CQz2khQsMXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl3pKL28lLnkQxGDezJIwz42C8uaTiJnFIkwlrZwaolrZ7GaFWREve+wolEV5jumPhDLZoWqmRQFHeXHV3wXW4OCjRUVSpuFX0zSLcFOMEzXtDaWca1EvwjfFbOYmZvIpOur5+0z8imOhZShBsq01xDMFJcis+9iG3740LMSuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLVCH5TBRzKHMn5;
	Tue,  9 Sep 2025 11:47:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E639E1A1A1B;
	Tue,  9 Sep 2025 11:47:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgAnM3lOo79oBVdmBw--.63383S10;
	Tue, 09 Sep 2025 11:47:55 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC -v2 08/11] cpuset: refactor cpus_allowed_validate_change
Date: Tue,  9 Sep 2025 03:32:30 +0000
Message-Id: <20250909033233.2731579-9-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909033233.2731579-1-chenridong@huaweicloud.com>
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnM3lOo79oBVdmBw--.63383S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy8tF4rAFWxArWDuFW8Xrb_yoW7Gr1DpF
	y3Cw47trWUGryUu3yUJan2kwn8Kw1kX3ZrtrnxJ3WSqFy7tasFya4jy39xZFy3JF9rGrW8
	Zan0qFsrWFyxCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

Refactor cpus_allowed_validate_change to handle the special case where
cpuset.cpus can be set even when violating partition sibling CPU
exclusivity rules. This differs from the general validation logic in
validate_change. Add a wrapper function to properly handle this
exceptional case.

The trialcs->prs_err field is cleared before performing validation checks
for both CPU changes and partition errors. If cpus_allowed_validate_change
fails its validation, trialcs->prs_err is set to PERR_NOTEXCL. If partition
validation fails, the specific error code returned by validate_partition
is assigned to trialcs->prs_err.

With the partition validation status now directly available through
trialcs->prs_err, the local boolean variable 'invalidate' becomes
redundant and can be safely removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 84 ++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 770b33e30576..6aa93bd9d5dd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2416,6 +2416,42 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
 	return PERR_NONE;
 }
 
+static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
+					struct tmpmasks *tmp)
+{
+	int retval;
+	struct cpuset *parent = parent_cs(cs);
+
+	retval = validate_change(cs, trialcs);
+
+	if ((retval == -EINVAL) && cpuset_v2()) {
+		struct cgroup_subsys_state *css;
+		struct cpuset *cp;
+
+		/*
+		 * The -EINVAL error code indicates that partition sibling
+		 * CPU exclusivity rule has been violated. We still allow
+		 * the cpumask change to proceed while invalidating the
+		 * partition. However, any conflicting sibling partitions
+		 * have to be marked as invalid too.
+		 */
+		trialcs->prs_err = PERR_NOTEXCL;
+		rcu_read_lock();
+		cpuset_for_each_child(cp, css, parent) {
+			struct cpumask *xcpus = user_xcpus(trialcs);
+
+			if (is_partition_valid(cp) &&
+			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
+				rcu_read_unlock();
+				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
+				rcu_read_lock();
+			}
+		}
+		rcu_read_unlock();
+		retval = 0;
+	}
+	return retval;
+}
 
 /**
  * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
@@ -2428,8 +2464,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 	struct tmpmasks tmp;
-	struct cpuset *parent = parent_cs(cs);
-	bool invalidate = false;
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 	enum prs_errcode prs_err;
@@ -2446,12 +2480,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		return -ENOMEM;
 
 	compute_trialcs_excpus(trialcs, cs);
+	trialcs->prs_err = PERR_NONE;
 
-	prs_err = validate_partition(cs, trialcs);
-	if (prs_err) {
-		invalidate = true;
-		cs->prs_err = prs_err;
-	}
+	if (cpus_allowed_validate_change(cs, trialcs, &tmp) < 0)
+		goto out_free;
 
 	/*
 	 * Check all the descendants in update_cpumasks_hier() if
@@ -2459,40 +2491,14 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
-	retval = validate_change(cs, trialcs);
-
-	if ((retval == -EINVAL) && cpuset_v2()) {
-		struct cgroup_subsys_state *css;
-		struct cpuset *cp;
-
-		/*
-		 * The -EINVAL error code indicates that partition sibling
-		 * CPU exclusivity rule has been violated. We still allow
-		 * the cpumask change to proceed while invalidating the
-		 * partition. However, any conflicting sibling partitions
-		 * have to be marked as invalid too.
-		 */
-		invalidate = true;
-		rcu_read_lock();
-		cpuset_for_each_child(cp, css, parent) {
-			struct cpumask *xcpus = user_xcpus(trialcs);
-
-			if (is_partition_valid(cp) &&
-			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
-				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, &tmp);
-				rcu_read_lock();
-			}
-		}
-		rcu_read_unlock();
-		retval = 0;
+	prs_err = validate_partition(cs, trialcs);
+	if (prs_err) {
+		trialcs->prs_err = prs_err;
+		cs->prs_err = prs_err;
 	}
 
-	if (retval < 0)
-		goto out_free;
-
 	if (is_partition_valid(cs) ||
-	   (is_partition_invalid(cs) && !invalidate)) {
+	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
 		struct cpumask *xcpus = trialcs->effective_xcpus;
 
 		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
@@ -2503,7 +2509,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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


