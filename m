Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174659CF58
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiHWDUK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiHWDUH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 23:20:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22184F6B7;
        Mon, 22 Aug 2022 20:20:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MBZF26vjlz6V2tg;
        Tue, 23 Aug 2022 11:18:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDXkO1fRwRj66O+Ag--.4888S7;
        Tue, 23 Aug 2022 11:20:04 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, ming.lei@redhat.com,
        mkoutny@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v8 3/4] blk-throttle: factor out code to calculate ios/bytes_allowed
Date:   Tue, 23 Aug 2022 11:31:29 +0800
Message-Id: <20220823033130.874230-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220823033130.874230-1-yukuai1@huaweicloud.com>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXkO1fRwRj66O+Ag--.4888S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DWw13XFy7uFy5CrW7Arb_yoWrCry5pr
        WfGr1jqF4rXF4xtF13JwsIkayrAw1kCFyUJ3y3Wa4vyF15uFykJFn3ZrW0yay7ZF97ua1x
        Zw1qq3ZrCF4DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
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
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
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

No functional changes, new apis will be used in later patches to
calculate wait time for throttled bios when new configuration is
submitted.

Noted this patch also rename tg_with_in_iops/bps_limit() to
tg_within_iops/bps_limit().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 59 ++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 773a355d3838..757b620f0f2d 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -754,33 +754,20 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
 }
 
-static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
-				  u32 iops_limit, unsigned long *wait)
+static unsigned int calculate_io_allowed(u32 iops_limit,
+					 unsigned long jiffy_elapsed)
 {
-	bool rw = bio_data_dir(bio);
 	unsigned int io_allowed;
-	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
-	if (iops_limit == UINT_MAX || bio_flagged(bio, BIO_IOPS_THROTTLED)) {
-		if (wait)
-			*wait = 0;
-		return true;
-	}
-
-	jiffy_elapsed = jiffies - tg->slice_start[rw];
-
-	/* Round up to the next throttle slice, wait time must be nonzero */
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
-
 	/*
-	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
+	 * jiffy_elapsed should not be a big value as minimum iops can be
 	 * 1 then at max jiffy elapsed should be equivalent of 1 second as we
 	 * will allow dispatch after 1 second and after that slice should
 	 * have been trimmed.
 	 */
 
-	tmp = (u64)iops_limit * jiffy_elapsed_rnd;
+	tmp = (u64)iops_limit * jiffy_elapsed;
 	do_div(tmp, HZ);
 
 	if (tmp > UINT_MAX)
@@ -788,6 +775,32 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	else
 		io_allowed = tmp;
 
+	return io_allowed;
+}
+
+static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
+{
+	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
+}
+
+static bool tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
+				 u32 iops_limit, unsigned long *wait)
+{
+	bool rw = bio_data_dir(bio);
+	unsigned int io_allowed;
+	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
+
+	if (iops_limit == UINT_MAX || bio_flagged(bio, BIO_IOPS_THROTTLED)) {
+		if (wait)
+			*wait = 0;
+		return true;
+	}
+
+	jiffy_elapsed = jiffies - tg->slice_start[rw];
+
+	/* Round up to the next throttle slice, wait time must be nonzero */
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
+	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
 	if (tg->io_disp[rw] + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
@@ -802,8 +815,8 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	return false;
 }
 
-static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
-				 u64 bps_limit, unsigned long *wait)
+static bool tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
+				u64 bps_limit, unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
 	u64 bytes_allowed, extra_bytes;
@@ -824,9 +837,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 		jiffy_elapsed_rnd = tg->td->throtl_slice;
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
-	bytes_allowed = mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed_rnd,
-					    (u64)HZ);
-
+	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
 	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
@@ -895,8 +906,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 				jiffies + tg->td->throtl_slice);
 	}
 
-	if (tg_with_in_bps_limit(tg, bio, bps_limit, &bps_wait) &&
-	    tg_with_in_iops_limit(tg, bio, iops_limit, &iops_wait)) {
+	if (tg_within_bps_limit(tg, bio, bps_limit, &bps_wait) &&
+	    tg_within_iops_limit(tg, bio, iops_limit, &iops_wait)) {
 		if (wait)
 			*wait = 0;
 		return true;
-- 
2.31.1

