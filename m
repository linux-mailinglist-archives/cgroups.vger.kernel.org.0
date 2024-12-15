Return-Path: <cgroups+bounces-5898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066EB9F220F
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 04:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F607A130E
	for <lists+cgroups@lfdr.de>; Sun, 15 Dec 2024 03:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A511713;
	Sun, 15 Dec 2024 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3GEG3Nl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D01B815;
	Sun, 15 Dec 2024 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233014; cv=none; b=owv0rdgxklv+yMrC23hylXfBrpW2APoD1/uLKz5cjj3T8sETsWvM0UosLbmQAzqJooXaKFhPfkzICQee24pVu2NQiKe2AyDLUfYUgxCLtpEE/qTulD3JPgEdWFmfxnHDtXyGXHE3CyI9TwmGeO5+HLBaCtqU2+mAgiB2wejfg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233014; c=relaxed/simple;
	bh=p623LhB5/pgHGul4CMWJvgPu3Z/w63bVmRJAxgcQvok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C23V2uQjQgJ9S4IEG7cMn65dmINl7kiPArDbWfniGOvPo7ZQYFvUcpO4ROR/fKMH+A0g+dENvEWfvYgkgcC+bTnZfLi4QBtuQo4qrAkIgM1kj6gJ6+Lx/0zOa3yrm2wkuVKwQgW6zQwNWNKCuq+xVOXZvX3seOnA9ovol2YkD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3GEG3Nl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so2699903a12.2;
        Sat, 14 Dec 2024 19:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734233013; x=1734837813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=i3GEG3NlvHo5Yknb0XT4FUex627vyJJf6XzRvJYFp/SMmiKwhHAVxmnq7w/DnxClH2
         7M01u4nOgrglSzO5N/2b3A7Fe0wLgx+IQv/kpRu35YLDckbEg+aP3a+ETMvl7ZWSlDpv
         8rg+DEXw9GuCftHi+Ajrvw8XDMGYETMaVvvbOBINptFaftXN510CeTSBY9BZ1wBvYbrD
         C522nD3eqBemuEdxmueCBzgeqyiSeu375swX74b5GyEQVNl+4SW5pUxD2ES1bxvfd55O
         4EGs6lnoFaL0E4LFD1vWJE6mwnW008+Rar10GypmpV0qjweK6WTYtromNQWPV6shMV5k
         S/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734233013; x=1734837813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=ujK9A4skyQh42LvH5DZEqN67FmJ89+xtyYRuxePzSvh+LrcsJl7ei+vN6L5PLz6aDr
         sckliyoKqzmKF3yZACSxzDE3C5c1BO64N6YkSiLzc9v63TjFaVtqtJUVMVut/NImUoOz
         bZemmo0x6gEACiOIoaoEScD3J3LemvuOBceXAL5zV5zxV02tOiaBQjMdvMGpq3vej6d3
         CS3XTD3t3e25qcmRjvr+YgU0Ki/uRCkYaYQRxzPRhUh423zXbUoU6YJhwi7dOLbG820C
         WNtS04UA6CbyCPb1NYKzRbXbNPBydHKikT5pjTk9sFhPL2CPa3xDml9fE4o3jG+gfekn
         URAA==
X-Forwarded-Encrypted: i=1; AJvYcCUIkVp7oULs6J+NxwFHOyLC+4LRT/mOwBeC3tzmobEMPYSvBjwgJ4GdMhnQe9mOs9m5aVgLZ0SEX9oTC/pI@vger.kernel.org, AJvYcCXIPE7PajEE0/9WAMVLmLRx5/Pn7th9riPVw6QVYGm1rKb5vduZCEjZ/lL/rLKQgEpxUFyFWonq@vger.kernel.org
X-Gm-Message-State: AOJu0YxvO+h0hHNX0vFJLmlBTT2SlN2fjUdRYBOkTqgvOhnlrZpuD3LT
	KaVh0OOUUZoHEl25jCk95OhYIorweBF0K29+vOW56wHB8fI5Jajb
X-Gm-Gg: ASbGnctrbdwt0+Fxx1wtyXpefGcs+lBPTJzJhh6yKx4b1EBpO9HU4wXtlRS2mlO02gs
	EoWrKJGPsGjiPFPuOymx7oPEnQFqfqe/8Dqu6WWjCDg1I+7jJUS3ggne0ftXaeDiXUTvaNmEhya
	A69QkrlRhyEWX/oOKNMTv5pKznUdL6/MicixtL0LY4nYphzmcozxym2FFLLM7WdtA1C7tkZY3NA
	PWzIOPIhci11ma3vJy1KlFII30zfLJS9tZzuXSwYSjRhn7TSUOrvznvyrBUsr0ApS/pBnDpmqQt
	mX/t5BE=
X-Google-Smtp-Source: AGHT+IFGvb2CHVzwR9hPAjtJk1WgngOZ/5HoaHh3EGO72pAtuelyrHlLg5uIQRaxsUMmJf9cl7cODA==
X-Received: by 2002:a05:6a20:9143:b0:1e1:9f77:da92 with SMTP id adf61e73a8af0-1e1dfde6d4dmr10598466637.33.1734233012781;
        Sat, 14 Dec 2024 19:23:32 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f1esm2176586b3a.92.2024.12.14.19.23.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Dec 2024 19:23:32 -0800 (PST)
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
Subject: [PATCH v7 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Sun, 15 Dec 2024 11:23:13 +0800
Message-Id: <20241215032315.43698-3-laoar.shao@gmail.com>
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

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84902936a620..22dfcd3e92ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -740,29 +740,31 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+	if (irqtime_enabled()) {
+		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
-	/*
-	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
-	 * this case when a previous update_rq_clock() happened inside a
-	 * {soft,}IRQ region.
-	 *
-	 * When this happens, we stop ->clock_task and only update the
-	 * prev_irq_time stamp to account for the part that fit, so that a next
-	 * update will consume the rest. This ensures ->clock_task is
-	 * monotonic.
-	 *
-	 * It does however cause some slight miss-attribution of {soft,}IRQ
-	 * time, a more accurate solution would be to update the irq_time using
-	 * the current rq->clock timestamp, except that would require using
-	 * atomic ops.
-	 */
-	if (irq_delta > delta)
-		irq_delta = delta;
+		/*
+		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
+		 * this case when a previous update_rq_clock() happened inside a
+		 * {soft,}IRQ region.
+		 *
+		 * When this happens, we stop ->clock_task and only update the
+		 * prev_irq_time stamp to account for the part that fit, so that a next
+		 * update will consume the rest. This ensures ->clock_task is
+		 * monotonic.
+		 *
+		 * It does however cause some slight miss-attribution of {soft,}IRQ
+		 * time, a more accurate solution would be to update the irq_time using
+		 * the current rq->clock timestamp, except that would require using
+		 * atomic ops.
+		 */
+		if (irq_delta > delta)
+			irq_delta = delta;
 
-	rq->prev_irq_time += irq_delta;
-	delta -= irq_delta;
-	delayacct_irq(rq->curr, irq_delta);
+		rq->prev_irq_time += irq_delta;
+		delta -= irq_delta;
+		delayacct_irq(rq->curr, irq_delta);
+	}
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-- 
2.43.5


