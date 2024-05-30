Return-Path: <cgroups+bounces-3039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF98D4C26
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 14:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1159286E58
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557AA17CA12;
	Thu, 30 May 2024 12:59:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3117C9FF
	for <cgroups@vger.kernel.org>; Thu, 30 May 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073957; cv=none; b=uCLQY222uT9mHNvPQwqevbczBSKyc8XEJMyhc8Q5zdUpxKgVH39dRT1y4a04FyvhwpUuUNnAqy5x97CnhuyqJG2bRyO8ghS0MyJ/Qby58JaFSXlIXftU92PQq4jB6L7uwbZnRDSI8OlmWQJ21JP59xOxPl+zxI4jxhHak66ieyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073957; c=relaxed/simple;
	bh=3f1UmhBrWJKcDw/pvbylXxqwLuv320BxM8dQHSal5JE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWCIk/MEvbwE+jI5vTeMFslA5/aSFljBb1mVvee0AKGS3MaUxcrEn5C+t7UhenV6K529I9RNN7NPZY1UyACFqNocb4Qbet+bO0+4KRwUMjsGMnv6Vd8oAkKUQOFE8/WfyrJGrCPcUkpN7rESZxCwsEHjlaQciZyyH27fXe42QdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost
Received: from unknown (HELO localhost)([101.132.132.191])
	by sina.com (10.182.253.25) with ESMTP
	id 6658778800006DCF; Thu, 30 May 2024 20:56:41 +0800 (CST)
X-Sender: ghostxavier@sina.com
X-Auth-ID: ghostxavier@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=ghostxavier@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=ghostxavier@sina.com
X-SMAIL-MID: 88201412059084
X-SMAIL-UIID: 024E43C30F014DEABD1ED150981E0866-20240530-205641-1
From: Xavier <ghostxavier@sina.com>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>
Subject: [PATCH] cpuset: Optimize the number of iterations in the scheduling domain construction process
Date: Thu, 30 May 2024 20:56:38 +0800
Message-Id: <20240530125638.231032-1-ghostxavier@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The process of constructing scheduling domains involves multiple loops and repeated evaluations, leading to numerous redundant and ineffective assessments that impact code efficiency. Here, we use Union-Find to optimize the merging of cpumasks. By employing path compression and union by rank, we effectively reduce the number of lookups and merge comparisons.

Signed-off-by: Xavier <ghostxavier@sina.com>
---
 kernel/cgroup/cpuset.c | 116 +++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 51 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c12b9fdb2..51595b68d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -891,6 +891,42 @@ static inline int nr_cpusets(void)
 	return static_key_count(&cpusets_enabled_key.key) + 1;
 }
 
+/*define a union find node struct*/
+struct uf_node {
+	int parent;
+	int rank;
+};
+
+static int find_root(struct uf_node *nodes, int x) {
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
+static void union_sets(struct uf_node *nodes, int a, int b) {
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
@@ -950,13 +986,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
 
 	doms = NULL;
 	dattr = NULL;
@@ -1022,33 +1059,32 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
+	/* Merge overlapping cpusets */
+	for (i = 0; i < csn; i++) {
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j])) {
+				union_sets(nodes, i, j);
 			}
 		}
 	}
 
+	/* Update each cpuset pn to its root */
+	for (i = 0; i < csn; i++) {
+		if (nodes[i].parent == i)
+			ndoms++;
+	}
+
 	/*
 	 * Now we know how many domains to create.
 	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
@@ -1065,47 +1101,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
+		struct cpumask *dp = doms[nslot];
 
 		cpumask_clear(dp);
 		if (dattr)
 			*(dattr + nslot) = SD_ATTR_INIT;
 		for (j = i; j < csn; j++) {
-			struct cpuset *b = csa[j];
-
-			if (apn == b->pn) {
-				cpumask_or(dp, dp, b->effective_cpus);
+			if (find_root(nodes, j) == i) {
+				if (i == j) {
+					nslot++;
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
 	}
 	BUG_ON(nslot != ndoms);
-
+	kfree(nodes);
 done:
 	kfree(csa);
 
-- 
2.34.1


