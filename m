Return-Path: <cgroups+bounces-16723-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NsvkJqS0JmoebgIAu9opvQ
	(envelope-from <cgroups+bounces-16723-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF34656219
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FnUadsyq;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16723-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16723-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE3830C487B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D263C09F5;
	Mon,  8 Jun 2026 12:16:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99A3B9D84
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920971; cv=none; b=QipgDVMHOLm7PqiVXG3M9urqO+qzGP9ReU2+VFb8VoMCBPRedm6hqj3YkDm7fLWu18MMWSrB6H9jvikhcSmI3BENWqvLqvp/REbh6aALXFgTuvcmgMo9s6HRzqERNivt8t1fRoKf2VAGuA+HRbsNsQJXTAFhMX2ygx/m/HLF8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920971; c=relaxed/simple;
	bh=4H2yEEwaf4FlJ+NZqz+XGSMYyLq38zJDZ20mJLr1i5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvmPzSXQGlOePtp3TtJMLn56dTOS4hgBqFmzFr8SEkY3krmycAsrxZUZvDyb452Hw6PguPbq1HudiUfYM8wut5mbccGOQ2hTnZEunR1JArYSKm2nmzeXCdQh36DawwUDLP7Psn45NwbENIhtzyvAkdsBhsiyUGr3b6C4rxLuf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnUadsyq; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3071262f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920967; x=1781525767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mQBzqg4bAUYq8M7ta+FoS64+dFJcVYXykliMfqHR1M=;
        b=FnUadsyqTe2AumztJrxyQ53vN8eJXslafchdyQjGdfFNsNquuuDu1t7AQ0JV3LrGfj
         X/f42aMoVofSTx+sv2Hnl8pWTQLCYhmP0yvj7kCc65mIIgM7GiVD4LFJaptGXiyPDB2x
         VFadjeFz79hhBJMfkxUtQrQJf9mIV6CdxsEx4VdFXbZOPPe754KHslYqzdTkVKhrPwJ8
         aphzj/XAuzMHIG5Utn+EoaZiz7zaWfYEeFZ0glTpX8SXbJmgYhMaSso694lq3sNSt07R
         hqWvCn0g/Us05QoW3HG+ISC5WLFfv7ziKJWxs4RSyWFrP0MhZMnCHX9MrfYxrg3NhcM/
         5HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920967; x=1781525767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mQBzqg4bAUYq8M7ta+FoS64+dFJcVYXykliMfqHR1M=;
        b=nPTbWU6AjDfSlDLR7vqbKcV9/F832R0BjvluLnyDoo3gPfj+dkYNZP69c6/mOz6wqB
         tEPUoLWxLdChKSrSC6qbFPecwhyVuoq/Sqvhbq7r1Od6f8qulFT2RAn9tVga1Cqu/Nl2
         tPEjC728QC3iYA4+9SNLJHPfyOxZ9NZhXmjiA9GyODFkcqtr8VQJ9fTps3YQHnVm+y6G
         mUJks+oVt0DVunPyAKRABOas99ZIt63IaEnQXk5wXIzASLsSwGVHbjAJoXtmQjWosjJI
         WZG1vo0yRG3X4Eesm5A2OKfdM3frmhNLY6YbNgqk/IYN2lPSNO0ljDUJRcRMqAEcT+yn
         NscQ==
X-Gm-Message-State: AOJu0YzsXArEldce2zLLz4FTWZ58Ll1C/P4Q4bmxrLoHDgpN8gK/E2/8
	Lt3+rNd8RUwUJfeleEWZKhNTm4H5MxkHAfFU/cXmhDle4vkDgVxbKNHi
X-Gm-Gg: Acq92OEUFfOt9ZFmT3Qsa4GOPUWl/f69joz686uEBCP+hThgcHr5hsQgGs57hSY9qlV
	RfdePAD2bICasvRFgVWX5ftssYi1pnwWxTnnKqMkMoKv3xjmK5Fv9CKRuVcyUdtMCYoCVNxC0IE
	WrWSrI4wvfvsmZTgyYs2iExyeinvfqIiRCsAI5LMjvEhKxKTVEFnFZC8399acITFJeYnD981+t4
	jtdzaF3AUrQ+3w2qwTv2ESOqJZbmHvhUXgFxh7t4JICCM28SWpoQvMLawXXfDZWxeHskl5Mgm5M
	9dh01+EBiWH6Y7AbRQ/GpDUcxLHzTjgfr48peaMphGnLD1O2dxE5JrROcQBc7hk8XiX1z9yy40Q
	O/MkbzZITvW50EAEyTDFFlC9PBT3uItAjvJ0NHvaI53VJgO8jKktavhq4QqeIZxLCsJwvrxPhyy
	VxaewhjlCKYnpiNayuHwk41nUdIq3yXPnDwvZi9fgkHA==
X-Received: by 2002:a05:6000:1aca:b0:45e:9520:d729 with SMTP id ffacd0b85a97d-460328109c5mr19241103f8f.0.1780920966856;
        Mon, 08 Jun 2026 05:16:06 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:06 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 20/25] sched/rt: Add HCBS migration code to related functions
