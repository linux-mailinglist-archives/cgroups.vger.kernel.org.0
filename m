Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6759CF54
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 05:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiHWDUM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiHWDUH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 23:20:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929434E603;
        Mon, 22 Aug 2022 20:20:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MBZF23YN0z6V2sG;
        Tue, 23 Aug 2022 11:18:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDXkO1fRwRj66O+Ag--.4888S6;
        Tue, 23 Aug 2022 11:20:03 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, ming.lei@redhat.com,
        mkoutny@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v8 2/4] blk-throttle: prevent overflow while calculating wait time
Date:   Tue, 23 Aug 2022 11:31:28 +0800
Message-Id: <20220823033130.874230-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220823033130.874230-1-yukuai1@huaweicloud.com>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXkO1fRwRj66O+Ag--.4888S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ur48GFy3JFW5uw4ftr4ruFg_yoW8GFW8pr
        WfGr40gF4rXF1fKF43Jan0va48Jws8JFW5G3y3Wan2yF90kr97XF9YvrWFva18AFZ29a1f
        Aw1Dtry7Ar1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There is a problem found by code review in tg_with_in_bps_limit() that
'bps_limit * jiffy_elapsed_rnd' might overflow. Fix the problem by
calling mul_u64_u64_div_u64() instead.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f3c9dcab63e2..773a355d3838 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -806,7 +806,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 				 u64 bps_limit, unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
-	u64 bytes_allowed, extra_bytes, tmp;
+	u64 bytes_allowed, extra_bytes;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
@@ -824,10 +824,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-
-	tmp = bps_limit * jiffy_elapsed_rnd;
-	do_div(tmp, HZ);
-	bytes_allowed = tmp;
+	bytes_allowed = mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed_rnd,
+					    (u64)HZ);
 
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
-- 
2.31.1

