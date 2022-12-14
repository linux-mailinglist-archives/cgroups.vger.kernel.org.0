Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3028D64C28E
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 04:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiLNDLR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 22:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiLNDLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 22:11:14 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E942AE6;
        Tue, 13 Dec 2022 19:11:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NX0kN0kgQz4f3pFb;
        Wed, 14 Dec 2022 11:11:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDHONbMPpljNSzJCA--.62944S6;
        Wed, 14 Dec 2022 11:11:11 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 2/2] block, bfq: replace 0/1 with false/true in bic apis
Date:   Wed, 14 Dec 2022 11:31:55 +0800
Message-Id: <20221214033155.3455754-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
References: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONbMPpljNSzJCA--.62944S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUJryrtFWfKFW5Cr1DGFg_yoW8ZFyfp3
        ZFqwsruw18Xr4rXr1UG3WqqF1xJ3Z5A34vyFy3X3yavry7WrnFqF4qv348Zrs2grs3CrW3
        Zry09ayvqr13GrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU=
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

Just to make the code a litter cleaner, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  | 8 ++++----
 block/bfq-iosched.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 23dc355a106d..1b2829e99dad 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -728,15 +728,15 @@ static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				    struct bfq_io_cq *bic,
 				    struct bfq_group *bfqg)
 {
-	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
-	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
+	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, false);
+	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, true);
 	struct bfq_entity *entity;
 
 	if (async_bfqq) {
 		entity = &async_bfqq->entity;
 
 		if (entity->sched_data != &bfqg->sched_data) {
-			bic_set_bfqq(bic, NULL, 0);
+			bic_set_bfqq(bic, NULL, false);
 			bfq_release_process_ref(bfqd, async_bfqq);
 		}
 	}
@@ -772,7 +772,7 @@ static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				 */
 				bfq_put_cooperator(sync_bfqq);
 				bfq_release_process_ref(bfqd, sync_bfqq);
-				bic_set_bfqq(bic, NULL, 1);
+				bic_set_bfqq(bic, NULL, true);
 			}
 		}
 	}
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b111a7b8dca6..dc576b90ddfe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3114,7 +3114,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	/*
 	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
 	 */
-	bic_set_bfqq(bic, new_bfqq, 1);
+	bic_set_bfqq(bic, new_bfqq, true);
 	bfq_mark_bfqq_coop(new_bfqq);
 	/*
 	 * new_bfqq now belongs to at least two bics (it is a shared queue):
@@ -6562,7 +6562,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 		return bfqq;
 	}
 
-	bic_set_bfqq(bic, NULL, 1);
+	bic_set_bfqq(bic, NULL, true);
 
 	bfq_put_cooperator(bfqq);
 
-- 
2.31.1