Date: Mon,  8 Jun 2026 14:15:39 +0200
Message-ID: <20260608121546.69910-21-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16723-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sssup.it:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BF34656219

Update rt_queue_{push/pull}_task{s} to differentiate between cgroup and
global runqueue balancing.

Introduce new balance callbacks for cgroup migration.

Add rq_to_push_from and rq_to_push_to fields for cgroup related migration.
  Balance callbacks are only called on the root runqueues, thus it is
  necessary to store which non-root runqueues need to be balanced.

Update migration functions to specialize for cgroup migration:
- find_lowest_rt_rq():
  Scan all the cpus to get the cgroup specific lowest_mask.
- find_lock_lowest_rt_rq():
  Use appropriate rt_rqs to differentiate the cgroup being checked.
  Prevent migration for throttled cgroups.
- push_rt_rq_task():
  Allow pushing away for migration disabled tasks only if the tasks
  belong to the same cgroup.
- pull_rt_rq_task():
  Use appropriate rt_rqs and push away for migration disabled only
  if the task to pull and curr are in the same runqueue.

Add tg_of_se to get the task group a scheduling entity is assigned to.
  This is different from the active context of the group.

Add new macros for field access and non-CONFIG_RT_GROUP_SCHED code.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c    | 263 ++++++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h |  26 +++++
 2 files changed, 221 insertions(+), 68 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fc7af6bda3f8..276eebe8d0a9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -364,31 +364,61 @@ static inline int has_pushable_tasks(struct rt_rq *rt_rq)

 static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
 static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_group_push_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_group_pull_head);

 static void push_rt_tasks(struct rq *);
 static void pull_rt_task(struct rq *);
+static void push_group_rt_tasks(struct rq *);
+static void pull_group_rt_task(struct rq *);

 static inline void rt_queue_push_tasks(struct rt_rq *rt_rq)
 {
-	struct rq *rq = global_rq_of_rt_rq(rt_rq);
-
-	if (is_dl_group(rt_rq))
-		return;
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct rq *global_rq = global_rq_of_rt_rq(rt_rq);

 	if (!has_pushable_tasks(rt_rq))
 		return;

-	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
+	if (!rt_group_sched_enabled() || !is_dl_group(rt_rq)) {
+
+		queue_balance_callback(global_rq,
+				       &per_cpu(rt_push_head, rq->cpu),
+				       push_rt_tasks);
+	} else {
+
+		if (rq_to_push_from(global_rq))
+			return;
+
+		rq_to_push_from(global_rq) = rq;
+		queue_balance_callback(global_rq,
+				       &per_cpu(rt_group_push_head, global_rq->cpu),
+				       push_group_rt_tasks);
+	}
 }

 static inline void rt_queue_pull_task(struct rt_rq *rt_rq)
 {
-	struct rq *rq = global_rq_of_rt_rq(rt_rq);
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct rq *global_rq = global_rq_of_rt_rq(rt_rq);
+	struct sched_dl_entity *dl_se;

-	if (is_dl_group(rt_rq))
-		return;
+	if (!rt_group_sched_enabled() || !is_dl_group(rt_rq)) {

-	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
+		queue_balance_callback(global_rq,
+				       &per_cpu(rt_pull_head, rq->cpu),
+				       pull_rt_task);
+	} else {
+
+		dl_se = dl_group_of(rt_rq);
+		if (dl_se->dl_throttled || rq_to_pull_to(global_rq))
+			return;
+
+		rq_to_pull_to(global_rq) = rq;
+		queue_balance_callback(global_rq,
+				       &per_cpu(rt_group_pull_head, global_rq->cpu),
+				       pull_group_rt_task);
+	}
 }

 static void push_rt_rq_tasks(struct rt_rq *rt_rq);
