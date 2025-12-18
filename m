Return-Path: <cgroups+bounces-12497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0493CCB407
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC09309FB05
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0171332908;
	Thu, 18 Dec 2025 09:46:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601823328ED;
	Thu, 18 Dec 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051206; cv=none; b=YGwH65AThaOnmjHWL/KZN4d9LMV0YYE3YlRcMUuV3EgZLifa47Q0UnQrmpJRjnG5TCTtWJWrcGFL/Eqi0F8XW6m1fE9LhJkrniHnLB/CoTtQ2eiHUAoDMk6CbmqAEESSGTA11dZYgF7QI7pvLtyGuNPAtXlto9OoJ4rZA8ky0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051206; c=relaxed/simple;
	bh=wZBl7x8+Ne/XNK8QrztwYkC4j/fLfB8EzFHDjngzbK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNicqljMlPD75RK6AYOg4ZRRUnkHyykgCqKfwZCFNwTjMuwxgGtjPIRCzHEJuNm6xQ1N0hFf9jDIK7EF+CzHPE6nFo3kniuOTh+S1gV1sP+2run9UnYmI3XrqedbvWQxzO3a1SJepJvJPH9KWCqVnlJz4RclBrx9blqEluF0V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX5QS4hwHzYQv6M;
	Thu, 18 Dec 2025 17:46:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0569C40576;
	Thu, 18 Dec 2025 17:46:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA35vZxzUNpHcJzAg--.22754S7;
	Thu, 18 Dec 2025 17:46:36 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 5/6] cpuset: separate generate_sched_domains for v1 and v2
Date: Thu, 18 Dec 2025 09:31:40 +0000
Message-Id: <20251218093141.2687291-6-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218093141.2687291-1-chenridong@huaweicloud.com>
References: <20251218093141.2687291-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vZxzUNpHcJzAg--.22754S7
X-Coremail-Antispam: 1UD129KBjvJXoWfJr4rGw15Kr1UCry7XF1kZrb_yoWDuFW3pF
	W8urW2vrWUtr1xu3yrCa18Z34a9wn7JFWUt3W5G3s5AF17tF1DuFy0vF9Ikry5urWDCrWU
	ZFsIq3y3u3WqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYcTQUUUU
	U
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The generate_sched_domains() function currently handles both v1 and v2
logic. However, the underlying mechanisms for building scheduler domains
differ significantly between the two versions. For cpuset v2, scheduler
domains are straightforwardly derived from valid partitions, whereas
cpuset v1 employs a more complex union-find algorithm to merge overlapping
cpusets. Co-locating these implementations complicates maintenance.

This patch, along with subsequent ones, aims to separate the v1 and v2
logic. For ease of review, this patch first copies the
generate_sched_domains() function into cpuset-v1.c as
cpuset1_generate_sched_domains() and removes v2-specific code. Common
helpers and top_cpuset are declared in cpuset-internal.h. When operating
in v1 mode, the code now calls cpuset1_generate_sched_domains().

Currently there is some code duplication, which will be largely eliminated
once v1-specific code is removed from v2 in the following patch.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  23 +++++
 kernel/cgroup/cpuset-v1.c       | 158 ++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          |  31 +------
 3 files changed, 185 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 677053ffb913..8622a4666170 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -9,6 +9,7 @@
 #include <linux/cpuset.h>
 #include <linux/spinlock.h>
 #include <linux/union_find.h>
+#include <linux/sched/isolation.h>
 
 /* See "Frequency meter" comments, below. */
 
@@ -185,6 +186,8 @@ struct cpuset {
 #endif
 };
 
+extern struct cpuset top_cpuset;
+
 static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct cpuset, css) : NULL;
