Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E56735C5
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 11:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjASKjt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 05:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjASKjo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 05:39:44 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D31BDF;
        Thu, 19 Jan 2023 02:39:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NyJzD5rhpz4f3mLS;
        Thu, 19 Jan 2023 18:39:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHmHclj45hSBw--.55879S7;
        Thu, 19 Jan 2023 18:39:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 3/3] blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()
Date:   Thu, 19 Jan 2023 19:03:50 +0800
Message-Id: <20230119110350.2287325-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHmHclj45hSBw--.55879S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4DZr45ZF1xJFWUArWxtFb_yoWrAFy8pF
        ZxGFW3trWSgr4xZF45Xr17ur93Ka18KrWUGayxKayYkr4Yvr4vqFnrCrWkAFWxAFs7Jr43
        Ar1jgF1DKr4UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
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
blkg_destroy() to blkg_free_workfn(), and using a new disk level mutex to
synchronize blkg_free_workfn() and blkcg_deactivate_policy().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c     | 35 +++++++++++++++++++++++++++++------
 include/linux/blkdev.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 75f3c4460715..cb110fc51940 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -118,16 +118,32 @@ static void blkg_free_workfn(struct work_struct *work)
 {
 	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
 					     free_work);
+	struct request_queue *q = blkg->q;
 	int i;
 
+	/*
+	 * pd_free_fn() can also be called from blkcg_deactivate_policy(),
+	 * in order to make sure pd_free_fn() is called in order, the deletion
+	 * of the list blkg->q_node is delayed to here from blkg_destroy(), and
+	 * blkcg_mutex is used to synchronize blkg_free_workfn() and
+	 * blkcg_deactivate_policy().
+	 */
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
+		list_del_init(&blkg->q_node);
+		mutex_unlock(&q->blkcg_mutex);
+		blk_put_queue(q);
+	}
+
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -462,9 +478,14 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	lockdep_assert_held(&blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
 
-	/* Something wrong if we are trying to remove same group twice */
-	WARN_ON_ONCE(list_empty(&blkg->q_node));
-	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
+	/*
+	 * blkg stays on the queue list until blkg_free_workfn(), see details in
+	 * blkg_free_workfn(), hence this function can be called from
+	 * blkcg_destroy_blkgs() first and again from blkg_destroy_all() before
+	 * blkg_free_workfn().
+	 */
+	if (hlist_unhashed(&blkg->blkcg_node))
+		return;
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -479,7 +500,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	blkg->online = false;
 
 	radix_tree_delete(&blkcg->blkg_tree, blkg->q->id);
-	list_del_init(&blkg->q_node);
 	hlist_del_init_rcu(&blkg->blkcg_node);
 
 	/*
@@ -1280,6 +1300,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	int ret;
 
 	INIT_LIST_HEAD(&q->blkg_list);
+	mutex_init(&q->blkcg_mutex);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
@@ -1520,6 +1541,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
@@ -1538,6 +1560,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
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

