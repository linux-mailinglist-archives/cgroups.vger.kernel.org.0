Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7D65CE46
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjADI32 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjADI3Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 03:29:25 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8A186D9;
        Wed,  4 Jan 2023 00:29:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nn2np3WZwz4f3nFG;
        Wed,  4 Jan 2023 16:29:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+ndOLVjwys+BA--.58806S6;
        Wed, 04 Jan 2023 16:29:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 2/4] block/rq_qos: factor out a helper to add rq_qos and activate policy
Date:   Wed,  4 Jan 2023 16:53:52 +0800
Message-Id: <20230104085354.2343590-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+ndOLVjwys+BA--.58806S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rCF1xtrykXr48XF1rCrg_yoW5Kw47pa
        yfKrnIyrWjgr4I9a1xGw4rJr98uw48Kry5Gay8AryfArW29w1Iy3W0yF1DKa4fZrsxArs5
        ZF4Yqry8GFy5G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
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

For the policy that use both rq_qos and blkcg_policy, rq_qos_add() and
blkcg_activate_policy() should be atomic, otherwise null-ptr-deference
can be triggered. This patch prepare to use a global mutex to protect
them, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c    | 14 +-------------
 block/blk-iolatency.c |  7 +------
 block/blk-rq-qos.c    | 23 +++++++++++++++++++++++
 block/blk-rq-qos.h    |  6 ++++++
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6955605629e4..9199124f0cc2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2883,23 +2883,11 @@ static int blk_iocost_init(struct gendisk *disk)
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
-	/*
-	 * rqos must be added before activation to allow ioc_pd_init() to
-	 * lookup the ioc from q. This means that the rqos methods may get
-	 * called before policy activation completion, can't assume that the
-	 * target bio has an iocg associated and need to test for NULL iocg.
-	 */
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add_and_activate_policy(q, rqos, &blkcg_policy_iocost);
 	if (ret)
 		goto err_free_ioc;
-
-	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
-	if (ret)
-		goto err_del_qos;
 	return 0;
 
-err_del_qos:
-	rq_qos_del(q, rqos);
 err_free_ioc:
 	free_percpu(ioc->pcpu_stat);
 	kfree(ioc);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ecdc10741836..a29b923e2a6a 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -771,20 +771,15 @@ int blk_iolatency_init(struct gendisk *disk)
 	rqos->ops = &blkcg_iolatency_ops;
 	rqos->q = q;
 
-	ret = rq_qos_add(q, rqos);
+	ret = rq_qos_add_and_activate_policy(q, rqos, &blkcg_policy_iolatency);
 	if (ret)
 		goto err_free;
-	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
-	if (ret)
-		goto err_qos_del;
 
 	timer_setup(&blkiolat->timer, blkiolatency_timer_fn, 0);
 	INIT_WORK(&blkiolat->enable_work, blkiolatency_enable_work_fn);
 
 	return 0;
 
-err_qos_del:
-	rq_qos_del(q, rqos);
 err_free:
 	kfree(blkiolat);
 	return ret;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index b6ea40775b2a..50544bfb12f1 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -353,3 +353,26 @@ void rq_qos_exit(struct request_queue *q)
 		rqos->ops->exit(rqos);
 	}
 }
+
+#ifdef CONFIG_BLK_CGROUP
+int rq_qos_add_and_activate_policy(struct request_queue *q, struct rq_qos *rqos,
+				   const struct blkcg_policy *pol)
+{
+	/*
+	 * rqos must be added before activation to allow pd_init_fn() to
+	 * lookup the global structure from q. This means that the rqos methods
+	 * may get called before policy activation completion, can't assume that
+	 * the target bio has an pd associated and need to test for NULL.
+	 */
+	int ret = rq_qos_add(q, rqos);
+
+	if (ret)
+		return ret;
+
+	ret = blkcg_activate_policy(q, pol);
+	if (ret)
+		rq_qos_del(q, rqos);
+
+	return ret;
+}
+#endif
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index f2d95e19d7a8..0778cff3777c 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -173,4 +173,10 @@ static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 		__rq_qos_queue_depth_changed(q->rq_qos);
 }
 
+#ifdef CONFIG_BLK_CGROUP
+#include "blk-cgroup.h"
+int rq_qos_add_and_activate_policy(struct request_queue *q, struct rq_qos *rqos,
+				   const struct blkcg_policy *pol);
+#endif
+
 #endif
-- 
2.31.1

