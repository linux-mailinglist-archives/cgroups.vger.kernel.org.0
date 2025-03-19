Return-Path: <cgroups+bounces-7188-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C5A69BF7
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BE51895BE3
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD921C198;
	Wed, 19 Mar 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZH6lZh8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66E21C186
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422925; cv=none; b=sE3lvL69+i0KCHivADceEp0d/7YIGQlNZAK9niIwUHQCIHsuxnDUalFz2ZQ4rW6nzHmjTEHOZ5uyMzCEvoi0ipQe5CCI6f85ufb/yRO4uRcdJNSxdyDwvMXJeZKWJPM71bEbU+zJZ+TPVQHeGEZ44QgkAmIwZe9YEHX+NGOkqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422925; c=relaxed/simple;
	bh=8jLVrOHAHGoTAlRlg93xv9Bypr5jXpOsBpYzxPXGGcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7xiuSy/T8S4GbJ4fD6aM1lMxMJ0XbvaBGPPsEAAljRBmkE4GD7kvTK5deqB61Vr4pRtN1XN0k5xIiq6qeytf8PVhko47vDnTeOv+SMQrWWAZAxUaOduPHReikMvNa86Bs63Zo1MWr0aCzv7lNmfx7VlZ/5L+owYxOWFNufWEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZH6lZh8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso1071015ad.2
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422923; x=1743027723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBVQ9JLe0YyGvw+H4jsTKvC5B30TGlzUOUpyXhkBvvk=;
        b=FZH6lZh8nouIkL23usVS+WA7Z/KysZ5FYsUMlBHVTwNjZtu/SB0gqfbHeVbNEGQmEd
         8BvGY8RQJHlnv/xyRqlX8cNgeHRM6GOc4Vj/LaV5h8HlGd3iSH8tFnATF68jpWsY5Jax
         8GarPgvhPMDQYLugl8G9xqZH2pnpACwmgltM9SJyy0FtuFUBBcApOoN/hM2P28GXtHwb
         L5N6iw5dvngGqn3DQHwjNgFHDc8KDtMSMhJDa68errB4BSJi6f1pPTa3OI4ei0QgPP9t
         xP1fcqZyfCDYd8/DWcPBkZv2gjwj68j7uNogg7dWQU4FD1TXAdMkAMZusn1h8nojVGM/
         M9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422923; x=1743027723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBVQ9JLe0YyGvw+H4jsTKvC5B30TGlzUOUpyXhkBvvk=;
        b=aCSxri/6oUEj89ROkJi9n0LkoO271CiyGQKhEu6+W2j0TP9OO3gndY2o9LAeRwjebq
         PQySuN4VuelZLW8KH0gJ99e3zB0Ad+YRN0tXFmLaAMAIsCjWL2BzSQC+5qLv93av7ZRP
         Z85e6Jl+4NF5cGE7BJzfnmCP96LCahM+DCNp/wgvtnnKMayE8YWD7lqdXasLcBkA/sm0
         YdFbN6kCAlIYcQ26V+zkrXoRK5IQsCpclBnhOgDYYwbicPJeUJCYkwK6NvlDZ+N6SVcL
         XcJRo0ikfckfKT+GshZsaEz7WYIGYfyZXgcZYsBJk1KxZlUEQcBgxtOTNsAsz8aTB6zH
         1V5w==
X-Forwarded-Encrypted: i=1; AJvYcCWjRXtPV7aGt8ZHZp/rW9y/o3qc+6AzbFyWKFON/Ipdnu3/xijTV3Jm2cuIVDuVYaIsRv1fUeKW@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJhI1KZFlrsCkTnKGV0P27XZcKyg1R918vaki7bwcPDG9tcKx
	mOPYztBcf1LEvI1++yecGnn1WgDPvTDGwKxXcwMZ/0lJj1LtkZBH
X-Gm-Gg: ASbGncu4RPf1RxPQCT4eecn/2WnWptnOhmIY+XDV0nKWL/eL3s/IXdjdKa9pDxaJaNz
	A01FPdayHvJv4Q9+xas+3pb2mTCj9E6dLv9B6LjhS8Rx2eExMymPzlGfGhx+qU717vW9Gfv2u5T
	4yVdO23p9t9sJLPj5UUYR2lGmRPHaiudCHNFeR5rY/YEqzVH+GSALJTh0NOJz/gLHCVPab2pxTo
	ccFvU3jzEoSUJRn5jqF0JeEwe1wGtkwuGi+Pxs/tDMfqYEVjJW+OAnYXUH+zUX5ygxxcmAw61YK
	Ru0t/erQOikZMdYO5u5xaXthMI39vpdf5Gn4ahwj+UIL3tUPWsBJU1vU+dBmAsaCIBhRVfcc
