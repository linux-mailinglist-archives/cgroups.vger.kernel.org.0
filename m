Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB577C557
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 03:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjHOBp1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHOBpI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 21:45:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C76F120;
        Mon, 14 Aug 2023 18:45:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPvGR03t4z4f4cWN;
        Tue, 15 Aug 2023 09:45:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6mb2NpkdnTyAg--.15945S8;
        Tue, 15 Aug 2023 09:45:02 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 4/4] blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()
Date:   Tue, 15 Aug 2023 09:41:23 +0800
Message-Id: <20230815014123.368929-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815014123.368929-1-yukuai1@huaweicloud.com>
References: <20230815014123.368929-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6mb2NpkdnTyAg--.15945S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3ZF47Zw43Ww13trW8WFg_yoW5Xw43pF
        WftFsrtwsFqFnxK3ZxZ3Z7Z3Wjy3yDAryDGrW5tw4fAF90kryrKr10krZ5tay2yF97CFWx
        J348ur9rAr4qkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

Currently, 'carryover_ios/bytes' is not handled in throtl_trim_slice(),
for consequence, 'carryover_ios/bytes' will be used to throttle bio
multiple times, for example:

1) set iops limit to 100, and slice start is 0, slice end is 100ms;
2) current time is 0, and 10 ios are dispatched, those io won't be
   throttled and io_disp is 10;
3) still at current time 0, update iops limit to 1000, carryover_ios is
   updated to (0 - 10) = -10;
4) in this slice(0 - 100ms), io_allowed = 100 + (-10) = 90, which means
   only 90 ios can be dispatched without waiting;
5) assume that io is throttled in slice(0 - 100ms), and
   throtl_trim_slice() update silce to (100ms - 200ms). In this case,
   'carryover_ios/bytes' is not cleared and still only 90 ios can be
   dispatched between 100ms - 200ms.

Fix this problem by updating 'carryover_ios/bytes' in
throtl_trim_slice().

Fixes: a880ae93e5b5 ("blk-throttle: fix io hung due to configuration updates")
Reported-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
Link: https://lore.kernel.org/all/20230812072116.42321-1-zhuxiaohui.400@bytedance.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e5296960c799..75b4a78c1e45 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -729,8 +729,9 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
-	unsigned long time_elapsed, io_trim;
-	u64 bytes_trim;
+	unsigned long time_elapsed;
+	long long bytes_trim;
+	int io_trim;
 
 	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
 
@@ -758,17 +759,21 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		return;
 
 	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
-					     time_elapsed);
-	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
-	if (!bytes_trim && !io_trim)
+					     time_elapsed) +
+		     tg->carryover_bytes[rw];
+	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
+		  tg->carryover_ios[rw];
+	if (bytes_trim <= 0 && io_trim <= 0)
 		return;
 
-	if (tg->bytes_disp[rw] >= bytes_trim)
+	tg->carryover_bytes[rw] = 0;
+	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
 		tg->bytes_disp[rw] -= bytes_trim;
 	else
 		tg->bytes_disp[rw] = 0;
 
-	if (tg->io_disp[rw] >= io_trim)
+	tg->carryover_ios[rw] = 0;
+	if ((int)tg->io_disp[rw] >= io_trim)
 		tg->io_disp[rw] -= io_trim;
 	else
 		tg->io_disp[rw] = 0;
-- 
2.39.2

