Return-Path: <cgroups+bounces-5109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04999BE04
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BCD1C22216
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEA81741;
	Mon, 14 Oct 2024 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSsytke/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF97D07D;
	Mon, 14 Oct 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875502; cv=none; b=Ff0oimoRmxFR0sACGJ5OXvh56z3EqsUfX4kwnS/61ILdlmqwcSCEDt0VQasM44/lzgivZmhNn1ifM029DAqzr+OH4J11Sg8di5CdCa6jupja02C6X6QOp91PmA7IrLlQ3jccjmToXeo0kRQuqRHBrQqI38X1IQ4huQSCmAN9HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875502; c=relaxed/simple;
	bh=HJP6a2h9/x54OljTWBeq6TmIslcq6mJSw5J+xx53u48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdUxz+qYjAi2qQcKHgJBxXTWHyl4Op2sjozh13E1u6gamG9f3mJAOU3+hmKOk5wLk6yxkjrfjIzswI+HsU0DRFBj6nbdcjxOMJgshVQCrESSfrkVuyBxJJ67DLVvNuMPobM1gTelWV3tDAkviho3AnA2OJVYGpIBxMLtI8uIdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSsytke/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5b2814f6so744482b3a.2;
        Sun, 13 Oct 2024 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728875500; x=1729480300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5golT4Suxm5vj1Uhhhzt+VjmPN8PE6WAYyWdar7nxo=;
        b=jSsytke/p6Wn0U+zrADoiPZS34cK1e8JxWOvqtQ8mZ0V5dTlvFMj9ZMYgQ75zvclqp
         hdzosZmXXbnumOp/2NZogCqEx2tHjdaMZ7k5OEzgDJVHY+AdCHQNOExc59PLPfa5rt5g
         ifMuOdm/XdzVINdMqTKJxbbWkO9l9nIfkNAsEG/9fI7u+dln+Ou19JFrLFvfRJSkc060
         gcj5vFuJ+qDbPxoVJgbUu6g91uIDXwzVsdJpYxuIX0Z+gaYNmN8k4yPHRWNKAC8sW1UX
         T6iErCjo/eV9dd3faqqutkJLOVlZ00l5CYTDKyB5wwJxCcu5nKHa41McQlkYpLYFu3w9
         eaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875500; x=1729480300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5golT4Suxm5vj1Uhhhzt+VjmPN8PE6WAYyWdar7nxo=;
        b=uZsRlHY5I/ztp10RYj4KFgcUeCuvLpeZxDPlW0yPRqSk4PU3nCeF9F49yDV9AgnGOL
         sJSxTTVw9snOT1Q6mdGMQpbQDo3Q/EjbLZXXeBH8DsgO10n2V/Sa214+g8Z7dMgH79h6
         MfY198qPdUPNMeuD3x0AhGZQcoR6tZg3/YwZQKnN+ioRclbwCyITXzBFZjAR3WcEk84X
         r2caPfWo7QiTDPqjgWO/Ggv7qAO5IKqZMT/4/SjoWwZ+uN9XjjDVUVdIbRIvj42iY2LK
         o0ZJQ4zYNJg6mu2/DVPfxwEsz3UCvNtPQYiRUteumsYQXmbVqsn/ciF6Chb0iI27NqES
         H65Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiLm9+zu4BYrlaTGHuqFEd/gP17w+w4VLgphlBB6MsGj2aMPnxzg4jEYfoX3Dsd2gLnkpADKZ86fO80HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBRhA33mH3iNlag/BCJ++t0WlIc9MQ4JvbmfAx8vV2Xxa0Bh7
	jfhmoJMLsBIR2Puuvz5THQ/4Mc/eWRfeLsQW1Z8sD9t8rh6tpgS1
X-Google-Smtp-Source: AGHT+IG/gwGJyn/d5hrBvoW9Srcb8iZ8RocW213bzEkYEyqINf9XYM4y39l3wHXlYWsXKOl+p5EwhQ==
X-Received: by 2002:a05:6a21:393:b0:1d2:f00e:47bb with SMTP id adf61e73a8af0-1d8bcf3e69fmr14923929637.21.1728875499822;
        Sun, 13 Oct 2024 20:11:39 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e396a71sm2987514a12.73.2024.10.13.20.11.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2024 20:11:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 4/4] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Mon, 14 Oct 2024 11:10:57 +0800
Message-Id: <20241014031057.8199-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241014031057.8199-1-laoar.shao@gmail.com>
References: <20241014031057.8199-1-laoar.shao@gmail.com>
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
 kernel/sched/core.c  | 34 ++++++++++++++++++++++++++++++++--
 kernel/sched/psi.c   | 15 +++------------
 kernel/sched/stats.h |  7 ++++---
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b633a14a60f..a99461c04cab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5566,6 +5566,36 @@ __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
 static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
 #endif /* CONFIG_SCHED_DEBUG */
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static void account_irqtime(struct rq *rq, struct task_struct *curr,
+			    struct task_struct *prev)
+{
+	int cpu = smp_processor_id();
+	u64 now, irq;
+	s64 delta;
+
+	if (!static_branch_likely(&sched_clock_irqtime))
+		return;
+
+	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta < 0)
+		return;
+
+	rq->psi_irq_time = irq;
+	psi_account_irqtime(rq, curr, prev, now, delta);
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
@@ -5587,7 +5617,7 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 
 	curr = rq->curr;
-	psi_account_irqtime(rq, curr, NULL);
+	account_irqtime(rq, curr, NULL);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -6667,7 +6697,7 @@ static void __sched notrace __schedule(int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
-		psi_account_irqtime(rq, prev, next);
+		account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 49d9c75be0c8..ffa8aa372fbd 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -992,16 +992,14 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev,
+			 u64 now, s64 delta)
 {
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now, irq;
-	s64 delta;
 
-	if (static_branch_likely(&psi_disabled) ||
-	    !static_branch_likely(&sched_clock_irqtime))
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!curr->pid)
@@ -1012,13 +1010,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	now = cpu_clock(cpu);
-	irq = irq_time_read(cpu);
-	delta = (s64)(irq - rq->psi_irq_time);
-	if (delta < 0)
-		return;
-	rq->psi_irq_time = irq;
-
 	do {
 		if (!group->enabled)
 			continue;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780aa3c53..7c5979761021 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -111,10 +111,11 @@ void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+			 struct task_struct *prev, u64 now, s64 delta);
 #else
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, u64 now, s64 delta) {}
 #endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -197,7 +198,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, u64 now, s64 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.43.5


