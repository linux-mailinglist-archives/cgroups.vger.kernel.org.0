Return-Path: <cgroups+bounces-3169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0390615B
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8CAB22391
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22488405F;
	Thu, 13 Jun 2024 01:50:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA8ECC;
	Thu, 13 Jun 2024 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243420; cv=none; b=YgrB8RZ+OJTGUBliuQPjH08MPw+xVgVKb/2mbrMHlYJjGRK/bcK0wnlWOUfA41wWxSYaaPbD4GWRnFf2EWIzRj2mHb+NX+LaVFQ8AGtpw0z3TYlmO6bRbSUaCF/Qg0k1zpGG0Jzk8fF8OJaRDtY4Er0bvM/suiOyBy7YcoZpGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243420; c=relaxed/simple;
	bh=SWfRtPhP1+lMSHBO1po8Poq/MU5qZDtTVQnew3U+1OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9EuUTi4TO2lGeq85QicVZSJxcW+ga+Ka1a7NiXI4VCi4H3unWUZ8oug+ZwOkkYAnv1DnHaHBLlsSAF9g41OfmMRdxGZo0O8X8AVNo1C9YLFFkZcTaRF9labflO0qIrRA8hdU7HLUQnJCL3nctdWfYTObt//sAbHYAmVev7ROi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W052M3thsz4f3kKD;
	Thu, 13 Jun 2024 09:50:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2768C1A1384;
	Thu, 13 Jun 2024 09:50:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S9;
	Thu, 13 Jun 2024 09:50:09 +0800 (CST)
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
Subject: [PATCH RFC -next 5/7] blk-iocost: parse params before initializing iocost
Date: Thu, 13 Jun 2024 09:49:35 +0800
Message-Id: <20240613014937.1326020-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45XFyDCFy5ZryxCrWDCFg_yoW5Aw4fp3
	WS93sxt3yUJrs3Zr1aqr40q3W3Z34Igrn3Xr17Gr95Jr17Cr1Fya4DCry09FWrJa93AayD
	tFZ8JrWUKr4xCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On the one hand prevent to initialize iocost for invalid input, on the
ohter hand prepare to add a new input to free iocost.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 253143005086..96a6f2292623 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3214,9 +3214,20 @@ struct ioc_qos_params {
 
 static void ioc_qos_params_init(struct ioc *ioc, struct ioc_qos_params *params)
 {
-	memcpy(params->qos, ioc->params.qos, sizeof(params->qos));
-	params->enable = ioc->enabled;
-	params->user = ioc->user_qos_params;
+	if (ioc) {
+		memcpy(params->qos, ioc->params.qos, sizeof(params->qos));
+		params->enable = ioc->enabled;
+		params->user = ioc->user_qos_params;
+	} else {
+		params->qos[QOS_RPPM] = 0;
+		params->qos[QOS_RLAT] = 0;
+		params->qos[QOS_WPPM] = 0;
+		params->qos[QOS_WLAT] = 0;
+		params->qos[QOS_MIN] = VRATE_MIN_PPM;
+		params->qos[QOS_MAX] = VRATE_MAX_PPM;
+		params->enable = false;
+		params->user = false;
+	}
 }
 
 static int ioc_qos_params_parse(struct blkg_conf_ctx *ctx,
@@ -3309,7 +3320,16 @@ static void ioc_qos_params_update(struct gendisk *disk, struct ioc *ioc,
 	}
 
 	if (params->user) {
-		memcpy(ioc->params.qos, params->qos, sizeof(params->qos));
+		if (params->qos[QOS_RPPM])
+			ioc->params.qos[QOS_RPPM] = params->qos[QOS_RPPM];
+		if (params->qos[QOS_RLAT])
+			ioc->params.qos[QOS_RLAT] = params->qos[QOS_RLAT];
+		if (params->qos[QOS_WPPM])
+			ioc->params.qos[QOS_RPPM] = params->qos[QOS_WPPM];
+		if (params->qos[QOS_WLAT])
+			ioc->params.qos[QOS_WLAT] = params->qos[QOS_WLAT];
+		ioc->params.qos[QOS_MIN] = params->qos[QOS_MIN];
+		ioc->params.qos[QOS_MAX] = params->qos[QOS_MAX];
 		ioc->user_qos_params = true;
 	} else {
 		ioc->user_qos_params = false;
@@ -3340,6 +3360,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	}
 
 	ioc = q_to_ioc(disk->queue);
+	ioc_qos_params_init(ioc, &params);
+
+	ret = ioc_qos_params_parse(&ctx, &params);
+	if (ret)
+		goto err;
+
 	if (!ioc) {
 		ret = blk_iocost_init(disk);
 		if (ret)
@@ -3351,11 +3377,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blk_mq_quiesce_queue(disk->queue);
 
 	spin_lock_irq(&ioc->lock);
-	ioc_qos_params_init(ioc, &params);
-
-	ret = ioc_qos_params_parse(&ctx, &params);
-	if (ret)
-		goto err_parse;
 
 	ioc_qos_params_update(disk, ioc, &params);
 	spin_unlock_irq(&ioc->lock);
@@ -3371,11 +3392,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	blkg_conf_exit(&ctx);
 	return nbytes;
 
-err_parse:
-	spin_unlock_irq(&ioc->lock);
-
-	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
 err:
 	blkg_conf_exit(&ctx);
 	return ret;
-- 
2.39.2