@@ -403,6 +433,27 @@ static void pull_rt_task(struct rq *global_rq) {
 	pull_rt_rq_task(&global_rq->rt);
 }

+static void push_group_rt_tasks(struct rq *global_rq)
+{
+	struct rq *rq = rq_to_push_from(global_rq);
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (rt_rq->rt_nr_running <= 1 && !dl_group_of(rt_rq)->dl_throttled)
+		return;
+
+	push_rt_rq_tasks(rt_rq);
+	rq_to_push_from(global_rq) = NULL;
+}
+
+static void pull_group_rt_task(struct rq *global_rq)
+{
+	struct rq *rq = rq_to_pull_to(global_rq);
+	struct rt_rq *rt_rq = &rq->rt;
+
+	pull_rt_rq_task(rt_rq);
+	rq_to_pull_to(global_rq) = NULL;
+}
+
 static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
 	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
@@ -1220,35 +1271,71 @@ static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
 static int find_lowest_rt_rq(struct task_struct *task)
 {
 	struct sched_domain *sd;
-	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
-	int this_cpu = smp_processor_id();
-	int cpu      = task_cpu(task);
-	int ret;
-
-	/* Make sure the mask is initialized first */
-	if (unlikely(!lowest_mask))
-		return -1;
+	struct cpumask mask, *lowest_mask;
+	struct sched_dl_entity *dl_se;
+	struct rt_rq *rt_rq, *task_rt_rq = rt_rq_of_se(&task->rt);
+	int cpu, this_cpu = smp_processor_id();
+	int ret, prio, lowest_prio;

 	if (task->nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */

-	/*
-	 * If we're on asym system ensure we consider the different capacities
-	 * of the CPUs when searching for the lowest_mask.
-	 */
-	if (sched_asym_cpucap_active()) {
+	if (!rt_group_sched_enabled() || !is_dl_group(task_rt_rq)) {
+
+		lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);

-		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
-					  task, lowest_mask,
-					  rt_task_fits_capacity);
+		/* Make sure the mask is initialized first */
+		if (unlikely(!lowest_mask))
+			return -1;
+
+		/*
+		* If we're on asym system ensure we consider the different
+		* capacities of the CPUs when searching for the lowest_mask.
+		*/
+		if (sched_asym_cpucap_active()) {
+
+			ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
+						  task, lowest_mask,
+						  rt_task_fits_capacity);
+		} else {
+
+			ret = cpupri_find(&task_rq(task)->rd->cpupri,
+					  task, lowest_mask);
+		}
+
+		if (!ret)
+			return -1; /* No targets found */
 	} else {

-		ret = cpupri_find(&task_rq(task)->rd->cpupri,
-				  task, lowest_mask);
+		lowest_prio = task->prio - 1;
+		lowest_mask = &mask;
+		cpumask_clear(lowest_mask);
+		for_each_cpu_and(cpu, cpu_online_mask, task->cpus_ptr) {
+			dl_se = dl_se_of_tg(task_rt_rq->tg, cpu);
+			rt_rq = &dl_se->my_q->rt;
+			prio = rt_rq->highest_prio.curr;
+
+			/*
+			* If we're on asym system ensure we consider the
+			* different capacities of the CPUs when searching for
+			* the lowest_mask.
+			*/
+			if (dl_se->dl_throttled || !rt_task_fits_capacity(task, cpu))
+				continue;
+
+			if (prio >= lowest_prio) {
+				if (prio > lowest_prio) {
+					cpumask_clear(lowest_mask);
+					lowest_prio = prio;
+				}
+
+				cpumask_set_cpu(cpu, lowest_mask);
+			}
+		}
 	}

