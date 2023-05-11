Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22E6FE996
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjEKBry (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 21:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEKBrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 21:47:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A15FDF;
        Wed, 10 May 2023 18:47:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QGvsv3BJ5z4f3jJ3;
        Thu, 11 May 2023 09:47:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eo_SVxkrgJdJA--.7260S8;
        Thu, 11 May 2023 09:47:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 4/6] blk-wbt: remove deadcode to handle wbt enable/disable with io inflight
Date:   Thu, 11 May 2023 09:45:07 +0800
Message-Id: <20230511014509.679482-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511014509.679482-1-yukuai1@huaweicloud.com>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eo_SVxkrgJdJA--.7260S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17uFyrCrWUWF4DZF1DWrg_yoW8XF15pr
        W3C3sYkFnFqFn293ZFqr1xXr4ayw4kGryxJFW5CrZxZr1UCr1a9F97ur409a4FvrWrCF4a
        gryIgFyrCa18JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
and never will be used, hence remove such deadcode.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index b1ab4688eb5c..7a9a30da8650 100644
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

