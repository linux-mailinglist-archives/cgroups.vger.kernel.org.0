Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9363B85D
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiK2DB4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiK2DBy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509845097;
        Mon, 28 Nov 2022 19:01:54 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLnCt1XVRz15MpD;
        Tue, 29 Nov 2022 11:01:14 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:51 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 03/10] blk-throttle: ignore cgroup without io queued in blk_throtl_cancel_bios
Date:   Tue, 29 Nov 2022 11:01:40 +0800
Message-ID: <20221129030147.27400-4-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221129030147.27400-1-shikemeng@huawei.com>
References: <20221129030147.27400-1-shikemeng@huawei.com>
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d516a37e82fb..ee7dc1a0adfd 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1738,7 +1738,18 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 		 * Set the flag to make sure throtl_pending_timer_fn() won't
 		 * stop until all throttled bios are dispatched.
 		 */
-		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
+		tg->flags |= THROTL_TG_CANCELING;
+
+		/*
+		 * Do not dispatch cgroup without THROTL_TG_PENDING or cgroup
+		 * will be inserted to service queue without THROTL_TG_PENDING
+		 * set in tg_update_disptime below. Then IO dispatched from
+		 * child in tg_dispatch_one_bio will trigger double insertion
+		 * and corrupt the tree.
+		 */
+		if (!(tg->flags & THROTL_TG_PENDING))
+			continue;
+
 		/*
 		 * Update disptime after setting the above flag to make sure
 		 * throtl_select_dispatch() won't exit without dispatching.
-- 
2.30.0

