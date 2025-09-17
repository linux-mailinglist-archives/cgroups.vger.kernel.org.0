Return-Path: <cgroups+bounces-10189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E936FB7D15B
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF02E4E1DAB
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DD2FD1BC;
	Wed, 17 Sep 2025 06:20:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27442E8DE2;
	Wed, 17 Sep 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090017; cv=none; b=IOFhag7gbNb49rJ2dJDA4gQMGQxE244Ig+RfGkKlrV8uq3sDMnX11TPa/e3YrgXd3ylkzqGd8FbEfJqw+gby1xf8mwwBFImVz/+eJgsBhpAFmKbSrymVsr90iyHg4jdg6uHMdIsDrFWEffja0SzLYKtneso/R6Hv2NlrhbkLqXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090017; c=relaxed/simple;
	bh=Qp98F9nw82x9bCpTgorZjGM4aiCPRpzKVVTsOLS+cOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhRdtveeEjUyxK9ceh9+gL3JHPTvoUF4MS2x67PF+uc6u/CKqjRtoH+MhyXclQC85ExYrJ4ic6mh8HorROqajVcV6xGEHRJGveETEAIOiTkKqJTUurG4nc8bhOyhDQdhO8JekZTgLN6nOh+oFLj4d465J2IziFW5JWwYY0w2rvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRTCD6t76zYQvXq;
	Wed, 17 Sep 2025 14:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8CD111A14BC;
	Wed, 17 Sep 2025 14:20:07 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCn74sNU8pos3slCw--.39134S10;
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
Subject: [PATCH -next 08/11] cpuset: refactor cpus_allowed_validate_change
Date: Wed, 17 Sep 2025 06:04:51 +0000
Message-Id: <20250917060454.2885698-9-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn74sNU8pos3slCw--.39134S10
X-Coremail-Antispam: 1UD129KBjvJXoWxKryrJF4kZF47ur43Ar1DWrg_yoW7GF4UpF
	y3Cw47trWUGryUu3yUJan2k3Z8Kw1kX3ZrtrnxJ3WSgFy7tasFya4jya9xZFy3JF9xGrW8
	Zan0qFsrWFy8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 84 ++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aaf8244b3cea..ab8572038fce 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2417,6 +2417,42 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
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
@@ -2429,8 +2465,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 {
 	int retval;
 	struct tmpmasks tmp;
-	struct cpuset *parent = parent_cs(cs);
-	bool invalidate = false;
 	bool force = false;
 	int old_prs = cs->partition_root_state;
 	enum prs_errcode prs_err;
@@ -2447,12 +2481,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -2460,40 +2492,14 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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
@@ -2504,7 +2510,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
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


