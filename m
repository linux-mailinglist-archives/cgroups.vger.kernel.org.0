Return-Path: <cgroups+bounces-8935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA34B16505
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DAD18C35B9
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143E2E06C3;
	Wed, 30 Jul 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYKOYFnm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEC2E03F2;
	Wed, 30 Jul 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894123; cv=none; b=ToU6jkg66zGvDeni6AWbhqxC+zbY83PXp/R1SaYwnl3xk72aMcikNWdOqJrKHpXA/LizlyZ0PrckjDZo2cKVzKmjOu5DT/+avkN4zX3Ze+WsbJ3hHt3HVmOGPi4J8+RSh2xmhUiP3R4Ecr7KqU9j3dEYgUm54cRy8nGfpth+d/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894123; c=relaxed/simple;
	bh=S3ZLhAQ0/4bbvyp1kVylg7m+jh0nJI3cnvrFEpF3/+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAlWuDw0vpawQtP8kRM7moeIPzE+H21ZC1EtCmTEjDfxiicrdyqtNm5aWCpVvcxyIopOtv+60DtaLa5in5lnWphKDJRZ1RtFfeBUJ+Dd2pvJFyIH20qY0nABPUR4HfAeA67i5dmBeSae9yUjsA9r6Qj8PwN1GBMzyFezR+SixuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYKOYFnm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso83545a91.2;
        Wed, 30 Jul 2025 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894121; x=1754498921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C0s2+ecPdhcpXy61gFU/B2Yg7s+esVSvQ4kT7kltr0=;
        b=DYKOYFnmISvYmGhdmlWA3emF5Bp685u1l7EP8FZ4d4JCFpLcsK+CuhpkTXStfcYrhF
         worzEujNzmmQInc64cwSTaXNKV38qh3kFyIbwX1Ot599Uid1CBCA9uLTMexPzwOImIaj
         AmFEQqm0rg9SUd4uaLyYzo1P1JaYbWX23o5uP0TPe4pKue4hFG8hiIEOxC2KHqntZpeL
         Tj5YbbfdhTZKQm3nBMf5oR48CUGNF7zffkMc/VUCLBYogdM8oMDdoof1S3yHmYKBXM4K
         +keoxYb5+bZrncCrc6QhkjjNwmtCXZF9LQg01P3GbAM/2voBfP83ceUvkIgkYzj7kJ0+
         FHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894121; x=1754498921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4C0s2+ecPdhcpXy61gFU/B2Yg7s+esVSvQ4kT7kltr0=;
        b=DNR3mybLxRvEKIkiNPKQpcPGuYKGxHJILfMfGKwB10moJTgx7tIPh9AQb+aqtAwErV
         TooDJvuTcVHrZm1aWKcIZizLDfhf83KNAnT+nK5tM9XUpnkTx2WG8J5c4kWvey9ZXw9u
         GBBfm0Bl+pFR+4JwWjTPLNExXltpss9Cl5/wDkFXgP0wgM9ZNVERMsl1jQIhbu7o4LQT
         Qlbh1Pck/IOUobbymTHWrI/PBfJcMzFrGOWMK+LISRd5llWImMaIoBgmmXqXkdwniUbo
         zItJS7SMvbAr8NPYKf7fT9oKdMzrCo0s1o82kNLWbZCLtbCoHVuOqGw63d4TH06w/Cq+
         JvGw==
X-Forwarded-Encrypted: i=1; AJvYcCUujtZRqVjuGAO62QtjzQdJ+8Dl+Xa45jZWU2VBZklVWnU7zq363CYoC8Ov/8EgtowUFjfhoj1Z3zfq9blc@vger.kernel.org, AJvYcCWaTmKnEVCjqYkJz6ZLHz1sb9bkcnxM7pyVRP2T9O38cE4fUpU76ddlTNPhy0ZDTfXTqY6Ygvlq@vger.kernel.org, AJvYcCXHyTp543fnpzyvmouS50d2FmsbWLqmX3SPgifsYHkCqdPbjC0qE50Uow1Nts6uRdY8esoPIHElsaC2Nk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRo94SNNRLvCEKfaywndvgwCdTN3wVueHPQirMkxO4IRZDi8ma
	fBKybcBFvfApjm/0mDan6zDdYfYW+2KM+8dJZF1lPOr1F82In3eE0MOL
X-Gm-Gg: ASbGncu+cEM95Eqx/Je+rnGck+6lllOFQKkTu78/nX6DRdoXXV1wbrKXbttFj2VyFsw
	jIa9jBkumOAxykelKv2xCsCXIY+JKOH1y4IybhFt4kC6M4Z276gXXpygOj88uoa9eviuDON5eSI
	80acBEe5F+Zm1prbYcjJ7GFUnf2bRZcJ3KIrj8sO4GMoJM8yFZXbv1XVTnZDIaJC/fY/Gwd+aRY
	Yxu7pFwUJTXtt0529+7ZMwZVSs8iHyopz7tx/LUvJwx5yicf9U+mNE6BjJBauv5X42sN+Q2uQIe
	ULxwXzLBqLh1iEPBRiK+jgDaMcXhzcKBEDpzYi1x+NCZDMSi9RvH9S6UGf8/cbSUDi1wvvVYdm/
	JnJlMEFYE9XIy/k99VupCLOKqmb9He/jEiYpoo/Y/LyXiyw==
