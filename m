Return-Path: <cgroups+bounces-7345-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A7A7B55E
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662803B8711
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53128DDD2;
	Fri,  4 Apr 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI85BFgg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB8944E
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729072; cv=none; b=FBX6h0me677e+R73ZaP520fO9JVm1iKb+TfEhGwNv2zYq2gaPscxYP+sMcfnKDp+MhArRquPwFitUiOkJoCSUjLQmqFSHvTi3f7bEX4peBuB+/KUXtk5u6LIxUgJt2LYXP8cy0KpM6YajGeJc4tQo3ZpIPwCkqBkA5AbqXJryEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729072; c=relaxed/simple;
	bh=PddZCX3SNjkNTJq2GepoAMnXXVriWKOk6lWLjAhueiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZMGYSM1YR8tsEShtisb64oeehtiTZQZ1yjovEUeLt2w32xgphhpkf38XUsy6wuxYMeJ7PJdQxKr9W+bzjjhrlP9hQtQjs2J8yGyNqc/PM5VK/hGQLnGCXuNI/6Mh64tG93qREz56uq/RyzPIKOPrxyCY/1y6XeyOJ3i3fiFENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI85BFgg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-226185948ffso16533335ad.0
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729070; x=1744333870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV5TV+bfAJxOC42aCHTzoJOjH1U8s9sOgmji4TeUkOw=;
        b=WI85BFgghzZA8GQsexd7yWa1s2GAE4SAO+HcRevD6TWqs6mfvIUgUZf0Bnuoso+Jwc
         G912SUOD+P68WHAzy61WruCYEkznGlrWwmaqRldOIKlIdr8fwb9ZLHXZosWw8f2hpBzy
         uhRH2OH0NlDuA8ZgPzSoMX8ZfGC2mYzn4u9Rd+z5kubgN+XtFaIiqY0zeOIOtuGjKISN
         3ayFNanqTXLbaJS7toJlt5paEsfPbTQpHGVm1deeq5R7px+dS9Xj4P7ATUgBhxwPl+wE
         seWpmiD3Am0tmSd2HG6Yrc3NGyK+ZRD9ncGa6sReFPo2xUy8Z1i70c5caUyULjWhsQq/
         0J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729070; x=1744333870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV5TV+bfAJxOC42aCHTzoJOjH1U8s9sOgmji4TeUkOw=;
        b=eqdzRjGJwBpGQZge45H3oWtNXiyPfxLopcN2wO4130CUVWJck+EpHtBXt2w021NnRE
         vSK1oYq7570q0igdEBqkI2slp3vjdp9KUWJYYb/P3QK3TjcDGVHoxzqlEWSs15b7o5eq
         tY7W1qcSegcGiG7iu9Xt92784bMpJZrT07aaTQ2fO/a6uMPRxf+pHtWlRs076pkakdS3
         HcRt2W7VIfj9JfOCM34EaiXlbynUK5DOjXLlL+VacEFnkxXxDlhrs1vnbTmmS6+xer/U
         QtCJ9qLuRFjNYuYDRsSZKeHamUgpsOjUyCEqqxMHUttccMVHoWKDwXdEuDu22ugCQaVu
         yfkw==
X-Forwarded-Encrypted: i=1; AJvYcCVM+uiCXMlz2cAIRRLUd/UGJpn8isEYvEuEut0oElcXRqlFo8M9y4syLOL2hehuBmmo/PBpYdVj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2LmBU49ElGf5Q6rvpeYAkqQSlmckVZn4cmVPwMlZ8G7Itgz1w
	z3uJKfJbbprKzmN29i9UBgCy6aH8w1g9WkEfNQBz7lMKV2M6olV4
X-Gm-Gg: ASbGncsf7hLiF1C8wCrXA5o+JDDq8VYZuzJG+jqsHcQ4YxlGHtqckSLzPDvw+Db+Hek
	n12v57KKGZj44NulXnPTH+4CO2TpRJY7EcD4GzIpJrUDSEOidHt17Mk6if9FEKnjobTkR1pUCgY
	PUBQtkznH6Y4E/oISPnojtnlLTv9/2Ee3CXjvzNm4zWjM8RfHGXmu/RibW6nxEu8FfXtgGL7ShR
	I8n4ijDIqSomDyGVeg63tJYNUED+XmJO8JoRoETOG7SQGc+O3zEerX92O7tFVHa+SPfo8HbpihG
	KSlVsG/xLBxhTcPfzYLekTYjUeg0adrsMslw/wk5o6kIZfpuCFcsh1TxbLVASfE88tY6IBA+
X-Google-Smtp-Source: AGHT+IFK/qgUBJjlDIvw3gZbcvK2irjy/zsY+pafGRpj9ZH7+vHNEUYzNMRDO7cu+8rCT9ccPE+fsg==
X-Received: by 2002:a17:903:2a88:b0:224:216e:332f with SMTP id d9443c01a7336-22a8a0a5c77mr16147105ad.48.1743729069423;
        Thu, 03 Apr 2025 18:11:09 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:08 -0700 (PDT)
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
Subject: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to avoid contention
Date: Thu,  3 Apr 2025 18:10:50 -0700
Message-ID: <20250404011050.121777-6-inwardvessel@gmail.com>
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

