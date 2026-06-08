Return-Path: <cgroups+bounces-16712-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AiOqIwy0Jmr9bQIAu9opvQ
	(envelope-from <cgroups+bounces-16712-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:22:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F306561C0
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Aptk6nj9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16712-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16712-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 491AA300CBFE
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED3937F742;
	Mon,  8 Jun 2026 12:16:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3837B007
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920961; cv=none; b=mIRFq3yi/O2JmyHlY5yPCBGdGMax08ZQ6/k7mZ8uHDjKtDlO2SyWGqT8WwkhlCWWj0uxmivPRMNUFvEd94U/abkK/RDAYBynsuqR69KSDwreqyV8hJ8Ybt/ZA478fBUx7NkliYhdwGrRNjftzp+GCklG7aJoLa9b7MqPjFIHmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920961; c=relaxed/simple;
	bh=KkBlQItDzOxsEF4Lf2x1Vu8P1jr7Y12pNbksjdoe9ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHEolxuzf5gNr7R86OQL+BFlegURuNaLEj/lbxF4h0vqBWUyNse6pEentsT883C+KHUWQUMf8BcJW2/5ze7P1Mz8z2F9NAsJ2aJsUA+Bts6JlcQoj05nqTgpeSsmR8E+w/mJ05+LZaaIDH3jXwJ6AljTfsqTrhkn+z7mNQFbAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aptk6nj9; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45fd464d51fso2256810f8f.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920957; x=1781525757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9vcVMFYUZttChdRfBEuCYgVvxDq81TU4GOQktFMuTQ=;
        b=Aptk6nj9m4xxXHcmapgGRkukt1Ue1W+w2HY2PGV+XbiC0PQD2SimUAztUdisJJIG/c
         2oMjSNP7mrIrGC2YZpn/2ro3lloCN/UoqEsUgJm3Y1seVYoPBiibRfk4eo8/9XkLYpwd
         0TygqORMCYzgi/8ILAUKY5M71p+uiDzS4kHSrMRWJgzrCnV8dbpwGQeFC4gmpPhV5ifs
         ye6P8KvFBmkoq2oqkyYB5+k2l+10TzcHJ3OTF+D48gE+ozwMKYmcDWTey0ZXAu5DkwG9
         Z7Cwlenra+T5e2Mwv8xPtqXsWTYM0CXnsFVtovu8NxbNPNRyXkJGeMUlnBlyFxaTSxBw
         SdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920957; x=1781525757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9vcVMFYUZttChdRfBEuCYgVvxDq81TU4GOQktFMuTQ=;
        b=Wbeh859EQuEi0srxajAmG3i0m0A51WeOtw/vPhlSyebdyHY70+Iy4KcYd3/b3+Y6Kq
         IMw53PkGEhx8zIFfp9gczBAjuygyrNq9OqNVBvf6gkBxkuBddBaSfMegKUmvXpR19wK2
         BuhZAf3of3j7MCcqOmjhkDb3MSlyFahfu+senhOc96cDk72467DyngLnw18LDjeWXUN6
         MdKC2SZdI6GR7QiEp2Wgqtqu661ULIGzclfcYMejmvR+tCp+vKEQpR0yogeaOD3o+T8Y
         aBYDGzU31vwITn7R3gztFP0/mxoftZUZ0uP0z+TsrNPz+7XcFXNuC4vHb3mhSVX4iKnV
         mNuQ==
X-Gm-Message-State: AOJu0Yz0VH4wWQVTxj0SN5tVl2vG3XACeGbHmsG3gLn8r5wpVQFg1b1E
	43dWSUIUobXk439J6RS2dJK9TRcV3v+YRPzUKNmlHGdR5sSWa9ETAFby
X-Gm-Gg: Acq92OGQBQSFzeWwTatmldxj67+sVF+JhPBk7m0SlYTyR37iHGtKncfYjsaqo70S2sx
	PHLX0Mu15Ki5zv1eWNg793NuXxDNDxWxIQYFyYA8cy4IL4aYXudargWeBXhjnPz+zBYdxpe3D2b
	ylJW+sPn64xBxydSA0Dc51ZUW3I+Y6zc2w0a47MPXkmOFL4bA61Funf3pWhlTP9aYR54cZwVHb0
	QHQR4AeH7D3rsNUwohFaIdl3sXC71l1T3+U8ZTu6voSgq/H6uG3O5EPLigPHv2NmtWGqM0aV960
	zytg5xVW77vHjWiaExs1A8PCIasEBj2+hFOn/9crggsBtaGjTh4BWwrNMAPRtrsoKY8OxgBMrEa
	AOMtRmoHnfy/DdCiUUuoyzO2sOW8W8tmsr6VvoLXYuEDQf8A5qX0KYF7UZ2hAeRWYSh6C6c+owh
	m6y9TxLBlL7+PAhvo6n03eA/cf2MAV5fw=
X-Received: by 2002:a05:6000:2990:20b0:460:25f3:b25a with SMTP id ffacd0b85a97d-460306301bdmr16257882f8f.34.1780920957342;
        Mon, 08 Jun 2026 05:15:57 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:57 -0700 (PDT)
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
Subject: [RFC PATCH v6 10/25] sched/core: Initialize HCBS specific structures.
Date: Mon,  8 Jun 2026 14:15:29 +0200
Message-ID: <20260608121546.69910-11-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16712-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sssup.it:email,santannapisa.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8F306561C0

From: luca abeni <luca.abeni@santannapisa.it>

Update autogroups' creation/destruction to use the new data structures.

Initialize the default bandwidth for rt-cgroups (sched_init).

Initialize rt-scheduler's specific data structures for the root control
group (sched_init).

Remove init_tg_rt_entry in favour of manual setup of the necessary data
structures in sched_init.

Add utility functions to check (and get) if a rt_rq entity is connected
to a rt-cgroup.

Add read/write accessors for dl_bandwidth.

Add dl_bw_lock_of_tg macro to reference the a task group dl_bandwidth's
spinlock.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/autogroup.c |  4 ++--
 kernel/sched/core.c      | 11 ++++++++--
 kernel/sched/deadline.c  | 11 ++++++++++
 kernel/sched/rt.c        | 45 ++++++++++++++++++++++++++++------------
 kernel/sched/sched.h     | 38 ++++++++++++++++++++++++++++++---
 5 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index e380cf9372bb..2122a0740a19 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -52,7 +52,7 @@ static inline void autogroup_destroy(struct kref *kref)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	/* We've redirected RT tasks to the root task group... */
-	ag->tg->rt_se = NULL;
+	ag->tg->dl_se = NULL;
 	ag->tg->rt_rq = NULL;
 #endif
 	sched_release_group(ag->tg);
@@ -109,7 +109,7 @@ static inline struct autogroup *autogroup_create(void)
 	 * the policy change to proceed.
 	 */
 	free_rt_sched_group(tg);
-	tg->rt_se = root_task_group.rt_se;
+	tg->dl_se = root_task_group.dl_se;
 	tg->rt_rq = root_task_group.rt_rq;
 #endif /* CONFIG_RT_GROUP_SCHED */
 	tg->autogroup = ag;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e38ca8192d2d..9e47a02cfaf7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8911,7 +8911,7 @@ void __init sched_init(void)
 		scx_tg_init(&root_task_group);
 #endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+		root_task_group.dl_se = (struct sched_dl_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.rt_rq = (struct rt_rq **)ptr;
@@ -8922,6 +8922,11 @@ void __init sched_init(void)
 
 	init_defrootdomain();
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	init_dl_bandwidth(&root_task_group.dl_bandwidth,
+			  global_rt_period(), 0, &root_task_group);
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
 
@@ -8973,7 +8978,9 @@ void __init sched_init(void)
 		 * starts working after scheduler_running, which is not the case
 		 * yet.
 		 */
-		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
+		rq->rt.tg = &root_task_group;
+		root_task_group.rt_rq[i] = &rq->rt;
+		root_task_group.dl_se[i] = NULL;
 #endif
 		rq->next_class = &idle_sched_class;
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c12882348a03..673c6f2b5ece 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -508,6 +508,17 @@ static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
+void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime,
+		       struct task_group *active_context)
+{
+	raw_spin_lock_init(&dl_b->dl_runtime_lock);
+	dl_b->dl_period = period;
+	dl_b->dl_runtime = runtime;
+	dl_b->dl_internal_runtime = 0;
+	dl_b->active_context = active_context;
+}
+
+
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4575c234ae46..dbba7a57d6f1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -86,26 +86,47 @@ void init_rt_rq(struct rt_rq *rt_rq)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 
-void unregister_rt_sched_group(struct task_group *tg)
+DEFINE_MUTEX(rt_constraints_mutex);
+
+const struct dl_bandwidth *dl_bandwidth_read(struct task_group *tg)
 {
+	int held;
+
+	if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks) {
+		held = 0;
+		if (lockdep_is_held(&rt_constraints_mutex)) {
+			__assume_ctx_lock(&rt_constraints_mutex);
+			held = 1;
+		}
+
+		if (lockdep_is_held(dl_bw_lock_of_tg(tg))) {
+			__assume_ctx_lock(dl_bw_lock_of_tg(tg));
+			held = 1;
+		}
 
+		lockdep_assert(held);
+	}
+
+	return (const struct dl_bandwidth *)&tg->dl_bandwidth;
 }
 
