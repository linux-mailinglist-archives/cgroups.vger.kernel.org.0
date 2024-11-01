Return-Path: <cgroups+bounces-5365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354199B89E9
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 04:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D11F241A4
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E31465BA;
	Fri,  1 Nov 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC5kQXZE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504C146000;
	Fri,  1 Nov 2024 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431111; cv=none; b=YhmBbGfX/HEqiamoQCR1Dj28NiwMtWPLjDdzPrszJVq9rH2tpWztXrJUeOV1THq4AnsFSuX7bKCVXrQdmIP5HcGtWue2zePhOyGcgXm//FJ/982g138NhZqwlIm3FxGjjd/62j7RaGYQxm+A6QWCRdC9E1Aw1L1m35fmGJwHhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431111; c=relaxed/simple;
	bh=C4kHVk8yGOp97R24xFKPOimMNvvcGIgopcVjcE0Zn/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnyAsCCWWURnAOYvU08x8VbAAIZnsYfW9AU3CiLpav2Fwp3kQ5xYlVjCkOvftqDE3Ffszkj3RFRBo/u7OPEiC5Jg2ohRgJi5kEQ+luYsqf3uxXp3glrYZk/8zJParEI0d1/LsdIw1wDNjh5IK9uICEDo3wo+e6wSPH5T3IwtP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC5kQXZE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d01caa66so204954b3a.2;
        Thu, 31 Oct 2024 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431107; x=1731035907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2vaxuzgksXz4yWA/68x9ijGVuyFQOHqmQ3f7bHhuGo=;
        b=dC5kQXZE4KOjm9zD//QXu1If6OrS33nItIMTT7P4T5I0+niQl4ZeMRCR02rSkIfRPn
         QcKn1+Y6zUmYUpbtsBHJYT68O+wVHkPgZt81ThQ19Ekt3G8VkFwAcqNzxkrAxlo5/Ed0
         97HNVKNAgZyfn+lLKVpVbcfupZTIthiWBweEwqB2ioRX4jEYu/cDf3HaJJNYVJZZdPse
         XRpeTWaEshxQdaAl7vTE6wducpqtOQfN/mF/JShOTJ1aJD9Ztk/U0m1yLGgXCg8xwXlI
         UTk5K+r6yavM8yuxc4Z7ReUPp9Uox5ufISCC4bgz3dIBC5tif2yYW8aNA2BoWnqVQ1RY
         Db9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431107; x=1731035907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2vaxuzgksXz4yWA/68x9ijGVuyFQOHqmQ3f7bHhuGo=;
        b=VibMGK7atRBO2hMYnP8O5sqm1xrTeH5uBKrS6AJoVj30FctmoBLJkMxTNtvYz1mI/4
         7pASKp2kSbEWkbVXQAHx6g9T1GzTQtnLh6YPIiZqYEBz7bvpluZcOODSxUhQqBofZQlz
         Qo1QnGJ79q2WaJMWVThKINCjCJf8HcCBclrpnd97UTrPQMVKUBUSFBj+JoQ6/xlAXGIq
         vvHVzi2pMP2yNzdlbp6PscMW5EX22GBZOmgGVChLlX6VSqUuJKZX5NvdZBa/X4aElSkz
         t5+n5Kmej4kQzCH9GmmxA3lp3ORKWcqCDGn2xoH5vKKzHLp0kgsJjwHUsGlSsHs7XnK/
         76jw==
X-Forwarded-Encrypted: i=1; AJvYcCVLzQcFfCANBK7Rb4pm6hyMjqvBNRrteUI5BWajlGm7C04MAjGdHrpCA/l77VuSat3Y+5mciY1b@vger.kernel.org, AJvYcCX/pq720R3+bT5Lqpaz1hy7Pa/ZyWFtPvqdKi/doF5uG3QeO0sIo9VIw+Dg0qbzGYQL8tHilJujUUogifUe@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYHDPnI8hbuILZ4VkagVgb8h9OfRsI7lT2IFPwDulLjIJ+z+o
	FiEblUxzHFIATWqn8nDRbHh0MwABnN8hmrbMuKr6F+1EzSvWLWaKEXPCYe+dyrBRtw==
X-Google-Smtp-Source: AGHT+IGkEDI6zIr7JO0DhH4ibPacIo0wpRogVp3awtFen42qJnMvrwJkCvWL8v+TAtCOElaKOipqMQ==
X-Received: by 2002:a05:6a00:2e22:b0:71e:6fcb:7688 with SMTP id d2e1a72fcca58-720b9ddb773mr7326970b3a.25.1730431107149;
        Thu, 31 Oct 2024 20:18:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.44.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31af9dsm1854445b3a.217.2024.10.31.20.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 20:18:26 -0700 (PDT)
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
Subject: [PATCH v4 4/4] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Fri,  1 Nov 2024 11:17:50 +0800
Message-Id: <20241101031750.1471-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241101031750.1471-1-laoar.shao@gmail.com>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
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

It is clear that the %soft is not accounted into the cgroup of the
interrupted task. This behavior is unexpected. We should account for IRQ
time to the cgroup to reflect the pressure the group is under.

After a thorough analysis, I discovered that this change in behavior is due
to commit 305e6835e055 ("sched: Do not account irq time to current task"),
which altered whether IRQ time should be charged to the interrupted task.
While I agree that a task should not be penalized by random interrupts, the
task itself cannot progress while interrupted. Therefore, the interrupted
time should be reported to the user.

The system metric in cpuacct.stat is crucial in indicating whether a
container is under heavy system pressure, including IRQ/softirq activity.
Hence, IRQ/softirq time should be accounted for in the cpuacct system
usage, which also applies to cgroup2’s rstat.

This patch reintroduces IRQ/softirq accounting to cgroups.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/core.c  | 33 +++++++++++++++++++++++++++++++--
 kernel/sched/psi.c   | 14 +++-----------
 kernel/sched/stats.h |  7 ++++---
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06a06f0897c3..5ed2c5c8c911 100644
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
+	if (!static_branch_likely(&sched_clock_irqtime))
+		return;
+
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta < 0)
+		return;
+
+	rq->psi_irq_time = irq;
+	psi_account_irqtime(rq, curr, prev, delta);
+	cgroup_account_cputime(curr, delta);
+	/* We account both softirq and irq into softirq */
+	cgroup_account_cputime_field(curr, CPUTIME_SOFTIRQ, delta);
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
index 4d26a106f03b..1adb41b2ae1d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -990,16 +990,14 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
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
 
-	if (static_branch_likely(&psi_disabled) ||
-	    !static_branch_likely(&sched_clock_irqtime))
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!curr->pid)
@@ -1010,12 +1008,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
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


