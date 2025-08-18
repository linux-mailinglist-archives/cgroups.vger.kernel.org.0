Return-Path: <cgroups+bounces-9252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EEB29787
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 05:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D40203868
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 03:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EF260585;
	Mon, 18 Aug 2025 03:59:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4431E8333;
	Mon, 18 Aug 2025 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489549; cv=none; b=gDqVeet3jOfhm1i33Ax2KNlk86SKQkku4b3I3Jj4SzFxtr2Cci1pHdocspcoe452rZgCYyQ8aLMP56n0Mh+e9uMlUSceoaZhyNuiaYF/in0moh6BAvXcO8NDkWFfkSBg8bD+VKXNj24Vo/0YJb82y+7Bo7zm4q9X+PfuCR30YSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489549; c=relaxed/simple;
	bh=JuVG9att7AzkCzxPFDUlM1JXpWkmVAjNjwYJTwtj2KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epV9qv7iDh6zgHFVC65cerrwhpT5LUCVNNXU1gfkrAovYzubdu9H7QSgudtirswukf+EfWPeFJGzY9TO3+xWqBUE9+BhlKTIIbUZJGfR7Yf3SXj9b8UON4Jp9ie6LYieF4pm6fVysJxJ5aQ4Dqy6+QGyt+ZjSQ49+CCHMAO1nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4zVL4Z0GzYQvL4;
	Mon, 18 Aug 2025 11:59:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3B07B1A173E;
	Mon, 18 Aug 2025 11:59:05 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnIhP+pKJot61AEA--.17966S5;
	Mon, 18 Aug 2025 11:59:05 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v3 3/3] cpuset: add helpers for cpus read and cpuset_mutex locks
Date: Mon, 18 Aug 2025 03:44:30 +0000
Message-Id: <20250818034430.1304069-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIhP+pKJot61AEA--.17966S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWfuryftF48uw4DWryxuFg_yoW7Kr45pF
	yq9rW7tayUtr4Duw13G34Dur1rKw1j9FWUGFn5J3WrAFy2yF429F1DCasxWr15KryxCrn8
	W3Zruw4Y9a1DGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrbyCDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

cpuset: add helpers for cpus_read_lock and cpuset_mutex

Replace repetitive locking patterns with new helpers:
- cpus_read_cpuset_lock()
- cpus_read_cpuset_unlock()

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


