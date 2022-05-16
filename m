Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAC527B64
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 03:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiEPBay (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 May 2022 21:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiEPBay (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 May 2022 21:30:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322456421;
        Sun, 15 May 2022 18:30:50 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L1hVy2RBQz1JCFc;
        Mon, 16 May 2022 09:29:30 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 09:30:48 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>
Subject: [PATCH -next] block: fix io hung of setting throttle limit frequently
Date:   Mon, 16 May 2022 09:44:29 +0800
Message-ID: <20220516014429.33723-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Our test find a io hung problem which could be simplified:
setting throttle iops/bps limit to small, and to issue a big
bio. if the io is limited to 10s, just wait 1s, continue to
set same throttle iops/bps limit again, now, we could see
that the new throttle time become 10s again, like this, if
we distribute limit repeatedly within 10s, this io will always
in throttle queue.

when the throttle limit iops/bps is set to io. tg_conf_updated
will be called, it will start a new slice and update a new
dispatch time to pending timer which lead to wait again.

Because of commit 9f5ede3c01f9 ("block: throttle split bio in
case of iops limit"), the io will work fine if limited by bps.
which could fix part of the problem, not the root cause.

To fix this problem, adding the judge before update dispatch time.
if the pending timer is alive, we should not to update time.

Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 block/blk-throttle.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 469c483719be..8acb205dfa85 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1321,12 +1321,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	 * that a group's limit are dropped suddenly and we don't want to
 	 * account recently dispatched IO with new low rate.
 	 */
-	throtl_start_new_slice(tg, READ);
-	throtl_start_new_slice(tg, WRITE);
+	if (!timer_pending(&sq->parent_sq->pending_timer)) {
+		throtl_start_new_slice(tg, READ);
+		throtl_start_new_slice(tg, WRITE);
 
-	if (tg->flags & THROTL_TG_PENDING) {
-		tg_update_disptime(tg);
-		throtl_schedule_next_dispatch(sq->parent_sq, true);
+		if (tg->flags & THROTL_TG_PENDING) {
+			tg_update_disptime(tg);
+			throtl_schedule_next_dispatch(sq->parent_sq, true);
+		}
 	}
 }
 
-- 
2.31.1

