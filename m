Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A6671C75
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 13:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjARMpd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 07:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjARMn2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 07:43:28 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5610ABE;
        Wed, 18 Jan 2023 04:07:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NxkzD0qL4z4f3p1W;
        Wed, 18 Jan 2023 20:07:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR8G4cdjY2MdBw--.48220S7;
        Wed, 18 Jan 2023 20:07:38 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 3/3] blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()
Date:   Wed, 18 Jan 2023 20:31:52 +0800
Message-Id: <20230118123152.1926314-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
References: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR8G4cdjY2MdBw--.48220S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DZr45ZF1xGryrGFy3urg_yoWrWF48pF
        ZxGFZxtrWSgr4xZF45Wr17ur93Ka18KrWUGayxKay5Cr4Yvr4vqFnrZFWkAFWxAF4kJr43
        Ar4jgFs8Kr4UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
        =
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

Currently parent pd can be freed before child pd:

t1: remove cgroup C1
blkcg_destroy_blkgs
 blkg_destroy
  list_del_init(&blkg->q_node)
  // remove blkg from queue list
  percpu_ref_kill(&blkg->refcnt)
   blkg_release
    call_rcu

t2: from t1
__blkg_release
 blkg_free
  schedule_work
			t4: deactivate policy
			blkcg_deactivate_policy
			 pd_free_fn
			 // parent of C1 is freed first
t3: from t2
 blkg_free_workfn
  pd_free_fn

If policy(for example, ioc_timer_fn() from iocost) access parent pd from
child pd after pd_offline_fn(), then UAF can be triggered.

Fix the problem by delaying 'list_del_init(&blkg->q_node)' from
blkg_destroy() to blkg_free_workfn(), and use a new disk level mutex to
protect blkg_free_workfn() and blkcg_deactivate_policy).

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c     | 33 +++++++++++++++++++++++++++------
 include/linux/blkdev.h |  1 +
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 75f3c4460715..4098e8030e01 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -118,16 +118,26 @@ static void blkg_free_workfn(struct work_struct *work)
 {
 	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
 					     free_work);
+	struct request_queue *q = blkg->q;
 	int i;
 
+	if (q)
+		mutex_lock(&q->blkcg_mutex);
+
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
 	if (blkg->parent)
 		blkg_put(blkg->parent);
-	if (blkg->q)
-		blk_put_queue(blkg->q);
+
+	if (q) {
+		if (!list_empty(&blkg->q_node))
+			list_del_init(&blkg->q_node);
+		mutex_unlock(&q->blkcg_mutex);
+		blk_put_queue(q);
+	}
+
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -462,9 +472,14 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	lockdep_assert_held(&blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
 
-	/* Something wrong if we are trying to remove same group twice */
-	WARN_ON_ONCE(list_empty(&blkg->q_node));
-	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
+	/*
+	 * blkg is removed from queue list in blkg_free_workfn(), hence this
+	 * function can be called from blkcg_destroy_blkgs() first, and then
+	 * before blkg_free_workfn(), this function can be called again in
+	 * blkg_destroy_all().
+	 */
+	if (hlist_unhashed(&blkg->blkcg_node))
+		return;
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -478,8 +493,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	blkg->online = false;
 
+	/*
+	 * Delay deleting list blkg->q_node to blkg_free_workfn() to synchronize
+	 * pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy().
+	 */
 	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
-	list_del_init(&blkg->q_node);
 	hlist_del_init_rcu(&blkg->blkcg_node);
 
 	/*
@@ -1280,6 +1298,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	int ret;
 
 	INIT_LIST_HEAD(&q->blkg_list);
+	mutex_init(&q->blkcg_mutex);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1520,6 +1539,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
@@ -1538,6 +1558,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	}
 
 	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b87ed829ab94..53ae0a7fe377 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -485,6 +485,7 @@ struct request_queue {
 	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
 	struct blkcg_gq		*root_blkg;
 	struct list_head	blkg_list;
+	struct mutex		blkcg_mutex;
 #endif
 
 	struct queue_limits	limits;
-- 
2.31.1

