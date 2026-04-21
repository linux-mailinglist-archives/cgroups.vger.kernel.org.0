Return-Path: <cgroups+bounces-15381-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FJPED7q5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15381-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:08:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9684B435BEF
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D17A303FFF3
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F89366DB6;
	Tue, 21 Apr 2026 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbd/XcDq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5E3659FB
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740729; cv=none; b=f4PZ0HIkBDwPe/t93I+5WM/enORJZEir+l9wt9IBIrz/g8HaDBvJWN+o/bwKXnkH9MhxyjxTenqkZJkcVQ+AEAoFfcFhKyL14Fsp+XZYRfp6pLRvqkbU+EPG53C4oOcUuCIteUxfi0Phoo0BI/baJwmGRbmFjCfQUl9UBci6oOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740729; c=relaxed/simple;
	bh=hqObzbSQGEeAd7/YyUO8I2dq8I5WxHIwNaMjXklxMws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cvl/ibPnps2Tx69TAyy+/cEXkN9Ok9QDrZYA+SUdz/1GRFUnvlKrtzsTeXcy5GWNHy2YYsK7fO453E5E8/gaU8dZBoFtA40shuUKncCItWp3DnM05G4Gu+IkxJ7P33Kbd1K8mP+GUQf/0szwgLaA++xAoNdtR3aEAGKpS2e4DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbd/XcDq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgcYIn++c2e0e5rWh9wDxm2bDr9HTUBWeCOEDxOtpq8=;
	b=cbd/XcDqO8FVl2Y8WBjvAQmquzOHree3wXt6XtEshYv/y70adRkHZ7M1UgfskcvEaPhpSc
	zJ0DP/uz6Z35gJ9loG1xESUwlaCB3J+FPveCS3gT3VERL3pyCntZeNOReEfb4qYtO5tFLP
	fy7cNYmO2twF0mQTu3BM7huRt3AEEPg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-mmfyWDemMNW9Ib7eyF-ndg-1; Mon,
 20 Apr 2026 23:05:22 -0400
X-MC-Unique: mmfyWDemMNW9Ib7eyF-ndg-1
X-Mimecast-MFC-AGG-ID: mmfyWDemMNW9Ib7eyF-ndg_1776740717
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D231955F18;
	Tue, 21 Apr 2026 03:05:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D59E119560B7;
	Tue, 21 Apr 2026 03:05:07 +0000 (UTC)
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
Subject: [PATCH 03/23] tick/nohz: Make nohz_full parameter optional
Date: Mon, 20 Apr 2026 23:03:31 -0400
Message-ID: <20260421030351.281436-4-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15381-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 9684B435BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To provide nohz_full tick support, there is a set of tick dependency
masks that need to be evaluated on every IRQ and context switch.
Switching on nohz_full tick support at runtime will be problematic
as some of the tick dependency masks may not be properly set causing
problem down the road.

Allow nohz_full boot option to be specified without any
parameter to force enable nohz_full tick support without any
CPU in the tick_nohz_full_mask yet. The context_tracking_key and
tick_nohz_full_running flag will be enabled in this case to make
tick_nohz_full_enabled() return true.

There is still a small performance overhead by force enable nohz_full
this way. So it should only be used if there is a chance that some
CPUs may become isolated later via the cpuset isolated partition
functionality and better CPU isolation closed to nohz_full is desired.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++------
 include/linux/context_tracking.h                |  7 ++++++-
 kernel/context_tracking.c                       |  4 +++-
 kernel/rcu/tree_nocb.h                          |  2 +-
 kernel/sched/isolation.c                        | 13 ++++++++++++-
 kernel/time/tick-sched.c                        | 11 +++++++++--
 6 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 95f97ce487a4..f0eedaebe9d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4550,13 +4550,16 @@ Kernel parameters
 			Valid arguments: on, off
 			Default: on
 
