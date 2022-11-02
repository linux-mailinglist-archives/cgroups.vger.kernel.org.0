Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFC615741
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKBCEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKBCED (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:04:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679A186C9;
        Tue,  1 Nov 2022 19:04:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N299p0BQBzl21b;
        Wed,  2 Nov 2022 10:01:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgCnP9QN0GFjGqzfBA--.48110S9;
        Wed, 02 Nov 2022 10:04:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next v4 5/5] block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
Date:   Wed,  2 Nov 2022 10:25:42 +0800
Message-Id: <20221102022542.3621219-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnP9QN0GFjGqzfBA--.48110S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UAFy5Wr47Gw4UCr45ZFb_yoW8tw43p3
        ZIq3WDWrWftrn3Wr4UA3Wjqr93twn3C34DKa4kX34avFy7trnFqan0yw18Z3W09FZxCrsr
        Z34j93ykZr17twUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

Prevent unnecessary format conversion for bfqg->bfqd in multiple
places.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Paolo Valente <paolo.valente@unimore.it>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 4c37398e0b99..d57872cc05ed 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 {
 	blkg_rwstat_add(&bfqg->stats.queued, opf, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+	if (!(bfqq == bfqg->bfqd->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 76363841d8ff..9fa89577322d 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -931,7 +931,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 4d4b84e7bf3e..b02b53658ed4 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -222,9 +222,8 @@ static void bfq_inc_active_entities(struct bfq_entity *entity)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
-	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
 
-	if (bfqg != bfqd->root_group)
+	if (bfqg != bfqg->bfqd->root_group)
 		bfqg->active_entities++;
 }
 
@@ -232,9 +231,8 @@ static void bfq_dec_active_entities(struct bfq_entity *entity)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_group *bfqg = container_of(sd, struct bfq_group, sched_data);
-	struct bfq_data *bfqd = (struct bfq_data *)bfqg->bfqd;
 
-	if (bfqg != bfqd->root_group)
+	if (bfqg != bfqg->bfqd->root_group)
 		bfqg->active_entities--;
 }
 
-- 
2.31.1

