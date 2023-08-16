Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DE77D7B0
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbjHPBa5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbjHPBay (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 21:30:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C42121;
        Tue, 15 Aug 2023 18:30:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVvY6Zh1z4f3q3b;
        Wed, 16 Aug 2023 09:30:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KbHJtxkQuVAAw--.55976S6;
        Wed, 16 Aug 2023 09:30:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 2/4] blk-throttle: fix wrong comparation while 'carryover_ios/bytes' is negative
Date:   Wed, 16 Aug 2023 09:27:06 +0800
Message-Id: <20230816012708.1193747-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KbHJtxkQuVAAw--.55976S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkAF4xAry8WF17KF17ZFb_yoW5ArWrpr
        WfGF1IgF4rX3Z3tFnxJan8AFyrt39rAr98GrW3WayrCFn8GFyktrn5uFWFyayUZFs3uF4S
        kw1FqFn7AF4qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
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

