Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393764F730
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLQCsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiLQCsb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:48:31 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F8A1BA;
        Fri, 16 Dec 2022 18:48:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NYr4m4v90z4f3nqH;
        Sat, 17 Dec 2022 10:48:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9j5LZ1jmxh7CQ--.11469S7;
        Sat, 17 Dec 2022 10:48:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/4] blk-cgroup: add a new interface blkcg_conf_close_bdev()
Date:   Sat, 17 Dec 2022 11:09:07 +0800
Message-Id: <20221217030908.1261787-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9j5LZ1jmxh7CQ--.11469S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1rGr1kAry7WFyfJr43KFg_yoW5CFW3pF
        W5tay3Jry2grn0vFsF9ay2gr1Fyr4kKFyfJ393GryYkrWIgw1xZF1kZF1kKrWrXFZ3Ars8
        ZFWSvrWjkr18CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFfHUDUUU
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

It's the same as blkdev_put_no_open() for now, prepare to synchronize
del_gendisk() with configuring cgroup policy. There are no functional
changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 9 +++++++--
 block/blk-cgroup.h | 1 +
 block/blk-iocost.c | 8 ++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 77f44472b41e..ad612148cf3b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -662,6 +662,11 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
 	return bdev;
 }
 
+void blkcg_conf_close_bdev(struct block_device *bdev)
+{
+	blkdev_put_no_open(bdev);
+}
+
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
@@ -781,7 +786,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 fail_exit_queue:
 	blk_queue_exit(q);
 fail:
-	blkdev_put_no_open(bdev);
+	blkcg_conf_close_bdev(bdev);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -808,7 +813,7 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 {
 	spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
 	rcu_read_unlock();
-	blkdev_put_no_open(ctx->bdev);
+	blkcg_conf_close_bdev(ctx->bdev);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1e94e404eaa8..d4ae1e7288c1 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -214,6 +214,7 @@ struct blkg_conf_ctx {
 };
 
 struct block_device *blkcg_conf_open_bdev(char **inputp);
+void blkcg_conf_close_bdev(struct block_device *bdev);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d1bdc12deaa7..5294a404c892 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3288,7 +3288,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-	blkdev_put_no_open(bdev);
+	blkcg_conf_close_bdev(bdev);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
@@ -3298,7 +3298,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	ret = -EINVAL;
 err:
-	blkdev_put_no_open(bdev);
+	blkcg_conf_close_bdev(bdev);
 	return ret;
 }
 
@@ -3424,7 +3424,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
-	blkdev_put_no_open(bdev);
+	blkcg_conf_close_bdev(bdev);
 	return nbytes;
 
 einval:
@@ -3435,7 +3435,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
 	ret = -EINVAL;
 err:
-	blkdev_put_no_open(bdev);
+	blkcg_conf_close_bdev(bdev);
 	return ret;
 }
 
-- 
2.31.1

