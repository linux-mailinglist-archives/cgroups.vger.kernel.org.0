Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF065CE4D
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjADI3b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 03:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjADI3Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 03:29:25 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA44193CF;
        Wed,  4 Jan 2023 00:29:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn2nq4J7sz4f3wYs;
        Wed,  4 Jan 2023 16:29:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+ndOLVjwys+BA--.58806S8;
        Wed, 04 Jan 2023 16:29:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 4/4] block/rq_qos: fail rq_qos_add() after rq_qos_exit()
Date:   Wed,  4 Jan 2023 16:53:54 +0800
Message-Id: <20230104085354.2343590-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+ndOLVjwys+BA--.58806S8
X-Coremail-Antispam: 1UD129KBjvJXoW7CF15XrWkCrWxZr4xCF4kZwb_yoW8ArW8pa
        yfKr1ay3yqgrs7W3WfGw48X39xA3yrKr47AFn7X3yfArWUCr1j9F1vyFWUtayfAFnrJF4f
        trn5Kr15Cr15J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Fix the problem by setting q->rq_qos to a special value in
rq_qos_exit(), and check the value in rq_qos_add().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-rq-qos.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 5f7ccc249c11..cfd8024ff6e8 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -290,6 +290,10 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 static int __rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
+	/* See details in rq_qos_exit() for this specail value. */
+	if (IS_ERR(q->rq_qos))
+		return PTR_ERR(q->rq_qos);
+
 	/*
 	 * No IO can be in-flight when adding rqos, so freeze queue, which
 	 * is fine since we only support rq_qos for blk-mq queue.
@@ -356,12 +360,22 @@ void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 
 void rq_qos_exit(struct request_queue *q)
 {
+	struct rq_qos *rqos;
+
 	mutex_lock(&rq_qos_lock);
-	while (q->rq_qos) {
-		struct rq_qos *rqos = q->rq_qos;
-		q->rq_qos = rqos->next;
+	rqos = q->rq_qos;
+
+	/*
+	 * Set q->rq_qos to a special value to make sure rq_qos_add() will fail
+	 * after rq_qos_exit().
+	 */
+	q->rq_qos = ERR_PTR(-ENODEV);
+
+	while (rqos) {
 		rqos->ops->exit(rqos);
+		rqos = rqos->next;
 	}
+
 	mutex_unlock(&rq_qos_lock);
 }
 
-- 
2.31.1

