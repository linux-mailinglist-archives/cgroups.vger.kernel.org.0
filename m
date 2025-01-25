Return-Path: <cgroups+bounces-6323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C7A1C115
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 06:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37847A38EF
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 05:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BF207A23;
	Sat, 25 Jan 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V2PHTE/h"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4B207A0C
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782793; cv=none; b=L0VlVrG/ZFPt/VTHQ/FqQPT4qwhUnq98Jtu79IjhExjqgGtuVZ9jIcN+tER/8QpAjKpRncJcvlZjosaN0flSb1PdVV3N/37QWqbsME2BfpSRjKfiSfyjoLGbl/AIdNqRnm8HBSqOKQoREFzoDk1UPqBDxei5OJUWCoUrJF/weMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782793; c=relaxed/simple;
	bh=F0tN3/ScTvoDzI4ZP+uWoHMZYDf4tVeWpABUX7xOiBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ec7k/ZOYmIdwUjStReAg0fT8JPI/sp3xKXX1upD6+I9PaaJPyOMINRN+rcf33oWS7syBuieR5ijFepET7Qd9xjZMJnij0PfUJnbB2hD0zd5hbP3D7JHAUgAivH7yiDA7bCYayKWcm0sTg3mCRqR7RJ4s+DPp1chUG88laTCTgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V2PHTE/h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so601547a91.0
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 21:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737782790; x=1738387590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65pQEnSZRCQqijbR0Oh+WFGSMWcOg9x3kdoXaS0aoxw=;
        b=V2PHTE/hcKNvo+f0QA+569TjvFwUOQEHYKRJMMnSZnjmzUr7YY9dcTXDdANoKZMIrm
         /bQ7NXll0Onbqf7BaH5i/yNZsHbLQmDpJ8VdIDegDgGvFMigAK13lxONbT5SIBnn/Z/p
         XlnEEUUWaVrPcIGwMedGBfEQ+fZHS/9ed9GmdHETozcKnD2UkcEmEUf5MOfOHh9FJKxh
         DhcWs//guJdFfnZAwok/a2i0scOilCMokK0hYBcXnvNiQyz1qZh9EsfgrTeHLd8e2PmP
         1cER8eA2MVfx7h//Ut8zG0RDbF+2CN7W6SsI3pj04guX2PQH1cQIp2wU7rK2j2Wczz6U
         FVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782790; x=1738387590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65pQEnSZRCQqijbR0Oh+WFGSMWcOg9x3kdoXaS0aoxw=;
        b=LzxyO8uxjih394h+8Vqv9suj8bLjuj0v7gH1BBWzTC/l4diYnJ3o8A9ul9789OgASk
         ZCJoWWko8xRI7pembRzbwVEbhez1tCrstVqk5kl5muCXwx4Ec2LAGN6BNuqxI73WleEX
         5klOVcL/Zy4b5w+CC4D8f4KTBkLVjGxt6IfgpA59JT5tjr5FQn7rQiHAKIPC9WjivhVp
         BkBGFIhSr3i6LCkgyc/y2uLBSZZmDdYtKdRKLLUIdtpEwjNABQuSHyxHB2ukkCrh2gDu
         qEb4UqLyzQCKvqAZHwnX3Jp7Sv1sbgRUabdZdMF67mu8kQ53tf6vBDIjUqN1PjsPGCbo
         y/oQ==
X-Gm-Message-State: AOJu0YyIRUk5Q3aeDTd5HJ4gZpWFNF6mfkaPhm0nEKuJYCPRyFfmTEbV
	i5ZZYp5uoMsRMTFyZG9lNdwkI4WlDCLI1Wk84UU4oJTlS8U5gZ4zYClq3uzXyw0=
X-Gm-Gg: ASbGncuj4qcpn6SoEicqJfA1a4vUBZxa7IDRY4WaWmZUqF3LYACQ9ovd7ExtadcvGBs
	lfMlrPlj4NIDIpu33RT0yTPZygiNKfL35h5tSwrKq+vL5ltiDf4/v3Rvb4X30oKJUaGVr05XPdM
	7gf4J4OXHJMAaTmbqSyz1pqWVUhLbY1DxxlZeOsBWhQ6FhK8uojFq0sGfgk8WzhvFBr8X3BU4Cb
	KM9WQW8lpcWOXj2Q8ETCHF8XFhp1KO01Q5gA4XqIUELUHaKlIPQWsOVHGxlru1awUlVtvgtayJs
	3gthMtPfzCP7UzN3e8k0JZ2z6AkUWDDGNwUhzHehrSg=
X-Google-Smtp-Source: AGHT+IHkD6zmvqMpOXbEPbuzXo/Pe1cZxAlxxma1M+X1urOV5txaJxgn/lBX2zCClsLohBxknITnJw==
X-Received: by 2002:a05:6a00:114d:b0:729:1ca2:c166 with SMTP id d2e1a72fcca58-72f6a89bb7dmr8743550b3a.2.1737782789881;
        Fri, 24 Jan 2025 21:26:29 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496bbdc9esm2563856a12.63.2025.01.24.21.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 21:26:29 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Date: Sat, 25 Jan 2025 13:25:12 +0800
