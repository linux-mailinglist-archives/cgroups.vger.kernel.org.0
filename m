Return-Path: <cgroups+bounces-2939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702318C7D0E
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930261C23A25
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1815B98C;
	Thu, 16 May 2024 19:08:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F26A003;
	Thu, 16 May 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886521; cv=none; b=ApmzzFzWmzEwnmZfNGjYTIxJsLZFL/GzKNztlBmycpAD/V2QIvdAY05km7NOIjRcQjXmQzRWlFaJtCwPhC7lqc+jhheh2XxEdR602agfTKgmc73C+yIo+Veq+FWFrwYS2ibxgxA/vSBPZ8efHIVnp6RzccY2kRYNQ4YbWMoDmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886521; c=relaxed/simple;
	bh=qStgHo+1zCUhiaWSXasLfZGf4XCdux/rCja3KMmaySw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2adltyfv+0cX5qCb7xdi1qDWlRT/IHBZVLJybRlKFCyhPrHNOjgu8qlLiy1tZcJ4f1tbAlvBlSl+zlnYv6kNvNkYUdWpB3GOsUPkNRjbfnda1F8R4DJ+c9u6Yfdygzv1NlnDfq0VD2SIYY+6mjobdcwz+YBKGgjc65+z8f8620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b59b7so31911075e9.0;
        Thu, 16 May 2024 12:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886518; x=1716491318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIB+O4v6/5R1ePF27G37Z2akXQzewaP8o/SKYVuDf5E=;
        b=sNxzzp44TYjX2koC1tBqP6NPYzwgTlXfjuF5q8NPMubv4r0E1mL94FDS2U1OSvXRkT
         nwmUVdhUS2njFoOml1wRvi5ynmlV1nazFlFqdbRifpM1XDmKlyqageWi7/Up8dNeGHvj
         xkuHPFVWh7OtrfXLPXtdjmp9P2jh5XrHzVsoyL7QJsA6yppXf67B0qzDK8QDwO+2vj4S
         j54cpigr15P3aRJrYYgLdumU6SP65rMjmejupUa3aXDUhdwlSLR0cC18i0t1tQdZj/qV
         AiWvDrz+EEVVPJUbwYbUeyRGmalehh0O40EXtcVw6ram9r/HB8F2BmV/K9+h541CA20b
         malw==
X-Forwarded-Encrypted: i=1; AJvYcCWZsKbRjrhxh39AilB5qF/fX6zwctFOmqdl3y0HQNZo8WYtDxIbzCCBNQaSy1xGXlfZOjAz3aZmTL7/X7/IhU6hii/llvbdL2Ogyi+aspMf+i/oWSdT+WXZeeKm5wwymio0RTXngA==
X-Gm-Message-State: AOJu0YyYlIH2EFIxBnZq1SyO9R2xKyq4DLgnfehvuJZbgh3RBfolfE+6
	CtHngpOCF6ZbxoTUmCYcVfPrvp6YnvtmQjQFhkgDTTocMCnJjE6K
X-Google-Smtp-Source: AGHT+IFh+715UhOK52DQvslqbyTnIlzBxZSHjl77sULY7U9THXtl4Z4HXFLZN69E+KDzXhSAytm8BA==
X-Received: by 2002:a05:600c:19c8:b0:41f:e720:eec9 with SMTP id 5b1f17b1804b1-41feac59c27mr148033985e9.25.1715886488140;
        Thu, 16 May 2024 12:08:08 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:08:07 -0700 (PDT)
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
Subject: [PATCH v1 3/7] sched/isolation: Adjust affinity of hrtimers according to change of housekeeping cpumask
Date: Thu, 16 May 2024 22:04:33 +0300
Message-ID: <20240516190437.3545310-4-costa.shul@redhat.com>
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

Adjust affinity of watchdog_cpumask, hrtimers according to
change of housekeeping.cpumasks[HK_TYPE_TIMER].

Function migrate_hrtimer_list_except() is prototyped from
migrate_hrtimer_list() and is more generic.

Potentially it can be used instead of migrate_hrtimer_list.

Function hrtimers_resettle_from_cpu() is blindly prototyped
from hrtimers_cpu_dying(). local_irq_disable() is used because
cpuhp_thread_fun() uses it before cpuhp_invoke_callback().

Core test snippets without infrastructure:

