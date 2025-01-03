Return-Path: <cgroups+bounces-6037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E09A002B6
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 03:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDA16284B
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5819F12A;
	Fri,  3 Jan 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShxseopL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AF1459F7;
	Fri,  3 Jan 2025 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871080; cv=none; b=cUqJ/hA6wJi71Ex6YT5+mW+Gb+xyC3W2Brrjv+e644oz/LBOsV6h2sSQbedHgFjuo/l9J/ueUUOvpASMxY6ANKWcwf9AgdAzPq/9wI9Y5ZGMXz3nRvvu4yO24PvlNHMz9xg+RTV/hQBJE2M0IzNjyBIfsZgsKETnEfBK22B01cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871080; c=relaxed/simple;
	bh=p623LhB5/pgHGul4CMWJvgPu3Z/w63bVmRJAxgcQvok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbndelySfxk/L1zPHT36Bc3ZDJ268TfCmmpioQHWAsmf8QvRYB+6Uc7+PiYhmJdFF3RL/oinO3jX61pO5Pqsdfcg0gNT28WlJaxblTyQaDicKEPbfy09l/6pHK2tjDCDvSINTbkTdxdaA05JsWGwIiIoCgNRRhearouFMN6BLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShxseopL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163bd70069so65173015ad.0;
        Thu, 02 Jan 2025 18:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871078; x=1736475878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=ShxseopLyUnfa38lRIgcFmC2ejH0v4dm6Hn4XuvBMNJnCVWToiNex1SSjcAuB9D5U0
         NSF66sGm/VFdMJGPqAoAUqZqp/3gcyxySD1K1bomnPFU67XTZYC31mvrcJHhwcRC6/Ua
         +cTIKuOg6Xwdj4m5QW0uKvlwkwNOqmRa92SLfYZAMLyPn7XB3oeVJfmZqVYRYcDKoJTf
         qrfLSkN1ywTsMWSavFooD9rDnbFfdMj3+NS8B9vl5JyLxuAqLj7U4VCEW32mSzprGH+e
         T1smc5iNfAOmpvjgTSPyj79a4AdytgFOVHtyJJzC86/CSAUxaW3OGhIADDgxoIkRSBFk
         cScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871078; x=1736475878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=RZTtLDPptk4TgZF5XLw/eYDlY5kgRLLt5T2anLuoctGLgoyanMmMsPgHUMJ7/+ncpv
         XhlwF9LimO0JtyvSkd5ChxfVHP/LzORbJ0lcT6sT3OgLipREIm8w22ZU1k3Cf51uMREb
         fuDqsF1zO/VzCTsIbh3QsrJYKgPdFu18FTKoE2e0oO4QNpzpmBF5wPHeGHtaAmZp8pXi
         qbKsUFSOvgb9OR6TIIHKS1g2Tn+w+uOnb26Shqxkvgx7NMoENitOD/9+nLKPI0v4sbVu
         1sY8ejYCZ5CpnP0cB8AUe/C+4iwussObEsY/lZRTjB0QmxMfre8MEiII+KpK2+6z5sma
         BCqg==
X-Forwarded-Encrypted: i=1; AJvYcCUnrzZcPsMZ74SJzfNa5KtdFzw4CAmRDfKq5n+0yMiNkKS8W/OSl4wYcJgWJkvzriZOXKlFc+g6Mp35eOVu@vger.kernel.org, AJvYcCWRUbjUG39OSE9pBe+0eFSrDM6pAr5gKmIZtWOEUsB0kJkqcu/vBAdnjaimI1GWokx3Gx7hxWHl@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLZK96hvyqtQFgRpPg3NxQdWCmk+nXAsJQKrEDlDdLRnNRpYn
	Yz9ces3Pl54brQW/FQHw+gMuSiYxu+AeFxBFl2lJbv8HbRLsCcBJ
X-Gm-Gg: ASbGncsL3Nd36EokBPmq3AZqIKZd6CZQKeUPGVYGBFCZwnmNtYcro6xtUHgZgVonfP6
	Q9deAedn/O73VudfY9LwRtdG3oNtxwPOHTOmwFDATyqXqxpyiukTXBnP5FUVty1D8sMyxnWuDyf
	KtHdatryji4RD4dOI49LQjudAP78ZIlVmMq/rxKnNNR5m81h3Y9NiEsEVc4w6kUHCF92kb6qszn
	iyo8N2sKYJAeEiv+3BD6aGq4a/W4yv6aKjvUy5KxT56OPV7iH84YJQYvOgfmbOc/qPJ0nSKHsdY
	QvA6tdk=
X-Google-Smtp-Source: AGHT+IFjV4O/xJ4uaqSufRAEt3pchg5BDxp7Rwle86ok33kSe8uitOTPdv/zDJMB1OW96j7KNrpwYw==
X-Received: by 2002:a17:903:22cc:b0:216:50c6:6b47 with SMTP id d9443c01a7336-219e6f266bdmr658362965ad.46.1735871077603;
        Thu, 02 Jan 2025 18:24:37 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca007f3sm234184145ad.228.2025.01.02.18.24.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jan 2025 18:24:37 -0800 (PST)
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
Subject: [PATCH v8 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Fri,  3 Jan 2025 10:24:07 +0800
Message-Id: <20250103022409.2544-3-laoar.shao@gmail.com>
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


