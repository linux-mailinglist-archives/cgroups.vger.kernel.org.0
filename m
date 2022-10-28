Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84522610DA7
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJ1JtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ1JtM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 05:49:12 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2B1C6BD7;
        Fri, 28 Oct 2022 02:49:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MzHkR5J8Yz6T8sr;
        Fri, 28 Oct 2022 17:46:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCntOaQpVtjHAtNAQ--.59885S9;
        Fri, 28 Oct 2022 17:49:08 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: [PATCH -next 5/5] blk-iocost: fix sleeping in atomic context warnning in ioc_cost_model_write()
Date:   Fri, 28 Oct 2022 18:10:56 +0800
Message-Id: <20221028101056.1971715-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCntOaQpVtjHAtNAQ--.59885S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fWw18Zr4fCFWDZF1kZrb_yoWrZrW7pF
        Wfu3sxt3y0qrs3CFWIq3yIqF1fuwn7Ww47Gay3Grn3tr17Kr109F18uryjkFW8J3yrJFWY
        qF98tr4UWrW7CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

match_u64() is called inside ioc->lock, which causes smatch static
checker warnings:

block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic context

Fix the problem by prase params before holding the lock.

Fixes: 2c0647988433 ("blk-iocost: don't release 'ioc->lock' while updating params")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 128 +++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 44 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 27b41f3f1b07..62e18c2719cb 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3403,43 +3403,23 @@ static const match_table_t i_lcoef_tokens = {
 	{ NR_I_LCOEFS,		NULL		},
 };
 
-static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
-				    size_t nbytes, loff_t off)
-{
-	struct block_device *bdev;
-	struct request_queue *q;
-	struct ioc *ioc;
+struct ioc_model_params {
 	u64 u[NR_I_LCOEFS];
 	bool user;
-	char *p;
-	int ret;
-
-	bdev = blkcg_conf_open_bdev(&input);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-
-	q = bdev_get_queue(bdev);
-	if (!queue_is_mq(q)) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	ioc = q_to_ioc(q);
-	if (!ioc) {
-		ret = blk_iocost_init(bdev->bd_disk);
-		if (ret)
-			goto out;
-		ioc = q_to_ioc(q);
-	}
+	bool set_u[NR_I_LCOEFS];
+	bool set_user;
+};
 
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
+static struct ioc_model_params *ioc_model_parse_params(char *input)
+{
+	struct ioc_model_params *params;
+	char *p;
+	int ret = -EINVAL;
 
-	spin_lock_irq(&ioc->lock);
-	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
-	user = ioc->user_cost_model;
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
 
-	ret = -EINVAL;
 	while ((p = strsep(&input, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
@@ -3454,48 +3434,108 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		case COST_CTRL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
 			if (!strcmp(buf, "auto"))
-				user = false;
+				params->user = false;
 			else if (!strcmp(buf, "user"))
-				user = true;
+				params->user = true;
 			else
-				goto out_unlock;
+				goto err;
+			params->set_user = true;
 			continue;
 		case COST_MODEL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
 			if (strcmp(buf, "linear"))
-				goto out_unlock;
+				goto err;
 			continue;
 		}
 
 		tok = match_token(p, i_lcoef_tokens, args);
 		if (tok == NR_I_LCOEFS)
-			goto out_unlock;
+			goto err;
 
 		err = match_u64(&args[0], &v);
 		if (err) {
 			ret = err;
-			goto out_unlock;
+			goto err;
 		}
 
-		u[tok] = v;
-		user = true;
+		params->u[tok] = v;
+		params->set_u[tok] = true;
+		params->user = true;
+		params->set_user = true;
 	}
 
-	if (user) {
-		memcpy(ioc->params.i_lcoefs, u, sizeof(u));
+	return params;
+
+err:
+	kfree(params);
+	return ERR_PTR(ret);
+}
+
+static void ioc_model_update_params(struct ioc *ioc,
+				    struct ioc_model_params *params)
+{
+	int i;
+
+	if (!params->set_user)
+		params->user = ioc->user_cost_model;
+	if (params->user) {
+		for (i = 0; i < NR_I_LCOEFS; ++i)
+			if (params->set_u[i])
+				ioc->params.i_lcoefs[i] = params->u[i];
 		ioc->user_cost_model = true;
 	} else {
 		ioc->user_cost_model = false;
 	}
+}
+
+static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
+				    size_t nbytes, loff_t off)
+{
+	struct block_device *bdev;
+	struct request_queue *q;
+	struct ioc *ioc;
+	struct ioc_model_params *params;
+	int ret;
+
+	bdev = blkcg_conf_open_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	q = bdev_get_queue(bdev);
+	if (!queue_is_mq(q)) {
+		ret = -EPERM;
+		goto out;
+	}
 
+	ioc = q_to_ioc(q);
+	if (!ioc) {
+		ret = blk_iocost_init(bdev->bd_disk);
+		if (ret)
+			goto out;
+		ioc = q_to_ioc(q);
+	}
+
+	params = ioc_model_parse_params(input);
+	if (IS_ERR(params)) {
+		ret = PTR_ERR(params);
+		goto out;
+	}
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	spin_lock_irq(&ioc->lock);
+
+	ioc_model_update_params(ioc, params);
 	ioc_refresh_params(ioc, true);
-	ret = nbytes;
 
-out_unlock:
 	spin_unlock_irq(&ioc->lock);
+
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
+	kfree(params);
+	ret = nbytes;
 out:
 	blkdev_put_no_open(bdev);
 	return ret;
-- 
2.31.1

