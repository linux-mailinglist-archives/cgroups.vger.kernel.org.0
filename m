Return-Path: <cgroups+bounces-12498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD4CCB40A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1708630A3200
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074733290C;
	Thu, 18 Dec 2025 09:46:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602143328F3;
	Thu, 18 Dec 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051206; cv=none; b=KHt8ZPvGE8xjORpzvpKiBhtXmchR0dUSd7j0t5W7zuOrHs32QJ6qA8P907RsLDM7NR7HaKBLfQg2FIK8N+G2kucMF2Apqbf3PeVakfRIpPNjiwE6UMHMX6rZ8KcVF+8VqioajioiPnra5XQNP6irO5HWWguWdjVqhNqpV5Wya7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051206; c=relaxed/simple;
	bh=s6FqSO7UAPYGyKrjenr4VMbg3mMAX3ZTlhNX6z4gP38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpaZGqLmKUq3VWW4d5+KmqOBbPCYeocVVbwsxt/trAsAhWyAu9jx4IhX1A17YjmLsJblXwXxVt2+x19h1yUnc6EWsHhjLM7i+CF4g2GzkQkuYkUXnDJkTb8jf7p2/jvarrhaYyYWjeub/8487WOnTE60/wyHymuYQis/loZjgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dX5QS52kdzYQv7s;
	Thu, 18 Dec 2025 17:46:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 145BF4058D;
	Thu, 18 Dec 2025 17:46:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA35vZxzUNpHcJzAg--.22754S8;
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
Subject: [PATCH -next v2 6/6] cpuset: remove v1-specific code from generate_sched_domains
Date: Thu, 18 Dec 2025 09:31:41 +0000
Message-Id: <20251218093141.2687291-7-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA35vZxzUNpHcJzAg--.22754S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWrWw18Wry3KF4ftrW7XFb_yoWfGryfpF
	W8Cay2qrW5tr1UG39YkwsrZ34S9wsrGayUK3W5Wwn5ZF17t3Wv9Fy0v3ZxCFWY9FyDCr13
	ZFZIgr4fW3WqkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbx9NDUU
	UUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Following the introduction of cpuset1_generate_sched_domains() for v1
in the previous patch, v1-specific logic can now be removed from the
generic generate_sched_domains(). This patch cleans up the v1-only
code and ensures uf_node is only visible when CONFIG_CPUSETS_V1=y.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  10 +--
 kernel/cgroup/cpuset-v1.c       |   2 +-
 kernel/cgroup/cpuset.c          | 145 ++++++--------------------------
 3 files changed, 28 insertions(+), 129 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 8622a4666170..e718a4f54360 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -175,14 +175,14 @@ struct cpuset {
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
 
-	/* Used to merge intersecting subsets for generate_sched_domains */
-	struct uf_node node;
-
 #ifdef CONFIG_CPUSETS_V1
 	struct fmeter fmeter;		/* memory_pressure filter */
 
 	/* for custom sched domain */
 	int relax_domain_level;
+
+	/* Used to merge intersecting subsets for generate_sched_domains */
+	struct uf_node node;
 #endif
 };
 
@@ -314,8 +314,6 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
 void cpuset1_init(struct cpuset *cs);
 void cpuset1_online_css(struct cgroup_subsys_state *css);
-void update_domain_attr_tree(struct sched_domain_attr *dattr,
-				    struct cpuset *root_cs);
 int cpuset1_generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes);
 
@@ -330,8 +328,6 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
 				struct cpuset *trial) { return 0; }
 static inline void cpuset1_init(struct cpuset *cs) {}
 static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
-static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
-				    struct cpuset *root_cs) {}
 static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes) { return 0; };
 
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ffa7a8dc6c3a..7303315fdba7 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -560,7 +560,7 @@ update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
 		dattr->relax_domain_level = c->relax_domain_level;
 }
 
