Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61768E690
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 04:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBHDYX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 22:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBHDYW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 22:24:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E43587;
        Tue,  7 Feb 2023 19:24:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PBQMh1fySz4f3tpX;
        Wed,  8 Feb 2023 11:24:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R_dFeNj8Tu4Cw--.19123S4;
        Wed, 08 Feb 2023 11:24:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] blk-iocost: fix sleeping in atomic warning for wbt_enable_default()
Date:   Wed,  8 Feb 2023 11:48:03 +0800
Message-Id: <20230208034803.2818155-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R_dFeNj8Tu4Cw--.19123S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fXr1xuw43ZFy5tFyDAwb_yoW8Cry5pF
        W3GrnFya4IqFZ7Zr47JanFqw15GaykGryxCw1fG34aqw1ak3s2qa1vkry09F1kZFZ3AF45
        XF48KF4UZa1vv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are following smatch warning:

block/blk-wbt.c:843 wbt_init() warn: sleeping in atomic context
ioc_qos_write() <- disables preempt
-> wbt_enable_default()
   -> wbt_init()

wbt_init() will be called from wbt_enable_default() if wbt is not
initialized, currently wbt is initialized in blk_register_queue(), hence
wbt_init() will never be called from iocost and this warning is false
positive.

However, we might support rq_qos destruction dynamically in the future,
and it's better to prevent that, hence move wbt_enable_default() outside
'ioc->lock'. This is safe because queue is still freezed.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y+Ja5SRs886CEz7a@kadam/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7a2dc9dc8e3b..03bfe1dda07c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3279,11 +3279,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
-		wbt_disable_default(disk);
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
-		wbt_enable_default(disk);
 	}
 
 	if (user) {
@@ -3296,6 +3294,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	if (enable)
+		wbt_disable_default(disk);
+	else
+		wbt_enable_default(disk);
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-- 
2.31.1