-	nohz_full=	[KNL,BOOT,SMP,ISOL]
-			The argument is a cpu list, as described above.
+	nohz_full[=cpu-list]
+			[KNL,BOOT,SMP,ISOL]
 			In kernels built with CONFIG_NO_HZ_FULL=y, set
-			the specified list of CPUs whose tick will be stopped
-			whenever possible. The boot CPU will be forced outside
-			the range to maintain the timekeeping.  Any CPUs
-			in this list will have their RCU callbacks offloaded,
+			the specified list of CPUs whose tick will be
+			stopped whenever possible.  If the argument is
+			not specified, nohz_full will be forced enabled
+			without any CPU in the nohz_full list yet.
+			The boot CPU will be forced outside the range
+			to maintain the timekeeping.  Any CPUs in this
+			list will have their RCU callbacks offloaded,
 			just as if they had also been called out in the
 			rcu_nocbs= boot parameter.
 
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a0922..a3fea7f9fef6 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -9,8 +9,13 @@
 
 #include <asm/ptrace.h>
 
-
 #ifdef CONFIG_CONTEXT_TRACKING_USER
+/*
+ * Pass CONTEXT_TRACKING_FORCE_ENABLE to ct_cpu_track_user() to force enable
+ * user context tracking.
+ */
+#define CONTEXT_TRACKING_FORCE_ENABLE	(-1)
+
 extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a743e7ffa6c0..925999de1a28 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -678,7 +678,9 @@ void __init ct_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
-	if (!per_cpu(context_tracking.active, cpu)) {
+	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
+		static_branch_inc(&context_tracking_key);
+	} else if (!per_cpu(context_tracking.active, cpu)) {
 		per_cpu(context_tracking.active, cpu) = true;
 		static_branch_inc(&context_tracking_key);
 	}
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3337c7231cc..2d06dcb61f37 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1267,7 +1267,7 @@ void __init rcu_init_nohz(void)
 	struct shrinker * __maybe_unused lazy_rcu_shrinker;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+	if (tick_nohz_full_running)
 		cpumask = tick_nohz_full_mask;
 #endif
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 965d6f8fe344..c233d55a1e95 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -268,6 +268,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	}
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
+
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		goto free_non_housekeeping_mask;
@@ -277,6 +278,13 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
+	/*
+	 * Allow "nohz_full" without parameter to force enable nohz_full
+	 * at boot time without any CPUs in the nohz_full list yet.
+	 */
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !*str)
+		goto setup_housekeeping_staging;
+
 	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
 	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
@@ -290,6 +298,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	if (cpumask_empty(non_housekeeping_mask))
 		goto free_housekeeping_staging;
 
+setup_housekeeping_staging:
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
@@ -357,10 +366,12 @@ static int __init housekeeping_nohz_full_setup(char *str)
 	unsigned long flags;
 
 	flags = HK_FLAG_KERNEL_NOISE | HK_FLAG_KERNEL_NOISE_BOOT;
+	if (*str == '=')
+		str++;
 
 	return housekeeping_setup(str, flags);
 }
-__setup("nohz_full=", housekeeping_nohz_full_setup);
+__setup("nohz_full", housekeeping_nohz_full_setup);
 
 static int __init housekeeping_isolcpus_setup(char *str)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9e5264458414..ed877b2c9040 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -676,8 +676,15 @@ void __init tick_nohz_init(void)
 		}
 	}
 
-	for_each_cpu(cpu, tick_nohz_full_mask)
-		ct_cpu_track_user(cpu);
+	/*
+	 * Force enable context_tracking_key if tick_nohz_full_mask empty
+	 */
+	if (cpumask_empty(tick_nohz_full_mask)) {
+		ct_cpu_track_user(CONTEXT_TRACKING_FORCE_ENABLE);
+	} else {
+		for_each_cpu(cpu, tick_nohz_full_mask)
+			ct_cpu_track_user(cpu);
+	}
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.53.0


