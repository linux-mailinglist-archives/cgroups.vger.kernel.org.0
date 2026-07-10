Return-Path: <cgroups+bounces-17633-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8tn6NudmUGoFyQIAu9opvQ
	(envelope-from <cgroups+bounces-17633-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:28:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F60736F2B
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:28:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bmpmGQCT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17633-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17633-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2705A301F14D
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD4367B6D;
	Fri, 10 Jul 2026 03:28:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97053381C4
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654115; cv=none; b=lSQxcCmvw3E4VfFh8Y797eCBSif3KBFM1j5trXh7owBvfRa21HjIWuA1JXn+DTgyUw+OTM2jOP2kZbGDFOQncmyMtyEqSeqrGylJVunH6Q3xsRuaPxpvlsEyMhDurOHF/Ztz/WuEej+5sJp4T/hU1S0JCj/PEMMK9HLSVzkuw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654115; c=relaxed/simple;
	bh=OWzkBZj94kwxwBi57rZUXfo+HI1CfaJQHHKsPhN/SsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpPJ/bCFYePOZrHcGLyWdaeLwTzqwGU8LdC121So3ifKoAx/2W6Rty/vsuHNxyQrCMyQ2yupKRcqk2eFM4Qb252X6ok7K1UoL7gNScPUDrnGjk8wQGGnJMtafQMu8hoYjzWfFTKbC28c3F3tKXaUbOL1zBKtmWJ3ityhMaaRX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmpmGQCT; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce7d2adef4so5783305ad.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654113; x=1784258913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+HqsKCBa8kVrZBI4dYL0PYb+R87jVrp5SVVk7foZ+g=;
        b=bmpmGQCT3Rvh1t88mGtFGv1b+QNcN2ItJcPpVGzoeLFqRc3MXc3TZIsYV2FvuQl2XD
         aHbRq2AmxZ+CNrPgfGCOv1qker64KXHBtoKD6GI7TYV+vIIbYUDCs1rQrmZcpFL7RDms
         D00BpVRBDBGdVYW1hNooulbEQU+nkyegX/TKNtK/v41BhqDcJpvpkmnFtxe5AqWPaqDv
         e2SHFn1Qn1xN+r/m97sqC4oh2adTCT577O8jD0xACHlltBou0bGEwEA7DNK+LnFj+P1j
         s+aP4j0wh7tv4bnSr3bZQkS0/xUiESFPTAirLHSBemdqs7A2Z+18rcnrV6sm2Tj/uvhD
         DaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654113; x=1784258913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+HqsKCBa8kVrZBI4dYL0PYb+R87jVrp5SVVk7foZ+g=;
        b=RTk3PxeIyyxlqznBCwYGK7jB/Her6FxdV6Q/v6I4pCBOfniTCFDviw46OUhLnSy4an
         HNfv0Cwf/VMEKu4BUbme4cucNPj+g09FJB+EzGqKYDKKddfKYAIIWZa6lOgItre+kw6T
         2NyJgLFMr0n2nWg5JavU6Cf+7EEQ8Wq9UBkOqKU7CCkEpbpogZNaAB2vg2kixrStsJ9e
         fuM6oN+Udo1nI6cJt6iYHsmMk9Qes+oSmdLCfuJBj73XLtwb1+9r0HqI7fn5c2b11ARm
         XL36ipmB4stnfVWjJ332Gf/92hkAeaBFlKEobDGcjxWfawLS1lakvH+BSOvAY/Zrtnd+
         sJ7A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4JsaOILMmZ7YRJWSh2dAIIe4fV2eQXTby38EC0J00nuFrBRzNyAnQQYoAwE+9AfsHfYts8Qvm@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkTr8JuI/f6j9v7XHSJthci3hafQL16RjSgqHXXnwsnmK/pyv
	bCQfcqbjrpSkMlAap+VyUP+/5KwJEymAe2BvsUkcXT5BSz2e15sY8rA5
X-Gm-Gg: AfdE7clnqOq6Zm7ahEUbDmEo1PB6aJiZtHLJMlsNmrXKDw37HhWXTLyUus66HHhbGYh
	78M5O7RBU+eJsN50dUt+HLgLlGt2y1yNszNSe1BudUZnqQE5Tc6Se2rdKiz13kqQM9IOTyz+qHr
	ukWqExZJGzvsEsjDxVBj13lIs3gYdaXxiwc75UCge8Ionu001OfFMAmMKVp0ENX9UQFAA++9uXp
	hPkFce8Rv3iVzhPvcrDKCppgL9jWBLQCYBoK/lioFKImezOo1LzDEa8KLIkZAnlTLnxcbdLp+BP
	T1rz5Vxzdm53XflsLgOOF22kGO9pa9VC71rkcbtmARSsMjOlYOptsB4d4fmExAQFOVQ7PMWE2jd
	oWY/PrdWAGShnc7kw1FOPO29k3bKm2/5YisCKgxs7pyXc0XGz1kRYEaxN9BXPyimmEgl+eqojIR
	k9rovIoU3ojms=
X-Received: by 2002:a17:902:ce03:b0:2cc:ee78:3236 with SMTP id d9443c01a7336-2ccee7832d2mr96667315ad.33.1783654112959;
        Thu, 09 Jul 2026 20:28:32 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:32 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:12 +0800
Subject: [PATCH v4 01/11] sched/isolation: Add runtime housekeeping mask
 updates with boot snapshots
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-1-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
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
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
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
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17633-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43F60736F2B

The housekeeping cpumasks for kernel noise (HK_TYPE_KERNEL_NOISE) and
managed interrupts (HK_TYPE_MANAGED_IRQ) are computed once at boot from
the nohz_full= and isolcpus=managed_irq arguments.  Dynamic CPU
isolation driven by cpuset isolated partitions needs to update these
masks after boot.

Add housekeeping_update_types() to recompute one or more housekeeping
masks as (boot snapshot & ~isolated), publish them via RCU and free the
old masks after a grace period.

Introduce HK_TYPE_KERNEL_NOISE_BOOT and HK_TYPE_MANAGED_IRQ_BOOT to
record the immutable boot configuration.  Anchoring every update on the
boot snapshot keeps the runtime mask a subset of the boot set and lets
de-isolation restore the boot configuration exactly.

When neither nohz_full= nor isolcpus=nohz was given at boot no boot
snapshot exists, so cpu_possible_mask is the implicit boot set and
HK_TYPE_KERNEL_NOISE is enabled on the first runtime call.  In that
case housekeeping_update_types() also calls sched_tick_offload_init()
to allocate the tick offload percpu data that would otherwise only be
allocated by housekeeping_init() when nohz_full= is present at boot.
Remove __init from sched_tick_offload_init() and guard it with a
tick_work_cpu check so it is safe to call at runtime.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/sched/isolation.h |  32 ++++++-
 kernel/sched/core.c             |   4 +-
 kernel/sched/isolation.c        | 197 +++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h            |   2 +-
 4 files changed, 209 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cf0fd03dd7a24..70602a74c1410 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -14,10 +14,26 @@ enum hk_type {
 	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
 	 */
 	HK_TYPE_DOMAIN,
-	/* Inverse of boot-time isolcpus=managed_irq argument */
-	HK_TYPE_MANAGED_IRQ,
-	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
+
+	/*
+	 * Inverse of the boot-time nohz_full= or isolcpus=nohz arguments.
+	 * When neither is given, DHM still records cpu_possible_mask here so
+	 * that kernel-noise isolation can be enabled purely at runtime.
+	 */
+	HK_TYPE_KERNEL_NOISE_BOOT,
+	/*
+	 * A subset of HK_TYPE_KERNEL_NOISE_BOOT: it may exclude additional
+	 * CPUs isolated at runtime via cpuset isolated partitions.
+	 */
 	HK_TYPE_KERNEL_NOISE,
+
+	/* Inverse of the boot-time isolcpus=managed_irq argument */
+	HK_TYPE_MANAGED_IRQ_BOOT,
+	/*
+	 * A subset of HK_TYPE_MANAGED_IRQ_BOOT: it may exclude additional
+	 * CPUs isolated at runtime via cpuset isolated partitions.
+	 */
+	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_MAX,
 
 	/*
@@ -40,10 +56,13 @@ enum hk_type {
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
 extern int housekeeping_any_cpu(enum hk_type type);
 extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
+extern const struct cpumask *housekeeping_cpumask_rcu(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern int housekeeping_update(struct cpumask *isol_mask);
+extern int housekeeping_update_types(unsigned long type_mask,
+				     struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
 #else
@@ -58,6 +77,11 @@ static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
 	return cpu_possible_mask;
 }
 
+static inline const struct cpumask *housekeeping_cpumask_rcu(enum hk_type type)
+{
+	return cpu_possible_mask;
+}
+
 static inline bool housekeeping_enabled(enum hk_type type)
 {
 	return false;
@@ -72,6 +96,8 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 
 static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
+static inline int housekeeping_update_types(unsigned long type_mask,
+					    struct cpumask *isol_mask) { return 0; }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c69..79c3349f65bb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5813,8 +5813,10 @@ static void sched_tick_stop(int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-int __init sched_tick_offload_init(void)
+int sched_tick_offload_init(void)
 {
+	if (tick_work_cpu)
+		return 0;
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
 	return 0;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe20..4602c8d0108e4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -12,10 +12,12 @@
 #include "sched.h"
 
 enum hk_flags {
-	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
-	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_DOMAIN_BOOT	  = BIT(HK_TYPE_DOMAIN_BOOT),
+	HK_FLAG_DOMAIN		  = BIT(HK_TYPE_DOMAIN),
+	HK_FLAG_KERNEL_NOISE_BOOT = BIT(HK_TYPE_KERNEL_NOISE_BOOT),
+	HK_FLAG_KERNEL_NOISE	  = BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_MANAGED_IRQ_BOOT  = BIT(HK_TYPE_MANAGED_IRQ_BOOT),
+	HK_FLAG_MANAGED_IRQ	  = BIT(HK_TYPE_MANAGED_IRQ),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -34,25 +36,40 @@ bool housekeeping_enabled(enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+/*
+ * Types that can change at runtime via cpuset isolated partitions.
+ * Boot-only types (DOMAIN_BOOT) are always safe to read without lockdep.
+ */
+static bool housekeeping_type_can_change(enum hk_type type)
+{
+	switch (type) {
+	case HK_TYPE_DOMAIN:
+	case HK_TYPE_KERNEL_NOISE:
+	case HK_TYPE_MANAGED_IRQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool housekeeping_dereference_check(enum hk_type type)
 {
-	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
-		/* Cpuset isn't even writable yet? */
-		if (system_state <= SYSTEM_SCHEDULING)
-			return true;
+	if (!IS_ENABLED(CONFIG_LOCKDEP) || !housekeeping_type_can_change(type))
+		return true;
 
-		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
-		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
-			return true;
+	/* Cpuset isn't even writable yet? */
+	if (system_state <= SYSTEM_SCHEDULING)
+		return true;
 
-		/* Cpuset lock held, partitions not writable */
-		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
-			return true;
+	/* CPU hotplug write locked, so cpuset partition can't be overwritten */
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
+		return true;
 
-		return false;
-	}
+	/* Cpuset lock held, partitions not writable */
+	if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
+		return true;
 
-	return true;
+	return false;
 }
 
 static inline struct cpumask *housekeeping_cpumask_dereference(enum hk_type type)
@@ -75,12 +92,26 @@ const struct cpumask *housekeeping_cpumask(enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 
+const struct cpumask *housekeeping_cpumask_rcu(enum hk_type type)
+{
+	const struct cpumask *mask = NULL;
+
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		if (READ_ONCE(housekeeping.flags) & BIT(type))
+			mask = rcu_dereference(housekeeping.cpumasks[type]);
+	}
+	if (!mask)
+		mask = cpu_possible_mask;
+	return mask;
+}
+EXPORT_SYMBOL_GPL(housekeeping_cpumask_rcu);
+
 int housekeeping_any_cpu(enum hk_type type)
 {
 	int cpu;
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
-		if (housekeeping.flags & BIT(type)) {
+		if (READ_ONCE(housekeeping.flags) & BIT(type)) {
 			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
@@ -162,6 +193,130 @@ int housekeeping_update(struct cpumask *isol_mask)
 	return 0;
 }
 
+/**
+ * housekeeping_update_types - Update housekeeping masks for specified types
+ * @type_mask: Bitmask of housekeeping types to update
+ * @isol_mask: CPUs being added to the isolation set
+ *
+ * For each type in @type_mask, compute the trial mask as
+ * (boot snapshot & ~@isol_mask), validate it against @cpu_online_mask,
+ * then swap the RCU mask pointer and free the old mask after
+ * synchronize_rcu().  Anchoring on the immutable boot snapshot
+ * (HK_TYPE_*_BOOT) keeps the runtime mask a subset of the boot set and
+ * lets de-isolation restore the boot configuration exactly.
+ *
+ * The updated mask only takes effect for subsystems as CPUs cycle
+ * through hotplug; callers isolate CPUs via the CPU hotplug machinery so
+ * that tick, RCU and interrupt state is reconfigured by the existing
+ * online/offline callbacks rather than reconfigured in place.
+ *
+ * HK_TYPE_KERNEL_NOISE also supports runtime first-enable: when neither
+ * nohz_full= nor isolcpus=nohz was given at boot, no boot snapshot
+ * exists, so cpu_possible_mask is the implicit boot set and the type
+ * flag is set in housekeeping.flags on the first call.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure, -EINVAL if
+ * a trial mask has no online CPUs.
+ */
+int housekeeping_update_types(unsigned long type_mask,
+			      struct cpumask *isol_mask)
+{
+	struct cpumask *trials[HK_TYPE_MAX] = {};
+	struct cpumask *old_masks[HK_TYPE_MAX] = {};
+	enum hk_type type;
+	int ret = 0;
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		const struct cpumask *base;
+
+		if (type == HK_TYPE_DOMAIN_BOOT)
+			continue;
+		if (!housekeeping_enabled(type)) {
+			/*
+			 * HK_TYPE_KERNEL_NOISE supports runtime first-enable
+			 * for DHM isolated partitions created without nohz_full=
+			 * at boot.  All other types must be boot-enabled.
+			 */
+			if (type != HK_TYPE_KERNEL_NOISE)
+				continue;
+		}
+
+		/*
+		 * Compute the trial mask relative to the immutable boot
+		 * snapshot, never relative to the current (already shrunk)
+		 * mask.  Using the current mask would let it shrink
+		 * monotonically across isolation/de-isolation cycles and would
+		 * never recover CPUs once de-isolated.  Anchoring on the boot
+		 * snapshot keeps the runtime mask a subset of the boot set and
+		 * lets de-isolation restore exactly the boot configuration.
+		 *
+		 * HK_TYPE_KERNEL_NOISE additionally supports runtime
+		 * first-enable: when no nohz_full=/isolcpus=nohz was given at
+		 * boot, no boot snapshot exists, so cpu_possible_mask is the
+		 * implicit boot set.
+		 */
+		if (type == HK_TYPE_KERNEL_NOISE &&
+		    !(housekeeping.flags & HK_FLAG_KERNEL_NOISE_BOOT))
+			base = cpu_possible_mask;
+		else if (type == HK_TYPE_KERNEL_NOISE)
+			base = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE_BOOT);
+		else if (type == HK_TYPE_MANAGED_IRQ)
+			base = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ_BOOT);
+		else
+			base = housekeeping_cpumask(type);
+		trials[type] = kmalloc(cpumask_size(), GFP_KERNEL);
+		if (!trials[type]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+		cpumask_andnot(trials[type], base, isol_mask);
+		if (!cpumask_intersects(trials[type], cpu_online_mask)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	if (!housekeeping.flags) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		if (!trials[type])
+			continue;
+		old_masks[type] = housekeeping_cpumask_dereference(type);
+		/* First-time runtime enable: register the type now. */
+		if (!housekeeping_enabled(type)) {
+			WRITE_ONCE(housekeeping.flags,
+				   housekeeping.flags | BIT(type));
+			/*
+			 * HK_TYPE_KERNEL_NOISE first-enable at runtime
+			 * (zero-boot-param path): tick offload percpu data
+			 * was never allocated at boot since nohz_full= was
+			 * absent.  Allocate it now before CPUs cycle through
+			 * hotplug and sched_tick_stop() dereferences
+			 * tick_work_cpu.
+			 */
+			if (type == HK_TYPE_KERNEL_NOISE)
+				WARN_ON_ONCE(sched_tick_offload_init());
+		}
+		rcu_assign_pointer(housekeeping.cpumasks[type], trials[type]);
+		trials[type] = NULL;
+	}
+
+	synchronize_rcu();
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX)
+		kfree(old_masks[type]);
+
+	return 0;
+
+err_free:
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX)
+		kfree(trials[type]);
+	return ret;
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;
@@ -305,7 +460,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_KERNEL_NOISE;
+	flags = HK_FLAG_KERNEL_NOISE | HK_FLAG_KERNEL_NOISE_BOOT;
 
 	return housekeeping_setup(str, flags);
 }
@@ -324,7 +479,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_KERNEL_NOISE;
+			flags |= HK_FLAG_KERNEL_NOISE | HK_FLAG_KERNEL_NOISE_BOOT;
 			continue;
 		}
 
@@ -336,7 +491,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "managed_irq,", 12)) {
 			str += 12;
-			flags |= HK_FLAG_MANAGED_IRQ;
+			flags |= HK_FLAG_MANAGED_IRQ | HK_FLAG_MANAGED_IRQ_BOOT;
 			continue;
 		}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d1..9d54ac3f2251d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2925,7 +2925,7 @@ extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
-extern int __init sched_tick_offload_init(void);
+extern int sched_tick_offload_init(void);
 
 /*
  * Tick may be needed by tasks in the runqueue depending on their policy and

-- 
2.43.0


