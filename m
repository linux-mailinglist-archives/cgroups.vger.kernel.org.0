Return-Path: <cgroups+bounces-6575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1745EA3912B
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E862B1650F4
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8063176242;
	Tue, 18 Feb 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7liAgi0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877617A5BE
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848504; cv=none; b=kk5y3nQjDd6peB6Qc0EjTKppa9BzaPe7/OhYQtCWBuaSIGq0YjMPCaR3G0/YIASZ5JGYy3fkLcgOeCfYG5v8eavRTqYDWlMlOImLrGnTWQhh5dyjSK/0IovbX4fA2EzBONTYv4GGH04czFlu4Ps8CnGv+UoGiD/7iF9nqnTg6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848504; c=relaxed/simple;
	bh=BhaYwFRBCVj6QE+XYgz6Il336p9+3M4oMB0a2YIkt5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTr7ycDvvbfu8FxTcu5soMCrh9dvEPA5naLEj3AlBTckRqnbbqIFHG9pFAHEh9NRHa9ER3DayiKpKHdUR4P1HZ7Fp1CG4Ub3zgxz/KgSuq/8ZNP2vLO55YJC8omgyy1Pf+UUtg/9/pIxmPB01Vu9e3mLmyHeZlPZ039ceZyA2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7liAgi0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ec47991aso48983675ad.1
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848502; x=1740453302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKC2oA1YaKWB10hzGh7Kd/lm3Yr8DEdtBJf40vcnIWI=;
        b=V7liAgi0XtZzcm146qSjPyEsAH1pHuUh19eecqN9zjRzph/lW/cQSF6E1/HjM9y6fw
         nvW8T9QVAAGCIXp/KkWTzVryy6durSR9G9hImu/A4znMac7K8c83A9aL2hlIRa11izeu
         cxk67kAuS/d1cZCTWMwkFPn/632jcb0OxxHHzeEg61/v2fHJoQm8LR/lwUaRpk0mWseR
         0LhKrkxlE0K+yYp7Xs2evfc8nOFsBVL4RaFx2KKqOfQ+zjwnjL53/OvVa0zmAQFrA8AP
         ybEoEvo7HDeFjFXdLTbp/fk0cQO4AEPfglZoyXl8Fjzb5taBfMw+RhUSzQxIB7VpKhTN
         UIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848502; x=1740453302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKC2oA1YaKWB10hzGh7Kd/lm3Yr8DEdtBJf40vcnIWI=;
        b=cAEWd4VxrkTbiMVGbFh8iuDun7Bl9f8UoRngy9ASvY20BBgwU9Zba7dChavVro1NGE
         ZmPdi0INstXPFg+f0pAPtvAj44wnb7NCgs2zyPUqzj1EEOPqo+998jH2B2i3nZdvZcVk
         70fvIc43l/Tth8eKjVnmhw04aGwAnDxOh8mmoBc4JPKR3mr+Dgi+y7vhcpJY0LygCCw8
         BosfdhHpe5d56K19zzL/XgyNq4C6smgKjhsvgC+pwU+zo1T6rL9c8vW3/4S2QZaBVzwk
         RGoxnf0+lWj7Li1VV35wHQPSS3+bzapl2zIVcMQFFG7LzZH8gwm6mg8J4nP11Qi3Tc7+
         KEMw==
X-Forwarded-Encrypted: i=1; AJvYcCU7vzQyBs/Wv5CYi3AhV2x0nMJbfYlf8k2Imd+0SFoMPK9OqIqk5CM8z+upLtqCgqMq+F0wKXHf@vger.kernel.org
X-Gm-Message-State: AOJu0YwdY90W6MKDKX/2JRVn0Wi4TFOtnhCCAoakjFHrYFqwJRtdB8Tv
	QC6vhGR9/fDx8m7XdgHiR+XTfXi8RCmirvmg/HCkhH3FI4J36+3m
