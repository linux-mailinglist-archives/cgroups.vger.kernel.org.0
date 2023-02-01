Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5F686580
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBALmS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBALmR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 06:42:17 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04985474D6;
        Wed,  1 Feb 2023 03:42:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6KlP6dxzz4f3nTl;
        Wed,  1 Feb 2023 19:42:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CESUNpjcwg6Cg--.7807S4;
        Wed, 01 Feb 2023 19:42:12 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] block, bfq: cleanup 'bfqg->online'
Date:   Wed,  1 Feb 2023 20:06:09 +0800
Message-Id: <20230201120609.4151432-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CESUNpjcwg6Cg--.7807S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxZF1xZr18JF1ktF4Utwb_yoW8Wr4kpF
        sFqF4UGa43tFn5XFW5C3WUXr1rtwn5u34DK3y8X34YyFy3Jrn29Fn0yw4rAFWIgF4fCFZ8
        Zw10grW8CF17K3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

After commit dfd6200a0954 ("blk-cgroup: support to track if policy is
online"), there is no need to do this again in bfq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 4 +---
 block/bfq-iosched.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b42956ab5550..a35136dae713 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -551,7 +551,6 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
 	bfqg->num_queues_with_pending_reqs = 0;
-	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
@@ -614,7 +613,7 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 			continue;
 		}
 		bfqg = blkg_to_bfqg(blkg);
-		if (bfqg->online) {
+		if (bfqg->pd.online) {
 			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
 			return bfqg;
 		}
@@ -985,7 +984,6 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 
 put_async_queues:
 	bfq_put_async_queues(bfqd, bfqg);
-	bfqg->online = false;
 
 	spin_unlock_irqrestore(&bfqd->lock, flags);
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 75cc6a324267..69aaee52285a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1009,8 +1009,6 @@ struct bfq_group {
 
 	/* reference counter (see comments in bfq_bic_update_cgroup) */
 	refcount_t ref;
-	/* Is bfq_group still online? */
-	bool online;
 
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
-- 
2.31.1

