Return-Path: <cgroups+bounces-3451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD7791C383
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7066E1C22AAB
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21851C8FD0;
	Fri, 28 Jun 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pSQNcblq"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD42158DDC;
	Fri, 28 Jun 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591251; cv=none; b=bYOfqV8GFJc/WuoTqd1FcO/IZ6XR6vXG4xi2hWpE/7NjGye5Tl7+uPS1Lqt2OnMqnJ2Uojvf3F7MPwHt+sKVFkZHewh1gG/pbQg474nJH/oGBhH4D5Y8FHdCdJSedq7nmmQZLAQB8O+XS5jyhWLh9BR91X6v/ozTnckMKvjvUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591251; c=relaxed/simple;
	bh=/ZLjV4AtG6PE9RE64qHOYEVdhdNaKhQgUm25uI4izAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4snwVZLlMRNwz4vPt0Jy5hlYOu6vm4sjZ1UVXGZYQZr1SxjW/jOgvNCNUqXeajAG+WF52Bbvi3dqb5Pwvrwmo96VwdC47igZs3tV9zlp1q4f3PDZBltnA2+kOX3DwRZT79tknx1Yn9HlcjLchwLfaAMMfFYrY242dNJ0odHuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pSQNcblq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e26+2
	q+3hBU2DBzF5851MuqgEXt4Q/cdEKTEV/s7sag=; b=pSQNcblqjulPYUuVA1ewP
	bWx080z7JFM3P2O9bxeinUlDmYzbrJrm5dLbggXVXuQeQ1wDWcw9ycoWKjAg1S/h
	ChMqJ2UsMDooZJce0bHBm8jKxN9oFrlmXbOnsEoYelo5eVrJQgbaxHJcHdBKREbj
	0J42/kHedGtk1ZAFIlCfR8=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wDX_yoR4X5m0+qRAw--.37690S2;
	Sat, 29 Jun 2024 00:13:05 +0800 (CST)
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
Subject: [PATCH-cpuset v8 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Sat, 29 Jun 2024 00:13:02 +0800
Message-Id: <20240628161302.240043-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628161302.240043-1-xavier_qy@163.com>
References: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
 <20240628161302.240043-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_yoR4X5m0+qRAw--.37690S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfur4kKFyUZFWUJrW3Awb_yoWruF1fpF
	sakay2qrWrJryUGwsakay8Zw1ak3ykJayUtwnxGw1rtr17A3Z29a40qFs3KFWUZrWq9F1U
	uF9Igr47Wr18KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ubo7tUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/xtbBchAMEGWXv5R4dgABso

The process of constructing scheduling domains
 involves multiple loops and repeated evaluations, leading to numerous
 redundant and ineffective assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/cgroup/cpuset.c | 96 ++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fe76045aa5..c435814ba8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -45,6 +45,8 @@
 #include <linux/cgroup.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/union_find.h>
+#include <linux/vmalloc.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -172,9 +174,6 @@ struct cpuset {
 	 */
 	int attach_in_progress;
 
-	/* partition number for rebuild_sched_domains() */
-	int pn;
-
 	/* for custom sched domain */
 	int relax_domain_level;
 
@@ -208,6 +207,9 @@ struct cpuset {
 
 	/* Remote partition silbling list anchored at remote_children */
 	struct list_head remote_sibling;
+
+	/* Used to merge intersecting subsets for generate_sched_domains*/
+	struct uf_node node;
 };
 
 /*
@@ -1007,7 +1009,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -1015,6 +1017,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1102,31 +1105,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
+			uf_nodes_init(&csa[i]->node);
 
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
@@ -1159,44 +1156,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
2.45.2


