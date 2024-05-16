Return-Path: <cgroups+bounces-2936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BE8C7D06
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC81F21E13
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DC15AAD8;
	Thu, 16 May 2024 19:07:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70E158D99;
	Thu, 16 May 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886477; cv=none; b=bFcAjBLzgTQxWQqYtM67IgPXMyjO0yPAGz8h0SqmQYGyyme3YPDTrnbVCrr/P1weELtaC56PiwxPhYUkpU+yBc6ZR/e/l4n1cbTWI9OmCieHDPQIIl7C9UORAo/zLngo72Sm+R2ZWzRugYXxUWSwXf37fMsmV3HTl6A41Rx8s40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886477; c=relaxed/simple;
	bh=YPEFrtuubBM6fnGYCgA5k7qX92z/KFJwSRrSAPfnjAg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYGtrzgbL8Zas3vyp0ENjIW32AdxGq18D0SHjcZT/speNh32lyEpXgFn2riCNkQsWobYyHx+vHWuDmzjkCByqEVIhGv/MQCk5P0NR7/erOQfC9pJHFEPIMj/VjTfgyaGmoNZjXwQaVFqBv5GG9Qi7hhURofpkBYMWeuj2usRROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4202ca70270so9420325e9.3;
        Thu, 16 May 2024 12:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886474; x=1716491274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvtGwduNasaOM3VcnROsPDVP96tMSrEFSnIEu3AfJDc=;
        b=TuJyl23937NbONASA/IvCu639U4Z8YtHDtA8L0R6u8Y1UKEdaOcPKv2gAH77WICEsJ
         VEtQCv+lbUnPaRI0WPaODDU3Bw1k1dzFFCEme/0wqFESssF6awRFrO/kzrS9f2lHUok6
         Czfedd1EoZ2NN8iVxyOZK527ejYcWUymm7YQ4bwulsvALVBNNbnHy9srvgJBJTW3SZFE
         X1slqHR6zcrnR4UfnDfD6KrJCxxjZ+WL1GPbfdkbh4GkI26kH29pcJfRBwEWXqg0onUf
         hf2KQEqGH4UMrl/Y6hCkaTcFhSXfcutnk2RCzgVZMMY85/kYAuwtQeK3WdpBhbI8e6xW
         +SzA==
X-Forwarded-Encrypted: i=1; AJvYcCW1s3p2UOW5c1i3Vo/GRMrqmc1Aj+/UOg8ZBHSYKCQZrUQtv957W4To11RI9b00gFuVjYTG0ipt35n0RRJG6n+4sdFWwag5kGHOVr+F1BhySCL/AjN95gB53lYEdIcjJU96nvc46w==
X-Gm-Message-State: AOJu0YymFyzGRhA3nJwgN+tartaW7N7X0HjAnqmCUi7utUIV0JSbgadT
	et7pLAE+0MaO/JpSJQORMSQ8u8bbaA7Igl/Yn1TWjdVEax6G+7Xz
X-Google-Smtp-Source: AGHT+IFgGf+aabCh2pLx3YMJxIhyC6A8RPl3ErJdma0B1WxABl8AUca89BHiazxnBkPPeU6aqag/Lw==
X-Received: by 2002:a05:600c:3ca3:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-41feac55e3cmr186888035e9.28.1715886474158;
        Thu, 16 May 2024 12:07:54 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:07:53 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	prarit@redhat.com,
	vschneid@redhat.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH v1 2/7] sched/isolation: Adjust affinity of timers according to change of housekeeping cpumask
Date: Thu, 16 May 2024 22:04:32 +0300
Message-ID: <20240516190437.3545310-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516190437.3545310-1-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust affinity timers and watchdog_cpumask according to
change of housekeeping.cpumasks[HK_TYPE_TIMER] during runtime.

watchdog_cpumask is initialized during boot in lockup_detector_init()
from housekeeping_cpumask(HK_TYPE_TIMER).

lockup_detector_reconfigure() utilizes updated watchdog_cpumask
via __lockup_detector_reconfigure().

timers_resettle_from_cpu() is blindly prototyped from timers_dead_cpu().
local_irq_disable is used because cpuhp_thread_fun uses it before
cpuhp_invoke_callback() call.

Core test snippets without infrastructure:

1. Create timer on specific cpu with:

	timer_setup(&test_timer, test_timer_cb, TIMER_PINNED);
        test_timer.expires = KTIME_MAX;
        add_timer_on(&test_timer, test_cpu);

2. Call housekeeping_update()

3. Assure that there is no timers on specified cpu at the end
of timers_resettle_from_cpu() with:

