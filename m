Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4806E06F8
	for <lists+cgroups@lfdr.de>; Thu, 13 Apr 2023 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDMG2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Apr 2023 02:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMG2u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Apr 2023 02:28:50 -0400
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E57DB3
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 23:28:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681367321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uuLZUtgeUwzy7HQkKWbC2Y+wAfW1jsm3UvSSwpC9GQ=;
        b=KdB0OD7JaB79oRR+5d+zVaBx/OkQHm1RI0hi4MuiY0fVYA0qanpEgKP47Ya07PQz7534/g
        aGRUTTQBYv29sY1tMk+2zU0xsV6T3eukaU7MRE/bcN8yoQ0O50yRYeqmGlUxm0L9kLz0oN
        tla8TtElBNB6kkQ7rbtyJB2145QiMiA=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     josef@toxicpanda.com, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/2] blk-throttle: only enable blk-stat when BLK_DEV_THROTTLING_LOW
Date:   Thu, 13 Apr 2023 14:28:05 +0800
Message-Id: <20230413062805.2081970-2-chengming.zhou@linux.dev>
In-Reply-To: <20230413062805.2081970-1-chengming.zhou@linux.dev>
References: <20230413062805.2081970-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

blk_throtl_register() will unconditionally enable blk-stat for gendisk
when register, even when we have no BLK_DEV_THROTTLING_LOW config.

Since the kernel always has only BLK_DEV_THROTTLING config and the
BLK_DEV_THROTTLING_LOW config is still in EXPERIMENTAL state, we can
just skip blk-stat when !BLK_DEV_THROTTLING_LOW.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47e9d8be68f3..3c07c9cfa70a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2439,11 +2439,12 @@ void blk_throtl_register(struct gendisk *disk)
 #ifndef CONFIG_BLK_DEV_THROTTLING_LOW
 	/* if no low limit, use previous default */
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
-#endif
 
+#else
 	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
2.39.2

