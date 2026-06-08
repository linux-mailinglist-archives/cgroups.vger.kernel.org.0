Return-Path: <cgroups+bounces-16718-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4HRL5uzJmq9bQIAu9opvQ
	(envelope-from <cgroups+bounces-16718-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14465615C
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s+nwOnoq;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16718-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16718-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16B7A301879C
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1C37B00E;
	Mon,  8 Jun 2026 12:16:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57838AC9C
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920968; cv=none; b=hD/5BC35thY3Dl6V8CKbods1Q0CCHSTpCO/p4RjC+fySKJ27gvdUKxhaAU9qH9ZG1DeX4SP7FiZT1WBZ9fGELA9QE5m9UEwHdpK+cfij4u3Mn5Yfp50TRD0VpGiunWBKUpgL/voD6a1VJocLfqvkM79cRC5r99rHRTvuuQEOsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920968; c=relaxed/simple;
	bh=/esGex96/7K5WixXjZCTWYkRUCk4zCR/RLJQIooAqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnF9MvYhwqtsFOZO1Luezj0qyX/IDvqFg9OJrlMuA+To1Qlk3Fsv3zy91BMCH2OrYo0+52OtANOFG8060NdXeK7rIRHSBXzNWQz2p2pXXtYir6977Vd38TONPsKjLm0N5cCUBGylRgVtDbtUfkJGhVbbvRii6otW5tXHPmpOc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+nwOnoq; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef82204c6so2202399f8f.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920963; x=1781525763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR4oYliqi6ykFwo23mj4CnogVrnrasJzQru04cwA8RQ=;
        b=s+nwOnoqN8RLanMGtpmidL6pvcqhAqsBQkZJtBcTBwafnwiJGp0M5gUZygRbq8CFPC
         ZE8Tb3JuWZSrMkgbSnkBpPbamoeOnc2dLepXgp7o2gGhVpwMMS775TFEmTo8N42vHLpU
         n8W8ENzyD56v9mtDgg99jDs++XqXj3EIsBJVffkFli03AyWvMUMdHgf+1Fd1zXBMOHLD
         15hRX02sH/CDN4oPo96HMBuEZH020cdKqtSMkSmype2ARd8ToZeVGAQd5NCgJhbtkqVq
         5yM8iI1JrbLm7f3vMCVl0mCK6h3BNYaA2jJvxTtUeEb6kphVgfCX17CbpQWtUjvbnO3A
         SRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920963; x=1781525763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eR4oYliqi6ykFwo23mj4CnogVrnrasJzQru04cwA8RQ=;
        b=cNhGVumG5Ggn5PyNmaMOv9W83DZl8z6kVzouWCuOyHuCGp3/quSGxMdXhlZ878xD30
         EUZ1DvXOrKmma+nwDm+uWq8dP9i7OR/R6bF4fSSHhXbx1j+yDUJ2d+Qpe7Nt4zZfbY7m
         VB4ULSreRvpXaItSb7v2JdYocf5ANmKcp2GOyKJDq9saet7blQcw9w1KFARjKDuJZ8vD
         ePyGf6//86s/U3e2nL6pShzVJiaj6frj9jQX/2AsL0rSb8wS7AxHpXgTEpHWelvT6Svo
         gSNzT3e2CuWrG+wyv+i4zyPaNDlAlaM3elBSX8xY4FB1T6a5jhREqt7lvJjK0HKGI2nn
         h1Fg==
X-Gm-Message-State: AOJu0YxFFC+3MrTDSjJ/6oSpkfpu5zZOir4xY5kXWfgdMTfBb93gmcia
	FKMO7wEu7wONcMtU8FKKiTz7kpq1iZt7zSaJzbjWh1wZyr2ERoeX+n8q
X-Gm-Gg: Acq92OGlqmOuRjPCyxsA1Bl1RjLZ+SnJkfkwMu5MO9m5oF4mZyjqqyUBBzWHa5wKkRv
	yI6TsSDKbxeswPj7TtHvgvkTJSlFIcSR6nUU553m2eLeihOPzP6+4k+3YpHmucsRernCGNUD1Bo
	gRL3S0iY1sA+pz1aPfE5q+EBCSHvU59GLDXohXYqs63ebyo95gB1Szmt1w0BXDGnH2AbmvCPSxT
	yjlY8ypfGtIwxXHn8Th7VYY02IDRBZcn4i0nxBTfWT0sPDjS3mNOffzcN50d9O4TK5Q68JXweGo
	T5OYhOozIl04VzEeK5ZaR4jIbBW60wCMZKfvJ+V2zNUJSzqjnE8QLIqDSbu4AzgYsvtSmy7Wi+A
	WrQCBgjvGAb8Ih/S9VEDa9EoGR3Grhdgy3QkN+K3oNBNDNj6xXfy61ybX6GOX+dl2RQc9FJ4L35
	+HuzrMG2GtFXMEj7r0e9Ie1XOQ4OMPU0Y=
X-Received: by 2002:adf:f2cf:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4603050230cmr19831400f8f.20.1780920963272;
        Mon, 08 Jun 2026 05:16:03 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:02 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 16/25] sched/rt: Remove support for cgroups-v1