-	if (!ret)
-		return -1; /* No targets found */
+	if (cpumask_empty(lowest_mask))
+		return -1;

 	/*
 	 * At this point we have built a mask of CPUs representing the
@@ -1258,6 +1345,7 @@ static int find_lowest_rt_rq(struct task_struct *task)
 	 * We prioritize the last CPU that the task executed on since
 	 * it is most likely cache-hot in that location.
 	 */
+	cpu = task_cpu(task);
 	if (cpumask_test_cpu(cpu, lowest_mask))
 		return cpu;

@@ -1268,30 +1356,27 @@ static int find_lowest_rt_rq(struct task_struct *task)
 	if (!cpumask_test_cpu(this_cpu, lowest_mask))
 		this_cpu = -1; /* Skip this_cpu opt if not among lowest */

-	rcu_read_lock();
-	for_each_domain(cpu, sd) {
-		if (sd->flags & SD_WAKE_AFFINE) {
+	scoped_guard(rcu) {
+		for_each_domain(cpu, sd) {
 			int best_cpu;

+			if (!(sd->flags & SD_WAKE_AFFINE))
+				continue;
+
 			/*
 			 * "this_cpu" is cheaper to preempt than a
 			 * remote processor.
 			 */
 			if (this_cpu != -1 &&
-			    cpumask_test_cpu(this_cpu, sched_domain_span(sd))) {
-				rcu_read_unlock();
+			    cpumask_test_cpu(this_cpu, sched_domain_span(sd)))
 				return this_cpu;
-			}

 			best_cpu = cpumask_any_and_distribute(lowest_mask,
 							      sched_domain_span(sd));
-			if (best_cpu < nr_cpu_ids) {
-				rcu_read_unlock();
+			if (best_cpu < nr_cpu_ids)
 				return best_cpu;
-			}
 		}
 	}
-	rcu_read_unlock();

 	/*
 	 * And finally, if there were no matches within the domains
@@ -1342,27 +1427,35 @@ static struct task_struct *pick_next_pushable_task(struct rt_rq *rt_rq)
 /* Will lock the rq it finds */
 static struct rt_rq *find_lock_lowest_rt_rq(struct task_struct *task, struct rt_rq *rt_rq)
 {
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-	struct rq *lowest_rq = NULL;
-	int tries;
-	int cpu;
+	struct rq *lowest_rq, *rq = global_rq_of_rt_rq(rt_rq);
+	struct rt_rq *lowest_rt_rq;
+	struct sched_dl_entity *lowest_dl_se;
+	int tries, cpu;
+	bool dl_group;
+
+	dl_group = rt_group_sched_enabled() && is_dl_group(rt_rq);

 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
 		cpu = find_lowest_rt_rq(task);

 		if ((cpu == -1) || (cpu == rq->cpu))
-			break;
+			return NULL;

 		lowest_rq = cpu_rq(cpu);
+		if (dl_group) {
+			lowest_dl_se = dl_se_of_tg(rt_rq->tg, cpu);
+			lowest_rt_rq = &lowest_dl_se->my_q->rt;
+		} else {
+			lowest_rt_rq = &lowest_rq->rt;
+		}

-		if (lowest_rq->rt.highest_prio.curr <= task->prio) {
+		if (lowest_rt_rq->highest_prio.curr <= task->prio) {
 			/*
 			 * Target rq has tasks of equal or higher priority,
 			 * retrying does not release any lock and is unlikely
 			 * to yield a different result.
 			 */
-			lowest_rq = NULL;
-			break;
+			return NULL;
 		}

 		/* if the prio of this runqueue changed, try again */
@@ -1378,25 +1471,24 @@ static struct rt_rq *find_lock_lowest_rt_rq(struct task_struct *task, struct rt_
 			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(is_migration_disabled(task) ||
+				     (dl_group && lowest_dl_se->dl_throttled) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task != pick_next_pushable_task(rt_rq))) {

 				double_unlock_balance(rq, lowest_rq);
-				lowest_rq = NULL;
-				break;
+				return NULL;
 			}
 		}

 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
-			break;
+		if (lowest_rt_rq->highest_prio.curr > task->prio)
+			return lowest_rt_rq;

 		/* try again */
 		double_unlock_balance(rq, lowest_rq);
-		lowest_rq = NULL;
 	}

-	return &lowest_rq->rt;
+	return NULL;
 }

 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq) {
@@ -1413,12 +1505,10 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq) {
 static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 {
 	struct task_struct *next_task;
-	struct rq *lowest_rq, *rq = rq_of_rt_rq(rt_rq);
+	struct rq *lowest_rq, *rq = global_rq_of_rt_rq(rt_rq);
 	struct rt_rq *lowest_rt_rq;
 	int ret = 0;
-
-	if (is_dl_group(rt_rq))
-		return 0;
+	bool dl_group;

 	if (!rt_rq->overloaded)
 		return 0;
@@ -1433,7 +1523,8 @@ static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->donor->prio)) {
+	dl_group = rt_group_sched_enabled() && is_dl_group(rt_rq);
+	if (!dl_group && unlikely(next_task->prio < rq->donor->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -1445,6 +1536,13 @@ static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 		if (!pull || rq->push_busy)
 			return 0;

+		/*
+		 * If the current task does not belong to the same task group
+		 * we cannot push it away.
+		 */
+		if (dl_group && rq->donor->sched_task_group != rt_rq->tg)
+			return 0;
+
 		/*
 		 * Invoking find_lowest_rt_rq() on anything but an RT task doesn't
 		 * make sense. Per the above priority check, curr has to
@@ -1521,7 +1619,7 @@ static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 		goto retry;
 	}

-	lowest_rq = rq_of_rt_rq(lowest_rt_rq);
+	lowest_rq = global_rq_of_rt_rq(lowest_rt_rq);
 	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
@@ -1718,16 +1816,22 @@ void rto_push_irq_work_func(struct irq_work *work)

 static void pull_rt_rq_task(struct rt_rq *this_rt_rq)
 {
-	struct rq *this_rq = rq_of_rt_rq(this_rt_rq);
+	struct rq* this_rq = global_rq_of_rt_rq(this_rt_rq);
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
-	struct task_struct *p, *push_task;
+	struct task_struct *p, *push_task = NULL;
+	struct sched_dl_entity *src_dl_se;
 	struct rt_rq *src_rt_rq;
 	struct rq *src_rq;
-	int rt_overload_count = rt_overloaded(this_rq);
+	int rt_overload_count;
+	const struct cpumask *cpu_mask;
+	bool dl_group;

-	if (is_dl_group(&this_rq->rt))
-		return;
+	dl_group = rt_group_sched_enabled() && is_dl_group(this_rt_rq);
+	if (dl_group)
+		goto group_sched;
+
+	rt_overload_count = rt_overloaded(this_rq);

 	if (likely(!rt_overload_count))
 		return;
@@ -1750,12 +1854,26 @@ static void pull_rt_rq_task(struct rt_rq *this_rt_rq)
 	}
 #endif

-	for_each_cpu(cpu, this_rq->rd->rto_mask) {
+group_sched:
+	if (!dl_group)
+		cpu_mask = this_rq->rd->rto_mask;
+	else
+		cpu_mask = cpu_online_mask;
+
+	for_each_cpu(cpu, cpu_mask) {
 		if (this_cpu == cpu)
 			continue;

 		src_rq = cpu_rq(cpu);
-		src_rt_rq = &src_rq->rt;
+		if (!dl_group) {
+			src_rt_rq = &src_rq->rt;
+		} else {
+			src_dl_se = dl_se_of_tg(this_rt_rq->tg, cpu);
+			src_rt_rq = &src_dl_se->my_q->rt;
+
+			if (src_rt_rq->rt_nr_running <= 1 && !src_dl_se->dl_throttled)
+				continue;
+		}

 		/*
 		 * Don't bother taking the src_rq->lock if the next highest
@@ -1796,12 +1914,21 @@ static void pull_rt_rq_task(struct rt_rq *this_rt_rq)
 			 * This is just that p is waking up and hasn't
 			 * had a chance to schedule. We only pull
 			 * p if it is lower in priority than the
-			 * current task on the run queue
+			 * current task on the run queue and p is
+			 * in the same runqueue as donor.
 			 */
-			if (p->prio < src_rq->donor->prio)
+			if (tg_of_se(&src_rq->donor->rt) == this_rt_rq->tg &&
+			    p->prio < src_rq->donor->prio)
 				goto skip;

 			if (is_migration_disabled(p)) {
+				/*
+				 * If the current task does not belong to the
+				 * same task group we cannot push it away.
+				 */
+				if (tg_of_se(&src_rq->donor->rt) != this_rt_rq->tg)
+					goto skip;
+
 				push_task = get_push_task(src_rq);
 			} else {
 				move_queued_task_locked(src_rq, this_rq, p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 53248cbbeaf8..3acc88a035a5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1341,6 +1341,16 @@ struct rq {
 	struct list_head	cfsb_csd_list;
 #endif

+#ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * Balance callbacks operate only on global runqueues.
+	 * These pointers allow referencing cgroup specific runqueues
+	 * for balancing operations.
+	 */
+	struct rq		*rq_to_push_from;
+	struct rq		*rq_to_pull_to;
+#endif
+
 	atomic_t		nr_iowait;
 } __no_randomize_layout;

@@ -3366,6 +3376,11 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 	return rt_se->rt_rq;
 }

+static inline struct task_group *tg_of_se(struct sched_rt_entity *rt_se)
+{
+	return rt_rq_of_se(rt_se)->tg;
+}
+
 static inline int is_dl_group(struct rt_rq *rt_rq)
 {
 	return rt_rq->tg != &root_task_group;
@@ -3382,6 +3397,9 @@ static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
 	return rt_rq->tg->dl_se[rq_of_rt_rq(rt_rq)->cpu];
 }

+#define rq_to_push_from(rq) ((rq)->rq_to_push_from)
+#define rq_to_pull_to(rq) ((rq)->rq_to_pull_to)
+#define dl_se_of_tg(tg, cpu) ((tg)->dl_se[(cpu)])
 #define dl_bw_lock_of_tg(tg) (&(tg)->dl_bandwidth.dl_runtime_lock)
 #else
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
@@ -3406,6 +3424,11 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 	return &rq->rt;
 }

+static inline struct task_group *tg_of_se(struct sched_rt_entity *rt_se)
+{
+	return &root_task_group;
+}
+
 static inline int is_dl_group(struct rt_rq *rt_rq)
 {
 	return 0;
@@ -3416,6 +3439,9 @@ static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
 	return NULL;
 }

+#define rq_to_push_from(rq) (rq)
+#define rq_to_pull_to(rq) (rq)
+#define dl_se_of_tg(tg, cpu) ((struct sched_dl_entity*)NULL)
 #define dl_bw_lock_of_tg(tg) ((raw_spinlock_t*)NULL)
 #endif

--
2.54.0


