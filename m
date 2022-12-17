Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A364F72D
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLQCsc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiLQCsa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:48:30 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AFB1E5;
        Fri, 16 Dec 2022 18:48:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NYr4m1k4gz4f3npg;
        Sat, 17 Dec 2022 10:48:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9j5LZ1jmxh7CQ--.11469S6;
        Sat, 17 Dec 2022 10:48:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 2/4] block/rq_qos: fail rq_qos_add() after del_gendisk()
Date:   Sat, 17 Dec 2022 11:09:06 +0800
Message-Id: <20221217030908.1261787-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9j5LZ1jmxh7CQ--.11469S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15XrWkCF15trWxGr1ftFb_yoW8CrW7pa
        1xKr13Aayvgrs7WaykGw4rXasxC34rKryfCFWxWrWSvF4j9F1j9F10yFWUWayrZFZ3AF4f
        Xr4rAr95Cr48GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe1v3UUUU
        U
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

rq_qos_add() can still succeed after rq_qos_exit() is done, which will
cause memory leak because such rq_qos will never be removed.

t1                      t2
// configure iocost
blk_iocost_init
			//remove device
			del_gendisk
			 rq_qos_exit
			 // done nothing because rq_qos doesn't exist
 rq_qos_add
 // will succeed, and rq_qos won't be removed

rq_qos_add() will also be called from blkcg_init_disk() from
__alloc_disk_node(), and GD_DEAD can distinguish between disk
allocation and disk deletion. Fix the problem by checking GD_DEAD in
rq_qos_add().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-rq-qos.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 1ef1f7d4bc3c..81e087139ffb 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -87,6 +87,7 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 
 static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
+	int err;
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
@@ -97,8 +98,16 @@ static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 	blk_mq_freeze_queue(q);
 
 	spin_lock_irq(&q->queue_lock);
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
+	if (rq_qos_id(q, rqos->id)) {
+		err = -EBUSY;
+		goto err;
+	}
+
+	if (q->disk && test_bit(GD_DEAD, &q->disk->state)) {
+		err = -ENODEV;
+		goto err;
+	}
+
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
 	spin_unlock_irq(&q->queue_lock);
@@ -112,10 +121,10 @@ static inline int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 	}
 
 	return 0;
-ebusy:
+err:
 	spin_unlock_irq(&q->queue_lock);
 	blk_mq_unfreeze_queue(q);
-	return -EBUSY;
+	return err;
 
 }
 
-- 
2.31.1

