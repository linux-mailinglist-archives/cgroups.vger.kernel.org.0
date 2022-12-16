Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FE64E63F
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 04:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLPDNn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 22:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLPDNg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 22:13:36 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0DF2A715;
        Thu, 15 Dec 2022 19:13:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYDhB07bVz4f4GD9;
        Fri, 16 Dec 2022 11:13:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXiNVW4ptjHYxACQ--.50238S11;
        Fri, 16 Dec 2022 11:13:32 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang@26.com, shikemeng@huaweicloud.com
Subject: [PATCH v2 09/10] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
Date:   Fri, 16 Dec 2022 19:12:29 +0800
Message-Id: <20221216111230.3638832-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
References: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXiNVW4ptjHYxACQ--.50238S11
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUJw1kCr15GFyUtw4rAFb_yoW8WF15pa
        nrK347WF17Kr4FgF1DAa4rXFnxta13uF9rKa1a9w4YyFW8XF1a93ZYyw1fX3Z2vFZ3Cr4f
        Zw4Fqa4Dtw18K3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
        8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
        CTnIWIevJa73UjIFyTuYvjTRKfOwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

bfqd->bfq_wr_max_time is set to 0 in bfq_init_queue and is never changed.
It is only used in bfq_wr_duration when bfq_wr_max_time > 0 which never
meets, so bfqd->bfq_wr_max_time is not used actually. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 4 ----
 block/bfq-iosched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 195cdc6be087..91bc68fba72d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1068,9 +1068,6 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 {
 	u64 dur;
 
-	if (bfqd->bfq_wr_max_time > 0)
-		return bfqd->bfq_wr_max_time;
-
 	dur = bfqd->rate_dur_prod;
 	do_div(dur, bfqd->peak_rate);
 
@@ -7079,7 +7076,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 */
 	bfqd->bfq_wr_coeff = 30;
 	bfqd->bfq_wr_rt_max_time = msecs_to_jiffies(300);
-	bfqd->bfq_wr_max_time = 0;
 	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
 	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
 	bfqd->bfq_wr_max_softrt_rate = 7000; /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 9fa89577322d..0b1a5438046a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -719,8 +719,6 @@ struct bfq_data {
 	 * is multiplied.
 	 */
 	unsigned int bfq_wr_coeff;
-	/* maximum duration of a weight-raising period (jiffies) */
-	unsigned int bfq_wr_max_time;
 
 	/* Maximum weight-raising duration for soft real-time processes */
 	unsigned int bfq_wr_rt_max_time;
-- 
2.30.0

