Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9C5952DD
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiHPGqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiHPGpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 02:45:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0332FF203;
        Mon, 15 Aug 2022 18:44:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M6DSp3mNrzlC6t;
        Tue, 16 Aug 2022 09:43:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnu_iS9vpicjqdAQ--.63281S7;
        Tue, 16 Aug 2022 09:44:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/3] block, bfq: remove useless parameter for bfq_add/del_bfqq_busy()
Date:   Tue, 16 Aug 2022 09:56:31 +0800
Message-Id: <20220816015631.1323948-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
References: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnu_iS9vpicjqdAQ--.63281S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGryrJF48ZFWxAw43Kr48WFg_yoW5Kw1Upa
        y3Ka17X3WrGr15Xr45Ja1jqrnIgw1rC3srt3W8X34rtrZFyrnFv3Wqy340vF4Igrn7Gr43
        Zr9Ygr97Ar1xGFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'bfqd' can be accessed through 'bfqq->bfqd', there is no need to pass
it as a parameter separately.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 8 ++++----
 block/bfq-iosched.h | 5 ++---
 block/bfq-wf2q.c    | 9 ++++++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f39067389b2b..7ea427817f7f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1925,7 +1925,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfqq->service_from_backlogged = 0;
 	bfq_clear_bfqq_softrt_update(bfqq);
 
-	bfq_add_bfqq_busy(bfqd, bfqq);
+	bfq_add_bfqq_busy(bfqq);
 
 	/*
 	 * Expire in-service queue if preemption may be needed for
@@ -2419,7 +2419,7 @@ static void bfq_remove_request(struct request_queue *q,
 		bfqq->next_rq = NULL;
 
 		if (bfq_bfqq_busy(bfqq) && bfqq != bfqd->in_service_queue) {
-			bfq_del_bfqq_busy(bfqd, bfqq, false);
+			bfq_del_bfqq_busy(bfqq, false);
 			/*
 			 * bfqq emptied. In normal operation, when
 			 * bfqq is empty, bfqq->entity.service and
@@ -3098,7 +3098,7 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	 */
 	if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
 	    bfqq != bfqd->in_service_queue)
-		bfq_del_bfqq_busy(bfqd, bfqq, false);
+		bfq_del_bfqq_busy(bfqq, false);
 
 	bfq_reassign_last_bfqq(bfqq, NULL);
 
@@ -3908,7 +3908,7 @@ static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			 */
 			bfqq->budget_timeout = jiffies;
 
-		bfq_del_bfqq_busy(bfqd, bfqq, true);
+		bfq_del_bfqq_busy(bfqq, true);
 	} else {
 		bfq_requeue_bfqq(bfqd, bfqq, true);
 		/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f81ab3c8fa3c..64ee618064ba 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1080,9 +1080,8 @@ void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		      bool expiration);
-void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-		       bool expiration);
-void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
+void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
 
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 983413cdefad..8fc3da4c23bb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1651,9 +1651,10 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * the service tree. As a special case, it can be invoked during an
  * expiration.
  */
-void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-		       bool expiration)
+void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration)
 {
+	struct bfq_data *bfqd = bfqq->bfqd;
+
 	bfq_log_bfqq(bfqd, bfqq, "del from busy");
 
 	bfq_clear_bfqq_busy(bfqq);
@@ -1674,8 +1675,10 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 /*
  * Called when an inactive queue receives a new request.
  */
-void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
 {
+	struct bfq_data *bfqd = bfqq->bfqd;
+
 	bfq_log_bfqq(bfqd, bfqq, "add to busy");
 
 	bfq_activate_bfqq(bfqd, bfqq);
-- 
2.31.1

