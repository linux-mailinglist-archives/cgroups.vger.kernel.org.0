Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370A064C28B
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 04:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiLNDLQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 22:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiLNDLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 22:11:14 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038432BEB;
        Tue, 13 Dec 2022 19:11:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NX0kM3QQwz4f3jMX;
        Wed, 14 Dec 2022 11:11:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDHONbMPpljNSzJCA--.62944S5;
        Wed, 14 Dec 2022 11:11:10 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 1/2] block, bfq: don't return bfqg from __bfq_bic_change_cgroup()
Date:   Wed, 14 Dec 2022 11:31:54 +0800
Message-Id: <20221214033155.3455754-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
References: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONbMPpljNSzJCA--.62944S5
X-Coremail-Antispam: 1UD129KBjvdXoWruFyktFWfZF47tw1UtFyUGFg_yoWkWrg_Aa
        s5K3W8tryUAFyfJr1qyrnIya92k3y3XwsruF15K3sxXF1DJa95Awnrtr47Wrs5uF48GF9x
        Zr98Ww4xJF4IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
        IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5SoXUUUUU
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

The return value is not used, hence remove it.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 627476bc6495..23dc355a106d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -724,9 +724,9 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * sure that the reference to cgroup is valid across the call (see
  * comments in bfq_bic_update_cgroup on this issue)
  */
-static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
-				     struct bfq_io_cq *bic,
-				     struct bfq_group *bfqg)
+static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic,
+				    struct bfq_group *bfqg)
 {
 	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
 	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
@@ -776,8 +776,6 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 			}
 		}
 	}
-
-	return bfqg;
 }
 
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
-- 
2.31.1