1. Create hrtimer on specific cpu with:

        set_cpus_allowed_ptr(current, cpumask_of(test_cpu));
        hrtimer_init(&test_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
        test_hrtimer.function = test_hrtimer_cb;
        hrtimer_start(&test_hrtimer, -1,  HRTIMER_MODE_REL);

2. Call housekeeping_update()

3. Assure that there is only tick_nohz_handler on specified cpu
in /proc/timer_list manually or with script:

grep -E 'cpu| #[0-9]' /proc/timer_list | \
	awk "/cpu:/{y=0};/cpu: $test_cpu\$/{y=1};y"

Another alternative solution to migrate hrtimers:
1. Use cpuhp to set sched_timer offline
2. Resettle all hrtimers likewise migrate_hrtimer_list
3. Use cpuhp to set sched_timer online

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/hrtimer.h  |  2 +
 kernel/sched/isolation.c |  2 +
 kernel/time/hrtimer.c    | 81 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb6158..004632fc7d643 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -381,8 +381,10 @@ extern void sysrq_timer_list_show(void);
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 int hrtimers_cpu_dying(unsigned int cpu);
+void hrtimers_resettle_from_cpu(unsigned int cpu);
 #else
 #define hrtimers_cpu_dying	NULL
+static inline void hrtimers_resettle_from_cpu(unsigned int cpu) { }
 #endif
 
 #endif
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3b63f0212887e..85a17d39d8bb0 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -126,10 +126,12 @@ static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable
 
 	for_each_cpu(cpu, enable_mask)	{
 		timers_prepare_cpu(cpu);
+		hrtimers_prepare_cpu(cpu);
 	}
 
 	for_each_cpu(cpu, disable_mask) {
 		timers_resettle_from_cpu(cpu);
+		hrtimers_resettle_from_cpu(cpu);
 	}
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14aac642b..7e71ebbb72348 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2201,6 +2201,87 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 }
 
+/*
+ * migrate_hrtimer_list_except - migrates hrtimers from one base to another,
+ * except specified one.
+ */
+static void migrate_hrtimer_list_except(struct hrtimer_clock_base *old_base,
+				struct hrtimer_clock_base *new_base, struct hrtimer *except)
+{
+	struct hrtimer *timer;
+	struct timerqueue_node *node;
+
+	node = timerqueue_getnext(&old_base->active);
+	while (node) {
+		timer = container_of(node, struct hrtimer, node);
+		node = timerqueue_iterate_next(node);
+		if (timer == except)
+			continue;
+
+		BUG_ON(hrtimer_callback_running(timer));
+		debug_deactivate(timer);
+
+		/*
+		 * Mark it as ENQUEUED not INACTIVE otherwise the
+		 * timer could be seen as !active and just vanish away
+		 * under us on another CPU
+		 */
+		__remove_hrtimer(timer, old_base, HRTIMER_STATE_ENQUEUED, 0);
+		timer->base = new_base;
+		/*
+		 * Enqueue the timers on the new cpu. This does not
+		 * reprogram the event device in case the timer
+		 * expires before the earliest on this CPU, but we run
+		 * hrtimer_interrupt after we migrated everything to
+		 * sort out already expired timers and reprogram the
+		 * event device.
+		 */
+		enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
+	}
+}
+
+/**
+ * hrtimers_resettle_from_cpu - resettles hrtimers from
+ * specified cpu to housekeeping cpus.
+ */
+void hrtimers_resettle_from_cpu(unsigned int isol_cpu)
+{
+	int ncpu, i;
+	struct tick_sched *ts = tick_get_tick_sched(isol_cpu);
+	struct hrtimer_cpu_base *old_base, *new_base;
+
+	local_irq_disable();
+	ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+	old_base = &per_cpu(hrtimer_bases, isol_cpu);
+	new_base = &per_cpu(hrtimer_bases, ncpu);
+
+	/*
+	 * The caller is globally serialized and nobody else
+	 * takes two locks at once, deadlock is not possible.
+	 */
+	raw_spin_lock(&old_base->lock);
+	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
+	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
+		migrate_hrtimer_list_except(&old_base->clock_base[i],
+				     &new_base->clock_base[i],
+				     &ts->sched_timer);
+	}
+
+	/*
+	 * The migration might have changed the first expiring softirq
+	 * timer on this CPU. Update it.
+	 */
+	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+
+	raw_spin_unlock(&new_base->lock);
+	raw_spin_unlock(&old_base->lock);
+	local_irq_enable();
+
+	/* Tell the other CPU to retrigger the next event */
+	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
+}
+
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
-- 
2.45.0


