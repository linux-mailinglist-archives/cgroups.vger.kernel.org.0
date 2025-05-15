Return-Path: <cgroups+bounces-8202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CEBAB7A7C
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF49817EC5F
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AC182D0;
	Thu, 15 May 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtkt9K0P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BE125B9
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268396; cv=none; b=r8y4qZ6hxesJmMjaon/0GMQXlhtj9/0jtR02lExbTwpDR3A1oFxS4aJoukjcz2UZUhtqER6ir6zGvoHNKZuOG0CXhfr9YuTKcn6reOFipT2apLMI8nQZkeCsLooLaVdHgYnJwxriAFVr3+/9HOvXeWf7JwnY1YZdiJXNvIXqNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268396; c=relaxed/simple;
	bh=GN7rLHminw3IlEM8hpEK+ohIhLRHt93zZj4FJt9KXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuXxBtc8IDBaMnCCQG/h9WZ726lWeXEKngaFAhdpT07YAiEsp/qXhxnLfQKypwZIyUbOt4k/HXnuJ63OQpJToZb5lQmlbXbY+b2MLr1LhYOEMxbJ/Y06mN9XGtRoTkqSpf6L5YgaSagKfi31IGpRiVKyYF8mWIv8gVsXkKHUPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtkt9K0P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22fa47d6578so3003975ad.2
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268393; x=1747873193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWFox4LIjsqPkf8GOiIF7Krk9TUQS5EFTj7kh57y2mY=;
        b=mtkt9K0POEtm2WEjiFU0Ysbqgd/lN447fmWg12iu+TXFSCNbVliF0BHJxBiL+eSnLt
         JJ1ZZyRC8Bt9cNRDQ2LmedYi6OnC1IQ6xwRCGwO1h62jaOoD5aM2ZZVdRx9oqYCMeF82
         XFTemjrMkEXWhABFHxpywfYMdC5ctR+d5H8AkCMkMGIXs9TpviB2wkkyHWIqPsHaaZOk
         nis2CXIBQFva3FAI1Ztk5JJXJodvFizelHZJWUm8+xqU0sFjzjfF6QPgp2/cQuS42e5S
         ucZpj2irxKeMyLM155aM+67Od4CW22EJLnnmdQfXOpBifYRWlwoQ0aKYVIcKVxRVGXD7
         8o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268393; x=1747873193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWFox4LIjsqPkf8GOiIF7Krk9TUQS5EFTj7kh57y2mY=;
        b=d2twMPBhfnBGC0ItKYhhmfLPJGv1cYiCB+KkciCYO2AZcwd2fUC+xavodipoUG0B8L
         rFIHmDBGW0zCZ1UGVai4qdOd2FiFu9CDPU6LDOR5hmXRV2mjuA+O764dRcrAagmolPXV
         3Lbe0Ndn8T5XWciudX6nP+dZi92IiVe2MlVkSZos8ga5s+hnFRwkUKdhDbcWxLc2RcQP
         jRn6wS7GmlvpYjcrAqlC9qY8wi4BaBm7pLA1pNybdVlGITnWcbZOtgQtWqn25gMdUED9
         ouNSg0XuPA41VDHOUTVjclc8BkXZJJ1x0dUZRV6rRIJHykJABWQ78cp9gbVkjnF611dD
         iYSw==
X-Forwarded-Encrypted: i=1; AJvYcCXHngeYqEXH966Tdprj6i1GSEUIHZLEQW6lIFUx2XOvTBERp7YwhYNHyvO0D9HK5dnv95dLRhLH@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5R5SZT4T+ezstwh4mVum2ZxaAfPtdz63y2b6oUQ/cdGEGA9P
	4kVPDajKrINRbgutc6prWU68VqYkUR5i0ilF5QHoKdM2N+VjQMem
X-Gm-Gg: ASbGncsLZLjmGn67w4ZUVJbgWueRZMbD83F+cmhtoOIGRm5FIjLnAJCJpE5cdAZEE3Q
	r4BgkwEpEmvrglKP58iCQFVpqhZ1G9MaUb0lhIB/hQ6D+WPf9qsojl1ac0j/KxMowprZ8dQ6RA9
	ChXyHWCIZoE4N2fKrBZutSrBa8GNHgQ7VTz5Ez4m73kd5IYQhAa7KmXhPwKAa89tRPqeGzFo7gy
	P+z27l2eNxUIQprX0D+8NnwVsHKz7Q4nxAisraXRn/NzE34xbVaWBSDs6NupCmTWt1cnY+mo22j
	o0le/G/lBhUDRGGs9QhY2KR7IQ9GLyIxuBWUJtYUB5NckyOSwGFSi7CSD0K3mUytXFiE8Bdw/uM
	G4XlNH/1wo1eyMTss+QfFw8RY33LeMfXUH1zcVNh9QI6Dzw2tIg==
