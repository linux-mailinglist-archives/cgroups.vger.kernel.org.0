Return-Path: <cgroups+bounces-15382-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAO7CXnq5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15382-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:09:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB84435C69
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD993051160
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3518367F31;
	Tue, 21 Apr 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4rk2yEY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D7364931
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740736; cv=none; b=olLNN6CEmCEjoUf9j6tNcbfoVQIyTeaQQG8w5jUh1gxtP3WOqHu4mbdWry3OfpCsfmsQSikCMXFMPSu/rJxpnpZJxhKM2DQNpXU6oEn9nGb2vCIxGusRogAiCeEQBe4g3BpVIhSNoktVZ0FyNYurac7KWzKZ/fKIoHbwhah4444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740736; c=relaxed/simple;
	bh=AAudttYRisFlY5Ez9Un7A1GLFdgmsNoB8kueTD7e+vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBJcG8hH9gSIYJfHZ3JjZWRg0eHC8qXPQZaCmh1nvhCIh2Hg1ckX9FGsVJsw4AK+oNPGgIK35VIWYkJGhQresQd/OgQpObUHr+7h6fdN1VXJWYlkFnEb9bRcxea3p0VwokD7aDmo9g3oKyaneJJ5wUkaNuSuIOblUVmgaej3UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4rk2yEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQwM3QXUNwSlfxVNwPQNRKjpWMNQLGduAjCpqdPCyps=;
	b=H4rk2yEYyglGD02kRnTF8qMmhV4rH2Ic/SNMqakN5QhnWi60/H/V7QnCUmkdJJIigVYblH
	fQ2tp6zrB1g3yYDOQAGPJiBMAmn5k2Lmr6ABGL3DPjlq9wIex6mrIEi0RStW4I4+2JT7Ru
	+wfe1WTPKsFEZnAv9qDA/koXGgf/Srs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-J0hBtGLTO-KlPDV8avLGEg-1; Mon,
 20 Apr 2026 23:05:29 -0400
X-MC-Unique: J0hBtGLTO-KlPDV8avLGEg-1
X-Mimecast-MFC-AGG-ID: J0hBtGLTO-KlPDV8avLGEg_1776740725
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D69719560B4;
	Tue, 21 Apr 2026 03:05:24 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 384F31955F21;
	Tue, 21 Apr 2026 03:05:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 04/23] tick/nohz: Allow runtime changes in full dynticks CPUs
Date: Mon, 20 Apr 2026 23:03:32 -0400
Message-ID: <20260421030351.281436-5-longman@redhat.com>
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15382-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EB84435C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Full dynticks can only be enabled if "nohz_full" boot option has been
been specified with or without parameter. Any change in the list of
nohz_full CPUs have to be reflected in tick_nohz_full_mask. Introduce
a new tick_nohz_full_update_cpus() helper that can be called to update
the tick_nohz_full_mask at run time. The housekeeping_update() function
is modified to call the new helper when the HK_TYPE_KERNEL_NOSIE cpumask
is going to be changed.

We also need to enable CPU context tracking for those CPUs that
are in tick_nohz_full_mask. So remove __init from tick_nohz_init()
and ct_cpu_track_user() so that they be called later when an isolated
cpuset partition is being created. The __ro_after_init attribute is
taken away from context_tracking_key as well.

Also add a new ct_cpu_untrack_user() function to reverse the action of
ct_cpu_track_user() in case we need to disable the nohz_full mode of
a CPU.

With nohz_full enabled, the boot CPU (typically CPU 0) will be the
tick CPU which cannot be shut down easily. So the boot CPU should not
be used in an isolated cpuset partition.

With runtime modification of nohz_full CPUs, tick_do_timer_cpu can become
TICK_DO_TIMER_NONE. So remove the two TICK_DO_TIMER_NONE WARN_ON_ONCE()
checks in tick-sched.c to avoid unnecessary warnings.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/context_tracking.h |  1 +
 include/linux/tick.h             |  2 ++
 kernel/context_tracking.c        | 15 ++++++++++---
 kernel/sched/isolation.c         |  3 +++
 kernel/time/tick-sched.c         | 37 ++++++++++++++++++++++++++------
 5 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index a3fea7f9fef6..1a6b816f1ad6 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -17,6 +17,7 @@
 #define CONTEXT_TRACKING_FORCE_ENABLE	(-1)
 
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577..05586f14461c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -274,6 +274,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
+extern void tick_nohz_full_update_cpus(struct cpumask *cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
@@ -299,6 +300,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
+static inline void tick_nohz_full_update_cpus(struct cpumask *cpumask) { }
 #endif
 
 static inline void tick_nohz_task_switch(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 925999de1a28..394e432630a3 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -674,9 +674,9 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
+	static bool initialized;
 
 	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
 		static_branch_inc(&context_tracking_key);
@@ -700,6 +700,15 @@ void __init ct_cpu_track_user(int cpu)
 	initialized = true;
 }
 
+void ct_cpu_untrack_user(int cpu)
+{
+	if (!per_cpu(context_tracking.active, cpu))
+		return;
+
+	per_cpu(context_tracking.active, cpu) = false;
+	static_branch_dec(&context_tracking_key);
+}
+
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 void __init context_tracking_init(void)
 {
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index c233d55a1e95..48b155e0b290 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -181,6 +181,9 @@ int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
 	if ((housekeeping.flags & flags) != flags)
 		WRITE_ONCE(housekeeping.flags, housekeeping.flags | flags);
 
+	if (flags & HK_FLAG_KERNEL_NOISE)
+		tick_nohz_full_update_cpus(isol_mask);
+
 	synchronize_rcu();
 
 	if (flags & HK_FLAG_DOMAIN) {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ed877b2c9040..7baa757ca45f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -241,9 +241,6 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	tick_cpu = READ_ONCE(tick_do_timer_cpu);
 
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && unlikely(tick_cpu == TICK_DO_TIMER_NONE)) {
-#ifdef CONFIG_NO_HZ_FULL
-		WARN_ON_ONCE(tick_nohz_full_running);
-#endif
 		WRITE_ONCE(tick_do_timer_cpu, cpu);
 		tick_cpu = cpu;
 	}
@@ -629,6 +626,36 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
+/* Get the new set of run-time nohz CPU list & update accordingly */
+void tick_nohz_full_update_cpus(struct cpumask *cpumask)
+{
+	int cpu;
+
+	if (!tick_nohz_full_running) {
+		pr_warn_once("Full dynticks cannot be enabled without the nohz_full kernel boot parameter!\n");
+		return;
+	}
+
+	/*
+	 * To properly enable/disable nohz_full dynticks for the affected CPUs,
+	 * the new nohz_full CPUs have to be copied to tick_nohz_full_mask and
+	 * ct_cpu_track_user/ct_cpu_untrack_user() will have to be called
+	 * for those CPUs that have their states changed. Those CPUs should be
+	 * in an offline state.
+	 */
+	for_each_cpu_andnot(cpu, cpumask, tick_nohz_full_mask) {
+		WARN_ON_ONCE(cpu_online(cpu));
+		ct_cpu_track_user(cpu);
+		cpumask_set_cpu(cpu, tick_nohz_full_mask);
+	}
+
+	for_each_cpu_andnot(cpu, tick_nohz_full_mask, cpumask) {
+		WARN_ON_ONCE(cpu_online(cpu));
+		ct_cpu_untrack_user(cpu);
+		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+	}
+}
+
 bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
@@ -1238,10 +1265,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		 */
 		if (tick_cpu == cpu)
 			return false;
-
-		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE))
-			return false;
 	}
 
 	return true;
-- 
2.53.0


