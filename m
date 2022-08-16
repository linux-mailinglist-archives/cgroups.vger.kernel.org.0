Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007605952DA
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 08:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiHPGqJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHPGpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 02:45:45 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBBFF201;
        Mon, 15 Aug 2022 18:44:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M6DSY1Cj1z6S2yM;
        Tue, 16 Aug 2022 09:43:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnu_iS9vpicjqdAQ--.63281S5;
        Tue, 16 Aug 2022 09:44:52 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 1/3] block, bfq: remove unused functions
Date:   Tue, 16 Aug 2022 09:56:29 +0800
Message-Id: <20220816015631.1323948-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
References: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnu_iS9vpicjqdAQ--.63281S5
X-Coremail-Antispam: 1UD129KBjvJXoWxur1rGryxKFykWw1kArW5Wrg_yoW5ury5pw
        43K3Wktr15Jwn5Wr45J3WUu3s3Kws5CwnFga97X34rCFsrtrnagF1qyr1rZry0vr95Cr4U
        Z3WjvrWkAryI9FUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

While doing code coverage testing(CONFIG_BFQ_CGROUP_DEBUG is disabled), we
found that some functions doesn't have caller, thus remove them.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c  |  5 -----
 block/bfq-iosched.h | 13 ++++++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 30b15a9a47c4..144bca006463 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -254,17 +254,12 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 
 #else /* CONFIG_BFQ_CGROUP_DEBUG */
 
-void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      blk_opf_t opf) { }
 void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf) { }
 void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf) { }
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 				  u64 io_start_time_ns, blk_opf_t opf) { }
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
-void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
-void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
 void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
-void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
 
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ad8e513d7e87..f81ab3c8fa3c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -993,20 +993,23 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 /* ---------------- cgroups-support interface ---------------- */
 
 void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
-void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      blk_opf_t opf);
 void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf);
 void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf);
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 				  u64 io_start_time_ns, blk_opf_t opf);
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
-void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
-void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
 void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg);
-void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg);
 void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg);
 
+#ifdef CONFIG_BFQ_CGROUP_DEBUG
+void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
+			      blk_opf_t opf);
+void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
+void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
+void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg);
+#endif
+
 void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
 void bfq_end_wr_async(struct bfq_data *bfqd);
-- 
2.31.1

