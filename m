Return-Path: <cgroups+bounces-8039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FBAAC982
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC356523CB3
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52664283120;
	Tue,  6 May 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AOF3howK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC74322E
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545467; cv=none; b=M+8mkc2xhIYUdGPTv28sfeLTlQdgwFHfrN5ihMrIfgCbOA9u5/OxDmoTKT29yz1hh8GtW/TkT2mpwCgNdhE931gwRCScsKE9j+ri7VYC5ZlNnTo/H/siJYTv7q1ru6x6FK5gNrhNLQs6QhfG8k9S6HLxovk6lKjA8Hk3yq3noUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545467; c=relaxed/simple;
	bh=kGg06HUhWSHniOuVzi4P0t5C81zPDotKXNcpOoa3Fb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ6Jw5+nPNh6RiCgGqTI2qsdYT7d8dIVN3AUNNFt5pmOI9dpz1ak2h6GrgiSDnUmOdLMJXbi4g7XD7WKUwXAEL8CWnpPn3FiAAMYFIYMyFijNQQSZdIRVVzu31uip/lCKeuGugxEevo6TS8/g3mY+3ttNK0oUMwG8DRHIlFV19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AOF3howK; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3642720f8f.0
        for <cgroups@vger.kernel.org>; Tue, 06 May 2025 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746545462; x=1747150262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXbFyxjc36cJwDEo8WWZfuc4edb1NHepYG3s9v6pnj4=;
        b=AOF3howK9KakhB18xUQEliQJvRH6ZTqGwxFJt8R8P8UH9mbVXOtEUi7PIG/U+X92wI
         ffrXFCHhja+1UGhFmgEq5uZUhCMOt3PHo4qrztGeM9fTrsiTiZC6caVZVguOpNwupKNs
         Cj86eWG59f7IL2bxASuMDHpALmN3V9qLfG7/rNozwdONaqSZMr6NenqvRgb0l3d0MZXA
         4J6fPd0AEkhdQYcR+X0Of+oT+mrO9vCbO84eUJTtaWS0CoGoqzqhICsqWbT5d4ujK789
         B5VIb1K9e+D1Q86HJvCerbcZIXawFwn5GhQ1psIOEcWhJRn1kFmc0FeIInq/JS6NAaF2
         3kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746545462; x=1747150262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXbFyxjc36cJwDEo8WWZfuc4edb1NHepYG3s9v6pnj4=;
        b=mlw0CkhzYLwU7MJRxIh+ZCubcu4qb96dVCpcI5i/Wxh6UCwhSkhDhBDkpLo1gO8NMQ
         OzhCXoj9J3piXKOUCUKD1CSMZyZ4q78PExt+cAXQM0DyK59FPF6bbQGiv4QrC+qwQdQU
         UblVyOM8ZeW/kXPP+Lvv5AVPvnPJ+U7ZzA6XV4SaNjSj3OdZZwo9fSfXS6tmjiLGLBf1
         rXEY/37gDM7+K86lJ6Qs/lA9iTc1IfkuFf76B+cv3h5Rk0q3GMovGJn7T8J2s3WgRVmw
         584SC5+oijUajWifGhIv5+zcxSXADvvgk9iNWXf2UCMXQhV246f5fOC07oyFEoOOBTw8
         8yJA==
X-Forwarded-Encrypted: i=1; AJvYcCX4v0Z3CDJ2PP9YRlNslZmdtyI+Qa43aPgY+NO6kGiacfxuYvBeervapofW3B8bfMGfeDfVTJq8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzff1JWkYR//G/Hf2z8753ptLAlXGOsXzKVvvzgtt+OYtKBTE1z
	o6Gb4wiRk97x9g/qYcp0I/V6ej3dof7sa6AVFxecLtIk439rNvosiHi9SHPQmoM=
X-Gm-Gg: ASbGnctCpXdSo04Pyi+0p7QY0y9q+a65p+gX90jUzcKADOV72GwP9sA/z53MJfXBzgq
	cC3ReInHXPZCMjM7zDaj4i8zMs4GIJ87kAuUeAS+5AVM11PiD+KTaEnhjEP9cmCajs2BxFVxEJR
	dcAbAc8/muMAkK4er3ZoBxsDuMxGg6JQB7sWwIAKF/DiIBckTgZDiXA/KqGJTn+REhrlvCHKk0w
	0gDt1VIM45lxjIybJ56x+mjqccnj5mLiYUdXz3OOsLdF2dhSJwmuafK5t21YwjD4t5vsyYdpQr6
	m21qz3fKUFWVUqtPEI2lRbpshjIAgB7Kawb3wUXoT42VsycT+Wrcfby6Zd/xrJpx46K3vwfEj81
	k4igmK8M8YZ7VyvUmSr9626+MRBDy4OgG5WMuX5ni
