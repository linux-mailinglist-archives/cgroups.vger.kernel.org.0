Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38665562D23
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiGAHzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiGAHzO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:55:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC46D579;
        Fri,  1 Jul 2022 00:55:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ6SY3FN0zKJtk;
        Fri,  1 Jul 2022 15:35:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWgIpL5igL73AA--.48972S13;
        Fri, 01 Jul 2022 15:36:46 +0800 (CST)
From:   Yu Kuai <yukuai3@huawei.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v6 8/8] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Date:   Fri,  1 Jul 2022 15:49:23 +0800
Message-Id: <20220701074923.657426-10-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701074923.657426-1-yukuai3@huawei.com>
References: <20220701074923.657426-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWgIpL5igL73AA--.48972S13
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UuFy7GF4UAFy3Xr18Zrb_yoW5Ar1Dpr
        y3AF1fGw48tr4qgrWYqF47GFWfZan3JrWSy3srJa1ftr42vr92qr1DZFyFvayFyFZ3GrW3
        ZF4Dt395Aa1UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
        02YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28I
        cwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UuuWdUUUUU=
Sender: yukuai1@huaweicloud.com
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

All related operations are inside 'queue_lock', there is no need to use
the flag, we only need to make sure throtl_enqueue_tg() is called when
the first bio is throttled, and throtl_dequeue_tg() is called when the
last throttled bio is dispatched.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 22 ++++++++--------------
 block/blk-throttle.h |  7 +++----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 473f0b651ef0..29e9f7f6573c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -561,23 +561,16 @@ static void tg_service_queue_add(struct throtl_grp *tg)
 
 static void throtl_enqueue_tg(struct throtl_grp *tg)
 {
-	if (!(tg->flags & THROTL_TG_PENDING)) {
-		tg_service_queue_add(tg);
-		tg->flags |= THROTL_TG_PENDING;
-		tg->service_queue.parent_sq->nr_pending++;
-	}
+	tg_service_queue_add(tg);
+	tg->service_queue.parent_sq->nr_pending++;
 }
 
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
-	if (tg->flags & THROTL_TG_PENDING) {
-		struct throtl_service_queue *parent_sq =
-			tg->service_queue.parent_sq;
+	struct throtl_service_queue *parent_sq = tg->service_queue.parent_sq;
 
-		throtl_rb_erase(&tg->rb_node, parent_sq);
-		--parent_sq->nr_pending;
-		tg->flags &= ~THROTL_TG_PENDING;
-	}
+	throtl_rb_erase(&tg->rb_node, parent_sq);
+	--parent_sq->nr_pending;
 }
 
 /* Call with queue lock held */
@@ -1021,8 +1014,9 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
 	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
 
+	if (!sq->nr_queued[READ] && !sq->nr_queued[WRITE])
+		throtl_enqueue_tg(tg);
 	sq->nr_queued[rw]++;
-	throtl_enqueue_tg(tg);
 }
 
 static void tg_update_disptime(struct throtl_grp *tg)
@@ -1377,7 +1371,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	throtl_start_new_slice(tg, READ, false);
 	throtl_start_new_slice(tg, WRITE, false);
 
-	if (tg->flags & THROTL_TG_PENDING) {
+	if (sq->nr_queued[READ] || sq->nr_queued[WRITE]) {
 		tg_update_disptime(tg);
 		throtl_schedule_next_dispatch(sq->parent_sq, true);
 	}
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 371d624af845..fba48afbcff3 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -53,10 +53,9 @@ struct throtl_service_queue {
 };
 
 enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
-	THROTL_TG_CANCELING	= 1 << 3,	/* starts to cancel bio */
+	THROTL_TG_WAS_EMPTY	= 1 << 0,	/* bio_lists[] became non-empty */
+	THROTL_TG_HAS_IOPS_LIMIT = 1 << 1,	/* tg has iops limit */
+	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
 };
 
 enum {
-- 
2.31.1