X-Gm-Gg: ASbGncveftPpe5CsoSwCNmYys4Y55hR8TplWhV4JtT4XZqW44ZRWlFQumI8V4OPR6qH
	NAMPpLtPnr4sIBncjfOPVCiYP0qARgPkpLrfW+udRs0EKWQebfEHrS9drF6VmponqeTnGven2MX
	oX2aOB/PsWd+geXK3e8/8y5LPpOMVpZFfQJ7AfuP0GuswW4dHgLTX1W9CSZeRw0ihg6IKL1sCMP
	//j5Lyg/QBYgSBiA0h7IOotewz/gJ0f1hphVcdTlOBRaMOhCJ2vj/EzL2gAKtQ4KGOCnm9TU01j
	OF1VBuZ1Qj6cYyPXfiVN9TZSrH8Fbg0zcN30BJLiiU/1DTLbKuwD
X-Google-Smtp-Source: AGHT+IF+DcmK8IyN/NoZE/SgRoHiYX03btr3kUIPJKJtKWJG3YwfRKa/liO8vC71Fr0zQV87n/GPlg==
X-Received: by 2002:a05:6a21:6b05:b0:1ee:5f3f:cde0 with SMTP id adf61e73a8af0-1ee8cbf7bcamr24262982637.34.1739848502002;
        Mon, 17 Feb 2025 19:15:02 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:01 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 01/11] cgroup: move rstat pointers into struct of their own
Date: Mon, 17 Feb 2025 19:14:38 -0800
Message-ID: <20250218031448.46951-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rstat infrastructure makes use of pointers for list management.
These pointers only exist as fields in the cgroup struct, so moving them
into their own struct will allow them to be used elsewhere. The base
stat entities are included with them for now.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h                   | 90 +-----------------
 include/linux/cgroup_rstat.h                  | 92 +++++++++++++++++++
 kernel/cgroup/cgroup.c                        |  3 +-
 kernel/cgroup/rstat.c                         | 27 +++---
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  4 +-
 5 files changed, 112 insertions(+), 104 deletions(-)
 create mode 100644 include/linux/cgroup_rstat.h

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1b20d2d8ef7c..6b6cc027fe70 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -17,7 +17,7 @@
 #include <linux/refcount.h>
 #include <linux/percpu-refcount.h>
 #include <linux/percpu-rwsem.h>
-#include <linux/u64_stats_sync.h>
+#include <linux/cgroup_rstat.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
 #include <linux/psi_types.h>
@@ -321,78 +321,6 @@ struct css_set {
 	struct rcu_head rcu_head;
 };
 
