Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE725F4A1
	for <lists+cgroups@lfdr.de>; Mon,  7 Sep 2020 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIGIKr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Sep 2020 04:10:47 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52513 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbgIGIKh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Sep 2020 04:10:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U87zzCq_1599466229;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U87zzCq_1599466229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Sep 2020 16:10:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] blk-throttle: Use readable READ/WRITE macros
Date:   Mon,  7 Sep 2020 16:10:14 +0800
Message-Id: <1f27cd3119163e97eb1e73e9191836e023a884f7.1599458244.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use readable READ/WRITE macros instead of magic numbers.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2fc6c3e..06e73ed 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1428,8 +1428,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * that a group's limit are dropped suddenly and we don't want to
 	 * account recently dispatched IO with new low rate.
 	 */
-	throtl_start_new_slice(tg, 0);
-	throtl_start_new_slice(tg, 1);
+	throtl_start_new_slice(tg, READ);
+	throtl_start_new_slice(tg, WRITE);
 
 	if (tg->flags & THROTL_TG_PENDING) {
 		tg_update_disptime(tg);
-- 
1.8.3.1

