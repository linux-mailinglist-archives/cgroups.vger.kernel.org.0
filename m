Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DF562FD0
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiGAJWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiGAJWE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 05:22:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA417599D4;
        Fri,  1 Jul 2022 02:22:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ8p754JXzlC3D;
        Fri,  1 Jul 2022 17:21:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mm1vL5i6ab6AA--.40529S11;
        Fri, 01 Jul 2022 17:22:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RESEND v6 7/8] blk-throttle: cleanup tg_update_disptime()
Date:   Fri,  1 Jul 2022 17:34:40 +0800
Message-Id: <20220701093441.885741-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701093441.885741-1-yukuai1@huaweicloud.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mm1vL5i6ab6AA--.40529S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrKw4DJw1rAw13uw1kGrg_yoW8WryrpF
        yUCF4rJa18tr4qkry5XFsrXFWfJan7JFWfA397Ga1fArW2qrnFgrn7ZryrZaykAF93XrW5
        ZFsrtw48Aa1UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbyv
        35UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

th_update_disptime() only need to adjust postion for 'tg' in
'parent_sq', there is no need to call throtl_enqueue/dequeue_tg().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ab30efedff4e..473f0b651ef0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -520,7 +520,6 @@ static void throtl_rb_erase(struct rb_node *n,
 {
 	rb_erase_cached(n, &parent_sq->pending_tree);
 	RB_CLEAR_NODE(n);
-	--parent_sq->nr_pending;
 }
 
 static void update_min_dispatch_time(struct throtl_service_queue *parent_sq)
@@ -572,7 +571,11 @@ static void throtl_enqueue_tg(struct throtl_grp *tg)
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
 	if (tg->flags & THROTL_TG_PENDING) {
-		throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
+		struct throtl_service_queue *parent_sq =
+			tg->service_queue.parent_sq;
+
+		throtl_rb_erase(&tg->rb_node, parent_sq);
+		--parent_sq->nr_pending;
 		tg->flags &= ~THROTL_TG_PENDING;
 	}
 }
@@ -1040,9 +1043,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
 	disptime = jiffies + min_wait;
 
 	/* Update dispatch time */
-	throtl_dequeue_tg(tg);
+	throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
 	tg->disptime = disptime;
-	throtl_enqueue_tg(tg);
+	tg_service_queue_add(tg);
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
-- 
2.31.1

