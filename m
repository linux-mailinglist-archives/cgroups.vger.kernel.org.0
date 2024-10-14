Return-Path: <cgroups+bounces-5107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36999BDFE
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBF9B2230C
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 03:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41460DCF;
	Mon, 14 Oct 2024 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc0yLBcs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EEB43ACB;
	Mon, 14 Oct 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875486; cv=none; b=Tx0HKBgiEDgJvsid3Grojg85U6C5mdn5/6JU0ry63HNy7KhPrhHyawd1Ekny9+XOBnwMOkRZnpY15hF+N6ScIcb6pVzgppGPFxtObx0hVfAY1wOiYPtE6ZwUKAAiOed1iHEYu0jQw1A/GJYX8gytL75kv0NH6s2r7G1BqJncwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875486; c=relaxed/simple;
	bh=Eb8d5lyXFhSllOGcwU1VmnjYWiuaJB9lPUZZG8MTkDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ny6iv7oRHXKrTFcwvV58V2t80W4OJHj1XumhHgSo26oEys2aRvmbHN322eCsqCHGh4bn3lchvg964njRPxp5LuWscCjsxpeZ5B7mA51H0Zqevyi62D08T5DimRDhwYVc7nyutXkX3k1BQMUM2UpjHLIgQjk3v32f8IVgNomW/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc0yLBcs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso433917a12.2;
        Sun, 13 Oct 2024 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728875485; x=1729480285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=jc0yLBcsWqkpRBKhZe0WWV7LfdjszG2PPu1EvPT+qxlzSAYQqD/lBrPUtMv0G0s9aG
         fsDBZVC87eIzfblSos/kwwdwv7IRmRX273kIasz1a7d+U63/kJjgb3BIOZh/JNdd1Jq6
         2eUgo0eLXYXLg9sUp8buFGOWtbG4opgMuddXHowztRXVEUkSdccQBJqeK9nsjGXNt11m
         FgAa+l61yI8H5CgLjrjC6eWY/3nhb/CLK/ifLXjOlGb+xuaJ0R4AY5X+6XbYWEijX4pU
         bzEYhCHB2QR0uuIqhddShRb5F85YKZjqLXcNP3dQaomcN9KTIjAjgIEwUZVriwgRJWeS
         IQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875485; x=1729480285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=kPdQfc73KziKrZg5ZDo7awtijmFfpsGqeTriT3E1+7gIdFKyZfEs3627xyKt9ldiR7
         WMVkaMFKezDyvzYFMJ9mp5vWFXwFM5z/ZXokN/G6hSlnOU0S703HYgi4BQb2GZBWIYkk
         E2wvshpxJoxgX4Fc3VIGpX0EfePCQx6y4nc9H5QESSYke+lRtAozQ49Cti9AZaQL17Rv
         bihSOjgBhnZAYZcVxk2WEH8Odzy6nkPDNHb1Ne284ZKA5hmzAvlbBGDuzN7Q+arVugNS
         4JQf/M/r69DW9m6sBKmol72Pmcdwk+Eu+RWknlvU0dN/ngk/OxIBxEfJe8rW5J865X6L
         tFzw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvBnPk9hWsKKyK9RGPsQORaSqm228KNKmxsVvDxnJkX5Ert/Ha9Qw77AsYNYr42tsTdkLDtrhr7nyiTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwytB/4gdkWDmDSGVbPHrRfIKvyuqutw9pl3vP0+sXKKv9SaC5j
	HjQWtLusE/0Z8XUsx+J0YeexOa3JLMlufAcRDJ263ctOR97Nn+Gj
X-Google-Smtp-Source: AGHT+IE7En5d/SWK9qXnmm9Y+WwUVVPi4obtfuxQzcdnLZbQ4AUsoBTQRGBT8Dje7/JHIXvcBbgX4w==
X-Received: by 2002:a05:6a21:3998:b0:1d7:1277:8d12 with SMTP id adf61e73a8af0-1d8bcf5c061mr14099715637.29.1728875484643;
        Sun, 13 Oct 2024 20:11:24 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e396a71sm2987514a12.73.2024.10.13.20.11.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2024 20:11:24 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Mon, 14 Oct 2024 11:10:55 +0800
Message-Id: <20241014031057.8199-3-laoar.shao@gmail.com>
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

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b6cc1cf499d6..8b633a14a60f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -735,29 +735,31 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+	if (static_branch_likely(&sched_clock_irqtime)) {
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


