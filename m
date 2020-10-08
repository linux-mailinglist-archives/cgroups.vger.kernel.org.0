Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8D286D54
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgJHDwv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:52:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58628 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbgJHDwu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:52:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGPAZa_1602129158;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGPAZa_1602129158)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] blk-throttle: Remove a meaningless parameter for throtl_downgrade_state()
Date:   Thu,  8 Oct 2020 11:52:22 +0800
Message-Id: <ea3aa9bc31fe1760b9876f5f0fa632ce4d0c1d95.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The throtl_downgrade_state() is always used to change to LIMIT_LOW
limitation, thus remove the latter meaningless parameter which
indicates the limitation index.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 36ba61c..4007b26 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1970,7 +1970,7 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	queue_work(kthrotld_workqueue, &td->dispatch_work);
 }
 
-static void throtl_downgrade_state(struct throtl_data *td, int new)
+static void throtl_downgrade_state(struct throtl_data *td)
 {
 	td->scale /= 2;
 
@@ -1980,7 +1980,7 @@ static void throtl_downgrade_state(struct throtl_data *td, int new)
 		return;
 	}
 
-	td->limit_index = new;
+	td->limit_index = LIMIT_LOW;
 	td->low_downgrade_time = jiffies;
 }
 
@@ -2067,7 +2067,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 	 * cgroups
 	 */
 	if (throtl_hierarchy_can_downgrade(tg))
-		throtl_downgrade_state(tg->td, LIMIT_LOW);
+		throtl_downgrade_state(tg->td);
 
 	tg->last_bytes_disp[READ] = 0;
 	tg->last_bytes_disp[WRITE] = 0;
-- 
1.8.3.1

