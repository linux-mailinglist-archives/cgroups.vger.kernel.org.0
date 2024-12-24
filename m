Return-Path: <cgroups+bounces-5998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932A9FB82B
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F4F164658
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267A946C;
	Tue, 24 Dec 2024 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuJa838T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E32D517
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002862; cv=none; b=GEQ1OgPlEmQQ4zOX2IwSVx23klNIJVXNgYM1H7IpxD1aYYgujWZJ/taIVc2nsPUASXMhgBLmYXNyskEeC01SU85aSl1ziQHdX3L78xhVxU2fwcZ6KHp8svOtfFvd2XI/zNjYvtRL3lPeD5cdPV+HSd9CeSd65mhs49qlKI0fCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002862; c=relaxed/simple;
	bh=u3AFtbyljxy8wxiuzvEeYEmO9yp/zIyp3Z2K9/iujNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keVgozeOmoQGW4e/P8JgZrJAJEEh0wqb1O7qCLSWoW121pEE14pvSCNT+O1+5hDo0VWIeD5eTWhmtSXXr5YQ0u7wRAPGozZBUoPxJsAwriEUHX9q1jJ/Qb3ZyQ5FlGQ9JQGBqMHS/trQ/SicY9VLilV9kD9FejkA5XxjGtW/Lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJa838T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so56086085ad.2
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002860; x=1735607660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpQSbn6C6AIKp7YKs7miT4jgNyhtNHCB16iSRmc/g1c=;
        b=UuJa838TZE+JMLTVV2uObY9blzz/Ti7eBn7hsV8SNiYHpzEU3W4sTfH2r2qpYWh8xm
         fzLhO1mRplSso946kiBYAAu0PTNGgYBwFqm7mbbNoihJ5eAtTI6fzeMnkP0lQjrwEAhY
         GmdbEJiaO5cC+stWh2wRNgfFMyG7s+V5EBSe6hhZd1J8TsNxzGuTCGx35x3ioHQJwWaD
         UMYbdngfKhKxnmHrbkgFWkMJg8oN+E5wZ1Fe0AdZZxgCm3LqhQ0B62d/39K2GUhowP1l
         ImpkIkPbGYOcjXdfeEAAFWhagiEdLFOF6f4bHOeJqE7jWYcHAJDjtN0uxjV6q0ffJEjo
         CDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002860; x=1735607660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpQSbn6C6AIKp7YKs7miT4jgNyhtNHCB16iSRmc/g1c=;
        b=NddMUN/wqQNKH6VC39HwxH2bWQ864lDC9ePcHKVgrDdFpI2XoLD5ARUzppcsGAVn6a
         lRhOUnNhSSlzEz33P+H1wNzSjlx2Z7WZmja/tQkXD0f9GYwY49F4e22oTZmt0G2dYenz
         yHYJNlFMDIbLEMHLq8DXu8Eyco5EeqxD632XBabqMTFZJDfVTqWBrpEDX1RJYshAnMWq
         z9vBfhDIQXeRw/b6yQCIv2TAOHRTvnrc+/UQCPYK+m2pz9TL3bJFl1v92MtOoQfiOt54
         8OqI2lXh4RXf0Vz6wFKVm6MjKOunHM8MdC88392lEJFfs0CUZ/lO2+YQeLityVl2JcEB
         di4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwyecp1TJ2cpBdvm91Hm+ZJZ4oyGAe1M5igWk2PjtyWrcTnOPJAj2K5Sq51SSOHWcxgVS+m7se@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDV+giRNETC+t6OLEZP8A3DPHYlkvReeHesoERSv/rMTzX04/
	lbxMbUIcAJTmfzbNjGkPtxZwS90L7KMRnF72YMHL6mOaKAdyypIG
X-Gm-Gg: ASbGncsOWCwkUV1buh+lwqaUSiH28UBIxxiQQzDLHpSdEYq6q0tey+hHSQEooAarCBn
	EhCs/aoKwMH2pS7xHjNIRq5eTnaZ8OvfFNiD3Td0/MNNjEsEJ4E3/FqoL3+ofa0s5L8bY5ucUUv
	eCFlF6HCiCwOwjhfDPdPV3QHzPyivi2nKPo8sDtjLjraK8PIb78m4dAb8OxSqv6HwYHq1QaWedM
	5hJwGm+oq8Z64cMJBNhiUr0upghN/NzpF9A5dTiGDi0gfe3ojxSP90vlG7ZACHeGAlanjAvWscH
	dVPAOryGh9Uauo8Rkw==
X-Google-Smtp-Source: AGHT+IFwR7wXxhzrgfdQceACkEtKrEhPAYVpgAqlRJPF2+jNIw5EIHwhSSCWtl13waEhVD43uo5AMQ==
X-Received: by 2002:a17:902:c943:b0:215:72aa:693f with SMTP id d9443c01a7336-219e6e8bb89mr229405165ad.9.1735002860313;
        Mon, 23 Dec 2024 17:14:20 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:19 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 5/9 RFC] cgroup: separate locking between base css and others
Date: Mon, 23 Dec 2024 17:13:58 -0800
Message-ID: <20241224011402.134009-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate locks can be used to eliminate contention across subsystems that make
use of rstat. The base stats also get their own lock. Where applicable, check
for the existence of a subsystem pointer to determine if the given
cgroup_subsys_state is the base css or not.

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


