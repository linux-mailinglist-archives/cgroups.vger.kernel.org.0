Return-Path: <cgroups+bounces-14872-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II3IETXaummfcgIAu9opvQ
	(envelope-from <cgroups+bounces-14872-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 18:00:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0332BFCC9
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA2233241FB
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754E39280A;
	Wed, 18 Mar 2026 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ5eef/g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AB3A9DA6
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851640; cv=none; b=KAFlfn5MvowBslQlG1Aa11ag/GxQ+LvjvWRfgJP/9ehh3ZjQlcMTM27w/aocuZBaEPWME0h4bOtaS5tux9nh9Pe+bHlyBBitScTsB2LI/VHBjAsIb+QwhNsFJJlTO60IQCt0FP0qLSv4LxDpHfJorOFLwW6szNsikZl5ie5Yci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851640; c=relaxed/simple;
	bh=feadXaVbDpt09d0IHhCtU9IhpkUdkNyxiJB78Gzd9wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+QIa6Fa7eq3Mzb5IRDtffGrPHMptJn03GIGckunCelZvRtY1BfQQBwMdlJiattgILX2hNQsv2ObWMrvTV3ng0Ap4ZGEpuPcFOnX1IVFrDIAIVjqluwWR2m1dlPOhKNfEiMVROqFQt7XRRtUW4Ag5Teh7ORS3nYFdXl6ruFGX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ5eef/g; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c739561f0d3so18785a12.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851637; x=1774456437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx2bMmg0TFOhekmjlMiH/uxb0wN03CxoN0qCye5m4u0=;
        b=RJ5eef/gE/eQVu++kkzNfOQT4T2TWDfvt45j4Jwv6A95LGKBPe+8GIP9ywyu2096dq
         RsDzoXeFV5SQB1TIfbOcOV60JlLve3PswD2IOOuFRysQOA38LGlmyZpAMik37YK8is2z
         dEGUijS91W4A+oe+WHCQhyBWfC2noz8kxVTO3S71Jq4cS0TUB0mDskkMkTUZTUxYdst6
         rTH2I3nwYfB5bTaBESxNc/vsXCS4PbZrutcVIZFm1DiZFIP/w2awnkQHkHRriSE5xrku
         NEfLzj7NrD+hUPAJMb9DTA/G/vMdhOSL2mGzz5UsT9s2Sdb+wpLw1Cwiwv32PGMXO5o4
         AKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851637; x=1774456437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx2bMmg0TFOhekmjlMiH/uxb0wN03CxoN0qCye5m4u0=;
        b=sQ4FoQAHSsIEu4GFzvhilLYBlmCEIa+5huJVQRorXt3dmuyyuLsjVQUlwh2VwDV9M2
         9uu0SI2CKle100RDQDd0G4tqvREHY3dxXQh2kDY2oUb4KxaUMjsg7kkKpbB7asWh7As4
         SPHqic7c564okgZZQtlzy56AStoTz6sM6cMZrl0CNYrUWrdNaAY4xa9FyVYT2hzZa8ou
         sVNPPeeK6pNX3vOpC4WckxKEAcQVinZMwGqKr1Io5m3f9kPiz69K5S5cRiXOyU6aOFdF
         j8K6nCEEvbPzNZYmrL/whNDJWpfdJTVNv4Y3qktPNMddPzsStNmGNEg75wQrCfzADPhq
         jgtw==
X-Gm-Message-State: AOJu0YwhSKNmLzSLGqbKR4p599X38md3GqjEfCm2GGGNc8xFUsTLduWa
	4BBmoNksBYP5FvSpmayRGTD5E+FtGiJ+oj1HOt2WNn5sKk1fAVCmcfOI
X-Gm-Gg: ATEYQzyIFoxgElWyl0RIi2T3hlaHMoovZ/5pc0Q/jkFaMGODctNnyUMGhAeeXCbQmBZ
	mUpA1wQfwIzKqLyYVDYyCLrIuR/uovC77wruJTypkcs32Jo8TmVJG7fyK4gAK3wH0x/+MD0Pwi0
	ur2L95Fy2XYaW6cG/9VMNQOoNJyd3yCMEk3iF2zM/1eHS1SXCaOzzxPpTICc81easitLIE0MxyG
	fOWDc7ji70AGYc+g2ONTlIZpHTzxQj5FA3ET3qz10sR6i5vuqrFwa7FDXzCr+ZqWg7UAp6VsIMc
	VW8HSn0IVUply5zsdjHj2GViuQCWTDk7Qm7qP8ugUTYZzRFLrtNHofqCyccVcukrTQokGVxCFIv
	7vCXVYqAcsTBtQ42UCH5g/xwe6MyDuOtt2+DSyUwf6shj5x++aCTl+wOBzk3bgdFccXny2xHI/I
	8RWZaA/6SLYlPxslNGJGEVASoBXYrim9mGGg==
X-Received: by 2002:a05:6a21:1505:b0:398:8026:4811 with SMTP id adf61e73a8af0-39b99f71c99mr3647999637.35.1773851636506;
        Wed, 18 Mar 2026 09:33:56 -0700 (PDT)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51b3sm3797678b3a.39.2026.03.18.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:33:56 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fnnas.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wjl.linux@gmail.com
Subject: [PATCH] blk-iocost: do not lower busy_level when no IOs are completed
Date: Wed, 18 Mar 2026 16:33:51 +0000
Message-ID: <20260318163351.394528-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14872-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.855];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E0332BFCC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ioc_timer_fn(), iocost evaluates the device latency to adjust the
vrate. However, a logic error exists when no IOs are completed during
a timer period.

