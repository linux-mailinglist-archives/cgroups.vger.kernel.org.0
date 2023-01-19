Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A56735BC
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjASKjp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 05:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjASKjn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 05:39:43 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B727AA2;
        Thu, 19 Jan 2023 02:39:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NyJzD3K79z4f41P5;
        Thu, 19 Jan 2023 18:39:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHmHclj45hSBw--.55879S6;
        Thu, 19 Jan 2023 18:39:38 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 2/3] blk-cgroup: support to track if policy is online
Date:   Thu, 19 Jan 2023 19:03:49 +0800
Message-Id: <20230119110350.2287325-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHmHclj45hSBw--.55879S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfurWxWFy7GFy7Gry3urg_yoWrGr47pF
        43Kry5J34Ivr18CFWjv3WUuryaga1rt345AFWfCws0kF17trnrZ3WDZayDArZayFZruF45
        WF18tayUKw45CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
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

A new field 'online' is added to blkg_policy_data to fix following
2 problem:

1) In blkcg_activate_policy(), if pd_alloc_fn() with 'GFP_NOWAIT'
   failed, 'queue_lock' will be dropped and pd_alloc_fn() will try again
   without 'GFP_NOWAIT'. In the meantime, remove cgroup can race with
   it, and pd_offline_fn() will be called without pd_init_fn() and
   pd_online_fn(). This way null-ptr-deference can be triggered.

2) In order to synchronize pd_free_fn() from blkg_free_workfn() and
   blkcg_deactivate_policy(), 'list_del_init(&blkg->q_node)' will be
   delayed to blkg_free_workfn(), hence pd_offline_fn() can be called
   first in blkg_destroy(), and then blkcg_deactivate_policy() will
   call it again, we must prevent it.

The new field 'online' will be set after pd_online_fn() and will be
cleared after pd_offline_fn(), in the meantime pd_offline_fn() will only
be called if 'online' is set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 24 +++++++++++++++++-------
 block/blk-cgroup.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c6d7d1fce65a..75f3c4460715 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -288,6 +288,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -359,8 +360,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i]) {
+				if (pol->pd_online_fn)
+					pol->pd_online_fn(blkg->pd[i]);
+				blkg->pd[i]->online = true;
+			}
 		}
 	}
 	blkg->online = true;
@@ -465,8 +469,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i] && blkg->pd[i]->online) {
+			if (pol->pd_offline_fn)
+				pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd[i]->online = false;
+		}
 	}
 
 	blkg->online = false;
@@ -1448,6 +1455,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1455,9 +1463,11 @@ int blkcg_activate_policy(struct request_queue *q,
 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	if (pol->pd_online_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid]->online = true;
+	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
@@ -1519,7 +1529,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1e94e404eaa8..b13ee84f358e 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -135,6 +135,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
-- 
2.31.1

