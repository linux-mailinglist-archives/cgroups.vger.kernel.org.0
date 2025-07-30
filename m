Return-Path: <cgroups+bounces-8934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DB9B16503
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A75649FA
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD642DFA38;
	Wed, 30 Jul 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO9Qgwz3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14592E3711;
	Wed, 30 Jul 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894120; cv=none; b=eLH2bECcSZxwLfKyDHDqBUXwOL1JNbLZhnmbUnPZoD5mmxqOlo7BRNW5d9YsC2F0vYLwXOrKrQqFFM8j0v3yNxJNafNHe7zNq4wwhWe+zkVg4cfgpf6GTf6wFeVe5PsNdu/SzH25gi/DeDE/D84H9QmMEyiXIYWl7b+UOeqwXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894120; c=relaxed/simple;
	bh=kgb8cK83STwGirlzdc9wh2BbiZuGIEutknP669/lYQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juStAkiMamqR+2If/6lKI33pvExBARtjca4JaQZR9EFRCuvvuSnRxMvEFfi/SljOuBH9oEjH7fV4nhqgvbXwdRor1mhhIEwFjPHkJxDQfbY10IB7Uso4vyosceeVjnODOhZb+mRrtfvXvGbL8cMq90fEsmXED+3EzZYTG2pey/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO9Qgwz3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso11792a91.3;
        Wed, 30 Jul 2025 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894118; x=1754498918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COtva7AgAsmvuDyZKfou3WP5bEWSxJoD7wNkuQvVslA=;
        b=OO9Qgwz3pu8CxE9AVft4mpaq3fsuYnyH1jHNc4zlZ1H7MjUHcvrcn50q6/BfeDx0Ae
         Xo73m/c8gXZLX0vaYztbLGNVFlnZcPVOvkkGcFjTm/2I8Kv5YW8yTHdjaYExWDonk9cO
         zgqSmVUKexegG0arvXJje2PBGFn17UgyUfx94fWcb27fG3uNmmUbfG6fBhl7UGIq0ZZz
         g2+7nFv4oHLf0tt6tEdidtpQFwwGDztDVGhBrF23fKtR+metHMlPj76DgYQdcDi/fkPx
         G963BBPDpWauM5QxszA8aXUgsm7OAeppNzavq2oUFxo2F1c9rrMvHO8KkUC6KpsRTxJQ
         CTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894118; x=1754498918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COtva7AgAsmvuDyZKfou3WP5bEWSxJoD7wNkuQvVslA=;
        b=e+JYGvBLrI8MJFK0VEBqdjF8Axa9sevmM66F35wEV/pp4YFcgHx7zTFsaYJhXx+7w/
         RKvplwHnGWw4Krmmf5sCZmm6/1K9jm38++GbWmI2xqU7Eyv93H/AtiRFQH0wsxZOuiFD
         03kbtEZmmewZN8iQ2omRzFv3ED9T+hEBFO5hzUASYeSuJm1sE4p7Cej3NbIfuvGVMp37
         c4ror6UBb1Y/X8SM4Hlbq41km4zwJ84Sxh9rofNtL7M2O4SSwyBgolirDp8vEqdtB9o1
         r79vIRdUbcWjI/O+/XboFEaAMi05Gqr9xeGl+eAK1H5GYwJKMZ2RDTsyDUNYB7yYUz/w
         BAVg==
X-Forwarded-Encrypted: i=1; AJvYcCUsAvmLEIg2XgxSHQdi3XLwUiNcYhKyoEHrpOYzZ05yROxlgGeYeD5Q32WLbxNx+vpT4cnbJdE5@vger.kernel.org, AJvYcCV/b+j/NBquFrK2wZHhtTHwLayXNrieILTqVyijN0vKXAXWKUZ9+lglSWFEgxFtl6aw0vCzXvFrgKI6tf5d@vger.kernel.org, AJvYcCVtbrdCnRvknfP7LdaxyGPXWSlpHT/eSt/mEvKnyqW0rZdoVIl8mxkxQjBPoLfje/fCh2fo/IH5iJmLt8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGNyT449/G57UnuxmAEqegcu5x26ErjJOzTM3zGRYPCVtbiqX
	2yuGZaRNs1i5Ksuh+oxFNx7AWw/EO5xYAFlrv7bu4zgsqRc+0Fbg6yvH8VSc0w==