X-Google-Smtp-Source: AGHT+IEGcY2aKA8XQV959Yq4kTr/uU7ry8vGv9V27wj29zqACrniwt41wDvcC+5GWMs2YXTmgSZOdw==
X-Received: by 2002:a05:6a21:6f10:b0:1f5:709d:e0cc with SMTP id adf61e73a8af0-1fbed8e7137mr7970456637.40.1742422922975;
        Wed, 19 Mar 2025 15:22:02 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9dd388sm11467484a12.20.2025.03.19.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:22:02 -0700 (PDT)
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
Subject: [PATCH 3/4 v3] cgroup: use subsystem-specific rstat locks to avoid contention
Date: Wed, 19 Mar 2025 15:21:49 -0700
Message-ID: <20250319222150.71813-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319222150.71813-1-inwardvessel@gmail.com>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to eliminate contention between subsystems when
updating/flushing stats by using subsystem-specific locks. Let the existing
rstat locks be dedicated to the base stats and rename them to reflect it.
Add similar locks to the cgroup_subsys struct for use with individual
subsystems. To make use of the new locks, change the existing lock helper
functions to accept a reference to a css and use css->ss to access the
locks or use the static locks for base stats when css->ss is NULL.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 block/blk-cgroup.c              |   2 +-
 include/linux/cgroup-defs.h     |  12 ++-
 include/trace/events/cgroup.h   |  10 ++-
 kernel/cgroup/cgroup-internal.h |   2 +-
 kernel/cgroup/cgroup.c          |  10 ++-
 kernel/cgroup/rstat.c           | 145 +++++++++++++++++++++-----------
 6 files changed, 122 insertions(+), 59 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cd9521f4f607..34d72bbdd5e5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1022,7 +1022,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	/*
 	 * For covering concurrent parent blkg update from blkg_release().
 	 *
-	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
+	 * When flushing from cgroup, the subsystem lock is always held, so
 	 * this lock won't cause contention most of time.
 	 */
 	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 031f55a9ac49..0ffc8438c6d9 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -223,7 +223,10 @@ struct cgroup_subsys_state {
 	/*
 	 * A singly-linked list of css structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-	 * cgroup_rstat_flush_locked() and protected by cgroup_rstat_lock.
+	 * cgroup_rstat_flush_locked().
+	 *
+	 * protected by rstat_base_lock when css is cgroup::self
+	 * protected by css->ss->lock otherwise
 	 */
 	struct cgroup_subsys_state *rstat_flush_next;
 };
@@ -391,7 +394,9 @@ struct css_rstat_cpu {
 	 * to the cgroup makes it unnecessary for each per-cpu struct to
 	 * point back to the associated cgroup.
 	 *
-	 * Protected by per-cpu cgroup_rstat_cpu_lock.
+	 * Protected by per-cpu rstat_base_cpu_lock when css->ss == NULL
+	 * otherwise,
+	 * Protected by per-cpu css->ss->rstat_cpu_lock
 	 */
 	struct cgroup_subsys_state *updated_children;	/* terminated by self */
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on list */
@@ -779,6 +784,9 @@ struct cgroup_subsys {
 	 * specifies the mask of subsystems that this one depends on.
 	 */
 	unsigned int depends_on;
+
+	spinlock_t lock;
+	raw_spinlock_t __percpu *percpu_lock;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index af2755bda6eb..ec3a95bf4981 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -231,7 +231,10 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 		  __entry->cpu, __entry->contended)
 );
 
-/* Related to global: cgroup_rstat_lock */
+/* Related to locks:
+ * rstat_base_lock when handling cgroup::self
+ * css->ss->lock otherwise
+ */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
 
 	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
@@ -253,7 +256,10 @@ DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
 	TP_ARGS(cgrp, cpu, contended)
 );
 
