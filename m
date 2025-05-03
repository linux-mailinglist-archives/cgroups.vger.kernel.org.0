Return-Path: <cgroups+bounces-7999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C90AA7DAE
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E411B665B6
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 00:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C12FB6;
	Sat,  3 May 2025 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdctFGu8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80383380
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746231162; cv=none; b=P1OnogHzcbeO5/HkRn6nvi9vmwvfvtjBwetOmEGPUfnDUGamUJ2yioihWRTZxYTMP5qb2NhHbKwAMlzwYCAP+D2FZGZ4//OHu/PVDz/sKPpe/CkxIq0fk+GmMuilWt+8oQgRhqKPH24WE0NUQiezTmRyXfTMix45VO+Qxh64Syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746231162; c=relaxed/simple;
	bh=7IRjlJGt+0M80JEjCFSC8azk88sOu/hqdTgZc9KuPfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cspngjl5W3fT0lZraOyc0/KW+u8hImkYDLP6XEeTCq6SrjAudn+cHJXnFFXx4/fDjLT6K2CINirMNYLVvZO71pYglwGkH+vjucLIV+fzVsVyVKV3enljMKaiz9X58RANwA1IgUBrpkhtYXl0zdcViJJri0pSkXRrN0HZICDM5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdctFGu8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22928d629faso26773505ad.3
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 17:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746231160; x=1746835960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gn9VQnWdJz4VhO77FIVJ04j98J5OLA080DsKiIUYkU=;
        b=EdctFGu8uEPzO6JFyq0djYJ/U6yo0mDXbaX1QxqUkP8YyT5gSqWoMcmI8NYNnntLnn
         hMrKesOA8C2O/rflRB3yezg1Ni1J//X7Qim499CYwuSZjkMVcuKT4pySYskNLplsyzmN
         yqtLBkuEALJei1KuJ9gEY69UaA5eyTC84fgHIYJLa017xOS0b1b0xcAXsqZK0mGwCBKp
         nocxnLh5PtNZs4RpxMra2C24hN2YNSEkxtQlAryYat1SDgcCo4udMQmS63pRklFKdVZ9
         1Maw2mx6pbrQOr2bHMvRcQSUtJgnhdfy2+WghOzqRWpsyWEIYzdHBPf07PPdxby3Qffi
         uG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746231160; x=1746835960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gn9VQnWdJz4VhO77FIVJ04j98J5OLA080DsKiIUYkU=;
        b=VcXrhc0Cjc2H8F+grz4oqeUdYt/iOPMTr1s3+mI+bNZIDCQmGet7Vz81Sjp0ZlGHxf
         ffNXHbIFgpwkLTw93+dy6WbP9qJATGQLnUxPUVjtK3KHS8qS0wNzSHG+NFDgMj7y6HLd
         gQvwFh/rhSAOIIRITD+mLl+LQ+TPvSH/dbuO6YuoxtZjbtvu01OwP6J9SHttDFVgCY9K
         0RAHdk3l/Lju8h4zFm77/kkxVBFR8vNs1LmMtxDFCQ521zXxE74Mg0qcIVfI7svCh9Xx
         8ltg1kvRaaRvOnbGeL3li+T+W7dfcUKElKjEGG+rIUtXmqm3y7k6XbTxN/4s8BqkmPOo
         a6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnN6BNI6fRbV25j+/yv72qenrjsnOpSltU8lo5s04+3MZw9P7Lai8FzjDwwn+qIpfmVYKVjS9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OiApMQV6LT62kxWWQPxoYASju8IThrfBNqVmOGVpAyNT2GC8
	gNv4TWZFfFx1aO5XW4LYlrHUr4JkDEFcNMoTguKXkamKeyGpXEDQ
X-Gm-Gg: ASbGnctWQyne7ZoU0S6koNgEk9WhcMOClry8WihYHYMJtjMvlvbHlddYTItyv7UuEYn
	8R4kLYGoN7A9+DRe+iOQVqu9ZCvI32Omun69qSYEN1OQNWBdxenoIZP5PlaEbVfH7rF1u8vrnfa
	LGjMfAjqSdPwtTXbEIji08/84GIuFFDdwNupJNzWPQnnRfVWjYBsQU1j/TmgVMBGeClanrPusDE
	mnRMtpI6/7GvKHy9MU5mhZS/yztoFuxPWwK5ZnYQna6XlOVfgK6TNgkEXE+x9lNOlTzYZvzteNb
	BggsHnJXncf0/pPGof0xTXJMR6VOr3MPZNEIsutfGhSkXROQKhWZuJrZkohQLovhrJ09UcWe/B7
	mY7M=
X-Google-Smtp-Source: AGHT+IEEvYbH8qiotsxVHATJlrvlyC+RXsviT//hx6CWKSGq6ssGakCaG62xqFdMk1ZhEFxbRffzyQ==
X-Received: by 2002:a17:902:ea0e:b0:22d:e5ab:5525 with SMTP id d9443c01a7336-22e10393f2fmr75982785ad.38.1746231159700;
        Fri, 02 May 2025 17:12:39 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:6a01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f9csm13718635ad.178.2025.05.02.17.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:12:39 -0700 (PDT)
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
Subject: [PATCH v5 3/5] cgroup: use subsystem-specific rstat locks to avoid contention
Date: Fri,  2 May 2025 17:12:20 -0700
Message-ID: <20250503001222.146355-4-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503001222.146355-1-inwardvessel@gmail.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
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
 include/linux/cgroup-defs.h     |  10 +++-
 include/trace/events/cgroup.h   |  12 +++-
 kernel/cgroup/cgroup-internal.h |   2 +-
 kernel/cgroup/cgroup.c          |   3 +-
 kernel/cgroup/rstat.c           | 103 ++++++++++++++++++++++----------
 6 files changed, 95 insertions(+), 37 deletions(-)

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
index f96535009d56..8071be38a409 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6088,6 +6088,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
+		BUG_ON(ss_rstat_init(ss));
 		BUG_ON(css_rstat_init(css));
 	}
 
@@ -6165,7 +6166,7 @@ int __init cgroup_init(void)
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-	cgroup_rstat_boot();
+	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 29ba804f6ccc..e1e9dd7de705 100644
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
@@ -468,12 +489,34 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
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


