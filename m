Return-Path: <cgroups+bounces-5058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BA993EC9
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B741C20F19
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40529197549;
	Tue,  8 Oct 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4LvUqFa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D70190463;
	Tue,  8 Oct 2024 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368538; cv=none; b=GNP5ErnauP66Ds6eubxW08AK3eBONx3ruEUUGUZ5kUAUXCz0mgDImVjg4Q2c6yyPdRcZKKwuk9CBdD8e0NFgjyBLTFDvD1K6xpOvXkWeO4iCo0hcUSei9O59QrX64Pr6LRDSxgJr0nv17zc5eTB9kyvj60YAKrrUCApWOZsZsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368538; c=relaxed/simple;
	bh=mD4RJEhAin69c0Coj5xGRt+ncUmUyzzgnKmub6srj84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VT1LKGakhlQLpsqmdyO9ywEPdJpC95G70kAr7Y5f1fnWBWHiMp+b4jYMr7R0ZwvXKczM6AXt/7O0KKkc+gL8lFoB7iPSCoiNaY/fyYznFy3AgglwZ5T2sgOZ3Xqrb3WwT/baV0y0tCGknLVfDidERSgSx6312/bG+i3Ftet8B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4LvUqFa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bb610be6aso58629275ad.1;
        Mon, 07 Oct 2024 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368536; x=1728973336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYsYYa+owJ/7qI8MxzT4IGktWSYUFxVm242eY9jgz8=;
        b=S4LvUqFaJ9vFRsFOzCDTvtvGge3eXA1LLnMxpPrnU/Ebw1XNe5X5HXMTvMptCRnJaK
         cSDdbvuAtZaNafIQqnL9+bFTgoGzTB0Px72TTIBJZ4jx6EW532diZ/C0frC5sePMED6O
         x/sa5nVO+nP/buAg6GSYCuAk3UWTeme8D6yDoj/RgcGVT7W8qGHbOOIvVN5E797YStg+
         RjkKfVDal2OTbhShj1ztueyj90z90Wyn7yl7OT/YDxvxAkvr58ZTCZV4xm9dNd95hF7Z
         hXFwWjYhSko9FtE/bdxTZB8PPcGDsFXBpCPXRtTaSDGs2s5OBrUasxbxIIs/v+kqVxWg
         nKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368536; x=1728973336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYsYYa+owJ/7qI8MxzT4IGktWSYUFxVm242eY9jgz8=;
        b=a+DmX1bGL9yIGABVaDgDVHYWrAl/i45WRfdvstLyABwUmp6nWA4eU12kBcXyawaiSO
         9BzkPOL+O2AU+lkFciu0OjMLf77thoBpzy5Nkn6PSksHQcn1LizRS9UH/t2oXvW/BUUe
         BAFWpVB1cx6k86IB5MqvLVnlkNDD414gPUpLirkNYEIcpe71w4CUGK9Im4/0o1gx3Wgn
         f7Q77BWO8A/7IhYo7yDefVRI1PCUN3zx5SbdzAkjn7Mv8uVtHypfZ95S1I+l9Rht0lIy
         PyOQGzWkrNx+UDiawSoV1AeTPog1eRIY2n/Tb+g3QPFWqRNMsNwr905qZ2Xp5fsUiDZf
         9WFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pfRnGOAnINXty0Ewrv63sjAMKgum1Jc8z/b5/8hHWKy2q7zKTO5BNL4IdegYw7Zr5k+ED7aFnMJDDf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61nhB7g2prGP3dMmwjuNTxB9Kozq0MHP9h3qsrTA0ZUytDqlM
	bihmB3VDahwfy5t52AlZGUr6Hysst/xvVeLJot2etTRCiIidF5hI
X-Google-Smtp-Source: AGHT+IEuM0/04eemhhnRkg5maHvKPdS/K7f2Wz8dYXLpVx63PL1J7Rihae/q0LlyTt07M4TVdqqjUw==
X-Received: by 2002:a17:90b:4a4c:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e1e631e2c9mr16741791a91.27.1728368535883;
        Mon, 07 Oct 2024 23:22:15 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm8357525a91.18.2024.10.07.23.22.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:22:15 -0700 (PDT)
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
Subject: [PATCH v2 1/4] sched: Define sched_clock_irqtime as static key
Date: Tue,  8 Oct 2024 14:19:48 +0800
Message-Id: <20241008061951.3980-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241008061951.3980-1-laoar.shao@gmail.com>
References: <20241008061951.3980-1-laoar.shao@gmail.com>
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


