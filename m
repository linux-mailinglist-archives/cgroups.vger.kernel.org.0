Return-Path: <cgroups+bounces-3172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627F906163
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005381F225BD
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9F12D761;
	Thu, 13 Jun 2024 01:50:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0887E788;
	Thu, 13 Jun 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243422; cv=none; b=pCpyC9oNL4X64C1BMB/p4fIOy2R7DP0m4bhHHOEhTWKdnV8FonOkG784GbmSI7bmOFhm1Vxq4VnKTPUaQWE6YoB/V9Y7LueuX2pfa/p36uQYA2GT9BLfMiPzH83/Kn5K+/xeAEM0198JsQY6wHSBslfQIqOsy6uV+z66KHI2WEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243422; c=relaxed/simple;
	bh=OfDv7R2e0Q9iiCmD3xqeT8MXD37MG2FQkk5TlDkCLos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/LLWwDDkrRK/jvdeIaPRzZUpnb1AWl7SQca/hE3WgFnoA7iYCvqFnZQfTEXgovBoYHjrRkbsxpmBQraaz2nQ3nrybSByN3ZXKB2aWf9fKr5U9VxqMi3oUg0VKodJG4JYxpS+n46e79GOZ7wogpAQawirtUt7PjLeySIFCsnENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W052H55MYz4f3n64;
	Thu, 13 Jun 2024 09:49:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 32C831A0185;
	Thu, 13 Jun 2024 09:50:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S11;
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
Subject: [PATCH RFC -next 7/7] blk-iocost: support to build iocost as kernel module
Date: Thu, 13 Jun 2024 09:49:37 +0800
Message-Id: <20240613014937.1326020-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyfJr4ftFy8AryfWryxAFb_yoW5Jr4UpF
	s8uw1Yya1UKFsIgFWfGwn7Xr1fCa4kKrWxWa43GwnYvFyaywn7Z3WkAryrXFy8ZFZxZr43
	ZFW0gFsxCFyUA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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
index 708a43a7c6a0..2a69db547045 100644
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


