Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6A7BCBA0
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 03:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbjJHBsQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 21:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbjJHBsP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 21:48:15 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E940B92;
        Sat,  7 Oct 2023 18:48:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 1CD25604A13E3;
        Sun,  8 Oct 2023 09:48:06 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
Cc:     Su Hui <suhui@nfschina.com>, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] blk-throttle: silence truncated string warning
Date:   Sun,  8 Oct 2023 09:47:52 +0800
Message-Id: <20231008014751.423133-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

using gcc and w=1, there are some warnings like these:

block/blk-throttle.c:1531:53: error:
‘snprintf’ output may be truncated before the last format character
[-Werror=format-truncation=]
 1531 |    snprintf(idle_time, sizeof(idle_time), " idle=%lu",
      |                                                     ^
block/blk-throttle.c:1531:4: note: ‘snprintf’ output between 8 and 27 bytes
into a destination of size 26
 1531 |    snprintf(idle_time, sizeof(idle_time), " idle=%lu",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1532 |     tg->idletime_threshold_conf);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-throttle.c:1538:15: error:
‘%lu’ directive output may be truncated writing between 1 and 20 bytes
into a region of size 17 [-Werror=format-truncation=]
 1538 |     " latency=%lu", tg->latency_target_conf);
      |               ^~~

"%lu" can up to 21, so string " idle=%lu" can up to 27. But 'idle_time'
only has 26 Bytes. It's same for 'latency_time' whose size should be 30
rather than 26 because string " latency=%lu" can up to 30.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38a881cf97d0..dfc5c0d3d9c1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1489,8 +1489,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
-	char idle_time[26] = "";
-	char latency_time[26] = "";
+	char idle_time[27] = "";
+	char latency_time[30] = "";
 
 	if (!dname)
 		return 0;
-- 
2.30.2

