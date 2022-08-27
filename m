Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B25A36DE
	for <lists+cgroups@lfdr.de>; Sat, 27 Aug 2022 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiH0KFY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Aug 2022 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiH0KFS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Aug 2022 06:05:18 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365213EB3;
        Sat, 27 Aug 2022 03:05:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MFC2d5WMrz6T2kQ;
        Sat, 27 Aug 2022 18:03:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgC3oLxY7AljpCKnAw--.52960S5;
        Sat, 27 Aug 2022 18:05:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 1/3] blk-throttle: use 'READ/WRITE' instead of '0/1'
Date:   Sat, 27 Aug 2022 18:16:35 +0800
Message-Id: <20220827101637.1775111-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220827101637.1775111-1-yukuai1@huaweicloud.com>
References: <20220827101637.1775111-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3oLxY7AljpCKnAw--.52960S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfGryDGw1rurykGFykKrg_yoW8JF4xp3
        45GF4rZa40qr4q9r9xKr47XayYga1kZrW3C393Ja1ayrW7JFnFqFn7ZF90va18AFn3Can0
        9r1DWrs8GF1UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

Make the code easier to read, like everywhere else.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9f5fe62afff9..fe1fa6441105 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -329,8 +329,8 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 /* init a service_queue, assumes the caller zeroed it */
 static void throtl_service_queue_init(struct throtl_service_queue *sq)
 {
-	INIT_LIST_HEAD(&sq->queued[0]);
-	INIT_LIST_HEAD(&sq->queued[1]);
+	INIT_LIST_HEAD(&sq->queued[READ]);
+	INIT_LIST_HEAD(&sq->queued[WRITE]);
 	sq->pending_tree = RB_ROOT_CACHED;
 	timer_setup(&sq->pending_timer, throtl_pending_timer_fn, 0);
 }
@@ -1106,7 +1106,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		nr_disp += throtl_dispatch_tg(tg);
 
 		sq = &tg->service_queue;
-		if (sq->nr_queued[0] || sq->nr_queued[1])
+		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
 			tg_update_disptime(tg);
 
 		if (nr_disp >= THROTL_QUANTUM)
-- 
2.31.1

