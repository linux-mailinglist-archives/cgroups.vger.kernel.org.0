Return-Path: <cgroups+bounces-5800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6D9ECD03
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C8F167C9C
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BF22C346;
	Wed, 11 Dec 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzoOU8WS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B022B59D;
	Wed, 11 Dec 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923083; cv=none; b=h41BBIWf6c71D4JC2DoYrebh7VTL2CnZxMMHF/gVw/TYt/W0fEDQ9vwYGrCRge/KtOjS95eoXJAey0Ct9kCiSv33ydENt5LWLUURvm2DfXmsxAVuO8dwB+AtxzEDqsMj63CioFSCu0fLcdBk0BexPX7snPz30Ozg8lbi5BQenug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923083; c=relaxed/simple;
	bh=d50T/0zGgVUyO6cd0DNoB3JWuubb13PgiEr69YXBdWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7FF6n1xe8TgkXwaqEVrqvvOgZxN/pLVnR1gv7LIZ7os2/E8x/yxjuWMDLimM4wluoq4yynNbVwd0r0hIJU5Bz8+FtbzCYO/lUDLNDvBevOvl153pQRis1oF+JI/GnQtyM4BSNzSmkN4SO8cNbsw1OFgyw+DRGzsGh669tp4wXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzoOU8WS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72739105e02so2738671b3a.0;
        Wed, 11 Dec 2024 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733923081; x=1734527881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfhKjLsWJbVZ1NKZ4UFy6xoLQKlWruWzaoZaagpdc1c=;
        b=WzoOU8WSZWWWKh7FhEslogeNHFNl4FiUGFPJcQQeukYuCVqRQYMexkbvlUYV65H4P/
         6dPoxk7IvfqgZkdu4lfD50xR7lZxJE6JblYnSU7HUG8WIHhO/JaxJ0KFPQJ5z8nkpO30
         EQUxPDuBJGqOP/p/D3S/NZKb2iJskf16USTmRmANs788bd/QRGrrxfvSGTtHhbvYs0+5
         XuEQGAQ1G0hJBi+tkymsu4i4OkyAHkNP/I2crUoOgAxDYK7aT4Ijcq9nT5TlMWDPlqsY
         kHYYnK6KvEQRrDn599Yu0Av4leIw5wfudG/EQaH4QN8lZsKhdtCv6KIHNgxFE48UYLL1
         6H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923081; x=1734527881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfhKjLsWJbVZ1NKZ4UFy6xoLQKlWruWzaoZaagpdc1c=;
        b=D0Uh54HPTHwaLF0v3zRMOWCn5WznspTKOIHbaf5DeK52h4XwYqn/+J5nuJJvJzfPBf
         rzAGQ9/R6oVPieCcZPA4mFUtJmS/pOCDu2WMOjyK6H/JKLRFgZb5b3WfvegFEcVG8oqu
         Ku8K8gLy4oNZVfICDL1SPBjY8sqHOC7sVPPH2ecycnIWYG52ieflDH+Z5nI9erw/kUz6
         +73e0xQKGdS5qXMcJc81CCcRKb6FHTNIvji6Oyf6n0jv0h65pv031giRfK7XMUhkx7Bh
         Z42Q6JfiVBvk0ChK6PIm0/BnLctC86Q/Rkqidr6HqgzgJE99S8l0nuk8HaENmyoyYt/F
         t+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHg0lXXlZtMB3Aop8HVRYI9aa8dreglGq/iYbc5UStI5c32sZYwdD/ZGYMSisOKDZvfOUtg8LS@vger.kernel.org, AJvYcCWgTFmNyh4uSH0NlZysI+a6qGWevUqE0vBVVFc/pfhURMFgHo6UaTos0LMdF/U3XBTzshDzrvZInOdUt03m@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04+IhpDj4lJwKxMW3PvX+6ps2X1t5zHUc0CnmKHQtNvWD82aX
	7sKiURZ6xCCGfYIg2tkVkMD+IGK4JZNF9Sn5LEH7298ACUcqs5V0
X-Gm-Gg: ASbGncvRpkOkArqawK8GgcWhyFjfA/zbsxNGXpTUqsUbb0YqzeekbTg4Yrsfjk8oJI+
	DPkKLHDaSAnxiUHTxgEq/FUcG4l3qO1Zu/45Cqu0GgcPrpQxVJ79SQRnIOfFD7+O52hNmaS9buL
	5qinMuK7n2RZIKX4W1z5RQ47G5ZEcAvkwm7zzhxZAOYtGqJ/pZqeEEImliNa3FNCfhr379Z4MmX
	pBRuwLJlWBG0yhJC0Jdv0RtUS7hN3lr63Mq9yQeQVsXeSXj1U1T4J96xGLjbwAtA+EOwxS8cvzc
	RXbM
X-Google-Smtp-Source: AGHT+IHsWU4lPadKWw3hYEQiOSN5Npg7sIvfqlTKCMi3MM6NHDZEvh4Hdt3Tnlp1BJbmxGKJgdtXMQ==
X-Received: by 2002:a05:6a21:4995:b0:1e1:c1a7:67ef with SMTP id adf61e73a8af0-1e1c1a7694bmr4344711637.30.1733923080647;
        Wed, 11 Dec 2024 05:18:00 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeb536a1sm5272628b3a.115.2024.12.11.05.17.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Dec 2024 05:17:59 -0800 (PST)
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
Subject: [PATCH v6 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Wed, 11 Dec 2024 21:17:27 +0800
Message-Id: <20241211131729.43996-3-laoar.shao@gmail.com>
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

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719e0ed1e976..a2a8d3d8da25 100644
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


