Return-Path: <cgroups+bounces-3494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE8923BDF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 12:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F921C215DB
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E38158DB3;
	Tue,  2 Jul 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gwGaxGLq"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0B51004;
	Tue,  2 Jul 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917640; cv=none; b=V09pI3tfIdyZ+gdjklpF0/+JyndXrw40vvQ6ufIaizUJAND0lKB+iEIm+rBt/Ir3EYzpUiCggRmWmEh5pwk4LqlGMIyUlucVWgCFfQq/t409ULif1cv03tatsU3KqnxerUWF5YkE+LEi+8Kt6GSZduPhodqaM4YWzuy6BxcBPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917640; c=relaxed/simple;
	bh=CpTcOvl0QkABqKFQB6/gYUAOE1TtybWUTE1vLk4wGmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGOF2sr8Phjbv7JkuviPECf7iYJ/QsNKWePRu1hrrobdkx09Fo58CUCiwzP/ilDmHR3PRC/VK6rTbCbn8JpeflhfjsJRQqiCqcHSBX4TiaEZ7FxjaITr81JBHB2us0I8B83e51XQslwmiBAV0Tgd08ipeogW5Tr1murK9RHJeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gwGaxGLq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PQ9RM
	3z3im+VjcU0v0S4k3STJQrv4lvRtxUnRKvb9y8=; b=gwGaxGLqTXIHZJ6NtaNn4
	d1I0KA5rRuSylBta9YIHGn+N86gdMZ8J5z0lcmMXirnOtWolqBvKUH78kAViu1sO
	YODAVuR6FRVKFJonz69iKnNj4sP0utoOESDPPwexyXJ/an6beq2iA/IoFLT1C4I9
	wZfES0vrEMG3VllHqTvLjY=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3P7Kp24NmfgFZAw--.52978S2;
	Tue, 02 Jul 2024 18:51:22 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org
Cc: longman@redhat.com,
	mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v9 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Tue,  2 Jul 2024 18:50:10 +0800
Message-Id: <20240702105010.253933-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702105010.253933-1-xavier_qy@163.com>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
 <20240702105010.253933-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P7Kp24NmfgFZAw--.52978S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfur4kKFyUZFWUJrW3Awb_yoWruryUpF
	4Sk3y2qrWrJryUGwsakay8Zw1Yk3ykJayUtw15Gw1rtrnrA3Z29a40qFs3KayUZrWq9F1U
	uF9Igr47Wr1UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbBMNUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiYwoQEGV4JGHcNAAAsZ

The process of constructing scheduling domains
 involves multiple loops and repeated evaluations, leading to numerous
 redundant and ineffective assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/cgroup/cpuset.c | 95 ++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 59 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fe76045aa5..4d32cd1407 100644
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
 
@@ -208,6 +206,9 @@ struct cpuset {
 
 	/* Remote partition silbling list anchored at remote_children */
 	struct list_head remote_sibling;
+
+	/* Used to merge intersecting subsets for generate_sched_domains*/
+	struct uf_node node;
 };
 
 /*
@@ -1007,7 +1008,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -1015,6 +1016,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1102,31 +1104,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	if (root_load_balance && (csn == 1))
 		goto single_root_domain;
 
-	for (i = 0; i < csn; i++)
-		csa[i]->pn = i;
-	ndoms = csn;
-
-restart:
-	/* Find the best partition (set of sched domains) */
-	for (i = 0; i < csn; i++) {
-		struct cpuset *a = csa[i];
-		int apn = a->pn;
+	if (!cgrpv2) {
+		for (i = 0; i < csn; i++)
+			uf_node_init(&csa[i]->node);
 
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
+		/* Merge overlapping cpusets */
+		for (i = 0; i < csn; i++) {
+			for (j = i + 1; j < csn; j++) {
+				if (cpusets_overlap(csa[i], csa[j]))
+					uf_union(&csa[i]->node, &csa[j]->node);
 			}
 		}
+
+		/* Count the total number of domains */
+		for (i = 0; i < csn; i++) {
+			if (csa[i]->node.parent == &csa[i]->node)
+				ndoms++;
+		}
+	} else {
+		ndoms = csn;
 	}
 
 	/*
@@ -1159,44 +1155,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
 
-- 
2.45.0


