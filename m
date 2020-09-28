Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6539B27A4ED
	for <lists+cgroups@lfdr.de>; Mon, 28 Sep 2020 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1Amf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Sep 2020 20:42:35 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59998 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgI1Amf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Sep 2020 20:42:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UAF1Lg1_1601253752;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UAF1Lg1_1601253752)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Sep 2020 08:42:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove redundant 'return' statement
Date:   Mon, 28 Sep 2020 08:42:26 +0800
Message-Id: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Remove redundant 'return' statement for 'void' functions.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c    | 2 +-
 block/blk-iolatency.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ef9476f..e38c406 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3343,7 +3343,7 @@ static int __init ioc_init(void)
 
 static void __exit ioc_exit(void)
 {
-	return blkcg_policy_unregister(&blkcg_policy_iocost);
+	blkcg_policy_unregister(&blkcg_policy_iocost);
 }
 
 module_init(ioc_init);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index f90429c..81be009 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1046,7 +1046,7 @@ static int __init iolatency_init(void)
 
 static void __exit iolatency_exit(void)
 {
-	return blkcg_policy_unregister(&blkcg_policy_iolatency);
+	blkcg_policy_unregister(&blkcg_policy_iolatency);
 }
 
 module_init(iolatency_init);
-- 
1.8.3.1

