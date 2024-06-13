Return-Path: <cgroups+bounces-3173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5951906165
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E901F21BCB
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE712D775;
	Thu, 13 Jun 2024 01:50:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440871B51;
	Thu, 13 Jun 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243422; cv=none; b=AvSFjkkiGrfCSQuOZCXZqBE6G1k/5UpwTkAyfTnf6gqNbkWCG91gr1ItObk2sgdJIX3/6ObjBQ2laGDWsYeUl76+GShZX7VOpc6FrYyQFi5HO2d9HBE6CWZUCh0TqoKngBwvJ7PUMlSj/SYt8JkN6KBkqmPuapqfa0nGtKLoYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243422; c=relaxed/simple;
	bh=On52Isa8wUdYQHy7bPnfk+F9qQkgUd6wBqtHNXpaSP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyOJdomuSezy4c52KpGNL8yCEqdrkFFsdY0UKs47tAYg+NlqI61BUl5PWssIMGuy3u2vIFnEyt49diJWLgaucPWvCfKWPtUfVoOGfhwVlmp4uhMmHIfDsAFug+WTsD3DXyq+vosfOe9H9tGXYxOnVoHl2UdxNun8GnOqZjx35iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W052J4G9Gz4f3jXd;
	Thu, 13 Jun 2024 09:50:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A4A921A1380;
	Thu, 13 Jun 2024 09:50:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S10;
	Thu, 13 Jun 2024 09:50:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	gregkh@linuxfoundation.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next 6/7] blk-iocost: support to free iocost
Date: Thu, 13 Jun 2024 09:49:36 +0800
Message-Id: <20240613014937.1326020-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Kr4DCFWfuFy7KF43GFg_yoW5KFy7pa
	1ruw1akayqqrs7urnxXr42vw1Skws2gryxG3yfG34fJrnFkr1FqF1kCryUCFy5JFZ5Zr4a
	vFZ5trW7Gr48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently if iocost is initialized, it can never be freed until the disk
is deleted.

A new param "free" is added to the blk-io cgroup api "io.cost.qos", and
user can use it to free iocost. On the one hand prevent overhead from
fast path, on the other hand prepare to build iocost as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 96a6f2292623..708a43a7c6a0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -324,6 +324,7 @@ enum ioc_running {
 enum {
 	QOS_ENABLE,
 	QOS_CTRL,
+	QOS_FREE,
 	NR_QOS_CTRL_PARAMS,
 };
 
@@ -2847,11 +2848,9 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
 	spin_unlock_irq(&ioc->lock);
 }
 
-static void ioc_rqos_exit(struct rq_qos *rqos)
+static void __ioc_exit(struct ioc *ioc)
 {
-	struct ioc *ioc = rqos_to_ioc(rqos);
-
-	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iocost);
+	blkcg_deactivate_policy(ioc->rqos.disk, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2862,6 +2861,13 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static void ioc_rqos_exit(struct rq_qos *rqos)
+{
+	struct ioc *ioc = rqos_to_ioc(rqos);
+
+	__ioc_exit(ioc);
+}
+
 static const struct rq_qos_ops ioc_rqos_ops = {
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
@@ -3193,6 +3199,7 @@ static int ioc_qos_show(struct seq_file *sf, void *v)
 static const match_table_t qos_ctrl_tokens = {
 	{ QOS_ENABLE,		"enable=%u"	},
 	{ QOS_CTRL,		"ctrl=%s"	},
+	{ QOS_FREE,		"free"		},
 	{ NR_QOS_CTRL_PARAMS,	NULL		},
 };
 
@@ -3210,6 +3217,7 @@ struct ioc_qos_params {
 	u32 qos[NR_QOS_PARAMS];
 	bool enable;
 	bool user;
+	bool free;
 };
 
 static void ioc_qos_params_init(struct ioc *ioc, struct ioc_qos_params *params)
@@ -3228,6 +3236,8 @@ static void ioc_qos_params_init(struct ioc *ioc, struct ioc_qos_params *params)
 		params->enable = false;
 		params->user = false;
 	}
+
+	params->free = false;
 }
 
 static int ioc_qos_params_parse(struct blkg_conf_ctx *ctx,
@@ -3260,6 +3270,9 @@ static int ioc_qos_params_parse(struct blkg_conf_ctx *ctx,
 			else
 				return -EINVAL;
 			continue;
+		case QOS_FREE:
+			params->free = true;
+			continue;
 		}
 
 		tok = match_token(p, qos_tokens, args);
@@ -3338,6 +3351,15 @@ static void ioc_qos_params_update(struct gendisk *disk, struct ioc *ioc,
 	ioc_refresh_params(ioc, true);
 }
 
+static void ioc_free(struct ioc *ioc)
+{
+	if (!ioc)
+		return;
+
+	rq_qos_del(&ioc->rqos);
+	__ioc_exit(ioc);
+}
+
 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
@@ -3366,7 +3388,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (ret)
 		goto err;
 
-	if (!ioc) {
+	if (!params.free && !ioc) {
 		ret = blk_iocost_init(disk);
 		if (ret)
 			goto err;
@@ -3376,6 +3398,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_freeze_queue(disk->queue);
 	blk_mq_quiesce_queue(disk->queue);
 
+	if (params.free) {
+		ioc_free(ioc);
+		goto out;
+	}
+
 	spin_lock_irq(&ioc->lock);
 
 	ioc_qos_params_update(disk, ioc, &params);
@@ -3386,6 +3413,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	else
 		wbt_enable_default(disk);
 
+out:
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 
-- 
2.39.2


