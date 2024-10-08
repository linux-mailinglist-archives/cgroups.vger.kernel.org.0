Return-Path: <cgroups+bounces-5059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F8993ECE
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 08:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35045283324
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50A1BAECA;
	Tue,  8 Oct 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjdXuNW4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370C190463;
	Tue,  8 Oct 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368546; cv=none; b=Fr1+EORmCm/pwmFW6RWeInDWf2/OmqIYUC5OQ1aQ6F8XozYPO7sAB6YCbqUn+iw+zMoDPZLMfa82anDy/x3RZl73dvTtmwzHuXljUQViRDFTucpcngyX/xJpcz119dW+UOcSIpMd6+NWSLfeajVs0X1ID7VkJVNzKzJOkgEX9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368546; c=relaxed/simple;
	bh=Eb8d5lyXFhSllOGcwU1VmnjYWiuaJB9lPUZZG8MTkDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hefMXRFUns3vqywfxmtLKW7zdOMtMr/5Kq0VskgxPSVeT9IWJC07j8tHrNbKiy6Ndjy8t92dbPxLokAEN2xE+Vw9yK4cZIE4bJV4sENLscisBZtWNTbkLtclLYuPJFiJXo2/P2ti3u6aZTXW8RrvLFunrl+RBsYL+uij8DXlbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjdXuNW4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso3830689a91.1;
        Mon, 07 Oct 2024 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728368545; x=1728973345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=IjdXuNW4hSvBlCgqNuw9WW7P54h7lL+jlGF2uZeAaUjJXa3Rh9S3ubQQsG7fOH9tX7
         mrbqdaiJMSX/Z27eft6cn7QhvYkxlJbrx9ew+9XcJ24N35pBRWAhVUt/JNoMaSE2bnWv
         dIP7+oMUaayJ42zG0qdS95xPW99rTY4tLh0pfN4KF2jNrh8OjqmtiPsHUsaAnXAyy0Vb
         7zai3XPLAs9XuA9OFWVPCjDFelZ8JUTsg85ss3kVMAexmFnjVnqMeXIsa/SbsM7ba057
         T6MyYhibA2kPBaJv47kIXH0WIp/17e/0wQzmAlk07kg/r1j+c09tGo3Eft9WiuWJ5wx/
         hfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368545; x=1728973345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCA0RTe4B5CkvnInMX18gUuR5vgyuSITkXk+PtSiiZc=;
        b=xTEEhbeH2O1KUhPLrlHCgUjWgQ+DG2tTYKfXoBXyRefNacDgCrtW1ZNedkXTfHSJ24
         0t1HaE0rRtTzdXuSjgd/weDhgDnZBqUmDi2uL+uy8XQjzQ2G8/KY7xH1qO5oor7LzZFh
         70pooenHEM0keiLmmlFInbhFvt6PD0TSwbwhd0Gt/PLuDylthuj3mdAQ7yYEQCPkS9Ak
         yr7x/uiLoilpuUga/nLCvJ2p/TDHZADSO09EgJvfPzp6sN9GzKgdQWE3QpM4p3EGtoDA
         vk4h385hiAehay0Z3r2rq4hLETqkmSXLt9qLiIv1VZtAkyoj9iUmZKbs/j2gFUuIA+Xk
         23LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIK1MHQTFPwwjoLI5wtf8BK66vC/V4tr4UsH1auGPMMKvbK90enZIwxiQpK1r+u7QCu2SWXZGzwkIKrGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+cdK/2q3FBfHbmkFZ2FAVpLPB7SbFrkuO8MprtNPfxfF0Gkr
	D0r6NpG6FCl9CpToVECiAUeCApjMPqfBwgUl58NO7GxL+yT+tM2U
X-Google-Smtp-Source: AGHT+IHgWeIfy/eX5qUF00EGeX9DuHDG/bJcMDVRAGpHPztKHZUJfEgweeCF+eX/1/FXCx/tRx6Sbg==
X-Received: by 2002:a17:90a:db14:b0:2e2:8d7a:f1ba with SMTP id 98e67ed59e1d1-2e28d7af415mr308078a91.2.1728368544778;
        Mon, 07 Oct 2024 23:22:24 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm8357525a91.18.2024.10.07.23.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:22:24 -0700 (PDT)
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
Subject: [PATCH v2 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Tue,  8 Oct 2024 14:19:49 +0800
Message-Id: <20241008061951.3980-3-laoar.shao@gmail.com>
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


