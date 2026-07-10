Return-Path: <cgroups+bounces-17641-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mdCnNeJpUGoLygIAu9opvQ
	(envelope-from <cgroups+bounces-17641-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C52473708F
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CPjSwQ1+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17641-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17641-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F043051DE3
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF27367B9D;
	Fri, 10 Jul 2026 03:29:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43913224F3
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654189; cv=none; b=fJR10Wj1jbS+9uJrf4wfnooqAtFTg0u0JZWHYKSwDpkXn3xDUcy96aYaolaAehktUDdC+VLZuj7eEg8eaXie9tx4t1rNk0G/TLhrTpLh65T9Bx64nbTkGpDgQkw1DXfVY/ZRzfYxW3k8Nuq3IacxWOVsb4TmeS3aGAq44czl9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654189; c=relaxed/simple;
	bh=Fu7ulrEF9vMTmeYkdDPOqk6yNZOJFGTqTgSUSx/HiFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIjGs9K5WDfI3zN9oc1xEqCWLVpTWGAmolK4K51FGYubivdd63sl9LofWGPGZV3VE5lmx1UJB4LENZssvyUCT953rWmRZpNyzn8+7XsxP6pf0bCHMDaf0zXnq9TETkloi7dlfm2+Ss4UMGWe3Y0zB6LIdBpJn+aOdWGu8LWnx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPjSwQ1+; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so3186965ad.3
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654188; x=1784258988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csN4cJukbkvLe5YqSWgDpZ0W4w2lD/0lFTHmWQ8kViM=;
        b=CPjSwQ1+Uh+vPpiUN05+zQHyfSzuyXF4e3gROBnIIoc2rU4Ll0devqaPDVA9FCir8o
         5LVYRJITVLiku3cPATljGHQ1eB1yHBR20dcFXTuo+talptIz++27a0LM6nhRWs0K7Hwa
         wxACCtUNOziunFnY7mbMCo627vNHOktUsBl5DIJ0G+xZQ8SEnWua8BPiGENm0X3fT7lv
         uhg9/zkRaDLCxUU4fiaSUPbryuaJ4bQUwalWRnKnkP6dnv3kNXATI2umjMHm4zsmx8Ju
         ybXTCKBjPEVV0n3jNhEOJbweOsBBCq69kmyrSwG0/rnJZUu/9eX01RydiiYGnLkwtJsn
         MvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654188; x=1784258988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csN4cJukbkvLe5YqSWgDpZ0W4w2lD/0lFTHmWQ8kViM=;
        b=ENk5MUyXIakkbc6QbfoCTPZ0c2E0cUshrzBVRwtgE7Y+Fz5/5QTf2XzRI840pSXb+f
         asIyLRSEe32Lr6eWs/hrQGM5bm9v1u13ydYv2jnuEgvU4XlglQiuGwl1TrzkF3BCd8+m
         lkvyxMG3xBPRz5UYEaZ78bWn9Us30HCvjcYfHQyp3F74K73RgqqqQIzxaqM6kUTPWHmi
         mhsTNYrngqOUySLUCjMNgILLoJB8fzVB5x46YvfiemD3NsNBG45ImTHhsuAhcF4dDHXj
         dlSFZuWC9ra9/h8bFeFvyA32MYiUldE72ACnWFPDh7PqZ+iiUwPOPrDj1ov64ik1OGYr
         nx1A==
X-Forwarded-Encrypted: i=1; AHgh+RqCa0YsnOGz2I/rDd6lyZO12DOtLxo4+65WAw1Cv84RqrJk5zDU8vjg2Qm5dYkHfmjFI8n6Gq1H@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbZjRizExKRJMk7x3Tqj9KJZq8UUbBnPbgPqtofFshOn1uEC8
	En9J42+jBq3BvyZ21EQcypEM00gMV0s9ra10B2lCukc0NAsYLswyyASO
X-Gm-Gg: AfdE7clOmeVAnRpgi8Vwc79MMNf+14eAOTuudAQqXQo6bHTNAD5tQKthhk/Li26hmPq
	Zc66aKLV+x8D+gpz/V+rJXKQEsFnlxSVMkJ8a94fuR+L3r1bPUwyTxhUNuQfffwzHaD4MpxWtZ1
	p85F4sK5/dsmvAbhwbw/ME9RFt0TvbmMzZ6qH/ZceGZj09oOvE5irhoaECaa2iBZqVSa6DtQK+n
	z1OovPDaHDAUTk0MEL2oN0iadVb2CXcpomzBIuhIHn7wnTz5HwRWOggOuAqhaiu0l1qxGpDeER5
	C2fDi13ZjiK2pYQ4r7RXfaf02TvWrRB40tmjOPecfQGKWPGLLvTbLCfEZBlY+XZsAcQPrm6oNMY
	sSN8ALP5YeDuz+m8xAAOkYICRYtOyGt1YlHG8AXLsqR04rPI8TeRLMcuEqtWM2M8RJs0IPtOKC0
	BwxlzXcU7Sw1w=
X-Received: by 2002:a17:903:2990:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2ccf4d46bd1mr83112295ad.24.1783654187634;
        Thu, 09 Jul 2026 20:29:47 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:47 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:20 +0800
Subject: [PATCH v4 09/11] cpuset: drive kernel-noise isolation via per-CPU
 hotplug cycling
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-9-2e912e5d9645@gmail.com>
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
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17641-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C52473708F
X-Spam: Yes

Track A (cpuset_update_sd_hk_unlock) updates the HK_TYPE_KERNEL_NOISE
and HK_TYPE_MANAGED_IRQ cpumasks but performs no per-CPU reconfiguration.
Tick suppression, RCU callback offloading and managed-IRQ remapping only
take effect when the affected CPUs pass through the CPU hotplug machinery.

Implement dhm_cycle_isolated_cpus() and call it from
cpuset_update_sd_hk_unlock() after all cpuset and hotplug locks are
released so that remove_cpu()/add_cpu() may acquire cpus_write_lock
without violating the cpu_hotplug_lock > cpuset_top_mutex order.

On isolation, for each newly-isolated CPU:
  1. remove_cpu()              - offline; dying callbacks migrate IRQs
  2. tick_nohz_cpu_isolate()  - add to tick_nohz_full_mask, enable
                                 context tracking (B0/B3)
  3. rcu_nocb_cpu_isolate()   - lazy nocb init, spawn kthreads, offload
                                 callbacks (B1)
  4. add_cpu()                 - online; tick and IRQ online callbacks
                                 reconfigure against updated HK masks

On de-isolation, the reverse order is applied.  The managed-IRQ
remapping requires no explicit call: irq_migrate_all_off_this_cpu()
(dying callback) and irq_affinity_online_cpu() (online callback)
already consult the updated HK_TYPE_MANAGED_IRQ mask.

dhm_prev_isolated tracks the previous isolation set so that only CPUs
whose state changed are cycled rather than the full isolation set.
lockup_detector_hk_update() (B2) is called once after all CPUs are
cycled to update the watchdog mask.

CPUs with hotplug disabled (e.g. x86-64 boot CPU) cannot be taken
offline and are skipped.  On any remove_cpu() failure the corresponding
CPU is cleared from dhm_prev_isolated so the next isolation attempt
will retry rather than silently treating it as already isolated.
Symmetrically, a de-isolation remove_cpu() failure re-sets the bit in
dhm_prev_isolated so the CPU remains tracked as still isolated.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 kernel/cgroup/cpuset.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 62eb6798a0c3e..d9e121bf14292 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -20,6 +20,8 @@
  */
 #include "cpuset-internal.h"
 
+#include <linux/cpu.h>
+#include <linux/cpuhplock.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -33,7 +35,9 @@
 #include <linux/sched/task.h>
 #include <linux/security.h>
 #include <linux/oom.h>
+#include <linux/nmi.h>
 #include <linux/sched/isolation.h>
+#include <linux/tick.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
@@ -164,6 +168,14 @@ static cpumask_var_t	isolated_hk_cpus;	/* T */
 static DEFINE_SPINLOCK(dhm_cycling_lock);
 static cpumask_var_t	dhm_cycling_cpus;
 
+/*
+ * Snapshot of the isolated CPUs from the previous housekeeping update.
+ * Used to compute the delta (newly isolated / newly de-isolated) so that
+ * only the changed CPUs are cycled rather than the full isolation set.
+ * Protected by cpuset_top_mutex.
+ */
+static cpumask_var_t	dhm_prev_isolated;
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -1339,6 +1351,84 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+/*
+ * dhm_cycle_isolated_cpus - Apply kernel-noise isolation via hotplug cycling
+ *
+ * For each CPU newly entering isolation: cycle it offline, configure tick
+ * suppression and RCU callback offloading while it is offline, then bring
+ * it back online.  The managed-IRQ state is handled automatically by the
+ * existing irq_migrate_all_off_this_cpu() dying callback and the
+ * irq_affinity_online_cpu() online callback which both consult the
+ * already-updated HK_TYPE_MANAGED_IRQ mask.
+ *
+ * For each CPU leaving isolation: cycle it offline, de-offload RCU and
+ * restore the tick, then bring it back online.
+ *
+ * Must be called without any cpuset or hotplug locks held.
+ */
+static void dhm_cycle_isolated_cpus(const struct cpumask *new_isolated)
+{
+	cpumask_var_t newly_isolated, newly_deisolated;
+	int cpu;
+
+	if (!alloc_cpumask_var(&newly_isolated, GFP_KERNEL) ||
+	    !alloc_cpumask_var(&newly_deisolated, GFP_KERNEL)) {
+		free_cpumask_var(newly_isolated);
+		return;
+	}
+
+	cpumask_andnot(newly_isolated, new_isolated, dhm_prev_isolated);
+	cpumask_andnot(newly_deisolated, dhm_prev_isolated, new_isolated);
+	cpumask_copy(dhm_prev_isolated, new_isolated);
+
+	if (cpumask_empty(newly_isolated) && cpumask_empty(newly_deisolated))
+		return;
+
+	/* Mark cycling CPUs so cpuset_hotplug_update_tasks skips invalidation */
+	spin_lock(&dhm_cycling_lock);
+	cpumask_or(dhm_cycling_cpus, newly_isolated, newly_deisolated);
+	spin_unlock(&dhm_cycling_lock);
+
+	for_each_cpu(cpu, newly_isolated) {
+		if (!cpu_is_hotpluggable(cpu)) {
+			pr_warn_once("cpuset: CPU%d cannot be isolated (hotplug disabled)\n",
+				     cpu);
+			cpumask_clear_cpu(cpu, dhm_prev_isolated);
+			continue;
+		}
+		if (remove_cpu(cpu)) {
+			pr_warn_once("cpuset: failed to offline CPU%d for isolation\n",
+				     cpu);
+			cpumask_clear_cpu(cpu, dhm_prev_isolated);
+			continue;
+		}
+		WARN_ON_ONCE(tick_nohz_cpu_isolate(cpu));
+		WARN_ON_ONCE(rcu_nocb_cpu_isolate(cpu));
+		WARN_ON_ONCE(add_cpu(cpu));
+	}
+
+	for_each_cpu(cpu, newly_deisolated) {
+		if (remove_cpu(cpu)) {
+			pr_warn_once("cpuset: failed to offline CPU%d for de-isolation\n",
+				     cpu);
+			cpumask_set_cpu(cpu, dhm_prev_isolated);
+			continue;
+		}
+		WARN_ON_ONCE(rcu_nocb_cpu_deoffload(cpu));
+		tick_nohz_cpu_deisolate(cpu);
+		WARN_ON_ONCE(add_cpu(cpu));
+	}
+
+	spin_lock(&dhm_cycling_lock);
+	cpumask_clear(dhm_cycling_cpus);
+	spin_unlock(&dhm_cycling_lock);
+
+	lockup_detector_hk_update();
+
+	free_cpumask_var(newly_isolated);
+	free_cpumask_var(newly_deisolated);
+}
+
 /*
  * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
  *
@@ -1386,6 +1476,13 @@ static void cpuset_update_sd_hk_unlock(void)
 		WARN_ON_ONCE(housekeeping_update_types(noise_types,
 						       isolated_hk_cpus));
 		mutex_unlock(&cpuset_top_mutex);
+
+		/*
+		 * All cpuset and hotplug locks are released.  Cycle each
+		 * affected CPU through hotplug to activate tick suppression,
+		 * RCU callback offloading and managed-IRQ remapping.
+		 */
+		dhm_cycle_isolated_cpus(isolated_hk_cpus);
 	} else {
 		cpuset_full_unlock();
 	}
@@ -3717,6 +3814,7 @@ int __init cpuset_init(void)
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&dhm_cycling_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&dhm_prev_isolated, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);

-- 
2.43.0


