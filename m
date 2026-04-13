Return-Path: <cgroups+bounces-15255-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNiiBB2f3Gk7UgkAu9opvQ
	(envelope-from <cgroups+bounces-15255-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:45:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F13E873E
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C36C30333B8
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27587397E6D;
	Mon, 13 Apr 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyfAsS+n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416163988F1
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066236; cv=none; b=lk7Z7qov1c5dPnjRrGQxMxtePeBv5USXaDwTd4Ku/P21fM2s5liKbbIw6jzYxGeKyJ2joqNpB8+JRGXdkZSGO5o3clMxlLOhuoT702lUXqNC1vqaDEpDXI6RIfC1aLBpARXLYlL7Qfh7EeDKPwCoXfOD2WQA1HKjWQkPCGkWRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066236; c=relaxed/simple;
	bh=a/odz2uw4gvTIjw/tTNRaOxlb3XXkQnfh9vxBJlDOpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mpi2btu9pO6eMnK7/uo9IfZ75dIOgGtHArN7SyetNRpBLMe6fKj7ftaz6OcXJiBeFAoEJ1/jppkMy4zJQIjLJBkLwGbRgsDWRAGE4Mh2S7YcoW2IN+R8hfuWoxls3/ciBiWJLnlt4C7f2RGLjOt+CTCoY6jrv/96FyLG4ET75bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyfAsS+n; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c1fcce8f8so6903306c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066234; x=1776671034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dq7A9F2uS9NBzcitrHUera4fwiqvquYPVtGYt+ZQHw=;
        b=LyfAsS+nyWB4jM85ExsVjPVvONfdxlrGTJBDdlw40d7Q59DquWHE7QDP7+H0x9IKv+
         peEFhobLpVxIll5J8SnBhZzaHVaQ07/B7n/s/LV+1E18QTjtrlZJHJBZbc6mcaVspnBp
         bzO0gWgPcXL1SccRJG6kSYRAUa18PJE9i7xWDkJA3gMId0NYYd2FOAUyY2D2IfNe9fJ5
         cUo+uruc5CcVD1cOAgvSwv6S6CSWZub/aWg278MdwGkFZqDx1QgZCzJrKYbS2808MEgV
         NjIxbOnChqBwR4wEqo9WZCnLAajeHcNfE4oZiOWbrK69aiUhjCdQ7bq17MmKnpEYfkLS
         1eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066234; x=1776671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dq7A9F2uS9NBzcitrHUera4fwiqvquYPVtGYt+ZQHw=;
        b=nGSRfCwco5QZxE/WysrSs0HIon/hU4ImV3jq26JLoYyLRX7p3GtIQRuEQBsF0Um4/X
         NOz2t+FUOPD5hMwHdlm5Wy7u9dAEcF4RDf4L77dmss75aSU9DQftWeoqXRNH4EgXmiR/
         ZSlDEuI3G77dD5A+d3lTKuBVGn4DCT8zjwaxac42X1ix+Gsvn3UWEUN/168J2V8X9YuR
         PYfdCcDZvfVIHrl2MUKWtr6II9kBH+wBv4Gu2FfMiUyFsgfnNSV3ZfHyQS6Huj4rAwPg
         ijTXEd/7s0CJ4P/gkNwWyLusrFiJVgGxR8w/NNCNRF/8DPAfarNwt3lqLk9pHOn9gpZh
         RKKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wRkTZvvZIkjBZNEhPdWzcC5v4dMRzLyeVPAra9Evfu2BrdJqCPiQP0Ljn8wtpG6OKKqtQr6JS@vger.kernel.org
X-Gm-Message-State: AOJu0YzJc5ZFTFh5SQfIs3wFVzTtqbF9UMtQmsFftriaXDn1HIKBAhJk
	iSRxxPoElpc84JNf890RhEX5l32uRdDqhbG71EvHqIUh+5ituG0CCj/H
X-Gm-Gg: AeBDieus4VS2i5tipouLVUdYj1OymT4EtDqElP28lMZY/0R9OxER6I7AvilOkRngGO2
	WHKv6dSLn37CwHIMBxck7i8Y6xdafL/4XxB6zU/YdgBLH7p6q2oomjNn/QYOQm6UEnFZI1qEz3o
	kdQl70bd1LT/We74ePIp0wZWlWoIPQA26KgBSqRVETRPxZ/x1QasJyoR18BXcQWQcc+JkzgdQDS
	gMAPGHr2Nxe+mbDxCuSeS7ZOFUPNAC1+KUncN7wXez14PZ2PtGjhjk5o0Wblcx0hh6kujLCLGMN
	KPCkGV7AuUFiDIXSp8G9NCL+RMcjdwXRIzkBs+X/JBm0f52Y47c3nfH6jjV1VCkoauuA5rWDH5X
	wBcZhHfzjKkIFEBIzyWHMXQPbrlk3mgNVPvK0i/z54pXWOIdCLZR8rx6kjgG4sRJrHehdX4Ij+T
	+uL/foYWSjRD792D/K
X-Received: by 2002:a05:7022:439f:b0:128:d5f1:d594 with SMTP id a92af1059eb24-12c34e7b83amr6713439c88.10.1776066234304;
        Mon, 13 Apr 2026 00:43:54 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:54 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:09 +0800
Subject: [PATCH v2 03/12] rcu: Support runtime NOCB initialization and
 dynamic offloading
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-3-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15255-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 846F13E873E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Context:
The RCU Non-Callback (NOCB) infrastructure traditionally requires
boot-time parameters (e.g., rcu_nocbs) to allocate masks and spawn
management kthreads (rcuog/rcuo). This prevents systems from activating
offloading on-demand without a reboot.

Problem:
Dynamic Housekeeping Management requires CPUs to transition to
NOCB mode at runtime when they are newly isolated. Without boot-time
setup, the NOCB masks are unallocated, and critical kthreads are missing,
preventing effective tick suppression and isolation.

Solution:
Refactor RCU initialization to support dynamic on-demand setup.
- Introduce rcu_init_nocb_dynamic() to allocate masks and organize
  kthreads if the system wasn't initially configured for NOCB.
- Introduce rcu_housekeeping_reconfigure() to iterate over CPUs and
  perform safe offload/deoffload transitions via hotplug sequences
  (cpu_down -> offload -> cpu_up) when a housekeeping cpuset triggers
  a notifier event.
- Remove __init from rcu_organize_nocb_kthreads to allow runtime
  reconfiguration of the callback management hierarchy.

This enables a true "Zero-Conf" isolation experience where any CPU
can be fully isolated at runtime regardless of boot parameters.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/rcu/rcu.h       |  4 +++
 kernel/rcu/tree.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 31 +++++++++++++--------
 4 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9b10b57b79ada..282874443c96b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -663,8 +663,12 @@ unsigned long srcu_batches_completed(struct srcu_struct *sp);
 #endif // #else // #ifdef CONFIG_TINY_SRCU
 
 #ifdef CONFIG_RCU_NOCB_CPU
+void rcu_init_nocb_dynamic(void);
+void rcu_spawn_cpu_nocb_kthread(int cpu);
 void rcu_bind_current_to_nocb(void);
 #else
+static inline void rcu_init_nocb_dynamic(void) { }
+static inline void rcu_spawn_cpu_nocb_kthread(int cpu) { }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e8..84c8388cf89a1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4928,4 +4928,79 @@ void __init rcu_init(void)
 #include "tree_stall.h"
 #include "tree_exp.h"
 #include "tree_nocb.h"
+
+#ifdef CONFIG_SMP
+static int rcu_housekeeping_reconfigure(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	struct task_struct *t;
+	int cpu;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_RCU)
+		return NOTIFY_OK;
+
+	rcu_init_nocb_dynamic();
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		bool isolated = !cpumask_test_cpu(cpu, upd->new_mask);
+		bool offloaded = rcu_rdp_is_offloaded(rdp);
+
+		if (isolated && !offloaded) {
+			/* Transition to NOCB */
+			pr_info("rcu: CPU %d transitioning to NOCB mode\n", cpu);
+			if (cpu_online(cpu)) {
+				remove_cpu(cpu);
+				rcu_spawn_cpu_nocb_kthread(cpu);
+				rcu_nocb_cpu_offload(cpu);
+				add_cpu(cpu);
+			} else {
+				rcu_spawn_cpu_nocb_kthread(cpu);
+				rcu_nocb_cpu_offload(cpu);
+			}
+		} else if (!isolated && offloaded) {
+			/* Transition to CB */
+			pr_info("rcu: CPU %d transitioning to CB mode\n", cpu);
+			if (cpu_online(cpu)) {
+				remove_cpu(cpu);
+				rcu_nocb_cpu_deoffload(cpu);
+				add_cpu(cpu);
+			} else {
+				rcu_nocb_cpu_deoffload(cpu);
+			}
+		}
+	}
+
+	t = READ_ONCE(rcu_state.gp_kthread);
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+
+#ifdef CONFIG_TASKS_RCU
+	t = get_rcu_tasks_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	t = get_rcu_tasks_rude_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rcu_housekeeping_nb = {
+	.notifier_call = rcu_housekeeping_reconfigure,
+};
+
+static int __init rcu_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&rcu_housekeeping_nb);
+	return 0;
+}
+late_initcall(rcu_init_housekeeping_notifier);
+#endif
+
 #include "tree_plugin.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb18..f3d31918ea322 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -517,7 +517,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