X-Google-Smtp-Source: AGHT+IEmWt7OzKVLMsDQaZtyJZngkoadbHoZBW1s+FCVw2/JSJ5mcNKu3bNimDj7381DTveNZAlOLA==
X-Received: by 2002:a17:903:194f:b0:22f:a48f:7a9a with SMTP id d9443c01a7336-231981bf07emr67387955ad.37.1747268393381;
        Wed, 14 May 2025 17:19:53 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:52 -0700 (PDT)
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
Subject: [PATCH v6 4/6] cgroup: use subsystem-specific rstat locks to avoid contention
Date: Wed, 14 May 2025 17:19:35 -0700
Message-ID: <20250515001937.219505-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515001937.219505-1-inwardvessel@gmail.com>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
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
 block/blk-cgroup.c              |  4 +-
 include/linux/cgroup-defs.h     | 10 +++-
 include/trace/events/cgroup.h   | 12 +++-
 kernel/cgroup/cgroup-internal.h |  2 +-
 kernel/cgroup/cgroup.c          |  3 +-
 kernel/cgroup/rstat.c           | 98 +++++++++++++++++++++++----------
 6 files changed, 91 insertions(+), 38 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0560ea402856..4dc10c1e97a4 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1074,8 +1074,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	/*
 	 * For covering concurrent parent blkg update from blkg_release().
 	 *
-	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
-	 * this lock won't cause contention most of time.
+	 * When flushing from cgroup, the subsystem rstat lock is always held,
+	 * so this lock won't cause contention most of time.
 	 */
 	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 17ecaae9c5f8..5b8127d29dc5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -222,7 +222,10 @@ struct cgroup_subsys_state {
 	/*
 	 * A singly-linked list of css structures to be rstat flushed.
 	 * This is a scratch field to be used exclusively by
-	 * css_rstat_flush() and protected by cgroup_rstat_lock.
+	 * css_rstat_flush().
+	 *
+	 * Protected by rstat_base_lock when css is cgroup::self.
+	 * Protected by css->ss->rstat_ss_lock otherwise.
 	 */
 	struct cgroup_subsys_state *rstat_flush_next;
 };
@@ -362,7 +365,7 @@ struct css_rstat_cpu {
 	 * the css makes it unnecessary for each per-cpu struct to point back
 	 * to the associated css.
 	 *
-	 * Protected by per-cpu cgroup_rstat_cpu_lock.
+	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
 	 */
 	struct cgroup_subsys_state *updated_children;
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
@@ -792,6 +795,9 @@ struct cgroup_subsys {
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
index 45097dc9e099..44baa0318713 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6088,6 +6088,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
+		BUG_ON(ss_rstat_init(ss));
 		BUG_ON(css_rstat_init(css));
 	}
 
@@ -6167,7 +6168,7 @@ int __init cgroup_init(void)
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-	cgroup_rstat_boot();
+	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 6ce134a7294d..0bb609e73bde 100644
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
@@ -115,7 +133,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
-	flags = _css_rstat_cpu_lock(cpu_lock, cpu, css, true);
+	flags = _css_rstat_cpu_lock(css, cpu, true);
 
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
@@ -143,7 +161,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		css = parent;
 	}
 
-	_css_rstat_cpu_unlock(cpu_lock, cpu, css, flags, true);
+	_css_rstat_cpu_unlock(css, cpu, flags, true);
 }
 
 /**
@@ -171,11 +189,11 @@ static struct cgroup_subsys_state *css_rstat_push_children(
 	child->rstat_flush_next = NULL;
 
 	/*
-	 * The cgroup_rstat_lock must be held for the whole duration from
+	 * The subsystem rstat lock must be held for the whole duration from
 	 * here as the rstat_flush_next list is being constructed to when
 	 * it is consumed later in css_rstat_flush().
 	 */
-	lockdep_assert_held(&cgroup_rstat_lock);
+	lockdep_assert_held(ss_rstat_lock(head->ss));
 
 	/*
 	 * Notation: -> updated_next pointer
@@ -245,12 +263,11 @@ static struct cgroup_subsys_state *css_rstat_push_children(
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
@@ -287,7 +304,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 	if (child != root)
 		head = css_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_css_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_css_rstat_cpu_unlock(root, cpu, flags, false);
 	return head;
 }
 
@@ -314,7 +331,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -324,27 +341,31 @@ __bpf_hook_end();
  */
 static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
 		int cpu_in_loop)
-	__acquires(&cgroup_rstat_lock)
+	__acquires(ss_rstat_lock(css->ss))
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
+	__releases(ss_rstat_lock(css->ss))
 {
 	struct cgroup *cgrp = css->cgroup;
+	spinlock_t *lock;
 
+	lock = ss_rstat_lock(css->ss);
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock_irq(lock);
 }
 
 /**
@@ -466,12 +487,29 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
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
 
+	if (ss) {
+		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
+		if (!ss->rstat_ss_cpu_lock)
+			return -ENOMEM;
+	}
+
+	spin_lock_init(ss_rstat_lock(ss));
 	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+		raw_spin_lock_init(ss_rstat_cpu_lock(ss, cpu));
+
+	return 0;
 }
 
 /*
-- 
2.47.1


