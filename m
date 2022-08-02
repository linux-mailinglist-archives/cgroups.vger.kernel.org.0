Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727E587D8C
	for <lists+cgroups@lfdr.de>; Tue,  2 Aug 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiHBNwp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Aug 2022 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiHBNwf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Aug 2022 09:52:35 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D527B14;
        Tue,  2 Aug 2022 06:52:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LxxGg0Q08zKPm2;
        Tue,  2 Aug 2022 21:51:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDXLsMQLOlivtl0AA--.20757S9;
        Tue, 02 Aug 2022 21:52:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v7 5/9] blk-throttle: improve handling of re-entered bio for bps limit
Date:   Tue,  2 Aug 2022 22:04:11 +0800
Message-Id: <20220802140415.2960284-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDXLsMQLOlivtl0AA--.20757S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43Zry7KFyxKw4DAFW8Zwb_yoW8uF17pF
        W7Xr95Gr1qgFnIgws5G3WfXFW5X3yrA345GrZ8G3W3JwnrGr1v9F1kGrWFk3yruF93Ca1k
        Xwn2qryxAF4UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, if new slice is started while bio is re-entered, such bio
will count multiple times for bps limit. Since 'bytes_skipped'
represents how many bytes will be skipped while dispatching bios, which
can handle that case, increasing it instead of decreasing 'bytes_disp'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 8 ++++----
 block/blk-throttle.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 621402cf2576..237668328e98 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2183,14 +2183,14 @@ bool __blk_throtl_bio(struct bio *bio)
 		 * Splited bios can be re-entered because iops limit should be
 		 * counted again, however, bps limit should not. Since bps limit
 		 * will be counted again while dispatching it, compensate the
-		 * over-accounting here. Noted that compensation can fail if
-		 * new slice is started.
+		 * over-accounting here. Since decrement of 'bytes_disp' can't
+		 * handle the case that new slice is started, increase
+		 * 'bytes_skipped' instead.
 		 */
 		if (bio_flagged(bio, BIO_THROTTLED)) {
 			unsigned int bio_size = throtl_bio_data_size(bio);
 
-			if (tg->bytes_disp[rw] >= bio_size)
-				tg->bytes_disp[rw] -= bio_size;
+			tg->bytes_skipped[rw] += bio_size;
 			if (tg->last_bytes_disp[rw] >= bio_size)
 				tg->last_bytes_disp[rw] -= bio_size;
 		}
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 0163aa9104c3..c9545616ba12 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -121,7 +121,9 @@ struct throtl_grp {
 	 * bytes/io are waited already in previous configuration, and they will
 	 * be used to calculate wait time under new configuration.
 	 *
-	 * Number of bytes will be skipped in current slice
+	 * Number of bytes will be skipped in current slice. In addition, this
+	 * field will help to handle re-entered bio for bps limit, see details
+	 * in __blk_throtl_bio().
 	 */
 	uint64_t bytes_skipped[2];
 	/* Number of bio will be skipped in current slice */
-- 
2.31.1

