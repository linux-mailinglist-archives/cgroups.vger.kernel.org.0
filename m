Return-Path: <cgroups+bounces-6036-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9350A002B5
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF87A06E7
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F73148FF2;
	Fri,  3 Jan 2025 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7P0GkUO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E11119A;
	Fri,  3 Jan 2025 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871072; cv=none; b=GCdsgwdmcrgcCHQdUK9e+gfIjclkbUJlSNWJyTkmXhx9k0cHH94tvm5Xy0myVITAhmPpT0QYctuU3rxbsmr/njk14NwlIwfJdU2sKzizAfW/38Xg6s/222wUXyjVwop0ORgfIGMoaVwLlw1u6wFMBK9TLbDXp5BRDJ2AgXCDXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871072; c=relaxed/simple;
	bh=9Fx1bLgQOBc/4RgmNBn61ZmqQ0quU4HxJT5F6P7PL9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IczWWXiMH43PyPPjCP0AThkQ2HdIuyr/2cPSWhPHSkHLFvow0M2Mhhz69WjEIkM0TSoS85DqIo58euPhJ70CyDQxvJeuShwcHzEB9BePmI0qo9eDxTWHolDgZVUq3+5gONGTUFz6WHtfIq8WIx5tdyYVqxKs4tvA71FxoAXEU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7P0GkUO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21619108a6bso151580535ad.3;
        Thu, 02 Jan 2025 18:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871070; x=1736475870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=J7P0GkUOGeIRlL1wo5gN7S828AwCcboNjgtCA855fBJMfO23jmwfV4DAHgVkKrGfNu
         ffZ314qEcYeffkj0Hb8ePus2bfwvAVB97Irt0Y233is8UZvcpl36RNT0BY+5OpmxvPUm
         seKZufyamNrol6OheZyz6IMEUR1yKdELv9P/1Mv+sxlY2TruR3Nd5UXOgdT7gmkYGblp
         sGtgpnj8vezOKmxpkxcEh6lZy6XWPCwy5XCWg/plD6+EsOj9A8Doj9Bvv7Y+iBw5V5ms
         v5rtpYgk2qg61q5NflfqJBTzMADB0i3EhZbqU7Xk7O8wFi6ZwDXXsOyz6P57fwqVmlvt
         ndIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871070; x=1736475870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=sz1ffFBM2cF6HT1AgPQgKFVcF5s8eF1qMM7xWHy6wdHYfms+DNazTpNvU9XwDq3idI
         r6/WGsBYn46V04BxZcBDdQcWZ+DGd7lKZUGgNBJw6L4ksEMvLQWZ+VMInHvmo5K/tq/R
         AsY1/nkiyycTkL/P+E5piS1RZKDb3AAzIhHTbfkb/PZzFxLS59aMAyX/PBI3nUrEMuoX
         Z8UAzqPuxOvrbXWLt2jXVZ5VbffRyD2B8URhWtaHNakeArsePG8Mfm6lDN/Nx5bjv6yf
         4Ng0aEcJU2n3P5Y5yHVHfF6rMe2V4D7E+Pq0RdmnzNFd4A8cMqsTksHPRlvzoveEoux5
         GyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSRZstS8A8AWfIK+rg1YrOV4kVIYn8MW8Sh3AsYWplzSrykjDi5j+bLnRt/R//ao5Hc4yKptOc@vger.kernel.org, AJvYcCWAP6ehKHjFM9ESF9yW0tZm2N1v0QbxHD7uGzvZk3/ElKfsF3i2ZGkkVSNwcnKpW4V4uwqzWMp1kpu/4m6/@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmLLdwtiZP6nuD6BUYwDuvXeXaqc0eC72ZAxVMyhC1M+LQOMF
	JEBVvOXRnYtxf37wKKnlnEzY4RwTU+ZSLmGCRxYegSbLYeJr63lJ
X-Gm-Gg: ASbGnctfi61zXpXae7GAZ/aVTWuVXJD31zP2ffi6Rcyie5F2N/aBk3qyJY3qSUJkACw
	0hm+w1mmkmCWC4ika4zo26rQP2HR3zgWj7P0XMVYBUYRjo6HdTWAc64EeKe6vr2J6XPm6EtRNSd
	s7Sr1Jn1S5ViZUyckV+UGiNLPVni/HScwE29NHRk5M+tewgRTB6vPoiOO4EvXMfSvvhHr9GUwQj
	I+hIVvOEHiLDdk+LBnTZmRkqk4+saU4Mlb/xtIQGlJRKC/LKyHyLY5ctaQHUZKZhwsNpYeJcBmK
	uwwB3X8=
X-Google-Smtp-Source: AGHT+IGaMRVrMVo90n2hd4S1mw3+w06zglgpXD9jY6ueOVcIc5Kac5fP7r5VdQKnCjYZiPHjKXPO4w==
X-Received: by 2002:a17:903:1209:b0:215:b9a7:5282 with SMTP id d9443c01a7336-219e6eb417dmr636867265ad.26.1735871070061;
        Thu, 02 Jan 2025 18:24:30 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca007f3sm234184145ad.228.2025.01.02.18.24.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jan 2025 18:24:29 -0800 (PST)
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
Subject: [PATCH v8 1/4] sched: Define sched_clock_irqtime as static key
Date: Fri,  3 Jan 2025 10:24:06 +0800
Message-Id: <20250103022409.2544-2-laoar.shao@gmail.com>
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


