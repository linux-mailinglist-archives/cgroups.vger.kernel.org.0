Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E564F71C
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLQCow (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLQCou (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:44:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90070216;
        Fri, 16 Dec 2022 18:44:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYr0X2DGDz4f3w0C;
        Sat, 17 Dec 2022 10:44:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9gcLZ1j2O96CQ--.47195S7;
        Sat, 17 Dec 2022 10:44:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/4] blk-iocost: dispatch all throttled bio in ioc_pd_offline
Date:   Sat, 17 Dec 2022 11:05:26 +0800
Message-Id: <20221217030527.1250083-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9gcLZ1j2O96CQ--.47195S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkXw1xtw4DXF15GrW5Awb_yoW5Jr48pF
        43W3WFya48Zr17Ka1rtF1DXrySy393Wan7tr43K3Z5AF1xGr12qFn5CryxCFyFvrZ3WFZ3
        AF4rKrWfCw4q937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
        =
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

Currently, if cgroup is removed while some bio is still throttled, such
bio will still wait for timer to dispatch. On the one hand, it
doesn't make sense to throttle bio while cgroup is removed, on the other
hand, this behaviour makes it hard to guarantee the exit order for
iocg(in ioc_pd_free() currently).

This patch make iocg->online updated under both 'ioc->lock' and
'iocg->waitq.lock', so it can be guaranteed that iocg will stay online
while holding any lock. In the meantime, all throttled bio will be
dispatched immediately in ioc_pd_offline().

This patch also prepare to move operations on iocg from ioc_pd_free()
to ioc_pd_offline().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 23cc734dbe43..b63ecfdd815c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1448,14 +1448,18 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 {
 	struct iocg_wait *wait = container_of(wq_entry, struct iocg_wait, wait);
 	struct iocg_wake_ctx *ctx = key;
-	u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
 
-	ctx->vbudget -= cost;
+	if (ctx->iocg->online) {
+		u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
 
-	if (ctx->vbudget < 0)
-		return -1;
+		ctx->vbudget -= cost;
+
+		if (ctx->vbudget < 0)
+			return -1;
+
+		iocg_commit_bio(ctx->iocg, wait->bio, wait->abs_cost, cost);
+	}
 
-	iocg_commit_bio(ctx->iocg, wait->bio, wait->abs_cost, cost);
 	wait->committed = true;
 
 	/*
@@ -3003,9 +3007,14 @@ static void ioc_pd_offline(struct blkg_policy_data *pd)
 	unsigned long flags;
 
 	if (ioc) {
-		spin_lock_irqsave(&ioc->lock, flags);
+		struct iocg_wake_ctx ctx = { .iocg = iocg };
+
+		iocg_lock(iocg, true, &flags);
 		iocg->online = false;
-		spin_unlock_irqrestore(&ioc->lock, flags);
+		iocg_unlock(iocg, true, &flags);
+
+		hrtimer_cancel(&iocg->waitq_timer);
+		__wake_up(&iocg->waitq, TASK_NORMAL, 0, &ctx);
 	}
 }
 
@@ -3030,8 +3039,6 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 
 		spin_unlock_irqrestore(&ioc->lock, flags);
-
-		hrtimer_cancel(&iocg->waitq_timer);
 	}
 	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
-- 
2.31.1

