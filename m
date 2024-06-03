Return-Path: <cgroups+bounces-3067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2F8D8254
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458501C23A71
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5312C48F;
	Mon,  3 Jun 2024 12:33:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59055126F2A
	for <cgroups@vger.kernel.org>; Mon,  3 Jun 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418017; cv=none; b=g9kOTEfzTAfkLwaY+H/TC5JctoNqnscm807ayMfNBZncQJUoYGEIKja+urmyt/vNMd3wPZKl99HbGkkRjkiRwaP45C8zagVf//hf0N9JBNFgp5LvdgyFgGQI7vzsKLZrXKUL45vgJRxnQwpW9upzei7VaaioXeho2YatbNgNsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418017; c=relaxed/simple;
	bh=F0Jf8OiTTvwdi30OQ3QHk+13cYz4+woNcq0c6+ItnoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Exz3FNGqYEIliwhlg9tsjq9u+02odb/29RH+p1H0AkzwI6UOpfw88m45qi+ThFTwYOXGXXCWqTTNfWiUU1PDV7o+gzx0KrTcCcBc6LXOz1ogH3y0jq4ZYogB8hNatfmPxoovjZqsQ2hJVIc3IPluQghpuXtRLFfqGVy6oWk8lBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost
Received: from unknown (HELO localhost)([101.132.132.191])
	by sina.com (10.182.253.24) with ESMTP
	id 665DB788000035BE; Mon, 3 Jun 2024 20:31:05 +0800 (CST)
X-Sender: ghostxavier@sina.com
X-Auth-ID: ghostxavier@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=ghostxavier@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=ghostxavier@sina.com
X-SMAIL-MID: 4516241049099
X-SMAIL-UIID: 12FB1F5EF9944B87A4329F8B41F467E7-20240603-203105-1
From: Xavier <ghostxavier@sina.com>
To: longman@redhat.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>
Subject: [PATCH v3] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Mon,  3 Jun 2024 20:31:01 +0800
Message-Id: <20240603123101.590760-1-ghostxavier@sina.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531024837.255293-1-ghostxavier@sina.com>
References: <20240531024837.255293-1-ghostxavier@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The process of constructing scheduling domains involves multiple loops
and repeated evaluations, leading to numerous redundant and ineffective
assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <ghostxavier@sina.com>

Hi Longman,

Thank you for your feedback on the previous version of the patch.

Now I will respond to the three questions you raised:
1) The function comment describes the algorithm to find the set of
domains. If you change the algorithm, you have to update the comment as
well.

Reply: Sorry for not paying attention to the comments before. The new patch (v3) has updated the comment content. 

2) generate_sched_domains() is not in a performance critical path, so
its performance is not as important. Also the csn array is typically not
that big. Changing the algorithm may introduce new bugs which leads to
the next point.

Reply: Indeed, this function is not a critical path impacting performance, but it's always good to optimize efficiency. The optimization is limited to the internals of this function and does not affect other modules, so fixing the internal bug should have manageable risks.

3) How do you test your code to ensure its correctness?
I applied your patch and run the ./test_cpuset_prs.sh got the following...

Reply: I'm very sorry, this is my first time submitting a kernel patch and I don't know which test cases need to be run. I just constructed some scenarios locally to test, so the testing scope is limited. Thank you for providing the test cases. I have reproduced and resolved the issue, and have passed several other test cases in CGroup. But currently, I only have QEMU simulation environment, so my testing ability is limited. I hope you can help me with some comprehensive testing of my new version patch. Thank you very much.

I hope you can pay further attention to the new patch.

Best regards,
Xavier

---
 kernel/cgroup/cpuset.c | 148 +++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 66 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb2..c2d030a30 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -891,6 +891,44 @@ static inline int nr_cpusets(void)
 	return static_key_count(&cpusets_enabled_key.key) + 1;
 }
 
