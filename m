Return-Path: <cgroups+bounces-3170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74490615D
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 03:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196911C20A5E
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F6126F1D;
	Thu, 13 Jun 2024 01:50:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB737F9;
	Thu, 13 Jun 2024 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243420; cv=none; b=iD4zEMtrGx11E0yHEuIK7zCQXMzH2u/qTvrTY2hjBfV/tT+T5tRxaHGgzRwmEaP3FWEex4q4yKT3NniiKPFniw/EUdQ0k3i2y/AIiI0RjYotloO5AxES8Y+an+yt9GKnySKMq1+uucRAE1RdJxWrlTKSP3UvZd6AfbAP5wkkdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243420; c=relaxed/simple;
	bh=oe8QNMwnW8SyIeciEKe/CjObH5mtNI7ifXaXJlFI0lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4Hr2iJKl4znUy9tDB69pC1bOcFYT8Z86v5u5D2Thsl7uFO4PXBzEpmBjA/vqWTZ4GD4RLSCdGR3JKp8InhnERYhovVgsiA8pMHDkUEPuujYEQVG0VCqOOUyzdYcycPxylS2WdxKFHzZTwa1ygpNTSTTrQ+ZWXfQJqqUwrg9mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W052L3RDCz4f3kKY;
	Thu, 13 Jun 2024 09:50:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 175511A1130;
	Thu, 13 Jun 2024 09:50:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S7;
	Thu, 13 Jun 2024 09:50:08 +0800 (CST)
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
Subject: [PATCH RFC -next 3/7] block: export some API
Date: Thu, 13 Jun 2024 09:49:33 +0800
Message-Id: <20240613014937.1326020-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fWFyDuw1UXr13KrWfZrb_yoW8ZF4DpF
	47Kr4fC3yjgFnrZay3W3WrX34ftw4kKF1fJ393ZrWSkFsrur1fZFnYy3WkGrySyF93AFs3
	AFyY9FyUAry8Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
	U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

These APIs are used in iocost, prepare to build iocost as kernel module.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 4 ++++
 block/blk-rq-qos.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..6171e546ea9f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -57,6 +57,7 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 bool blkcg_debug_stats = false;
+EXPORT_SYMBOL_GPL(blkcg_debug_stats);
 
 static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
 
@@ -688,6 +689,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
 		return NULL;
 	return bdi_dev_name(blkg->q->disk->bdi);
 }
+EXPORT_SYMBOL_GPL(blkg_dev_name);
 
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
@@ -815,6 +817,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev = bdev;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
@@ -2011,6 +2014,7 @@ void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
 		current->use_memdelay = use_memdelay;
 	set_notify_resume(current);
 }
+EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
 
 /**
  * blkcg_add_delay - add delay to this blkg
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index dd7310c94713..c3fdf91ddf8d 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -332,6 +332,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	blk_mq_unfreeze_queue(q);
 	return -EBUSY;
 }
+EXPORT_SYMBOL_GPL(rq_qos_add);
 
 void rq_qos_del(struct rq_qos *rqos)
 {
@@ -353,3 +354,4 @@ void rq_qos_del(struct rq_qos *rqos)
 	blk_mq_debugfs_unregister_rqos(rqos);
 	mutex_unlock(&q->debugfs_mutex);
 }
+EXPORT_SYMBOL_GPL(rq_qos_del);
-- 
2.39.2


