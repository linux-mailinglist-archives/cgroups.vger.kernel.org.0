Return-Path: <cgroups+bounces-6472-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A4A2DB47
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 07:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E761887A48
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3E42C0B;
	Sun,  9 Feb 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B42QOgje"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9249659
	for <cgroups@vger.kernel.org>; Sun,  9 Feb 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739081643; cv=none; b=EZfh/mSBHa8mXeNUoMXqPM4GYSn+eW8X47Bmue733klZ+eGWiYIZYad+EnkHNqHWprqOzB+2k/y2SaC9hWpnGZVYJXPwJNhGz6JsvPolO4Mk6P8bMAaWzH7nEwGVZfuS42pXoMgARgH+Aj4ZOqyM1f71v91cp1b/84oAKA/woFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739081643; c=relaxed/simple;
	bh=bkK0CH511DnkVfmrMeGvewdUCLteCTKCIflo07f3QTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STkB4iO9AdCPSvoUDIoAINF7i2BZj3unwXro0fjdZvSk37iQD5qFy+2gxhJpQJskxE2Fi/DWBGAloSldHatjkpiIAXKAMWjzwGeVqn/Y5A+BIiJIkr7VEQT9hwHqVD5L4GSXZUN6ThiRYdOy+vn6BhR64Xb+e49nTZIy/4IDjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B42QOgje; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f45244a81fso882781a91.1
        for <cgroups@vger.kernel.org>; Sat, 08 Feb 2025 22:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739081641; x=1739686441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOjIKAHCQDSMAXA0ImMg5Ea5nk/p2DbggDGTVuT7g2A=;
        b=B42QOgjePMHmyQ5YbvEPt2FYglBTm9YZUucWK5Yh/YW7jFn7NwQzC3+fF06eoTh8xi
         TqPz+ZLmJYkM9/AtQwc/i6uO7twy99+Adt+ltN6eWonssK5pkq+qcs3V78a44UbFD15l
         qFCSfUd1j0qw6w3OjOeDAN6D8alimxojN30ltmn992PZdAJ0INsPOZbbRcWC0tQfkhMm
         nm9g1FCicyNlUnio8cz+oSU7PIUtpDQt2ZHv7vneeUCdAFLTe9UELfDdWrb1v+7ooqy2
         WHwrBwHurbGRuAb17Uj832CIpEVzmw0fjjLkBElpbjtLoiL8gEfg3jNaf4FXBiax+ZCs
         s0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739081641; x=1739686441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOjIKAHCQDSMAXA0ImMg5Ea5nk/p2DbggDGTVuT7g2A=;
        b=lxeNrBAXdvMu8OClOcrrBL1pE4ARnBBEoptNO+rosUZl25+3Y/UEsqevx+IuHCfwkZ
         1w0IrhmcepVgooPEvDOCgdbsU577k0q6KfUyPOV5Z+vpodB2TWHsjequSkeHRnCCcq+m
         whuMGnTllqNjFZJTp+QXyBtV8tv+4h6Zep6tnHLMCeKCE3pXZmfG3oMpLMLb4j9yh7gd
         ubs/2LVEncT3tvKZ8L8qIlJKgqw4pQ21lv0ovZKDqhYtAW9NdQm8mZdJs41+IGShltpH
         SHj7tIbTsiL0/NTZlQ7bFwpndsjZlt43L9/nM5UvwxIlrSt2pDfXkWFbiBxZnbz78m/G
         Qcog==
X-Gm-Message-State: AOJu0YxF+0nPm8/JgYmUaZepMq5BQfwsio0uJSxRFp6qzvoytfbWVLXY
	0AZpfmShdQcDydEU73zzKXaAcudJGRC/+huNMUIzY/JFPNy8eOO/OwS+h8QA7lc=
X-Gm-Gg: ASbGncuRa47dOKj+Q6n4lEMQY0pz22xz0G8liGxZd1fLVfkNiT6bMP3R3nYwVO/OEaH
	zEkqfKqnlrdQIucExnf3PkTS3T6EqsX5PMZhwngD2454znIyJR4URyGxykn+UpXHAO5oCdEK8kT
	2dDNjDL+qWEd+e7XL5dJbLmUzeZv5Eut5C1tmHrXNtxSErKiDBf2CNfc6E/mylvYjBvVGzrznOV
	gEhaOJ2KCpa41ivZYxCL886LpIf/0Z9xkGljzroVvVzDhF2juYff9gnJX2T5txm8vejIOIxfle/
	ZsgwSjAxscN3/u8Kq2EkIEOC5s4bOL1lObQdEZrp+WuR1zwX7TQsNg==