X-Google-Smtp-Source: AGHT+IHIKlG3AhGm3OguhqQoif3hMnei0+qo/txrJ/Gg61xTjpycmaQRJiA3ezhVFoBtUUHetrTe3w==
X-Received: by 2002:a05:6000:184f:b0:3a0:92d9:da4 with SMTP id ffacd0b85a97d-3a0b43afb7amr200541f8f.6.1746545462426;
        Tue, 06 May 2025 08:31:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0feb3sm14084719f8f.67.2025.05.06.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:31:02 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH PoC] kernel/cgroup/pids: refactor "pids.forks" into "pids.stat"
Date: Tue,  6 May 2025 17:30:56 +0200
Message-ID: <20250506153057.210213-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <aBkqeM0DoXUHHdgq@slm.duckdns.org>
References: <aBkqeM0DoXUHHdgq@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proof-of-concept patch as reply to
https://lore.kernel.org/cgroups/aBkqeM0DoXUHHdgq@slm.duckdns.org/ to
be applied on top of
https://lore.kernel.org/lkml/20250502121930.4008251-1-max.kellermann@ionos.com/

This is quick'n'dirty, with a lot of code copied from mm/memcontrol.c
and adjusted.  I omitted the tables memcg_vm_event_stat and
memory_stats because I did not understand why they exist; simply using
enum pids_stat_item for everything instead, with no lookup table (only
pids_stats_names, a simple array of C string pointers).

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 kernel/cgroup/pids.c | 269 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 256 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index fb18741f85ba..9f09f1ebc986 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -32,12 +32,23 @@
 #include <linux/threads.h>
 #include <linux/atomic.h>
 #include <linux/cgroup.h>
+#include <linux/seq_buf.h>
+#include <linux/sizes.h> // for SZ_4K
 #include <linux/slab.h>
 #include <linux/sched/task.h>
 
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
 
+/*
+ * size of first charge trial.
+ * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
+ * workload.
+ */
+#define PIDS_CHARGE_BATCH 64U
+
+#define SEQ_BUF_SIZE SZ_4K
+
 enum pidcg_event {
 	/* Fork failed in subtree because this pids_cgroup limit was hit. */
 	PIDCG_MAX,
@@ -49,9 +60,6 @@ enum pidcg_event {
 struct pids_cgroup {
 	struct cgroup_subsys_state	css;
 
-	/* the "pids.forks" counter */
-	atomic64_t			forks;
-
 	/*
 	 * Use 64-bit types so that we can safely represent "max" as
 	 * %PIDS_MAX = (%PID_MAX_LIMIT + 1).
@@ -64,8 +72,55 @@ struct pids_cgroup {
 	struct cgroup_file		events_file;
 	struct cgroup_file		events_local_file;
 
+	/* pids.stat */
+	struct pids_cgroup_stats	*stats;
+
 	atomic64_t			events[NR_PIDCG_EVENTS];
 	atomic64_t			events_local[NR_PIDCG_EVENTS];
+
+	struct pids_cgroup_stats_percpu __percpu *stats_percpu;
+};
+
+/* Cgroup-specific page state, on top of universal node page state */
+enum pids_stat_item {
+	PIDS_FORKS,
+	PIDS_NR_STAT,
+};
+
+struct pids_cgroup_stats_percpu {
+	/* Stats updates since the last flush */
+	unsigned int			stats_updates;
+
+	/* Cached pointers for fast iteration in pids_rstat_updated() */
+	struct pids_cgroup_stats_percpu	*parent;
+	struct pids_cgroup_stats	*stats;
+
+	/* The above should fit a single cacheline for pids_rstat_updated() */
+
+	/* Local (CPU and cgroup) state */
+	long			state[PIDS_NR_STAT];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[PIDS_NR_STAT];
+} ____cacheline_aligned;
+
+struct pids_cgroup_stats {
+	/* Aggregated (CPU and subtree) state */
+	long			state[PIDS_NR_STAT];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[PIDS_NR_STAT];
+
+	/* Stats updates since the last flush */
+	atomic64_t		stats_updates;
+};
+
+struct pids_stat {
+	const char *name;
+};
+
+static const char *const pids_stats_names[] = {
+	"forks",
 };
 
 static struct pids_cgroup *css_pids(struct cgroup_subsys_state *css)
@@ -78,22 +133,181 @@ static struct pids_cgroup *parent_pids(struct pids_cgroup *pids)
 	return css_pids(pids->css.parent);
 }
 
+static void __pids_css_free(struct pids_cgroup *pids)
+{
+
+	free_percpu(pids->stats_percpu);
+	kfree(pids);
+}
+
 static struct cgroup_subsys_state *
 pids_css_alloc(struct cgroup_subsys_state *parent)
 {
+	struct pids_cgroup *parent_pids = css_pids(parent);
 	struct pids_cgroup *pids;
+	struct pids_cgroup_stats_percpu *statc, *pstatc;
+	int cpu;
 
 	pids = kzalloc(sizeof(struct pids_cgroup), GFP_KERNEL);
 	if (!pids)
 		return ERR_PTR(-ENOMEM);
 
+	pids->stats = kzalloc(sizeof(struct pids_cgroup_stats),
+			      GFP_KERNEL_ACCOUNT);
+	pids->stats_percpu = alloc_percpu_gfp(struct pids_cgroup_stats_percpu,
+					      GFP_KERNEL_ACCOUNT);
+	if (!pids->stats || !pids->stats_percpu) {
+		__pids_css_free(pids);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (parent_pids)
+			pstatc = per_cpu_ptr(parent_pids->stats_percpu, cpu);
+		statc = per_cpu_ptr(pids->stats_percpu, cpu);
+		statc->parent = parent_pids ? pstatc : NULL;
+		statc->stats = pids->stats;
+	}
+
 	atomic64_set(&pids->limit, PIDS_MAX);
 	return &pids->css;
 }
 
 static void pids_css_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_pids(css));
