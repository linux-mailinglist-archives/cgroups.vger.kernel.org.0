Return-Path: <cgroups+bounces-6029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA82A00286
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6331883EF3
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE77187346;
	Fri,  3 Jan 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3wkzpZc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8C185B62
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869041; cv=none; b=DTx38CoeoeyJsiVTmUE7XDyb0ZSqgVPf2DtjBOZPEu+oD7tSlqcVdA91QTv1wZt2XOjaT+8y5IktK4BD2WcyfAu5sDocO79Y0+ex5t9Qt14OXAivry+kssFrT+DxRtb0Ve6c81aUMkAliqOt3g0x5Y1gMBW1bi/meEffDNEdLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869041; c=relaxed/simple;
	bh=Jm0ZTxGxh7nE7ILS5pnD3oIILQ8AL+2DaPtaGxuPvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxyvTnFyU0i6D6h/IAE6UUGrxQ0Yh7/MvjQhXFkOrZrtjj3QPCujEIIZPLchBGvBUwJhiOW0anUb+i1QRpmGiGjeWsViNtEdPs0GSqZPoCSAGxAZQUyA7PcW2hiVAEUp7VZzDZxWAJLcye5L1eASiZT2LK9zowNkdqChu4pqR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3wkzpZc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165cb60719so165630565ad.0
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869038; x=1736473838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06Rq6Yp6bkyCHegIVI2ycFM+KAFm/5mAM9hGlEHX3pE=;
        b=S3wkzpZcv6akQfwotiEeP/JbMKWJr5UWg68EVD8DE2trkXR/Z1DDLYkVmpGqnqdPG1
         kZzIH0mxzg+WZtQn+CE2H6hQj/Jm00Dx3oEtEHBXTyLN2nA91eTRQKyuCPNKXq94fTic
         4/m0YadikUQK22uc24eteUWSmOFtanmg7rkLImqzJqYjE42IQqBFL7FU22fIFdGIs54m
         9o55UyeDOH7r4xYzaSTkj5WgNuEy/KsR5da+4AHlKwwQQ6DIbv719azRf7LY5anNzmeF
         Q0OpX+lDKVrmOEBXof5B/W3ffNx6+WoSzepHHUYyvBuNLIVhCLPuI5/yl6gLUhVRpG8h
         BJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869038; x=1736473838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06Rq6Yp6bkyCHegIVI2ycFM+KAFm/5mAM9hGlEHX3pE=;
        b=mjtKxftii0rN4MxUua7Edivwsrwo94XNNGF+PjqK8/WcoPidrAD2itq9JR9l/jMsRO
         fSLOXJJEj7ltVSqbvzTFS5xsp4DHgfNxxQpTPqk1fpzNQZPtvOT3mIRBd2ajQ9n6Zaqp
         sEAq2RMWwg1H7wsMKFwddd8kRA3NKnAJvtyjpXdhf1RO5h5lKGijoshrm2in9rPNK31F
         IwuwYhyZrh4dmJJYfDAh67wr89jXuzcbBKpzy/nJLzW/JFwrmVb6otlbE13bFS1IjeQy
         jXuwDXEOHzfOcf/ZJx2xxiSg/uqF3dMbOJ8F68DY15a0kIg2K4H3H7KkF5pm7QPX/hax
         VHJw==
X-Forwarded-Encrypted: i=1; AJvYcCVzexGABHkS2GJf5NfnbslTHBNeX6C6bynUNMo7G9WyZurvKxJmhu4KMiPJWMFFHOeOQtJDXLnl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TsOszTQumsl0gmNmnFeVVLuKXi8IgaTQOktz72TCoawBoE8h
	rCM+1e5G/oLpciyICFjh9sBV6WVzgMEk7wzr1c4X4IALQWnwrH0k
X-Gm-Gg: ASbGncuXWWhIFt575Zl0Dfe7ysRoRPJrRFLId7S5Upjy0533lBCl0KaMzRFmCPyaQoY
	s2Ve1lvDPxxzCZ+qaOdrt8ng2IfPUdGltmCVXJ9+Fp9bhy/To6hGMFAmMGgJMbsWQAttmgLgdId
	5c67N1HHi4DAAshirtfD9ofgV52HxejY+fnZuPVFfg8AIOUq+E1p/AgwrXLbYg9p12JhlazQoyN
	DI1Vu3Kf8c3eCYTym+LoL9I11MaipwGAwpGaMy9/tt5nfN9xZtATe87oM3EITY/x78ue4j95qLG
	oVs6Ei7+53C2dhF1Jw==
X-Google-Smtp-Source: AGHT+IGrZJLbbkVIwX5AQ1w7ifn+2yxZj+rAsWC13phN3JNek86G54n2zYjuYiKjyl8m0KsBcHLbEg==
X-Received: by 2002:a17:903:230c:b0:216:1543:195d with SMTP id d9443c01a7336-219e6eb3a5dmr635218695ad.25.1735869037897;
        Thu, 02 Jan 2025 17:50:37 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:37 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 5/9 v2] cgroup: separate locking between base css and others
