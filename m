Return-Path: <cgroups+bounces-5986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EA9FA384
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 03:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268A47A2B88
	for <lists+cgroups@lfdr.de>; Sun, 22 Dec 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3908A1AAC9;
	Sun, 22 Dec 2024 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+N8P8t+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976074BE1;
	Sun, 22 Dec 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835684; cv=none; b=iCpl35S9E3NrExmJYbiNeo2UjZNw1U30JA/aPXGZ+HbpxAnD99iKSfydjiBmvauK4ivo1X/SBH6enLsuEzrBbF3+NQPPXIK+S9ZbizNpQYA+XfH9wWfwCSQ5OSbW4f3zKYlk2d0YU2YEUnxoQY2D2Vfd9dswO1KU6zXYUCQ4NSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835684; c=relaxed/simple;
	bh=p623LhB5/pgHGul4CMWJvgPu3Z/w63bVmRJAxgcQvok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtAyt9cwvU4jSfdAzgyaLPO5FpaBzbamy/k7YM5jGbuqQziP98jS4nn3REuQgD5ngC/H8esC2AbyxVcv+7UhS7HrjH2SxodR9Kj8f52RY//ysX6ZdEdwY9UdMZyhZL8RCCzvtibKep5tj2czXVXTlRjjwLqaSaSa28FPSv1P/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+N8P8t+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725d9f57d90so2343576b3a.1;
        Sat, 21 Dec 2024 18:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734835682; x=1735440482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=a+N8P8t+h13Ac0/1Ky0XETdkpgX3kDH4Ij0VfUINlYR6lGgxSqb3QS4v9oaedXp/UB
         OQ2Y5XdasLYM7NEi2G33GSo24yNZP93CarcWKNLjBDTw9JHubMSCcge7u0uJCdgENrZ6
         gFX+GmeOVzoYzL5PCw1r6W3kZFQqpYFl71701As2wk/GMrfDIwvuH6GEQf69+bk3RIrI
         gW8wvZKbmFkvuE5Ch6Z+fF5jqiNtLnzzP4c1diiLMDCpHVeTcKvywrk8YHPqQRZ6Tnhs
         YL7NymmE9RFRvTClfekILx533cJpIdQ1CYmeHGwHQBMjo+MfoJKqcdsoGDkM3AmSAAyi
         FNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734835682; x=1735440482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pfOoxJev37uPhhhtmnxcIpBCI1zYq5lZd98FYyO5K4=;
        b=D1YqtsQXVWPdx4rC877ZsnRSyOWrDyrWrVaAX9zzCWIGobybzUxHi1MTCKSZtRcyis
         1OSQXavYNkLPV9YNFTrKckIEtUPnmLzIYcOVW6nnrzsu2r1gWkmlBaj9Ta3FrDX2dgYL
         rUrJoZYUcNnm1M1J9XCffU1HOSd+ZPBOhOfXhSw+EVQzPEJ+VK+BRLtdfz9kKyjObzGF
         um8qSn4CvBRloaSPhzRGOTOIXGTvn0vGhg5DKPgxv3eV0miksWBH/EJ6Jn4glzLh71l6
         QSp12QfZUwafXwrdsEt7fB5Ex18el3uOz3ZCqc4if3klC95ElnO8QtjiHBYXwOiKELu4
         ZlSw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Cw1OYz8OT3st5lCEhEzpLoyCMor6HGNjltAdeqU/ssFnv04gmaX5N0t72mURnjGStmaUk5so@vger.kernel.org, AJvYcCXi3OWq5mEEsdZbfmTBlv2Xeq4qT7HaD188iAyUEdYlqR0ttdli+sLzW8aaeMN4Y2qvvBVO6mkA0+um33t/@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfFSCSG3iaRhDMbDNjR5Pra+4gjCam/ZgIAtAAu4ePcbJMJHU
	ARY7EzxeKPPVNDUAE9TeV+nczNuL1IcUQ7tD/d0llc1bEBPfWNAG
X-Gm-Gg: ASbGncuM+uvH6/pcQIU79Yf3unjei9vyXM3J6A08grgNmo0YJXDa71rUj8K6ffWeLE0
	7Qv8tNPxR8i4JbhER+52uh3Vu+CtRqBFGD9yAWpoRd2ntaVriVsPgTCK/QT5NJqYIdQrexV/hGY
	MHlNGdELYODDBpP4Eu2kF73UPlX7XqvLvtkmxxWI+BLqn5BiX019q3EVnUomB75Tq3Pi84No4vS
	1EepxNJkHNj01B1n4k3QsXN+bbOpsWzKI1ycOMIQcX05MlGcg4ZP9yhUx9N8rreuIDEW9HNVufI
	iZTrBpg=
X-Google-Smtp-Source: AGHT+IHeulpUoVyVtiVqmKk+T6sq3uPVX8XX79gsHC3WlhgWbz+XjzkUZAwXF+x15UhBIKzQ5MoozA==
X-Received: by 2002:a05:6a21:2d07:b0:1e2:5cf:c8d6 with SMTP id adf61e73a8af0-1e5e080ba76mr12138266637.36.1734835681819;
        Sat, 21 Dec 2024 18:48:01 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01b8sm4219265a12.20.2024.12.21.18.47.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Dec 2024 18:48:01 -0800 (PST)
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
Subject: [PATCH v8 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Sun, 22 Dec 2024 10:47:32 +0800
Message-Id: <20241222024734.63894-3-laoar.shao@gmail.com>
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


