Return-Path: <cgroups+bounces-5106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F999BDFC
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F6B221A8
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297DB481D1;
	Mon, 14 Oct 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+FEkloY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03C43ACB;
	Mon, 14 Oct 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875480; cv=none; b=W7hgFuE82ddrEhin1SpVRA5dt0G8vUu8th0Lsfcdr5s0tK1ykG+iCfhUdfvMG2LfzmBbaJNUSsh2qnQI7hiOwqgh/9qO8kpcJXRLzW+/E3yCaIlfhj1svP8OtoSJJbIj3Tiv3tLtKvoTfi/qbieRJBp0/Kr5n9Pqa49d5s7rzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875480; c=relaxed/simple;
	bh=mD4RJEhAin69c0Coj5xGRt+ncUmUyzzgnKmub6srj84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvC0vyfzFYogthiENv+At8oh4f8qA/gEeLkiK0cb4YeFT2V5+yUQ+L+mXCSxoQM41mD7LmvsQyOPtD0V1ueq4mfnJGce88gFXNcgkqN1+qmGPotrBxYW0ZQl1AUe52LsMN61xnqvumVcffL5TK0BsaGxGMSbc+Ik3jBPbBIvkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+FEkloY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso881926a12.3;
        Sun, 13 Oct 2024 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728875478; x=1729480278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYsYYa+owJ/7qI8MxzT4IGktWSYUFxVm242eY9jgz8=;
        b=i+FEkloYGbtATs4xjoWl+d7DhwA1TGeqk9ONjIT2Opj9mHRu5BFE5v8C+iqLuf/93A
         xCAqR9Nc93hISfHIx/71sad7V9+f0581d4rC33CRcEu5PYxnhg6Kh43OUgh4GyixI2/n
         Jc+2XF/B54YsVxIUH09bdxWfAKJcDQExP3PVAizhnkMu1gCfBELl4cnCdYZNtrgWAbZc
         yvrItqSDzTJzla+Bu21eRKHaOYGuKcUvTac0PAFKw/cq1qAlMY7aPGJZF8pMpWZtYcWQ
         vGj1CyTiVDVeNx+U8a6CCK0/QASuEngoB/pvNwnrT4HdmyXZJ+VEVV6d7SakFcXlOiTw
         HJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875478; x=1729480278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYsYYa+owJ/7qI8MxzT4IGktWSYUFxVm242eY9jgz8=;
        b=eon9c+U9XFmqckThxYbNnTPEFeEzeK4z1vfE7DbwEUqATn5XIf1j+BRRRGCkVCtO9A
         5l+O61cOCxlArck0BwbmmZ/TncfZNixje4++XSE8j9/VeDJrDjardZhiRpcySbOa1Sij
         ozhsCS2grtaYOzmlWAhtLMRbBmHlYhlXtdPRZstGt5Gw6qt231qfm8d0PB4rTYPAibfi
         bLLm3E1rrtsufCvMdPsXXFnUa6Xat6d29WIyNE57bKwDsInqrVPIU1RW6L/q+2m3z6wW
         5yJ8bkiC7Qz8CYa6FgSoz25ZO8EIAIAxO5/oPLqDpUEK6JPPVG3atBViDy68J3Sf3+JS
         oPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUw909gOT9Tfvwzn0UuGVrYZ7arUMmcOPUcrFK1DUeOJOavZWQL9Meizt/R8yVudnWqq1DkQuyG17MKRRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvfAoYPyeu/ojO0iN3ioYxuZ6IzeLHIYKe3zWCfBlWt56UnZQ
	KAZkbeORE8DMeiz6i3wz+by+zW0DTfG6C6oUW4xKRMH5WZXRzGZi
X-Google-Smtp-Source: AGHT+IESsY50CaRkq7+Sv8BAcwt26tbNnmoJIQEwykjCyVcBMvJ9VxsQ+1v5tXM0gUMi/wxZdfW79w==
X-Received: by 2002:a05:6a20:438d:b0:1d6:2378:cffd with SMTP id adf61e73a8af0-1d8c93f5dbemr10657209637.0.1728875477718;
        Sun, 13 Oct 2024 20:11:17 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e396a71sm2987514a12.73.2024.10.13.20.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2024 20:11:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 1/4] sched: Define sched_clock_irqtime as static key
Date: Mon, 14 Oct 2024 11:10:54 +0800
Message-Id: <20241014031057.8199-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241014031057.8199-1-laoar.shao@gmail.com>
References: <20241014031057.8199-1-laoar.shao@gmail.com>
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
 kernel/sched/sched.h   |  1 +
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1acd9..d0b6ea737d04 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -7,6 +7,8 @@
  #include <asm/cputime.h>
 #endif
 
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 /*
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
+	if (!static_branch_likely(&sched_clock_irqtime))
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
+	if (static_branch_likely(&sched_clock_irqtime)) {
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -507,7 +505,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_likely(&sched_clock_irqtime)) {
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8063db62b027..db7d541eebff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3174,6 +3174,7 @@ struct irqtime {
 };
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
 
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
-- 
2.43.5


