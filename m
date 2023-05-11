Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1726FE99E
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 03:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjEKBsA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjEKBry (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 21:47:54 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E165AA;
        Wed, 10 May 2023 18:47:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QGvsv1mCSz4f3lwX;
        Thu, 11 May 2023 09:47:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eo_SVxkrgJdJA--.7260S9;
        Thu, 11 May 2023 09:47:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 5/6] blk-wbt: cleanup rwb_enabled() and wbt_disabled()
Date:   Thu, 11 May 2023 09:45:08 +0800
Message-Id: <20230511014509.679482-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511014509.679482-1-yukuai1@huaweicloud.com>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eo_SVxkrgJdJA--.7260S9
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1UWw43XF1kWryDtr13Arb_yoWDWFgEkw
        18WFn7Gwn5ZrsYyF4Uuw15WFWIkrWDJF18urn3KF9ayr47JF9akw4xXr4rCrW3urWxCFy8
        tFyDZry7Zr4fXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
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

The code is redundant, reuse rwb_enabled() for wbt_disabled().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 7a9a30da8650..7066fc2c1e5d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -146,7 +146,7 @@ enum {
 static inline bool rwb_enabled(struct rq_wb *rwb)
 {
 	return rwb && rwb->enable_state != WBT_STATE_OFF_DEFAULT &&
-		      rwb->wb_normal != 0;
+		      rwb->enable_state != WBT_STATE_OFF_MANUAL;
 }
 
 static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
@@ -494,8 +494,7 @@ bool wbt_disabled(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 
-	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT ||
-	       RQWB(rqos)->enable_state == WBT_STATE_OFF_MANUAL;
+	return !rqos || !rwb_enabled(RQWB(rqos));
 }
 
 u64 wbt_get_min_lat(struct request_queue *q)
-- 
2.39.2

