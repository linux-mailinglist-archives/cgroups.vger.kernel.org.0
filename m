Return-Path: <cgroups+bounces-970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9853381592C
	for <lists+cgroups@lfdr.de>; Sat, 16 Dec 2023 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FDB212FA
	for <lists+cgroups@lfdr.de>; Sat, 16 Dec 2023 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0058721A02;
	Sat, 16 Dec 2023 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dUmPu60U"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240283034C
	for <cgroups@vger.kernel.org>; Sat, 16 Dec 2023 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id EUC8rL1Hz45wtEUC8rBRUA; Sat, 16 Dec 2023 13:55:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702731305;
	bh=Fa9yeiiOVaCIdEktKvlcN06YmNgKcMNBNVzgkivBQlM=;
	h=From:To:Cc:Subject:Date;
	b=dUmPu60UhSREhpVkcpZzDVQ689zSfTU3NlsfqjtfvupSWZEOVLUDCpxKto0CSkdCS
	 5Nnz1O4jZqfqJyS7xA65N7xp1/kmUYljw3x+tt45Q+MXE5cg9EsqdE9dgDSxhtWDXR
	 5ppLEBsLOB+DvYlZOVH7klV4W/NwDXWvYLa0by1VEYun4K9rtAN1nBgZwQPFtY2Y8Q
	 5RExd/d6mlgz104tZhfylYj2bgUpalB5Vc4RRgn1wUZ7H3/1NZYhjrRX5EdgAR2Ejd
	 fw1JpwvUDvlszECy2petjXjIxYPQY4hb9TJES0C/R4AbPDK6PRLg1/a0xsKLhE9R3H
	 X/1OmkPCMQwqA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Dec 2023 13:55:05 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-throttle: Fix some potential string truncation in tg_prfill_limit()
Date: Sat, 16 Dec 2023 13:54:56 +0100
Message-Id: <0461f1d69c84cf5a98ae57012856dace757d319e.1702731206.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiled with W=1, we get:
  block/blk-throttle.c: In function ‘tg_prfill_limit’:
  block/blk-throttle.c:1539:74: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
   1539 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
        |                                                                          ^
  block/blk-throttle.c:1539:25: note: ‘snprintf’ output between 8 and 27 bytes into a destination of size 26
   1539 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1540 |                                 tg->idletime_threshold_conf);
        |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  block/blk-throttle.c:1546:43: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 17 [-Werror=format-truncation=]
   1546 |                                 " latency=%lu", tg->latency_target_conf);
        |                                           ^~~
  block/blk-throttle.c:1546:33: note: directive argument in the range [0, 18446744073709551614]
   1546 |                                 " latency=%lu", tg->latency_target_conf);
        |                                 ^~~~~~~~~~~~~~
  block/blk-throttle.c:1545:25: note: ‘snprintf’ output between 11 and 30 bytes into a destination of size 26
   1545 |                         snprintf(latency_time, sizeof(latency_time),
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1546 |                                 " latency=%lu", tg->latency_target_conf);
        |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to fix it, remove all the intermediate buffers and write directly
into the 'sf' seq_file.

Fixes: ada75b6e5b2a ("blk-throttle: add interface to configure idle time threshold")
Fixes: ec80991d6fc2 ("blk-throttle: add interface for per-cgroup target latency")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 block/blk-throttle.c | 52 +++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..470a8a4ed68e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1494,11 +1494,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
 	const char *dname = blkg_dev_name(pd->blkg);
-	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
-	char idle_time[26] = "";
-	char latency_time[26] = "";
 
 	if (!dname)
 		return 0;
@@ -1520,35 +1517,46 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
 		return 0;
 
+	seq_printf(sf, "%s", dname);
+
+	seq_puts(sf, " rbps=");
 	if (tg->bps_conf[READ][off] != U64_MAX)
-		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
-			tg->bps_conf[READ][off]);
+		seq_printf(sf, "%llu", tg->bps_conf[READ][off]);
+	else
+		seq_puts(sf, "max");
+
+	seq_puts(sf, " wbps=");
 	if (tg->bps_conf[WRITE][off] != U64_MAX)
-		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
-			tg->bps_conf[WRITE][off]);
+		seq_printf(sf, "%llu", tg->bps_conf[WRITE][off]);
+	else
+		seq_puts(sf, "max");
+
+	seq_puts(sf, " riops=");
 	if (tg->iops_conf[READ][off] != UINT_MAX)
-		snprintf(bufs[2], sizeof(bufs[2]), "%u",
-			tg->iops_conf[READ][off]);
+		seq_printf(sf, "%u", tg->iops_conf[READ][off]);
+	else
+		seq_puts(sf, "max");
+
+	seq_puts(sf, " wiops=");
 	if (tg->iops_conf[WRITE][off] != UINT_MAX)
-		snprintf(bufs[3], sizeof(bufs[3]), "%u",
-			tg->iops_conf[WRITE][off]);
+		seq_printf(sf, "%u", tg->iops_conf[WRITE][off]);
+	else
+		seq_puts(sf, "max");
+
 	if (off == LIMIT_LOW) {
-		if (tg->idletime_threshold_conf == ULONG_MAX)
-			strcpy(idle_time, " idle=max");
+		seq_puts(sf, " idle=");
+		if (tg->idletime_threshold_conf != ULONG_MAX)
+			seq_printf(sf, "%lu", tg->idletime_threshold_conf);
 		else
-			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
-				tg->idletime_threshold_conf);
+			seq_puts(sf, "max");
 
-		if (tg->latency_target_conf == ULONG_MAX)
-			strcpy(latency_time, " latency=max");
+		seq_puts(sf, " latency=");
+		if (tg->latency_target_conf != ULONG_MAX)
+			seq_printf(sf, "%lu", tg->latency_target_conf);
 		else
-			snprintf(latency_time, sizeof(latency_time),
-				" latency=%lu", tg->latency_target_conf);
+			seq_puts(sf, "max");
 	}
 
-	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
-		   dname, bufs[0], bufs[1], bufs[2], bufs[3], idle_time,
-		   latency_time);
 	return 0;
 }
 
-- 
2.34.1


