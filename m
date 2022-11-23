Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF525634FEE
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiKWGEM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKWGEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:04:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34396F2C08;
        Tue, 22 Nov 2022 22:04:08 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NH9Tt2rc6zJnrH;
        Wed, 23 Nov 2022 14:00:50 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:05 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 03/11] blk-throttle: ignore cgroup without io queued in blk_throtl_cancel_bios
Date:   Wed, 23 Nov 2022 14:03:53 +0800
Message-ID: <20221123060401.20392-4-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221123060401.20392-1-shikemeng@huawei.com>
References: <20221123060401.20392-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ignore cgroup without io queued in blk_throtl_cancel_bios for two
reasons:
1. Save cpu cycle for trying to dispatch cgroup which is no io queued.
2. Avoid non-consistent state that cgroup is inserted to service queue
without THROTL_TG_PENDING set as tg_update_disptime will unconditional
re-insert cgroup to service queue. If we are on the default hierarchy,
IO dispatched from child in tg_dispatch_one_bio will trigger inserting
cgroup to service queue without erase first and ruin the tree.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b33bcf53b36e..acfac916ed99 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1728,7 +1728,12 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		 * Set the flag to make sure throtl_pending_timer_fn() won't
 		 * stop until all throttled bios are dispatched.
 		 */
-		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
+		tg->flags |= THROTL_TG_CANCELING;
+
+		/* No need to dispatch cgroup without io queued */
+		if (!(tg->flags & THROTL_TG_PENDING))
+			continue;
+
 		/*
 		 * Update disptime after setting the above flag to make sure
 		 * throtl_select_dispatch() won't exit without dispatching.
-- 
2.30.0

