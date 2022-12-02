Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF19C63FD8D
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLBBRW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 20:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLBBRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 20:17:22 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831FBB00F;
        Thu,  1 Dec 2022 17:17:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWAIyvC_1669943834;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VWAIyvC_1669943834)
          by smtp.aliyun-inc.com;
          Fri, 02 Dec 2022 09:17:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tj@kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] blk-cgroup: Fix some kernel-doc comments
Date:   Fri,  2 Dec 2022 09:17:13 +0800
Message-Id: <20221202011713.14834-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
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

