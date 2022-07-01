Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C571B562D28
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiGAHzT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiGAHzO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:55:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061916D56B;
        Fri,  1 Jul 2022 00:55:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LZ6SX2qkYz6R4Y2;
        Fri,  1 Jul 2022 15:35:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWgIpL5igL73AA--.48972S11;
        Fri, 01 Jul 2022 15:36:45 +0800 (CST)
From:   Yu Kuai <yukuai3@huawei.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v6 6/8] blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
Date:   Fri,  1 Jul 2022 15:49:21 +0800
Message-Id: <20220701074923.657426-8-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701074923.657426-1-yukuai3@huawei.com>
References: <20220701074923.657426-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWgIpL5igL73AA--.48972S11
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4xKFy8ZryrGFW3JryrJFb_yoWfCrg_ZF
        yfCr40krn8uwn7Ja4rJF1rur9Ygw4FgFy2gay0kFy7WF15Jwn8Xw13JrWa9wsxZay0kr4f
        Xw1DWr4UAr40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbm8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Jr0_Jr4l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
        8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UuuWdUUUUU=
Sender: yukuai1@huaweicloud.com
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It's a litter weird to call throtl_dequeue_tg() unconditionally in
throtl_select_dispatch(), since it will be called in
tg_update_disptime() again if some bio is still throttled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e690dc1c1cde..ab30efedff4e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1151,13 +1151,13 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		if (time_before(jiffies, tg->disptime))
 			break;
 
-		throtl_dequeue_tg(tg);
-
 		nr_disp += throtl_dispatch_tg(tg);
 
 		sq = &tg->service_queue;
 		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
 			tg_update_disptime(tg);
+		else
+			throtl_dequeue_tg(tg);
 
 		if (nr_disp >= THROTL_QUANTUM)
 			break;
-- 
2.31.1