@@ -242,6 +245,21 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+/*
+ * Helper routine for generate_sched_domains().
+ * Do cpusets a, b have overlapping effective cpus_allowed masks?
+ */
+static inline int cpusets_overlap(struct cpuset *a, struct cpuset *b)
+{
+	return cpumask_intersects(a->effective_cpus, b->effective_cpus);
+}
+
+static inline int nr_cpusets(void)
+{
+	/* jump label reference count + the top-level cpuset */
+	return static_key_count(&cpusets_enabled_key.key) + 1;
+}
+
 /**
  * cpuset_for_each_child - traverse online children of a cpuset
  * @child_cs: loop cursor pointing to the current child
@@ -298,6 +316,9 @@ void cpuset1_init(struct cpuset *cs);
 void cpuset1_online_css(struct cgroup_subsys_state *css);
 void update_domain_attr_tree(struct sched_domain_attr *dattr,
 				    struct cpuset *root_cs);
+int cpuset1_generate_sched_domains(cpumask_var_t **domains,
+			struct sched_domain_attr **attributes);
+
 #else
 static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk) {}
@@ -311,6 +332,8 @@ static inline void cpuset1_init(struct cpuset *cs) {}
 static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
 static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
 				    struct cpuset *root_cs) {}
+static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
+			struct sched_domain_attr **attributes) { return 0; };
 
 #endif /* CONFIG_CPUSETS_V1 */
 
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index a4f8f1c3cfaa..ffa7a8dc6c3a 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -580,6 +580,164 @@ void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
+/*
+ * cpuset1_generate_sched_domains()
+ *
+ * Finding the best partition (set of domains):
+ *	The double nested loops below over i, j scan over the load
+ *	balanced cpusets (using the array of cpuset pointers in csa[])
+ *	looking for pairs of cpusets that have overlapping cpus_allowed
+ *	and merging them using a union-find algorithm.
+ *
+ *	The union of the cpus_allowed masks from the set of all cpusets
+ *	having the same root then form the one element of the partition
+ *	(one sched domain) to be passed to partition_sched_domains().
+ */
+int cpuset1_generate_sched_domains(cpumask_var_t **domains,
+			struct sched_domain_attr **attributes)
+{
+	struct cpuset *cp;	/* top-down scan of cpusets */
+	struct cpuset **csa;	/* array of all cpuset ptrs */
+	int csn;		/* how many cpuset ptrs in csa so far */
+	int i, j;		/* indices for partition finding loops */
+	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
+	struct sched_domain_attr *dattr;  /* attributes for custom domains */
+	int ndoms = 0;		/* number of sched domains in result */
+	int nslot;		/* next empty doms[] struct cpumask slot */
+	struct cgroup_subsys_state *pos_css;
+	bool root_load_balance = is_sched_load_balance(&top_cpuset);
+	int nslot_update;
+
+	lockdep_assert_cpuset_lock_held();
+
+	doms = NULL;
+	dattr = NULL;
+	csa = NULL;
+
+	/* Special case for the 99% of systems with one, full, sched domain */
+	if (root_load_balance) {
+		ndoms = 1;
+		doms = alloc_sched_domains(ndoms);
+		if (!doms)
+			goto done;
+
+		dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
+		if (dattr) {
+			*dattr = SD_ATTR_INIT;
+			update_domain_attr_tree(dattr, &top_cpuset);
+		}
+		cpumask_and(doms[0], top_cpuset.effective_cpus,
+			    housekeeping_cpumask(HK_TYPE_DOMAIN));
+
+		goto done;
+	}
+
+	csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
+	if (!csa)
+		goto done;
+	csn = 0;
+
+	rcu_read_lock();
+	if (root_load_balance)
+		csa[csn++] = &top_cpuset;
+	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
+		if (cp == &top_cpuset)
+			continue;
+
+		/*
+		 * Continue traversing beyond @cp iff @cp has some CPUs and
+		 * isn't load balancing.  The former is obvious.  The
+		 * latter: All child cpusets contain a subset of the
+		 * parent's cpus, so just skip them, and then we call
+		 * update_domain_attr_tree() to calc relax_domain_level of
+		 * the corresponding sched domain.
+		 */
+		if (!cpumask_empty(cp->cpus_allowed) &&
+		    !(is_sched_load_balance(cp) &&
+		      cpumask_intersects(cp->cpus_allowed,
+					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
+			continue;
+
+		if (is_sched_load_balance(cp) &&
+		    !cpumask_empty(cp->effective_cpus))
+			csa[csn++] = cp;
+
+		/* skip @cp's subtree */
+		pos_css = css_rightmost_descendant(pos_css);
+		continue;
+	}
+	rcu_read_unlock();
+
+	for (i = 0; i < csn; i++)
+		uf_node_init(&csa[i]->node);
+
+	/* Merge overlapping cpusets */
+	for (i = 0; i < csn; i++) {
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j]))
+				uf_union(&csa[i]->node, &csa[j]->node);
+		}
+	}
+
+	/* Count the total number of domains */
+	for (i = 0; i < csn; i++) {
+		if (uf_find(&csa[i]->node) == &csa[i]->node)
+			ndoms++;
+	}
+
+	/*
+	 * Now we know how many domains to create.
+	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
+	 */
+	doms = alloc_sched_domains(ndoms);
+	if (!doms)
+		goto done;
+
+	/*
+	 * The rest of the code, including the scheduler, can deal with
+	 * dattr==NULL case. No need to abort if alloc fails.
+	 */
+	dattr = kmalloc_array(ndoms, sizeof(struct sched_domain_attr),
+			      GFP_KERNEL);
+
+	for (nslot = 0, i = 0; i < csn; i++) {
+		nslot_update = 0;
+		for (j = i; j < csn; j++) {
+			if (uf_find(&csa[j]->node) == &csa[i]->node) {
+				struct cpumask *dp = doms[nslot];
+
+				if (i == j) {
+					nslot_update = 1;
+					cpumask_clear(dp);
+					if (dattr)
+						*(dattr + nslot) = SD_ATTR_INIT;
+				}
+				cpumask_or(dp, dp, csa[j]->effective_cpus);
+				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
+				if (dattr)
+					update_domain_attr_tree(dattr + nslot, csa[j]);
+			}
+		}
+		if (nslot_update)
+			nslot++;
+	}
+	BUG_ON(nslot != ndoms);
+
+done:
+	kfree(csa);
+
+	/*
+	 * Fallback to the default domain if kmalloc() failed.
+	 * See comments in partition_sched_domains().
+	 */
+	if (doms == NULL)
+		ndoms = 1;
+
+	*domains    = doms;
+	*attributes = dattr;
+	return ndoms;
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cf2363a9c552..33c929b191e8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -211,7 +211,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
  * If cpu_online_mask is used while a hotunplug operation is happening in
  * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
  */
