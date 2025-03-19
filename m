Return-Path: <cgroups+bounces-7183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46BA69BE6
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFA48192B
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAD21B9F8;
	Wed, 19 Mar 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3kicT+U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6A21C163
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422635; cv=none; b=UztApwsWS7wfJwhFSOUfXeHFXrGzuHv+1Qq4FMwLGpvQwzJnvbd3VwrJ3ApPj5SzQha8f4UnU+LCQ4QPnSrXTjbr+S2NNdXVW6krK6+ecYOxMlEhe8CJFW3mjzYAiSqxo2OwJui/FbKkAMpaYS7gI2+wAxur5TCzIiPvcnUYwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422635; c=relaxed/simple;
	bh=971obr5cFSwcFbC6qRAVlOFa46UVlCDtJvbLtD4omk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0lbZuPbc0jJwqquaX+AmBSn9teL0edAnovM8i2c9zpE3EejCeMGCstrmcKRukiRQjaejXLoiK10NrO5YyjS/rN8pzOIZFUsJtkzado5ipaG9322ol6hGA8gZ2QYVWqKwUArTta/a2tYOqAqQm9D/k/WS/m92iYNQH/0PR8Y7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3kicT+U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224341bbc1dso983385ad.3
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422633; x=1743027433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afEnSPzJRvzNwhVeLcHVZ9SDJWWdS1gSO21ww78tbw0=;
        b=Y3kicT+Uc9eMktLXa1R2vtpmmQddU0idkmPYARtLjVDmerTNX2dKBeXv7xzqQxC8Dm
         au6zphPbcOr6fLneM1S7BgrzcqpyeaOe6xmwZ7yB7nQD6CcBpXKuuioC7Cmk6ZkFmug3
         XgoUnRa+7oaRY9jq0AbGiUkTamRrsdoaY+uRh1M4uQtvJQalWqDV8e5BlCWbOXQlYE8y
         LBwqoxFUpH9rSnVcEmsqLwPZdr8hrzdb+1aZFv0xQ6Qrf1lJGccPUpuymqh8+i0djU4F
         +AmCjHPBAlLArr9sP2YsZNpuUFjLk0P7MA3ac5kYDq2c0FeNGi75Tb1EYrpB8B7UuNkg
         koag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422633; x=1743027433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afEnSPzJRvzNwhVeLcHVZ9SDJWWdS1gSO21ww78tbw0=;
        b=YhixIAUwyW+8iNSQLz+SdsEib3twmyLoASUYWv7HtMcabRRALJ+mLmKhTQNgS6zMzC
         IL2ncKcmAKW7S9ZGhMcH1SdWhsTbv9YwTHzMDZosT2VJLolqNDxD2sqKYot0BGM+9zdk
         gB74XbS07+ms5sDxl+h2br6emhnKZcC1fEnj0HUZDsjk87ZEc7GCFes9KknNcWDpLkGD
         S3uH77YAbI1Lx3X4zDhx4yICBVlIy8Y9FcjJhE7Mmc2j+EUbF5+GG7i6Jvm+iCpXpkfv
         qDVjcYtb2iUXUDwtB8mcI/vJlqTqgArY5gN/He6ygdXfuvoch6lrpHtecwBVue8Ewk0n
         IRXA==
X-Forwarded-Encrypted: i=1; AJvYcCUeAkBYK/KBI4PlR7LKFR0X4nEx7qm5N8/uIpFaOW7zSZmHuFYEC0chpu5JFPzq8yMPNtOq9PiG@vger.kernel.org
X-Gm-Message-State: AOJu0YxzP7NuasikuD69SXn0dm8oCkMOcSp0dHSIvlmpyqligfZJvkOt
	H99lOvzu+2IYkrAZHzvLwATmRHazkUUY8Ed4GsQrB4cfVndnfzsm
X-Gm-Gg: ASbGncsGX/mkHgY2kC/y+lMcxTEmrlinCbQTPJBoTyMSsGJXgv739QGC/fJaVlJAuA7
	ARSEAPi/VQh7eKiSumGtS8wWUNmn0KRINnu8WvLaLktJsMhdftKksEwLuWfPScmrwyJljQhOBqh
	pAYALgBkyrSs0vKsOK20VoZ/5kwK/QcPxGXcoi1N8U5/fgz3c4sSF5A848x0UUzWiSC3zYSxpZ0
	aja3Ft688GqmU4wWt71nyrladR3qkm30w1+dTowu6Rx8b8a5Z+Gb9Hxq0poTLqy0eTJNEaoWoVX
	SlWxaFV5KQJ1uBroeIt4RejR9ysGBg7ddME3ib0UMXEanO5xp0tFOoPCPAk2Oix3laEq95E+
