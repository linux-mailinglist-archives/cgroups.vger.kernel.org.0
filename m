Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07D713155
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjE0BKV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE0BKT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 21:10:19 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C27189;
        Fri, 26 May 2023 18:10:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QSkH86Q3Mz4f3s5f;
        Sat, 27 May 2023 09:10:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J0WHFkNZwtKQ--.29147S6;
        Sat, 27 May 2023 09:10:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 2/5] blk-wbt: remove dead code to handle wbt enable/disable with io inflight
Date:   Sat, 27 May 2023 09:06:41 +0800
Message-Id: <20230527010644.647900-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527010644.647900-1-yukuai1@huaweicloud.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J0WHFkNZwtKQ--.29147S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17uFyrCrWUWF4DuFW3Wrg_yoW8Xw15pr
        W3C34qkFsFqFn29anFqr4xXrWayw4kGryxGFW5CrZxZr1UCr1a9F97Wr109a4FvrWFkanI
        gr1I9FyrCF4rJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

enable or disable wbt is always called with queue freezed, so that wbt
can never be enabled or disabled while io is still inflight, and this
behaviour should always hold to avoid io hang(There have been reported
several times).

Therefor, the code to handle wbt enable/diskble with io inflight is not
and never will be used, hence remove such dead code.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-wbt.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9ec2a2f1eda3..cb464c572840 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -200,15 +200,6 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
 
 	inflight = atomic_dec_return(&rqw->inflight);
 
-	/*
-	 * wbt got disabled with IO in flight. Wake up any potential
-	 * waiters, we don't have to do more than that.
-	 */
-	if (unlikely(!rwb_enabled(rwb))) {
-		rwb_wake_all(rwb);
-		return;
-	}
-
 	/*
 	 * For discards, our limit is always the background. For writes, if
 	 * the device does write back caching, drop further down before we
@@ -545,13 +536,6 @@ static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
 {
 	unsigned int limit;
 
-	/*
-	 * If we got disabled, just return UINT_MAX. This ensures that
-	 * we'll properly inc a new IO, and dec+wakeup at the end.
-	 */
-	if (!rwb_enabled(rwb))
-		return UINT_MAX;
-
 	if ((opf & REQ_OP_MASK) == REQ_OP_DISCARD)
 		return rwb->wb_background;
 
-- 
2.39.2

