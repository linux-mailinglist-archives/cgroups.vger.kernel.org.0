Return-Path: <cgroups+bounces-6251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75833A1A92C
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1191188AF22
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64B156885;
	Thu, 23 Jan 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TWPgygyf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DA1494BF
	for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654542; cv=none; b=EhxhxWQ8aU4hYrhcO7IGFDKVyIOUAFWyVxAEkNS9Z7lGSmGfwFBbzaTgFi+YbeqQ4B1SLfBmQY8W7JgAtqyBEuJDaLlU59Eu9V85sF4DIaOjvCuNxYAAdHDQaDibA1H2mNi2uflnSxHpwocP89Y0I7oZDGUMAt/ZZJB5gyvmDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654542; c=relaxed/simple;
	bh=8WGgEe1qqPoke3T4UxtXtCNX1n1hbWiwQZda9CSCCak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIqX3icepFfKqrdSSti3S29bjee4eOWsW02+o+dnWHL/DDZnCfQrWnpEHGEVDF7tqOcCRDpFPJY0gmtLRSyM44ejAqYTc6+7JORIS9tnGtVKPI0efM6FaC/+w6VP2gqWgwOSSWDn2yFM+RwssJb8jDRrty+PBiRxg84Z8F4ep5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TWPgygyf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-218c8ac69faso2649615ad.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737654540; x=1738259340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTn8r4QEzvDBUmGZjORVX6QcvwIiTzYvfF2/f68bzP0=;
        b=TWPgygyf4F+uBXYxnpNSojTmirfVbkd5ak3UD7DG+3serwF4VRHZoRFWtFoUyszloe
         gHtm890hEz7NeyeSrO7/DG6MH0iUz9GsQmvMjNKvfngS0+8cbi72lGrHra7p16+mNhJ3
         Nk0qo5yQL0DvUJgVHjzZq6oLga6lwaZRT/6hPEfh0e15PIWi8gCnh3AdNa3Ep+pZvD1Y
         fAN+LMBHxBIoy9b8KMQp2W/vtz8xNBKTmt5vifALiTEaRhCH8H4EVKEal05d1omZxaHp
         c5Ow7pgpQ0fQeVOhkmUhAng6qvX7jsT6Ffgx2U1KjAip5QeOLwtlBYM7WNoMikv9dX1Q
         JAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654540; x=1738259340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTn8r4QEzvDBUmGZjORVX6QcvwIiTzYvfF2/f68bzP0=;
        b=SB3fCt+kO3SA3los5pn1laEkKSs3lgHDnu9gkKBfUyNHBoX83Ln298XVnsZc49BJze
         JAYzz/VmWOOJJkP7abisdZK8vgfSDzT1ugy3hM0BOAOJMubxmrHdISUoCK1isekWDoW6
         TJtwQl2I/dwCP88cP8ljLHhjOVWDw9XFE5YfcXng5qzHgqLaRVsFLMJdt9wRlY/m1tUL
         w81C8fH3qw1RcXXVjenol6gzU0BbAskAefbtKHrqEoz6l/HPxDcX2/yxpuwz06X2pi0s
         HfNTt8aLIVq4NNpnhgnZh4eydvz5TVv00S/TnvpjyK7jT/3rJDoz0AbDld0JFIxxIKLY
         Izsg==
X-Gm-Message-State: AOJu0YzUubsutL9am2PDeVC91rtzyYT+m0kQimIBgziRT/8lI9EX66oo
	KAuBP22YVInZzrettBbYPF+6hBa1iIM2ekGIOIZDFqAoZPqKyKQCnZ8cub0kh2I=
X-Gm-Gg: ASbGncuTUkzWA/Fyz+qkbZduGHsGy9tXvvvDtLRtNF+CfGAreRfMzlF1eomQTh9txJM
	JzbD5wlN+x/rMK1drmJRZJXngHJdDrpeB7vA/9JWLfBY4z+vQbzN3eZFXt4YwMLlNepTVJNWG9F
	kBbjaPhXnrHxSf/eMwzPY0ThBVvvMLKPt/F1vYn6oDfaekbhR+OmOKcgW5gQ+YvLDnPk5hCqmVT
	MdvQRv2Dhjp+8+sswGXDM31EepeArh0AP6Fuw7sc2PCijSKLh2TSBPPJES6g9SOQ9FTjnCKZtkf
	H1awIm8n2JG8x1+muy7ah3UgftTpjV4gK8CUoFG7DCw=
X-Google-Smtp-Source: AGHT+IEFdWKMkAB1YQXh16g+6HdulE67MQAXde0sc7pWtNVxFpaHq4g2sxWh/TsZJylG7/Nv2aJZ+g==
X-Received: by 2002:a17:902:f548:b0:215:3862:603a with SMTP id d9443c01a7336-21c355854e8mr157179985ad.10.1737654540165;
        Thu, 23 Jan 2025 09:49:00 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c4esm1620765ad.110.2025.01.23.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:48:59 -0800 (PST)
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
	Yury Norov <yury.norov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Chen Ridong <chenridong@huawei.com>
Cc: cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Date: Fri, 24 Jan 2025 01:47:03 +0800
Message-Id: <20250123174713.25570-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250123174713.25570-1-wuyun.abel@bytedance.com>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
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
index 6ad647f3e241..6a365a7fb7b8 100644
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


