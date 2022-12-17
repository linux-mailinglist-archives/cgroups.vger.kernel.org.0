Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A6064F731
	for <lists+cgroups@lfdr.de>; Sat, 17 Dec 2022 03:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiLQCse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 21:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiLQCsc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 21:48:32 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E4A453;
        Fri, 16 Dec 2022 18:48:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYr4n1m64z4f3lXl;
        Sat, 17 Dec 2022 10:48:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9j5LZ1jmxh7CQ--.11469S8;
        Sat, 17 Dec 2022 10:48:28 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 4/4] blk-cgroup: synchronize del_gendisk() with configuring cgroup policy
Date:   Sat, 17 Dec 2022 11:09:08 +0800
Message-Id: <20221217030908.1261787-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9j5LZ1jmxh7CQ--.11469S8
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DZrykJF4kCw4rXrW3Awb_yoW5Jw18pa
        9IgF13CrWIgrsrZa1DGa1fZrsavw40gr1fA3yfA3yayrW7Kr1IvF1kAF9rZrWfZFsxJrsx
        Xr4FgrZ0kr1UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
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

iocost is initialized when it's configured the first time, and iocost
initializing can race with del_gendisk(), which will cause null pointer
dereference:

t1				t2
ioc_qos_write
 blk_iocost_init
  rq_qos_add
  				del_gendisk
  				 rq_qos_exit
  				 //iocost is removed from q->roqs
  blkcg_activate_policy
   pd_init_fn
    ioc_pd_init
     ioc = q_to_ioc(blkg->q)
     //can't find iocost and return null

Fix the problem by adding a new mutex in request_queue, and use it to
synchronize rq_qos_exit() from del_gendisk() with configuring cgroup
policy.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c     | 3 +++
 block/blk-rq-qos.c     | 8 ++++++++
 include/linux/blkdev.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ad612148cf3b..8dcdaacb52a1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -658,12 +658,14 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
 		return ERR_PTR(-ENODEV);
 	}
 
+	mutex_lock(&bdev->bd_queue->blkcg_pols_lock);
 	*inputp = input;
 	return bdev;
 }
 
 void blkcg_conf_close_bdev(struct block_device *bdev)
 {
+	mutex_unlock(&bdev->bd_queue->blkcg_pols_lock);
 	blkdev_put_no_open(bdev);
 }
 
@@ -1277,6 +1279,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	int ret;
 
 	INIT_LIST_HEAD(&q->blkg_list);
+	mutex_init(&q->blkcg_pols_lock);
 
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index efffc6fa55db..86bccdfa1a43 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -290,6 +290,10 @@ void rq_qos_exit(struct request_queue *q)
 {
 	struct rq_qos *rqos;
 
+#ifdef CONFIG_BLK_CGROUP
+	mutex_lock(&q->blkcg_pols_lock);
+#endif
+
 	spin_lock_irq(&q->queue_lock);
 	rqos = q->rq_qos;
 	q->rq_qos = NULL;
@@ -300,4 +304,8 @@ void rq_qos_exit(struct request_queue *q)
 			rqos->ops->exit(rqos);
 		rqos = rqos->next;
 	} while (rqos);
+
+#ifdef CONFIG_BLK_CGROUP
+	mutex_unlock(&q->blkcg_pols_lock);
+#endif
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 301cf1cf4f2f..824d68a41a83 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -484,6 +484,7 @@ struct request_queue {
 	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
 	struct blkcg_gq		*root_blkg;
 	struct list_head	blkg_list;
+	struct mutex		blkcg_pols_lock;
 #endif
 
 	struct queue_limits	limits;
-- 
2.31.1

