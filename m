Return-Path: <cgroups+bounces-17061-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kb1wFidiM2r4/wUAu9opvQ
	(envelope-from <cgroups+bounces-17061-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:12:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1269D3CF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VgIzoKEG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17061-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17061-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E27E930CEDCF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D61326939;
	Thu, 18 Jun 2026 03:12:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23526331EC6
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752325; cv=none; b=huXOS3OSo/2EG4lgowJHF7yB4qa9LZwzYGFVIlkOHzhPT582IbBVm1lQkmQuoHRU4Y+BWNjTrnE7zBnpUtiSYGxnLonYkstTvUEiLo0zjegZ6Qky9s+5B/yPZLqTtwv9k0ICi/pBxqxER9b1B8axjaD34sJiq8r4mYezddlv8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752325; c=relaxed/simple;
	bh=NGMo6Qrww1dJu/rQIpKoY8Dsqru3A+nBInxhSjZKlJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JV75CJzS7iWi0N8ZTNcAmu4wCcov9B5kE6x1kvJxWKeIk6PbnYcThuKxKHZORJyjA2I+XuqG8j7oPqcejgaegf+R1tSeJ3UvXwL/Sex1/w+AJyTW7QgrACO/TbqQHTwL+Bn8tr0NW0GEDkKIXOpfa8cA4uknSV3xbQL9ZGe+DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgIzoKEG; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c69921bd15so2306125ad.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752323; x=1782357123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHPKcwKivbUSuSD1ETvryOn1BWPlqo5A5EDmYEYSw9g=;
        b=VgIzoKEGvj64yDtKUpABwC6fSoqI9NQdNIRNsIvl208WEH5OtxLqVw1TVszBPx8jKB
         2fTUZEMpm9oE/7jQ5URCsEs0LVwVwhb9hlPsvi3tidk0+HOJkGxcnRByebmG26Ta6XIz
         5hrOJMN2G9nWHfC5ZLH0AVIZ2JUcqMGp1wRRz53BqxAipuNzphl5SEzYOAEhjDGmRwD1
         rLVbJDjL8TFmtli9WfD2SUIXvYQOY48UV2QNy7xOHKghB2nZ4ouiIQM7LGFU0IrdoQu7
         1UKK4ZluK6eV4M/MN4tfBhwsPqGk8fKWzkfO28s3Mm9lX0hN6/r3EJIYrzmTQf/tlata
         IhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752323; x=1782357123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHPKcwKivbUSuSD1ETvryOn1BWPlqo5A5EDmYEYSw9g=;
        b=n/8hCJgUOxyQzc2pwjjMo6LlP/Xc1H2MkFskJoEI4CO6T/UGaW4lpuRB/IyWlUQ/nY
         0YuRCKoEHV5AehZQnLvPk3GmDhdQSyqRQFpqFTfo0Kk/bjC3T18AC0rdLHHiKC0mTvAF
         izaYbx9BRzgJYjcCCjXfANxKfgMrNymFPLPhm9ZuhGlYY6KZjyoRPvb3UoC4h//BG/ib
         evk4Usi2Lp9x413l2my67fk9hyjSexTlXa1lPTdFNsRrdMT4w2Tdbs7KHyxni0dvZ+7E
         tPHgU9OKX11LlJv72mIUwFRSXhZk4OjpeFLuqKuNY1xSpMHN4kElhymY3ZphILQ5E2ok
         Fasw==
X-Forwarded-Encrypted: i=1; AFNElJ+gHFg2n0MQgVl4PgzYiuiMH2l+XEpzdO5TkqTzMA3kOG1Fp9pAxZ8sngQ5f8LlFl+DDqKfGQmk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sltqV1EUkhjGqmZlDUMxVvlDtr/ihJGX3XZThJOJ8ygvouiR
	WOC7O/RE8v3cazRrBN9ascdkwFMtLpS2wFhNAg40s+R75uLFWLVBpiSK
X-Gm-Gg: AfdE7cmUbrmiuzAdhxIzUrx3J8VhC4utvfLoE9K4TOLAkprTaf8Stgaa+pcPlkNuAQv
	Kq6SPgKPiMXiJCeytpYl2IQP9s+ZjFoFWEBumqqWNBIObA0ave4ext2LURZjDfFxbHv20s3oE/d
	3zjcM9S3hlIAKUmXlmkXKkCzHYqTHjb3ObI583UGB0se096FrT9BEhTsYRFnu3vN/bL3UvXX6H3
	AJp+/Gp9U08x08zeKMmL5jZMAkdTCf9USdngWnDoKc/T2RJ8EnkVBvrO4xYlBe4GY2WLwTOaYig
	SHoYtEIeQOrvyOpyGFsZg+qPg/ConJu2bUn1Qw00c0XAS4GOutZba6TE76OyBNYu7J0qW6GhqDh
	W+SvCSL243JlTsYvVmGDPbAi+h4tjM37sVrmu/EuUjvbSUEkHRcKTDdiTO0Yhv07h6CFKExCOJu
	8x9RVP/5QISk0=
X-Received: by 2002:a17:903:32d0:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c6e52e23edmr17236945ad.35.1781752323371;
        Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:03 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:17 +0800
Subject: [PATCH v3 06/13] tick/nohz, context_tracking: Prepare for runtime
 nohz_full updates
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-wujing-dhm-v3-6-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17061-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0A1269D3CF

Remove __init from ct_cpu_track_user() and __initdata from the
initialized flag so context tracking can be activated on CPUs that
join nohz_full at runtime.  Drop the __ro_after_init attribute from
the context_tracking_key static key, allowing static_branch_dec()
when a CPU leaves nohz_full.

Add ct_cpu_untrack_user() to reverse ct_cpu_track_user(), decrementing
the static key and clearing the per-CPU tracking state.

Register a housekeeping_cbs for HK_TYPE_KERNEL_NOISE that:
- pre_validate: checks CONFIG_NO_HZ_FULL is available.
- apply: snapshots the new HK_TYPE_KERNEL_NOISE mask under an RCU
  read lock (the lockdep annotation in housekeeping_cpumask() requires
  this even after synchronize_rcu() completes), computes nohz_full as
  the complement of the housekeeping mask, then under tick_nohz_lock:
  - Activates context tracking (ct_cpu_track_user()) on CPUs newly
    added to nohz_full, and deactivates it (ct_cpu_untrack_user()) on
    CPUs returning to the housekeeping set.  This activates the
    context_tracking_key static key dynamically, eliminating the
    need for CONFIG_CONTEXT_TRACKING_USER_FORCE.
  - Updates tick_nohz_full_mask in-place (legacy EXPORT_SYMBOL_GPL
    snapshot, eventually consistent).
  - Migrates tick_do_timer_cpu if it moved into the isolated set.
  - Kicks all CPUs to re-evaluate tick behaviour.

When CONFIG_CONTEXT_TRACKING_USER_FORCE is enabled and nohz_full= is
given at boot, tick_nohz_init() now calls context_tracking_init()
before iterating over tick_nohz_full_mask to call ct_cpu_track_user().
This ensures the per-CPU tracking state is set up before any CPU is
tracked, which is also required for CPUs later added to nohz_full at
runtime via DHM isolated partitions.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/context_tracking.h |   1 +
 kernel/context_tracking.c        |  23 ++----
 kernel/time/tick-sched.c         | 157 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 161 insertions(+), 20 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..632cfc97b5b22 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
+extern void ct_cpu_untrack_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c00..e68fb02b25ad4 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)
@@ -674,28 +674,21 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init ct_cpu_track_user(int cpu)
+void ct_cpu_track_user(int cpu)
 {
-	static __initdata bool initialized = false;
-
 	if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
+}
 
