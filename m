Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342875AE43
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGTMXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTMXS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 08:23:18 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 05:23:16 PDT
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [IPv6:2001:41d0:203:375::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6AA2
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 05:23:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689855359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1qUoKI3SbOAj4JugO0eFEKpo/XtZkaAZd4jHbDGRCXI=;
        b=UYRVGSJeMWgVT/Cmj35t2ZweiX0f74MUBaOSw4MLtDmMy3IiuQrHv8RU4qRm/+sTXZG3zj
        +eK1+VPGThdCpfSCGWbopKgw5Dw3dyzfnI+h4Dk0lnIiYvGH6rNedI6u3cchFohjzDfaRp
        UtcGfRKuKFeW1oGmtQWsxdDyRcpHit4=
From:   chengming.zhou@linux.dev
To:     tj@kernel.org, josef@toxicpanda.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-iocost: skip empty flush bio in iocost
Date:   Thu, 20 Jul 2023 20:14:41 +0800
Message-ID: <20230720121441.1408522-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The flush bio may have data, may have no data (empty flush), we couldn't
calculate cost for empty flush bio. So we'd better just skip it for now.

Another side effect is that empty flush bio's bio_end_sector() is 0, cause
iocg->cursor reset to 0, may break the cost calculation of other bios.

This isn't good enough, since flush bio still consume the device bandwidth,
but flush request is special, can be merged randomly in the flush state
machine, we don't know how to calculate cost for it for now.

Its completion time also has flaws, which may include the pre-flush or
post-flush completion time, but I don't know if we need to fix that and
how to fix it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6084a9519883..e735b3e9997c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2516,6 +2516,10 @@ static void calc_vtime_cost_builtin(struct bio *bio, struct ioc_gq *iocg,
 	u64 seek_pages = 0;
 	u64 cost = 0;
 
+	/* Can't calculate cost for empty bio */
+	if (!bio->bi_iter.bi_size)
+		goto out;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		coef_seqio	= ioc->params.lcoefs[LCOEF_RSEQIO];
-- 
2.41.0

