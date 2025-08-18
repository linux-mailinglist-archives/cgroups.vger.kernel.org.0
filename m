Return-Path: <cgroups+bounces-9249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F1B29783
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 05:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FED21965313
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 03:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460C25DCF0;
	Mon, 18 Aug 2025 03:59:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB9245031;
	Mon, 18 Aug 2025 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489548; cv=none; b=Q8MiakR8OMN/I39kXyeECwsZmKLHgEz/O3tVZ1M2yIagN1YxqDjbpRUtgmmbwS0SzD4KGiuDLdHpGFCfW4X7zU1Y1Vz/Pbjyp3HCpHNzijFsUZwGUDvxM8X3YARrY+xDZdjmotxa10/noegXY0CtwyWqx1Ugf/yt3IISFNkhE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489548; c=relaxed/simple;
	bh=Br0+2PlUjPPGeMzWnZYJpUwzDrugCdxxG7eJYgdVut8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xau+cnmP5WU8qzGLV86GwDtlY/AJmdDSr/kVo/VxWfB0ZIscVh4780+nSSjAjdWjH8aq8hdIlq4yw6vVvGbjygpXXgkQBGsbgJlBkZorZEZMUSbIdT+d8F7OLrcujX2KTanQbMIjaWJCVBpayBi+mX7DxYEyt+nlA9gCbJoToBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4zVL3nGrzYQvKx;
	Mon, 18 Aug 2025 11:59:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1EADA1A1746;
	Mon, 18 Aug 2025 11:59:05 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnIhP+pKJot61AEA--.17966S3;
	Mon, 18 Aug 2025 11:59:04 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v3 1/3] cpuset: decouple tmpmasks and cpumasks freeing in cgroup
Date: Mon, 18 Aug 2025 03:44:28 +0000
Message-Id: <20250818034430.1304069-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818034430.1304069-1-chenridong@huaweicloud.com>
References: <20250818034430.1304069-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIhP+pKJot61AEA--.17966S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kGFy7Gr47XrWUJFWfAFb_yoW5Aw48pF
	WYkFW7K3yUJr18W34DJ3Z7Xr1Skaykt34vk3sxJ34rGFyay3y0vFy7Z3sYqw45KF97WF43
	JFWqyr4IgFyUtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUw9a9UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, free_cpumasks() can free both tmpmasks and cpumasks of a cpuset
(cs). However, these two operations are not logically coupled. To improve
code clarity:
1. Move cpumask freeing to free_cpuset()
2. Rename free_cpumasks() to free_tmpmasks()

This change enforces the single responsibility principle.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3466ebbf1016..aebda14cc67f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -459,23 +459,14 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 }
 
 /**
- * free_cpumasks - free cpumasks in a tmpmasks structure
- * @cs:  the cpuset that have cpumasks to be free.
+ * free_tmpmasks - free cpumasks in a tmpmasks structure
  * @tmp: the tmpmasks structure pointer
  */
-static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
+static inline void free_tmpmasks(struct tmpmasks *tmp)
 {
-	if (cs) {
-		free_cpumask_var(cs->cpus_allowed);
-		free_cpumask_var(cs->effective_cpus);
-		free_cpumask_var(cs->effective_xcpus);
-		free_cpumask_var(cs->exclusive_cpus);
-	}
-	if (tmp) {
-		free_cpumask_var(tmp->new_cpus);
-		free_cpumask_var(tmp->addmask);
-		free_cpumask_var(tmp->delmask);
-	}
+	free_cpumask_var(tmp->new_cpus);
+	free_cpumask_var(tmp->addmask);
+	free_cpumask_var(tmp->delmask);
 }
 
 /**
@@ -508,7 +499,10 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
  */
 static inline void free_cpuset(struct cpuset *cs)
 {
-	free_cpumasks(cs, NULL);
+	free_cpumask_var(cs->cpus_allowed);
+	free_cpumask_var(cs->effective_cpus);
+	free_cpumask_var(cs->effective_xcpus);
+	free_cpumask_var(cs->exclusive_cpus);
 	kfree(cs);
 }
 
@@ -2427,7 +2421,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs->partition_root_state)
 		update_partition_sd_lb(cs, old_prs);
 out_free:
-	free_cpumasks(NULL, &tmp);
+	free_tmpmasks(&tmp);
 	return retval;
 }
 
@@ -2530,7 +2524,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs->partition_root_state)
 		update_partition_sd_lb(cs, old_prs);
 
-	free_cpumasks(NULL, &tmp);
+	free_tmpmasks(&tmp);
 	return 0;
 }
 
@@ -2983,7 +2977,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	notify_partition_change(cs, old_prs);
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
-	free_cpumasks(NULL, &tmpmask);
+	free_tmpmasks(&tmpmask);
 	return 0;
 }
 
@@ -4006,7 +4000,7 @@ static void cpuset_handle_hotplug(void)
 	if (force_sd_rebuild)
 		rebuild_sched_domains_cpuslocked();
 
-	free_cpumasks(NULL, ptmp);
+	free_tmpmasks(ptmp);
 }
 
 void cpuset_update_active_cpus(void)
-- 
2.34.1


