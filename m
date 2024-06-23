Return-Path: <cgroups+bounces-3287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF42913765
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 04:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9231C20F31
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECDDD268;
	Sun, 23 Jun 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nl73rTbO"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1840944E;
	Sun, 23 Jun 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719110382; cv=none; b=NiONKDSRlcUN9+RZvODEUGdncCqmbKUjHFOjDBXK1XcGGqheYsyRKkJVfSZQ/criaI+Oviwq6hzBcuXS4Y6dDuLgect+dmbVivTRHTq4CzDF29j7NvSiuLWOCHq6yEbowG4pkvFyBfleArCwuw7d0mjRF4b/6DTQgE2D6Ewio2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719110382; c=relaxed/simple;
	bh=gfgt6MOsoUMc2Co3kgD9D44YTV8Y1Wq/uaGxeaKsrUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6eQXBf0NGElkxSFM2gtZVESBK7gMbHhtbrbd6O4BYMfDjqlJ6q5Zq6UnuNQXdqfyv+XXtmqhCtAOB/+Fks89qFvFe5vhv8rl3iGgyg74OItR+VS3ZCaSIVrDrJbrEhFGkHGW2ew3A6KF3JSv1aMzyH7zoqERVYZI/cWR3cVzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nl73rTbO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qctbx
	oSUfBGOtVIcg4lCiASKBVYtbzC69YaXnAwrNqw=; b=Nl73rTbOAWeroGi+xe0Xj
	P4+kkA+kgEw3TahTET4Mm+8BYfantTqpz8UNrHy70ReQN+ecLV6kLc3Xqkc3IwZT
	qRaCLET8GKs7NNyIClF5Dbg9wrhxbGU2YpTeHN8AEp22ohvuwVSVJeJ0cYEyfLzj
	vmZ+Q1RCYYSH7TZVWjYCpc=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3P4LJindmYR5+AA--.40472S2;
	Sun, 23 Jun 2024 10:39:05 +0800 (CST)
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
Subject: [PATCH-cpuset v7 2/2] cpuset: use Union-Find to optimize the merging of cpumasks
Date: Sun, 23 Jun 2024 10:39:01 +0800
Message-Id: <20240623023901.218892-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623023901.218892-1-xavier_qy@163.com>
References: <Znb4JBpJoGZ3LS1W@slm.duckdns.org>
 <20240623023901.218892-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P4LJindmYR5+AA--.40472S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWfur4kKFyUZFWUJrW3Awb_yoWrZF48pF
	s3Cay2grWrJryUGwsYkay8Z34SkaykJa1Utw13Gw1rArnrA3Z2va40qFs5KFWUurWqkF1U
	uF9xKr43Wr1UKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-J5wUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZQwHEGXAmkcMqQAAsj

The process of constructing scheduling domains
 involves multiple loops and repeated evaluations, leading to numerous
 redundant and ineffective assessments that impact code efficiency.

Here, we use Union-Find to optimize the merging of cpumasks. By employing
path compression and union by rank, we effectively reduce the number of
lookups and merge comparisons.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/cgroup/cpuset.c | 99 +++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fe76045aa5..d459cfddcb 100644
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
 
@@ -1007,7 +1006,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
-	int i, j, k;		/* indices for partition finding loops */
+	int i, j;		/* indices for partition finding loops */
 	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
 	struct sched_domain_attr *dattr;  /* attributes for custom domains */
 	int ndoms = 0;		/* number of sched domains in result */
@@ -1015,6 +1014,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	struct uf_node *nodes = NULL;
+	int nslot_update;
 
 	doms = NULL;
 	dattr = NULL;
@@ -1102,31 +1103,29 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
+	if (!cgrpv2) {
+		nodes = vzalloc(sizeof(struct uf_node) * csn);
+		if (!nodes)
+			goto done;
 
-			if (apn != bpn && cpusets_overlap(a, b)) {
-				for (k = 0; k < csn; k++) {
-					struct cpuset *c = csa[k];
+		for (i = 0; i < csn; i++)
+			uf_nodes_init(&nodes[i]);
 
-					if (c->pn == bpn)
-						c->pn = apn;
-				}
-				ndoms--;	/* one less element */
-				goto restart;
+		/* Merge overlapping cpusets */
+		for (i = 0; i < csn; i++) {
+			for (j = i + 1; j < csn; j++) {
+				if (cpusets_overlap(csa[i], csa[j]))
+					uf_union(&nodes[i], &nodes[j]);
 			}
 		}
+
+		/* Count the total number of domains */
+		for (i = 0; i < csn; i++) {
+			if (nodes[i].parent == &nodes[i])
+				ndoms++;
+		}
+	} else {
+		ndoms = csn;
 	}
 
 	/*
@@ -1159,48 +1158,32 @@ static int generate_sched_domains(cpumask_var_t **domains,
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
 
 done:
+	if (nodes)
+		vfree(nodes);
+
 	kfree(csa);
 
 	/*
-- 
2.45.2


