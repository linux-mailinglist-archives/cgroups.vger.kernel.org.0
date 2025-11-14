Return-Path: <cgroups+bounces-11980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5FC5FA41
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 00:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394FF3BFF68
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 23:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6DC3112BE;
	Fri, 14 Nov 2025 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gGLgwHAQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568F30FC30
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164493; cv=none; b=qDCljbxSrW5Wbm8K84pOq6jimiubnM2vaUI9jdyl+06BefDXbK8wkR+suxR3YS1HxdIGU+AbvAoCM1cicAX2lRTA4uJab6uWEER02DpIL4T6AAl0A8d/TfIf+2BTX7LFfNLuy63b5NOcmuCJ9wjPzL06nRq3jK32r6pTfjTNDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164493; c=relaxed/simple;
	bh=ZLJRDtmMTSR2hBThTLrxeqF6jTJw2BnwyDiG+k52hmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBxAybK3KF21oNDVDHOLmqfjcCnCCWZ/MKVIeIZ1EJAlDlac7P+1OJbvKfFwSYPQaLT8s3g5Gbi741d8/QZkPz7emHx//4eafpbrhy0xBczxGMa+aQnvAdwJoKlaWvOF02Xb3/1bCwdRBWBvcsDeJOEUbPT3AMjFiiLps+5tCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gGLgwHAQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so1742111a12.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164491; x=1763769291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lAexgWc5Rcvg5lyc1le6j9r+USga7BCC8BjTHR1o00=;
        b=gGLgwHAQIxSenfZSrhHYNYfQlm7im/DNkz8ns7NzzxV7WITPBCDhqJ9o4TOMg8wa0X
         F/hWNq7cHU6ANqqY0CioBRz5S+6ygzZ0EN752UDm9HACZftOEFsUuvn45XOTRfXdfY+6
         Fo663sT5GAqV6rD++hgkK3rMKxi1cVDCJLdVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164491; x=1763769291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lAexgWc5Rcvg5lyc1le6j9r+USga7BCC8BjTHR1o00=;
        b=TySOBeBYxC9R4bYg7wgPAKld2ToRIXH7uXqCYRPa+NjRa6LAAtNL7vA3/2IeB1TkVT
         24N1aUV4qH9fZmK/iQilBou/QusGzkSpLWXNeC7+Zk0sN01p/udRGydd0F8qtL/h0Sho
         115a/Abe5PtQH2aV4zc86B3W+opW3Nn2YtmInqQEJJHa1RimlR0SgdchTEIEb2trvQOW
         twv4aeX0RVEkbj48bhhrpEUHAGZ9KRzQG/s4lDQZsl7VvEnznbrZdaQvaN7GSTVe/Woq
         k90kp4AreStwiVUTer0jjnCBmBQrT38E02WeWE8nG3tlRbXv0LGi/zeQpXPInT/lnPqL
         rzOA==
X-Gm-Message-State: AOJu0YxsxB0+FDPBdamM9RNAwD8lZNU2s7MFsS+RMmTpfytoJH679ERm
	jumfbvpnAnIfyJXsl9VsjunPEKWAPSk2ox3d0jN1jVYcPLjGAkNN9KnPLcHqfSIjnA==
X-Gm-Gg: ASbGncs0xRoJIfX5wipu3hwwu27K9eQ6gLQn9AwBN9aIArshGRdrTXMvJ3jTUG5XedL
	3ltvo1Wx8Nxbvauw6qT0Zn6EjE8bzyUAMEBSK5QFE4VR54txDFEfU1uCEuLENIb16lH5q7OzbJw
	BaJEu8MheHcRpLrRjHV5C2MZwKmwNlP1tyK5DZLtEzLfaAQ1XHWshjQJl4Ug3UR60TZVo2dlsn9
	hblkZ6W8THUUXciIV41hQyPKKdT3UScH7f53qql2ItdXVyAHG6Nn8C1wrx+Zng0zZwqLuOuKfxN
	9pAJdL3JcV/JdDe5fNmh4Vabp/mo6rnL+AJ7muSjF7LK5lLRe2a+WhJDpv0gLVeEy+GkRXvh/aH
	F7CP0Bu8m20nuf2x9rcsXhfgOB/1/bFbTUpjMZJIguTdEzfqHqdwZnWoiwAvahL8q+W1N/N1pX3
	fcUAy/Fcrzx/cWbIqCWQjS0tLjWPD5IxvMfMWNdhX12chvCE3WW0TW8liu/PTcDRZpQheM2S+3m
	epUeJGWSEOQ/+kDCT9wH+x8J9ltz2c=
X-Google-Smtp-Source: AGHT+IENm05lp2n5p9aaZwPR6AbyHzdYiijOCfRa1baT1RHuX94T4U1gtpighni0ZWGkTrpfmPN3Aw==
X-Received: by 2002:a05:7300:bc86:b0:2a4:3594:72d4 with SMTP id 5a478bee46e88-2a4ab88e643mr1939285eec.3.1763164491131;
        Fri, 14 Nov 2025 15:54:51 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:50 -0800 (PST)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Yu Kuai <yukuai@kernel.org>,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v2 3/3] block/blk-throttle: Remove throtl_slice from struct throtl_data
Date: Fri, 14 Nov 2025 15:54:34 -0800
Message-ID: <20251114235434.2168072-4-khazhy@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114235434.2168072-1-khazhy@google.com>
References: <20251114235434.2168072-1-khazhy@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

throtl_slice is now a constant. Remove the variable and use the constant
directly where needed.

Cc: Yu Kuai <yukuai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 041bcf7b2c7c..97188a795848 100644
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
@@ -1333,12 +1331,8 @@ static int blk_throtl_init(struct gendisk *disk)
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
2.52.0.rc1.455.g30608eb744-goog


