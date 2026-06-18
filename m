Return-Path: <cgroups+bounces-17059-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tpkgFmxiM2oMAAYAu9opvQ
	(envelope-from <cgroups+bounces-17059-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3169D40B
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=miNT5MPt;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17059-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17059-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AB23079601
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B50336882;
	Thu, 18 Jun 2026 03:11:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABC331EC3
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:11:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752312; cv=none; b=bDCPfFvh144uFSAvZ2tdi3FvmgDORB/JjWAxs8YeTUz7i1RJ/ovQwLmh1SYU1Vcw8UCYA+m9Sy1lIxIfX0H+BUhphIDFs3PLq0lWr0RfAqSjJyVDbwzv/7RJHIJTJYJ0nEbUVny+CFM7hYLjDHFKARx2sMjSteRdde9yhAVTvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752312; c=relaxed/simple;
	bh=DkfY/r2xkmo438EzM4kwrrTgd/VUujsBaL78ZzvJYv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM4K7V8kum/lO5az223pRx+f9+ZP7dX30z0cnOeRL7vPuMU9mzduKZJt9AnSd1YbloMjEl/gr/TnzMhlbN7Yt4Fc6eTRsGfei/lrhueSEyyKCVbUk+SXeizjlwjMAmO9bpSLig2ZOQU5DdvKyhX2ZFjsb6EcKagrQ78t4b3Ym84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miNT5MPt; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c379e8ffso3918455ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752310; x=1782357110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoMbytYOzbmWtTlBZiAAPcp758fAUen5og8k+7nFdmk=;
        b=miNT5MPts8clFix+tyjttW7l/VPBvTrZ7A+khs5o9ZXl64idvfiun7L9cGrvQY095s
         Jjv1gA2SD1ZE08k2KT/zh7sRUDvtBvm7ZWiyzjPyVIyWHQ0S84scfUxbytMJkAh/YZMK
         eAcB9Z40UvEHfXFMJ/Agi+n81nGIMtpoJBCke6rtEcqUQFpBrmBe4G7ufWfLLhWWhFj2
         9nAR12YvmXTkxzdtBp7eoM7obAi1ZCMLmvKRPB8YruqlU/rsrmXDm+TfIXsHyl3lcuc0
         eCOZ9FoGDqU48D1h5amG38NWtWnkLqLf2iPm0HKmTJi6+GUSz+zo6yVyLFj6NGZoF2qp
         MRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752310; x=1782357110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PoMbytYOzbmWtTlBZiAAPcp758fAUen5og8k+7nFdmk=;
        b=Z6ujk8acMvk4oHLxZ+6rJEIk4jieu7lazn1jIfc1fZPcgEBnjTKPVvfAN4wLXdhzde
         0qBubLnNpidzgxVP6pNypYpVQgAts7uz1Ot+jcPMGDIb5JWJ8jKzwriuqHOccPAYdO3Y
         a8tTVoFswT1xtd9xuhdt3sR9XHX9VFR6ItV/fx7HRPB982oEfwnYr+E8VmnxALAyWoSR
         m15R2EE4Avi1PKciMSqnoTx2xBStIy/pHAOdqylq+UPDSzh5XQ/f5x04XOFzTh98MLcV
         GGGCpO9uErXWwDFBGA3C9w2XmxGi52Wz64XMrzR/yiKOMY5tBEGPfPlpjARgUO5tjLZB
         FJJA==
X-Forwarded-Encrypted: i=1; AFNElJ//CsSjf1g2F21dV7cGH6yuZCqgTsbHf3lq/cnmcqyAfgXNZHQ4NF/osab7aLDDZRR1IvztuK7G@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzUNBDpqP096Cr72fQL+nK5AS0cfocejXgt2lo0l04HlRVdM6
	SuCtskIsSn4eazUJJefFyAv7MScy/edxT3jEY5VRPDxelAuhyx2fSxqI
X-Gm-Gg: AfdE7cm0QRacHexGLY4N7ppBoXU1aLAaNnDDg5aWBTz+fO1a/v3sPoBHUlT13zQAN00
	x7vlxnKR3H4eumTMmpLKLvEcl7lHK0AQPMNJWD51NgTKMGXT7rK9mLE67514uQo3akyLWn7cd7L
	ySorvmAC31vlpsRUTz8DmOIkLiNRah8G1JRA7gwLA8IqlYqj52sF3+zW7DHJi5bCU0oXDRtfCMA
	kCvlqBv3/jZlq1y6UbPtcpUVKGb+1leB5hIPlNRPDvlOl2p+AtqC0YDl7jREvdXzkD+INpNVFip
	2SqXOZxSOmBgkDAvqRhptJSmzBok2U1S005JbdMFdWWnNj2P2bqDJOIMnMPXEI/mU3+GeRBwCus
	ZKheZShX//pJRCB1+qdlfGQjp51IPuKXBG+6FRbcfH0cx9IPeA5pPiT+vmedj3drRrSLSa83AFw
	u2swiKBeIoTJQ=
X-Received: by 2002:a17:902:ce04:b0:2bd:ba44:6c07 with SMTP id d9443c01a7336-2c6e494930cmr17614055ad.16.1781752310297;
        Wed, 17 Jun 2026 20:11:50 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:11:49 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:15 +0800
Subject: [PATCH v3 04/13] sched/isolation: Fix RCU protection for
 runtime-mutable cpumask callers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-4-28f1a4d83b68@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17059-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D3169D40B

housekeeping_update_types() installs new cpumasks via rcu_assign_pointer()
and frees the old ones after synchronize_rcu(); callers that dereference
the old pointer without holding an RCU read lock can access freed memory.

Fix the four call sites:

kernel/sched/core.c (get_nohz_timer_target, HK_TYPE_KERNEL_NOISE):
  The guard(rcu)() was acquired after housekeeping_cpumask().  Move it
  before the call and switch to housekeeping_cpumask_rcu() so hk_mask
  is read inside the RCU read-side critical section.  HK_TYPE_KERNEL_NOISE
  is updated at runtime by housekeeping_update_types(); this fix is
  required for correctness.

drivers/hv/channel_mgmt.c (init_vp_index, HK_TYPE_MANAGED_IRQ):
  The function stored the raw pointer in a local variable and used it
  across GFP_KERNEL allocations (which can sleep, so an RCU read lock
  cannot span them).  Allocate both cpumask_var_t buffers first, then
  snapshot the housekeeping mask under a brief rcu_read_lock() and use
  the snapshot throughout.  HK_TYPE_MANAGED_IRQ is updated at runtime;
  this fix is required for correctness.

kernel/time/hrtimer.c (get_target_base, HK_TYPE_TIMER):
  cpumask_any_and() against housekeeping_cpumask(HK_TYPE_TIMER) was
  called without any lock.  Wrap with rcu_read_lock()/rcu_read_unlock()
  and use housekeeping_cpumask_rcu().  HK_TYPE_TIMER is not changed at
  runtime in this series; this is a defensive fix to satisfy the
  housekeeping_dereference_check() lockdep annotation for future-proofing.
  hrtimers_cpu_dying() is already safe: it runs under the cpu_hotplug_lock
  write side, which housekeeping_dereference_check() already permits.

arch/arm64/kernel/topology.c (arch_freq_get_on_cpu, HK_TYPE_TICK):
  cpumask_intersects() against housekeeping_cpumask(HK_TYPE_TICK) was
  called without any lock.  Evaluate under rcu_read_lock() and store
  the boolean result before releasing the lock.  HK_TYPE_TICK is not
  changed at runtime in this series; this is a defensive fix.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 arch/arm64/kernel/topology.c |  9 ++++++--
 drivers/hv/channel_mgmt.c    | 50 ++++++++++++++++++++++++++++++--------------
 kernel/sched/core.c          |  3 +--
 kernel/time/hrtimer.c        |  5 ++++-
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b32f13358fbb1..8f4329b57cea7 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -212,8 +212,13 @@ int arch_freq_get_on_cpu(int cpu)
 			if (!policy)
 				return -EINVAL;
 
-			if (!cpumask_intersects(policy->related_cpus,
-						housekeeping_cpumask(HK_TYPE_TICK))) {
+			bool no_hk_in_policy;
+
+			rcu_read_lock();
+			no_hk_in_policy = !cpumask_intersects(policy->related_cpus,
+							      housekeeping_cpumask_rcu(HK_TYPE_TICK));
+			rcu_read_unlock();
+			if (no_hk_in_policy) {
 				cpufreq_cpu_put(policy);
 				return -EOPNOTSUPP;
 			}
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 84eb0a6a0b546..fc5247e92e1b3 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -750,26 +750,43 @@ static void init_vp_index(struct vmbus_channel *channel)
 {
 	bool perf_chn = hv_is_perf_channel(channel);
 	u32 i, ncpu = num_online_cpus();
-	cpumask_var_t available_mask;
+	cpumask_var_t available_mask, hk_snap;
 	struct cpumask *allocated_mask;
-	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	u32 target_cpu;
 	int numa_node;
 
-	if (!perf_chn ||
-	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
-	    cpumask_empty(hk_mask)) {
-		/*
-		 * If the channel is not a performance critical
-		 * channel, bind it to VMBUS_CONNECT_CPU.
-		 * In case alloc_cpumask_var() fails, bind it to
-		 * VMBUS_CONNECT_CPU.
-		 * If all the cpus are isolated, bind it to
-		 * VMBUS_CONNECT_CPU.
-		 */
+	if (!perf_chn) {
+		channel->target_cpu = VMBUS_CONNECT_CPU;
+		return;
+	}
+
+	if (!alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
+		channel->target_cpu = VMBUS_CONNECT_CPU;
+		hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
+		return;
+	}
+
+	/*
+	 * Snapshot HK_TYPE_MANAGED_IRQ cpumask under RCU read lock.
+	 * housekeeping_update_types() frees the old cpumask after
+	 * synchronize_rcu(), so we must not hold the pointer beyond an
+	 * RCU read-side critical section.
+	 */
+	if (!alloc_cpumask_var(&hk_snap, GFP_KERNEL)) {
+		free_cpumask_var(available_mask);
+		channel->target_cpu = VMBUS_CONNECT_CPU;
+		hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
+		return;
+	}
+	rcu_read_lock();
+	cpumask_copy(hk_snap, housekeeping_cpumask_rcu(HK_TYPE_MANAGED_IRQ));
+	rcu_read_unlock();
+
+	if (cpumask_empty(hk_snap)) {
+		free_cpumask_var(hk_snap);
+		free_cpumask_var(available_mask);
 		channel->target_cpu = VMBUS_CONNECT_CPU;
-		if (perf_chn)
-			hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
+		hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
 		return;
 	}
 
@@ -788,7 +805,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 
 retry:
 		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
-		cpumask_and(available_mask, available_mask, hk_mask);
+		cpumask_and(available_mask, available_mask, hk_snap);
 
 		if (cpumask_empty(available_mask)) {
 			/*
@@ -809,6 +826,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 
 	channel->target_cpu = target_cpu;
 
+	free_cpumask_var(hk_snap);
 	free_cpumask_var(available_mask);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c69..371b509d92164 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1272,9 +1272,8 @@ int get_nohz_timer_target(void)
 		default_cpu = cpu;
 	}
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
-
 	guard(rcu)();
+	hk_mask = housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE);
 
 	for_each_domain(cpu, sd) {
 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5bd6efe598f0f..18e17a9dad67b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -242,8 +242,11 @@ static bool hrtimer_suitable_target(struct hrtimer *timer, struct hrtimer_clock_
 static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base, bool pinned)
 {
 	if (!hrtimer_base_is_online(base)) {
-		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+		int cpu;
 
+		rcu_read_lock();
+		cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask_rcu(HK_TYPE_TIMER));
+		rcu_read_unlock();
 		return &per_cpu(hrtimer_bases, cpu);
 	}
 

-- 
2.43.0


