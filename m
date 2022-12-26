Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37232656120
	for <lists+cgroups@lfdr.de>; Mon, 26 Dec 2022 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiLZIir (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Dec 2022 03:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLZIip (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Dec 2022 03:38:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0591109;
        Mon, 26 Dec 2022 00:38:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NgWQk27hLz4f3jZ5;
        Mon, 26 Dec 2022 16:38:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBH7eqEXaljOrUjAg--.30907S6;
        Mon, 26 Dec 2022 16:38:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 2/5] blk-iocost: don't allow to configure bio based device
Date:   Mon, 26 Dec 2022 16:58:56 +0800
Message-Id: <20221226085859.2701195-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221226085859.2701195-1-yukuai1@huaweicloud.com>
References: <20221226085859.2701195-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7eqEXaljOrUjAg--.30907S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxur13Zr1rCr4xJw1fWFg_yoWkAwb_Ca
        yI9r90gFs5Gay8XF1SyF90vrWfKw4FqFW0vFy7Ja43JFn8Xas0yan3Xryktr45uayq9a45
        Ca9ruw1DJFs7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
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

iocost is based on rq_qos, which can only work for request based device,
thus it doesn't make sense to configure iocost for bio based device.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 93b938517be3..ce4eafbada56 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3185,6 +3185,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		return PTR_ERR(bdev);
 
 	disk = bdev->bd_disk;
+	if (!queue_is_mq(disk->queue)) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
 	ioc = q_to_ioc(disk->queue);
 	if (!ioc) {
 		ret = blk_iocost_init(disk);
@@ -3365,6 +3370,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		return PTR_ERR(bdev);
 
 	q = bdev_get_queue(bdev);
+	if (!queue_is_mq(q)) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
 	ioc = q_to_ioc(q);
 	if (!ioc) {
 		ret = blk_iocost_init(bdev->bd_disk);
-- 
2.31.1

