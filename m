Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A1713158
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjE0BKW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 21:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjE0BKV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 21:10:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86B135;
        Fri, 26 May 2023 18:10:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSkHD3jbRz4f3nT5;
        Sat, 27 May 2023 09:10:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J0WHFkNZwtKQ--.29147S8;
        Sat, 27 May 2023 09:10:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 4/5] blk-iocost: move wbt_enable/disable_default() out of spinlock
Date:   Sat, 27 May 2023 09:06:43 +0800
Message-Id: <20230527010644.647900-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230527010644.647900-1-yukuai1@huaweicloud.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J0WHFkNZwtKQ--.29147S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fXr1xtry7urW7WrWrAFb_yoW8CFy3pF
        ZxCrsFya4IvFs2vr47GanFqw15Ga1kGryfAr1fGw1Sqw13C3s2qan7KrW09F1kZFZ3AFs8
        Xr4IkF4jva1vy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
initialized, currently this is only possible in blk_register_queue(), hence
wbt_init() will never be called from iocost and this warning is false
positive.

However, we might support rq_qos destruction dynamically in the future,
and it's better to prevent that, hence move wbt_enable_default() outside
'ioc->lock'. This is safe because queue is still freezed.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y+Ja5SRs886CEz7a@kadam/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 285ced3467ab..eb57e7e4f2db 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3300,11 +3300,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
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
@@ -3317,6 +3315,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	if (enable)
+		wbt_disable_default(disk);
+	else
+		wbt_enable_default(disk);
+
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-- 
2.39.2

