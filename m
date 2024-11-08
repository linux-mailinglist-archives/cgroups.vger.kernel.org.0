Return-Path: <cgroups+bounces-5478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E09C1E04
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB41287D44
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04B1EBA00;
	Fri,  8 Nov 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az7Xgajq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABF1EC015;
	Fri,  8 Nov 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072563; cv=none; b=Hjsfwbte2wieiWPCMfyNnixctKn+1MSgi8zmCq5BjsA5bXH7IpirXpkpdWg3Aprh2ldzyldQs0z+DTVnVt6hNGeyUHzdy+ODGnY6hoR3GDsRAYZfmI0kEx/D4+8IISeo21czrG9ZeXkM8rt968xMZnFOrf9WLJ6SVXXLMpP1liI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072563; c=relaxed/simple;
	bh=awhjoehiBq9K/ShfB1gLgEPzL9/qaL+Uh3vkwhYwJD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/FuNJldWuFAp5b8nAhQRBpnw+Bf4CRoSzYlffRg1grC2FBQFqcsms+e1lQktdNPFNxpUOmI4CfiwhpA7us50Y1yN38giOD2Zyjo1bo7oMWQxdY6wNKVTPjZQ6TRQXVfXxiwp7ESb9fG61ghAY3glQvACn5+ZKn0lyprQgdCfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az7Xgajq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720d01caa66so1973803b3a.2;
        Fri, 08 Nov 2024 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072561; x=1731677361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHC8CQdHO3sJRaU8u6msHyqioLgOfX7kr4v7xgAz/pg=;
        b=az7XgajqtsUQEp0Xpi5hE0k6iioinfOAS8BHc/bAG0/DgUD/pQF+NcakDwJkV1jWud
         G2RDqZjLwVBEXdMbiwllo0VvIZeGZHCkv9x4A314qeBqQYpVPbiGbA/TfgrbV4pAkKGi
         PgOYtDXQN5pPIg5K6YkO1y7wqILCnJmvH//cD/mbpwWiBxH99whTteEaUe7jPixDmceB
         0/ydKOiiUaH2IDFxZvX5GBbLOHNK423LDpW6oUl77FF+aD9OekQzIzI6fJ0tIB4xO7Xz
         ku4Y/d4VSBcUj9Rna298BJMOcsVqF/8O7ZMJz3fT+0SeuM8+nUp62J6fwNoWnFxyzqvr
         xkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072561; x=1731677361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHC8CQdHO3sJRaU8u6msHyqioLgOfX7kr4v7xgAz/pg=;
        b=R4rLTFFNlQSXuNufaIHpwBetPC/FwtZPyVYWtVhJZe765PuCbcTcIhXVtLbHzCIp/w
         qlYRLmoKD/fo40J6An73P/d/30FFFgdLXfrocZt8lLdJ9f+GA0Y/nZJi6dpgB207D0aW
         KrQyROn5chJrzx9IB9PVFPkynAJ6aGeZ73X0Blx3CQqg8woa9NxjZ+z+GthQCl6TrY0V
         WPxWSTYHPIyDF3kLixf4gwmJbHGCUqhsikbqjxetu5PTKULPbfFXQSQXj8L90WRV8Dgm
         Izgw0T/J4CQRNOhbCWFFSeT6PvKzhYGRYe49A9v241MxWT62ByFeZypyUvGtTzzTa3HC
         IgHg==
X-Forwarded-Encrypted: i=1; AJvYcCXJnCTTXZRAAmZbSZ/mlcCpFkAjHw4tMnOl6Soy/o8oBHQZCOxf8QbMcbJgYNbH19f847NgeIli6XBj73aI@vger.kernel.org, AJvYcCXUonLkxZ8UowXdAbGwj19RUC7o6MwK/+TnaGIqawLzPq81pRHBjA3O/QF4bfIZDhHUk7M7BpLD@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEuZ6I+FJD/ZEHWa/X3FDmHnCAAr1rTyIU6C6CKg5atjlgdNJ
	NhWsHjbqLN7+Vo3HKujreKgp1gYWnsN6fziG1c9CMV2mDfZXF9BD
X-Google-Smtp-Source: AGHT+IEAsCp6Ri9+gJQf3AMi94IwKLWsEWVoq7ZJMhKvkiCX9rGAtbplU2IsUFIHuXagg+71JXKAnA==
X-Received: by 2002:a05:6a00:22cd:b0:71e:581f:7d7e with SMTP id d2e1a72fcca58-724132cd0f9mr3162742b3a.15.1731072561093;
        Fri, 08 Nov 2024 05:29:21 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm3642561b3a.86.2024.11.08.05.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:29:20 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 1/4] sched: Define sched_clock_irqtime as static key
Date: Fri,  8 Nov 2024 21:29:01 +0800
Message-Id: <20241108132904.6932-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241108132904.6932-1-laoar.shao@gmail.com>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since CPU time accounting is a performance-critical path, let's define
sched_clock_irqtime as a static key to minimize potential overhead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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
index 081519ffab46..0c83ab35256e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3179,6 +3179,12 @@ struct irqtime {
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
@@ -3199,6 +3205,13 @@ static inline u64 irq_time_read(int cpu)
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


