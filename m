Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3877C552
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjHOBp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 21:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjHOBpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 21:45:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD210E3;
        Mon, 14 Aug 2023 18:45:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPvGL6z3hz4f40L7;
        Tue, 15 Aug 2023 09:44:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6mb2NpkdnTyAg--.15945S6;
        Tue, 15 Aug 2023 09:45:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 2/4] blk-throttle: fix wrong comparation while 'carryover_ios/bytes' is negative
Date:   Tue, 15 Aug 2023 09:41:21 +0800
Message-Id: <20230815014123.368929-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815014123.368929-1-yukuai1@huaweicloud.com>
References: <20230815014123.368929-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6mb2NpkdnTyAg--.15945S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkAF4xAry8WF17KF17ZFb_yoW5ArWrpr
        WfGF1IgF4rX3Z3tFnxJan8AFyrt39rAr98GrW3WayrCFn8GFyktrn5uFWFyayUZFs3uF4S
        kw1FqFn7AF4qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

carryover_ios/bytes[] can be negative in the case that ios are
dispatched in the slice in advance, and then configuration is updated.
For example:

1) set iops limit to 1000, and slice start is 0, slice end is 100ms;
2) current time is 0, and 100 ios are dispatched, those ios will not be
   throttled, hence io_disp is 100;
3) still at current time 0, update iops limit to 100, then carryover_ios
   is (0 - 100) = -100;
4) then, dispatch a new io at time 0, the expected result is that this
   io will wait for 1s. The calculation in tg_within_iops_limit:

   io_disp = 0;
   io_allowed = calculate_io_allowed + carryover_ios
	      = 10 + (-100) = -90;
   io won't be throttled if (io_disp + 1 < io_allowed) passed.

Before this patch, in step 4) (io_disp + 1 < io_allowed) is passed,
because -90 for unsigned value is very huge, and such io won't be
throttled.

Fix this problem by checking if 'io/bytes_allowed' is negative first.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5184f17f5129..7c93144d03da 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -825,7 +825,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 				 u32 iops_limit)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned int io_allowed;
+	int io_allowed;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 
 	if (iops_limit == UINT_MAX) {
@@ -838,9 +838,8 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
 		     tg->carryover_ios[rw];
-	if (tg->io_disp[rw] + 1 <= io_allowed) {
+	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
 		return 0;
-	}
 
 	/* Calc approx time to dispatch */
 	jiffy_wait = jiffy_elapsed_rnd - jiffy_elapsed;
@@ -851,7 +850,8 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 				u64 bps_limit)
 {
 	bool rw = bio_data_dir(bio);
-	u64 bytes_allowed, extra_bytes;
+	long long bytes_allowed;
+	u64 extra_bytes;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
@@ -869,9 +869,8 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
 			tg->carryover_bytes[rw];
-	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
+	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
 		return 0;
-	}
 
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-- 
2.39.2

