Return-Path: <cgroups+bounces-5479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9F9C1E0C
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959F3B231A8
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7571EE000;
	Fri,  8 Nov 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFaKLNH5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF01EC015;
	Fri,  8 Nov 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072570; cv=none; b=E/bs1y851L86gsWQUxyGB6KEBPPg/GbIcClgSsw/Wg9dYGKbeclvLHJGjAhEXhiAariquUc6Qj/OVVWsWH/LCQdmjR+pfBFfyUG2OlCaGml++paZqJ+UkyhwMe2jC2J3imBK9RXJVr4vdnfQb0RxxXqbsA3TBFhu4W2sfhoSvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072570; c=relaxed/simple;
	bh=1em+axrvF9NwNv7QaMn9okeJtnJ833xHpyR29l1vHkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkHlKGA+pOmnw0jas1yrp1rIyPx5DhvFq+yvA1CPsXKqFRJcKpg8pQDcpL0yJjV4vQixdimSCVkgBMB0kPbL8FGdkgyJd7t1leAS5ck7h/gIwmA6zIb/3C5BasF4HteG66iuW7ehvic2JzCEiWNIMlaGQXK6oW1FujbJXsU8pGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFaKLNH5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1561636a12.1;
        Fri, 08 Nov 2024 05:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072569; x=1731677369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75LfCx1c72huwMJ9cBBxyuvVsqp01GHj0CZoJyicaVg=;
        b=QFaKLNH5p2hll5mqi60GaDSaFrsBeZExsderA7XrKraHl4QgO8SsNtSsmfm5PKAFar
         F2AwPncZGvw1vKhCE1nIl62003q7nZNNa/KSbhwTaSLSA66E4bjymeDrqZ+psQhMSIXM
         qb44iRcMBQ1G8F+c74TRz3lZcPBIXrKwrLWhZSaNyGWRkE4uApaeAXCRnqvodoaEwpjJ
         Fjaisael7XQNxdI+PJbfJ1Ji7NJsNSdh2iWTDgbIqandVkuPnrMSvvcDyKgpxLpvxP53
         UNgOMRor7FtXGvgxaj2mM057qZkDvRhSa/drzczruL9S4VRIiHw7/Yc/U5qazukPvtZB
         Le/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072569; x=1731677369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75LfCx1c72huwMJ9cBBxyuvVsqp01GHj0CZoJyicaVg=;
        b=TGkewE5HMmWO6y2olXiKv4PkXOkyN8ELXHOylNecTMobq6YU+E8pv8E7DrTgAhnui8
         o50nILErsPU5/4qMZY8yj0z9Q8KDdp18lrH1kYX7XbeHafXkSyy9cO7UXC+XFHpHP/Un
         8BnC7qqyFzFlRUS1WXS/yEvd8xPITbrHO2pjNdznmGYppDVUZ2SS5UJynlGl1lVE6AQ6
         7QJzBR42eQ+oQfnksKMc5grm6Qk6VLe8e9Qp8f5EZdHT5xEYNtsubgUuTiZ0/23YRw6u
         8RyOZHAfd2W7R9AWNpSR6AZpIWODNHFW+DPicSvunCmNCSqNI4hNZOBKsNm9q57uWVbt
         yIbA==
X-Forwarded-Encrypted: i=1; AJvYcCUZv/3g4gBTakLgzuJrm2iS1RMDRAXD3JKbpbVjeXZSa3fiNbIwEW/NNaeHA1A41AxmIg0zA0GnS52pKGwr@vger.kernel.org, AJvYcCXQtfIBgc5ODIzC0S7785PVqMlzaP6LY2iJbiJOA1aDwS/Ge0kiKsuvFaKj0zfJ1Bd7OKC0zG1s@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtebskl3tpiVAZaQvK0QkrdqY7Rq9ujRSkTGvdMSWms4KJxR1
	YcFkyO5V9XAWcYT5uz/vokN++Yjeixj/iPc1R9ETmESth6DuBwLF
X-Google-Smtp-Source: AGHT+IEUhJgOI1vmuKjBMjYKIz19xNmd7ocadeN2ED+0CdgUKOSWhRBEBI2lqV4N/y3ATA9xap+Qhg==
X-Received: by 2002:a05:6a20:8404:b0:1d9:d9a7:dd36 with SMTP id adf61e73a8af0-1dc22b54192mr3295225637.32.1731072568702;
        Fri, 08 Nov 2024 05:29:28 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm3642561b3a.86.2024.11.08.05.29.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:29:28 -0800 (PST)
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
Subject: [PATCH v5 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Fri,  8 Nov 2024 21:29:02 +0800
Message-Id: <20241108132904.6932-3-laoar.shao@gmail.com>
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

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbfb5717d6af..a75dad9be4b9 100644
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