+	struct pids_cgroup *pids = css_pids(css);
+
+	__pids_css_free(pids);
+}
+
+struct aggregate_control {
+	/* pointer to the aggregated (CPU and subtree aggregated) counters */
+	long *aggregate;
+	/* pointer to the pending child counters during tree propagation */
+	long *pending;
+	/* pointer to the parent's pending counters, could be NULL */
+	long *ppending;
+	/* pointer to the percpu counters to be aggregated */
+	long *cstat;
+	/* pointer to the percpu counters of the last aggregation*/
+	long *cstat_prev;
+	/* size of the above counters */
+	int size;
+};
+
+static void pids_cgroup_stat_aggregate(struct aggregate_control *ac)
+{
+	int i;
+	long delta, delta_cpu, v;
+
+	for (i = 0; i < ac->size; i++) {
+		/*
+		 * Collect the aggregated propagation counts of groups
+		 * below us. We're in a per-cpu loop here and this is
+		 * a global counter, so the first cycle will get them.
+		 */
+		delta = ac->pending[i];
+		if (delta)
+			ac->pending[i] = 0;
+
+		/* Add CPU changes on this level since the last flush */
+		delta_cpu = 0;
+		v = READ_ONCE(ac->cstat[i]);
+		if (v != ac->cstat_prev[i]) {
+			delta_cpu = v - ac->cstat_prev[i];
+			delta += delta_cpu;
+			ac->cstat_prev[i] = v;
+		}
+
+		if (delta) {
+			ac->aggregate[i] += delta;
+			if (ac->ppending)
+				ac->ppending[i] += delta;
+		}
+	}
+}
+
+static void pids_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct pids_cgroup *pids = css_pids(css);
+	struct pids_cgroup *parent = parent_pids(pids);
+	struct pids_cgroup_stats_percpu *statc;
+	struct aggregate_control ac;
+
+	statc = per_cpu_ptr(pids->stats_percpu, cpu);
+
+	ac = (struct aggregate_control) {
+		.aggregate = pids->stats->state,
+		.pending = pids->stats->state_pending,
+		.ppending = parent ? parent->stats->state_pending : NULL,
+		.cstat = statc->state,
+		.cstat_prev = statc->state_prev,
+		.size = PIDS_NR_STAT,
+	};
+	pids_cgroup_stat_aggregate(&ac);
+
+	WRITE_ONCE(statc->stats_updates, 0);
+	/* We are in a per-cpu loop here, only do the atomic write once */
+	if (atomic64_read(&pids->stats->stats_updates))
+		atomic64_set(&pids->stats->stats_updates, 0);
+}
+
+static bool pids_stats_needs_flush(struct pids_cgroup_stats *stats)
+{
+	return atomic64_read(&stats->stats_updates) >
+		PIDS_CHARGE_BATCH * num_online_cpus();
+}
+
+static inline void pids_rstat_updated(struct pids_cgroup *pids, int val)
+{
+	struct pids_cgroup_stats_percpu *statc;
+	int cpu = smp_processor_id();
+	unsigned int stats_updates;
+
+	if (!val)
+		return;
+
+	cgroup_rstat_updated(pids->css.cgroup, cpu);
+	statc = this_cpu_ptr(pids->stats_percpu);
+	for (; statc; statc = statc->parent) {
+		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
+		WRITE_ONCE(statc->stats_updates, stats_updates);
+		if (stats_updates < PIDS_CHARGE_BATCH)
+			continue;
+
+		/*
+		 * If @pids is already flush-able, increasing stats_updates is
+		 * redundant. Avoid the overhead of the atomic update.
+		 */
+		if (!pids_stats_needs_flush(statc->stats))
+			atomic64_add(stats_updates,
+				     &statc->stats->stats_updates);
+		WRITE_ONCE(statc->stats_updates, 0);
+	}
+}
+
+/**
+ * __mod_pids_state - update cgroup pids statistics
+ * @pids: the pids cgroup
+ * @idx: the stat item - can be enum pids_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+static void __mod_pids_state(struct pids_cgroup *pids, enum pids_stat_item i,
+			     int val)
+{
+	__this_cpu_add(pids->stats_percpu->state[i], val);
+	pids_rstat_updated(pids, val);
+}
+
+/* idx can be of type enum pids_stat_item or node_stat_item */
+static void mod_pids_state(struct pids_cgroup *pids,
+			   enum pids_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_pids_state(pids, idx, val);
+	local_irq_restore(flags);
 }
 
 static void pids_update_watermark(struct pids_cgroup *p, int64_t nr_pids)
