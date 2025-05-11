Return-Path: <cgroups+bounces-8128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6CAB264B
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 05:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DF3189AC1E
	for <lists+cgroups@lfdr.de>; Sun, 11 May 2025 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA512D1F1;
	Sun, 11 May 2025 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfqGLWzv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA961632D7;
	Sun, 11 May 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746932915; cv=none; b=i5wkMBGd3ofWCXx9FoujQlpe/Pz0R0sPOiVcP1Vani2TZ49U1Kj9g/pVbOBI/rr3sJUmSac6hp6BgPLLRGvyiZfGqHmN3w2SN1cLk3WNo1MNDm1mMYIvWq+VmtLdJPrkGI67KIVgJe6wPhVSWB2jw1U0aEwhVz3JKv7bpe/+eKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746932915; c=relaxed/simple;
	bh=MQEsQHR3gRve3q2ofgvAZApoif+uVZYs6z9H/I8Zi7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtOykp20LBgfOsbB9pzBltoLRudqqk0qL6P7nvMXU5GkLv+XWFGNHY9uixfUwsgO9flH6cTN4kI7QFS+uo/2PtDG7sqm2XN5cF/wb3Cy42ePt+gkK4B/HosrtPqdEl/GMNeX83ST5SL1kwIhAAnry3C/WqRDWl68Q+2RGdJAdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfqGLWzv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74237a74f15so3147161b3a.0;
        Sat, 10 May 2025 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746932912; x=1747537712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt7RuWvxVmDNymBvAA2iervDVjFxk6KLxIbmPbMBI7s=;
        b=BfqGLWzvWb2RDu/Tkn1mBjk+4VWl/Te3DJ+wBTnFY2LsleJZXKeYI2KoOD9qQfy31s
         60oJwj2vtUTGLWClgcIGOYOXLy5VpnSrq8VJf81/SDqJzqd8hNqGavTREUfzuqgdWLk0
         r2s7m7klYKX/1MQmS9iN7WctvKqDhkhSD7FpVsSrQ0fHT/ge9Jli37xc6TjF2VswkCDN
         9JWaghXVNhEYYVB0H5Hk8cdCY0eHDfL/t4ssMBiKFXsPCMHF4T+qp3OsmjafFFpXhfO0
         dZtCpDnwJ3yDXIYDd1tgNELxovLy54DlfdZlg3NynvH4fCt4+mOdioDCmIhQAmXfGvSP
         XHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746932912; x=1747537712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt7RuWvxVmDNymBvAA2iervDVjFxk6KLxIbmPbMBI7s=;
        b=mizOB639IVMBtTcDs9dap/hBHjnLO0LImc8ftOjzk5xlLBxs4RTye7yzJiMh2+/RIV
         SOZ4PDUCXh0DKugO5sQuKMVRcUxVhHfYr9SNbPCRmQp6uCDdZM4PffoWHYPsn3sPOlkp
         a4EE1cxcKQDYqRsY5kOrUummDvgH/jng7bbY+yjOyDfHsZ6gJeui0iKiXSzbAtfrGlL2
         +DnPFPB21aA8fZx6BWaDn6CD4NaYygIYndmBeS8F1/YZWifLn5+qX905DrPtrDnlu8Dc
         lyiGYFGAqtRGtmhn9lo8LVKxrpDDsgoLSNHB5LdhFIvVQOs+YOgtU604Q5AF1F5OsLy+
         mHGg==
X-Forwarded-Encrypted: i=1; AJvYcCVzaMptTcHjd3D+wRa9ZZib2DpVhzS9FucqUJmvmmAj/ZYVsdTRDZ3wem9o+Zgqup8O8ScP2WviBwy9m53n@vger.kernel.org, AJvYcCWJ/nDC6CwisIWyDx1yYywBnG5E5z83szbOdSAIPaNUp2JWqVZibKuKWSMscoczwXTttFQ1523w@vger.kernel.org
X-Gm-Message-State: AOJu0YwS80ZSy3zuJA1QTy9VfraTdDBJLMiCCMGkJCJJL1b3kQ1xIyjU
	AfBuclhZ1UMkotzhfbMQeT3VG2+9GrbxHdv7aTf0dk1yj2e22M+2
X-Gm-Gg: ASbGncvoj8a5KPXMNC1lbSXro/iZcGZNmerqgoDaFfqfotTsXTKL+WOMvxA8MztqVjN
	97hVrdPF/M16hqYOqGi8CSZVVFGZvvZa8bW4q5VbAWOPLAnJIuxiPkmKrLgfNSzs5bPN6bf0jOY
	8B0CB1pLbZuG3HDeXEvsOHspcWyuIW7jaYcL/b7nTvI3pz0AHrxBTs5JPRRtuE7Sd1Wc2Cr5u9l
	uyVKxcqz58e2vtGgHb6kKs+Vh/APLZQ9XVJcAVVbTYfhxx3t8PtEzAOVsOv2g5Yj7RDrXjwQ/oa
	nbp/4jqLWXMiVAAI79Xbef5CGrExQ667IAo5GuhGxsJ+Hjzmql7mTx0gYTJt8j7TZghrvp0PaqT
	V
X-Google-Smtp-Source: AGHT+IHwTZDePmas/9n60pqusuSVwcyJig1GGPD8uSrk/a3UQoN2MLg28Aj3VU93LkhQWzNiv/RdhQ==
X-Received: by 2002:a05:6a00:997:b0:73e:b65:bc47 with SMTP id d2e1a72fcca58-7423bfe4cf7mr11349477b3a.17.1746932912456;
        Sat, 10 May 2025 20:08:32 -0700 (PDT)
Received: from localhost.localdomain ([39.144.107.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a105fdsm3956883b3a.100.2025.05.10.20.08.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 May 2025 20:08:31 -0700 (PDT)
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
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 1/2] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Sun, 11 May 2025 11:07:59 +0800
Message-Id: <20250511030800.1900-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250511030800.1900-1-laoar.shao@gmail.com>
References: <20250511030800.1900-1-laoar.shao@gmail.com>
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
index c81cf642dba0..2a1ce5a88076 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5627,6 +5627,35 @@ static int __init setup_resched_latency_warn_ms(char *str)
 }
 __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
 
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
@@ -5649,7 +5678,7 @@ void sched_tick(void)
 	rq_lock(rq, &rf);
 	donor = rq->donor;
 
-	psi_account_irqtime(rq, donor, NULL);
+	account_irqtime(rq, donor, NULL);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -6757,7 +6786,7 @@ static void __sched notrace __schedule(int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
-		psi_account_irqtime(rq, prev, next);
+		account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
 					     prev->se.sched_delayed);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1396674fa722..4affc1f747bd 100644
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
index 47972f34ea70..b5e71dfad66c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1226,7 +1226,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
-	u64			psi_irq_time;
+	u64			irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 452826df6ae1..b5b626cb1b83 100644
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
@@ -228,7 +229,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
-				       struct task_struct *prev) {}
+				       struct task_struct *prev, s64 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.43.5


