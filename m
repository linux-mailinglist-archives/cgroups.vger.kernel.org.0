Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9EFAAD1
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2019 08:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMHVf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Nov 2019 02:21:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45611 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfKMHVf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Nov 2019 02:21:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Thxx-12_1573629692;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Thxx-12_1573629692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 15:21:32 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH] iocost: check active_list of all the ancestors in iocg_activate()
Date:   Wed, 13 Nov 2019 15:21:31 +0800
Message-Id: <1573629691-6619-1-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is a bug that checking the same active_list over and over again
in iocg_activate(). The intention of the code was checking whether all
the ancestors and self have already been activated. So fix it.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/blk-iocost.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a7ed434..e01267f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1057,9 +1057,12 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	atomic64_set(&iocg->active_period, cur_period);
 
 	/* already activated or breaking leaf-only constraint? */
-	for (i = iocg->level; i > 0; i--)
-		if (!list_empty(&iocg->active_list))
+	if (!list_empty(&iocg->active_list))
+		goto succeed_unlock;
+	for (i = iocg->level - 1; i > 0; i--)
+		if (!list_empty(&iocg->ancestors[i]->active_list))
 			goto fail_unlock;
+
 	if (iocg->child_active_sum)
 		goto fail_unlock;
 
@@ -1101,6 +1104,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 		ioc_start_period(ioc, now);
 	}
 
+succeed_unlock:
 	spin_unlock_irq(&ioc->lock);
 	return true;
 
-- 
1.8.3.1

