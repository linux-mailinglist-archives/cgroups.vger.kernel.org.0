Return-Path: <cgroups+bounces-9126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D9B24498
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4558054A
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26222F1FCF;
	Wed, 13 Aug 2025 08:43:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4E2F0691;
	Wed, 13 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074614; cv=none; b=l5/r7MnU9qprG1wbRCDZ/keZtwCDcc3feMEExHeeO1fFsMlcymcHVhhYf//D4ptm52C1RGk6onxjcrQamme8/a+/oSLt3KPArkqMdnh8XV71FQMnB7abueOmRK86hRY2kZjQQ7gplBL9VwFSTEezevTHdVXhEQwJHQYUcserfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074614; c=relaxed/simple;
	bh=LDoKSLv6DaS71m95O+3GWjqRdNCs5dlPBklDENMne4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGiJvmYqkFcEoRiLUUa2HisKMEqJT0WG61zL2qnfMRWwpfV/jMAdmYrDOCkmtwwVqK3rjTBnUX3rSOBTnpLk3amVtSn7hui1j8CjN92QpqguBKACV261yqpJOquZwrzrIafcYCT7U1WS7FMYMZueh7546abupwZ/jefoRcbSrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c222n1Q1kzKHMx3;
	Wed, 13 Aug 2025 16:43:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 727D01A1B99;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg8qUJxoaYwdDg--.28644S4;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	christophe.jaillet@wanadoo.fr
Subject: [-next v2 2/4] cpuset: decouple tmpmaks and cpumaks of cs free
Date: Wed, 13 Aug 2025 08:29:02 +0000
Message-Id: <20250813082904.1091651-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813082904.1091651-1-chenridong@huaweicloud.com>
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg8qUJxoaYwdDg--.28644S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fXF13Wr4xZry8tFWUJwb_yoW5AFy7pF
	WYkFW7G3yUJr18W34DJa97Xr1Sk3ykt34kK3sxJ3s5GFyav3y0vFy7Z3sYq3yYkFykWF43
	JFWDtr4SgFyUtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7v38UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, free_cpumasks can free tmpmasks of cpumask of cs. However, it
doesn't have couple these 2 options. To make the function more clearer,
move the freeing of cpumask in cs to the free_cpuset. And rename the
free_cpumasks to the free_tmpmasks. which is Single responsibility.

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


