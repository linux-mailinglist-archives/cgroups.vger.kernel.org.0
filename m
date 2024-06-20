Return-Path: <cgroups+bounces-3245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6590FFAA
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C530C1C2040C
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1319B3E1;
	Thu, 20 Jun 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BZf2uBSZ"
X-Original-To: cgroups@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282C2D05D;
	Thu, 20 Jun 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873711; cv=none; b=hHb3gnO8ky92uN3dIJLGYaytf0G/6wyC0EzIef88UoyUtbsYQ0c3uazFABvcQGP83k4yidlm7b1uDyV72WXXCfSsfplOa7Iv8suCcFkdwWs0wjk86BPz2sqVENRRj8e0KQTLn3qBZ7Wbby0m3LvknjKGwQTwAKnlLDYgNZcHYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873711; c=relaxed/simple;
	bh=Zte5JUNqWfYMzsUShAtYW3hHHTnmNIinQoLo7kExpMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtG8cK/C837sqeZR9DdBToo5bUxPY0cjCoEksrJQHobg3k0/KSElqTibHDw6deFgkFBsCpwSqVhOu85WJIySs4KeHfdrf/6933qPlYTQKfWFV/Kb56xUpVktEOxr+46FpNuNJuWD0JlS2kffBXODINI/Vq/KHRUQ7nqh/MSCiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BZf2uBSZ; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=f4H86
	bcCOfTgkY5Xt2BTUJ/8giKcEdQStQuqAfO5dp8=; b=BZf2uBSZXrBHtEgFYvLkO
	nVgboCNiFOQHEnRh0IDaI9uvdRMjLNQRHr8wVn0h5+NMF24f7KjCdhpH9rrf/AnX
	1tqNoUnjJhEphMmmFo5UUhejiLXjck4cBmhG65OLhIU0cXTLnqFs4nRoKi7uaUUE
	c0+AOWFqk9kJPXT6Hy66Rg=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDn5JjV7XNmrecAJA--.9351S2;
	Thu, 20 Jun 2024 16:52:38 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: longman@redhat.com,
	mkoutny@suse.com
Cc: lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v4 v4 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Thu, 20 Jun 2024 16:52:33 +0800
Message-Id: <20240620085233.205690-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620085233.205690-1-xavier_qy@163.com>
References: <20240603123101.590760-1-ghostxavier@sina.com>
 <20240620085233.205690-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn5JjV7XNmrecAJA--.9351S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfur4kKFyUZFWUJrW3Awb_yoWrurW5pF
	s3Cay2qrWrJryUGwsYk3y8Z34SkaykJa1Utw13Gw1fArnrA3Z29a40qFs5KayUuFyDCr1U
	uF9xKr47Wr1UKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UadgZUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRYEEGXAmg963wABsz

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


