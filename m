Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0DF5BFB36
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiIUJm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIUJmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 05:42:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0A915CE;
        Wed, 21 Sep 2022 02:42:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXYLc1PwyzlDwy;
        Wed, 21 Sep 2022 17:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgA3inN73CpjFoetBA--.3521S5;
        Wed, 21 Sep 2022 17:42:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 1/2] blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
Date:   Wed, 21 Sep 2022 17:53:08 +0800
Message-Id: <20220921095309.1481289-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
References: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inN73CpjFoetBA--.3521S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCw48Ww4xtrWDGF45ArWfuFg_yoW5Xr1rpF
        yxCr1UCr4jqrnrWr4rJ3W7uFWFvrWDJrWrJrZ8XayFyFyakr92qrn5Zry8Z3yfZF9I9w4j
        vF4Ut34kAa17uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, "tg->has_rules" and "tg->flags & THROTL_TG_HAS_IOPS_LIMIT"
both try to bypass bios that don't need to be throttled, however, they are
a little redundant and both not perfect:

1) "tg->has_rules" only distinguish read and write, but not iops and bps
   limit.
2) "tg->flags & THROTL_TG_HAS_IOPS_LIMIT" only check if iops limit
   exist, read and write is not distinguished, and bps limit is not
   checked.

tg->has_rules will extended to distinguish bps and iops in the following
patch. There is no need to keep the flag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 16 ++--------------
 block/blk-throttle.h |  8 +-------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 55f2d985cfbb..a062539d84d0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -420,24 +420,12 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
 	struct throtl_data *td = tg->td;
 	int rw;
-	int has_iops_limit = 0;
-
-	for (rw = READ; rw <= WRITE; rw++) {
-		unsigned int iops_limit = tg_iops_limit(tg, rw);
 
+	for (rw = READ; rw <= WRITE; rw++)
 		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
 			(td->limit_valid[td->limit_index] &&
 			 (tg_bps_limit(tg, rw) != U64_MAX ||
-			  iops_limit != UINT_MAX));
-
-		if (iops_limit != UINT_MAX)
-			has_iops_limit = 1;
-	}
-
-	if (has_iops_limit)
-		tg->flags |= THROTL_TG_HAS_IOPS_LIMIT;
-	else
-		tg->flags &= ~THROTL_TG_HAS_IOPS_LIMIT;
+			  tg_iops_limit(tg, rw) != UINT_MAX));
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 66b4292b1b92..3994b89dfa11 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -55,8 +55,7 @@ struct throtl_service_queue {
 enum tg_state_flags {
 	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
 	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
-	THROTL_TG_CANCELING	= 1 << 3,	/* starts to cancel bio */
+	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
 };
 
 enum {
@@ -183,11 +182,6 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
-	/* no need to throttle bps any more if the bio has been throttled */
-	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
-	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
-		return false;
-
 	if (!tg->has_rules[bio_data_dir(bio)])
 		return false;
 
-- 
2.31.1

