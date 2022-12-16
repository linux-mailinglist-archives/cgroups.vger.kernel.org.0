Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235AC64E638
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 04:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLPDNm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Dec 2022 22:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPDNf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Dec 2022 22:13:35 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F12B267;
        Thu, 15 Dec 2022 19:13:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NYDh86GhFz4f43lm;
        Fri, 16 Dec 2022 11:13:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAXiNVW4ptjHYxACQ--.50238S9;
        Fri, 16 Dec 2022 11:13:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang@26.com, shikemeng@huaweicloud.com
Subject: [PATCH v2 07/10] block, bfq: remove redundant check in bfq_put_cooperator
Date:   Fri, 16 Dec 2022 19:12:27 +0800
Message-Id: <20221216111230.3638832-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
References: <20221216111230.3638832-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXiNVW4ptjHYxACQ--.50238S9
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWxAFWUXr1xWw48Gw1Utrb_yoWxtrg_t3
        sYkFWrJrW8Gry5Ar1ftas8Aw1UAayrJF1DJFyFqw4DXF15GF4rCa92gFWayFs8Way7Ga4a
        yFy0q3WDtr4DKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbvkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjTRKfOwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have already avoided a circular list in bfq_setup_merge (see comments
in bfq_setup_merge() for details), so bfq_queue will not appear in it's
new_bfqq list. Just remove this check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7c91d16dbf6f..89995815dbae 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5273,8 +5273,6 @@ void bfq_put_cooperator(struct bfq_queue *bfqq)
 	 */
 	__bfqq = bfqq->new_bfqq;
 	while (__bfqq) {
-		if (__bfqq == bfqq)
-			break;
 		next = __bfqq->new_bfqq;
 		bfq_put_queue(__bfqq);
 		__bfqq = next;
-- 
2.30.0