-static void __init rcu_organize_nocb_kthreads(void);
+static void rcu_organize_nocb_kthreads(void);
 
 /*
  * Disable IRQs before checking offloaded state so that local
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3337c7231ccb..36f6c9be937aa 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1259,6 +1259,22 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 }
 #endif // #ifdef CONFIG_RCU_LAZY
 
+void rcu_init_nocb_dynamic(void)
+{
+	if (rcu_state.nocb_is_setup)
+		return;
+
+	if (!cpumask_available(rcu_nocb_mask)) {
+		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
+			pr_info("rcu_nocb_mask allocation failed, dynamic offloading disabled.\n");
+			return;
+		}
+	}
+
+	rcu_state.nocb_is_setup = true;
+	rcu_organize_nocb_kthreads();
+}
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1276,15 +1292,8 @@ void __init rcu_init_nohz(void)
 		cpumask = cpu_possible_mask;
 
 	if (cpumask) {
-		if (!cpumask_available(rcu_nocb_mask)) {
-			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
-				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
-				return;
-			}
-		}
-
+		rcu_init_nocb_dynamic();
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
-		rcu_state.nocb_is_setup = true;
 	}
 
 	if (!rcu_state.nocb_is_setup)
@@ -1344,7 +1353,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
  * for this CPU's group has not yet been created, spawn it as well.
  */
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
+void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
@@ -1416,7 +1425,7 @@ module_param(rcu_nocb_gp_stride, int, 0444);
 /*
  * Initialize GP-CB relationships for all no-CBs CPU.
  */
-static void __init rcu_organize_nocb_kthreads(void)
+static void rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;
@@ -1668,7 +1677,7 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 	return false;
 }
 
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
+void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 }
 

-- 
2.43.0


