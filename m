Return-Path: <cgroups+bounces-4610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EE965E07
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0142FB20E00
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0117C7C4;
	Fri, 30 Aug 2024 10:10:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EF17B509;
	Fri, 30 Aug 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012625; cv=none; b=BkLMr3Lm2D3L198G1ALOnyx+ZeUX7pw5bmw8H+IX7Z3QKHHt7dV6rNKco43H8uQ1X9TjN9yJgLuoBniwbNPbJKmY36tr0icpsVSDDQ2h+Plk0ANzLCW2UuO5785G57ofF9tXf3yKU7fo2ac9A/QDXl3q0HMRn1m6VOhG5LU2Cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012625; c=relaxed/simple;
	bh=Lq30TMTvq1nugXdlbEuSNodsHxxvnLeUppxtBC2RRCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im+i7+ax1lZ/BmXJI+wyXQjiUVXSOZRLkBpQO3mO0V82tIcuIc+ZsLloyXS5BIUyHHwch6OF/bN4H6hqEl0owoNsbNTCKsO5PpnBq8+3vIxKq1j/Sh0awKTU9CArtrCvINSXSgVXm/fAarte65WpjZ1OwilO3Vn+kgC2V0l0mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WwDRL4SxVz1S9Qx;
	Fri, 30 Aug 2024 18:10:06 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 138F11A0188;
	Fri, 30 Aug 2024 18:10:21 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:20 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 04/12] cgroup/cpuset: move relax_domain_level to cpuset-v1.c
Date: Fri, 30 Aug 2024 10:02:21 +0000
Message-ID: <20240830100229.953012-5-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
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
index e7d137ff57cf..c7b321029cbb 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -135,3 +135,62 @@ void __cpuset_memory_pressure_bump(void)
 	fmeter_markevent(&task_cs(current)->fmeter);
 	rcu_read_unlock();
 }
+
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


