Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE1618E1C
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 03:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKDCSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Nov 2022 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDCSB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Nov 2022 22:18:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC912B;
        Thu,  3 Nov 2022 19:18:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N3PNy4WVRzlBwJ;
        Fri,  4 Nov 2022 10:15:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgB3D9RTdmRjDShNBQ--.16192S8;
        Fri, 04 Nov 2022 10:17:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context warnning
Date:   Fri,  4 Nov 2022 10:39:37 +0800
Message-Id: <20221104023938.2346986-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3D9RTdmRjDShNBQ--.16192S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fWw15XFy5Gw45uF17KFg_yoW7Jr4kpF
        WYg39xt3y8trsrXw1DWrsFvr4rC34kKrWxJ3s3JFn3AF9rKrn2qF1kCryj9F48tFZ3ZrZx
        tr4Fq395AF4UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

match_u64() is called inside ioc->lock, which causes smatch static
checker warnings:

block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic
context

Fix the problem by introducing a mutex and using it while prasing input
params.

Fixes: 2c0647988433 ("blk-iocost: don't release 'ioc->lock' while updating params")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2bfecc511dd9..192ad4e0cfc6 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -404,6 +404,7 @@ struct ioc {
 
 	bool				enabled;
 
+	struct mutex			params_mutex;
 	struct ioc_params		params;
 	struct ioc_margins		margins;
 	u32				period_us;
@@ -2212,6 +2213,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 	/* how were the latencies during the period? */
 	ioc_lat_stat(ioc, missed_ppm, &rq_wait_pct);
 
+	mutex_lock(&ioc->params_mutex);
+
 	/* take care of active iocgs */
 	spin_lock_irq(&ioc->lock);
 
@@ -2222,6 +2225,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	period_vtime = now.vnow - ioc->period_at_vtime;
 	if (WARN_ON_ONCE(!period_vtime)) {
 		spin_unlock_irq(&ioc->lock);
+		mutex_unlock(&ioc->params_mutex);
 		return;
 	}
 
@@ -2419,6 +2423,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	}
 
 	spin_unlock_irq(&ioc->lock);
+	mutex_unlock(&ioc->params_mutex);
 }
 
 static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
@@ -2801,9 +2806,11 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
+	mutex_lock(&ioc->params_mutex);
 	spin_lock_irq(&ioc->lock);
 	ioc_refresh_params(ioc, false);
 	spin_unlock_irq(&ioc->lock);
+	mutex_unlock(&ioc->params_mutex);
 }
 
 static void ioc_rqos_exit(struct rq_qos *rqos)
@@ -2862,6 +2869,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	rqos->ops = &ioc_rqos_ops;
 	rqos->q = q;
 
+	mutex_init(&ioc->params_mutex);
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2874,10 +2882,12 @@ static int blk_iocost_init(struct gendisk *disk)
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
 
+	mutex_lock(&ioc->params_mutex);
 	spin_lock_irq(&ioc->lock);
 	ioc->autop_idx = AUTOP_INVALID;
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
+	mutex_unlock(&ioc->params_mutex);
 
 	/*
 	 * rqos must be added before activation to allow iocg_pd_init() to
@@ -3197,7 +3207,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
-	spin_lock_irq(&ioc->lock);
+	mutex_lock(&ioc->params_mutex);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
 	user = ioc->user_qos_params;
@@ -3278,6 +3288,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (qos[QOS_MIN] > qos[QOS_MAX])
 		goto out_unlock;
 
+	spin_lock_irq(&ioc->lock);
 	if (enable) {
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
@@ -3298,9 +3309,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	ioc_refresh_params(ioc, true);
 	ret = nbytes;
+	spin_unlock_irq(&ioc->lock);
 
 out_unlock:
-	spin_unlock_irq(&ioc->lock);
+	mutex_unlock(&ioc->params_mutex);
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
@@ -3385,7 +3397,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
-	spin_lock_irq(&ioc->lock);
+	mutex_lock(&ioc->params_mutex);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
 
@@ -3431,6 +3443,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		user = true;
 	}
 
+	spin_lock_irq(&ioc->lock);
 	if (user) {
 		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
 		ioc->user_cost_model = true;
@@ -3440,9 +3453,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
 	ioc_refresh_params(ioc, true);
 	ret = nbytes;
+	spin_unlock_irq(&ioc->lock);
 
 out_unlock:
-	spin_unlock_irq(&ioc->lock);
+	mutex_unlock(&ioc->params_mutex);
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
-- 
2.31.1