Date: Thu,  2 Jan 2025 17:50:16 -0800
Message-ID: <20250103015020.78547-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate locks can be used to eliminate contention between subsystems that make
use of rstat. The base stats also get their own lock. Where applicable, check
for the existence of a subsystem pointer to determine if the given
cgroup_subsys_state is the base css or not for deciding which lock to take.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h |  2 +
 kernel/cgroup/rstat.c       | 92 +++++++++++++++++++++++++------------
 2 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1932f8ae7995..4d87519ff023 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -790,6 +790,8 @@ struct cgroup_subsys {
 	 * specifies the mask of subsystems that this one depends on.
 	 */
 	unsigned int depends_on;
+
+	spinlock_t rstat_lock;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4381eb9ac426..958bdccf0359 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -9,8 +9,9 @@
 
 #include <trace/events/cgroup.h>
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock[CGROUP_SUBSYS_COUNT]);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -86,7 +87,7 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	struct cgroup *cgrp = css->cgroup;
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	raw_spinlock_t *cpu_lock;
 	unsigned long flags;
 
 	/*
@@ -100,6 +101,11 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
 		return;
 
+	if (css->ss)
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock[css->ss->id], cpu);
+	else
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
+
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
@@ -207,11 +213,16 @@ static struct cgroup_subsys_state *cgroup_rstat_push_children(
 static struct cgroup_subsys_state *cgroup_rstat_updated_list(
 				struct cgroup_subsys_state *root, int cpu)
 {
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = css_rstat_cpu(root, cpu);
 	struct cgroup_subsys_state *head = NULL, *parent, *child;
+	raw_spinlock_t *cpu_lock;
 	unsigned long flags;
 
+	if (root->ss)
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock[root->ss->id], cpu);
+	else
+		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
+
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root->cgroup, false);
 
 	/* Return NULL if this subtree is not on-list */
@@ -285,37 +296,44 @@ __bpf_hook_end();
  * number processed last.
  */
 static inline void __cgroup_rstat_lock(struct cgroup_subsys_state *css,
-				int cpu_in_loop)
-	__acquires(&cgroup_rstat_lock)
+				spinlock_t *lock, int cpu_in_loop)
+	__acquires(lock)
 {
 	struct cgroup *cgrp = css->cgroup;
 	bool contended;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
+	contended = !spin_trylock_irq(lock);
 	if (contended) {
 		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(&cgroup_rstat_lock);
+		spin_lock_irq(lock);
 	}
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
 static inline void __cgroup_rstat_unlock(struct cgroup_subsys_state *css,
-				int cpu_in_loop)
-	__releases(&cgroup_rstat_lock)
+				spinlock_t *lock, int cpu_in_loop)
+	__releases(lock)
 {
 	struct cgroup *cgrp = css->cgroup;
 
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock_irq(lock);
 }
 
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
+	__releases(&css->ss->rstat_lock) __acquires(&css->ss->rstat_lock)
 {
+	spinlock_t *lock;
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
+	if (!css->ss) {
+		pr_warn("cannot use generic flush on base subsystem\n");
+		return;
+	}
+
+	lock = &css->ss->rstat_lock;
+	lockdep_assert_held(lock);
 
 	for_each_possible_cpu(cpu) {
 		struct cgroup_subsys_state *pos = cgroup_rstat_updated_list(css, cpu);
@@ -334,11 +352,11 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 		}
 
 		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(css, cpu);
+		if (need_resched() || spin_needbreak(lock)) {
+			__cgroup_rstat_unlock(css, lock, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(css, cpu);
+			__cgroup_rstat_lock(css, lock, cpu);
 		}
 	}
 }
@@ -358,11 +376,22 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
+	spinlock_t *lock;
+
+	if (!css->ss) {
+		int cpu;
+
+		for_each_possible_cpu(cpu)
+			cgroup_base_stat_flush(css->cgroup, cpu);
+		return;
+	}
+
 	might_sleep();
 
-	__cgroup_rstat_lock(css, -1);
+	lock = &css->ss->rstat_lock;
+	__cgroup_rstat_lock(css, lock, -1);
 	cgroup_rstat_flush_locked(css);
-	__cgroup_rstat_unlock(css, -1);
+	__cgroup_rstat_unlock(css, lock, -1);
 }
 
 /**
@@ -374,11 +403,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
  *
  * This function may block.
  */
-void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
-	__acquires(&cgroup_rstat_lock)
+static void cgroup_rstat_base_flush_hold(struct cgroup_subsys_state *css)
+	__acquires(&cgroup_rstat_base_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(css, -1);
+	__cgroup_rstat_lock(css, &cgroup_rstat_base_lock, -1);
 	cgroup_rstat_flush_locked(css);
 }
 
@@ -386,10 +415,10 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  * @cgrp: cgroup used by tracepoint
  */
-void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
-	__releases(&cgroup_rstat_lock)
+static void cgroup_rstat_base_flush_release(struct cgroup_subsys_state *css)
+	__releases(&cgroup_rstat_base_lock)
 {
-	__cgroup_rstat_unlock(css, -1);
+	__cgroup_rstat_unlock(css, &cgroup_rstat_base_lock, -1);
 }
 
 int cgroup_rstat_init(struct cgroup_subsys_state *css)
@@ -435,10 +464,15 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 
 void __init cgroup_rstat_boot(void)
 {
-	int cpu;
+	struct cgroup_subsys *ss;
+	int cpu, ssid;
+
+	for_each_possible_cpu(cpu) {
+		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
 
-	for_each_possible_cpu(cpu)
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+		for_each_subsys(ss, ssid)
+			raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock[ssid], cpu));
+	}
 }
 
 /*
@@ -629,12 +663,12 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	u64 usage, utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
-		cgroup_rstat_flush_hold(css);
+		cgroup_rstat_base_flush_hold(css);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
 		ntime = cgrp->bstat.ntime;
-		cgroup_rstat_flush_release(css);
+		cgroup_rstat_base_flush_release(css);
 	} else {
 		/* cgrp->bstat of root is not actually used, reuse it */
 		root_cgroup_cputime(&cgrp->bstat);
-- 
2.47.1


