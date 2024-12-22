Return-Path: <cgroups+bounces-5988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332C9FA386
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 03:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D7A1884A19
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 02:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4F2AF11;
	Sun, 22 Dec 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDcTzrkk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4313B5B6;
	Sun, 22 Dec 2024 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835692; cv=none; b=PkbIS2CfjN/FMZnH7YevavX5b5/xFpBMYOPI8XzKj1IVNKtd5ZLd38POALl8HU1tZ9oBxlg8k+1bNa3QvuVjF/hrPHpfx+jvj3qAdvvxAUWqqEmWM6J1idmZbflqyKaBdt7hNA3WMySowLBjjxhXMLQnk6BNY+0dQIyxkxNye80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835692; c=relaxed/simple;
	bh=KEU7CWczGDLyD7YwHYxR3y7xe8tazXwkEwl9zxlXFls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXJhHi0mGVwVjgOYLz01pKWxLTLgej0jTXnLuhv4CowRECzVp/ec1BJx1cMgqukYoBgPev5hIvy5gMFo1yQz6GpctEkevsgmF1/z+1A4oFy1L/991uGFHoDbHOmU74EVvP2bOQkqfFlxEP1RE0XEpviie/Uiu0w0NNIGkRz75u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDcTzrkk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728e1799d95so3612609b3a.2;
        Sat, 21 Dec 2024 18:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734835690; x=1735440490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avljg6opUL/YIQ884XhrX8PNb9qrQzwcO+9J8KL8WNo=;
        b=GDcTzrkk2BCdC1Lzjkr5KLMgUtIop+kpeQA5qB3wYg5GMF5rqjx0VUb5U2HMoyQ75r
         8GGV/sDFW/8PFwp2rugcy1l1Ik5g7jikYMNlDBSnH4TXIHm6EcoJ1SbArXLPU9ASVg5J
         VJGp4iPnn1PlHtbL/UFTzanSifHnZq1w04tiN4TW4JZofoNodBSdxBp/wjpf+8g6TXYu
         BcsCnoHde8W/hyEYDF82S2fjuSJieN5qrI8wIRI30GzdKpHOQ90ZHRPBtitW5pwxhDHt
         GsJWmK4HDq4exMg/k3BeJfgGmGSz2bUVMH4Qnzy9uvMzNQ/wCfE/dmWD3hyQuzZblqXQ
         wTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734835690; x=1735440490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avljg6opUL/YIQ884XhrX8PNb9qrQzwcO+9J8KL8WNo=;
        b=udRIH1HuWFD1ECKYTMkHD8GRVhkYp4eQsVkD++RSzZURvHlkHJz/22wgML3q/4GQak
         IdGnxV6/C7DySTMpiWpB5WTLkeTzmhguiCy4lDHl/M8chGlptzsfmOm3LvS0RkqnizfZ
         k8mMy5MhFc3pFyexj3RZo1XwnhDm1/gGCWXsKgDTASqS0w9l++qc2vLOaO2xKFht3HdA
         0jcRaRTEwfSXEVStV112ZHSZDiIu+qXw54ACyxAl93CGrMRrk6CxepkUqRy4/DZ87bwQ
         ccpU9o3ho4JTGTeRpDfyh70OxHbHv/c3ylWGkK4V7Mbg3wfBZ7sRTLzGXyHGolLp00HW
         O9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Q5ovUrYfa0jRJQMNbd+BrZI1fXQj+S/N/SXM5bcM+9KO8owGYJ5jiR9RnHHPuG4zqRnmwNQc@vger.kernel.org, AJvYcCVU0HtLvlaX00zFmUfM3Ut+X3mUt0C14hOiaIAxemvcAPnsPczP0np1uquqL0weWZsH4x0UkJW0gM00+PwE@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPv0DZxNuRavCAl2uYAwLeUNnGXlZLm4Wnx8PIKLUwbfy61GQ
	XZNfic3/BFAo0jFQgF2rOXwmxgF+5M2Sgsd9OvqpPHfcgjq4pI15
X-Gm-Gg: ASbGncvnmZeHqKERno4M67gSpIl4lh/6k6uolaGMYYsuqCvmMFtvxBZpmDbmlrXg9Tq
	TxAvR++K0/y4Eaft/6y+3h5hXrFJ7jX94kaj7/cGic41JT3+vTQM8ndLVwYSTEawdv1hrR1ga3u
	nMW84/U8XdrOyYQtgl2pmd4896a4YDPnFKVLQY4Jwoj77gvfKBRd46qchO9SA13kml4NHLk4Ris
	6rF8zyfG2K+b0OVBM6YcL71qEBnnojB5Wp/nnBzJEWxn6OAnMA90RnoZZ2Wr/iVQSv2tgDuzVSQ
	8zwIQ9A=
X-Google-Smtp-Source: AGHT+IFf8XlfAi+sn7o2pUxzdMKTLaI9sN8E5bgBRuXrtamE6qeCcZfnQHLd3QSFgUmU/9Fq1ZbPlg==
X-Received: by 2002:a05:6a00:410d:b0:727:3c37:d5fb with SMTP id d2e1a72fcca58-72abde8461bmr11296650b3a.16.1734835690209;
        Sat, 21 Dec 2024 18:48:10 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01b8sm4219265a12.20.2024.12.21.18.48.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Dec 2024 18:48:09 -0800 (PST)
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
Subject: [PATCH v8 4/4] sched: Fix cgroup irq time for CONFIG_IRQ_TIME_ACCOUNTING
Date: Sun, 22 Dec 2024 10:47:34 +0800
Message-Id: <20241222024734.63894-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241222024734.63894-1-laoar.shao@gmail.com>
References: <20241222024734.63894-1-laoar.shao@gmail.com>
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


