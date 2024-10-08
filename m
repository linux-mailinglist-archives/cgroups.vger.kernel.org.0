Return-Path: <cgroups+bounces-5061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E29993EE2
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DCD1C206FD
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE11C3F27;
	Tue,  8 Oct 2024 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhWyvaCv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0612190463;
	Tue,  8 Oct 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368569; cv=none; b=VvdiK5oCYsg21WxND/J+0RZnarW8GSZO0SPENRyRA9Cxs01Gib0y0GaDUMidTeh7I4J0LiewAwSUtI+LtPoMZEZUMbpQINRjrknIGZgcU4ElbLfOSC/VLkYefQEYiSuoeRbWcXXRv+liY5Y2fbZ5t+EY378UwNlHzP6yMNM6nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368569; c=relaxed/simple;
	bh=86UgX/mbty8uWpIMTjQSPIXrHh3bYdC5nmoLRupt7Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s23RhAFSNC3/7V7Qfg0/ctKY+1/371s4aF/jidfmve5wk1lG+Id/bkCLzl8HqU5+5uDXTWTu/4Pavd2l+2oeW6YnIE6qTckAGlyl9pBhF+Tm/fJPJIIjJ36j8m7QjG77tDRAnwoR678x8khFa3FBOX+yRUpxuVgGykMiKn/RVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhWyvaCv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3296971a12.2;
        Mon, 07 Oct 2024 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368567; x=1728973367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CREL76g3HNxkv23W1Xe5cLsUMj2uTYl1300sEXcL2Wo=;
        b=NhWyvaCvfcOjziqSYVQxjdRbGyo1Lyj2fieNaOAKwC8SomjlDRlzk0c9Rp5EJfNy8f
         I3/SSba6lwVejEya8ttMs6asIOV9CLLk78JEg4nrGnDb2NH8yiIomYw5exIvdYwwwphl
         tDIW7Au/cm1VJrU9z2HzHKQjzZajPn0v7MnZqWkfSvEQa32W7tLjb0XgcHyG+QAABFgN
         3u4MbfnEsHznU7cfjuDdeKo30kLyFaG+9UWW7XJdCqT9kjnE1rydHod+Q4PZ/rUApTlk
         kl7gXjBelUND4yOFdSc04h8liZB+B/ZZlA1EI6YHUcZLWxYxYrPBEm7LLCew5CW378Q0
         mfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368567; x=1728973367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CREL76g3HNxkv23W1Xe5cLsUMj2uTYl1300sEXcL2Wo=;
        b=ZRi0c6r/pwJ0invsjAOryp8r7px83sXt5K9ByEUmrGZB1XBMWNdSdA69Ke9p410aCa
         kwRglLs1A0K6Xqct95ISB2iUbUV5z7Znk4fOS9kD+jHQmE1PNJID43WmCKzyS7ZjJUrP
         saF6ivqdhW9QU18WrHjqYKqkingyiVn9XB5UCUV/wxd70xDyOB71SZEBa/7vqnkKxCiA
         4dVVzTF4Iy/pUkO3QjhiIr9dmuKE8xtwcopT24JC/50rsk7jLmMuLkRjH4hGO0iCuTZ7
         GVjtzV7DdSlNlqBnbt9qrHZmYWq7mCkJniKUqyR8bK0MxgkbFaCLuODLb+EgS8Zo2Q4L
         BYCA==
X-Forwarded-Encrypted: i=1; AJvYcCWQnANmGWIzFxfMuxi9COiVnD9cFedjt7JUG0Ddemyk6vVpqbZ3CcKAm/csczAqsCuwTq6G72poSsSEngA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4kjsi7joxCuQcUEoqOuMPdbtm8ZKFi12rIAVv/k1R7vNz9T5
	yCIuaweM8V0/DBQ1GF9AGjtEK82KQtBCxvwiVKcRc2By3kAzVgceqz/Uu5qf0+0=
X-Google-Smtp-Source: AGHT+IEGVu1GOoUdoVNewOPD2PejpPcmOyTHW1Lx20GCF66jj3PCbYeYhczjd4kPCVGPEEQ30XNeFQ==
X-Received: by 2002:a17:90b:b14:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2e1e63bbf13mr16444269a91.35.1728368566981;
        Mon, 07 Oct 2024 23:22:46 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm8357525a91.18.2024.10.07.23.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:22:46 -0700 (PDT)
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
Subject: [PATCH v2 4/4] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Tue,  8 Oct 2024 14:19:51 +0800
Message-Id: <20241008061951.3980-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241008061951.3980-1-laoar.shao@gmail.com>
References: <20241008061951.3980-1-laoar.shao@gmail.com>
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

This behavior is unexpected. We should account for IRQ time to the cgroup
to reflect the pressure the group is under.

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
---
 kernel/sched/core.c  | 39 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/psi.c   | 15 +++------------
 kernel/sched/stats.h |  7 ++++---
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b633a14a60f..533e015f8777 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5587,7 +5587,24 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 
 	curr = rq->curr;
-	psi_account_irqtime(rq, curr, NULL);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	if (static_branch_likely(&sched_clock_irqtime)) {
+		u64 now, irq;
+		s64 delta;
+
+		now = cpu_clock(cpu);
+		irq = irq_time_read(cpu);
+		delta = (s64)(irq - rq->psi_irq_time);
+		if (delta > 0) {
+			rq->psi_irq_time = irq;
+			psi_account_irqtime(rq, curr, NULL, now, delta);
+			cgroup_account_cputime(curr, delta);
+			/* We account both softirq and irq into softirq */
+			cgroup_account_cputime_field(curr, CPUTIME_SOFTIRQ, delta);
+		}
+	}
+#endif
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -6667,7 +6684,25 @@ static void __sched notrace __schedule(int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
-		psi_account_irqtime(rq, prev, next);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+		if (static_branch_likely(&sched_clock_irqtime)) {
+			u64 now, irq;
+			s64 delta;
+
+			now = cpu_clock(cpu);
+			irq = irq_time_read(cpu);
+			delta = (s64)(irq - rq->psi_irq_time);
+			if (delta > 0) {
+				rq->psi_irq_time = irq;
+				psi_account_irqtime(rq, prev, next, now, delta);
+				cgroup_account_cputime(prev, delta);
+				/* We account both softirq and irq into softirq */
+				cgroup_account_cputime_field(prev, CPUTIME_SOFTIRQ, delta);
+			}
+		}
+#endif
+
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


