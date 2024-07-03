Return-Path: <cgroups+bounces-3513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E1C9253C5
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C721F251AE
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 06:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E12131BDD;
	Wed,  3 Jul 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R1JqLhhD"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A51130A4D;
	Wed,  3 Jul 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988741; cv=none; b=AJHV0w+NSizbetnY7WYXEaOxfoGWRBvWznqN6dvOYISniyiokkSnsM+N+M1MLhcR+TGYIlf8Z47K6HFagxCo2+QltlQnIx+XyXRtMya/mTprsTaCUuO7+sSyY1WsVL3rrCowRis2R7LlHgZUm21wKdAKZwSDYyY7xrx11FoIphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988741; c=relaxed/simple;
	bh=myh1aa48Bh/L4wqolNywr+n9SD0QbTDH8XQwjQrza/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFhrKh9DdTuc76kZjw5IZGeE9nKjyPDoUI8oDlysav4MilTf54FMrAxUwc9dmHfpgqGN6mbsIUG6AXlnzP5S4pdTG1pSVrxvd88xl+MbMl2ZNionTuzj6raFa5RXZQtsYn1nrd/ha09wRTRHLcgsdEBv9AsYYJ1XXKUfgm4qka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R1JqLhhD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Zv2dl
	wf+anNkBWjblWem+6ZBOSSccXad6uVe9RvcLP0=; b=R1JqLhhDPWsNn1RCJNmQJ
	/GlGOX6XZ/amB1gC19oMZY0Yuo+rK2nP6yk5pidVYTc+QZLzQwJ2pzieLJrmrumk
	UnJDYODKYjrhHtqFAvNHKPhcrjhlWQ67b1dUcya4yW6UsoX8C5Gcts21Wmw0JW1V
	eQ3HPLZ1274NCeG4D7zWoU=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wDnlxGt8YRme0eRAQ--.62674S2;
	Wed, 03 Jul 2024 14:37:33 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tj@kernel.org,
	longman@redhat.com,
	akpm@linux-foundation.org
Cc: mkoutny@suse.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-cpuset v10 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Wed,  3 Jul 2024 14:37:27 +0800
Message-Id: <20240703063727.258722-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703063727.258722-1-xavier_qy@163.com>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnlxGt8YRme0eRAQ--.62674S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw15WFWrKF4DWF1xArW8JFb_yoW7uw45pF
	4fK3y2vrWrtry7Gws2kayxZw1ak397JayUtw13Gw1FyrnrA3Z29Fy0gFsIkFWUZrWqkFyU
	uF9Igr47WF1qkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbBMNUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRIREGXAmyudTwAAsx

The process of constructing scheduling domains
 involves multiple loops and repeated evaluations, leading to numerous
 redundant and ineffective assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/cgroup/cpuset.c | 114 ++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 70 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fe76045aa5..88c2171361 100644
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
+	/* Used to merge intersecting subsets for generate_sched_domains */
+	struct uf_node node;
 };
 
 /*
@@ -988,18 +989,15 @@ static inline int nr_cpusets(void)
  *	   were changed (added or removed.)
  *
  * Finding the best partition (set of domains):
- *	The triple nested loops below over i, j, k scan over the
- *	load balanced cpusets (using the array of cpuset pointers in
- *	csa[]) looking for pairs of cpusets that have overlapping
- *	cpus_allowed, but which don't have the same 'pn' partition
- *	number and gives them in the same partition number.  It keeps
- *	looping on the 'restart' label until it can no longer find
- *	any such pairs.
+ *	The double nested loops below over i, j scan over the load
+ *	balanced cpusets (using the array of cpuset pointers in csa[])
+ *	looking for pairs of cpusets that have overlapping cpus_allowed
+ *	and merging them using a union-find algorithm.
+ *
+ *	The union of the cpus_allowed masks from the set of all cpusets
+ *	having the same root then form the one element of the partition
+ *	(one sched domain) to be passed to partition_sched_domains().
  *
- *	The union of the cpus_allowed masks from the set of
- *	all cpusets having the same 'pn' value then form the one
- *	element of the partition (one sched domain) to be passed to
- *	partition_sched_domains().
  */
 static int generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes)
@@ -1007,7 +1005,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -1015,6 +1013,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1102,31 +1101,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
-
-		for (j = 0; j < csn; j++) {
-			struct cpuset *b = csa[j];
-			int bpn = b->pn;
-
-			if (apn != bpn && cpusets_overlap(a, b)) {
-				for (k = 0; k < csn; k++) {
-					struct cpuset *c = csa[k];
+	if (!cgrpv2) {
+		for (i = 0; i < csn; i++)
+			uf_node_init(&csa[i]->node);
 
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
@@ -1159,44 +1152,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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


