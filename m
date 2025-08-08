Return-Path: <cgroups+bounces-9028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E41B1E5BB
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 11:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E87D34E355C
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF7270571;
	Fri,  8 Aug 2025 09:39:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809B26D4F7;
	Fri,  8 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645986; cv=none; b=BVSC6KxjfdiURsLqGOcDhL3sORx89Zl54pWX3Z8yZ5QfRAcZL5DCe6Z0FGm05aYuLDEUIMSFGBymE+vJNm3KHzJM95hWUSYkSODkJUcWOgy2eC0LGr7vMRc70AE0H1eurXgxI6jLHfLZVci4rLhOGMI40wQY/1BPOuIoUieX7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645986; c=relaxed/simple;
	bh=Mg80xmJK9bQ8a2X6BBD010qfIsSEnKAortDyuVurY40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWSU1rNyRqcmwNd4uxQebmW3HfCkObnzcyEHpSfT/lYZ66wWf6fmTYfo2Jgs028yAse8H7B/yp50mkNXCfx7gy4Nb9jgYLnrJ06zqjM5uAEHkmV5guU7aQ50oyF237+mBVJNhcUS9A6WzEEb76Yxgefm5QOpma1sDApx2bFi3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4byzWy499PzYQvC4;
	Fri,  8 Aug 2025 17:39:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 370191A1208;
	Fri,  8 Aug 2025 17:39:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCXo7XPxZVooOS_Cw--.51716S5;
	Fri, 08 Aug 2025 17:39:40 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 3/4] cpuset: use guard_cpus_read_and_cpuset to make code concise
Date: Fri,  8 Aug 2025 09:25:14 +0000
Message-Id: <20250808092515.764820-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808092515.764820-1-chenridong@huaweicloud.com>
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXo7XPxZVooOS_Cw--.51716S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1rJFW8GrWDXr1kCw1kuFg_yoW7Ar48pF
	909rW7JayUJr4kuw4fGa4DuF1rKw10gF4UGFykG3WrAFy2yFnI9Fy8GasYgry5Gr9rCrW5
	JFnFgws09ayUJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Ru
	WJUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Several functions currently implement manual locking sequences for both
cpus_read_lock() and cpuset_mutex. Replace these repetitive patterns
with the new guard_cpus_read_and_cpuset() helper.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-v1.c | 22 +++++++---------------
 kernel/cgroup/cpuset.c    | 39 ++++++++++-----------------------------
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b69a7db67090..70685b90759c 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -169,10 +169,10 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	cpus_read_lock();
-	cpuset_lock();
+	guard_cpus_read_and_cpuset();
+
 	if (!is_cpuset_online(cs))
-		goto out_unlock;
+		return retval;
 
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
@@ -183,9 +183,6 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = -EINVAL;
 		break;
 	}
-out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
 	return retval;
 }
 
@@ -454,12 +451,9 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	cpus_read_lock();
-	cpuset_lock();
-	if (!is_cpuset_online(cs)) {
-		retval = -ENODEV;
-		goto out_unlock;
-	}
+	guard_cpus_read_and_cpuset();
+	if (!is_cpuset_online(cs))
+		return -ENODEV;
 
 	switch (type) {
 	case FILE_CPU_EXCLUSIVE:
@@ -497,9 +491,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = -EINVAL;
 		break;
 	}
-out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
+
 	return retval;
 }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f6cdb5cdffe8..110d2b93ff96 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3235,15 +3235,14 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	int retval = -ENODEV;
 
 	buf = strstrip(buf);
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	guard_cpus_read_and_cpuset();
 	if (!is_cpuset_online(cs))
-		goto out_unlock;
+		goto out;
 
 	trialcs = alloc_trial_cpuset(cs);
 	if (!trialcs) {
 		retval = -ENOMEM;
-		goto out_unlock;
+		goto out;
 	}
 
 	switch (of_cft(of)->private) {
@@ -3264,9 +3263,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	free_cpuset(trialcs);
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
-out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+out:
 	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
@@ -3370,12 +3367,9 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	guard_cpus_read_and_cpuset();
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -3506,8 +3500,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	guard_cpus_read_and_cpuset();
 
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
@@ -3529,7 +3522,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
-		goto out_unlock;
+		return 0;
 
 	/*
 	 * Clone @parent's configuration if CGRP_CPUSET_CLONE_CHILDREN is
@@ -3548,7 +3541,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpuset_for_each_child(tmp_cs, pos_css, parent) {
 		if (is_mem_exclusive(tmp_cs) || is_cpu_exclusive(tmp_cs)) {
 			rcu_read_unlock();
-			goto out_unlock;
+			return 0;
 		}
 	}
 	rcu_read_unlock();
@@ -3559,9 +3552,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
-out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
 	return 0;
 }
 
@@ -3576,16 +3566,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	guard_cpus_read_and_cpuset();
 
 	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
 }
 
 /*
@@ -3597,16 +3583,11 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	guard_cpus_read_and_cpuset();
 
 	/* Reset valid partition back to member */
 	if (is_partition_valid(cs))
 		update_prstate(cs, PRS_MEMBER);
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
-
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
-- 
2.34.1


