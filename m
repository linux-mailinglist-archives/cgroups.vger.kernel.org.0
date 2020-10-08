Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5E286D59
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgJHDw6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:52:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54120 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728307AbgJHDwo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:52:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGF.4M_1602129159;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGF.4M_1602129159)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:39 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] blk-throttle: Fix IO hang for a corner case
Date:   Thu,  8 Oct 2020 11:52:25 +0800
Message-Id: <ad720c13c15d7f6c1faa7ca1391c9f4420905f23.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It can not scale up in throtl_adjusted_limit() if we set bps or iops is
1, which will cause IO hang when enable low limit. Thus we should treat
1 as a illegal value to avoid this issue.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b0d8f7c..0649bce 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1687,13 +1687,13 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -EINVAL;
-		if (!strcmp(tok, "rbps"))
+		if (!strcmp(tok, "rbps") && val > 1)
 			v[0] = val;
-		else if (!strcmp(tok, "wbps"))
+		else if (!strcmp(tok, "wbps") && val > 1)
 			v[1] = val;
-		else if (!strcmp(tok, "riops"))
+		else if (!strcmp(tok, "riops") && val > 1)
 			v[2] = min_t(u64, val, UINT_MAX);
-		else if (!strcmp(tok, "wiops"))
+		else if (!strcmp(tok, "wiops") && val > 1)
 			v[3] = min_t(u64, val, UINT_MAX);
 		else if (off == LIMIT_LOW && !strcmp(tok, "idle"))
 			idle_time = val;
-- 
1.8.3.1

