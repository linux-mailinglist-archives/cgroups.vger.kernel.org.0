Return-Path: <cgroups+bounces-5362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D579B89E3
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 04:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D56282F16
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 03:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FB145324;
	Fri,  1 Nov 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID4ph9Pl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7776146596;
	Fri,  1 Nov 2024 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431093; cv=none; b=MbwgtBCHWkzpT37dUX5v942WUng1VyPAuC+wD1A/Fxj2dPWlDL4iMEQ+0heCEVNjntjDS2UNr9DsshALM6PIMhOSbBLGNN1FwS38j6N1xac3VwBtZo1ztOIj384H5LB4gNqeSUbbl/aQ0vsZDVxsmpMfvSwRLkNDb90FRrrHRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431093; c=relaxed/simple;
	bh=hoBYOBwvRWg95nA71vWiykGK7mKakjibn+uJFK9Yvu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fc7EpEHWrnodLGIqi/43HjU3VRcwjrYHvo8WM7tTrhmDl5U+fO9jwBUpSm/t0LHHkLQ8617QL//e9CK9G28Oe2llZa7NsnAEos+v4SIKpzNu1LjsI7KebS7VpBVea6PQEAwFgL+ifeCMnidbFySOxhzD6SeUSQLudi6TK9/CcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID4ph9Pl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720be27db74so930297b3a.1;
        Thu, 31 Oct 2024 20:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431091; x=1731035891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImL5gbpH80k/RQVQHmGfObnVHocW+7l6/wYsDpcrN+I=;
        b=ID4ph9PlzKe7EONZLkY1A317CJo0634cv63r5UfRS2UIX7jLGYq4qhcvwU1ihmAWqK
         ZypLn+WzsI7MDaFPbOcJUgreyHOCQunkk9xMuKtJ9xMPl+msqnR1sMutMsljCZTX84QU
         Hnk6G/0A93E1Ea3a+0wZSDctbPtVeXEcHD6zaX1LoORda1HWKHG7/1UGrteOfzMlnR4c
         hBLdGGohimlY6L3xmOX4hOG0hRiyyMG706GL+sczPx0I528+A4invdB8ZkF8Ai3fxMOo
         FS2wK421xMu7bvco4c3UckW+hlmNmisHqxUhWZwjlISMp8yw3ITmQMUDKyiPtjL8kt11
         LaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431091; x=1731035891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImL5gbpH80k/RQVQHmGfObnVHocW+7l6/wYsDpcrN+I=;
        b=MStRHpO+04qACnoGrukWblFNV+1DQIw2vU7dw5TmdkQSDNlsC+WJoOBcYi7og7lckP
         LdLrtsrzupl0GQqIFDKCyClbCky16W7QmjK11g0hAS3MddM1OpFwJuQdfNyqIRKDLPif
         CIJ09Tn2LyCC51hrpZY3IuNQYg9Kr0eKP6B1gONkn9xKcydskTHyu2BkwvQViT++cLvh
         WX/fk8ExwGfh3QZXYVZhL+kMcbjMvs4+yo1D5mfLc2hTTswXrHDUzwkgwYek5zWQx92/
         Bq8TOvNP7U6dISQ9+/Ok1Kc6DwaPI0lvxr1fXDliUkR9VQIfix0vcHHdTZ3YJ5Ti31PL
         nmsg==
X-Forwarded-Encrypted: i=1; AJvYcCVBCZMy/vSCvEx63hvDdOeABYx/MjA/5O6mxNtbqi1Mlu2BaivmToshiRna6lCC1dgW3izEcpm4@vger.kernel.org, AJvYcCVu/Ovbtzai2ryJbSxGu0YyqsbDDdMZ2RASf+I30ehjsnKXwOZrkA82fZy3I7oA8XHcMJ46gkjoZ8+mmExy@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPgI0Hp3syGdQchrTFC5SU1d82l1OCQjLeb/DFkz/3n9FUUaq
	EQr8vp4FNvUsddjIzPe50UL9IZfuvuP3QKrI/sbPTTaaS3Xtn+aLcPgWmle1qvzCNw==
X-Google-Smtp-Source: AGHT+IEnuOkWfX4734hR4p6OeZwydqRMrrRS2qoM/A7bvcA7g5CbgJMYrMjsD+XsNHcf/w/9l6Qp5w==
X-Received: by 2002:a05:6a20:3544:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1db95056f28mr6822894637.21.1730431091084;
        Thu, 31 Oct 2024 20:18:11 -0700 (PDT)
Received: from localhost.localdomain ([39.144.44.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31af9dsm1854445b3a.217.2024.10.31.20.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 20:18:09 -0700 (PDT)
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
Subject: [PATCH v4 1/4] sched: Define sched_clock_irqtime as static key
Date: Fri,  1 Nov 2024 11:17:47 +0800
Message-Id: <20241101031750.1471-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241101031750.1471-1-laoar.shao@gmail.com>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
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
index 081519ffab46..038ce65d6635 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3179,6 +3179,7 @@ struct irqtime {
 };
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
 
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
-- 
2.43.5


