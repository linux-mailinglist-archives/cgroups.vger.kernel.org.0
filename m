Return-Path: <cgroups+bounces-6039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E571A002BA
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19637162FFE
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF22E401;
	Fri,  3 Jan 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iac178Ln"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB5190688;
	Fri,  3 Jan 2025 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871095; cv=none; b=AXu9o6nLppaQoeB04eywXAdY2ZN2OU1KoqvqWjycmkZcyyVjFDwv+aAtFmDwY8RIU5Q5ti0N1haLlG+FquDHATeNMbaKqs8xucyy9ev14NBxjUTkm8KrNzyoDlGbXxnvdWupv8Mr1MLT5mI9cz6Kz9FjeUNNn7xY+4UBMyGmNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871095; c=relaxed/simple;
	bh=KEU7CWczGDLyD7YwHYxR3y7xe8tazXwkEwl9zxlXFls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ3ykyYyWsk/6ZF3oKdWhME3s0QW5XGouMVFzDUlcb1PrX+3RS0GUcxlEKWphi/NkpifhZ2uyNbupn7MIORZx9XAcGBMMXzBma2Zjg1CFMLfwH5hQUqbnM8wRBSywacUebiQlH0jMh6vfQ33qD3Ej05d9NQNkPwth2vV4YuKnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iac178Ln; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165448243fso196581655ad.1;
        Thu, 02 Jan 2025 18:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871092; x=1736475892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avljg6opUL/YIQ884XhrX8PNb9qrQzwcO+9J8KL8WNo=;
        b=Iac178LnMUTCMViSmANU3RdzgKvnrxY6UNN5kcxuxVbbLdUYq1Bxp3IIHbxDZ7fboI
         a0tD8ugGOLROwfFt8hNq0ak4RUFjbGCvQM3m6EMcMBp2FqfYKvNt19PCBNvEtSrLvLdt
         CC0LRW1VjWoCQ7SFju6ns0gmYTGnB3UH38MaVHLSVHApVGRT63QEpQkxcoZUt4PxxBau
         4rLe/gbi3dep64uxHznjEBGTF4QXAZfAUWM53p78g3OLgTRtYjq/1VQ6RqNcnqUqXD/0
         JwzhEGw6X4KETendbnK2KMpl/gJWCQ5WKbs4RuuuI08R+69FTncLWHtWT1YUcaEcjnkm
         dQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871092; x=1736475892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avljg6opUL/YIQ884XhrX8PNb9qrQzwcO+9J8KL8WNo=;
        b=DNPx0Kh44gpaILQhZtWl85JMfka1uE55Q2tpmO85cj/GnAF2/gDETBtt4ZhdmEahuR
         /t08BKomUPf1aPGVt88LxtEMPv9q1nuMcBu6ScoakRTEErQixyyqFnMn+tXUxipoco+9
         YTHO28EmQUaYFEAhBAE/vVatxG1K6WBzzEwedkWYYxr9EO2TQ2/Eh8SrZ9qSqZkpGTRk
         p9822fJdHlC+FINdSY9RnRIb0Jak6WxkHwbxiwj2psMlkBxExD18beOV6yZ3HvsEv/tU
         R4uBwwrDaT0ek89G+FpjnkW/dLTXnd+qhL11RvZxeGC7zClwTe7ywvag8i0Sq/QfLM6k
         kFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6EABUEWxZS0qwY+bNpooMndieatjNituUKgG1p58trum9Y1Q66upHHOgdgB8zHKzK4KA8xJ9WOkXY3qas@vger.kernel.org, AJvYcCV6deXNbcpu/dKWE+9xYWR21LJlOw6x790Wo3+QPxt2piBwT/4QGL6sGH0YDmGRjQA1J7umSTv3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nSAERO5HHdT9F8oBzZaIJOT1SQiEow8vnzwhKHk3ME/Wh1cJ
	mIanUXHnEqjI63dP15pVaYbWQrmbuIncdHpe3gKqSwWnxd71asdn
X-Gm-Gg: ASbGncsPX4svwgMLvgVzXkdhPxHt1Jo+FTNcfHgEpJxvf7W79j4LOGomeWmqFMGsBJb
	WY5oqpGCtHpbThTt+imQEqchv+8svH9CzIeG6VLnbujL2hGY73s5naZWzTb55+WdJSYjgkY37sx
	3yWSBEzPBPdGcZLJuz9AzfM27Md23MhXp4WtZV7WZSVowzSQHWFC1Kuq1F9lKYHuduNXs8QHxbg
	SjP2et/1jocC1qNdAzrogL8D/eWANqwDmZuqwvYcPyH1eYI8iqgoIRZXbztcD1oVgSkN2xuMcWg
	XVO5wtM=
X-Google-Smtp-Source: AGHT+IHBk2iQ2PW4PxELu2coNq5s3P9s/AA319Toiatpmai8xVat5IMDzQXHiLBCQ50YuN3XU5IlpQ==
X-Received: by 2002:a17:903:32c6:b0:216:25a2:2ebe with SMTP id d9443c01a7336-219e6e9fb3amr701989925ad.19.1735871092453;
        Thu, 02 Jan 2025 18:24:52 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca007f3sm234184145ad.228.2025.01.02.18.24.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jan 2025 18:24:52 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: mkoutny@suse.com,
	hannes@cmpxchg.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Fri,  3 Jan 2025 10:24:09 +0800
Message-Id: <20250103022409.2544-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250103022409.2544-1-laoar.shao@gmail.com>
References: <20250103022409.2544-1-laoar.shao@gmail.com>
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
index 22dfcd3e92ed..7faacf320af9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5622,6 +5622,35 @@ __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
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
@@ -5644,7 +5673,7 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 	donor = rq->donor;
 
-	psi_account_irqtime(rq, donor, NULL);
+	account_irqtime(rq, donor, NULL);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -6751,7 +6780,7 @@ static void __sched notrace __schedule(int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
-		psi_account_irqtime(rq, prev, next);
+		account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, block);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index bb56805e3d47..6fa3233fcba9 100644
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
index 7e8c73110884..570cc19a0060 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1227,7 +1227,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
-	u64			psi_irq_time;
+	u64			irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 8ee0add5a48a..b9ed9fea5ab7 100644
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
@@ -224,7 +225,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, s64 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.43.5