X-Google-Smtp-Source: AGHT+IFCkTpbKKfaRvMohnnB70rMnRi0gOsnSx4WPZ7U4X4EyrXnKy0KBUsp7VDUscCluFBftaYktA==
X-Received: by 2002:a05:6a00:1884:b0:730:271e:3c17 with SMTP id d2e1a72fcca58-7305d5a315emr5776709b3a.7.1739081640689;
        Sat, 08 Feb 2025 22:14:00 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad26b9sm5550700b3a.50.2025.02.08.22.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 22:14:00 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] cgroup/rstat: Add run_delay accounting for cgroups
Date: Sun,  9 Feb 2025 14:13:12 +0800
Message-Id: <20250209061322.15260-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250209061322.15260-1-wuyun.abel@bytedance.com>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "some" field of cpu.pressure indicator may lose the insight into
how severely one cgroup is stalled on certain cpu, because PSI tracks
stall time for each cpu through:

	tSOME[cpu] = time(nr_delayed_tasks[cpu] != 0)

which turns nr_delayed_tasks[cpu] into boolean value. So together with
this cgroup level run_delay accounting, the scheduling info of cgroups
will be better illustrated.

Currently the task and cpu level accounting have already been tracked
through the following two holders respectively:

	struct task_struct::sched_info if SCHED_INFO
	struct rq::rq_sched_info if SCHEDSTATS

When extending this to cgroups, the minimal requirement would be:

	root: relies on rq::rq_sched_info, hence SCHEDSTATS
	non-root: relies on task's, hence SCHED_INFO

It might be too demanding to require both, while collecting data for
root cgroup from different holders according to different configs would
also be confusing and error-prone. In order to keep things simple, let
us rely on the cputime infrastructure to do the accounting as the other
cputimes do.

Only cgroup v2 is supported and CONFIG_SCHED_INFO is required.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/cgroup-defs.h |  3 +++
 include/linux/kernel_stat.h |  7 +++++++
 kernel/cgroup/rstat.c       | 25 +++++++++++++++++++++++++
 kernel/sched/cputime.c      | 10 ++++++++++
 kernel/sched/stats.h        |  3 +++
 5 files changed, 48 insertions(+)

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
index b97ce2df376f..ddd59fea10ad 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -29,6 +29,9 @@ enum cpu_usage_stat {
 	CPUTIME_GUEST_NICE,
 #ifdef CONFIG_SCHED_CORE
 	CPUTIME_FORCEIDLE,
+#endif
+#ifdef CONFIG_SCHED_INFO
+	CPUTIME_RUN_DELAY,
 #endif
 	NR_STATS,
 };
@@ -141,4 +144,8 @@ extern void account_idle_ticks(unsigned long ticks);
 extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
 #endif
 
+#ifdef CONFIG_SCHED_INFO
+extern void account_run_delay_time(struct task_struct *tsk, u64 delta);
+#endif
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c2784c317cdd..53984cdf7f9b 100644
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
+		bstat->run_delay += cpustat[CPUTIME_RUN_DELAY];
+#endif
 	}
 }
 
@@ -610,6 +624,16 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 #endif
 }
 
+static void cgroup_run_delay_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
+{
+#ifdef CONFIG_SCHED_INFO
+	u64 run_delay = bstat->run_delay;
+
+	do_div(run_delay, NSEC_PER_USEC);
+	seq_printf(seq, "run_delay_usec %llu\n", run_delay);
+#endif
+}
+
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
@@ -640,6 +664,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 			bstat.ntime);
 
 	cgroup_force_idle_show(seq, &bstat);
+	cgroup_run_delay_show(seq, &bstat);
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5d9143dd0879..42af602c10a6 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -243,6 +243,16 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
 }
 #endif
 
+#ifdef CONFIG_SCHED_INFO
+/*
+ * Account for run_delay time spent waiting in rq.
+ */
+void account_run_delay_time(struct task_struct *p, u64 delta)
+{
+	task_group_account_field(p, CPUTIME_RUN_DELAY, delta);
+}
+#endif
+
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
  * ticks are not redelivered later. Due to that, this function may on
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 19cdbe96f93d..fdfd04a89b05 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -252,7 +252,9 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 		t->sched_info.max_run_delay = delta;
 	if (delta && (!t->sched_info.min_run_delay || delta < t->sched_info.min_run_delay))
 		t->sched_info.min_run_delay = delta;
+
 	rq_sched_info_dequeue(rq, delta);
+	account_run_delay_time(t, delta);
 }
 
 /*
@@ -279,6 +281,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 		t->sched_info.min_run_delay = delta;
 
 	rq_sched_info_arrive(rq, delta);
+	account_run_delay_time(t, delta);
 }
 
 /*
-- 
2.37.3


