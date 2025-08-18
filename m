Return-Path: <cgroups+bounces-9258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8CB29A5E
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108933B1E8E
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD8279331;
	Mon, 18 Aug 2025 06:56:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542027BF6F;
	Mon, 18 Aug 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500185; cv=none; b=FRRDY4FKEuRsC8aSWEllEssSSgOjRJsnC4kte48gfAH1+pnMug4tKXma7eCOd/sqVqoeMvbX+3fQHb2/T0HxCr+BsGn70o91YKJpliQ9nfjCg7IzyR6UeKJ91fXH1BL9oSalaKmq3d1dZIwVAQ6/UbhqMAAouTwuoWzLrBqsnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500185; c=relaxed/simple;
	bh=8RrSXNYUXXgdtquNh357VcdePORcjqY/Gj8+7VjE6Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8dkDdYvefYDY85GH7SKFWS0rUNwQmqt7sDqmwB5QqfnnUEgxJge/wVkRohTuhUapwlMCcDImH2nnCs7jJeXxe7WfXipqfSoembCpRBakfYyv3SNsrOEYdSA2UMUv+wZ8NSaQaD2Fyk1xQfSGGpiKUs8maq4h1Mq3ofxLTs4dG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c53Qs6jxNzYQvbv;
	Mon, 18 Aug 2025 14:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 823A11A0EDA;
	Mon, 18 Aug 2025 14:56:20 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg+FzqJoKNJOEA--.3242S5;
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
Subject: [PATCH -next v4 3/3] cpuset: add helpers for cpus read and cpuset_mutex locks
Date: Mon, 18 Aug 2025 06:41:41 +0000
Message-Id: <20250818064141.1334859-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818064141.1334859-1-chenridong@huaweicloud.com>
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg+FzqJoKNJOEA--.3242S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWfGF4Dtr1UGr4xuF4xCrg_yoW7Kr1DpF
	yq9rW7tayUtr4Duw17G34Dur1rKw1j9FWUGFn5J3WrAFy2yF429F1DCF9xWr15GryxCrn8
	W3Zruw4Y9a1DGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1UPE3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.

Replace repetitive locking patterns with new helpers:
- cpuset_full_lock()
- cpuset_full_unlock()

This makes the code cleaner and ensures consistent lock ordering.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  2 ++
 kernel/cgroup/cpuset-v1.c       | 12 +++----
 kernel/cgroup/cpuset.c          | 60 +++++++++++++++++++--------------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 75b3aef39231..337608f408ce 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
 ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off);
 int cpuset_common_seq_show(struct seq_file *sf, void *v);
+void cpuset_full_lock(void);
+void cpuset_full_unlock(void);
 
 /*
  * cpuset-v1.c
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b69a7db67090..12e76774c75b 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -169,8 +169,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	cpus_read_lock();
-	cpuset_lock();
+	cpuset_full_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -184,8 +183,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
+	cpuset_full_unlock();
 	return retval;
 }
 
@@ -454,8 +452,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	cpus_read_lock();
-	cpuset_lock();
+	cpuset_full_lock();
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -498,8 +495,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
+	cpuset_full_unlock();
 	return retval;
 }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d5588a1fef60..d29f90a28e1e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -250,6 +250,12 @@ static struct cpuset top_cpuset = {
 
 static DEFINE_MUTEX(cpuset_mutex);
 
+/**
+ * cpuset_lock - Acquire the global cpuset mutex
+ *
+ * This locks the global cpuset mutex to prevent modifications to cpuset
+ * hierarchy and configurations. This helper is not enough to make modification.
+ */
 void cpuset_lock(void)
 {
 	mutex_lock(&cpuset_mutex);
@@ -260,6 +266,24 @@ void cpuset_unlock(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/**
+ * cpuset_full_lock - Acquire full protection for cpuset modification
+ *
+ * Takes both CPU hotplug read lock (cpus_read_lock()) and cpuset mutex
+ * to safely modify cpuset data.
+ */
+void cpuset_full_lock(void)
+{
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+}
+
+void cpuset_full_unlock(void)
+{
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+}
+
 static DEFINE_SPINLOCK(callback_lock);
 
 void cpuset_callback_lock_irq(void)
@@ -3233,8 +3257,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	int retval = -ENODEV;
 
 	buf = strstrip(buf);
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	cpuset_full_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -3263,8 +3286,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpuset_full_unlock();
 	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
@@ -3367,12 +3389,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	cpuset_full_lock();
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpuset_full_unlock();
 	return retval ?: nbytes;
 }
 
@@ -3497,9 +3517,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpuset_full_lock();
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
@@ -3551,8 +3569,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpuset_full_unlock();
 	return 0;
 }
 
@@ -3567,16 +3584,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpuset_full_lock();
 	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpuset_full_unlock();
 }
 
 /*
@@ -3588,16 +3601,11 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpuset_full_lock();
 	/* Reset valid partition back to member */
 	if (is_partition_valid(cs))
 		update_prstate(cs, PRS_MEMBER);
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
-
+	cpuset_full_unlock();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
-- 
2.34.1