static int count_timers(int cpu)
{
	struct timer_base *base;
	int b, v, count = 0;

	for (b = 0; b < NR_BASES; b++) {
		base = per_cpu_ptr(&timer_bases[b], cpu);
		raw_spin_lock_irq(&base->lock);

		for (v = 0; v < WHEEL_SIZE; v++) {
			struct hlist_node *c;

			hlist_for_each(c, base->vectors + v)
				count++;
		}
		raw_spin_unlock_irq(&base->lock);
	}

	return count;
}

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/timer.h    |  2 ++
 init/Kconfig             |  1 +
 kernel/sched/isolation.c | 27 ++++++++++++++++++++++++++
 kernel/time/timer.c      | 42 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e67ecd1cbc97d..a09266abdb18a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -219,9 +219,11 @@ unsigned long round_jiffies_up_relative(unsigned long j);
 #ifdef CONFIG_HOTPLUG_CPU
 int timers_prepare_cpu(unsigned int cpu);
 int timers_dead_cpu(unsigned int cpu);
+void timers_resettle_from_cpu(unsigned int cpu);
 #else
 #define timers_prepare_cpu	NULL
 #define timers_dead_cpu		NULL
+static inline void timers_resettle_from_cpu(unsigned int cpu) { }
 #endif
 
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f21577..fac49c6bb965a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -682,6 +682,7 @@ config CPU_ISOLATION
 	bool "CPU isolation"
 	depends on SMP || COMPILE_TEST
 	default y
+	select HOTPLUG_CPU
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
 	  any source of "noise" such as unbound workqueues, timers, kthreads...
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 036e48f0e7d1b..3b63f0212887e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,10 @@
  *
  */
 
+#ifdef CONFIG_LOCKUP_DETECTOR
+#include <linux/nmi.h>
+#endif
+
 enum hk_flags {
 	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
 	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
@@ -116,6 +120,19 @@ static void __init housekeeping_setup_type(enum hk_type type,
 		     housekeeping_staging);
 }
 
+static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable_mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, enable_mask)	{
+		timers_prepare_cpu(cpu);
+	}
+
+	for_each_cpu(cpu, disable_mask) {
+		timers_resettle_from_cpu(cpu);
+	}
+}
+
 /*
  * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
  * change.
@@ -144,6 +161,16 @@ static int housekeeping_update(enum hk_type type, cpumask_var_t update)
 	if (!static_branch_unlikely(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
 
+	switch (type) {
+	case HK_TYPE_TIMER:
+		resettle_all_timers(&masks->enable, &masks->disable);
+#ifdef CONFIG_LOCKUP_DETECTOR
+		cpumask_copy(&watchdog_cpumask, housekeeping_cpumask(HK_TYPE_TIMER));
+		lockup_detector_reconfigure();
+#endif
+		break;
+	default:
+	}
 	kfree(masks);
 
 	return 0;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 48288dd4a102f..2d15c0e7b0550 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -51,6 +51,7 @@
 #include <asm/div64.h>
 #include <asm/timex.h>
 #include <asm/io.h>
+#include <linux/sched/isolation.h>
 
 #include "tick-internal.h"
 #include "timer_migration.h"
@@ -2657,6 +2658,47 @@ int timers_prepare_cpu(unsigned int cpu)
 	return 0;
 }
 
+/**
+ * timers_resettle_from_cpu - resettles timers from
+ * specified cpu to housekeeping cpus.
+ */
+void timers_resettle_from_cpu(unsigned int cpu)
+{
+	struct timer_base *old_base;
+	struct timer_base *new_base;
+	int b, i;
+
+	local_irq_disable();
+	for (b = 0; b < NR_BASES; b++) {
+		old_base = per_cpu_ptr(&timer_bases[b], cpu);
+		new_base = per_cpu_ptr(&timer_bases[b],
+				cpumask_any_and(cpu_active_mask,
+					housekeeping_cpumask(HK_TYPE_TIMER)));
+		/*
+		 * The caller is globally serialized and nobody else
+		 * takes two locks at once, deadlock is not possible.
+		 */
+		raw_spin_lock_irq(&new_base->lock);
+		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+
+		/*
+		 * The current CPUs base clock might be stale. Update it
+		 * before moving the timers over.
+		 */
+		forward_timer_base(new_base);
+
+		WARN_ON_ONCE(old_base->running_timer);
+		old_base->running_timer = NULL;
+
+		for (i = 0; i < WHEEL_SIZE; i++)
+			migrate_timer_list(new_base, old_base->vectors + i);
+
+		raw_spin_unlock(&old_base->lock);
+		raw_spin_unlock_irq(&new_base->lock);
+	}
+	local_irq_enable();
+}
+
 int timers_dead_cpu(unsigned int cpu)
 {
 	struct timer_base *old_base;
-- 
2.45.0