-	if (initialized)
+void ct_cpu_untrack_user(int cpu)
+{
+	if (!per_cpu(context_tracking.active, cpu))
 		return;
 
-#ifdef CONFIG_HAVE_TIF_NOHZ
-	/*
-	 * Set TIF_NOHZ to init/0 and let it propagate to all tasks through fork
-	 * This assumes that init is the only task at this early boot stage.
-	 */
-	set_tsk_thread_flag(&init_task, TIF_NOHZ);
-#endif
-	WARN_ON_ONCE(!tasklist_empty());
-
-	initialized = true;
+	per_cpu(context_tracking.active, cpu) = false;
+	static_branch_dec(&context_tracking_key);
 }
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7c..a7fe097042f7d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
+#include <linux/sched/isolation.h>
 #include <linux/mm.h>
 
 #include <asm/irq_regs.h>
@@ -653,11 +654,6 @@ void __init tick_nohz_init(void)
 	if (!tick_nohz_full_running)
 		return;
 
-	/*
-	 * Full dynticks uses IRQ work to drive the tick rescheduling on safe
-	 * locking contexts. But then we need IRQ work to raise its own
-	 * interrupts to avoid circular dependency on the tick.
-	 */
 	if (!arch_irq_work_has_interrupt()) {
 		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support IRQ work self-IPIs\n");
 		cpumask_clear(tick_nohz_full_mask);
@@ -676,6 +672,16 @@ void __init tick_nohz_init(void)
 		}
 	}
 
