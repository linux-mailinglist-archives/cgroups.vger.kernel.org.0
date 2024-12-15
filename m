Return-Path: <cgroups+bounces-5900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA879F2211
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 04:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5357A129D
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C3C13D;
	Sun, 15 Dec 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKwJHLyE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF17BE46;
	Sun, 15 Dec 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233024; cv=none; b=JA4Xz+9P0fuG5MqakgmtcKac/zLpZMJz7H9KCKMWhP/DqwDAihjlqbKVtWDNb72oNvz9tEB7+KQ9OsBdpsAUkcVXea1yP7OfOnfMBkKsyoBN09mu8ghgVCyeLsB0UvfB88Zq5iJIuGx0i274VaKn36hWTIHqm79HeJ+zB1MtVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233024; c=relaxed/simple;
	bh=SNPX4EfxgJ85jzAxQBtGA4qctFecg38aQ1ua4Td2t5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8XCjkly9Ke9DXWd/U2F6kT2rPNQsQbMvsFIjq242EWHNlvu8JIbam65gaC3jT06bdAkOr1hvhsEs9KlN7DPeW1h1Hhg+KvrPbvrmT3n6sM9UEdDGx8y8y4NbSsXPaXaXmIx7sRhZ5YEcnVL/eA7nAwQFWAd3CyXe2p/DA9laKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKwJHLyE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so2276396b3a.2;
        Sat, 14 Dec 2024 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233022; x=1734837822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlcFHISrD5XleVb0eDpHCT0UGjFhU+jp5XrXYYSVbls=;
        b=GKwJHLyEDxh3LfdFDgPoVe3bp9zzF7IdP1aKdeMUB0n+nv5ojNR5oAwRnVUBsRAbTI
         wlNh5JudxJAzSH00z2tPYnHZaLKYLA9McL5uo2+KdnBaYzDG6rY3yqkf/w4hJtoIy5GG
         8LEWA3bSZLiMFmfsrYIDmuc6mM5HuxP540qtK3K+KZRcNqSo36UqP/CFSFP1P9EeL+xX
         AVra04HNYLZSmV6kkarr5zds5iNOtiFR06NaTh2WGn11rTecZgZyCq2QwJ7xhz0GrTFo
         2GWLjB3EgIYFgw8e4FOvh5ij9WXhZyjBVTjbL/3h2oRWKUVcsezoSmSgjZWvaeDVYiX0
         PaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233022; x=1734837822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlcFHISrD5XleVb0eDpHCT0UGjFhU+jp5XrXYYSVbls=;
        b=LiztvW5xngbikxQgUYIwYshvaDjKbeFlQgJVbKw7Wii6QdNnEluyY2Z5kDDExgjbFH
         ANdoF8CtBSqrR/YeZlatC1c7mwWbnddnaJjl7Iblubigq+7yQF3gT1DOGmnerBMmPpdL
         dNC4t4h1+GLhcRPXB20MyKjHcrFveHsOqBWl2/HmfL8X1XcpwPmQsr7+IHBg37WOYKL8
         T9z6NC9WHGlB3AcH0V9fj0UZT3E5tuuyCNw32C2RIuP0N0lE3pLLjH8UJ+rp/TDobs4l
         HmbBs9n84bUf2A5rNhXyDvzF7Tm0uhwuwD4CnoDCGnifQOKMiKnRw358z3ZOMYvV15Qo
         YJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs5N4F541ycZYQUZ8e2MZyNdv2CyWa6PV4ioBxAX/yFjaN7iH+iC6yT9aJW6BNjVt4mN1KBGdCaYn5+XBI@vger.kernel.org, AJvYcCWBaCutmHhXyrm3eBXlNYzi45piB9Ew75PRti7zAIqFySBbEXVDb052cEqReLfiI3C7KSJEyjoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrRESYKm2Dz2NxJTrqoizV9gn97U3AJGdQ1H1JMfQCUbFuASs
	3RWSun2Q2SL20JQ5zsWcdDTmjk0uO8tPaQYn8bOnnhkjToqMSdTZ
X-Gm-Gg: ASbGnctawdFjR63I979qJqHA+/YqnnSCGNdnJta37cKRfUTSBT97xM+OwF5N5MqgSm1
	kVA1DNDgUwspuULqbpVv2r20ZFLU6pt1ZeYEnL9cJql6DZVL3xa+VrNBC6FyZELHkU5O4LYsho1
	GBxgLN3npKUKu0HIbF7C2xzRa+mfoKXJ0Y+lYbJshSnVHMEmdswG+ktezX+p+yLHVJE7jkupZIu
	QUfJuDuZejS9u2bCJlTY/zYzFRjbqq8AyeBkuMBa1yD8j1hMlA3FeS6RxN19uj1rNMkdqSZIxty
	IV08G7Q=
X-Google-Smtp-Source: AGHT+IE5HvOgkTTToCtWzeJMvFIMGWPY1+8ZEeVewiPMo0n/M8Wf2FR/N7vOTzFNq+S0YBQF3i70ZQ==
X-Received: by 2002:a05:6a21:789d:b0:1db:ff9c:6f3a with SMTP id adf61e73a8af0-1e1dfe05229mr12942954637.42.1734233021853;
        Sat, 14 Dec 2024 19:23:41 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f1esm2176586b3a.92.2024.12.14.19.23.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Dec 2024 19:23:41 -0800 (PST)
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
Subject: [PATCH v7 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Sun, 15 Dec 2024 11:23:15 +0800
Message-Id: <20241215032315.43698-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241215032315.43698-1-laoar.shao@gmail.com>
References: <20241215032315.43698-1-laoar.shao@gmail.com>
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
index 893d454c82ae..68657444efb9 100644
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


