Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF057B1090
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjI1CFT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 22:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CFS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 22:05:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C5AC;
        Wed, 27 Sep 2023 19:05:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RwxdH31Wpz4f3kGD;
        Thu, 28 Sep 2023 10:05:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdVU3xRlbOxHBg--.51493S4;
        Thu, 28 Sep 2023 10:05:09 +0800 (CST)
From:   linan666@huaweicloud.com
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] blk-throttle: Calculate allowed value only when the throttle is enabled
Date:   Thu, 28 Sep 2023 09:58:58 +0800
Message-Id: <20230928015858.1809934-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdVU3xRlbOxHBg--.51493S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DJr45Jw1DuFWUurW8Crg_yoW8uryDpF
        WfGr17Gr4aqF93KF43JasIvF15JrZ7Cr98J398X3sYyFWYk348Krn7ur40qFy2vF97Zayr
        J34jqr95AF42kaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF
        7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7IU1kpnJUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Nan <linan122@huawei.com>

When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX,
which is be used in calculate_bytes_allowed(), and divide 0 error will
happen.

To fix it, only calculate allowed value when the throttle of bps/iops is
enabled and the value will be used.

Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()")
Reported-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-throttle.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38a881cf97d0..3c9a74ab9f0e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -730,8 +730,10 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
 	unsigned long time_elapsed;
-	long long bytes_trim;
-	int io_trim;
+	long long bytes_trim = 0;
+	int io_trim = 0;
+	u64 bps_limit;
+	u32 iops_limit;
 
 	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
 
@@ -758,11 +760,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	if (!time_elapsed)
 		return;
 
-	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
-					     time_elapsed) +
-		     tg->carryover_bytes[rw];
-	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
-		  tg->carryover_ios[rw];
+	bps_limit = tg_bps_limit(tg, rw);
+	iops_limit = tg_iops_limit(tg, rw);
+	if (tg->bytes_disp[rw] > 0 && bps_limit != U64_MAX)
+		bytes_trim = calculate_bytes_allowed(bps_limit,
+			     time_elapsed) + tg->carryover_bytes[rw];
+	if (tg->io_disp[rw] > 0 && iops_limit != UINT_MAX)
+		io_trim = calculate_io_allowed(iops_limit, time_elapsed) +
+			  tg->carryover_ios[rw];
 	if (bytes_trim <= 0 && io_trim <= 0)
 		return;
 
-- 
2.39.2