-void free_rt_sched_group(struct task_group *tg)
+struct dl_bandwidth *dl_bandwidth_write(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
-		return;
+	lockdep_assert_held(&rt_constraints_mutex);
+	lockdep_assert_held(dl_bw_lock_of_tg(tg));
+
+	return &tg->dl_bandwidth;
 }
 
-void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent)
+void unregister_rt_sched_group(struct task_group *tg)
 {
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->tg = tg;
 
-	tg->rt_rq[cpu] = rt_rq;
-	tg->rt_se[cpu] = rt_se;
+}
+
+void free_rt_sched_group(struct task_group *tg)
+{
+	if (!rt_group_sched_enabled())
+		return;
 }
 
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
@@ -1802,8 +1823,6 @@ DEFINE_SCHED_CLASS(rt) = {
 /*
  * Ensure that the real time constraints are schedulable.
  */
-static DEFINE_MUTEX(rt_constraints_mutex);
-
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
 	struct task_struct *task;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3c259ab9344..0ba87be1c98f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -606,9 +606,6 @@ extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent);
 extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
@@ -2926,6 +2923,8 @@ extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
+extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime,
+			      struct task_group *active_context);
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 extern void init_cfs_throttle_work(struct task_struct *p);
@@ -3349,6 +3348,9 @@ extern void set_rq_offline(struct rq *rq);
 
 extern bool sched_smp_initialized;
 
+extern const struct dl_bandwidth *dl_bandwidth_read(struct task_group *tg);
+extern struct dl_bandwidth *dl_bandwidth_write(struct task_group *tg);
+
 #ifdef CONFIG_RT_GROUP_SCHED
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
@@ -3372,6 +3374,24 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
 	return rt_se->rt_rq;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return rt_rq->tg != &root_task_group;
+}
+
+/*
+ * Return the scheduling entity of this group of tasks.
+ */
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	if (WARN_ON_ONCE(!is_dl_group(rt_rq)))
+		return NULL;
+
+	return rt_rq->tg->dl_se[rq_of_rt_rq(rt_rq)->cpu];
+}
+
+#define dl_bw_lock_of_tg(tg) (&(tg)->dl_bandwidth.dl_runtime_lock)
 #else
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
@@ -3394,6 +3414,18 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 
 	return &rq->rt;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return 0;
+}
+
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	return NULL;
+}
+
+#define dl_bw_lock_of_tg(tg) ((raw_spinlock_t*)NULL)
 #endif
 
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
-- 
2.54.0


