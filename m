Return-Path: <cgroups+bounces-9123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F139AB24492
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 10:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5432A2256
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683872F0C47;
	Wed, 13 Aug 2025 08:43:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE52F0692;
	Wed, 13 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074613; cv=none; b=PfW8H1GFva67t9wJNYEHHcYF+YdLbus7E+Mx81Z3VnXuQv582bzwMirLc8p08uqBF9wPZbe40D7tj2F5lRtJVXYGnl4YOCObj0Or71vyv2iZdAwstFmZCHHQ0ONIYdcXlQmtdEH57VvMYjIstU308by38MIshZw5RlE71fUENu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074613; c=relaxed/simple;
	bh=OdgxX4Rn7gFH8ZsT0xUJqucClnQOuiA6GibA7838GO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AX2x7Biqpmb8RKu8O3Qa21vMw3P61c+3KOIvY+/uVJGLydMcg7luIhuEcTRNZoopFcnwFbZSQKHFVgCjXMhZ6DpV8Ggocc9htpQq6mcxfKVjOTQvmsYmzvhhx32r9cvP6POvQS5erVWdXD+2zPxPBhH7gW+BKct4CdCrevWTWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c222n2JtDzKHMx3;
	Wed, 13 Aug 2025 16:43:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 933361A1BA6;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg8qUJxoaYwdDg--.28644S6;
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
Subject: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex locks
Date: Wed, 13 Aug 2025 08:29:04 +0000
Message-Id: <20250813082904.1091651-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHDg8qUJxoaYwdDg--.28644S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWfuryftF47Kr4rXF48tFb_yoW7CrWDpF
	yq9rW7trWUtrs7uw13G34Dur18Kw1jgF4UGF1kJ3WrZFy7AFsI9FyDCasxWr1Ygry7Crn8
	W3Zruws0vayDJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoo7KUUUUU
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
 kernel/cgroup/cpuset-v1.c       | 12 +++------
 kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 75b3aef39231..6fb00c96044d 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
 ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off);
 int cpuset_common_seq_show(struct seq_file *sf, void *v);
+void cpus_read_cpuset_lock(void);
+void cpus_read_cpuset_unlock(void);
 
 /*
  * cpuset-v1.c
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index b69a7db67090..f3d2d116c842 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -169,8 +169,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	cpus_read_lock();
-	cpuset_lock();
+	cpus_read_cpuset_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -184,8 +183,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 	return retval;
 }
 
@@ -454,8 +452,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	cpus_read_lock();
-	cpuset_lock();
+	cpus_read_cpuset_lock();
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -498,8 +495,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	cpuset_unlock();
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 	return retval;
 }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3c5e44f824d1..9c0e8f297aaf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -260,6 +260,18 @@ void cpuset_unlock(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+void cpus_read_cpuset_lock(void)
+{
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+}
+
+void cpus_read_cpuset_unlock(void)
+{
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+}
+
 static DEFINE_SPINLOCK(callback_lock);
 
 void cpuset_callback_lock_irq(void)
@@ -3233,8 +3245,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	int retval = -ENODEV;
 
 	buf = strstrip(buf);
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	cpus_read_cpuset_lock();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -3263,8 +3274,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 	flush_workqueue(cpuset_migrate_mm_wq);
 	return retval ?: nbytes;
 }
@@ -3367,12 +3377,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
 	else
 		return -EINVAL;
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	cpus_read_cpuset_lock();
 	if (is_cpuset_online(cs))
 		retval = update_prstate(cs, val);
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 	return retval ?: nbytes;
 }
 
@@ -3497,9 +3505,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpus_read_cpuset_lock();
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
@@ -3551,8 +3557,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 	return 0;
 }
 
@@ -3567,16 +3572,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpus_read_cpuset_lock();
 	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpus_read_cpuset_unlock();
 }
 
 /*
@@ -3588,16 +3589,11 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-
+	cpus_read_cpuset_lock();
 	/* Reset valid partition back to member */
 	if (is_partition_valid(cs))
 		update_prstate(cs, PRS_MEMBER);
-
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
-
+	cpus_read_cpuset_unlock();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
-- 
2.34.1


