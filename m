Return-Path: <cgroups+bounces-5897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55199F220A
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 04:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1384016585F
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950611C83;
	Sun, 15 Dec 2024 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrQ8yyGO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A76D2FB;
	Sun, 15 Dec 2024 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233010; cv=none; b=Cp4vZsbFfapxsAm8lEyCL7yqKm9FNKApj/NSaqKO9IYcajXvz2PGk4OyRkm6VM9tuOIUbe3FEIkIrXd1mm3XHnIFBCtd3M+TJZQ8f/TJn2WbADr6CMKGkM9mRbnZzStrVVsFR7bg5xThPUB8EEzFohriPFBvwk3V9pCUEmkuzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233010; c=relaxed/simple;
	bh=9Fx1bLgQOBc/4RgmNBn61ZmqQ0quU4HxJT5F6P7PL9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+/pm5mfsA41IQc3IQ8vdrf3QvUvxngHKjZl40b3Rayq6Cgce/gF6tPlsme2D8PwwLVUkcGeHyBgGS13EjCaEBoGIeTgg3Fh0qkkPbyHoelFKSGuTagbVmwVzz8ZRcRqMUpi3RHN38LCfpgVKG5mmhHlE6kPW9R1iWcthuxev3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrQ8yyGO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ef0397aeso2545654b3a.2;
        Sat, 14 Dec 2024 19:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233008; x=1734837808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=jrQ8yyGO3K+ebBSKIxDzRe4buGrundPNhuF90W/xBE7QrZYzozVhKfhgqWwOxCzjtJ
         43BSG/rccJPzOFzT0tIWUoDXtpMxxgqd05z9cIb26BzEvnXQnDS1EVxHHjvmtI0b5p2N
         lqZQufGplnkOYRbkB8xr4SCXkrw5bb6twW1UwAAJSKpXn8LIT1QjfQbFyJ3fncNeU1c7
         /BaCwks6fjJpnB8wo9RG+qc398IhY6JjtNAp0U2yECj+lw2HnjRhRIJRQCo3bCtMfxwU
         cC9PDLwb7qeieqhftKHlM5FcFdpAvdDGu4FUEiYJfupUbmgLrU+UUUcz0L+HZu+le8xH
         vDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233008; x=1734837808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=V3CqM/PzYjxa/N7M65U5Fw3P4P5bSQ8SkaYxzI2N2doAmm5wJgBA9S+fcy64Ouar7V
         /CzGmJ3u5j6W0RXPatbV8U9gUiRvCSDwTn4nZjlRqACKN1EO8a0mnvVlTP5vJID1oN9I
         JVt0bY0RRndLjp0MmPrulHAwBza0VTLcLXuwdz9FERpAAaiIAOtni80hEnafTyYuFCDB
         NdGEYl6HZMYnrRqi610Mua1DY2xnGH2Deji1HueIUrGb6M57R2FHhjhXn6qBtYpNpg7u
         ZjHLSnwSDjxbcwVW9xb7HwANpAek1DtOpRpfSV/19DZ7xwrWxHceHPYUSHJK+8HuD47G
         L5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU2ubDh0ANgUDKf3OYsYsUPKckzJdBjMu97nvG73DDeW083fKJAJKwPe2UcIr8BtUY98PY5pl0@vger.kernel.org, AJvYcCW4q23bGKOgIKjOD5g+PLakpFiWXz9ONne/2zuefuD5yupRYXSx7R0LSG5VMyPvFb7LtqBm2PycxvpePRf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3JHF6F4T0JKaGSSJVpBcPWpBm7GKoaPPAEeRl2lLmG9JS029
	V3o+I6acmaWI9O/8TX1+l2/OQGYMHbjHViT1jsUxFtSXLx0RCYFp
X-Gm-Gg: ASbGncvf637xbJGn2hpc7Wn25Mv1js5b6/gelSyH+ZTb7FaddCRy+mfujMJyjr9SwpG
	mIcNEvuZ7H81sQWJLvpNPlgCfE1dQBNVo253eFiPW+nluJzZPZZX70ckmsWYjxNAah1jvC5J7TB
	E/ls8CPosACV44SflemyyI+D7/xlMxapDsvFg8X8EdEPXlAnIW71hyovr64tsieRdPBJbuUx5zi
	607BcQlN9lbCIvJ6uRDjVTcbCuFaqy9D48aZ+xL4fxp6mvvDA2gOOMkzU2Mvh0IyiZsU2NRaY3L
	VE2fw3o=
X-Google-Smtp-Source: AGHT+IEbPALpZd2u3ybIHeJ4WyQxRtL/5fmLBTSz7fHi/ONzKvUYJz74pdimEeyV84Yyb51h9wOplQ==
X-Received: by 2002:a05:6a00:b56:b0:727:3c37:d5f9 with SMTP id d2e1a72fcca58-7290c26863dmr12959610b3a.26.1734233008413;
        Sat, 14 Dec 2024 19:23:28 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f1esm2176586b3a.92.2024.12.14.19.23.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Dec 2024 19:23:27 -0800 (PST)
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
Subject: [PATCH v7 1/4] sched: Define sched_clock_irqtime as static key
Date: Sun, 15 Dec 2024 11:23:12 +0800
Message-Id: <20241215032315.43698-2-laoar.shao@gmail.com>
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

Since CPU time accounting is a performance-critical path, let's define
sched_clock_irqtime as a static key to minimize potential overhead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/cputime.c | 16 +++++++---------
 kernel/sched/sched.h   | 13 +++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1acd9..5d9143dd0879 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -9,6 +9,8 @@
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
 /*
  * There are no locks covering percpu hardirq/softirq time.
  * They are only modified in vtime_account, on corresponding CPU
@@ -22,16 +24,14 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
-static int sched_clock_irqtime;
-
 void enable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime = 1;
+	static_branch_enable(&sched_clock_irqtime);
 }
 
 void disable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime = 0;
+	static_branch_disable(&sched_clock_irqtime);
 }
 
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
@@ -57,7 +57,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	s64 delta;
 	int cpu;
 
-	if (!sched_clock_irqtime)
+	if (!irqtime_enabled())
 		return;
 
 	cpu = smp_processor_id();
@@ -90,8 +90,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 
-#define sched_clock_irqtime	(0)
-
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -478,7 +476,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
-	if (sched_clock_irqtime) {
+	if (irqtime_enabled()) {
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -507,7 +505,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
 
-	if (sched_clock_irqtime) {
+	if (irqtime_enabled()) {
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aef716c41edb..7e8c73110884 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3233,6 +3233,12 @@ struct irqtime {
 };
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
+static inline int irqtime_enabled(void)
+{
+	return static_branch_likely(&sched_clock_irqtime);
+}
 
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
@@ -3253,6 +3259,13 @@ static inline u64 irq_time_read(int cpu)
 	return total;
 }
 
+#else
+
+static inline int irqtime_enabled(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.43.5


