Return-Path: <cgroups+bounces-5802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F9B9ECD0B
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B9B282985
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91A5236908;
	Wed, 11 Dec 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYQuxN7s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0F2368F7;
	Wed, 11 Dec 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923097; cv=none; b=sBtu0llm4NrS/ssvBFmecPrabUTiNsee6CapJi+lRkj3ogoa92L6JvuovEfAnmTRzT7SMl0BeYTJ3xVpby5kx9prfs5j7H1h533GRklCb5oRGoRaVNC8aap4tEUd+s0vKRXf8gbqUDZuoBBmDTEy9Geu33ikmAFPd9PKW1VEb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923097; c=relaxed/simple;
	bh=0nPHnor7nHwzRB+2pWju/d6pFw1bPo1wapd6R1Uqq9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwhVmN3g7GN1gOqRnIj+t5cpxXoSK4uEgJzB6GhL7+zw6hA+cN8RkEIbXhfe1tgluCU1fjM4V9Fs6vqFQQoG7KP5KIbwgYP5fGUB44rjXPHsmyxcYJDEvXeQhayQM89Dx2tTn/mVw5tFdCSC2Pb2+dFeydqFvFURJbEzqFAbypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYQuxN7s; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728e3826211so1417999b3a.0;
        Wed, 11 Dec 2024 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733923095; x=1734527895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEsuW6xrVYcwy+l9jRBOUVbolWKY/E8cX1evWjlrM9A=;
        b=kYQuxN7sBpnZluOSpGkfARnvm7muyuq07NTJf1dWypVguGUQSW0nE8mGNhDO4lVwQn
         hkoZUL2JN3+TbzjzVpGOHqEfxTYRYXtZarKQHKqp4t0pXDUOoszwnxIbeaNvjcjXjgvV
         yhcEPu+2FSQ8RncFxqfL80btOjxCCeEpG5DtntKxHgbmjCPOmHn3frKCB6JC+Hcfsj4B
         SAI8ERJZ0VrSXbhfTEp7DH6bU1yyXhD0vaPBgw0lRg5HP2ZZ/hSbsUM+6IZnZDevMtnk
         eyQlURxO5unM0kVXzH4rAFjjf9EtIqTUZ+u/DwS9xLDYkPN12g7B2FVDSd1/sA0jC2SG
         lZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923095; x=1734527895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEsuW6xrVYcwy+l9jRBOUVbolWKY/E8cX1evWjlrM9A=;
        b=F5YeZIn7bhdiX8CHbkrXxTa2hDkcRxwknCzwZR7HEg5PJFT32Au83i/JfNR8jakSgc
         7qFeqw/MLv2V+K+9Ud2eDmsffnmBFxi/QctDzySGt9xEMEaUV/qS631CknQUuYYSy72n
         PcLgrLag/voxFIcQfBNzKfgaEz3D7tLRaJkZekJW2Xuxh5bDGDetIxuN1JPyLRfpGQO5
         nEeKrzKDhR+Zt9+fJ8OoKq/zorHnwmCwB99N/FShsh7UEzfF0yXDzVSuG7nyIewz7mRA
         odX6MgWO/HdRVEXbbwabceliQPIXZfutIBSYjUmQBRbzmrn/tYJYR4aVJwtwUnhKvrAC
         jt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4YcBVS+vMe+tJ7uVrfGfTVRwJpQqDbPp4TpzfAgUoyy7Mlv/JStMPAuhYY2RPll+WLKf0FvO@vger.kernel.org, AJvYcCUd91mnyUtc7gPRp7saBoX0xJuKvaRz7xArknsyeqRExnyylvvURdkI/RR6LTEw3YtPRN/R87dae2e1kLYK@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8SwVidQycGXl0rIro2+qXmKXW+EBaZ7dYJQMK7eFeVMEgvhd
	wTXKshQdCCravX4kVU2L5Y97okqQXftv1qZhK4jxHD0vY05teqX9
X-Gm-Gg: ASbGncvKjh9dkhU1pz/BQ3djxQJnLyMTWutVePWLuFsRy0BPYi+SuQco5t2La6Mjx4q
	8MQqncBbZ7WWCZ/RBTbtmRhLtJ65fQspdork/gEj+dszQ8nrpgjyflKBKUusebAbTZUwc7XNMmK
	fl4srLNbudZ8S+3Bc5gNIwU5IKODzavVag68mVZZSYEjIiVHyMfZXVrV6WNIVYGg4KqJxbWLl6G
	9KBn2NSB94gnhi7vfZEtQ8IicLbKLvRPvkmZmIUPEqcC6/K7D/Eitz7PMVC1AZumQFQs2InDZYw
	85Hh
X-Google-Smtp-Source: AGHT+IEKnUknPfSY2YGuF8kUHgT1E2xf6sfPu7asatsIw6sT5Oi6r2qwtNLSQWDHXngXRLpt1v0uSg==
X-Received: by 2002:a05:6a00:179b:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-728ed3dca59mr4559921b3a.10.1733923095031;
        Wed, 11 Dec 2024 05:18:15 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeb536a1sm5272628b3a.115.2024.12.11.05.18.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Dec 2024 05:18:14 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Wed, 11 Dec 2024 21:17:29 +0800