X-Google-Smtp-Source: AGHT+IFrFgCS8dDhvXzZ3pmRSL5PI+IuoTySLBe+Qt2yGOY/MJc5imuwWRkc8x+PC5JqjjBIrA1KCA==
X-Received: by 2002:a05:6a20:8426:b0:1f5:7f0c:2462 with SMTP id adf61e73a8af0-1fbed21eeabmr8324206637.28.1742422633020;
        Wed, 19 Mar 2025 15:17:13 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm12253977b3a.160.2025.03.19.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:17:12 -0700 (PDT)
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
Subject: [PATCH 4/4] cgroup: save memory by splitting cgroup_rstat_cpu into compact and full versions
Date: Wed, 19 Mar 2025 15:16:34 -0700
Message-ID: <20250319221634.71128-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319221634.71128-1-inwardvessel@gmail.com>
References: <20250319221634.71128-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup_rstat_cpu struct contains rstat node pointers and also the base
stat objects. Since ownership of the cgroup_rstat_cpu has shifted from
cgroup to cgroup_subsys_state, css's other than cgroup::self are now
carrying along these base stat objects which go unused. Eliminate this
wasted memory by splitting up cgroup_rstat_cpu into two separate structs.

The cgroup_rstat_cpu struct is modified in a way that it now contains only
the rstat node pointers. css's that are associated with a subsystem
(memory, io) use this compact struct to participate in rstat without the
memory overhead of the base stat objects.

As for css's represented by cgroup::self, a new cgroup_rstat_base_cpu
struct is introduced. It contains the new compact cgroup_rstat_cpu struct
as its first field followed by the base stat objects.

Because the rstat pointers exist at the same offset (beginning) in both
structs, cgroup_subsys_state is modified to contain a union of the two
structs. Where css initialization is done, the compact struct is allocated
when the css is associated with a subsystem. When the css is not associated
with a subsystem, the full struct is allocated. The union allows the
existing rstat updated/flush routines to work with any css regardless of
subsystem association. The base stats routines however, were modified to
access the full struct field in the union.

The change in memory on a per-cpu basis is shown below.

before:
    struct size
    sizeof(cgroup_rstat_cpu) =~ 144 bytes /* can vary based on config */

    per-cpu overhead
    nr_cgroups * (
	sizeof(cgroup_rstat_cpu) * (1 + nr_rstat_subsystems)
    )
    nr_cgroups * (144 * (1 + 2))
    nr_cgroups * 432

    432 bytes per cgroup per cpu

after:
    struct sizes
    sizeof(cgroup_rstat_base_cpu) =~ 144 bytes
    sizeof(cgroup_rstat_cpu) = 16 bytes

    per-cpu overhead
    nr_cgroups * (
	sizeof(cgroup_rstat_base_cpu) +
	sizeof(cgroup_rstat_cpu) * (nr_rstat_subsystems)
    )
    nr_cgroups * (144 + 16 * 2)
    nr_cgroups * 176

    176 bytes per cgroup per cpu

