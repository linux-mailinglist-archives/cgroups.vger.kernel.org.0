Return-Path: <cgroups+bounces-11979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47653C5FA3E
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 00:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EA4420F82
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132930FF37;
	Fri, 14 Nov 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DS9f4io7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88A30F543
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164492; cv=none; b=QpPNQ9jQ3ZTC0k6f6r5OBaO0Xw17xdX8SpBmCu1wtj/H9wiifLQQeZGAznBYkuIpP6yT66sH75FedpLa1GUD8W6wDq4ylLyb2IXv+tHSGnZ0V6ASyXa+YRJiYpwx1G8LhAHOhZjq0sLR76fh2jIPaTQWQKJEMB3VSY6MwGY4f08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164492; c=relaxed/simple;
	bh=3ISK3vmEmXYxkx6L/TlERdD5sr35Uw+sM1ovYwgxP0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQAQLacAKcdLuJUi9NYumbrK65mWIGTOQPUF9mnnRETA6tOnYNBnAfV5hgHU/x2v75NLNvtC8k2bftlUOnRygt1XGWbh8OD9sBLSW6fGuIHdoAi/I6hanI/v6lLuODRf8KqwkKBhaCO4SHs98l6emgiADFlqFyJ3ZnRyYBtd8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DS9f4io7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so2657540a12.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763164490; x=1763769290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFdmZz4q1tuXgiwvVFEfWPnDBWXiUNf2fULwgRSPSqE=;
        b=DS9f4io790OsIQQ1ObW/CGEvjd4Xxt1lt1eK4HNFtVr5b14K75C/8nS5J30rc6wyPD
         0+X0bU9Wl7BC37ENdbc1ABMIu6bI7vHuJ2XrwdAzMcUfGKJeGhBx9RcGWeKEyIIcrFQw
         9nhrtp5Lt6wdQChMsh6Ayf7vBmZzle0QYDOEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763164490; x=1763769290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFdmZz4q1tuXgiwvVFEfWPnDBWXiUNf2fULwgRSPSqE=;
        b=EfHrb5nKcpkmgCFR7I8V64917iZvMkZwkp7xrF+jXqHKgwoDW0c/q/3kPubBPGkWfZ
         fzWvJvi//SzJWvPa1CCrLYXew+ySYBimfp+yAMKJEHvEVFXfZRoyF5X/x2n1780qd64H
         XIWb2Mr+QJIvw/MotKSA5/BbePDn8T+Lf0U52sIdTn3SVj9jmkaedvyXmvHCGXW226XQ
         g3H6KC/Hn9AprwY2BiodBGEOAKSiKEdy5ULAjN1Kpqnsqq8r26ZfO8zBaH+RbAAVuFXG
         lvHw4vZ6yJ1/YugBvxRMiDjogGSF70pYukvpRW82Ob3ouwbeQA27eN1VgjAqDnShV9Qn
         SpxQ==
X-Gm-Message-State: AOJu0YzS1iO7VcE1KZGa7ySUXj6Qof+YkI3Gj+s4X7zUQxE6WzXGrLvD
	3EbYXtgP6rcjh7qV8ma+FbwSNJHLOgm+/Elb3/tvXmxNR+awUmxgXDa0+F3gsj55iQ==
X-Gm-Gg: ASbGncsy4hG4/doLd1hLvv3aNAGzSGWSt1nesfW6Ja/ujqisbVl74uDQ/xNObac5CSB
	ZhYmd73KIHZoy/vxY2l55Nop6UoEJCAMJYiB6xjpcoFf/HL1CaRhC2JO1CeFx7ByekVG426lm6U
	RQ7hukwsZFwQ8my26Az155DGviFv4X4gatOFPQ5yVqBeYPUIqC7dmR/sNZRscetXQXdGrV4d4Lx
	MwuXsyz3ivsw2AKeR/hULY//Ah0MmP5/6oFovitAEVkD5anKfRzAGENdJXfSNYbWhyQbUZY+Upa
	cjjKJ6p8YC8mxI5w8vXjNKlzC0szosKzZoDNXhKR+/MfjgwIcCKLXLmDr0LAvKgU3Y1wsO03/BN
	6qEmp8ojMQAvVfqT4JH7oFF+1kOWpR6v2afK/ugEgWWrO87VZ53IBuztaQm7YBrQQJYRQtac66R
	2911LNrvoQZOacQRTJzaWWGUYAu8SqlNd9ZNUMqWIzGRndn35OYMDfZrR+VDepbOE9MtV8nNvNa
	x1Sacixlk2XTT29tr/n
X-Google-Smtp-Source: AGHT+IHedTwgJN/jlP+lN345ODfHCK52a3qWBMDHclzPe3MK3s/H5bCWbd4lV8zbwLxOjyRjOUEI3A==
X-Received: by 2002:a05:7300:f68b:b0:2a4:3593:ccc6 with SMTP id 5a478bee46e88-2a4ab443a21mr1704630eec.13.1763164489828;
        Fri, 14 Nov 2025 15:54:49 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:bb76:6725:868a:78e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm14114818eec.6.2025.11.14.15.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:54:49 -0800 (PST)
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
Subject: [PATCH v2 2/3] block/blk-throttle: drop unneeded blk_stat_enable_accounting
Date: Fri, 14 Nov 2025 15:54:33 -0800
Message-ID: <20251114235434.2168072-3-khazhy@google.com>
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

After the removal of CONFIG_BLK_DEV_THROTTLING_LOW, it is no longer
necessary to enable block accounting, so remove the call to
blk_stat_enable_accounting(). With that, the track_bio_latency variable
is no longer used and can be deleted from struct throtl_data. Also,
including blk-stat.h is no longer necessary.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Cc: Yu Kuai <yukuai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-throttle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c19d052a8f2f..041bcf7b2c7c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -12,7 +12,6 @@
 #include <linux/blktrace_api.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
-#include "blk-stat.h"
 #include "blk-throttle.h"
 
 /* Max dispatch from a group in 1 round */
@@ -43,8 +42,6 @@ struct throtl_data
 
 	/* Work for dispatching throttled bios */
 	struct work_struct dispatch_work;
-
-	bool track_bio_latency;
 };
 
 static void throtl_pending_timer_fn(struct timer_list *t);
@@ -1340,9 +1337,6 @@ static int blk_throtl_init(struct gendisk *disk)
 	}
 
 	td->throtl_slice = DFL_THROTL_SLICE;
-	td->track_bio_latency = !queue_is_mq(q);
-	if (!td->track_bio_latency)
-		blk_stat_enable_accounting(q);
 
 out:
 	blk_mq_unquiesce_queue(disk->queue);
-- 
2.52.0.rc1.455.g30608eb744-goog


