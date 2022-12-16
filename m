Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142564E62D
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 04:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLPDNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLPDNe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 22:13:34 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA82A969;
        Thu, 15 Dec 2022 19:13:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYDh70jPTz4f43Dd;
        Fri, 16 Dec 2022 11:13:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXiNVW4ptjHYxACQ--.50238S5;
        Fri, 16 Dec 2022 11:13:29 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang@26.com, shikemeng@huaweicloud.com
Subject: [PATCH v2 03/10] block, bfq: initialize bfqq->decrease_time_jif correctly
Date:   Fri, 16 Dec 2022 19:12:23 +0800
Message-Id: <20221216111230.3638832-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
References: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXiNVW4ptjHYxACQ--.50238S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4Utw1kuw4fJr45tF4ruFg_yoW8AFy5pa
        9Fgr47KF4jqFy3Wr1UAa1DGF98Krs09ry7J3W2g392y3yUArnFgFsYkrWYvFWfGrs7Aw10
        qw4vqr9ruw1F9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
        1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjTRNzVbUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Inject limit is updated or reset when time_is_before_eq_jiffies(
decrease_time_jif + several msecs) or think-time state changes.
decrease_time_jif is initialized to 0 and will be set to current jiffies
when inject limit is updated or reset. If the jiffies is slightly greater
than LONG_MAX, time_is_after_eq_jiffies(0) will keep for a long time, so as
time_is_after_eq_jiffies(decrease_time_jif + several msecs). If the
think-time state never chages, then the injection will not work as expected
for long time.

To be more specific:
Function bfq_update_inject_limit maybe triggered when jiffies pasts
decrease_time_jif + msecs_to_jiffies(10) in bfq_add_request by setting
bfqd->wait_dispatch to true.
Function bfq_reset_inject_limit are called in two conditions:
1. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(1000) in
function bfq_add_request.
2. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(100) or
bfq think-time state change from short to long.

Fix this by initializing bfqq->decrease_time_jif to current jiffies
to trigger service injection soon when service injection conditions
are met.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5a6d9e8c329d..9441fc98961a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5491,6 +5491,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
+
+	bfqq->decrease_time_jif = jiffies;
 }
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
-- 
2.30.0