-/* Related to per CPU: cgroup_rstat_cpu_lock */
+/* Related to per CPU locks:
+ * rstat_base_cpu_lock when handling cgroup::self
+ * css->ss->cpu_lock otherwise
+ */
 DEFINE_EVENT(cgroup_rstat, cgroup_rstat_cpu_lock_contended,
 
 	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index d4b75fba9a54..513bfce3bc23 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -271,7 +271,7 @@ int cgroup_task_count(const struct cgroup *cgrp);
  */
 int css_rstat_init(struct cgroup_subsys_state *css);
 void css_rstat_exit(struct cgroup_subsys_state *css);
-void cgroup_rstat_boot(void);
+int ss_rstat_init(struct cgroup_subsys *ss);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1e21065dec0e..3e8948805f67 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6085,8 +6085,10 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
-		if (ss->css_rstat_flush)
+		if (ss->css_rstat_flush) {
+			BUG_ON(ss_rstat_init(ss));
 			BUG_ON(css_rstat_init(css));
+		}
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6163,7 +6165,7 @@ int __init cgroup_init(void)
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-	cgroup_rstat_boot();
+	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
@@ -6193,8 +6195,10 @@ int __init cgroup_init(void)
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
index a28c00b11736..ffd7ac6bcefc 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,8 +9,8 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static DEFINE_SPINLOCK(rstat_base_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -20,8 +20,24 @@ static struct css_rstat_cpu *css_rstat_cpu(
 	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
+static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
+{
+	if (ss)
+		return &ss->lock;
+
+	return &rstat_base_lock;
+}
+
+static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
+{
+	if (ss)
+		return per_cpu_ptr(ss->percpu_lock, cpu);
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
@@ -29,20 +45,23 @@ static struct css_rstat_cpu *css_rstat_cpu(
  * operations without handling high-frequency fast-path "update" events.
  */
 static __always_inline
-unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
-				     struct cgroup *cgrp, const bool fast_path)
+unsigned long _css_rstat_cpu_lock(struct cgroup_subsys_state *css, int cpu,
+		const bool fast_path)
 {
+	struct cgroup *cgrp = css->cgroup;
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
@@ -62,15 +81,18 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
 }
 
 static __always_inline
-void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
-			      struct cgroup *cgrp, unsigned long flags,
-			      const bool fast_path)
+void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
+		unsigned long flags, const bool fast_path)
 {
+	struct cgroup *cgrp = css->cgroup;
+	raw_spinlock_t *cpu_lock;
+
 	if (fast_path)
 		trace_cgroup_rstat_cpu_unlock_fastpath(cgrp, cpu, false);
 	else
 		trace_cgroup_rstat_cpu_unlock(cgrp, cpu, false);
 
+	cpu_lock = ss_rstat_cpu_lock(css->ss, cpu);
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
 
@@ -85,8 +107,6 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
  */
 void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	struct cgroup *cgrp = css->cgroup;
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
 	/*
@@ -100,7 +120,7 @@ void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
+	flags = _css_rstat_cpu_lock(css, cpu, true);
 
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -128,7 +148,7 @@ void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		css = parent;
 	}
 
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
+	_css_rstat_cpu_unlock(css, cpu, flags, true);
 }
 
 __bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
@@ -211,13 +231,11 @@ static struct cgroup_subsys_state *cgroup_rstat_push_children(
 static struct cgroup_subsys_state *css_rstat_updated_list(
 		struct cgroup_subsys_state *root, int cpu)
 {
-	struct cgroup *cgrp = root->cgroup;
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct css_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
+	flags = _css_rstat_cpu_lock(root, cpu, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -254,7 +272,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
+	_css_rstat_cpu_unlock(root, cpu, flags, false);
 	return head;
 }
 
@@ -281,7 +299,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -289,35 +307,44 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
-	__acquires(&cgroup_rstat_lock)
+static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
+		int cpu_in_loop)
+	__acquires(lock)
 {
+	struct cgroup *cgrp = css->cgroup;
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
 
-static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
-	__releases(&cgroup_rstat_lock)
+static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
+		int cpu_in_loop)
+	__releases(lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
+
+	lock = ss_rstat_lock(css->ss);
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock_irq(lock);
 }
 
-/* see css_rstat_flush() */
+/* see css_rstat_flush()
+ *
+ * it is required that callers have previously acquired a lock via
+ * __css_rstat_lock(css)
+ */
 static void css_rstat_flush_locked(struct cgroup_subsys_state *css)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
-
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos;
 
@@ -332,11 +359,11 @@ static void css_rstat_flush_locked(struct cgroup_subsys_state *css)
 		}
 
 		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
+		if (need_resched() || spin_needbreak(ss_rstat_lock(css->ss))) {
+			__css_rstat_unlock(css, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__css_rstat_lock(css, cpu);
 		}
 	}
 }
@@ -356,13 +383,10 @@ static void css_rstat_flush_locked(struct cgroup_subsys_state *css)
  */
 void css_rstat_flush(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
-
-	__cgroup_rstat_lock(cgrp, -1);
+	__css_rstat_lock(css, -1);
 	css_rstat_flush_locked(css);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__css_rstat_unlock(css, -1);
 }
 
 __bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
@@ -381,10 +405,8 @@ __bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
  */
 void css_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
+	__css_rstat_lock(css, -1);
 	css_rstat_flush_locked(css);
 }
 
@@ -394,8 +416,7 @@ void css_rstat_flush_hold(struct cgroup_subsys_state *css)
  */
 void css_rstat_flush_release(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
-	__cgroup_rstat_unlock(cgrp, -1);
+	__css_rstat_unlock(css, -1);
 }
 
 int css_rstat_init(struct cgroup_subsys_state *css)
@@ -439,12 +460,36 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
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
+	spin_lock_init(&ss->lock);
+	ss->percpu_lock = alloc_percpu(raw_spinlock_t);
+	if (!ss->percpu_lock)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+		raw_spin_lock_init(per_cpu_ptr(ss->percpu_lock, cpu));
+
+	return 0;
 }
 
 /*
-- 
2.47.1


