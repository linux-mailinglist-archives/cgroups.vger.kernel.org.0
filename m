Return-Path: <cgroups+bounces-7883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94617AA02CB
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 08:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6646B1744C4
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F75278E42;
	Tue, 29 Apr 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THqEnbW7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci32vtEo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59C27814B
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=95.215.58.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907198; cv=fail; b=EFaDwblEnWPRmpzTeQ6P2B+2B/zC0Ldrz0E4lrFR5M7gfFxMA6ziEtipxcZSgwLI+G5x/uy7l4j22CQ63IzyogZHAKJfgk/KaakRdSKvvfFpGInLvD4OY1WJCsCISCm041pVKll/PkLK1dSmrp6ka22vcM8f7/SJ8zKaiRfIxFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907198; c=relaxed/simple;
	bh=nYy0qDCjYxWZ22VEUJmMORCKoJVUSTHj74OR03G0Lis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYRttNjqNVHOH2sRo7iHjhu+llLIRoyA4ZRHInQ8Q6LRtFaObg3XTtzjhvbmz+lnLaQlQKTIjqhiOzaFzWn95DJ3Iy0q+4GzgMiXUJl65T7mmFG9U0SQNjUVPYi+30eSD5gGlWVmg2UII/OoCOnNEP3ktbwZFaUhm2u3qaqtaZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THqEnbW7; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci32vtEo reason="signature verification failed"; arc=fail smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uH9lxtGNXrDszx56Z84uJt2iii6/fQ5pv5DwQ8+b+A=;
	b=THqEnbW7OoTDfwchJqNiCBLD5t/x8waxsTnItkSaXgIAZ8UECZufOsgr6VCTfXkzconuUE
	5+IoumwiWD9l8uqO368d6j9X4w/tx8QkmgWq+4xcBR8drIiufwcemE5kWflM7MWaMyN5ae
	vfIPOVihPmVzNfERodHMAeEWTgfjq60=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	shakeel.butt@linux.dev
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks to avoid contention
Date: Mon, 28 Apr 2025 23:12:11 -0700
Message-ID: <20250428174943.69803-2-inwardvessel@gmail.com>
In-Reply-To: <20250428174943.69803-1-inwardvessel@gmail.com>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
Delivered-To: shakeel.butt@linux.dev
X-Envelope-To: shakeel.butt@linux.dev
Authentication-Results: aspmx1.migadu.com; dkim=pass header.d=gmail.com header.s=20230601 header.b=ci32vtEo; spf=pass (aspmx1.migadu.com: domain of inwardvessel@gmail.com designates 2607:f8b0:4864:20::636 as permitted sender) smtp.mailfrom=inwardvessel@gmail.com; dmarc=pass (policy=none) header.from=gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1; t=1745862594; h=from:from:reply-to:subject:subject:date:date:message-id:message-id: to:to:cc:mime-version:mime-version: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references:dkim-signature; bh=T9FxElrI6X1f0BNtJHqNj7QKlHLxnjZJhQ1N93uc1Tc=; b=ahKz7kbXjBCloHM3NUJVvHBkLPEE4UvoVt7dh3ns7i13MxZIbXu+eJiFuk8qzUxIQluMiI G9qf9k4Xqm1qt5sQIi/x2AkA6jQshm8yWS17HrWMboM1cs6GmTkIIymlfB+JY6Rk2P4GUF JykjfckEfXPH2g8EV2/p6ieOmEq/+fw=
ARC-Authentication-Results: i=1; aspmx1.migadu.com; dkim=pass header.d=gmail.com header.s=20230601 header.b=ci32vtEo; spf=pass (aspmx1.migadu.com: domain of inwardvessel@gmail.com designates 2607:f8b0:4864:20::636 as permitted sender) smtp.mailfrom=inwardvessel@gmail.com; dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=key1; d=linux.dev; t=1745862594; a=rsa-sha256; cv=none; b=h6hnDA/r0jVlcSztxPLrFH7bThdRtG0pAeVd6rbVj4X4SF59w3xeCIaDV6NXcoSw2fasYH FA6vn9jLODXnklWc8t6qlChHUWHc0jTWHgtsB9DJenuBZcLEVpN1byHt9asJIWfi/W8OBl Ci1xuWEzDSMqzUQq5JHyxyj1YLH/6hE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1745862593; x=1746467393; darn=linux.dev; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:to:from:from:to:cc:subject:date:message-id :reply-to; bh=T9FxElrI6X1f0BNtJHqNj7QKlHLxnjZJhQ1N93uc1Tc=; b=ci32vtEogx4cEeQcZtrAuBLyzwDlsmqWghOA6klX2bZowAJt0NM/nfiGU6BgKfL6cX npECEJ0w2f/k0d/7fl1CX0oAqbPhCrDv2UZr9U9L1FiKUu8TDeV8Yf7BWB47wAVHLpAR 731L5f/BzFmFoUrrjWI1QD3Jfq/OvwPc+OFSRIz36lcQGgsGrM6UIUjOQnItBiOSEh+/ gRlsIMrrcfGtC7Z1cXZ0QddVK7pQ0e05GrYgu+Q0Kr0uOnhlh/1qit5vHh5hD52nEoye sZfSfeis704+eQiddrBtfD+Nw3qWyqPPXlxSt8OVTqJpqySfVoHgpL3KwbGgy3VNrisv ++JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1745862593; x=1746467393; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:to:from:x-gm-message-state:from:to:cc :subject:date:message-id:reply-to; bh=T9FxElrI6X1f0BNtJHqNj7QKlHLxnjZJhQ1N93uc1Tc=; b=BdV1AxGgcrsOtkplWI1fNsi1TIirplTaAzPb+E5d25gfZP+RIOdfzEnfKPS7xcFb5l ZfAmwgrWhMghGd4Q+nak3Da1b17BoDlRpXddyVf882ij/JySHM6EK3LMWv4EFNeRMhxL 4u4WxIpEHRgCXOXBGNOp5605dPLZgo4SekhRtZ56qjO9M8V6/twySiuOzusSGMD51Z1N nEqb39vh56K/8grqikSCsyTGsI7lMuxKvDmeZ3rE6WY+n+vuk+pNBKbUv7cEQRIrAPyZ wW2F32elphNW1PZZpeiOGksKibHmwKD0wcub8Fo+m8h2loPdKPXqO8+lZadAvVt6ArwH exfA==
X-Gm-Message-State: AOJu0Yye91PsE+Ure1V8fqyJT8Fcmxc6sgQmgkODIcv4g7qHgIkLnJf/ LKNs43zrFDufjKLUrbEHRZsJCzHDpzgvYt7UAmpEywN8jgEisdPxCgvRDA==
X-Gm-Gg: ASbGncs3UaapzVtqCFXlFVYVHMu4wTau3LUcY4rj6fPlENUoNeMnOHAGsYmqTTKZFil vp2SUJYfR2J1Aoyy/wS1En9hN0qdqoxRjJ3X4ZVHhAapaviVub9oPB+tkx1Oqh4DPi//mQukguz gV9HTGRMnIrS6ECNQPOitmyJRQLLcwl1R8MdiX91/q+6CMSTnLowxbVIfiWYZJlkbcDF9QgoKbF OgoMk0yoUJ5DONIWkR0gmP8JDrXhvhcprlv06Ihtl/W7ZE75M3a+sxlIp1sPMPHWfi6nkqSNVms diaGcd4d6xm7nn2jO39bbLY6HoeASatYqk9pP5mH92mucVT/xr6UX5ukzoum3O3axid5
X-Google-Smtp-Source: AGHT+IGsAd1D2IKaxjoFfQ5223jM/wGLIRLsGqB17mzJvlp+SdkmS8QwKpGmi7DX+5UTYBepcSWnEA==
X-Received: by 2002:a17:902:d485:b0:224:1609:a74a with SMTP id d9443c01a7336-22dc6a6851emr145269525ad.34.1745862593096; Mon, 28 Apr 2025 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -5.78
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <inwardvessel@gmail.com>

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
 kernel/cgroup/cgroup.c          |  10 ++-
 kernel/cgroup/rstat.c           | 108 +++++++++++++++++++++-----------
 6 files changed, 103 insertions(+), 47 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index abeb7ec27e92..d7563b4bb795 100644
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
index 45a605c74ff8..560582c4dbeb 100644
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
@@ -794,6 +797,9 @@ struct cgroup_subsys {
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
index d9865299edf5..3528381ea73c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6141,8 +6141,10 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 
-		if (ss->css_rstat_flush)
+		if (ss->css_rstat_flush) {
+			BUG_ON(ss_rstat_init(ss));
 			BUG_ON(css_rstat_init(css));
+		}
 	}
 
 	/* Update the init_css_set to contain a subsys
@@ -6219,7 +6221,7 @@ int __init cgroup_init(void)
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
-	cgroup_rstat_boot();
+	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
@@ -6250,8 +6252,10 @@ int __init cgroup_init(void)
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
index ddc799ca6591..a30bcc4d4f48 100644
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
@@ -163,13 +181,6 @@ static struct cgroup_subsys_state *css_rstat_push_children(
 
 	child->rstat_flush_next = NULL;
 
-	/*
-	 * The cgroup_rstat_lock must be held for the whole duration from
-	 * here as the rstat_flush_next list is being constructed to when
-	 * it is consumed later in css_rstat_flush().
-	 */
-	lockdep_assert_held(&cgroup_rstat_lock);
-
 	/*
 	 * Notation: -> updated_next pointer
 	 *	     => rstat_flush_next pointer
@@ -238,12 +249,11 @@ static struct cgroup_subsys_state *css_rstat_push_children(
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
@@ -280,7 +290,7 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 	if (child != root)
 		head = css_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_css_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_css_rstat_cpu_unlock(root, cpu, flags, false);
 	return head;
 }
 
@@ -307,7 +317,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -317,27 +327,31 @@ __bpf_hook_end();
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
@@ -444,12 +458,36 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
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


