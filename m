Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61B63D61D
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiK3NA4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 08:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiK3NAz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 08:00:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423B4B99D;
        Wed, 30 Nov 2022 05:00:53 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMfSV6SB7zRpZH;
        Wed, 30 Nov 2022 21:00:10 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:00:51 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 30 Nov
 2022 21:00:50 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 1/9] blk-iocost: cleanup ioc_qos_write() and ioc_cost_model_write()
Date:   Wed, 30 Nov 2022 21:21:48 +0800
Message-ID: <20221130132156.2836184-2-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221130132156.2836184-1-linan122@huawei.com>
References: <20221130132156.2836184-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, just to make the code a litter cleaner
and follow up patches easier.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Li Nan <linan122@huawei.com>
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

