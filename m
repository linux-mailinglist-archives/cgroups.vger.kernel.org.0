Return-Path: <cgroups+bounces-4456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABF95F30A
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D68EB2194B
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1401865F8;
	Mon, 26 Aug 2024 13:34:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBA185956;
	Mon, 26 Aug 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679297; cv=none; b=hGC2awhBF77P6HLlKFnFYXYXHGv+yRB4xMvm/uuo5QcO7gHOuK7DDByvwzT7wEaKYS8c/c38ALi/GHXkrZnUumNM0ZTO3e30TJDCEWKfqOhq0cUFyGiUL6xJZ6vZw9T7ngyj8LdORXryvMx7I4fWXp6jd5ZAwK9TBpkvf2b3eng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679297; c=relaxed/simple;
	bh=CXfalMzAbCDg7Dk8otRGSVuPZTZTRHDU54icItbZwcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6V7Kb4/MjhmcEvO6z4HD6Dye8jT+jXAZ1OzcNU/jFdGc1Ygu8YgVV4oKm48F1S0Is1YPeAxCZPLNOwY6mFjvUT8SKoxfyJwtqCTKmWj86tY3BamN+4XbUIF/9SwXZaeyySOl18sEvr3CUxcTkjK+U1QAEJfprMF7oumGvMnAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wss7B66yKz1xw0F;
	Mon, 26 Aug 2024 21:32:54 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E20014022F;
	Mon, 26 Aug 2024 21:34:51 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 21:34:51 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v2 -next 04/11] cgroup/cpuset: move relax_domain_level to cpuset-v1.c
Date: Mon, 26 Aug 2024 13:26:56 +0000
Message-ID: <20240826132703.558956-5-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826132703.558956-1-chenridong@huawei.com>
References: <20240826132703.558956-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Setting domain level is not supported at cpuset v2, so move corresponding
code into cpuset-v1.c.

The 'cpuset_write_s64' and 'cpuset_read_s64' are only used for setting
domain level, move them to cpuset-v1.c. Currently, expose to cpuset.c.
After cpuset legacy interface files are move to cpuset-v1.c, they can
be static. The 'rebuild_sched_domains_locked' is exposed to cpuset-v1.c.

The change from original code is that using 'cpuset_lock' and
'cpuset_unlock' functions to lock or unlock cpuset_mutex.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  6 +++-
 kernel/cgroup/cpuset-v1.c       | 59 +++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 62 ++-------------------------------
 3 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 7911c86bf012..1058a45f05ec 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -238,11 +238,15 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+void rebuild_sched_domains_locked(void);
+
 /*
  * cpuset-v1.c
  */
-
 void fmeter_init(struct fmeter *fmp);
 int fmeter_getrate(struct fmeter *fmp);
+int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
+			    s64 val);
+s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft);
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index f17ba44bc566..175638f2e7b7 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -136,3 +136,62 @@ void __cpuset_memory_pressure_bump(void)
 	rcu_read_unlock();
 }
 
+static int update_relax_domain_level(struct cpuset *cs, s64 val)
+{
+#ifdef CONFIG_SMP
+	if (val < -1 || val > sched_domain_level_max + 1)
+		return -EINVAL;
+#endif
+
+	if (val != cs->relax_domain_level) {
+		cs->relax_domain_level = val;
+		if (!cpumask_empty(cs->cpus_allowed) &&
+		    is_sched_load_balance(cs))
+			rebuild_sched_domains_locked();
+	}
+
+	return 0;
+}
+
+int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
+			    s64 val)
+{
+	struct cpuset *cs = css_cs(css);
+	cpuset_filetype_t type = cft->private;
+	int retval = -ENODEV;
+
+	cpus_read_lock();
+	cpuset_lock();
+	if (!is_cpuset_online(cs))
+		goto out_unlock;
+
+	switch (type) {
+	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
+		retval = update_relax_domain_level(cs, val);
+		break;
+	default:
+		retval = -EINVAL;
+		break;
+	}
+out_unlock:
+	cpuset_unlock();
+	cpus_read_unlock();
+	return retval;
+}
+
+s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct cpuset *cs = css_cs(css);
+	cpuset_filetype_t type = cft->private;
+
+	switch (type) {
+	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
+		return cs->relax_domain_level;
+	default:
+		BUG();
+	}
+
+	/* Unreachable but makes gcc happy */
+	return 0;
+}
+
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 17f7984a41f5..45031a17e068 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1069,7 +1069,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  *
  * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
-static void rebuild_sched_domains_locked(void)
+void rebuild_sched_domains_locked(void)
 {
 	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
@@ -1121,7 +1121,7 @@ static void rebuild_sched_domains_locked(void)
 	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 }
 #else /* !CONFIG_SMP */
-static void rebuild_sched_domains_locked(void)
+void rebuild_sched_domains_locked(void)
 {
 }
 #endif /* CONFIG_SMP */
@@ -2788,23 +2788,6 @@ bool current_cpuset_is_being_rebound(void)
 	return ret;
 }
 
-static int update_relax_domain_level(struct cpuset *cs, s64 val)
-{
-#ifdef CONFIG_SMP
-	if (val < -1 || val > sched_domain_level_max + 1)
-		return -EINVAL;
-#endif
-
-	if (val != cs->relax_domain_level) {
-		cs->relax_domain_level = val;
-		if (!cpumask_empty(cs->cpus_allowed) &&
-		    is_sched_load_balance(cs))
-			rebuild_sched_domains_locked();
-	}
-
-	return 0;
-}
-
 /**
  * update_tasks_flags - update the spread flags of tasks in the cpuset.
  * @cs: the cpuset in which each task's spread flags needs to be changed
@@ -3267,32 +3250,6 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
-static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
-			    s64 val)
-{
-	struct cpuset *cs = css_cs(css);
-	cpuset_filetype_t type = cft->private;
-	int retval = -ENODEV;
-
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
-	if (!is_cpuset_online(cs))
-		goto out_unlock;
-
-	switch (type) {
-	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
-		retval = update_relax_domain_level(cs, val);
-		break;
-	default:
-		retval = -EINVAL;
-		break;
-	}
-out_unlock:
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
-	return retval;
-}
-
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
@@ -3443,21 +3400,6 @@ static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
-static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
-{
-	struct cpuset *cs = css_cs(css);
-	cpuset_filetype_t type = cft->private;
-	switch (type) {
-	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
-		return cs->relax_domain_level;
-	default:
-		BUG();
-	}
-
-	/* Unreachable but makes gcc happy */
-	return 0;
-}
-
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
-- 
2.34.1


