Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0859CDDE
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 03:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiHWB0q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiHWB0p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 21:26:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A95A2D4;
        Mon, 22 Aug 2022 18:26:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MBWkD6wbszKySj;
        Tue, 23 Aug 2022 09:25:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAHDPnPLARj9WfNAg--.16985S8;
        Tue, 23 Aug 2022 09:26:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 4/4] blk-throttle: cleanup throtl_dequeue_tg()
Date:   Tue, 23 Aug 2022 09:38:10 +0800
Message-Id: <20220823013810.406075-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220823013810.406075-1-yukuai1@huaweicloud.com>
References: <20220823013810.406075-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHDPnPLARj9WfNAg--.16985S8
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1kJr4UtFW7Wr4fXFyUtrb_yoWkuFg_Za
        4xCrWrKF18Gwn7Jr98Aw15uFWYk3yUury2qa1jkFW5GFnxX3WkAay7ZrWY9r47uay5Wry3
        Cw1DGr42yr4akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that throtl_dequeue_tg() is called when the last bio is dispatched,
there is no need to check the flag THROTL_TG_PENDING, since it's ensured
to be set when bio is throttled.

There are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47142a1dd102..e47506a8ef47 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -570,14 +570,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
 
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
-	if (tg->flags & THROTL_TG_PENDING) {
-		struct throtl_service_queue *parent_sq =
-			tg->service_queue.parent_sq;
+	struct throtl_service_queue *parent_sq = tg->service_queue.parent_sq;
 
-		throtl_rb_erase(&tg->rb_node, parent_sq);
-		--parent_sq->nr_pending;
-		tg->flags &= ~THROTL_TG_PENDING;
-	}
+	throtl_rb_erase(&tg->rb_node, parent_sq);
+	--parent_sq->nr_pending;
+	tg->flags &= ~THROTL_TG_PENDING;
 }
 
 /* Call with queue lock held */
-- 
2.31.1