Date: Mon,  8 Jun 2026 14:15:35 +0200
Message-ID: <20260608121546.69910-17-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16718-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B14465615C

Disable control files for cgroups-v1.

Remove cpu_rt_group_init function and functions related to the
cgroup-v1 control files 'rt_runtime_us' and 'rt_period_us'.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c  | 50 --------------------------------------------
 kernel/sched/rt.c    | 49 +------------------------------------------
 kernel/sched/sched.h |  4 ----
 3 files changed, 1 insertion(+), 102 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1252f45feda0..a8a81c69b3d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10150,32 +10150,6 @@ static int cpu_burst_write_u64(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_GROUP_SCHED_BANDWIDTH */
 
-#ifdef CONFIG_RT_GROUP_SCHED
-static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
-				struct cftype *cft, s64 val)
-{
-	return sched_group_set_rt_runtime(css_tg(css), val);
-}
-
-static s64 cpu_rt_runtime_read(struct cgroup_subsys_state *css,
-			       struct cftype *cft)
-{
-	return sched_group_rt_runtime(css_tg(css));
-}
-
-static int cpu_rt_period_write_uint(struct cgroup_subsys_state *css,
-				    struct cftype *cftype, u64 rt_period_us)
-{
-	return sched_group_set_rt_period(css_tg(css), rt_period_us);
-}
-
-static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
-				   struct cftype *cft)
-{
-	return sched_group_rt_period(css_tg(css));
-}
-#endif /* CONFIG_RT_GROUP_SCHED */
-
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
@@ -10253,20 +10227,6 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-static struct cftype rt_group_files[] = {
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-	{ }	/* Terminate */
-};
-
 # ifdef CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -10289,16 +10249,6 @@ static int __init setup_rt_group_sched(char *str)
 	return 1;
 }
 __setup("rt_group_sched=", setup_rt_group_sched);
-
-static int __init cpu_rt_group_init(void)
-{
-	if (!rt_group_sched_enabled())
-		return 0;
-
-	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
-	return 0;
-}
-subsys_initcall(cpu_rt_group_init);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 static int cpu_extra_stat_show(struct seq_file *sf,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 168a92945b4a..4f1e7af2e88d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,3 +1,4 @@
+#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
@@ -2258,54 +2259,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	return err;
 }
 
-int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
-{
-	u64 rt_runtime, rt_period;
-
-	rt_period = ktime_to_ns(tg->rt_bandwidth.rt_period);
-	rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
-	if (rt_runtime_us < 0)
-		rt_runtime = RUNTIME_INF;
-	else if ((u64)rt_runtime_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
-}
-
-long sched_group_rt_runtime(struct task_group *tg)
-{
-	u64 rt_runtime_us;
-
-	if (tg->rt_bandwidth.rt_runtime == RUNTIME_INF)
-		return -1;
-
-	rt_runtime_us = tg->rt_bandwidth.rt_runtime;
-	do_div(rt_runtime_us, NSEC_PER_USEC);
-	return rt_runtime_us;
-}
-
-int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us)
-{
-	u64 rt_runtime, rt_period;
-
-	if (rt_period_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	rt_period = rt_period_us * NSEC_PER_USEC;
-	rt_runtime = tg->rt_bandwidth.rt_runtime;
-
-	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
-}
-
-long sched_group_rt_period(struct task_group *tg)
-{
-	u64 rt_period_us;
-
-	rt_period_us = ktime_to_ns(tg->rt_bandwidth.rt_period);
-	do_div(rt_period_us, NSEC_PER_USEC);
-	return rt_period_us;
-}
-
 int sched_rt_can_attach(struct task_group *tg)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bde49f216081..efe52e162ba5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -607,10 +607,6 @@ extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
-extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
-extern long sched_group_rt_runtime(struct task_group *tg);
-extern long sched_group_rt_period(struct task_group *tg);
 extern int sched_rt_can_attach(struct task_group *tg);
 
 extern struct task_group *sched_create_group(struct task_group *parent);
-- 
2.54.0