-void update_domain_attr_tree(struct sched_domain_attr *dattr,
+static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 				    struct cpuset *root_cs)
 {
 	struct cpuset *cp;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 33c929b191e8..221da921b4f9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -789,18 +789,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
 {
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
-	int csn;		/* how many cpuset ptrs in csa so far */
 	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
-	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
-	bool root_load_balance = is_sched_load_balance(&top_cpuset);
-	bool cgrpv2 = cpuset_v2();
-	int nslot_update;
 
-	if (!cgrpv2)
+	if (!cpuset_v2())
 		return cpuset1_generate_sched_domains(domains, attributes);
 
 	doms = NULL;
@@ -808,70 +803,26 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	csa = NULL;
 
 	/* Special case for the 99% of systems with one, full, sched domain */
-	if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
-single_root_domain:
+	if (cpumask_empty(subpartitions_cpus)) {
 		ndoms = 1;
-		doms = alloc_sched_domains(ndoms);
-		if (!doms)
-			goto done;
-
-		dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
-		if (dattr) {
-			*dattr = SD_ATTR_INIT;
-			update_domain_attr_tree(dattr, &top_cpuset);
-		}
-		cpumask_and(doms[0], top_cpuset.effective_cpus,
-			    housekeeping_cpumask(HK_TYPE_DOMAIN));
-
-		goto done;
+		/* !csa will be checked and can be correctly handled */
+		goto generate_doms;
 	}
 
 	csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
 	if (!csa)
 		goto done;
-	csn = 0;
 
+	/* Find how many partitions and cache them to csa[] */
 	rcu_read_lock();
-	if (root_load_balance)
-		csa[csn++] = &top_cpuset;
 	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
-		if (cp == &top_cpuset)
-			continue;
-
-		if (cgrpv2)
-			goto v2;
-
-		/*
-		 * v1:
-		 * Continue traversing beyond @cp iff @cp has some CPUs and
-		 * isn't load balancing.  The former is obvious.  The
-		 * latter: All child cpusets contain a subset of the
-		 * parent's cpus, so just skip them, and then we call
-		 * update_domain_attr_tree() to calc relax_domain_level of
-		 * the corresponding sched domain.
-		 */
-		if (!cpumask_empty(cp->cpus_allowed) &&
-		    !(is_sched_load_balance(cp) &&
-		      cpumask_intersects(cp->cpus_allowed,
-					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
-			continue;
-
-		if (is_sched_load_balance(cp) &&
-		    !cpumask_empty(cp->effective_cpus))
-			csa[csn++] = cp;
-
-		/* skip @cp's subtree */
-		pos_css = css_rightmost_descendant(pos_css);
-		continue;
-
-v2:
 		/*
 		 * Only valid partition roots that are not isolated and with
-		 * non-empty effective_cpus will be saved into csn[].
+		 * non-empty effective_cpus will be saved into csa[].
 		 */
 		if ((cp->partition_root_state == PRS_ROOT) &&
 		    !cpumask_empty(cp->effective_cpus))
-			csa[csn++] = cp;
+			csa[ndoms++] = cp;
 
 		/*
 		 * Skip @cp's subtree if not a partition root and has no
@@ -882,40 +833,18 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 	rcu_read_unlock();
 
-	/*
-	 * If there are only isolated partitions underneath the cgroup root,
-	 * we can optimize out unneeded sched domains scanning.
-	 */
-	if (root_load_balance && (csn == 1))
-		goto single_root_domain;
-
-	for (i = 0; i < csn; i++)
-		uf_node_init(&csa[i]->node);
-
-	/* Merge overlapping cpusets */
-	for (i = 0; i < csn; i++) {
-		for (j = i + 1; j < csn; j++) {
-			if (cpusets_overlap(csa[i], csa[j])) {
+	for (i = 0; i < ndoms; i++) {
+		for (j = i + 1; j < ndoms; j++) {
+			if (cpusets_overlap(csa[i], csa[j]))
 				/*
 				 * Cgroup v2 shouldn't pass down overlapping
 				 * partition root cpusets.
 				 */
-				WARN_ON_ONCE(cgrpv2);
-				uf_union(&csa[i]->node, &csa[j]->node);
-			}
+				WARN_ON_ONCE(1);
 		}
 	}
 
-	/* Count the total number of domains */
-	for (i = 0; i < csn; i++) {
-		if (uf_find(&csa[i]->node) == &csa[i]->node)
-			ndoms++;
-	}
-
-	/*
-	 * Now we know how many domains to create.
-	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
-	 */
+generate_doms:
 	doms = alloc_sched_domains(ndoms);
 	if (!doms)
 		goto done;
@@ -932,45 +861,19 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
 	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
 	 */
-	if (cgrpv2) {
-		for (i = 0; i < ndoms; i++) {
-			/*
-			 * The top cpuset may contain some boot time isolated
-			 * CPUs that need to be excluded from the sched domain.
-			 */
-			if (csa[i] == &top_cpuset)
-				cpumask_and(doms[i], csa[i]->effective_cpus,
-					    housekeeping_cpumask(HK_TYPE_DOMAIN));
-			else
-				cpumask_copy(doms[i], csa[i]->effective_cpus);
-			if (dattr)
-				dattr[i] = SD_ATTR_INIT;
-		}
-		goto done;
-	}
-
-	for (nslot = 0, i = 0; i < csn; i++) {
-		nslot_update = 0;
-		for (j = i; j < csn; j++) {
-			if (uf_find(&csa[j]->node) == &csa[i]->node) {
-				struct cpumask *dp = doms[nslot];
-
-				if (i == j) {
-					nslot_update = 1;
-					cpumask_clear(dp);
-					if (dattr)
-						*(dattr + nslot) = SD_ATTR_INIT;
-				}
-				cpumask_or(dp, dp, csa[j]->effective_cpus);
-				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
-				if (dattr)
-					update_domain_attr_tree(dattr + nslot, csa[j]);
-			}
-		}
-		if (nslot_update)
-			nslot++;
+	for (i = 0; i < ndoms; i++) {
+		/*
+		 * The top cpuset may contain some boot time isolated
+		 * CPUs that need to be excluded from the sched domain.
+		 */
+		if (!csa || csa[i] == &top_cpuset)
+			cpumask_and(doms[i], top_cpuset.effective_cpus,
+				    housekeeping_cpumask(HK_TYPE_DOMAIN));
+		else
+			cpumask_copy(doms[i], csa[i]->effective_cpus);
+		if (dattr)
+			dattr[i] = SD_ATTR_INIT;
 	}
-	BUG_ON(nslot != ndoms);
 
 done:
 	kfree(csa);
-- 
2.34.1


