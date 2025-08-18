Return-Path: <cgroups+bounces-9259-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99CB29A5F
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00EF3B5B8C
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9E27E7DF;
	Mon, 18 Aug 2025 06:56:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538C27BF6C;
	Mon, 18 Aug 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500185; cv=none; b=YNtDIPaXBRd1dRTXw279mUorCQcX1j6DIkvN+FyeGg+tP/yow61JBqO1sGlkpVUXf9xarSDbgQCr8C1v5NFEq2vewyY+8SuUQf6P//kJFbPrJyN9M9Cguce+WOjaqVgAUXOI2Z+x/lZrRp7WFwBYn+sZOrRaUuoeEOaAZVGs5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500185; c=relaxed/simple;
	bh=3MEDVwuejxLIxhJHIwWBKqI70/LdL6U7s/ee5SQrQXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvevgoPV13bkKkePGpPzENRjrUUj04jzcGF5S2scYtpA8v/onxuQ0wnmt0DbNPav3Qfvo5QQer5onIRoila7asLg/AbFO1zszlEyO0FCVFkF8NnAKCsplSO0wDiwqvncLSCWVtazvmWn8IsvvaVrAGKCH6Zo/SRxWjrclCfJG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c53Qs6T8WzYQvcD;
	Mon, 18 Aug 2025 14:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A6381A0CDB;
	Mon, 18 Aug 2025 14:56:20 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg+FzqJoKNJOEA--.3242S4;
	Mon, 18 Aug 2025 14:56:20 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v4 2/3] cpuset: separate tmpmasks and cpuset allocation logic
Date: Mon, 18 Aug 2025 06:41:40 +0000
Message-Id: <20250818064141.1334859-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818064141.1334859-1-chenridong@huaweicloud.com>
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg+FzqJoKNJOEA--.3242S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfuFW3ZF43uw4UtrW5ZFb_yoWxtry8pF
	4rCrWUKayUJr18Ww4UG3Z7Gr1fK3yvqa4qy3W5XryruFyaqF4I9FyDJ3sYvay7CasrCF1r
	XF98Aw4IgFyDKrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2FApUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The original alloc_cpumasks() served dual purposes: allocating cpumasks
for both temporary masks (tmpmasks) and cpuset structures. This patch:

1. Decouples these allocation paths for better code clarity
2. Introduces dedicated alloc_tmpmasks() and dup_or_alloc_cpuset()
   functions
3. Maintains symmetric pairing:
   - alloc_tmpmasks() ↔ free_tmpmasks()
   - dup_or_alloc_cpuset() ↔ free_cpuset()

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 128 ++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aebda14cc67f..d5588a1fef60 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -411,51 +411,46 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 }
 
 /**
- * alloc_cpumasks - allocate three cpumasks for cpuset
- * @cs:  the cpuset that have cpumasks to be allocated.
- * @tmp: the tmpmasks structure pointer
- * Return: 0 if successful, -ENOMEM otherwise.
+ * alloc_cpumasks - Allocate an array of cpumask variables
+ * @pmasks: Pointer to array of cpumask_var_t pointers
+ * @size: Number of cpumasks to allocate
  *
- * Only one of the two input arguments should be non-NULL.
+ * Allocates @size cpumasks and initializes them to empty. Returns 0 on
+ * success, -ENOMEM on allocation failure. On failure, any previously
+ * allocated cpumasks are freed.
  */
