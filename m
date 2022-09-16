Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF855BA72D
	for <lists+cgroups@lfdr.de>; Fri, 16 Sep 2022 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIPHIz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Sep 2022 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIPHIx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Sep 2022 03:08:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257DA3D28;
        Fri, 16 Sep 2022 00:08:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTQ9r0mGfzlCNJ;
        Fri, 16 Sep 2022 15:07:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXP9ICRj02qwAw--.33483S6;
        Fri, 16 Sep 2022 15:08:49 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [patch v11 2/6] block, bfq: record how many queues have pending requests
Date:   Fri, 16 Sep 2022 15:19:38 +0800
Message-Id: <20220916071942.214222-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXP9ICRj02qwAw--.33483S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45tr1kWFWDGF1kGFyDZFb_yoW5ZFWxpa
        98K3WUZr43Jrn5XrW5Ca10qwn7X3s5Zr9rtrWvv34Yyr47JrySv3ZIyr1Fvr109F1fGF43
        Zr1Y9ryDuw17GFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
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

Prepare to refactor the counting of 'num_groups_with_pending_reqs'.

Add a counter in bfq_group, update it while tracking if bfqq have pending
requests and when bfq_bfqq_move() is called.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 10 ++++++++++
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 12 ++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 144bca006463..4c37398e0b99 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -552,6 +552,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 				   */
 	bfqg->bfqd = bfqd;
 	bfqg->active_entities = 0;
+	bfqg->num_queues_with_pending_reqs = 0;
 	bfqg->online = true;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
@@ -641,6 +642,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_group *old_parent = bfqq_group(bfqq);
+	bool has_pending_reqs = false;
 
 	/*
 	 * No point to move bfqq to the same group, which can happen when
@@ -661,6 +663,11 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 */
 	bfqq->ref++;
 
+	if (entity->in_groups_with_pending_reqs) {
+		has_pending_reqs = true;
+		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
+	}
+
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
 	 * from data structures related to current group. Otherwise we
@@ -688,6 +695,9 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
 
+	if (has_pending_reqs)
+		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
+
 	if (bfq_bfqq_busy(bfqq)) {
 		if (unlikely(!bfqd->nonrot_with_queueing))
 			bfq_pos_tree_add_move(bfqd, bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 44e08b194749..338ff5418ea8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -943,6 +943,7 @@ struct bfq_group {
 	struct bfq_entity *my_entity;
 
 	int active_entities;
+	int num_queues_with_pending_reqs;
 
 	struct rb_root rq_pos_tree;
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index bd8f4ed84848..5549ccf09cd2 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1650,16 +1650,24 @@ void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (!entity->in_groups_with_pending_reqs)
+	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
+#endif
+	}
 }
 
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
-	if (entity->in_groups_with_pending_reqs)
+	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
+#endif
+	}
 }
 
 /*
-- 
2.31.1

