Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD76F271318
	for <lists+cgroups@lfdr.de>; Sun, 20 Sep 2020 11:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITJOd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Sep 2020 05:14:33 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48733 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgITJOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Sep 2020 05:14:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9TjK9b_1600593271;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9TjK9b_1600593271)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 17:14:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] blk-throttle: Avoid tracking latency if low limit is invalid
Date:   Sun, 20 Sep 2020 17:14:26 +0800
Message-Id: <a244c9973c6fc0081dba4142625840696b386a0f.1600592693.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The IO latency tracking is only for LOW limit, so we should add a
validation to avoid redundant latency tracking if the LOW limit
is not valid.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7e72102..b0d8f7c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2100,7 +2100,7 @@ static void throtl_update_latency_buckets(struct throtl_data *td)
 	unsigned long last_latency[2] = { 0 };
 	unsigned long latency[2];
 
-	if (!blk_queue_nonrot(td->queue))
+	if (!blk_queue_nonrot(td->queue) || !td->limit_valid[LIMIT_LOW])
 		return;
 	if (time_before(jiffies, td->last_calculate_time + HZ))
 		return;
@@ -2338,6 +2338,8 @@ void blk_throtl_bio_endio(struct bio *bio)
 	if (!blkg)
 		return;
 	tg = blkg_to_tg(blkg);
+	if (!tg->td->limit_valid[LIMIT_LOW])
+		return;
 
 	finish_time_ns = ktime_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
-- 
1.8.3.1

