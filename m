Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93A587D93
	for <lists+cgroups@lfdr.de>; Tue,  2 Aug 2022 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiHBNw4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Aug 2022 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiHBNwk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Aug 2022 09:52:40 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D7286E3;
        Tue,  2 Aug 2022 06:52:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LxxGw0bXlzlDjv;
        Tue,  2 Aug 2022 21:51:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDXLsMQLOlivtl0AA--.20757S13;
        Tue, 02 Aug 2022 21:52:25 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v7 9/9] blk-throttle: clean up flag 'THROTL_TG_PENDING'
Date:   Tue,  2 Aug 2022 22:04:15 +0800
Message-Id: <20220802140415.2960284-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDXLsMQLOlivtl0AA--.20757S13
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UuFW5KF1UXrWkuw4fuFg_yoW5AFWDpr
        y3AF4fGw48tr4qgrWYqF47GFWSvan3JrWfA3srJa1fJr42vr92gr4DZFyFqayrAFZ3CFW3
        ZF4Dt3y8Ja18X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
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

All related operations are inside 'queue_lock', there is no need to use
the flag, we only need to make sure throtl_enqueue_tg() is called when
the first bio is throttled, and throtl_dequeue_tg() is called when the
last throttled bio is dispatched. There are no functional changes in
this patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 22 ++++++++--------------
 block/blk-throttle.h |  7 +++----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6b2096e95221..778c0131adb1 100644
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
@@ -1026,8 +1019,9 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
 	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
 
+	if (!sq->nr_queued[READ] && !sq->nr_queued[WRITE])
+		throtl_enqueue_tg(tg);
 	sq->nr_queued[rw]++;
-	throtl_enqueue_tg(tg);
 }
 
 static void tg_update_disptime(struct throtl_grp *tg)
@@ -1382,7 +1376,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 	throtl_start_new_slice(tg, READ, false);
 	throtl_start_new_slice(tg, WRITE, false);
 
-	if (tg->flags & THROTL_TG_PENDING) {
+	if (sq->nr_queued[READ] || sq->nr_queued[WRITE]) {
 		tg_update_disptime(tg);
 		throtl_schedule_next_dispatch(sq->parent_sq, true);
 	}
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index c9545616ba12..2ae5ac8fe76e 100644
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