Message-Id: <20241211131729.43996-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241211131729.43996-1-laoar.shao@gmail.com>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling CONFIG_IRQ_TIME_ACCOUNTING to monitor IRQ pressure in our
container environment, we observed several noticeable behavioral changes.

One of our IRQ-heavy services, such as Redis, reported a significant
reduction in CPU usage after upgrading to the new kernel with
CONFIG_IRQ_TIME_ACCOUNTING enabled. However, despite adding more threads
to handle an increased workload, the CPU usage could not be raised. In
other words, even though the container’s CPU usage appeared low, it was
unable to process more workloads to utilize additional CPU resources, which
caused issues.

This behavior can be demonstrated using netperf:

  function start_server() {
      for j in `seq 1 3`; do
          netserver -p $[12345+j] > /dev/null &
      done
  }

  server_ip=$1
  function start_client() {
    # That applies to cgroup2 as well.
    mkdir -p /sys/fs/cgroup/cpuacct/test
    echo $$ > /sys/fs/cgroup/cpuacct/test/cgroup.procs
    for j in `seq 1 3`; do
        port=$[12345+j]
        taskset -c 0 netperf -H ${server_ip} -l ${run_time:-30000}   \
                -t TCP_STREAM -p $port -- -D -m 1k -M 1K -s 8k -S 8k \
                > /dev/null &
    done
  }

  start_server
  start_client

We can verify the CPU usage of the test cgroup using cpuacct.stat. The
output shows:

  system: 53
  user: 2

The CPU usage of the cgroup is relatively low at around 55%, but this usage
doesn't increase, even with more netperf tasks. The reason is that CPU0 is
at 100% utilization, as confirmed by mpstat:

  02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
  02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0.00    0.00    0.00    0.00

  02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
  02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0.00    0.00    0.00    0.00

It is clear that the %soft is excluded in the cgroup of the interrupted
task. This behavior is unexpected. We should include IRQ time in the
cgroup to reflect the pressure the group is under.

After a thorough analysis, I discovered that this change in behavior is due
to commit 305e6835e055 ("sched: Do not account irq time to current task"),
which altered whether IRQ time should be charged to the interrupted task.
While I agree that a task should not be penalized by random interrupts, the
task itself cannot progress while interrupted. Therefore, the interrupted
time should be reported to the user.

The system metric in cpuacct.stat is crucial in indicating whether a
container is under heavy system pressure, including IRQ/softirq activity.
Hence, IRQ/softirq time should be included in the cpuacct system usage,
which also applies to cgroup2’s rstat.

The reason it doesn't just add the cgroup_account_*() to
irqtime_account_irq() is that it might result in performance hit to hold
the rq_lock in the critical path. Taking inspiration from
commit ddae0ca2a8fe ("sched: Move psi_account_irqtime() out of
update_rq_clock_task() hotpath"), I've now adapted the approach to handle
it in a non-critical path, reducing the performance impact.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c  | 33 +++++++++++++++++++++++++++++++--
 kernel/sched/psi.c   | 13 +++----------
 kernel/sched/sched.h |  2 +-
 kernel/sched/stats.h |  7 ++++---
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2a8d3d8da25..cf14ea8649df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5579,6 +5579,35 @@ __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
 static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
 #endif /* CONFIG_SCHED_DEBUG */
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static void account_irqtime(struct rq *rq, struct task_struct *curr,
+			    struct task_struct *prev)
+{
+	int cpu = smp_processor_id();
+	s64 delta;
+	u64 irq;
+
+	if (!irqtime_enabled())
+		return;
+
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->irq_time);
+	if (delta < 0)
+		return;
+
+	rq->irq_time = irq;
+	psi_account_irqtime(rq, curr, prev, delta);
+	cgroup_account_cputime(curr, delta);
+	/* We account both softirq and irq into CPUTIME_IRQ */
+	cgroup_account_cputime_field(curr, CPUTIME_IRQ, delta);
+}
+#else
+static inline void account_irqtime(struct rq *rq, struct task_struct *curr,
+				   struct task_struct *prev)
+{
+}
+#endif
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -5600,7 +5629,7 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 
 	curr = rq->curr;
-	psi_account_irqtime(rq, curr, NULL);
+	account_irqtime(rq, curr, NULL);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -6683,7 +6712,7 @@ static void __sched notrace __schedule(int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
-		psi_account_irqtime(rq, prev, next);
+		account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, block);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 6836c34d063e..7341d33d9118 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -990,15 +990,14 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev,
+			 s64 delta)
 {
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	s64 delta;
-	u64 irq;
 
-	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!curr->pid)
@@ -1009,12 +1008,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	irq = irq_time_read(cpu);
-	delta = (s64)(irq - rq->psi_irq_time);
-	if (delta < 0)
-		return;
-	rq->psi_irq_time = irq;
-
 	do {
 		u64 now;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38aceb7289b7..09d920e8556c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1223,7 +1223,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
-	u64			psi_irq_time;
+	u64			irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 767e098a3bd1..17eefe5876a5 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -111,10 +111,11 @@ void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+			 struct task_struct *prev, s64 delta);
 #else
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, s64 delta) {}
 #endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -215,7 +216,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, s64 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.43.5


