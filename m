Return-Path: <cgroups+bounces-11978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7592C5FA20
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 00:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B92AB4E2557
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 23:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BE30F7ED;
	Fri, 14 Nov 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HXRR9iCD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728930DD3D
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164491; cv=none; b=tWOIP0C/rb+APhPWci6kCGMWPAdtcl4KXm4oXx9+L21DtCoLRPk0EhgLPHtZFtgQjHFtLgFaBZihnOXJGdStfNm2xLnoCQfx2duS0Tu76zYL3Z61VfCRfvsdXVmQ+f6RzjlFnpC6ap8rQp7WO2gUJtGugmRdWKIAIhDKypGYsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164491; c=relaxed/simple;
	bh=eZmo6/5xCexjplSdLKsWrnqHmeMVHTordQIE+X1VxUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d41f8kFkSnElZ7qIy9k+C7XOhSYBPRWob6qg3I1IMzvzDR8xK8E2pev5tNovei/Uab/Y6ezHQBCY7fL9AyUlEbhZf1ee1Zv4yTgU46DbYLqEhS+d3ICTvT0KN48xOqe0XYtgoJBYP1euQlPUKrKkFT1Sc6y1sLwJEafG0ckyRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HXRR9iCD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1418659a12.3
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164489; x=1763769289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4f5r+TGOOPde/WLtRUa45GVIxXbdn1Vo4b55yI0gt4=;
        b=HXRR9iCD4ENjXznIuoGTr8IHj75+6u5IHRhUrtib9y946Xg5VIN5NRPwxxI/fCVPg6
         V/F1L73PrHf/vD83VcnkkpY0FOxSsEUtXYY0ZEsa0Ip6cnFo8aWIugXUEhnqzrZZ6VOX
         yvsICP43bAt7HJqMG9DikG1YDf35gqBpq7Dmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164489; x=1763769289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4f5r+TGOOPde/WLtRUa45GVIxXbdn1Vo4b55yI0gt4=;
        b=cGl6/XPdcCYokWXq7iw1gTjZ//Ft1SVaaAzu2zMlmr62YErPsxb0RMqX+cM+mgklQy
         UElQM5od9YLrYqC8qsYI0QRaBXQjj+05CzHahCYttTqT1sjUoS4RFI5EzMdOzGhpn3Ck
         Vznd3ULLAE+AnxZHOfRi2Ksp00eUATR232Z/bTsJ++KhmHh3AjWpVzqq445DmXgajPVC
         IUQ8Fa9S89XyKiJeCws/1Dh7raCdGBvD3RHCHCh1r3OsqB6Q1r6AWWacM8+YqiXZqeKJ
         FWpYXZMo9XjmOSbFDNxFZRbcqP4UaaEQ/mI+MWX63WYlKjxQBYqhoL1ugiDBfnuLKWJ/
         Ko1Q==
X-Gm-Message-State: AOJu0Yxohyn+WGlw4IzMdt9EjKy5ZdB1W50KN4otgdOjp30vLup1qpCG
	z1gBw/9I7bNG3Fn+yaGGzDEu/j1KNBA4OSpDioHydHzRp2vUnnXkGpYno6XplEzvQw==
X-Gm-Gg: ASbGncu7MB4QxrAUn51OvPhV2G6rfugmSSBe/FyQcXBbhY7McXceQy2MXBBSBa3SMXz
	iggpbM949GMJGHu+BIM6O9Ab4imqCLDeoJgTe5GLBT35Zc8n9xGc7EeK3GndPxOktL9ipkwq2nj
	DgLRq9MYW7M7dPXLSqhB2b0d2NCnmMYzha2HowmhYqbNTBdhQJnzaDLQyaGNTy6/8jBsdAhFX6j
	TvE/bjvMFfp03EaYxg3Qp20LlS6TcICqfKZY8S7qgjbZFxDjeh4O6+NQI+R4yG1OFoY4ovahfUZ
	TsO0HXkLhC6jPLZ6inWwhx6F0nfztnscmNYYtPFq7JiXu+2PfJFsq80e5G2BzLiMFD3lcWdhZVw
	KeGguiWaAnw+C5EW+OTvjBuO5eaUY0jGOCcayaRy6Ksz3ilfQLGSRYpFBIaCK2yjgrdbmaGc3Sq
	7Z2K5ZJKB2Agrujag6yolMkUZqXE7iPe8kblZQcWm8QN9OBNbSVKyxiylU02nWFHpKHG3LRDpiN
	mX3uTDdCw==
X-Google-Smtp-Source: AGHT+IFtwwfARtE+LZgjm4XpePNHmAw5KTc8Gn91NyCPCwHKkcDkm5Smf3lVi3mzi3s6gN/2LN1I7g==
X-Received: by 2002:a05:693c:40dc:b0:2a4:3593:4679 with SMTP id 5a478bee46e88-2a4abd973e6mr2295298eec.21.1763164488752;
        Fri, 14 Nov 2025 15:54:48 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:48 -0800 (PST)
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
Subject: [PATCH v2 1/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Fri, 14 Nov 2025 15:54:32 -0800
Message-ID: <20251114235434.2168072-2-khazhy@google.com>
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

Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
was enabled. Commit bf20ab538c81 ("blk-throttle: remove
CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LOW,
but left the device type specific throttle slices in place. This
effectively changed throttling behavior on systems with SSD which now use
a different and non-configurable slice time compared to non-SSD devices.
Practical impact is that throughput tests with low configured throttle
values (65536 bps) experience less than expected throughput on SSDs,
presumably due to rounding errors associated with the small throttle slice
time used for those devices. The same tests pass when setting the throttle
values to 65536 * 4 = 262144 bps.

The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert to
the original code and re-introduce DFL_THROTL_SLICE to replace both
DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD").

While at it, also remove MAX_THROTL_SLICE since it is not used anymore.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Cc: Yu Kuai <yukuai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2c5b64b1a724..c19d052a8f2f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -22,9 +22,7 @@
 #define THROTL_QUANTUM 32
 
 /* Throttling is performed over a slice and after that slice is renewed */
-#define DFL_THROTL_SLICE_HD (HZ / 10)
-#define DFL_THROTL_SLICE_SSD (HZ / 50)
-#define MAX_THROTL_SLICE (HZ)
+#define DFL_THROTL_SLICE (HZ / 10)
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
@@ -1341,10 +1339,7 @@ static int blk_throtl_init(struct gendisk *disk)
 		goto out;
 	}
 
-	if (blk_queue_nonrot(q))
-		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
-		td->throtl_slice = DFL_THROTL_SLICE_HD;
+	td->throtl_slice = DFL_THROTL_SLICE;
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
-- 
2.52.0.rc1.455.g30608eb744-goog


