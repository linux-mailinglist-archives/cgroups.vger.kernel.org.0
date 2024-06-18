Return-Path: <cgroups+bounces-3218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978390C256
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F7A283CC1
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15762B9A6;
	Tue, 18 Jun 2024 03:18:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF41CD35;
	Tue, 18 Jun 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680729; cv=none; b=r5sjqLHPygH0dLJvWsOt8mV2tHHnXlud6m3J8SwakWEopTQ5DAA9NTBVdGieQknxWqg08Ha0CgZlpknzp+r0/1a+sqZxpVxuIY0wKW0EQ7IJGRaSI1vEdyXuQr6Mj5PU93ebKTM0XkLsX7K3On7fQLRq39hJZzwEbCyaCi6agnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680729; c=relaxed/simple;
	bh=1w2uBjaaCYiqkDeJ8zIZEjj4QVSb+MXZMKyM2t9/Q68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWEBsU6ycY1uKqIwT47F8/mjlH++CJV5dW3iqlN8hefsw4aGFoC1qKWFMrIywRlTHb3kH4Kzn01Aru4ff9bRrcvDL08J4eCqyqp0u3fU9E0ljLUhVo7Dtt/zLpcNmrf/bUJ8fUGBFATPgVsA+kTpenNtmyDWMH/9/5lWhjNOPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3Bm76yzWz4f3kvv;
	Tue, 18 Jun 2024 11:18:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B2ED01A0FC7;
	Tue, 18 Jun 2024 11:18:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXAQ+N_HBmFJj8AA--.12964S11;
	Tue, 18 Jun 2024 11:18:43 +0800 (CST)
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
Subject: [PATCH RFC v2 7/7] blk-iocost: support to build iocost as kernel module
Date: Tue, 18 Jun 2024 11:17:51 +0800
Message-Id: <20240618031751.3470464-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXAQ+N_HBmFJj8AA--.12964S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1xCr43AF4xCr1xAFy7Wrg_yoW5CF48pF
	s8Ww1Yyay7KFsIgayfGwn7Xr1fJa92gFWrWa43W3sYv3yayw1xZ3WkJryrXFy8ZF43Zr43
	XFW0qrWakFyUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The motivation is that iocost is not used widely in our production, and
some customers don't want to increase kernel size to enable iocost that
they will never use, and it'll be painful to maintain a new downstream
kernel version. Hence it'll be beneficially to build iocost as kernel
module:

- Kernel Size and Resource Usage, modules are loaded only when their
specific functionality is required.

- Flexibility and Maintainability, allows for dynamic loading and unloading
of modules at runtime without the need to recompile and restart the kernel,
for example we can just replace blk-iocost.ko to fix iocost CVE in our
production environment.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/Kconfig             |  2 +-
 block/blk-iocost.c        | 14 +++++++++++++-
 include/linux/blk_types.h |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index dc12af58dbae..b94b93158e57 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -156,7 +156,7 @@ config BLK_CGROUP_FC_APPID
 	  application specific identification into the FC frame.
 
 config BLK_CGROUP_IOCOST
-	bool "Enable support for cost model based cgroup IO controller"
+	tristate "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
 	select BLK_RQ_ALLOC_TIME
 	help
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9765c988113f..33ab6e436af2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2850,6 +2850,7 @@ static void ioc_rqos_queue_depth_changed(struct rq_qos *rqos)
 
 static void __ioc_exit(struct ioc *ioc)
 {
+	module_put(THIS_MODULE);
 	blkcg_deactivate_policy(ioc->rqos.disk, &blkcg_policy_iocost);
 
 	spin_lock_irq(&ioc->lock);
@@ -2882,13 +2883,19 @@ static int blk_iocost_init(struct gendisk *disk)
 	struct ioc *ioc;
 	int i, cpu, ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
-	if (!ioc)
+	if (!ioc) {
+		module_put(THIS_MODULE);
 		return -ENOMEM;
+	}
 
 	ioc->pcpu_stat = alloc_percpu(struct ioc_pcpu_stat);
 	if (!ioc->pcpu_stat) {
 		kfree(ioc);
+		module_put(THIS_MODULE);
 		return -ENOMEM;
 	}
 
@@ -2938,6 +2945,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	rq_qos_del(&ioc->rqos);
 err_free_ioc:
 	free_percpu(ioc->pcpu_stat);
+	module_put(THIS_MODULE);
 	kfree(ioc);
 	return ret;
 }
@@ -3616,3 +3624,7 @@ static void __exit ioc_exit(void)
 
 module_init(ioc_init);
 module_exit(ioc_exit);
+
+MODULE_AUTHOR("Tejun Heo");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cost model based cgroup IO controller");
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 781c4500491b..8da12ebc7777 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -234,7 +234,7 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
-#ifdef CONFIG_BLK_CGROUP_IOCOST
+#if IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST)
 	u64			bi_iocost_cost;
 #endif
 #endif
-- 
2.39.2


