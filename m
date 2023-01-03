Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0921765BC1D
	for <lists+cgroups@lfdr.de>; Tue,  3 Jan 2023 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjACIX1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Jan 2023 03:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjACIX0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Jan 2023 03:23:26 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763291036;
        Tue,  3 Jan 2023 00:23:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NmQjH3z7yz4f3kpC;
        Tue,  3 Jan 2023 16:23:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rH05bNjFOASBA--.23491S4;
        Tue, 03 Jan 2023 16:23:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH] block, bfq: switch 'bfqg->ref' to use atomic refcount apis
Date:   Tue,  3 Jan 2023 16:47:55 +0800
Message-Id: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rH05bNjFOASBA--.23491S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfuw15JryDWrWDury3Arb_yoW8Zr1kpF
        n0qa45G34rGr1fXF4UAa4UXry8Jw1fCryrK3yqg3sYyry7Xw1Sg3Z0yrWrJ34SvF93ArWU
        Zr1Ygay0vr12qFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
during code review, we found that bfq_pd_free() update 'bfqg->ref'
without holding the lock, which is problematic:

1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
which can concurrent with 1).

Unfortunately, 'bfqd->lock' can't be held here because 'bfqd' might already
be freed in bfq_pd_free(). Fix the problem by using atomic refcount apis.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes from RFC:
 - refcount_dec_and_test(bfqg->ref) -> refcount_dec_and_test(&bfqg->ref)

 block/bfq-cgroup.c  | 8 +++-----
 block/bfq-iosched.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1b2829e99dad..7d9b15f0dbd5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 
 static void bfqg_get(struct bfq_group *bfqg)
 {
-	bfqg->ref++;
+	refcount_inc(&bfqg->ref);
 }
 
 static void bfqg_put(struct bfq_group *bfqg)
 {
-	bfqg->ref--;
-
-	if (bfqg->ref == 0)
+	if (refcount_dec_and_test(&bfqg->ref))
 		kfree(bfqg);
 }
 
@@ -530,7 +528,7 @@ static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
 	}
 
 	/* see comments in bfq_bic_update_cgroup for why refcounting */
-	bfqg_get(bfqg);
+	refcount_set(&bfqg->ref, 1);
 	return &bfqg->pd;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 41aa151ccc22..466e4865ace6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -928,7 +928,7 @@ struct bfq_group {
 	char blkg_path[128];
 
 	/* reference counter (see comments in bfq_bic_update_cgroup) */
-	int ref;
+	refcount_t ref;
 	/* Is bfq_group still online? */
 	bool online;
 
-- 
2.31.1

