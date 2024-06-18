Return-Path: <cgroups+bounces-3216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625E90C252
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069DAB227E9
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0019B5A2;
	Tue, 18 Jun 2024 03:18:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F56256D;
	Tue, 18 Jun 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680729; cv=none; b=jsWpDVHd+/TlKZBd0q87Kf9jJ75i2kqR1+gn/AkXBBGYT75BXk6sHV7Y2SLYPwjnBR9+UOa5w7nPqPWV0UAxUDXhM9OLP8x1/jccQ1wh3LXRmCXA5111UaDPlRwEcnABDNYnDcEqZdgTbT0nT5J/+w9LEQ3y0DsADkoMHtcb+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680729; c=relaxed/simple;
	bh=e7+vDoIEVL1RlGQ3D7xQBG+dbRRC33wLqhnC22LJoPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjCqGIvRCaEZrJsnnvbxqMoxaGRpDxKTxDCPBuZdtqfSQrEb8C2utvMIB7wC9cCtzqE7MGgJe1Ce+rSjAlsoMsJBWpU5lg0w7pLGaWH/IZi5k5rUywHeJDdOaH1gnGuXFYEutHS2D/QqEdfcjKdzffyd1fdEIEeTi3Oa7l2atGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3BmD2dswz4f3jQd;
	Tue, 18 Jun 2024 11:18:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2840E1A016E;
	Tue, 18 Jun 2024 11:18:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXAQ+N_HBmFJj8AA--.12964S10;
	Tue, 18 Jun 2024 11:18:42 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	bvanassche@acm.org,
	hch@infradead.org,
	josef@toxicpanda.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 6/7] blk-iocost: support to free iocost
Date: Tue, 18 Jun 2024 11:17:50 +0800
Message-Id: <20240618031751.3470464-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXAQ+N_HBmFJj8AA--.12964S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Kr4DCFWfuFy7KF43GFg_yoW5KFy7pa
	1ruw1akayqqrs7urnxXr42vw1Skws2gryxJ3yfG34ftrnFkr1FqF1kCry8CFy5JFZ5Ar4a
	vFZ5trW7Gr48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
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
index 34dcf4cdfadb..9765c988113f 100644
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


