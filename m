Return-Path: <cgroups+bounces-5481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B050D9C1E14
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5F1F2133B
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8D1F1319;
	Fri,  8 Nov 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKJqoFqm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3521F1308;
	Fri,  8 Nov 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072581; cv=none; b=pMYNsh37S0Qoyh+J5Uh8hzCyGZUde3JlW00cGRKneBFUVZRiJWZNEMZ1VOCJKdxKHERX23/80kaqApKahFrRfMqKha6JRqL+NVq31JstsmbX+jOvr5h0CVeVxRI3SchWe6H+a5e2a3vLJmWdq9Th9B3SkQ1PbZXyB6XqA6Z9CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072581; c=relaxed/simple;
	bh=p4IdLRBAI4i4tclu8JnMt2nvytFeCZIaKF2dwGdnWjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnJanf+SwHxhQzuSoO0XHs6NGJw1kdMRKpCmjFQKLGZ2n2z9Cg5vkby0Jo7fntxiXMpIS2Si+A0uClHY4UJD0QWgefl99fKGpz+XCFXQrPEh1HkCNE53QOhz7dkcDQhyp5d63NJ3uhF3+WoPkv//TzTlv4PlEi3qMa7+qDU3uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKJqoFqm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720c2db824eso2208883b3a.0;
        Fri, 08 Nov 2024 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072579; x=1731677379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwj397Wxnt9kp22qzTuTHo57hB6xPUyU9ek/jjGs02U=;
        b=MKJqoFqm5u/qjZKuKqRkjfCE1NeVt1Iy1OM8iSYsEPzIqLfJUfMQegFIZw2FwVTgkA
         2y3+4reGpWnLH1UEFqPudFmsscdLlU2IKw178VI0vGKwPKhfNxufJwc9FRS4c3e/9kai
         cBMMLDzLHTsl8mfnevHLBZ3sFkCV21JVqSTD9SjlhrMUUl4zA0JySgLCX9hScHE+C8TC
         weCUnvkQ2zoE2aJdjLjeLF6JMg6p9W4zfdh5+JiDvJvoM1hT7LgJF7933WrVRNwFSVRQ
         M7HeMIv2fvzX+oZwE4OPzLLSADwkmGBX8wW8FQai/iSoh5bTqygk9QmFWG5MDlNJaA6L
         uePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072579; x=1731677379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwj397Wxnt9kp22qzTuTHo57hB6xPUyU9ek/jjGs02U=;
        b=lHwyXHcCH+nPVozLevyVECz8wogNjvYBV7EGsf9ByzvDY/y7NwOxNXPTvxcMyiDiZ/
         4tCvpMzT4tI37uSHINyZs3ncck/zeMeW7d7Ol48NZyxXVn9QFLkhdQULwSPzEvMcssJB
         QlhsZMCEAWT2ZVZ4TU3wSn0gO0zC9/5PEqdYaEEJ3+yMA8YCrzV5MxYuyj3FZu6CzNSA
         DnL5vDRj8DerSCIa3Iw1tx3IAPngOyQet3XiC62hMhQKvH/pH3cqlhadRAjX0/zjGvSY
         CLE73cegBPVUKLXC9985+Jk/W165uFXvXnGwKpaEh8nwtyMMXM3gPybd8rPY8jMTqFaG
         0HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg4N+vFcDBI5x3V8Zuji5a+B0brsnupNdcMcggGa15UOvgF2u7tRQYa4HxiQt3CZHR49kZQ+DM@vger.kernel.org, AJvYcCXzlq9SOuxztLl0j7YU80hw37S3kFD8z6pG1Rza4+4UGiq+uBVFMfjRgq90eKcNpX4cS0VGwSAUvc1zo4ws@vger.kernel.org
X-Gm-Message-State: AOJu0YxEafUF0NapGLFaaq2qjM47GL12lDwyArDJr9y1Aqr767ux4x87
	mQUiR1WuW3Q2wMbvP/kyFlDuDm/aNeemSrrredLCfil2ntMdiAqs
X-Google-Smtp-Source: AGHT+IFUDoeABPnImbn3piDnHO/WytS+iVznYw2BlqmngWWX5JNqpLZU6n/owlQl3ABz7QXviJwloA==
X-Received: by 2002:a05:6a00:1307:b0:71e:6728:72d5 with SMTP id d2e1a72fcca58-724132c1a44mr3850160b3a.15.1731072579060;
        Fri, 08 Nov 2024 05:29:39 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm3642561b3a.86.2024.11.08.05.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:29:38 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Fri,  8 Nov 2024 21:29:04 +0800
Message-Id: <20241108132904.6932-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241108132904.6932-1-laoar.shao@gmail.com>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
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
---
 kernel/sched/core.c  | 33 +++++++++++++++++++++++++++++++--
 kernel/sched/psi.c   | 13 +++----------
 kernel/sched/sched.h |  2 +-
 kernel/sched/stats.h |  7 ++++---
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a75dad9be4b9..61545db8ca4b 100644
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
index 210aec717dc7..1adb41b2ae1d 100644
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
index 0c83ab35256e..690fc6f9d97c 100644
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


