Return-Path: <cgroups+bounces-17634-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pOBjJgJnUGoXyQIAu9opvQ
	(envelope-from <cgroups+bounces-17634-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56467736F52
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cnDmH4dh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17634-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17634-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B0E302A7EF
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B899367B79;
	Fri, 10 Jul 2026 03:28:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362A3672A5
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:28:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654124; cv=none; b=h3WCYhsljcgj05dTQcgNyx+bVLA5pSppV9c2N3kT63i6xRT6fC3dw6SSYgKRQbZRqKW2IlI3OOMeO+R807Xtma4yxjDkuLc9Vl/NkiHnFyJMM4oFx7/ORx7JPZED5ILyw2jm51nNNZrB52i1SFDibqD9p29cC6gFupdZo5/mTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654124; c=relaxed/simple;
	bh=tA9wD3TNXeEArI8ZoxLwOtsaod6AseL+D5l+XBb7lvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyWBEjlEm8kEsyEEEDvN9M+EUQM3rznAYxwdSLp+7vG7RCX4tb5VGYA0tuFUSjeevxx2Ct5Xcux2s3SjdZJAD2KmtIU4+s6vwv2oT3h2/xOSmJCIyfOKqgd7G8Utkrm52hDpsizQUaot4qIh6izfcvSuBVv6gKEqentvrCteYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnDmH4dh; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc73e322dbso4402635ad.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654122; x=1784258922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRlCpxoiJUvKc2NSwy5g73yIeI0cTYhVnCLSI2ilvTQ=;
        b=cnDmH4dhfFzZIKi56f3Z4JsrCm7444rLwqcUq0UDgzOHlxqIKVw3lY96f7ZeP+Z3P/
         +A3SVdvam2tgi3wXs1lJh9R3j5MKtfImQBFyrZ2mGE3Vcp+rXByWnHTZSJKq6ol5ijDp
         7dNu3QsPyQgy9btje65H/Fg5HUDfRIVw2RqW44iWePsysbFS7hv6n+4DoR7C5+NuP0XM
         A3BshLDLUxcllOyYU61e25E1tBwEaEDCZ7kcy284Gb39/t08SSi3L5sLn01vs83mHda/
         qhYvTsMPINHJhrxpRFwXpSTbHPcyqWHTu4SAWd6JvXUeVbNfovE51xiod3AdLqY9UulA
         S2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654122; x=1784258922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRlCpxoiJUvKc2NSwy5g73yIeI0cTYhVnCLSI2ilvTQ=;
        b=AWoA8v2m58fm/8a/VOrq9Z3ok11qGPFN2Rj5aBOXsSC88GXULlkx8m2piP+BYK5umA
         jIyW8+6Iti2J8z5I2/8JH9/hrms1codagnzUU2//gBoRxf+n70wkBoROyR4C3mCN1LU2
         dMSeEdlHWJBv+7ucJTyTGcA6gtXcQqCikLM38+uwUwoHjDxSqCRPmGSuRzMKlyXde3lU
         kHYIYjw7EE0O9znv3owPv3/t2B6T53vGlTSrDGvqtARJ6GRsr044YyYU7k8mmKY6PCGK
         iWI8Lazs1uLkayTYc7onl4hGeCV0OWyJ4lLGnfOYGlgcWINLwdGeY2POuYBgdRKRvi+b
         mwvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsWbF8WGxxWD9d0Nuu33HR/rHd68kgY/ekbIHUHUOhmaCuKoF8+0heSCHbb2ldtDtKNVUOQixX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp00Z62RjeVE1118VwmlOrrmEmasbWzsBPJxBQPu/3VRzoAduS
	c+S09L27fmHVwFdbEuZ7RrO6dyqsmn+CnFKIHNVuVbzOI9bKrGv9le7z
X-Gm-Gg: AfdE7cm59Pf3zciX9/6JBeKHhSxjTZOAbKj40CaqM9H1x+sBSS7dFtw/mfSriQfmx9G
	SLa9uvdG/JyTru7epJD/pFBsHiGraDliulKTb5203gO+CJ5gx9nkSez0P5/4cO7u4+DMB8/BxGW
	NzfmNSNfBsNilvMJA1A9yiKg/djd4Bat/peEql0UAvM3uLzM8xnYGcLPyOWZcHtrVNhpHbnLPwB
	PQ/tfJEuI6F3OhK+pZ7ydw52dGCVnHZVieC6Y0+Bf3eq+R7MQHUqeYvNaBOM1xB1zrMeFLEoKrd
	rz39O92vuFd84vouJyDWWohrRQjATwLrPdN0IWLTRAJS1A+mNhBt9A8b7VzyMGWeJjMdf8gE737
	8TPKFCROb+UHWwKRvVGUCHT4B8+yFVTCGWKGhy6mOc9uoStrPLuumyNL2TlybPf5ZKPIfanZv45
	szKoZT5qoJteo=
X-Received: by 2002:a17:902:db09:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2ccea3b1266mr100601535ad.12.1783654121956;
        Thu, 09 Jul 2026 20:28:41 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:41 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:13 +0800
Subject: [PATCH v4 02/11] sched/isolation: RCU-protect runtime-mutable
 housekeeping cpumask readers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-2-2e912e5d9645@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17634-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56467736F52

Now that HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ can be updated at
runtime, their cpumask pointers are swapped and the old masks freed after
an RCU grace period.  Readers that dereference these masks must do so
inside an RCU read-side critical section, otherwise the mask can be freed
while it is still in use.

Convert the runtime-mutable readers to housekeeping_cpumask_rcu() under
rcu_read_lock():

  - get_nohz_timer_target() (HK_TYPE_KERNEL_NOISE)
  - hrtimer target selection (HK_TYPE_TIMER)
  - arm64 topology (HK_TYPE_TICK)
  - Hyper-V channel management (HK_TYPE_MANAGED_IRQ)
  - the housekeeping sysfs attribute (HK_TYPE_KERNEL_NOISE)

The watchdog boot-time cpumask initialisation is switched from the
HK_TYPE_TIMER alias to HK_TYPE_KERNEL_NOISE for consistency; both alias
the same value.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 arch/arm64/kernel/topology.c |  9 ++++++--
 drivers/base/cpu.c           | 20 +++++++++++++-----
 drivers/hv/channel_mgmt.c    | 50 ++++++++++++++++++++++++++++++--------------
 kernel/sched/core.c          |  3 +--
 kernel/time/hrtimer.c        |  5 ++++-
 kernel/watchdog.c            |  2 +-
 6 files changed, 62 insertions(+), 27 deletions(-)

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
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e1..e0aa3d34bc41a 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -303,13 +303,23 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t housekeeping_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	const struct cpumask *hk_mask;
+	ssize_t len;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
+	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return sysfs_emit(buf, "\n");
 
-	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
-		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(hk_mask));
-	return sysfs_emit(buf, "\n");
+	/*
+	 * HK_TYPE_KERNEL_NOISE is runtime-mutable: the mask pointer can be
+	 * swapped and the old mask freed after an RCU grace period.  Hold the
+	 * RCU read lock across the dereference and the format so the mask
+	 * cannot be freed while it is being printed.
+	 */
+	rcu_read_lock();
+	len = sysfs_emit(buf, "%*pbl\n",
+			 cpumask_pr_args(housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE)));
+	rcu_read_unlock();
+
+	return len;
 }
 static DEVICE_ATTR_RO(housekeeping);
 
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
index 79c3349f65bb4..3eb39103f5469 100644
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
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968d..c18c3e9781d7b 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1389,7 +1389,7 @@ void __init lockup_detector_init(void)
 		pr_info("Disabling watchdog on nohz_full cores by default\n");
 
 	cpumask_copy(&watchdog_cpumask,
-		     housekeeping_cpumask(HK_TYPE_TIMER));
+		     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;

-- 
2.43.0


