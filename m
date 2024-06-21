Return-Path: <cgroups+bounces-3264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77822911F4E
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E9A1C212B4
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27816D9BC;
	Fri, 21 Jun 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DkkytO23"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5F18E20;
	Fri, 21 Jun 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959873; cv=none; b=HArHt2PB4q8r1Ypx40PWC4CGgUFcG93G4DwM9ePlkcUjFQmcE7tjDBrhIhb39zPjzNb+Sm8vPJKUSwvneQJbUiiuSOZtshl47VzdtPx6t1vQU74n3o1ErjxflRpmeH1NAw3s7iX7BY3sZsQvcOb7BJDspChGJr0KWMtUrlFlfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959873; c=relaxed/simple;
	bh=Zte5JUNqWfYMzsUShAtYW3hHHTnmNIinQoLo7kExpMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYMnEnMOEbID4pS05uy7AWJ0suS8KdrYaHqkStCPPF21RuNoSYpt2sfRsE+rvMrIa9bq4B4H0sk5czAyWJh/5yDQ8Rtd0IQ2Q4d2Un2cI15al7eOdQzaUBLi/v1k2tB40WelaacNBQKz8lPkNQU2A5MCz4jG4CrFsG4XNsuitsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DkkytO23; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=f4H86
	bcCOfTgkY5Xt2BTUJ/8giKcEdQStQuqAfO5dp8=; b=DkkytO2327zAY8bmj4lwC
	5ke/3qdWtvgw95FRwg+BqoKephRG3S3XlrlEWTD//NpIEyjJ+TZkjLXyKVFA+gxY
	mc0kRwmiMrJLOyTlXt1rH4nGMS7N5Gzji4T2x1lvaSwYA3AECpELHxODk19k1wNU
	daR7iYn87mHeEO8wS+G78E=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDn_4O2PnVmSbjWEg--.56944S2;
	Fri, 21 Jun 2024 16:49:59 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v5 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Fri, 21 Jun 2024 16:49:52 +0800
Message-Id: <20240621084952.209770-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621084952.209770-1-xavier_qy@163.com>
References: <b511173c-53fe-4a93-8030-d99ed1b65bd6@redhat.com>
 <20240621084952.209770-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_4O2PnVmSbjWEg--.56944S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfur4kKFyUZFWUJrW3Awb_yoWrurW5pF
	s3Cay2qrWrJryUGwsYk3y8Z34SkaykJa1Utw13Gw1fArnrA3Z29a40qFs5KayUuFyDCr1U
	uF9xKr47Wr1UKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U47K3UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZR0FEGXAmib2rAAEsq

The process of constructing scheduling domains
 involves multiple loops and repeated evaluations, leading to numerous
 redundant and ineffective assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/cgroup/cpuset.c | 95 +++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 61 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fe76045aa5..7e527530f8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -45,6 +45,7 @@
 #include <linux/cgroup.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/union_find.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -172,9 +173,6 @@ struct cpuset {
 	 */
 	int attach_in_progress;
 
-	/* partition number for rebuild_sched_domains() */
-	int pn;
-
 	/* for custom sched domain */
 	int relax_domain_level;
 
@@ -1007,7 +1005,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -1015,6 +1013,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	struct uf_node *nodes;
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1102,40 +1102,31 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	if (root_load_balance && (csn == 1))
 		goto single_root_domain;
 
-	for (i = 0; i < csn; i++)
-		csa[i]->pn = i;
-	ndoms = csn;
+	nodes = uf_nodes_alloc(csn);
+	if (!nodes)
+		goto done;
 
-restart:
-	/* Find the best partition (set of sched domains) */
+	/* Merge overlapping cpusets */
 	for (i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		int apn = a->pn;
-
-		for (j = 0; j < csn; j++) {
-			struct cpuset *b = csa[j];
-			int bpn = b->pn;
-
-			if (apn != bpn && cpusets_overlap(a, b)) {
-				for (k = 0; k < csn; k++) {
-					struct cpuset *c = csa[k];
-
-					if (c->pn == bpn)
-						c->pn = apn;
-				}
-				ndoms--;	/* one less element */
-				goto restart;
-			}
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j]))
+				uf_union(&nodes[i], &nodes[j]);
 		}
 	}
 
+	/* Count the total number of domains */
+	for (i = 0; i < csn; i++) {
+		if ((nodes[i].parent == &nodes[i]) || !nodes[i].parent)
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
@@ -1159,47 +1150,29 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 
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
+			if (uf_find(&nodes[j]) == &nodes[i]) {
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
+	uf_nodes_free(nodes);
 done:
 	kfree(csa);
 
-- 
2.45.2