savings:
    256 bytes per cgroup per cpu

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h |  41 +++++++++------
 kernel/cgroup/rstat.c       | 100 ++++++++++++++++++++++--------------
 2 files changed, 86 insertions(+), 55 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 0ffc8438c6d9..f9b84e7f718d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -170,7 +170,10 @@ struct cgroup_subsys_state {
 	struct percpu_ref refcnt;
 
 	/* per-cpu recursive resource statistics */
-	struct css_rstat_cpu __percpu *rstat_cpu;
+	union {
+		struct css_rstat_cpu __percpu *rstat_cpu;
+		struct css_rstat_base_cpu __percpu *rstat_base_cpu;
+	};
 
 	/*
 	 * siblings list anchored at the parent's ->children
@@ -358,6 +361,26 @@ struct cgroup_base_stat {
  * resource statistics on top of it - bsync, bstat and last_bstat.
  */
 struct css_rstat_cpu {
+	/*
+	 * Child cgroups with stat updates on this cpu since the last read
+	 * are linked on the parent's ->updated_children through
+	 * ->updated_next.
+	 *
+	 * In addition to being more compact, singly-linked list pointing
+	 * to the cgroup makes it unnecessary for each per-cpu struct to
+	 * point back to the associated cgroup.
+	 *
+	 * Protected by per-cpu rstat_base_cpu_lock when css->ss == NULL
+	 * otherwise,
+	 * Protected by per-cpu css->ss->rstat_cpu_lock
+	 */
+	struct cgroup_subsys_state *updated_children;	/* terminated by self */
+	struct cgroup_subsys_state *updated_next;	/* NULL if not on list */
+};
+
+struct css_rstat_base_cpu {
+	struct css_rstat_cpu rstat_cpu;
+
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
 	 * updated in the hot path.
@@ -384,22 +407,6 @@ struct css_rstat_cpu {
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
-	 * Protected by per-cpu rstat_base_cpu_lock when css->ss == NULL
-	 * otherwise,
-	 * Protected by per-cpu css->ss->rstat_cpu_lock
-	 */
-	struct cgroup_subsys_state *updated_children;	/* terminated by self */
-	struct cgroup_subsys_state *updated_next;	/* NULL if not on list */
 };
 
 struct cgroup_freezer_state {
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ffd7ac6bcefc..250f0987407e 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -20,6 +20,12 @@ static struct css_rstat_cpu *css_rstat_cpu(
 	return per_cpu_ptr(css->rstat_cpu, cpu);
 }
 
+static struct css_rstat_base_cpu *css_rstat_base_cpu(
+		struct cgroup_subsys_state *css, int cpu)
+{
+	return per_cpu_ptr(css->rstat_base_cpu, cpu);
+}
+
 static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
 {
 	if (ss)
@@ -425,17 +431,35 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 
 	/* the root cgrp's self css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
-		css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
-		if (!css->rstat_cpu)
-			return -ENOMEM;
+		/* One of the union fields must be initialized.
+		 * Allocate the larger rstat struct for base stats when css is
+		 * cgroup::self.
+		 * Otherwise, allocate the compact rstat struct since the css is
+		 * associated with a subsystem.
+		 */
+		if (css_is_cgroup(css)) {
+			css->rstat_base_cpu = alloc_percpu(struct css_rstat_base_cpu);
+			if (!css->rstat_base_cpu)
+				return -ENOMEM;
+		} else {
+			css->rstat_cpu = alloc_percpu(struct css_rstat_cpu);
+			if (!css->rstat_cpu)
+				return -ENOMEM;
+		}
 	}
 
-	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
+		struct css_rstat_cpu *rstatc;
 
+		rstatc = css_rstat_cpu(css, cpu);
 		rstatc->updated_children = css;
-		u64_stats_init(&rstatc->bsync);
+
+		if (css_is_cgroup(css)) {
+			struct css_rstat_base_cpu *rstatbc;
+
+			rstatbc = css_rstat_base_cpu(css, cpu);
+			u64_stats_init(&rstatbc->bsync);
+		}
 	}
 
 	return 0;
@@ -522,9 +546,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct css_rstat_cpu *rstatc = css_rstat_cpu(&cgrp->self, cpu);
+	struct css_rstat_base_cpu *rstatbc = css_rstat_base_cpu(&cgrp->self, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct css_rstat_cpu *prstatc;
+	struct css_rstat_base_cpu *prstatbc;
 	struct cgroup_base_stat delta;
 	unsigned seq;
 
@@ -534,15 +558,15 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 
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
@@ -551,73 +575,73 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
-		delta = rstatc->subtree_bstat;
-		prstatc = css_rstat_cpu(&parent->self, cpu);
-		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
-		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
-		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
+		delta = rstatbc->subtree_bstat;
+		prstatbc = css_rstat_base_cpu(&parent->self, cpu);
+		cgroup_base_stat_sub(&delta, &rstatbc->last_subtree_bstat);
+		cgroup_base_stat_add(&prstatbc->subtree_bstat, &delta);
+		cgroup_base_stat_add(&rstatbc->last_subtree_bstat, &delta);
 	}
 }
 
-static struct css_rstat_cpu *
+static struct css_rstat_base_cpu *
 cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
 {
-	struct css_rstat_cpu *rstatc;
+	struct css_rstat_base_cpu *rstatbc;
 
-	rstatc = get_cpu_ptr(cgrp->self.rstat_cpu);
-	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
-	return rstatc;
+	rstatbc = get_cpu_ptr(cgrp->self.rstat_base_cpu);
+	*flags = u64_stats_update_begin_irqsave(&rstatbc->bsync);
+	return rstatbc;
 }
 
 static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
-						 struct css_rstat_cpu *rstatc,
+						 struct css_rstat_base_cpu *rstatbc,
 						 unsigned long flags)
 {
-	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
+	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
 	css_rstat_updated(&cgrp->self, smp_processor_id());
-	put_cpu_ptr(rstatc);
+	put_cpu_ptr(rstatbc);
 }
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
 {
-	struct css_rstat_cpu *rstatc;
+	struct css_rstat_base_cpu *rstatbc;
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
-	struct css_rstat_cpu *rstatc;
+	struct css_rstat_base_cpu *rstatbc;
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