It is possible to eliminate contention between subsystems when
updating/flushing stats by using subsystem-specific locks. Let the existing
rstat locks be dedicated to the cgroup base stats and rename them to
reflect that. Add similar locks to the cgroup_subsys struct for use with
individual subsystems.

Lock initialization is done in the new function ss_rstat_init(ss) which
replaces cgroup_rstat_boot(void). If NULL is passed to this function, the
global base stat locks will be initialized. Otherwise, the subsystem locks
will be initialized.

Change the existing lock helper functions to accept a reference to a css.
Then within these functions, conditionally select the appropriate locks
based on the subsystem affiliation of the given css. Add helper functions
for this selection routine to avoid repeated code.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c              |   2 +-
 include/linux/cgroup-defs.h     |  16 +++--
 include/trace/events/cgroup.h   |  12 +++-
 kernel/cgroup/cgroup-internal.h |   2 +-
 kernel/cgroup/cgroup.c          |  10 +++-
 kernel/cgroup/rstat.c           | 101 +++++++++++++++++++++++---------
 6 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0560ea402856..62d0bf1e1a04 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1074,7 +1074,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	/*
 	 * For covering concurrent parent blkg update from blkg_release().
 	 *
-	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
+	 * When flushing from cgroup, the subsystem lock is always held, so
 	 * this lock won't cause contention most of time.
 	 */
 	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c58c21c2110a..bb5a355524d6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -223,7 +223,10 @@ struct cgroup_subsys_state {
 	/*
 	 * A singly-linked list of css structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 * css_rstat_flush_locked().
+	 *
+	 * Protected by rstat_base_lock when css is cgroup::self.
+	 * Protected by css->ss->rstat_ss_lock otherwise.
 	 */
 	struct cgroup_subsys_state *rstat_flush_next;
 };
@@ -359,11 +362,11 @@ struct css_rstat_cpu {
 	 * are linked on the parent's ->updated_children through
 	 * ->updated_next.
 	 *
-	 * In addition to being more compact, singly-linked list pointing
-	 * to the cgroup makes it unnecessary for each per-cpu struct to
-	 * point back to the associated cgroup.
+	 * In addition to being more compact, singly-linked list pointing to
+	 * the css makes it unnecessary for each per-cpu struct to point back
+	 * to the associated css.
 	 *
-	 * Protected by per-cpu cgroup_rstat_cpu_lock.
+	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
 	 */
 	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
 	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
@@ -793,6 +796,9 @@ struct cgroup_subsys {
 	 * specifies the mask of subsystems that this one depends on.
 	 */
 	unsigned int depends_on;
+
+	spinlock_t rstat_ss_lock;
+	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index af2755bda6eb..7d332387be6c 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -231,7 +231,11 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 		  __entry->cpu, __entry->contended)
 );
 
-/* Related to global: cgroup_rstat_lock */
+/*
+ * Related to locks:
+ * global rstat_base_lock for base stats
+ * cgroup_subsys::rstat_ss_lock for subsystem stats
+ */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
 
 	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
@@ -253,7 +257,11 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
 	TP_ARGS(cgrp, cpu, contended)
 );
 
-/* Related to per CPU: cgroup_rstat_cpu_lock */
+/*
+ * Related to per CPU locks:
+ * global rstat_base_cpu_lock for base stats
+ * cgroup_subsys::rstat_ss_cpu_lock for subsystem stats
+ */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended,
 
 	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c161d34be634..b14e61c64a34 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -272,7 +272,7 @@ int cgroup_task_count(const struct cgroup *cgrp);
  */
 int css_rstat_init(struct cgroup_subsys_state *css);
 void css_rstat_exit(struct cgroup_subsys_state *css);
-void cgroup_rstat_boot(void);
+int ss_rstat_init(struct cgroup_subsys *ss);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c351b98ebd06..2e0348d78679 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6106,8 +6106,10 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
-		if (ss->css_rstat_flush)
+		if (ss->css_rstat_flush) {
+			BUG_ON(ss_rstat_init(ss));
 			BUG_ON(css_rstat_init(css));
+		}
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6184,7 +6186,7 @@ int __init cgroup_init(void)
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-	cgroup_rstat_boot();
+	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
@@ -6215,8 +6217,10 @@ int __init cgroup_init(void)
 						   GFP_KERNEL);
 			BUG_ON(css->id < 0);
 
-			if (ss->css_rstat_flush)
+			if (ss->css_rstat_flush) {
+				BUG_ON(ss_rstat_init(ss));
 				BUG_ON(css_rstat_init(css));
+			}
 		} else {
 			cgroup_init_subsys(ss, false);
 		}
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 37d9e5012b2d..bcc253aec774 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,8 +9,8 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static DEFINE_SPINLOCK(rstat_base_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -26,8 +26,24 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
 	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
 }
 
