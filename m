Return-Path: <cgroups+bounces-4457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD195F30C
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 15:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3833D2815B1
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77A18FC92;
	Mon, 26 Aug 2024 13:34:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050D18890F;
	Mon, 26 Aug 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679297; cv=none; b=KZKEA+1AEyYxWP5yEXIWjjrMZcbZ3t2cai6oyZCd3GKyrqrNJq9sMaATarrv2gqs3ktyGGA1efhVohRjv8ee8aW3u7INBS/uchEisvm93n1oK6x+oN7V3uG/lgubeW6ur/P/P1dUMXjendPlx9DVaYyCyz1xRrVz4qQ059OY9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679297; c=relaxed/simple;
	bh=vo4xB7kAPDJy3wvOmvTBvDI9+iWmkaewkqIzP/g06m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8fbh9CYZp9fqaj33mlJ/H0fLz8e7aPnZ0WurDRruq+UEB5B9XPT7+kfiW5WvfatFdP0wJ5x/9y6FiZm0KfVIYeJWJSKoY4+Vhw9mPMcMUwBScMsd7VJ9XYmGPMgzqYJCf9DuxzUQTVvz0FJbm+21vIyML25f3Iccl0KskcHoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wss762vc2zfZd4;
	Mon, 26 Aug 2024 21:32:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6246814037E;
	Mon, 26 Aug 2024 21:34:53 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 21:34:52 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v2 -next 08/11] cgroup/cpuset: move validate_change_legacy to cpuset-v1.c
Date: Mon, 26 Aug 2024 13:27:00 +0000
Message-ID: <20240826132703.558956-9-chenridong@huawei.com>
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

The validate_change_legacy functions is used for v1, move it to
cpuset-v1.c. And two micro 'cpuset_for_each_child' and
'cpuset_for_each_descendant_pre' are common for v1 and v2, move them to
cpuset-internal.h.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h | 29 +++++++++++++
 kernel/cgroup/cpuset-v1.c       | 45 ++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 73 ---------------------------------
 3 files changed, 74 insertions(+), 73 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 7cd30ad809d5..07551ff0812e 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -238,6 +238,34 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+/**
+ * cpuset_for_each_child - traverse online children of a cpuset
+ * @child_cs: loop cursor pointing to the current child
+ * @pos_css: used for iteration
+ * @parent_cs: target cpuset to walk children of
+ *
+ * Walk @child_cs through the online children of @parent_cs.  Must be used
+ * with RCU read locked.
+ */
+#define cpuset_for_each_child(child_cs, pos_css, parent_cs)		\
+	css_for_each_child((pos_css), &(parent_cs)->css)		\
+		if (is_cpuset_online(((child_cs) = css_cs((pos_css)))))
+
+/**
+ * cpuset_for_each_descendant_pre - pre-order walk of a cpuset's descendants
+ * @des_cs: loop cursor pointing to the current descendant
+ * @pos_css: used for iteration
+ * @root_cs: target cpuset to walk ancestor of
+ *
+ * Walk @des_cs through the online descendants of @root_cs.  Must be used
+ * with RCU read locked.  The caller may modify @pos_css by calling
+ * css_rightmost_descendant() to skip subtree.  @root_cs is included in the
+ * iteration and the first node to be visited.
+ */
+#define cpuset_for_each_descendant_pre(des_cs, pos_css, root_cs)	\
+	css_for_each_descendant_pre((pos_css), &(root_cs)->css)		\
+		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
+
 void rebuild_sched_domains_locked(void);
 void callback_lock_irq(void);
 void callback_unlock_irq(void);
@@ -258,5 +286,6 @@ void update_tasks_flags(struct cpuset *cs);
 void hotplug_update_tasks_legacy(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
+int validate_change_legacy(struct cpuset *cur, struct cpuset *trial);
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ce1d00746e92..246fc962f549 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -328,3 +328,48 @@ void hotplug_update_tasks_legacy(struct cpuset *cs,
 	}
 }
 
