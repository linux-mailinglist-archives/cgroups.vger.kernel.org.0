Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6B63FE3D
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 03:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiLBCmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 21:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLBCmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 21:42:55 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5189D15BA;
        Thu,  1 Dec 2022 18:42:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWAkoq4_1669948970;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VWAkoq4_1669948970)
          by smtp.aliyun-inc.com;
          Fri, 02 Dec 2022 10:42:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] blk-cgroup: Fix some kernel-doc comments
Date:   Fri,  2 Dec 2022 10:42:49 +0800
Message-Id: <20221202024249.12884-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make the description of @gendisk to @disk in blkcg_schedule_throttle()
to clear the below warnings:

block/blk-cgroup.c:1850: warning: Function parameter or member 'disk' not described in 'blkcg_schedule_throttle'
block/blk-cgroup.c:1850: warning: Excess function parameter 'gendisk' description in 'blkcg_schedule_throttle'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3338
Fixes: de185b56e8a6 ("blk-cgroup: pass a gendisk to blkcg_schedule_throttle")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

change in v2:
--According to Jens's suggestion, add a fixes line.

 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1bb939d3b793..77f44472b41e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1831,7 +1831,7 @@ void blkcg_maybe_throttle_current(void)
 
 /**
  * blkcg_schedule_throttle - this task needs to check for throttling
- * @gendisk: disk to throttle
+ * @disk: disk to throttle
  * @use_memdelay: do we charge this to memory delay for PSI
  *
  * This is called by the IO controller when we know there's delay accumulated
-- 
2.20.1.7.g153144c

