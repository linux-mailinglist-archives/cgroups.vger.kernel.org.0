Return-Path: <cgroups+bounces-15749-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EQAIpHGAWqSjgEAu9opvQ
	(envelope-from <cgroups+bounces-15749-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776A50D54C
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A1C3300DEDE
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E939E18C;
	Mon, 11 May 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGXMaeek"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8C37B012;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501243; cv=none; b=NXlxXmQ7jifaegtlG83uqcDsa00OWddzTQhv/lxbWe3jphuGVbcqH/NdDRk06Q473i+Po48iCWpsKzjTNV+AUGW7AK249tVOX9L3AgzIcv+ZAs2niSzT9w+wrUTp0oL5ZvDFBkNAsWVLf+Trs0rxhXccKy4YyjQyuYx+AQqpm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501243; c=relaxed/simple;
	bh=l4dMnXD2h3p2MzhM1/gUhNNAztN6IxaTksmz8LwOBUg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YLjL1PZm/hOCxZGl3Nf47d5MRq401aFy3i9bfxMsgKKDY3BXVsO9Bnc5UJDjOPXoEA1+M6viH7urow/c6VS36o/DVLp8JgiZDbj9m2YIwqnsLMZ7PX8wq5Zsz7MyBz/Hfr+430uWP3e//ZU25LfnFy1w3GapfMp/kyDxOAdxrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGXMaeek; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=/hl7CkGPa8QagrOg/MoFz/yn/ve0/GzVR17AckAYuSQ=; b=BGXMaeek1XsxyUulDTaFf9TzmM
	IUan7CA+jWkMbuC6XgykuKpObERgBb1hkEAeN5MOSINx5v5WUlXKBztocx1pSlgRkLmWdk08QhMMb
	o7vP+5V6S1Wm6M2VnK7ItJXo1Lu3Exv+1d68kswTQRYqQ1L1ktXZGYLjafJDMKDSjh3cEx8pPQN6u
	u10H3m5x8+p42xBHzSil/zwyuObkdHAw74P5FQSH3bX7/iT+Dd3nLFVRcd3g1GYPQcWrycQgz31qM
	SYzkwOLBCpvIqxtGexMXUFh7AgK0oF0p1m2OITFB/N8a4vHRZyAG+LrDldBY6bsigWTZNHE6PvCsn
	Fd3hLwlg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPZ-0000000BZMo-3qaI;
	Mon, 11 May 2026 12:07:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 24D6330303E; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.710598934@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:10 +0200
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
Subject: [PATCH v2 06/10] sched/fair: Add cgroup_mode: MAX
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 6776A50D54C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15749-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

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
@@ -4100,6 +4100,21 @@ bool cpuset_cpus_allowed_fallback(struct
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
@@ -594,6 +594,7 @@ int cgroup_mode = 1;
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
 
@@ -4181,7 +4179,48 @@ static long calc_smp_shares(struct cfs_r
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
@@ -4200,6 +4239,9 @@ static long calc_group_shares(struct cfs
 	if (mode == 0)
 		return calc_up_shares(cfs_rq);
 
+	if (mode == 2)
+		return calc_max_shares(cfs_rq);
+
 	return calc_smp_shares(cfs_rq);
 }
 



