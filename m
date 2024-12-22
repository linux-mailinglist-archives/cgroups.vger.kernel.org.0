Return-Path: <cgroups+bounces-5985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2219FA380
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 03:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794F6166F49
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF144C94;
	Sun, 22 Dec 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFgNcdvU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1582B9B4;
	Sun, 22 Dec 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835680; cv=none; b=tcxzmLnJEgjQb+tgiN5nJ43q0h3a7qmfph5lsa2I3qD0NQhupXfKiUztpUYSzg24EA7P8C7RDvTo6fNN0bX7S9PUVcTqceGq3/rsnmULrdQmJ2WsptvZtVi3ksNZL52iLoP2UyKXWOtLkdLz0k4yamEndEPtSOnth91/UzqaOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835680; c=relaxed/simple;
	bh=9Fx1bLgQOBc/4RgmNBn61ZmqQ0quU4HxJT5F6P7PL9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mj6aZ0PbTJDxR5BWY040T+Hw1eI11Yoxe7T5UGt6Gvl5dwG/jQmM+ml1ufpThBYC+aXvIajWiB/k7EEXXmTSb5UYGMq4wm362bUwBL+dsG0JFsWEH7G87rmj2gLtwP9lxtZyrB2e6DkRNq8UrxxvyHzffE8BB4nkkUAF+Su43+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFgNcdvU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so30114425ad.0;
        Sat, 21 Dec 2024 18:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734835678; x=1735440478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=hFgNcdvULJZLPRWPubPPr60f7IIMk6vWXPafCSDiUizMeR+oj9+xcbleRxWJ7Lc33Z
         ICSeP6q9O8QcUvmnE9j+dZRlJcGlDs8aOe/EgJ/bKJsYK71e4b2n8T6nCu3f0TEy1+78
         314Bx1HQQNPzGlfluINcM5AGW/dFZMpQBUPsMRPl2L6dFtPEVb7HQf0J62hNOrIj4z3T
         RLSjmJ3oEdVri7ASrTyStSTcaNyO0GpQbOSQghe9x4ENpRwJr3ovv+G/uUXMCqWISzea
         OOzNR5ePFUMfKGWc8jlmhSmFM+ZGk7nrDl3cV0dcCLktO/cw49VN+32LED84ErYxe8Du
         CR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734835678; x=1735440478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0wgvUkZl83NVS3YwL+hYGXPkTDH9VTAKHlm2OealRw=;
        b=VlhhbhkxYCaKaRJPBxmLCAJD5T4k5vgPWayhoWzNSdQSAscVDfuHbgB1LKiPwmYyJg
         +XCyXBk9dXQIjs3599Mcer+MeovOAWKoGjK21N9YF30QRTEx4SQEtuejVRT6S1usvsZS
         iv23Jn8J4BZ0E0h/17nfCM1sXvbiwLYqQiI/N0AR0DjqLaOYrdgaCF2pzFkJsJJG1aRb
         4xqaP3o3zRTOVAz/6vT6GBmCj4tMauiuJgEjaSHNNS+DvrUKZw1L9ukWjOcqtcfsgnDa
         cbnSX9/qBU6f7tN/1XDvQLAEYH3vHT/eRgv/mYfizfMwIFQrV/HZDrBVeoHr/NzZobbw
         n7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMLnilk3Gsh7VAIKjG9HJpzVjmoX7cBskA7HvRYfbyVzc5eF/IJgtIo5sEylYS081FqIivjILp+IEh3e1E@vger.kernel.org, AJvYcCUy1kJi0kiowZJIGBmjM2UcIBqjGm0tdbhgMIt34+TWmNgFDoSY1un8mICCASjiu2SSCf/pY2Qx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8YuHse8/55QAFYcwlYpD+O5COJPMaqLV0fV0zp5I3fN6rUnL
	55CvzyAV+uMeBcRgKT+zmPu9xWQqVm9GoMymjcKzGdffPErFXnT7
X-Gm-Gg: ASbGncugkOYsf4/JEvxVfjnMExLDIDNjjB5oq2Eughx6B+3TRzVI7hUpA6MbKUhowax
	Fyo7AR4omSxSuGqAA8UxiKJ0ju9xcFoD/8d5Wm+tF9Uyqk8Ofl+dp+9srYBW75yClN24z3+4Jfg
	VL850SxfnQuFOC+84VmDSqxK85pY6dDnE1hT6oFOEN+t9dwLE+Z6KRGX0Hm3GVaMl5QBgsUZDlN
	/NrKsmqclgNaqFrJyWDsvsnwy0dUykrufJbLpLCFpjrFxdcQNsejvLI7rtMri+hlPGdh/OcpEiY
	yS3P6es=
X-Google-Smtp-Source: AGHT+IHxEEHl30Wcln1krXzR6QdnRWE/RR1qXKJsfphWpkDwr10jzj5E0MmvncD7rUoXynfw6C/Xqw==
X-Received: by 2002:a17:902:dacf:b0:215:6489:cfd0 with SMTP id d9443c01a7336-219e6e88028mr103879135ad.3.1734835677942;
        Sat, 21 Dec 2024 18:47:57 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01b8sm4219265a12.20.2024.12.21.18.47.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Dec 2024 18:47:57 -0800 (PST)
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
Subject: [PATCH v8 1/4] sched: Define sched_clock_irqtime as static key
Date: Sun, 22 Dec 2024 10:47:31 +0800
Message-Id: <20241222024734.63894-2-laoar.shao@gmail.com>
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


