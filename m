Return-Path: <cgroups+bounces-7341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9389A7B55A
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC89172FE2
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51AD517;
	Fri,  4 Apr 2025 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBiXHJvF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D9748D
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729065; cv=none; b=MmhcQB+VvZT1/d3bYKizJSuzlliSLwbUk46bMVhhQqEswa3dplyB2syihyQS72bSedah17U8F3Y/IBqvJ8zwTzQThFGfDowBYk4l4K7IKcVkc+09gEQeb5WAJOu88aP6vli4uhkVibALWUK9v/BnRL2YMEUeJzCwv068f8Di9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729065; c=relaxed/simple;
	bh=jqADKIhS5lxXZSKEuZcnSRW5k4YucZkrkhFMvzCl67I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApguIvfgoB1RFrJuTCNJabqicTLc312Tep0qdJKNjY+9996VD5g7BVZWWqSnDREotH2RYQB8MdsVrhZbP/oqPM823v5dg20VsPJKLjcEY9pTPDp7HGjbqv3t9v5eIAcluh1wGcOfwvvRm4p32LT6aDpWxQxQ7e6e7Ms1sms0vLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBiXHJvF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so11682375ad.0
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729063; x=1744333863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZsU5fSVi28PbSL6szY7mdlMdjJc5ZoxpLKyts0s7sA=;
        b=NBiXHJvFvUeGhrJ3zEFVLGlMc/8dRsmLbVsP0mQGr3u6eoIiDMaqRqHEwyasGNgg4l
         DYDdcEBUBiglY/mq45JT51NV7wNKZtuFLv/XyM4JUc9YA40eUKaTav/WkFGza4umYQVX
         muA4ZaGN7584rI13jthCf8IiDtP2Duk3nsoipSSvnEyFc/HXCRuV79f/k76Xgz5Wa45f
         JsdXZlEe1jJFXUbviS6HKIL4j7/xuXLjRRsvSDwb7qKrRtCJBcdoWaZl2tunU1uxXVeE
         DyAMrOSAN3kXk301HZ5vUhL1FP1jtkJTf5G6ABTvjs1CROm9UkUgUXAQEwKy4+8s0dxs
         Nmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729063; x=1744333863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZsU5fSVi28PbSL6szY7mdlMdjJc5ZoxpLKyts0s7sA=;
        b=A5v5sCHMiXgD21+jOS881PAhdeVaKY+NfUxWVft1wAGjb0ckpvA4dduhcgeS4hJoRN
         qwhVfkrcTOAOYi6Z/YvkR37J1J5TctG3yWo0KfxLGbrwwFdKKmW1GygwmRwvkJJbRQkR
         nLrvkJO5BANBHNCruZLxUirx40PdbjfWb4VSpSXFWhDL1mTDyA4NRX11oHSEKXVfX9ub
         7jqTrs7zM8J1HkQ4V5zQFQljslg1MQwWcaFp73aOV+Kj4BImGhpMh5L/QkD0Hc/0v3F8
         21oCYIfw0htbVXrg7AskKUGZ5bwfnRsFvqWrZiAGX0UaJ1rwWmJ0Ar1cDMo2ZWWVazJC
         vo4w==
X-Forwarded-Encrypted: i=1; AJvYcCXx8oUdYMKuNjZm3TpYBbjXfo2HDwu+vX8hpWDI+0YcnHjaiEz0eQfCJJlUve+b33jBzRwHv87o@vger.kernel.org
X-Gm-Message-State: AOJu0YzfL3onjHpr3nX4+9Rz4Y+wZM0/HHxcvpHgSySbGp4XiNVmjLDL
	C0BYZ0WOpwjtpJG+urGolN8UCWI6PgyGH1Ihyv7IGaUj/4mJdvP/
X-Gm-Gg: ASbGncsnzfUjqE3zEyomwVok1Hf4VKQXeFCBChee2/OXvvsRxp7tFI7iQBIFNeszkGw
	vm50HoY0ubvQaQvPrzrLR2eNftuesEI4BlbYsVfMgEl6cC9bWbD8jZXRPKy0Zn4qHNEBGpmoFED
	ZYtmISVfq8olkE6eOTLL7w96uS6P4Sc8/aRCdNiign2q5U2zpDOC4LB5vERBQkox+ha32E+4gm8
	MbLJIl4OyV5sppinFzECXjzKZ9cvIq3P17ZLKXDb7Smvgl5PP8GXV5lnNnzEfSiVOS5xw+7g2cP
	03yhRLoNCP+9IC1xSc2YWEYQSiXMiprb1HOcpbobEKGeWHrBNlDYlPJF1ug9fdgIxHzd4BWt