-struct cgroup_base_stat {
-	struct task_cputime cputime;
-
-#ifdef CONFIG_SCHED_CORE
-	u64 forceidle_sum;
-#endif
-	u64 ntime;
-};
-
-/*
- * rstat - cgroup scalable recursive statistics.  Accounting is done
- * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
- * hierarchy on reads.
- *
- * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
- * linked into the updated tree.  On the following read, propagation only
- * considers and consumes the updated tree.  This makes reading O(the
- * number of descendants which have been active since last read) instead of
- * O(the total number of descendants).
- *
- * This is important because there can be a lot of (draining) cgroups which
- * aren't active and stat may be read frequently.  The combination can
- * become very expensive.  By propagating selectively, increasing reading
- * frequency decreases the cost of each read.
- *
- * This struct hosts both the fields which implement the above -
- * updated_children and updated_next - and the fields which track basic
- * resource statistics on top of it - bsync, bstat and last_bstat.
- */
-struct cgroup_rstat_cpu {
-	/*
-	 * ->bsync protects ->bstat.  These are the only fields which get
-	 * updated in the hot path.
-	 */
-	struct u64_stats_sync bsync;
-	struct cgroup_base_stat bstat;
-
-	/*
-	 * Snapshots at the last reading.  These are used to calculate the
-	 * deltas to propagate to the global counters.
-	 */
-	struct cgroup_base_stat last_bstat;
-
-	/*
-	 * This field is used to record the cumulative per-cpu time of
-	 * the cgroup and its descendants. Currently it can be read via
-	 * eBPF/drgn etc, and we are still trying to determine how to
-	 * expose it in the cgroupfs interface.
-	 */
-	struct cgroup_base_stat subtree_bstat;
-
-	/*
-	 * Snapshots at the last reading. These are used to calculate the
-	 * deltas to propagate to the per-cpu subtree_bstat.
-	 */
-	struct cgroup_base_stat last_subtree_bstat;
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
-};
-
 struct cgroup_freezer_state {
 	/* Should the cgroup and its descendants be frozen. */
 	bool freeze;
@@ -517,23 +445,9 @@ struct cgroup {
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
 	/* per-cpu recursive resource statistics */
-	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+	struct cgroup_rstat rstat;
 	struct list_head rstat_css_list;
 
-	/*
-	 * Add padding to separate the read mostly rstat_cpu and
-	 * rstat_css_list into a different cacheline from the following
-	 * rstat_flush_next and *bstat fields which can have frequent updates.
-	 */
-	CACHELINE_PADDING(_pad_);
-
-	/*
-	 * A singly-linked list of cgroup structures to be rstat flushed.
-	 * This is a scratch field to be used exclusively by
-	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
-	 */
-	struct cgroup	*rstat_flush_next;
-
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
new file mode 100644
index 000000000000..f95474d6f8ab
--- /dev/null
+++ b/include/linux/cgroup_rstat.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RSTAT_H
+#define _LINUX_RSTAT_H
+
+#include <linux/u64_stats_sync.h>
+
+struct cgroup_rstat_cpu;
+
+/*
+ * rstat - cgroup scalable recursive statistics.  Accounting is done
+ * per-cpu in cgroup_rstat_cpu which is then lazily propagated up the
+ * hierarchy on reads.
+ *
+ * When a stat gets updated, the cgroup_rstat_cpu and its ancestors are
+ * linked into the updated tree.  On the following read, propagation only
+ * considers and consumes the updated tree.  This makes reading O(the
+ * number of descendants which have been active since last read) instead of
+ * O(the total number of descendants).
+ *
+ * This is important because there can be a lot of (draining) cgroups which
+ * aren't active and stat may be read frequently.  The combination can
+ * become very expensive.  By propagating selectively, increasing reading
+ * frequency decreases the cost of each read.
+ *
+ * This struct hosts both the fields which implement the above -
+ * updated_children and updated_next - and the fields which track basic
+ * resource statistics on top of it - bsync, bstat and last_bstat.
+ */
+struct cgroup_rstat {
+	struct cgroup_rstat_cpu __percpu *rstat_cpu;
+
+	/*
+	 * Add padding to separate the read mostly rstat_cpu and
+	 * rstat_css_list into a different cacheline from the following
+	 * rstat_flush_next and containing struct fields which can have
+	 * frequent updates.
+	 */
+	CACHELINE_PADDING(_pad_);
+	struct cgroup *rstat_flush_next;
+};
+
+struct cgroup_base_stat {
+	struct task_cputime cputime;
+
+#ifdef CONFIG_SCHED_CORE
+	u64 forceidle_sum;
+#endif
+	u64 ntime;
+};
+
+struct cgroup_rstat_cpu {
+	/*
+	 * Child cgroups with stat updates on this cpu since the last read
+	 * are linked on the parent's ->updated_children through
+	 * ->updated_next.
+	 *
+	 * In addition to being more compact, singly-linked list pointing
+	 * to the cgroup makes it unnecessary for each per-cpu struct to
+	 * point back to the associated cgroup.
+	 */
+	struct cgroup *updated_children;	/* terminated by self */
+	struct cgroup *updated_next;		/* NULL if not on the list */
+
+	/*
+	 * ->bsync protects ->bstat.  These are the only fields which get
+	 * updated in the hot path.
+	 */
+	struct u64_stats_sync bsync;
+	struct cgroup_base_stat bstat;
+
+	/*
+	 * Snapshots at the last reading.  These are used to calculate the
+	 * deltas to propagate to the global counters.
+	 */
+	struct cgroup_base_stat last_bstat;
+
+	/*
+	 * This field is used to record the cumulative per-cpu time of
+	 * the cgroup and its descendants. Currently it can be read via
+	 * eBPF/drgn etc, and we are still trying to determine how to
+	 * expose it in the cgroupfs interface.
+	 */
+	struct cgroup_base_stat subtree_bstat;
+
+	/*
+	 * Snapshots at the last reading. These are used to calculate the
+	 * deltas to propagate to the per-cpu subtree_bstat.
+	 */
+	struct cgroup_base_stat last_subtree_bstat;
+};
+
+#endif	/* _LINUX_RSTAT_H */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436..03a3a4da49f1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -31,6 +31,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/bpf-cgroup.h>
+#include <linux/cgroup_rstat.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/init_task.h>
@@ -164,7 +165,7 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = { .cgrp.rstat.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 5877974ece92..7e7879d88c38 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -16,7 +16,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
 static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
 {
-	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	return per_cpu_ptr(cgrp->rstat.rstat_cpu, cpu);
 }
 
 /*
@@ -149,24 +149,24 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
 	struct cgroup *parent, *grandchild;
 	struct cgroup_rstat_cpu *crstatc;
 
-	child->rstat_flush_next = NULL;
+	child->rstat.rstat_flush_next = NULL;
 
 next_level:
 	while (chead) {
 		child = chead;
-		chead = child->rstat_flush_next;
+		chead = child->rstat.rstat_flush_next;
 		parent = cgroup_parent(child);
 
 		/* updated_next is parent cgroup terminated */
 		while (child != parent) {
-			child->rstat_flush_next = head;
+			child->rstat.rstat_flush_next = head;
 			head = child;
 			crstatc = cgroup_rstat_cpu(child, cpu);
 			grandchild = crstatc->updated_children;
 			if (grandchild != child) {
 				/* Push the grand child to the next level */
 				crstatc->updated_children = child;
-				grandchild->rstat_flush_next = ghead;
+				grandchild->rstat.rstat_flush_next = ghead;
 				ghead = grandchild;
 			}
 			child = crstatc->updated_next;
@@ -238,7 +238,7 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 
 	/* Push @root to the list first before pushing the children */
 	head = root;
-	root->rstat_flush_next = NULL;
+	root->rstat.rstat_flush_next = NULL;
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
@@ -310,7 +310,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	for_each_possible_cpu(cpu) {
 		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
-		for (; pos; pos = pos->rstat_flush_next) {
+		for (; pos; pos = pos->rstat.rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
@@ -387,9 +387,10 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 	int cpu;
 
 	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
-		if (!cgrp->rstat_cpu)
+	if (!cgrp->rstat.rstat_cpu) {
+		cgrp->rstat.rstat_cpu = alloc_percpu(
+				struct cgroup_rstat_cpu);
+		if (!cgrp->rstat.rstat_cpu)
 			return -ENOMEM;
 	}
 
@@ -419,8 +420,8 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 			return;
 	}
 
-	free_percpu(cgrp->rstat_cpu);
-	cgrp->rstat_cpu = NULL;
+	free_percpu(cgrp->rstat.rstat_cpu);
+	cgrp->rstat.rstat_cpu = NULL;
 }
 
 void __init cgroup_rstat_boot(void)
@@ -503,7 +504,7 @@ cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags
 {
 	struct cgroup_rstat_cpu *rstatc;
 
-	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
+	rstatc = get_cpu_ptr(cgrp->rstat.rstat_cpu);
 	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
 	return rstatc;
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 38f78d9345de..035412265c3c 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
 {
-	g = (__u64)cgrp->rstat_cpu->updated_children;
+	g = (__u64)cgrp->rstat.rstat_cpu->updated_children;
 	return 0;
 }
 
@@ -56,7 +56,7 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 	__u32 cpu;
 
 	cpu = bpf_get_smp_processor_id();
-	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat_cpu, cpu);
+	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat.rstat_cpu, cpu);
 	if (rstat) {
 		/* READ_ONCE */
 		*(volatile int *)rstat;
-- 
2.48.1


