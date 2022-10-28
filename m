Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06F610D9D
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJ1JtS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJ1JtJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 05:49:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A731C4ECC;
        Fri, 28 Oct 2022 02:49:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MzHkQ0kfwz6T8tN;
        Fri, 28 Oct 2022 17:46:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCntOaQpVtjHAtNAQ--.59885S5;
        Fri, 28 Oct 2022 17:49:06 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: [PATCH -next 1/5] blk-iocost: cleanup ioc_qos_write() and ioc_cost_model_write()
Date:   Fri, 28 Oct 2022 18:10:52 +0800
Message-Id: <20221028101056.1971715-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCntOaQpVtjHAtNAQ--.59885S5
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UJF4rJFy5uFy5ZF18Krg_yoWrCFW8pF
        WF93yaq3y8Ars7Wr42yF42ga4rCwsrWry7CFWkGr1fZrnFyrnFgF109FyUurW8JFZ3Jrs8
        JFZFqrWDCayDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

There are no functional changes, just to make the code a litter cleaner
and follow up patches easier.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 62 +++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index f01359906c83..fd495e823db2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3185,7 +3185,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (!ioc) {
 		ret = blk_iocost_init(disk);
 		if (ret)
-			goto err;
+			goto out;
 		ioc = q_to_ioc(disk->queue);
 	}
 
@@ -3197,6 +3197,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	enable = ioc->enabled;
 	user = ioc->user_qos_params;
 
+	ret = -EINVAL;
 	while ((p = strsep(&input, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
@@ -3218,7 +3219,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			else if (!strcmp(buf, "user"))
 				user = true;
 			else
-				goto einval;
+				goto out_unlock;
 			continue;
 		}
 
@@ -3228,39 +3229,39 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		case QOS_WPPM:
 			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
 			    sizeof(buf))
-				goto einval;
+				goto out_unlock;
 			if (cgroup_parse_float(buf, 2, &v))
-				goto einval;
+				goto out_unlock;
 			if (v < 0 || v > 10000)
-				goto einval;
+				goto out_unlock;
 			qos[tok] = v * 100;
 			break;
 		case QOS_RLAT:
 		case QOS_WLAT:
 			if (match_u64(&args[0], &v))
-				goto einval;
+				goto out_unlock;
 			qos[tok] = v;
 			break;
 		case QOS_MIN:
 		case QOS_MAX:
 			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
 			    sizeof(buf))
-				goto einval;
+				goto out_unlock;
 			if (cgroup_parse_float(buf, 2, &v))
-				goto einval;
+				goto out_unlock;
 			if (v < 0)
-				goto einval;
+				goto out_unlock;
 			qos[tok] = clamp_t(s64, v * 100,
 					   VRATE_MIN_PPM, VRATE_MAX_PPM);
 			break;
 		default:
-			goto einval;
+			goto out_unlock;
 		}
 		user = true;
 	}
 
 	if (qos[QOS_MIN] > qos[QOS_MAX])
-		goto einval;
+		goto out_unlock;
 
 	if (enable) {
 		blk_stat_enable_accounting(disk->queue);
@@ -3281,21 +3282,14 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	}
 
 	ioc_refresh_params(ioc, true);
-	spin_unlock_irq(&ioc->lock);
+	ret = nbytes;
 
-	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
-
-	blkdev_put_no_open(bdev);
-	return nbytes;
-einval:
+out_unlock:
 	spin_unlock_irq(&ioc->lock);
-
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-	ret = -EINVAL;
-err:
+out:
 	blkdev_put_no_open(bdev);
 	return ret;
 }
@@ -3364,7 +3358,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (!ioc) {
 		ret = blk_iocost_init(bdev->bd_disk);
 		if (ret)
-			goto err;
+			goto out;
 		ioc = q_to_ioc(q);
 	}
 
@@ -3375,6 +3369,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
 
+	ret = -EINVAL;
 	while ((p = strsep(&input, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
@@ -3392,20 +3387,20 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 			else if (!strcmp(buf, "user"))
 				user = true;
 			else
-				goto einval;
+				goto out_unlock;
 			continue;
 		case COST_MODEL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
 			if (strcmp(buf, "linear"))
-				goto einval;
+				goto out_unlock;
 			continue;
 		}
 
 		tok = match_token(p, i_lcoef_tokens, args);
 		if (tok == NR_I_LCOEFS)
-			goto einval;
+			goto out_unlock;
 		if (match_u64(&args[0], &v))
-			goto einval;
+			goto out_unlock;
 		u[tok] = v;
 		user = true;
 	}
@@ -3416,23 +3411,16 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	} else {
 		ioc->user_cost_model = false;
 	}
-	ioc_refresh_params(ioc, true);
-	spin_unlock_irq(&ioc->lock);
 
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
-
-	blkdev_put_no_open(bdev);
-	return nbytes;
+	ioc_refresh_params(ioc, true);
+	ret = nbytes;
 
-einval:
+out_unlock:
 	spin_unlock_irq(&ioc->lock);
-
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
-	ret = -EINVAL;
-err:
+out:
 	blkdev_put_no_open(bdev);
 	return ret;
 }
-- 
2.31.1