X-Google-Smtp-Source: AGHT+IF8Od4xvEKN3/RaUfeo4N1bACCSjzvUpvp6Hxw/d1Soi6qjdw8eOYD9IyiMEadxhY9T/76/Gg==
X-Received: by 2002:a17:902:be15:b0:221:751f:cfbe with SMTP id d9443c01a7336-22a89b8e034mr16115945ad.19.1743729063215;
        Thu, 03 Apr 2025 18:11:03 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:02 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 1/5] cgroup: move rstat base stat objects into their own struct
Date: Thu,  3 Apr 2025 18:10:46 -0700
Message-ID: <20250404011050.121777-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404011050.121777-1-inwardvessel@gmail.com>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This non-functional change serves as preparation for moving to
subsystem-based rstat trees. The base stats are not an actual subsystem,
but in future commits they will have exclusive rstat trees just as other
subsystems will.

Moving the base stat objects into a new struct allows the cgroup_rstat_cpu
struct to become more compact since it now only contains the minimum amount
of pointers needed for rstat participation. Subsystems will (in future
commits) make use of the compact cgroup_rstat_cpu struct while avoiding the
memory overhead of the base stat objects which they will not use.

An instance of the new struct cgroup_rstat_base_cpu was placed on the
cgroup struct so it can retain ownership of these base stats common to all
cgroups. A helper function was added for looking up the cpu-specific base
stats of a given cgroup. Finally, initialization and variable names were
adjusted where applicable.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h | 38 ++++++++++-------
 kernel/cgroup/cgroup.c      |  8 +++-
 kernel/cgroup/rstat.c       | 84 ++++++++++++++++++++++---------------
 3 files changed, 79 insertions(+), 51 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 485b651869d9..6d177f770d28 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -344,10 +344,29 @@ struct cgroup_base_stat {
  * frequency decreases the cost of each read.
  *
  * This struct hosts both the fields which implement the above -
- * updated_children and updated_next - and the fields which track basic
- * resource statistics on top of it - bsync, bstat and last_bstat.
+ * updated_children and updated_next.
  */
 struct cgroup_rstat_cpu {
+	/*
+	 * Child cgroups with stat updates on this cpu since the last read
+	 * are linked on the parent's ->updated_children through
+	 * ->updated_next.
+	 *
+	 * In addition to being more compact, singly-linked list pointing
+	 * to the cgroup makes it unnecessary for each per-cpu struct to
+	 * point back to the associated cgroup.
+	 *
+	 * Protected by per-cpu cgroup_rstat_cpu_lock.
+	 */
+	struct cgroup *updated_children;	/* terminated by self cgroup */
+	struct cgroup *updated_next;		/* NULL iff not on the list */
+};
+
+/*
+ * This struct hosts the fields which track basic resource statistics on
+ * top of it - bsync, bstat and last_bstat.
+ */
+struct cgroup_rstat_base_cpu {
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
 	 * updated in the hot path.
@@ -374,20 +393,6 @@ struct cgroup_rstat_cpu {
 	 * deltas to propagate to the per-cpu subtree_bstat.
 	 */
 	struct cgroup_base_stat last_subtree_bstat;
-
-	/*
-	 * Child cgroups with stat updates on this cpu since the last read
-	 * are linked on the parent's ->updated_children through
-	 * ->updated_next.
-	 *
-	 * In addition to being more compact, singly-linked list pointing
-	 * to the cgroup makes it unnecessary for each per-cpu struct to
-	 * point back to the associated cgroup.
-	 *
-	 * Protected by per-cpu cgroup_rstat_cpu_lock.
-	 */
-	struct cgroup *updated_children;	/* terminated by self cgroup */
-	struct cgroup *updated_next;		/* NULL iff not on the list */
 };
 
 struct cgroup_freezer_state {
@@ -518,6 +523,7 @@ struct cgroup {
 
 	/* per-cpu recursive resource statistics */
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
 	struct list_head rstat_css_list;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ac2db99941ca..77349d07b117 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -161,10 +161,14 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 };
 #undef SUBSYS
 
-static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
+static DEFINE_PER_CPU(struct cgroup_rstat_cpu, root_rstat_cpu);
+static DEFINE_PER_CPU(struct cgroup_rstat_base_cpu, root_rstat_base_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.rstat_cpu = &root_rstat_cpu,
+	.cgrp.rstat_base_cpu = &root_rstat_base_cpu,
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4bb587d5d34f..a20e3ab3f7d3 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -19,6 +19,12 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
 	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
 }
 
+static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
+		struct cgroup *cgrp, int cpu)
+{
+	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
+}
+
 /*
  * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
  *
@@ -351,12 +357,22 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 			return -ENOMEM;
 	}
 
+	if (!cgrp->rstat_base_cpu) {
+		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
+		if (!cgrp->rstat_cpu) {
+			free_percpu(cgrp->rstat_cpu);
+			return -ENOMEM;
+		}
+	}
+
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_base_cpu *rstatbc =
+			cgroup_rstat_base_cpu(cgrp, cpu);
 
 		rstatc->updated_children = cgrp;
-		u64_stats_init(&rstatc->bsync);
+		u64_stats_init(&rstatbc->bsync);
 	}
 
 	return 0;
@@ -379,6 +395,8 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 
 	free_percpu(cgrp->rstat_cpu);
 	cgrp->rstat_cpu = NULL;
+	free_percpu(cgrp->rstat_base_cpu);
+	cgrp->rstat_base_cpu = NULL;
 }
 
 void __init cgroup_rstat_boot(void)
@@ -419,9 +437,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup_rstat_base_cpu *rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_rstat_cpu *prstatc;
+	struct cgroup_rstat_base_cpu *prstatbc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -431,15 +449,15 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 
 	/* fetch the current per-cpu values */
 	do {
-		seq = __u64_stats_fetch_begin(&rstatc->bsync);
-		delta = rstatc->bstat;
-	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
+		seq = __u64_stats_fetch_begin(&rstatbc->bsync);
+		delta = rstatbc->bstat;
+	} while (__u64_stats_fetch_retry(&rstatbc->bsync, seq));
 
 	/* propagate per-cpu delta to cgroup and per-cpu global statistics */
-	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
+	cgroup_base_stat_sub(&delta, &rstatbc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
-	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
-	cgroup_base_stat_add(&rstatc->subtree_bstat, &delta);
+	cgroup_base_stat_add(&rstatbc->last_bstat, &delta);
+	cgroup_base_stat_add(&rstatbc->subtree_bstat, &delta);
 
 	/* propagate cgroup and per-cpu global delta to parent (unless that's root) */
 	if (cgroup_parent(parent)) {
@@ -448,73 +466,73 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
-		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(parent, cpu);
-		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
-		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
-		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
+		delta = rstatbc->subtree_bstat;
+		prstatbc = cgroup_rstat_base_cpu(parent, cpu);
+		cgroup_base_stat_sub(&delta, &rstatbc->last_subtree_bstat);
+		cgroup_base_stat_add(&prstatbc->subtree_bstat, &delta);
+		cgroup_base_stat_add(&rstatbc->last_subtree_bstat, &delta);
 	}
 }
 
-static struct cgroup_rstat_cpu *
+static struct cgroup_rstat_base_cpu *
 cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatbc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
-	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
-	return rstatc;
+	rstatbc = get_cpu_ptr(cgrp->rstat_base_cpu);
+	*flags = u64_stats_update_begin_irqsave(&rstatbc->bsync);
+	return rstatbc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct cgroup_rstat_cpu *rstatc,
+						 struct cgroup_rstat_base_cpu *rstatbc,
 						 unsigned long flags)
 {
-	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
+	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
 	cgroup_rstat_updated(cgrp, smp_processor_id());
-	put_cpu_ptr(rstatc);
+	put_cpu_ptr(rstatbc);
 }
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatbc;
 	unsigned long flags;
 
-	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
-	rstatc->bstat.cputime.sum_exec_runtime += delta_exec;
-	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
+	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
+	rstatbc->bstat.cputime.sum_exec_runtime += delta_exec;
+	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
 }
 
 void __cgroup_account_cputime_field(struct cgroup *cgrp,
 				    enum cpu_usage_stat index, u64 delta_exec)
 {
-	struct cgroup_rstat_cpu *rstatc;
+	struct cgroup_rstat_base_cpu *rstatbc;
 	unsigned long flags;
 
-	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
+	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
 
 	switch (index) {
 	case CPUTIME_NICE:
-		rstatc->bstat.ntime += delta_exec;
+		rstatbc->bstat.ntime += delta_exec;
 		fallthrough;
 	case CPUTIME_USER:
-		rstatc->bstat.cputime.utime += delta_exec;
+		rstatbc->bstat.cputime.utime += delta_exec;
 		break;
 	case CPUTIME_SYSTEM:
 	case CPUTIME_IRQ:
 	case CPUTIME_SOFTIRQ:
-		rstatc->bstat.cputime.stime += delta_exec;
+		rstatbc->bstat.cputime.stime += delta_exec;
 		break;
 #ifdef CONFIG_SCHED_CORE
 	case CPUTIME_FORCEIDLE:
-		rstatc->bstat.forceidle_sum += delta_exec;
+		rstatbc->bstat.forceidle_sum += delta_exec;
 		break;
 #endif
 	default:
 		break;
 	}
 
-	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
+	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
 }
 
 /*
-- 
2.47.1