+/*define a union find node struct*/
+struct uf_node {
+	int parent;
+	int rank;
+};
+
+static int find_root(struct uf_node *nodes, int x)
+{
+	int root = x;
+	int parent;
+
+	/*Find the root node and perform path compression at the same time*/
+	while (nodes[root].parent != root) {
+		parent = nodes[root].parent;
+		nodes[root].parent = nodes[parent].parent;
+		root = parent;
+	}
+	return root;
+}
+
+/*Function to merge two sets, using union by rank*/
+static void union_sets(struct uf_node *nodes, int a, int b)
+{
+	int root_a = find_root(nodes, a);
+	int root_b = find_root(nodes, b);
+
+	if (root_a != root_b) {
+		if (nodes[root_a].rank < nodes[root_b].rank) {
+			nodes[root_a].parent = root_b;
+		} else if (nodes[root_a].rank > nodes[root_b].rank) {
+			nodes[root_b].parent = root_a;
+		} else {
+			nodes[root_b].parent = root_a;
+			nodes[root_a].rank++;
+		}
+	}
+}
+
 /*
  * generate_sched_domains()
  *
@@ -930,17 +968,13 @@ static inline int nr_cpusets(void)
  *	   value to determine what partition elements (sched domains)
  *	   were changed (added or removed.)
  *
- * Finding the best partition (set of domains):
- *	The triple nested loops below over i, j, k scan over the
- *	load balanced cpusets (using the array of cpuset pointers in
- *	csa[]) looking for pairs of cpusets that have overlapping
- *	cpus_allowed, but which don't have the same 'pn' partition
- *	number and gives them in the same partition number.  It keeps
- *	looping on the 'restart' label until it can no longer find
- *	any such pairs.
+ *  By creating a union-find data structure for all load-balanced cpusets,
+ *  cpusets with overlapping cpus_allowed are found and marked with the
+ *  same parent node. Path compression is performed during the search to
+ *  improve comparison efficiency.
  *
  *	The union of the cpus_allowed masks from the set of
- *	all cpusets having the same 'pn' value then form the one
+ *	all cpusets having the same parent then form the one
  *	element of the partition (one sched domain) to be passed to
  *	partition_sched_domains().
  */
@@ -950,13 +984,15 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
+	struct uf_node *nodes;
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1022,40 +1058,38 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 	rcu_read_unlock();
 
-	for (i = 0; i < csn; i++)
-		csa[i]->pn = i;
-	ndoms = csn;
-
-restart:
-	/* Find the best partition (set of sched domains) */
-	for (i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		int apn = a->pn;
+	nodes = kmalloc_array(csn, sizeof(struct uf_node), GFP_KERNEL);
+	if (!nodes)
+		goto done;
 
-		for (j = 0; j < csn; j++) {
-			struct cpuset *b = csa[j];
-			int bpn = b->pn;
 
-			if (apn != bpn && cpusets_overlap(a, b)) {
-				for (k = 0; k < csn; k++) {
-					struct cpuset *c = csa[k];
+	/* Each node is initially its own parent */
+	for (i = 0; i < csn; i++) {
+		nodes[i].parent = i;
+		nodes[i].rank = 0;
+	}
 
-					if (c->pn == bpn)
-						c->pn = apn;
-				}
-				ndoms--;	/* one less element */
-				goto restart;
-			}
+	/* Merge overlapping cpusets */
+	for (i = 0; i < csn; i++) {
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j]))
+				union_sets(nodes, i, j);
 		}
 	}
 
+	/* Calculate the number of domains after merging */
+	for (i = 0; i < csn; i++) {
+		if (nodes[i].parent == i)
+			ndoms++;
+	}
+
 	/*
 	 * Now we know how many domains to create.
 	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
 	 */
 	doms = alloc_sched_domains(ndoms);
 	if (!doms)
-		goto done;
+		goto free;
 
 	/*
 	 * The rest of the code, including the scheduler, can deal with
@@ -1065,47 +1099,29 @@ static int generate_sched_domains(cpumask_var_t **domains,
 			      GFP_KERNEL);
 
 	for (nslot = 0, i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		struct cpumask *dp;
-		int apn = a->pn;
-
-		if (apn < 0) {
-			/* Skip completed partitions */
-			continue;
-		}
-
-		dp = doms[nslot];
-
-		if (nslot == ndoms) {
-			static int warnings = 10;
-			if (warnings) {
-				pr_warn("rebuild_sched_domains confused: nslot %d, ndoms %d, csn %d, i %d, apn %d\n",
-					nslot, ndoms, csn, i, apn);
-				warnings--;
-			}
-			continue;
-		}
-
-		cpumask_clear(dp);
-		if (dattr)
-			*(dattr + nslot) = SD_ATTR_INIT;
+		nslot_update = 0;
 		for (j = i; j < csn; j++) {
-			struct cpuset *b = csa[j];
-
-			if (apn == b->pn) {
-				cpumask_or(dp, dp, b->effective_cpus);
+			if (find_root(nodes, j) == i) {
+				struct cpumask *dp = doms[nslot];
+
+				if (i == j) {
+					nslot_update = 1;
+					cpumask_clear(dp);
+					if (dattr)
+						*(dattr + nslot) = SD_ATTR_INIT;
+				}
+				cpumask_or(dp, dp, csa[j]->effective_cpus);
 				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
 				if (dattr)
-					update_domain_attr_tree(dattr + nslot, b);
-
-				/* Done with this partition */
-				b->pn = -1;
+					update_domain_attr_tree(dattr + nslot, csa[j]);
 			}
 		}
-		nslot++;
+		if (nslot_update)
+			nslot++;
 	}
 	BUG_ON(nslot != ndoms);
-
+free:
+	kfree(nodes);
 done:
 	kfree(csa);
 
-- 
2.34.1


