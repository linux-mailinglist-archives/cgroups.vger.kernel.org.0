Return-Path: <cgroups+bounces-5363-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA09B89E5
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568D21F2286A
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62B145B1B;
	Fri,  1 Nov 2024 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDU7bOUT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F43143890;
	Fri,  1 Nov 2024 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431099; cv=none; b=Hs2LeFh0fy7jxJgfrhiC7CGoSkDrufGNukcgoWMbthZHLE8rjf6Vz35rYwheNNOH3Vhl++6VGQ/Xn3UrOyYwvv/jAWwAf3sVfhEF54IgWQuY73i2kuR5h0ziry8qCFXbMXk7uRvyTFl7KY5TG1PPLtWTX7FitpygqkLT6sjdcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431099; c=relaxed/simple;
	bh=6kwRE49ETYWaNzkeA8XdNMt4XaICAEAnI7Uy2TCX2Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgDD8vkwZtYjoZ6SvWGKzeiZw4IWCc+Gs71s/AIEO3gw5VWuysqs1BpLORAxgZ5QX0wzgyL5iQHkzFXYUW5g3BAQppkc+7jyhR44kS4DhV5D1+ziecZWRB68QtXbew2f9dVCFJvtIELqxh7L2shlq/1fdHtcEKVHUXQLF0otGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDU7bOUT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1302765b3a.2;
        Thu, 31 Oct 2024 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431097; x=1731035897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCOOD+oOSZ7Ku2BtoyZC97RAuaceez++PiYgbbH10I8=;
        b=gDU7bOUTaCFyoeOlc2LiL4fYs6QTZ/DMVvAmXYfgXrZ5DTYQQtlpsYJtE2pwVzr1O+
         QALDgzFDorqNvB7+8OM6od7Amgr7wwCbRNzUxzn3tDtL7KWqI0YcMS8rnI4tn3oaZ3QE
         8Ohlc4Qv9HCh2XHdgUgGhb9jDjkygq2if/c1BJ5H9oYQzA7UYwZaJSCTzehwa6nAXfGn
         SbLB4pdw4T5T1NPrlj8vFoFMNLRiH307p7shgDLupud0e7InvOGcjtcwlQRPKVt3th3E
         IgpAVh3v80TYPAVysy/JDgQo9LB7V1dhCO+IlJAfXP/Wu7Yfpe3qMGn0rcPaAVFLkHgx
         isGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431097; x=1731035897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCOOD+oOSZ7Ku2BtoyZC97RAuaceez++PiYgbbH10I8=;
        b=puTcy+SiKRL0rMMH7U30EdDbMRo0xqZlch7AIT/r/D5l6OKXsZTQFwvq0AwZ0GCkaQ
         GK6Yn+WhxwoTZAy1to4XuVje80y5hsokawb1db+yqzAlmSxS7vm9rtxLU3cNqxtmZ/QS
         M7+eYMRADyNQzJq8gZMSrL5J47i5Jn/yE60oLjdjmqYKd/M6ePUGB5ea99G0NQnJ4Mzo
         LFBu66VwN3gwKnZoodvfEjWXAod/lQUN7qIMrlVZCn9lUbvOSCY3FI14+FF1MhxdSW9J
         UNYoM8G2eEplwMUF8H0iwbV525kQKzpUyqlNhSR07GdGGhFDVYyZH5m0TPHRgvZN3T97
         9T7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkmecTrOwLOfcHLtWDUi7ialfxGNdrqRM2kRCQO237EYdQOSfNaEnzOfr05ERf0nLgpOqwtjPu1V71zxkf@vger.kernel.org, AJvYcCVv+WAsL7MHbZUwq1KeOoAJT4UbxoozmRpcfvnc2r+FPD85Ri1dQygZ8YxE4p9KBdCtwL9I2rac@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0UwJQt5gxWT7+mzaWOSmW1ByBG2kAXdSmZE5Puv0LFs0Tsnb
	uvzPNz79dqX+BzlX6M/IJNMr6xFv/qQXAV+xC4BHdmiQfafGw8T0
X-Google-Smtp-Source: AGHT+IFp3oIRnkmXbG2waFsi4w5plsLbXBIX8s+1Wwg/DGPH2uReRuRsOAEKPmyk8MHm4Z7xw3lt7Q==
X-Received: by 2002:a05:6a21:e88:b0:1d2:ef5c:13f6 with SMTP id adf61e73a8af0-1dba54e0957mr2097436637.34.1730431096781;
        Thu, 31 Oct 2024 20:18:16 -0700 (PDT)
Received: from localhost.localdomain ([39.144.44.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31af9dsm1854445b3a.217.2024.10.31.20.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 20:18:15 -0700 (PDT)
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
Subject: [PATCH v4 2/4] sched: Don't account irq time if sched_clock_irqtime is disabled
Date: Fri,  1 Nov 2024 11:17:48 +0800
Message-Id: <20241101031750.1471-3-laoar.shao@gmail.com>
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

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbfb5717d6af..06a06f0897c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -740,29 +740,31 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
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