+static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
+{
+	if (ss)
+		return &ss->rstat_ss_lock;
+
+	return &rstat_base_lock;
+}
+
+static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
+{
+	if (ss)
+		return per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu);
+
+	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
+}
+
 /*
- * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
+ * Helper functions for rstat per CPU locks.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments. The parameter @fast_path determine the
@@ -35,21 +51,23 @@ static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
  * operations without handling high-frequency fast-path "update" events.
  */
 static __always_inline
-unsigned long _css_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
-				     struct cgroup_subsys_state *css, const bool fast_path)
+unsigned long _css_rstat_cpu_lock(struct cgroup_subsys_state *css, int cpu,
+		const bool fast_path)
 {
 	struct cgroup *cgrp = css->cgroup;
+	raw_spinlock_t *cpu_lock;
 	unsigned long flags;
 	bool contended;
 
 	/*
-	 * The _irqsave() is needed because cgroup_rstat_lock is
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-	 * this lock with the _irq() suffix only disables interrupts on
-	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-	 * interrupts on both configurations. The _irqsave() ensures
-	 * that interrupts are always disabled and later restored.
+	 * The _irqsave() is needed because the locks used for flushing are
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
+	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
+	 * kernel. The raw_spinlock_t below disables interrupts on both
+	 * configurations. The _irqsave() ensures that interrupts are always
+	 * disabled and later restored.
 	 */
+	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
 	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
 	if (contended) {
 		if (fast_path)
@@ -69,17 +87,18 @@ unsigned long _css_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 static __always_inline
-void _css_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
-			      struct cgroup_subsys_state *css, unsigned long flags,
-			      const bool fast_path)
+void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
+		unsigned long flags, const bool fast_path)
 {
 	struct cgroup *cgrp = css->cgroup;
+	raw_spinlock_t *cpu_lock;
 
 	if (fast_path)
 		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
 	else
 		trace_cgroup_rstat_cpu_unlock(cgrp, cpu, false);
 
+	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
 
@@ -94,7 +113,6 @@ void _css_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
 	/*
@@ -108,7 +126,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
-	flags = _css_rstat_cpu_lock(cpu_lock, cpu, css, true);
+	flags = _css_rstat_cpu_lock(css, cpu, true);
 
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -136,7 +154,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		css = parent;
 	}
 
-	_css_rstat_cpu_unlock(cpu_lock, cpu, css, flags, true);
+	_css_rstat_cpu_unlock(css, cpu, flags, true);
 }
 
 /**
@@ -214,12 +232,11 @@ static struct cgroup_subsys_state *css_rstat_push_children(
 static struct cgroup_subsys_state *css_rstat_updated_list(
 		struct cgroup_subsys_state *root, int cpu)
 {
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _css_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _css_rstat_cpu_lock(root, cpu, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -256,7 +273,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 	if (child != root)
 		head = css_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_css_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_css_rstat_cpu_unlock(root, cpu, flags, false);
 	return head;
 }
 
@@ -283,7 +300,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -293,27 +310,31 @@ __bpf_hook_end();
  */
 static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
 		int cpu_in_loop)
-	__acquires(&cgroup_rstat_lock)
+	__acquires(lock)
 {
 	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
 	bool contended;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
+	lock = ss_rstat_lock(css->ss);
+	contended = !spin_trylock_irq(lock);
 	if (contended) {
 		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(&cgroup_rstat_lock);
+		spin_lock_irq(lock);
 	}
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
 static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
 		int cpu_in_loop)
-	__releases(&cgroup_rstat_lock)
+	__releases(lock)
 {
 	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
 
+	lock = ss_rstat_lock(css->ss);
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock_irq(lock);
 }
 
 /**
@@ -422,12 +443,36 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 	css->rstat_cpu = NULL;
 }
 
-void __init cgroup_rstat_boot(void)
+/**
+ * ss_rstat_init - subsystem-specific rstat initialization
+ * @ss: target subsystem
+ *
+ * If @ss is NULL, the static locks associated with the base stats
+ * are initialized. If @ss is non-NULL, the subsystem-specific locks
+ * are initialized.
+ */
+int __init ss_rstat_init(struct cgroup_subsys *ss)
 {
 	int cpu;
 
+	if (!ss) {
+		spin_lock_init(&rstat_base_lock);
+
+		for_each_possible_cpu(cpu)
+			raw_spin_lock_init(per_cpu_ptr(&rstat_base_cpu_lock, cpu));
+
+		return 0;
+	}
+
+	spin_lock_init(&ss->rstat_ss_lock);
+	ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
+	if (!ss->rstat_ss_cpu_lock)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+		raw_spin_lock_init(per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu));
+
+	return 0;
 }
 
 /*
-- 
2.47.1