In such cases, ioc_lat_stat() returns missed_ppm and rq_wait_pct as zero.
The iocost incorrectly treats these zeros as a sign that the device
is meeting its QoS targets. As a result, busy_level is reset to 0. This
prevents busy_level from reaching the threshold needed to reduce vrate,
making iocost ineffective even when the device is severely overloaded.

This issue was observed while testing iocost on cloud disks. In normal
conditions, a 1MB IO has an average latency of ~6.5ms. After iocost
subtracts the size-based cost (size_nsec), the remaining latency is
~1.5ms. Based on this, rlat and wlat were set to 3000us. However, when
using fio with iodepth=128 to hit the cloud provider's BPS/IOPS limits,
the latency spiked to ~800ms as observed via iostat. Under this pressure,
it was common for some periods to record zero IO completions. This caused
busy_level to stay near zero, and vrate failed to scale down for over
10 seconds at a time.

Fix this by tracking the number of completed IOs (nr_done). The logic to
lower busy_level now requires nr_done > 0. If no IOs were completed, we
maintain the current busy_level because the latency is unknown.

Due to limited resources, I have only tested this patch on Azure
cloud disks. I am unsure of its impact on other types of hardware.
Testing on different storage devices would be highly appreciated.

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 block/blk-iocost.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..8b3bec6ea27e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1596,7 +1596,8 @@ static enum hrtimer_restart iocg_waitq_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p)
+static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p,
+			 u32 *nr_done)
 {
 	u32 nr_met[2] = { };
 	u32 nr_missed[2] = { };
@@ -1633,6 +1634,8 @@ static void ioc_lat_stat(struct ioc *ioc, u32 *missed_ppm_ar, u32 *rq_wait_pct_p
 
 	*rq_wait_pct_p = div64_u64(rq_wait_ns * 100,
 				   ioc->period_us * NSEC_PER_USEC);
+
+	*nr_done = nr_met[READ] + nr_met[WRITE] + nr_missed[READ] + nr_missed[WRITE];
 }
 
 /* was iocg idle this period? */
@@ -2250,12 +2253,12 @@ static void ioc_timer_fn(struct timer_list *timer)
 	u64 usage_us_sum = 0;
 	u32 ppm_rthr;
 	u32 ppm_wthr;
-	u32 missed_ppm[2], rq_wait_pct;
+	u32 missed_ppm[2], rq_wait_pct, nr_done;
 	u64 period_vtime;
 	int prev_busy_level;
 
 	/* how were the latencies during the period? */
-	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
+	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct, &nr_done);
 
 	/* take care of active iocgs */
 	spin_lock_irq(&ioc->lock);
@@ -2403,7 +2406,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 		/* clearly missing QoS targets, slow down vrate */
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
-	} else if (rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
+	} else if (nr_done &&
+		   rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[READ] <= ppm_rthr * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[WRITE] <= ppm_wthr * UNBUSY_THR_PCT / 100) {
 		/* QoS targets are being met with >25% margin */
@@ -2429,7 +2433,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			 */
 			ioc->busy_level = 0;
 		}
-	} else {
+	} else if (nr_done) {
 		/* inside the hysterisis margin, we're good */
 		ioc->busy_level = 0;
 	}
-- 
2.53.0


