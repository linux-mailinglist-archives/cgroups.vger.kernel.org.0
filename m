Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB385BFB37
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiIUJm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiIUJmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 05:42:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D48915E9;
        Wed, 21 Sep 2022 02:42:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXYLc47rQzlFXq;
        Wed, 21 Sep 2022 17:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgA3inN73CpjFoetBA--.3521S6;
        Wed, 21 Sep 2022 17:42:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 2/2] blk-throttle: improve bypassing bios checkings
Date:   Wed, 21 Sep 2022 17:53:09 +0800
Message-Id: <20220921095309.1481289-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inN73CpjFoetBA--.3521S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1ktr1rtF4xKw4xWr15Arb_yoW5Xw47pF
        W7uF45Gr4jvFsxuwnxJF13XFW5Za97WrWSy395Xa1SyF43Kr93XFn5ZryUZaySvFZ3ua18
        Zr42krWkCF1jgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

"tg->has_rules" is extended to "tg->has_rules_iops/bps", thus bios that
don't need to be throttled can be checked accurately.

With this patch, bio will be throttled if:

1) Bio is read/write, and corresponding read/write iops limit exist.
2) If corresponding doesn't exist, corresponding bps limit exist and
bio is not throttled before.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 13 +++++++++----
 block/blk-throttle.h | 22 +++++++++++++++++++---
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a062539d84d0..78316955e30f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -421,11 +421,16 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 	struct throtl_data *td = tg->td;
 	int rw;
 
-	for (rw = READ; rw <= WRITE; rw++)
-		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
+	for (rw = READ; rw <= WRITE; rw++) {
+		tg->has_rules_iops[rw] =
+			(parent_tg && parent_tg->has_rules_iops[rw]) ||
 			(td->limit_valid[td->limit_index] &&
-			 (tg_bps_limit(tg, rw) != U64_MAX ||
-			  tg_iops_limit(tg, rw) != UINT_MAX));
+			  tg_iops_limit(tg, rw) != UINT_MAX);
+		tg->has_rules_bps[rw] =
+			(parent_tg && parent_tg->has_rules_bps[rw]) ||
+			(td->limit_valid[td->limit_index] &&
+			 (tg_bps_limit(tg, rw) != U64_MAX));
+	}
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 3994b89dfa11..69f00012d616 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -98,7 +98,8 @@ struct throtl_grp {
 	unsigned int flags;
 
 	/* are there any throtl rules between this group and td? */
-	bool has_rules[2];
+	bool has_rules_bps[2];
+	bool has_rules_iops[2];
 
 	/* internally used bytes per second rate limits */
 	uint64_t bps[2][LIMIT_CNT];
@@ -178,11 +179,26 @@ void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
 bool __blk_throtl_bio(struct bio *bio);
 void blk_throtl_cancel_bios(struct request_queue *q);
-static inline bool blk_throtl_bio(struct bio *bio)
+
+static inline bool blk_should_throtl(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
+	int rw = bio_data_dir(bio);
+
+	/* iops limit is always counted */
+	if (tg->has_rules_iops[rw])
+		return true;
+
+	if (tg->has_rules_bps[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))
+		return true;
+
+	return false;
+}
+
+static inline bool blk_throtl_bio(struct bio *bio)
+{
 
-	if (!tg->has_rules[bio_data_dir(bio)])
+	if (!blk_should_throtl(bio))
 		return false;
 
 	return __blk_throtl_bio(bio);
-- 
2.31.1

