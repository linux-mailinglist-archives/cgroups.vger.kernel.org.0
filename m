Return-Path: <cgroups+bounces-14844-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNVsEJ0xuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14844-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:49:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B32A83F0
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09830306A388
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF13A6F10;
	Tue, 17 Mar 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivcBvy+Y"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FF36F409;
	Tue, 17 Mar 2026 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744470; cv=none; b=p00bSpEKjwpdOysDkVh0lcHM9LrvZyOvyWWmX8NhqyBH1K7xxu3FTO/tENWVhcd533rmlnisc07OwOBQ4bX233mmtGz7MWMCKvaHA5Trd1CNfalsn7rnrUaNcRbJ4MsnyrgLdsNEK0TwwexxdlrHfka92cIbUSmwSysm72tco2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744470; c=relaxed/simple;
	bh=Njtr4wetw4qnMu7EczptHyAJpUMZpiLKP/9d7iDF+C8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C+x7gQPovE0guaaWfN6x9rBQCstihOBJLGv3EYGUOc8IhbaEYusgVv/ud0GuSqGr0J39vk2uApu2no8qcZ0InPlq8OfEzD73UgvpuQdni0W3fFZB1hE6Cp77SxYlsvbIx7gouU5sZH+b6NWTQGFnawcY3HTb1EMHnpSD6ah3vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ivcBvy+Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1UIIxXcXTofvHqmLg2jEeMe7ZJOig4GgUp8eZAjd+Bo=; b=ivcBvy+Y1L1R2I5qROLM6gFZvt
	NG8FMMhjDoY77MzqUbshJubV6PWQcbZjZ7gfxDddkoRr6BBna0FdQdARZ5g2Vofm91A9X5RhH6yCT
	EmgyuTYh6VVwYS6wggjvIR1oHfOiHOdlUYIBrVbeQRb+OcE/ngbY9I7+qTwOxQGVma39e8OhRRvat
	jfZL2ojofWsi2Npd1BSzEIyGv4/gcXB+2i6uB/cm8gLD05JIFJyRpuhezj8WSsx9J7H+4SPi8IQlQ
	ntLRBVIMoXhd9kM/kfWrSiRpINzKAFiS5QUVgISBKOpd+ppZmxRGle9HU1cjauELzwgpyDzhn1Mpy
	JAVFoD5Q==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000002YWo-0rFg;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2624D3032C7; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104342.815599388@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 4/8] sched/fair: Add cgroup_mode: MAX
References: <20260317095113.387450089@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14844-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE3B32A83F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to avoid the CPU shares becoming tiny '1 / nr_cpus', assume each
cgroup is maximally concurrent and distrubute 'nr_cpus * tg->shares',
such that each CPU ends up with a 'tg->shares' sized fraction (on
average).

There is the corner case, when a cgroup is minimally loaded, eg a
single spinner, therefore limit the CPU shares to that of a nice -20
task to avoid getting too much load.

It was previously suggested to allow raising cpu.weight to '100 * nr_cpus'
to combat this same problem, but the problem there is the above corner case,
allowing multiple cgroups with such immense weight to the runqueue has
significant problems.

It would drown the kthreads, but it also risks overflowing the load values.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpuset.h |    6 +++++
 kernel/cgroup/cpuset.c |   15 ++++++++++++++
 kernel/sched/debug.c   |    1 
 kernel/sched/fair.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 67 insertions(+), 5 deletions(-)

--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -80,6 +80,7 @@ extern void lockdep_assert_cpuset_lock_h
 extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern int cpuset_num_cpus(struct cgroup *cgroup);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -216,6 +217,11 @@ static inline bool cpuset_cpus_allowed_f
 	return false;
 }
 
+static inline int cpuset_num_cpus(struct cgroup *cgroup)
+{
+	return num_online_cpus();
+}
+
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 {
 	return node_possible_map;
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4097,6 +4097,21 @@ bool cpuset_cpus_allowed_fallback(struct
 	return changed;
 }
 
+int cpuset_num_cpus(struct cgroup *cgrp)
+{
+	int nr = num_online_cpus();
+	struct cpuset *cs;
+
+	if (is_in_v2_mode()) {
+		guard(rcu)();
+		cs = css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
+		if (cs)
+			nr = cpumask_weight(cs->effective_cpus);
+	}
+
+	return nr;
+}
+
 void __init cpuset_init_current_mems_allowed(void)
 {
 	nodes_setall(current->mems_allowed);
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -593,6 +593,7 @@ int cgroup_mode = 1;
 static const char *cgroup_mode_str[] = {
 	"up",
 	"smp",
+	"max",
 };
 
 static int sched_cgroup_mode(const char *str)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4150,12 +4150,10 @@ static inline int throttled_hierarchy(st
  *
  * hence icky!
  */
-static long calc_smp_shares(struct cfs_rq *cfs_rq)
+static long __calc_smp_shares(struct cfs_rq *cfs_rq, long tg_shares, long shares_max)
 {
-	long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
-
-	tg_shares = READ_ONCE(tg->shares);
+	long tg_weight, load, shares;
 
 	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
 
@@ -4181,7 +4179,47 @@ static long calc_smp_shares(struct cfs_r
 	 * case no task is runnable on a CPU MIN_SHARES=2 should be returned
 	 * instead of 0.
 	 */
-	return clamp_t(long, shares, MIN_SHARES, tg_shares);
+	return clamp_t(long, shares, MIN_SHARES, shares_max);
+}
+
+static int tg_cpus(struct task_group *tg)
+{
+	int nr = num_online_cpus();
+
+	if (cpusets_enabled()) {
+		struct cgroup *cgrp = tg->css.cgroup;
+		nr = cpuset_num_cpus(cgrp);
+	}
+
+	return nr;
+}
+
+/*
+ * Func: min(fraction(num_cpus * tg->shares), nice -20)
+ *
+ * Scale tg->shares by the maximal number of CPUs; but clip the max shares at
+ * nice -20, otherwise a single spinner on a 512 CPU machine would result in
+ * 512*NICE_0_LOAD, which is also crazy.
+ */
+static long calc_max_shares(struct cfs_rq *cfs_rq)
+{
+	struct task_group *tg = cfs_rq->tg;
+	int nr = tg_cpus(tg);
+	long tg_shares = READ_ONCE(tg->shares);
+	long max_shares = scale_load(sched_prio_to_weight[0]);
+	return __calc_smp_shares(cfs_rq, tg_shares * nr, max_shares);
+}
+
+/*
+ * Func: fraction(tg->shares)
+ *
+ * This infamously results in tiny shares when you have many CPUs.
+ */
+static long calc_smp_shares(struct cfs_rq *cfs_rq)
+{
+	struct task_group *tg = cfs_rq->tg;
+	long tg_shares = READ_ONCE(tg->shares);
+	return __calc_smp_shares(cfs_rq, tg_shares, tg_shares);
 }
 
 /*
@@ -4197,6 +4235,8 @@ static long calc_group_shares(struct cfs
 {
 	if (cgroup_mode == 0)
 		return calc_up_shares(cfs_rq);
+	if (cgroup_mode == 2)
+		return calc_max_shares(cfs_rq);
 
 	return calc_smp_shares(cfs_rq);
 }