X-Google-Smtp-Source: AGHT+IEaHdpL0FC+hX73dpxEAZe9z0rxJqJ0TfDgR1D3+BPqgAC9gTp9YgDHLMoqXwSKqEaUEkDnig==
X-Received: by 2002:a17:90b:1d0d:b0:311:b413:f5e1 with SMTP id 98e67ed59e1d1-31f5ea6a623mr5073033a91.32.1753894120651;
        Wed, 30 Jul 2025 09:48:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63e3bf4dsm2456886a91.36.2025.07.30.09.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:48:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] block/blk-throttle: Remove throtl_slice from struct throtl_data
Date: Wed, 30 Jul 2025 09:48:32 -0700
Message-ID: <20250730164832.1468375-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250730164832.1468375-1-linux@roeck-us.net>
References: <20250730164832.1468375-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

throtl_slice is now a constant. Remove the variable and use the constant
directly where needed.

Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 block/blk-throttle.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 924d09b51b69..7756e6c8338d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -38,8 +38,6 @@ struct throtl_data
 	/* Total Number of queued bios on READ and WRITE lists */
 	unsigned int nr_queued[2];
 
-	unsigned int throtl_slice;
-
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
 };
@@ -446,7 +444,7 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
-	unsigned long max_expire = jiffies + 8 * sq_to_td(sq)->throtl_slice;
+	unsigned long max_expire = jiffies + 8 * DFL_THROTL_SLICE;
 
 	/*
 	 * Since we are adjusting the throttle limit dynamically, the sleep
@@ -514,7 +512,7 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
 	if (time_after(start, tg->slice_start[rw]))
 		tg->slice_start[rw] = start;
 
-	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	tg->slice_end[rw] = jiffies + DFL_THROTL_SLICE;
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice with credit start=%lu end=%lu jiffies=%lu",
 		   rw == READ ? 'R' : 'W', tg->slice_start[rw],
@@ -529,7 +527,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
 		tg->io_disp[rw] = 0;
 	}
 	tg->slice_start[rw] = jiffies;
-	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
+	tg->slice_end[rw] = jiffies + DFL_THROTL_SLICE;
 
 	throtl_log(&tg->service_queue,
 		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
@@ -540,7 +538,7 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
 static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 					unsigned long jiffy_end)
 {
-	tg->slice_end[rw] = roundup(jiffy_end, tg->td->throtl_slice);
+	tg->slice_end[rw] = roundup(jiffy_end, DFL_THROTL_SLICE);
 }
 
 static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
@@ -671,12 +669,12 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * sooner, then we need to reduce slice_end. A high bogus slice_end
 	 * is bad because it does not allow new slice to start.
 	 */
-	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
+	throtl_set_slice_end(tg, rw, jiffies + DFL_THROTL_SLICE);
 
 	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
-				 tg->td->throtl_slice);
+				 DFL_THROTL_SLICE);
 	/* Don't trim slice until at least 2 slices are used */
-	if (time_elapsed < tg->td->throtl_slice * 2)
+	if (time_elapsed < DFL_THROTL_SLICE * 2)
 		return;
 
 	/*
@@ -687,7 +685,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * lower rate than expected. Therefore, other than the above rounddown,
 	 * one extra slice is preserved for deviation.
 	 */
-	time_elapsed -= tg->td->throtl_slice;
+	time_elapsed -= DFL_THROTL_SLICE;
 	bytes_trim = throtl_trim_bps(tg, rw, time_elapsed);
 	io_trim = throtl_trim_iops(tg, rw, time_elapsed);
 	if (!bytes_trim && !io_trim)
@@ -697,7 +695,7 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 
 	throtl_log(&tg->service_queue,
 		   "[%c] trim slice nr=%lu bytes=%lld io=%d start=%lu end=%lu jiffies=%lu",
-		   rw == READ ? 'R' : 'W', time_elapsed / tg->td->throtl_slice,
+		   rw == READ ? 'R' : 'W', time_elapsed / DFL_THROTL_SLICE,
 		   bytes_trim, io_trim, tg->slice_start[rw], tg->slice_end[rw],
 		   jiffies);
 }
@@ -768,7 +766,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, DFL_THROTL_SLICE);
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
 	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
 		return 0;
@@ -794,9 +792,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Slice has just started. Consider one slice interval */
 	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = tg->td->throtl_slice;
+		jiffy_elapsed_rnd = DFL_THROTL_SLICE;
 
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, DFL_THROTL_SLICE);
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
 	/* Need to consider the case of bytes_allowed overflow. */
 	if ((bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
@@ -848,7 +846,7 @@ static void tg_update_slice(struct throtl_grp *tg, bool rw)
 	    sq_queued(&tg->service_queue, rw) == 0)
 		throtl_start_new_slice(tg, rw, true);
 	else
-		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
+		throtl_extend_slice(tg, rw, jiffies + DFL_THROTL_SLICE);
 }
 
 static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio)
@@ -1337,12 +1335,8 @@ static int blk_throtl_init(struct gendisk *disk)
 	if (ret) {
 		q->td = NULL;
 		kfree(td);
-		goto out;
 	}
 
-	td->throtl_slice = DFL_THROTL_SLICE;
-
-out:
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue, memflags);
 
-- 
2.45.2