+	/*
+	 * Pre-initialize context tracking for all possible CPUs so
+	 * ctx tracking is already active when a CPU is later added to
+	 * nohz_full at runtime.  The tracking overhead is negligible
+	 * because the static key is not incremented yet — only per-CPU
+	 * tracking state is set up.
+	 */
+	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER_FORCE))
+		context_tracking_init();
+
 	for_each_cpu(cpu, tick_nohz_full_mask)
 		ct_cpu_track_user(cpu);
 
@@ -686,6 +692,147 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
+
+static int tick_nohz_hk_validate(enum hk_type type,
+				 const struct cpumask *cur_mask,
+				 const struct cpumask *new_mask)
+{
+	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void tick_nohz_hk_apply(enum hk_type type)
+{
+	static DEFINE_SPINLOCK(tick_nohz_lock);
+	cpumask_var_t nohz_full, added, removed;
+	bool was_running;
+	int cpu;
+
+	if (!alloc_cpumask_var(&nohz_full, GFP_KERNEL))
+		return;
+	if (!alloc_cpumask_var(&added, GFP_KERNEL)) {
+		free_cpumask_var(nohz_full);
+		return;
+	}
+	if (!alloc_cpumask_var(&removed, GFP_KERNEL)) {
+		free_cpumask_var(added);
+		free_cpumask_var(nohz_full);
+		return;
+	}
+
+	/*
+	 * Snapshot the new HK_TYPE_KERNEL_NOISE mask under an RCU read lock.
+	 * housekeeping_update_types() completes synchronize_rcu() before
+	 * invoking apply(), so the new pointer is stable; however the lockdep
+	 * annotation in housekeeping_cpumask() still requires an RCU read-side
+	 * critical section for runtime-mutable types.
+	 */
+	rcu_read_lock();
+	cpumask_andnot(nohz_full, cpu_possible_mask,
+		       housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
+	rcu_read_unlock();
+
+	/*
+	 * When "nohz_full=" was not passed at boot, tick_nohz_full_running is
+	 * false and the full dynticks infrastructure (sched_tick_offload_init,
+	 * RCU nohz quiescent-state reporting, context-tracking bootstrap) was
+	 * never initialised.  In that case restrict the update to
+	 * tick_nohz_full_mask so the /sys/devices/system/cpu/nohz_full sysfs
+	 * attribute reflects DHM-isolated CPUs without enabling tick
+	 * suppression, context tracking, or timer migration – all of which
+	 * require boot-time setup and would deadlock on the first
+	 * synchronize_rcu() call after CPUs are offlined.
+	 */
+	was_running = READ_ONCE(tick_nohz_full_running);
+
+	spin_lock(&tick_nohz_lock);
+
+	/*
+	 * When nohz_full= was active at boot, compute the delta and update
+	 * context tracking for CPUs joining or leaving the nohz_full set.
+	 * Skip when !was_running: ct_cpu_track_user() calls
+	 * static_branch_inc() which may sleep (jump_label_update on the
+	 * 0→1 transition) – illegal inside a spinlock.
+	 */
+	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) &&
+	    was_running &&
+	    cpumask_available(tick_nohz_full_mask)) {
+		cpumask_andnot(added, nohz_full, tick_nohz_full_mask);
+		cpumask_andnot(removed, tick_nohz_full_mask, nohz_full);
+		for_each_cpu(cpu, added)
+			ct_cpu_track_user(cpu);
+		for_each_cpu(cpu, removed)
+			ct_cpu_untrack_user(cpu);
+	}
+
+	/*
+	 * Update tick_nohz_full_mask unconditionally: this is the snapshot
+	 * read by the /sys/devices/system/cpu/nohz_full sysfs attribute and
+	 * must reflect the current isolation set even in the DHM runtime case.
+	 */
+	if (cpumask_available(tick_nohz_full_mask))
+		cpumask_copy(tick_nohz_full_mask, nohz_full);
+
+	/*
+	 * Only modify tick_nohz_full_running and migrate the global tick when
+	 * nohz_full= was set at boot; without boot-time setup, setting
+	 * tick_nohz_full_running would suppress ticks on isolated CPUs and
+	 * prevent RCU quiescent-state reporting, causing synchronize_rcu()
+	 * to stall permanently when a CPU is subsequently offlined.
+	 */
+	if (was_running) {
+		tick_nohz_full_running = !cpumask_empty(nohz_full);
+
+		if (tick_nohz_full_running) {
+			cpu = READ_ONCE(tick_do_timer_cpu);
+			if (cpu < nr_cpu_ids &&
+			    !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
+				int new_cpu;
+
+				new_cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
+				if (new_cpu < nr_cpu_ids)
+					WRITE_ONCE(tick_do_timer_cpu, new_cpu);
+			}
+		}
+	}
+
+	spin_unlock(&tick_nohz_lock);
+
+	if (was_running)
+		tick_nohz_full_kick_all();
+	free_cpumask_var(removed);
+	free_cpumask_var(added);
+	free_cpumask_var(nohz_full);
+}
+
+static struct housekeeping_cbs tick_nohz_hk_cbs = {
+	.name		= "tick/nohz",
+	.pre_validate	= tick_nohz_hk_validate,
+	.apply		= tick_nohz_hk_apply,
+};
+
+static int __init tick_nohz_hk_init_late(void)
+{
+	int ret;
+
+	/*
+	 * Ensure tick_nohz_full_mask is allocated so that tick_nohz_hk_apply()
+	 * can update it (and the /sys/devices/system/cpu/nohz_full sysfs
+	 * attribute) when CPUs are isolated at runtime via DHM.  If "nohz_full="
+	 * was passed at boot the mask is already allocated; allocate an empty
+	 * one here for the runtime-only case.
+	 */
+	if (!cpumask_available(tick_nohz_full_mask) &&
+	    !zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL))
+		pr_warn("tick/nohz: failed to allocate nohz_full_mask for DHM\n");
+
+	ret = housekeeping_register_cbs(HK_TYPE_KERNEL_NOISE, &tick_nohz_hk_cbs);
+	if (ret)
+		pr_warn("tick/nohz: Failed to register hk callback: %d\n", ret);
+	return 0;
+}
+late_initcall(tick_nohz_hk_init_late);
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
 
 /*

-- 
2.43.0


