Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0386FE99A
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjEKBr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 21:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjEKBrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 21:47:53 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE375BA9;
        Wed, 10 May 2023 18:47:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QGvst2lPxz4f3l2X;
        Thu, 11 May 2023 09:47:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eo_SVxkrgJdJA--.7260S7;
        Thu, 11 May 2023 09:47:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 3/6] blk-wbt: don't enable wbt for bio based device
Date:   Thu, 11 May 2023 09:45:06 +0800
Message-Id: <20230511014509.679482-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511014509.679482-1-yukuai1@huaweicloud.com>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eo_SVxkrgJdJA--.7260S7
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyfXw43GrWUZF1rKF4UJwb_yoW3Jrg_uF
        1kur1Iqrn3AFn29r4ayr4FqFZ5G3s5XFWUWFWkJ347ZFn8J3Z3Gws7Xrs8Wr47uFWxKFWr
        ur17W34xJrWIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6AFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU=
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

Because rq_qos only make sense for rq based device. Instead of fail
from sysfs configuration, make wbt sysfs dentry invisible directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6c1c4ba66bc0..c8e1f1462422 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -686,6 +686,10 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 	    !blk_queue_is_zoned(q))
 		return 0;
 
+#ifdef CONFIG_BLK_WBT
+	if (attr == &queue_wb_lat_entry.attr && !queue_is_mq(q))
+		return 0;
+#endif
 	return attr->mode;
 }
 
-- 
2.39.2

