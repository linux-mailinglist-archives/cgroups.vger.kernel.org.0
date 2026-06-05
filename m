Return-Path: <cgroups+bounces-16661-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44uFIG/FImrzdQEAu9opvQ
	(envelope-from <cgroups+bounces-16661-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2366484CD
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=DbEBAgkJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16661-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16661-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8604304D902
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD43C4B88;
	Fri,  5 Jun 2026 12:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6A3BE628;
	Fri,  5 Jun 2026 12:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663417; cv=none; b=oCZ3iqHLqH8uPOo/EX/WyOI7a+CpuTdqg2T+9AFRIZvEYv+rd0mW+GrFef0ATmagnTu1KsjP/EkbBenwyZhPupMkIidR0e2g4gvcQbb1sjVnkrXMD7IUdoJEVTe/c2W7VEtEKcHscSo/XNqNtYAY0JUp0Qd+RkN7MayCmmortp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663417; c=relaxed/simple;
	bh=c4VeD7Zsnsh/unQbMVpMRZY4PeiOUexoPYPgs57H0qE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SZNiGiFJ53QZsdUFhT126vlpPVtiOVdlCD4NCcN5Ucc7fXTErMc82N4vpWDsb1k+MGZi7o2SJqtnU3WkdgLPJgiQKFG27M0CMT4UiuEqxQ0WN601S7mu50JpdvLXIyTq6QtTC0qHa39qCO3M3y9QBRb/MO97YEy/DaydFwqd92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DbEBAgkJ; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=+g4JhBB4PfZbxdVKSRhV8vLIidbqMDTAQZUEIvo+pog=; b=DbEBAgkJFcX1rGQxNeqWt4CQ++
	5eWJMCWSzlMl0d5Y693X2WbPWN3RA5AO8PUlfoZZOv2NAntEaoIfn8vWMHmwuvFJm38IFYA5rnJLT
	sCEuwbJfU4i3B6pcfndeeZHCEpa3+VuVFlmTA/5RD4mgcettt4XmPt3vgPmo4RxlqVbUQ7XraATUa
	6YFqPWayrYQ5NmrFBEk/+Kw9zOjbc8WDh3Zw9x37epjNBx4V8MQRedQhgcWK8guTtUV4L3zPyNMzQ
	tlNEg3SxWe/oK1vZVBcOU5uJw0djOv1jryZl7m1GvA4ZXZxD42rkyLAclYTjwShG9QyXQIJtqz61J
	ROWe2HLA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVTtJ-0000000FbIH-1CPx;
	Fri, 05 Jun 2026 12:43:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2D0DC302F8E; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605124051.589618504@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:16 +0200
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
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v3 3/7] sched/fair: Add cgroup_mode: max
References: <20260605105513.354837583@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16661-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:from_mime,infradead.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B2366484CD

In order to avoid the average CPU fraction avg(F_g_n) becoming tiny '1/N',
assume each cgroup is maximally concurrent and distrubute 'N*weight', such
that:

	F_g_n' = N * F_g_n

Giving:

	avg(F_g_n') = N*avg(F_g_n) ~ N * 1/N = 1

And while this sounds like it solves things, remember what that ~ meant. There
is the corner case when a cgroup is minimally loaded, eg a single runnable
task, therefore limit the CPU fraction to that of a nice -20 task to avoid
getting too much load.

This last bit is what makes it different from a previous proposal to allow
raising cpu.weight to '100 * N', that would not limit the mininal concurrency
case and results in a very large F_g_n. And just like F_g_n << 1 is
problematic, so is F_g_n >> 1 for the exact same reasons (it would drown the
kthreads, but it also risks overflowing the load values).

So while this might appear to be a better scheme than the current default
scheme, it doesn't really handle less than maximal concurrency nicely -- it
clips and introduces artificially large weights. So where the traditional SMP
mode works well when nr_tasks << nr_cpus, MAX doesn't work well in that regime
and vice-versa.

The meaning of "cpu.weight" would be: weight per allowed CPU.

Included for completeness (and infrastructure).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpuset.h |    6 +++++
 kernel/cgroup/cpuset.c |   15 ++++++++++++++
 kernel/sched/debug.c   |    1 
 kernel/sched/fair.c    |   52 ++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 69 insertions(+), 5 deletions(-)

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
@@ -4116,6 +4116,21 @@ bool cpuset_cpus_allowed_fallback(struct
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
@@ -641,6 +641,7 @@ static int cgroup_mode = 1;
 static const char *cgroup_mode_str[] = {
 	"up",
 	"smp",
+	"max",
 };
 
 static int sched_cgroup_mode(const char *str)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4801,12 +4801,10 @@ static inline int throttled_hierarchy(st
  *
  * hence icky!
  */
-static long calc_smp(struct cfs_rq *cfs_rq)
+static long __calc_smp_shares(struct cfs_rq *cfs_rq, long tg_shares, long shares_max)
 {
-	long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
-
-	tg_shares = READ_ONCE(tg->shares);
+	long tg_weight, load, shares;
 
 	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
 
@@ -4832,7 +4830,48 @@ static long calc_smp(struct cfs_rq *cfs_
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
+		if (cgrp)
+			nr = cpuset_num_cpus(cgrp);
+	}
+
+	return nr;
+}
+
+/*
+ * Func: min(fraction(nr_cpus * tg->shares), nice -20)
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
@@ -4857,6 +4896,9 @@ void __sched_cgroup_mode_update(int mode
 	default:
 		func = &calc_smp_shares;
 		break;
+	case 2:
+		func = &calc_max_shares;
+		break;
 	}
 	static_call_update(calc_group_shares, func);
 }



