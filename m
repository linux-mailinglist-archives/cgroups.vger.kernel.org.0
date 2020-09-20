Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E647271313
	for <lists+cgroups@lfdr.de>; Sun, 20 Sep 2020 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgITJKf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Sep 2020 05:10:35 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37040 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbgITJKf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Sep 2020 05:10:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U9TmHbH_1600593031;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U9TmHbH_1600593031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 17:10:32 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] blk-throttle: Avoid getting the current time if tg->last_finish_time is 0
Date:   Sun, 20 Sep 2020 17:10:19 +0800
Message-Id: <534c289866f74d1587806f7818baac789b49c484.1600592693.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We only update the tg->last_finish_time when the low limitaion is
enabled, so we can move the tg->last_finish_time validation a little
forward to avoid getting the unnecessary current time stamp if the
the low limitation is not enabled.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4007b26..7e72102 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2077,10 +2077,14 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 
 static void blk_throtl_update_idletime(struct throtl_grp *tg)
 {
-	unsigned long now = ktime_get_ns() >> 10;
+	unsigned long now;
 	unsigned long last_finish_time = tg->last_finish_time;
 
-	if (now <= last_finish_time || last_finish_time == 0 ||
+	if (last_finish_time == 0)
+		return;
+
+	now = ktime_get_ns() >> 10;
+	if (now <= last_finish_time ||
 	    last_finish_time == tg->checked_last_finish_time)
 		return;
 
-- 
1.8.3.1