-static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
+static inline int alloc_cpumasks(cpumask_var_t *pmasks[], u32 size)
 {
-	cpumask_var_t *pmask1, *pmask2, *pmask3, *pmask4;
+	int i;
 
-	if (cs) {
-		pmask1 = &cs->cpus_allowed;
-		pmask2 = &cs->effective_cpus;
-		pmask3 = &cs->effective_xcpus;
-		pmask4 = &cs->exclusive_cpus;
-	} else {
-		pmask1 = &tmp->new_cpus;
-		pmask2 = &tmp->addmask;
-		pmask3 = &tmp->delmask;
-		pmask4 = NULL;
+	for (i = 0; i < size; i++) {
+		if (!zalloc_cpumask_var(pmasks[i], GFP_KERNEL)) {
+			while (--i >= 0)
+				free_cpumask_var(*pmasks[i]);
+			return -ENOMEM;
+		}
 	}
-
-	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
-		goto free_one;
-
-	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
-		goto free_two;
-
-	if (pmask4 && !zalloc_cpumask_var(pmask4, GFP_KERNEL))
-		goto free_three;
-
-
 	return 0;
+}
 
-free_three:
-	free_cpumask_var(*pmask3);
-free_two:
-	free_cpumask_var(*pmask2);
-free_one:
-	free_cpumask_var(*pmask1);
-	return -ENOMEM;
+/**
+ * alloc_tmpmasks - Allocate temporary cpumasks for cpuset operations.
+ * @tmp: Pointer to tmpmasks structure to populate
+ * Return: 0 on success, -ENOMEM on allocation failure
+ */
+static inline int alloc_tmpmasks(struct tmpmasks *tmp)
+{
+	/*
+	 * Array of pointers to the three cpumask_var_t fields in tmpmasks.
+	 * Note: Array size must match actual number of masks (3)
+	 */
+	cpumask_var_t *pmask[3] = {
+		&tmp->new_cpus,
+		&tmp->addmask,
+		&tmp->delmask
+	};
+
+	return alloc_cpumasks(pmask, ARRAY_SIZE(pmask));
 }
 
 /**
@@ -470,26 +465,46 @@ static inline void free_tmpmasks(struct tmpmasks *tmp)
 }
 
 /**
- * alloc_trial_cpuset - allocate a trial cpuset
- * @cs: the cpuset that the trial cpuset duplicates
+ * dup_or_alloc_cpuset - Duplicate or allocate a new cpuset
+ * @cs: Source cpuset to duplicate (NULL for a fresh allocation)
+ *
+ * Creates a new cpuset by either:
+ * 1. Duplicating an existing cpuset (if @cs is non-NULL), or
+ * 2. Allocating a fresh cpuset with zero-initialized masks (if @cs is NULL)
+ *
+ * Return: Pointer to newly allocated cpuset on success, NULL on failure
  */
-static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
+static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
 {
 	struct cpuset *trial;
 
-	trial = kmemdup(cs, sizeof(*cs), GFP_KERNEL);
+	/* Allocate base structure */
+	trial = cs ? kmemdup(cs, sizeof(*cs), GFP_KERNEL) :
+		     kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!trial)
 		return NULL;
 
-	if (alloc_cpumasks(trial, NULL)) {
+	/* Setup cpumask pointer array */
+	cpumask_var_t *pmask[4] = {
+		&trial->cpus_allowed,
+		&trial->effective_cpus,
+		&trial->effective_xcpus,
+		&trial->exclusive_cpus
+	};
+
+	if (alloc_cpumasks(pmask, ARRAY_SIZE(pmask))) {
 		kfree(trial);
 		return NULL;
 	}
 
-	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
-	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
-	cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
-	cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
+	/* Copy masks if duplicating */
+	if (cs) {
+		cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
+		cpumask_copy(trial->effective_cpus, cs->effective_cpus);
+		cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
+		cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
+	}
+
 	return trial;
 }
 
@@ -2332,7 +2347,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
 		return 0;
 
-	if (alloc_cpumasks(NULL, &tmp))
+	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
 	if (old_prs) {
@@ -2476,7 +2491,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval)
 		return retval;
 
-	if (alloc_cpumasks(NULL, &tmp))
+	if (alloc_tmpmasks(&tmp))
 		return -ENOMEM;
 
 	if (old_prs) {
@@ -2820,7 +2835,7 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	int spread_flag_changed;
 	int err;
 
-	trialcs = alloc_trial_cpuset(cs);
+	trialcs = dup_or_alloc_cpuset(cs);
 	if (!trialcs)
 		return -ENOMEM;
 
@@ -2881,7 +2896,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (new_prs && is_prs_invalid(old_prs))
 		old_prs = PRS_MEMBER;
 
-	if (alloc_cpumasks(NULL, &tmpmask))
+	if (alloc_tmpmasks(&tmpmask))
 		return -ENOMEM;
 
 	err = update_partition_exclusive_flag(cs, new_prs);
@@ -3223,7 +3238,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
-	trialcs = alloc_trial_cpuset(cs);
+	trialcs = dup_or_alloc_cpuset(cs);
 	if (!trialcs) {
 		retval = -ENOMEM;
 		goto out_unlock;
@@ -3456,15 +3471,10 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!parent_css)
 		return &top_cpuset.css;
 
-	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+	cs = dup_or_alloc_cpuset(NULL);
 	if (!cs)
 		return ERR_PTR(-ENOMEM);
 
-	if (alloc_cpumasks(cs, NULL)) {
-		kfree(cs);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
@@ -3920,7 +3930,7 @@ static void cpuset_handle_hotplug(void)
 	bool on_dfl = is_in_v2_mode();
 	struct tmpmasks tmp, *ptmp = NULL;
 
-	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
+	if (on_dfl && !alloc_tmpmasks(&tmp))
 		ptmp = &tmp;
 
 	lockdep_assert_cpus_held();
-- 
2.34.1