-static struct cpuset top_cpuset = {
+struct cpuset top_cpuset = {
 	.flags = BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
@@ -744,21 +744,6 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 }
 
 #ifdef CONFIG_SMP
-/*
- * Helper routine for generate_sched_domains().
- * Do cpusets a, b have overlapping effective cpus_allowed masks?
- */
-static int cpusets_overlap(struct cpuset *a, struct cpuset *b)
-{
-	return cpumask_intersects(a->effective_cpus, b->effective_cpus);
-}
-
-/* Must be called with cpuset_mutex held.  */
-static inline int nr_cpusets(void)
-{
-	/* jump label reference count + the top-level cpuset */
-	return static_key_count(&cpusets_enabled_key.key) + 1;
-}
 
 /*
  * generate_sched_domains()
@@ -798,17 +783,6 @@ static inline int nr_cpusets(void)
  *	   convenient format, that can be easily compared to the prior
  *	   value to determine what partition elements (sched domains)
  *	   were changed (added or removed.)
- *
- * Finding the best partition (set of domains):
- *	The double nested loops below over i, j scan over the load
- *	balanced cpusets (using the array of cpuset pointers in csa[])
- *	looking for pairs of cpusets that have overlapping cpus_allowed
- *	and merging them using a union-find algorithm.
- *
- *	The union of the cpus_allowed masks from the set of all cpusets
- *	having the same root then form the one element of the partition
- *	(one sched domain) to be passed to partition_sched_domains().
- *
  */
 static int generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes)
@@ -826,6 +800,9 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	bool cgrpv2 = cpuset_v2();
 	int nslot_update;
 
+	if (!cgrpv2)
+		return cpuset1_generate_sched_domains(domains, attributes);
+
 	doms = NULL;
 	dattr = NULL;
 	csa = NULL;
-- 
2.34.1