@@ -150,7 +364,7 @@ static void pids_charge(struct pids_cgroup *pids, int num)
 	struct pids_cgroup *p;
 
 	for (p = pids; parent_pids(p); p = parent_pids(p)) {
-		atomic64_add(num, &p->forks);
+		mod_pids_state(p, PIDS_FORKS, num);
 		int64_t new = atomic64_add_return(num, &p->counter);
 
 		pids_update_watermark(p, new);
@@ -172,10 +386,11 @@ static int pids_try_charge(struct pids_cgroup *pids, int num, struct pids_cgroup
 	struct pids_cgroup *p, *q;
 
 	for (p = pids; parent_pids(p); p = parent_pids(p)) {
-		atomic64_add(num, &p->forks);
 		int64_t new = atomic64_add_return(num, &p->counter);
 		int64_t limit = atomic64_read(&p->limit);
 
+		mod_pids_state(p, PIDS_FORKS, num);
+
 		/*
 		 * Since new is capped to the maximum number of pid_t, if
 		 * p->limit is %PIDS_MAX then we know that this test will never
@@ -347,12 +562,40 @@ static int pids_max_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static s64 pids_forks_read(struct cgroup_subsys_state *css,
-			   struct cftype *cft)
+static void pids_cgroup_flush_stats(struct pids_cgroup *pids)
 {
-	struct pids_cgroup *pids = css_pids(css);
+	if (!pids_stats_needs_flush(pids->stats))
+		return;
 
-	return atomic64_read(&pids->forks);
+	cgroup_rstat_flush(pids->css.cgroup);
+}
+
+static void pids_stat_format(struct pids_cgroup *pids, struct seq_buf *s)
+{
+	unsigned i;
+
+	pids_cgroup_flush_stats(pids);
+
+	for (i = 0; i < ARRAY_SIZE(pids_stats_names); i++) {
+		long x = READ_ONCE(pids->stats->state[i]);
+
+		seq_buf_printf(s, "%s %ld\n", pids_stats_names[i], x);
+	}
+}
+
+static int pids_stat_show(struct seq_file *seq, void *v)
+{
+	struct pids_cgroup *pids = css_pids(seq_css(seq));
+	char *buf = kmalloc(SEQ_BUF_SIZE, GFP_KERNEL);
+	struct seq_buf s;
+
+	if (!buf)
+		return -ENOMEM;
+	seq_buf_init(&s, buf, SEQ_BUF_SIZE);
+	pids_stat_format(pids, &s);
+	seq_puts(seq, buf);
+	kfree(buf);
+	return 0;
 }
 
 static s64 pids_current_read(struct cgroup_subsys_state *css,
@@ -418,9 +661,8 @@ static struct cftype pids_files[] = {
 		.read_s64 = pids_peak_read,
 	},
 	{
-		.name = "forks",
-		.read_s64 = pids_forks_read,
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "stat",
+		.seq_show = pids_stat_show,
 	},
 	{
 		.name = "events",
@@ -467,6 +709,7 @@ static struct cftype pids_files_legacy[] = {
 struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
+	.css_rstat_flush = pids_css_rstat_flush,
 	.can_attach 	= pids_can_attach,
 	.cancel_attach 	= pids_cancel_attach,
 	.can_fork	= pids_can_fork,
-- 
2.47.2