Message-Id: <20250125052521.19487-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250125052521.19487-1-wuyun.abel@bytedance.com>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-task and per-cpu accounting have already been tracked by
t->sched_info.run_delay and rq->rq_sched_info.run_delay respectively.
Extends this to also include cgroups.

The PSI indicator, "some" of cpu.pressure, loses the insight into how
severely that cgroup is stalled. Say 100 tasks or just 1 task that gets
stalled at a certain point will show no difference in "some" pressure.
IOW "some" is a flat value that not weighted by the severity (e.g. # of
tasks).

Only cgroup v2 is supported. Similar to the task accounting, the cgroup
accounting requires that CONFIG_SCHED_INFO is enabled.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  1 +
 include/linux/cgroup-defs.h             |  3 +++
 include/linux/kernel_stat.h             | 14 ++++++++++++++
 kernel/cgroup/rstat.c                   | 17 +++++++++++++++++
 kernel/sched/cputime.c                  | 12 ++++++++++++
 kernel/sched/stats.h                    |  2 ++
 6 files changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 315ede811c9d..440c3800c49c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1100,6 +1100,7 @@ All time durations are in microseconds.
 	- usage_usec
 	- user_usec
 	- system_usec
+	- run_delay_usec	(requires CONFIG_SCHED_INFO)
 
 	and the following five when the controller is enabled:
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1b20d2d8ef7c..287366e60414 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -328,6 +328,9 @@ struct cgroup_base_stat {
 	u64 forceidle_sum;
 #endif
 	u64 ntime;
+#ifdef CONFIG_SCHED_INFO
+	u64 run_delay;
+#endif
 };
 
 /*
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..256b1a55de62 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -31,6 +31,15 @@ enum cpu_usage_stat {
 	CPUTIME_FORCEIDLE,
 #endif
 	NR_STATS,
+
+#ifdef CONFIG_SCHED_INFO
+	/*
+	 * Instead of cputime, run_delay is tracked through
+	 * sched_info by task and rq, so there is no need to
+	 * enlarge the cpustat[] array.
+	 */
+	CPUTIME_RUN_DELAY,
+#endif
 };
 
 struct kernel_cpustat {
@@ -141,4 +150,9 @@ extern void account_idle_ticks(unsigned long ticks);
 extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
 #endif
 
+#ifdef CONFIG_SCHED_INFO
+extern void account_run_delay_time(struct task_struct *tsk, u64 delta);
+extern u64 get_cpu_run_delay(int cpu);
+#endif
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index dc6acab00d69..c7f9397a714e 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -445,6 +445,9 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
 #endif
 	dst_bstat->ntime += src_bstat->ntime;
+#ifdef CONFIG_SCHED_INFO
+	dst_bstat->run_delay += src_bstat->run_delay;
+#endif
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
@@ -457,6 +460,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
 #endif
 	dst_bstat->ntime -= src_bstat->ntime;
+#ifdef CONFIG_SCHED_INFO
+	dst_bstat->run_delay -= src_bstat->run_delay;
+#endif
 }
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
@@ -551,6 +557,11 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	case CPUTIME_FORCEIDLE:
 		rstatc->bstat.forceidle_sum += delta_exec;
 		break;
+#endif
+#ifdef CONFIG_SCHED_INFO
+	case CPUTIME_RUN_DELAY:
+		rstatc->bstat.run_delay += delta_exec;
+		break;
 #endif
 	default:
 		break;
@@ -596,6 +607,9 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
 #endif
 		bstat->ntime += cpustat[CPUTIME_NICE];
+#ifdef CONFIG_SCHED_INFO
+		bstat->run_delay += get_cpu_run_delay(i);
+#endif
 	}
 }
 
@@ -611,6 +625,9 @@ static struct bstat_entry {
 	BSTAT_ENTRY("nice_usec",	ntime),
 #ifdef CONFIG_SCHED_CORE
 	BSTAT_ENTRY("core_sched.force_idle_usec", forceidle_sum),
+#endif
+#ifdef CONFIG_SCHED_INFO
+	BSTAT_ENTRY("run_delay_usec",	run_delay),
 #endif
 	{ NULL } /* must be at end */
 #undef BSTAT_ENTRY
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5d9143dd0879..e6be57cdb54e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -243,6 +243,18 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
 }
 #endif
 
+#ifdef CONFIG_SCHED_INFO
+void account_run_delay_time(struct task_struct *p, u64 delta)
+{
+	cgroup_account_cputime_field(p, CPUTIME_RUN_DELAY, delta);
+}
+
+u64 get_cpu_run_delay(int cpu)
+{
+	return cpu_rq(cpu)->rq_sched_info.run_delay;
+}
+#endif
+
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
  * ticks are not redelivered later. Due to that, this function may on
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6ade91bce63e..b21a2c4b9c54 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -249,6 +249,7 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 	t->sched_info.last_queued = 0;
 	t->sched_info.run_delay += delta;
 
+	account_run_delay_time(t, delta);
 	rq_sched_info_dequeue(rq, delta);
 }
 
@@ -271,6 +272,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
 
+	account_run_delay_time(t, delta);
 	rq_sched_info_arrive(rq, delta);
 }
 
-- 
2.37.3


