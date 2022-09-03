Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6915ABD69
	for <lists+cgroups@lfdr.de>; Sat,  3 Sep 2022 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiICGRS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Sep 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICGRR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Sep 2022 02:17:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30663F0776;
        Fri,  2 Sep 2022 23:17:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MKPf924XwzKDR9;
        Sat,  3 Sep 2022 14:15:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBH53Bn8RJjLm43AQ--.14139S4;
        Sat, 03 Sep 2022 14:17:12 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] blk-throttle: clean up codes that can't be reached
Date:   Sat,  3 Sep 2022 14:28:26 +0800
Message-Id: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53Bn8RJjLm43AQ--.14139S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1rJr47Gr4rGr45Jw4fXwb_yoWrAr4kpF
        Wava13Aw1UXrsF9r43tw1DtFWFvws7X343t3y7Jw43trW2qw1qgF1kZa40vFWFyFZ7Wrs3
        ZFn8KrWDGF4UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

While doing code coverage testing while CONFIG_BLK_DEV_THROTTLING_LOW is
disabled, we found that there are many codes can never be reached.

This patch move such codes inside "#ifdef CONFIG_BLK_DEV_THROTTLING_LOW".

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 90 +++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9f5fe62afff9..667b2958471a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1673,6 +1673,40 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	spin_lock_irq(&q->queue_lock);
+	/*
+	 * queue_lock is held, rcu lock is not needed here technically.
+	 * However, rcu lock is still held to emphasize that following
+	 * path need RCU protection and to prevent warning from lockdep.
+	 */
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		/*
+		 * Set the flag to make sure throtl_pending_timer_fn() won't
+		 * stop until all throttled bios are dispatched.
+		 */
+		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
+		/*
+		 * Update disptime after setting the above flag to make sure
+		 * throtl_select_dispatch() won't exit without dispatching.
+		 */
+		tg_update_disptime(tg);
+
+		throtl_schedule_pending_timer(sq, jiffies + 1);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
+}
+
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
 {
 	unsigned long rtime = jiffies, wtime = jiffies;
@@ -1777,39 +1811,6 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
 	return false;
 }
 
-void blk_throtl_cancel_bios(struct request_queue *q)
-{
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
-
-	spin_lock_irq(&q->queue_lock);
-	/*
-	 * queue_lock is held, rcu lock is not needed here technically.
-	 * However, rcu lock is still held to emphasize that following
-	 * path need RCU protection and to prevent warning from lockdep.
-	 */
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-		struct throtl_service_queue *sq = &tg->service_queue;
-
-		/*
-		 * Set the flag to make sure throtl_pending_timer_fn() won't
-		 * stop until all throttled bios are dispatched.
-		 */
-		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
-		/*
-		 * Update disptime after setting the above flag to make sure
-		 * throtl_select_dispatch() won't exit without dispatching.
-		 */
-		tg_update_disptime(tg);
-
-		throtl_schedule_pending_timer(sq, jiffies + 1);
-	}
-	rcu_read_unlock();
-	spin_unlock_irq(&q->queue_lock);
-}
-
 static bool throtl_can_upgrade(struct throtl_data *td,
 	struct throtl_grp *this_tg)
 {
@@ -2005,7 +2006,6 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 	tg->checked_last_finish_time = last_finish_time;
 }
 
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static void throtl_update_latency_buckets(struct throtl_data *td)
 {
 	struct avg_latency_bucket avg_latency[2][LATENCY_BUCKET_SIZE];
@@ -2086,6 +2086,28 @@ static void throtl_update_latency_buckets(struct throtl_data *td)
 static inline void throtl_update_latency_buckets(struct throtl_data *td)
 {
 }
+
+static void blk_throtl_update_idletime(struct throtl_grp *tg)
+{
+}
+
+static void throtl_downgrade_check(struct throtl_grp *tg)
+{
+}
+
+static void throtl_upgrade_check(struct throtl_grp *tg)
+{
+}
+
+static bool throtl_can_upgrade(struct throtl_data *td,
+	struct throtl_grp *this_tg)
+{
+	return false;
+}
+
+static void throtl_upgrade_state(struct throtl_data *td)
+{
+}
 #endif
 
 bool __blk_throtl_bio(struct bio *bio)
-- 
2.31.1

