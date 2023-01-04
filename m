Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C665CE4F
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjADI3d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 03:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjADI3Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 03:29:25 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96E192BA;
        Wed,  4 Jan 2023 00:29:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn2nq0Qy6z4f42p3;
        Wed,  4 Jan 2023 16:29:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+ndOLVjwys+BA--.58806S7;
        Wed, 04 Jan 2023 16:29:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect rq_qos apis
Date:   Wed,  4 Jan 2023 16:53:53 +0800
Message-Id: <20230104085354.2343590-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+ndOLVjwys+BA--.58806S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAryftw1DGrW7ZFy8Cw1Utrb_yoWrGr4Dpa
        1fKrWay3yqgrs7Was8Gw48ZasxKw1rKryUJF4xJrWfArWvvF1jvF10yFyxWFWrZF9rJrs3
        Ary5trs5Ar1UXwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This patch fix following problems:

1) rq_qos_add() and rq_qos_del() is protected, while rq_qos_exit() is
   not.
2) rq_qos_add() and blkcg_activate_policy() is not atomic, if
   rq_qos_exit() is done before blkcg_activate_policy(),
   null-ptr-deference can be triggered.

rq_qos_add(), rq_qos_del() and rq_qos_exit() are super cold path, hence
fix the problems by using a global mutex to protect them.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-rq-qos.c | 50 ++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 50544bfb12f1..5f7ccc249c11 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,6 +2,8 @@
 
 #include "blk-rq-qos.h"
 
+static DEFINE_MUTEX(rq_qos_lock);
+
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -286,23 +288,18 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	finish_wait(&rqw->wait, &data.wq);
 }
 
-int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+static int __rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
 	 */
 	blk_mq_freeze_queue(q);
 
-	spin_lock_irq(&q->queue_lock);
 	if (rq_qos_id(q, rqos->id))
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
 
 	blk_mq_unfreeze_queue(q);
 
@@ -314,29 +311,23 @@ int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 
 	return 0;
 ebusy:
-	spin_unlock_irq(&q->queue_lock);
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
 }
 
-void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+static void __rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 {
 	struct rq_qos **cur;
 
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
+	/* See comment in __rq_qos_add() about freezing queue */
 	blk_mq_freeze_queue(q);
 
-	spin_lock_irq(&q->queue_lock);
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
 			break;
 		}
 	}
-	spin_unlock_irq(&q->queue_lock);
 
 	blk_mq_unfreeze_queue(q);
 
@@ -345,13 +336,33 @@ void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
+int rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
+{
+	int ret;
+
+	mutex_lock(&rq_qos_lock);
+	ret = __rq_qos_add(q, rqos);
+	mutex_unlock(&rq_qos_lock);
+
+	return ret;
+}
+
+void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
+{
+	mutex_lock(&rq_qos_lock);
+	__rq_qos_del(q, rqos);
+	mutex_unlock(&rq_qos_lock);
+}
+
 void rq_qos_exit(struct request_queue *q)
 {
+	mutex_lock(&rq_qos_lock);
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
 	}
+	mutex_unlock(&rq_qos_lock);
 }
 
 #ifdef CONFIG_BLK_CGROUP
@@ -364,15 +375,20 @@ int rq_qos_add_and_activate_policy(struct request_queue *q, struct rq_qos *rqos,
 	 * may get called before policy activation completion, can't assume that
 	 * the target bio has an pd associated and need to test for NULL.
 	 */
-	int ret = rq_qos_add(q, rqos);
+	int ret;
 
-	if (ret)
+	mutex_lock(&rq_qos_lock);
+	ret = __rq_qos_add(q, rqos);
+	if (ret) {
+		mutex_unlock(&rq_qos_lock);
 		return ret;
+	}
 
 	ret = blkcg_activate_policy(q, pol);
 	if (ret)
-		rq_qos_del(q, rqos);
+		__rq_qos_del(q, rqos);
 
+	mutex_unlock(&rq_qos_lock);
 	return ret;
 }
 #endif
-- 
2.31.1