X-Gm-Gg: ASbGncu3vO2yPEU5ki4wpWddFP+8LLPfocVsVQ/LOIqIbSD9DtizGbIs0QG1PWjOJh9
	5DbZXpSM7A7mwzC++NQZtSVVrvZvuTg8BP1odBSMlscD+NsPn1INnEHltMLiuFWPGzOI676vtV4
	oO4SMklNAWesp+MbhplYRli0wt4DiqjkdCy5JlWnNKZy0xrqIxyrwTUWvgMH1PxP4FrrLSW3rFt
	ngHqXoj6hh74DQdbl0yF8NABgJ4xMbA/MPnAZplXaA0XfmvMHLZbtM5Z1HnYxZN0Ezzvfmej/ID
	e/Jj44XxfIitKkLHxLBroKJWcGUZsKiEl3PReKi0ICdSo5MHw0wtlaCjwpt5LSX2MLNYRr6HSeD
	6JOuChvlS9peBy1n+Ojn0FoSK7eYKHGknMmA=
X-Google-Smtp-Source: AGHT+IFXmiA9PJ38oSVKdH01dSTBbo9cUE4Q++w5DkrsBBEnrP9RXVx2WxM9VsafN7Kode9BjK4RLA==
X-Received: by 2002:a17:90a:e7c1:b0:31f:20a:b549 with SMTP id 98e67ed59e1d1-31f5dd8ce0fmr5659301a91.7.1753894118040;
        Wed, 30 Jul 2025 09:48:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f310261d6sm2362558a91.4.2025.07.30.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:48:37 -0700 (PDT)
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
Subject: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
Date: Wed, 30 Jul 2025 09:48:31 -0700
Message-ID: <20250730164832.1468375-2-linux@roeck-us.net>
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

After the removal of CONFIG_BLK_DEV_THROTTLING_LOW, it is no longer
necessary to enable block accounting, so remove the call to
blk_stat_enable_accounting(). With that, the track_bio_latency variable
is no longer used and can be deleted from struct throtl_data. Also,
including blk-stat.h is no longer necessary.

While at it, also remove MAX_THROTL_SLICE since it is not used anymore.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 block/blk-throttle.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 397b6a410f9e..924d09b51b69 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -12,7 +12,6 @@
 #include <linux/blktrace_api.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
-#include "blk-stat.h"
 #include "blk-throttle.h"
 
 /* Max dispatch from a group in 1 round */
@@ -22,9 +21,7 @@
 #define THROTL_QUANTUM 32
 
 /* Throttling is performed over a slice and after that slice is renewed */
-#define DFL_THROTL_SLICE_HD (HZ / 10)
-#define DFL_THROTL_SLICE_SSD (HZ / 50)
-#define MAX_THROTL_SLICE (HZ)
+#define DFL_THROTL_SLICE (HZ / 10)
 
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
@@ -45,8 +42,6 @@ struct throtl_data
 
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
-
-	bool track_bio_latency;
 };
 
 static void throtl_pending_timer_fn(struct timer_list *t);
@@ -1345,13 +1340,7 @@ static int blk_throtl_init(struct gendisk *disk)
 		goto out;
 	}
 
-	if (blk_queue_nonrot(q))
-		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
-		td->throtl_slice = DFL_THROTL_SLICE_HD;
-	td->track_bio_latency = !queue_is_mq(q);
-	if (!td->track_bio_latency)
-		blk_stat_enable_accounting(q);
+	td->throtl_slice = DFL_THROTL_SLICE;
 
 out:
 	blk_mq_unquiesce_queue(disk->queue);
-- 
2.45.2