+/*
+ * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
+ *
+ * One cpuset is a subset of another if all its allowed CPUs and
+ * Memory Nodes are a subset of the other, and its exclusive flags
+ * are only set if the other's are set.  Call holding cpuset_mutex.
+ */
+
+static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
+{
+	return	cpumask_subset(p->cpus_allowed, q->cpus_allowed) &&
+		nodes_subset(p->mems_allowed, q->mems_allowed) &&
+		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
+		is_mem_exclusive(p) <= is_mem_exclusive(q);
+}
+
+/*
+ * validate_change_legacy() - Validate conditions specific to legacy (v1)
+ *                            behavior.
+ */
+int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *c, *par;
+	int ret;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	/* Each of our child cpusets must be a subset of us */
+	ret = -EBUSY;
+	cpuset_for_each_child(c, css, cur)
+		if (!is_cpuset_subset(c, trial))
+			goto out;
+
+	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
+	ret = -EACCES;
+	par = parent_cs(cur);
+	if (par && !is_cpuset_subset(trial, par))
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b93ef0b48eae..4412a4168902 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -180,34 +180,6 @@ static struct cpuset top_cpuset = {
 	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
 };
 
-/**
- * cpuset_for_each_child - traverse online children of a cpuset
- * @child_cs: loop cursor pointing to the current child
- * @pos_css: used for iteration
- * @parent_cs: target cpuset to walk children of
- *
- * Walk @child_cs through the online children of @parent_cs.  Must be used
- * with RCU read locked.
- */
-#define cpuset_for_each_child(child_cs, pos_css, parent_cs)		\
-	css_for_each_child((pos_css), &(parent_cs)->css)		\
-		if (is_cpuset_online(((child_cs) = css_cs((pos_css)))))
-
-/**
- * cpuset_for_each_descendant_pre - pre-order walk of a cpuset's descendants
- * @des_cs: loop cursor pointing to the current descendant
- * @pos_css: used for iteration
- * @root_cs: target cpuset to walk ancestor of
- *
- * Walk @des_cs through the online descendants of @root_cs.  Must be used
- * with RCU read locked.  The caller may modify @pos_css by calling
- * css_rightmost_descendant() to skip subtree.  @root_cs is included in the
- * iteration and the first node to be visited.
- */
-#define cpuset_for_each_descendant_pre(des_cs, pos_css, root_cs)	\
-	css_for_each_descendant_pre((pos_css), &(root_cs)->css)		\
-		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
-
 /*
  * There are two global locks guarding cpuset structures - cpuset_mutex and
  * callback_lock. We also require taking task_lock() when dereferencing a
@@ -403,22 +375,6 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
 }
 
-/*
- * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
- *
- * One cpuset is a subset of another if all its allowed CPUs and
- * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_mutex.
- */
-
-static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
-{
-	return	cpumask_subset(p->cpus_allowed, q->cpus_allowed) &&
-		nodes_subset(p->mems_allowed, q->mems_allowed) &&
-		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
-		is_mem_exclusive(p) <= is_mem_exclusive(q);
-}
-
 /**
  * alloc_cpumasks - allocate three cpumasks for cpuset
  * @cs:  the cpuset that have cpumasks to be allocated.
@@ -549,35 +505,6 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 	return true;
 }
 
-/*
- * validate_change_legacy() - Validate conditions specific to legacy (v1)
- *                            behavior.
- */
-static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
-{
-	struct cgroup_subsys_state *css;
-	struct cpuset *c, *par;
-	int ret;
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	/* Each of our child cpusets must be a subset of us */
-	ret = -EBUSY;
-	cpuset_for_each_child(c, css, cur)
-		if (!is_cpuset_subset(c, trial))
-			goto out;
-
-	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
-	ret = -EACCES;
-	par = parent_cs(cur);
-	if (par && !is_cpuset_subset(trial, par))
-		goto out;
-
-	ret = 0;
-out:
-	return ret;
-}
-
 /*
  * validate_change() - Used to validate that any proposed cpuset change
  *		       follows the structural rules for cpusets.
-- 
2.34.1


