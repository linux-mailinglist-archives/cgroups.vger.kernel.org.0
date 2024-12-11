Return-Path: <cgroups+bounces-5799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF389ECD01
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44F9167CAC
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570A229144;
	Wed, 11 Dec 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQJiAX3+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6E1F193D;
	Wed, 11 Dec 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923074; cv=none; b=DwJ3XXXXlOVh3Ps/YWaHbsW3v/w70tE79UcFHqUpT3Wins72BEeR7lmAW80MHjXBgclPzu0ndYcAdm/yT0gFajKDdZGmLBlG4yw/yVLGtmmckdwIEysSh64XukEEdiugLJDyaJX6nEBEsOA7trQTRQsD2dajQT4wL5ub0RiF5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923074; c=relaxed/simple;
	bh=YKut9eFLbv8wkhW3Aw73UqZamaMGzSnQhbMHmznk78U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQOj2MdZ+hZhu52MfhlnFW83U+NW7oy38oDmcHnOemPKffBGXaaFpXT3iQxn1Icvbv9heW7xnuXk5A4ibk2UCdwmjbQWERe8vS31I8yYM6OirGolXG2hv2S+A7XZN3IMqC5/dd4BeewQorhU1JRjD/dnuffliQSgHwjXEaQUm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQJiAX3+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so2899718b3a.3;
        Wed, 11 Dec 2024 05:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733923072; x=1734527872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99YVoxP4xRvn770uvDfh6WBhPwP6s830fS2ZBhYtLpw=;
        b=lQJiAX3+R33diuZA6JY6PhBI6aUrNpWIioms+AyDrWF7LA1ql50j5eECqZUtFft3D5
         mEAvBEQ3NrIqyylmo2SNKjMPWFynJUgO6bAfsfOdKI/2+drdQzTS5hBapsoiUmAeDagQ
         WdEBBdEU7Jgyxu9HRNEZ+/cvB6ugqxGcfO2U60fPP+2ackKthqpiEMkdKBF/C82V0I+T
         6+SV0rKtKjLMNwr+VzZz6BsjrBmTAuCQUXCqBEXHA0836VuxeskxTWhhDy1u2xL8euk5
         66ssDiThVGA77Veru+QRuBGs0506nMIL2xjhxZFX5V+X7k+bub8pTaiUFnHnFl/aBej1
         vk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923072; x=1734527872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99YVoxP4xRvn770uvDfh6WBhPwP6s830fS2ZBhYtLpw=;
        b=nJjrdfYFzTgX4uEoIH4J6QKm/gepu0tbXsRyc4BCrWPreQ4ExNGp9I8B3Kw/WYDQon
         nLq3Sj5IMD6oMIqcKdhxpECyGjRjRbDIAEhtymeCdEFXHvGZCNipel9aNclZNXxcIdTX
         hnWvc+hrZBxC987b9+mFXhb21iK7DLOmolayiNwF+xY7dpIcdrtN5Et5tAy42BXHVB1h
         KciQm4jhqh/LoyaqFwuR1jcb506AF5REW+TLXOp332+FxyeI1o9mYUXTz4dVznCH6Ik/
         NNFvC6/ShNmJB9DTVXB8Nxi4ejxxxXGohhYl5lHQa0RSBKPaFc7UIuy/OOeGJoocLjsm
         y8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUHJdoeDgW0vXcpFd+tyJeYuSwvvSDD7gFrgsKk2pFnXW5xUVDCjvhKWgvgEP9RqgOJZUg4YktX@vger.kernel.org, AJvYcCWBwl6yxrPT6n56AjPxuvjbnViUdxWy5RML+6A8Emovwaynefn0XsYZQgvPOXSkriMIL/4fpvrODzVkSf4k@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzS9KKpKqZyIbUXNOSIRGPoLgAxjvWuba9dkIdhyEdS4Mdqby
	ryHEhh95TUJ5S08nbVH4uelPDuJFvUHkCDn6jy1dNGVQrItqX6Oa87LibxOTg04=
X-Gm-Gg: ASbGncvTfQTl9+m24AKqDlKvCdIQxBY1aEHde9dtsmlXKxTzRsROwoyQc7dLjZZZApl
	PIh6gR1vh9E7NxTc7owAy1SLXs192ZA7af4FCOVdZwZtJdTal8+w3ygVBm+/6m4Asx3k41Pwzmk
	LZhSCIkUjQ+LMmbKy/H8uWJ2EK8M6yOL3KryNGfw0EyaaWHTmcS50WBijmcKbikPEscjZGcLpLs
	66BKMtq0u7zJHwiKf7LKNUD686yMGJcGAHPVAualkRYC0Ed7qnXGBL1XuzS6tZ5xskGrI29leY4
	7frV
X-Google-Smtp-Source: AGHT+IEpTLOhH60CQ9QFyGXAa5ujTRDB5UlMLhxPcUvvyDmyIDQ5Vlt1Hhgh0NjxPhEg4UpxYksp0g==
X-Received: by 2002:a05:6a00:c90:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-728ed48d927mr4810163b3a.20.1733923072269;
        Wed, 11 Dec 2024 05:17:52 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeb536a1sm5272628b3a.115.2024.12.11.05.17.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Dec 2024 05:17:51 -0800 (PST)
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
Subject: [PATCH v6 1/4] sched: Define sched_clock_irqtime as static key
Date: Wed, 11 Dec 2024 21:17:26 +0800
Message-Id: <20241211131729.43996-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241211131729.43996-1-laoar.shao@gmail.com>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
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
index 6c54a57275cc..38aceb7289b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3209,6 +3209,12 @@ struct irqtime {
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
@@ -3229,6 +3235,13 @@ static inline u64 irq_time_read(int cpu)
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


