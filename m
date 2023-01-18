Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC06716B0
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjARIz3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 03:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjARIwj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 03:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EB5AA4F;
        Wed, 18 Jan 2023 00:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A148EB81B3E;
        Wed, 18 Jan 2023 08:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2522C433D2;
        Wed, 18 Jan 2023 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674029233;
        bh=jV7i9GOJFI/Ud+m8L/XR9u5kzqRqvbbtkxuVTnegFv0=;
        h=From:To:Cc:Subject:Date:From;
        b=hE9uf9tA9pYO+pI66/xY5O8+jR+zScqB63M3U6aiTPIAe1bwEzMc5i+1ivbvdYs8C
         Y/NoVnKf6GSXY6DmNtXLL4WutHYj2zCjiy9q9zxjgrBaHX44DOd0ym+L63Z0kr54AN
         uChgkqEihIGa9nIoOMWtS/qJCBpC8iEYmTq7BipJKGEUHhnYs1Yw9BERk97XugR8+P
         D8JHi4jthfx/TajyRznKPg8X9J6MV6SzVBWukSRwkeO+TClzAywpoK6izRxeZsVvNV
         O9RzDY6EQnSELfSMmuOsjcagdPrNhauThPFk+Azop9nDovIJ6gZoYMfbc5HQgb+3iz
         i1t2zSYZ5Jw8A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kemeng Shi <shikemeng@huawei.com>,
        Andreas Herrmann <aherrmann@suse.de>,
        Yu Kuai <yukuai3@huawei.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jinke Han <hanjinke.666@bytedance.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-iocost: avoid 64-bit division in ioc_timer_fn
Date:   Wed, 18 Jan 2023 09:07:01 +0100
Message-Id: <20230118080706.3303186-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The behavior of 'enum' types has changed in gcc-13, so now the
UNBUSY_THR_PCT constant is interpreted as a 64-bit number because
it is defined as part of the same enum definition as some other
constants that do not fit within a 32-bit integer. This in turn
leads to some inefficient code on 32-bit architectures as well
as a link error:

arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: block/blk-iocost.o: in function `ioc_timer_fn':
blk-iocost.c:(.text+0x68e8): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: blk-iocost.c:(.text+0x6908): undefined reference to `__aeabi_uldivmod'

Split the enum definition to keep the 64-bit timing constants in
a separate enum type from those constants that can clearly fit
within a smaller type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-iocost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6955605629e4..b691b6bb498f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -258,6 +258,11 @@ enum {
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
 
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
+
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -296,9 +301,6 @@ enum {
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
-	/* switch iff the conditions are met for longer than this */
-	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
-
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer
-- 
2.39.0

