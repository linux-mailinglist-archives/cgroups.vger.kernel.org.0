Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53164F722
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLQCoz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiLQCou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:44:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C570218;
        Fri, 16 Dec 2022 18:44:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYr0X56mRz4f3rDH;
        Sat, 17 Dec 2022 10:44:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9gcLZ1j2O96CQ--.47195S8;
        Sat, 17 Dec 2022 10:44:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 4/4] blk-iocost: guarantee the exit order of iocg
Date:   Sat, 17 Dec 2022 11:05:27 +0800
Message-Id: <20221217030527.1250083-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9gcLZ1j2O96CQ--.47195S8
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1UKFWxArWDZF15JF1DJrb_yoW8ZFy7pF
        13WasIka18XFn7Wan8J3ZrX34Sva1vgw40kw4fu3ZYyF1UAw1xKrs7AryfCFWrtr93uFZ3
        ZF10qFW8Aw4UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

pd_offline_fn() is ensured to be called in order(parent after child),
while pd_free_fn() is not. Furthermore, rq_qos_exit() can also be called
before pd_free_fn(). For conclusion, doing cleanups in ioc_pd_free() is
not safe, which can cause many problems. By the way, iocost is the only
policy to do cleanups in pd_free_fn().

Since previous patches guarantee that ioc_pd_offline() will dispatch
throttled bio and prevent new io to be throttled. It's safe to move
cleanup operations for iocg from ioc_pd_free() to ioc_pd_offline().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b63ecfdd815c..d634ea73f991 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3011,21 +3011,6 @@ static void ioc_pd_offline(struct blkg_policy_data *pd)
 
 		iocg_lock(iocg, true, &flags);
 		iocg->online = false;
-		iocg_unlock(iocg, true, &flags);
-
-		hrtimer_cancel(&iocg->waitq_timer);
-		__wake_up(&iocg->waitq, TASK_NORMAL, 0, &ctx);
-	}
-}
-
-static void ioc_pd_free(struct blkg_policy_data *pd)
-{
-	struct ioc_gq *iocg = pd_to_iocg(pd);
-	struct ioc *ioc = iocg->ioc;
-	unsigned long flags;
-
-	if (ioc) {
-		spin_lock_irqsave(&ioc->lock, flags);
 
 		if (!list_empty(&iocg->active_list)) {
 			struct ioc_now now;
@@ -3038,8 +3023,17 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		WARN_ON_ONCE(!list_empty(&iocg->walk_list));
 		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 
-		spin_unlock_irqrestore(&ioc->lock, flags);
+		iocg_unlock(iocg, true, &flags);
+
+		hrtimer_cancel(&iocg->waitq_timer);
+		__wake_up(&iocg->waitq, TASK_NORMAL, 0, &ctx);
 	}
+}
+
+static void ioc_pd_free(struct blkg_policy_data *pd)
+{
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+
 	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
 }
-- 
2.31.1

