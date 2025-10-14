Return-Path: <cgroups+bounces-10703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D6BD713B
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBE7A4F25B1
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313B3043C3;
	Tue, 14 Oct 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DjaLYW3U"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F42E975E;
	Tue, 14 Oct 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408933; cv=none; b=r0CHAlQpL3r1tQKm6PkmS/sKdzDK36GWgzyXl+qYOfOu1UfbGUMRiITbN2a6H4CJjNwqFm6TDXDkxeHYkTFBgUO7FLCXDzJ/QdJ48LeYVsOkb/Q3uBPhJFI2mbr8BecJCjpPbBeCUZj3Y7eqjObANpVT+zMaclxCvqi8wEGvf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408933; c=relaxed/simple;
	bh=NPxRRzFtScXdG9auhMZ3j0+iJAE7hIaDhucri088R14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ci6yjW9jBj6laJO++oRirE8IaEfaMaQGAhV6NWKKtVfzP4GzdXGZiWLwQ+Q/YbOnVSIlPqw13r0Q3srMZttVACivreF6kzs67WXYstGbdWe1WRwokF2sLEhL+gEEAydysMavrAfm45x/vUne0PYVCSfVCCn+bHBGHwR4V+0/tio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DjaLYW3U; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=U1hjB0qTtrdjgi/WXA5posceqyaZ4D57rjh6XcurGsw=;
	b=DjaLYW3UfNLtiO0wkrTsZlMza+8vAf7L/7ez1+ObIkBe4xfIU+dtPLZbs6TNqON815iKa9nKe
	MCfB0G5zr5pkYilRr6+Cf9rDKdoMTqRNPwLPKKPxk7KW3ajS9dk3VpUEhwOA+oS6OEKHWvJxvV/
	x2U3YKqJ1BhlsH+phQv75MA=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4clyn246wCz1T4Gl;
	Tue, 14 Oct 2025 10:28:06 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 495A51402DA;
	Tue, 14 Oct 2025 10:28:49 +0800 (CST)
Received: from huawei.com (10.50.87.129) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Oct
 2025 10:28:48 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <nilay@linux.ibm.com>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<johnny.chenyi@huawei.com>
Subject: [PATCH 3/4] blk-rq-qos: fix possible deadlock
Date: Tue, 14 Oct 2025 10:21:48 +0800
Message-ID: <20251014022149.947800-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251014022149.947800-1-yukuai3@huawei.com>
References: <20251014022149.947800-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500007.china.huawei.com (7.202.194.92)

Currently rq-qos debugfs entries is created from rq_qos_add(), while
rq_qos_add() requires queue to be freezed. This can deadlock because
creating new entries can trigger fs reclaim.

Fix this problem by delaying creating rq-qos debugfs entries until
it's initialization is complete.

- For wbt, it can be initialized by default of by blk-sysfs, fix it by
  calling blk_mq_debugfs_register_rq_qos() after wbt_init;
- For other policies, they can only be initialized by blkg configuration,
  fix it by calling blk_mq_debugfs_register_rq_qos() from
  blkg_conf_end();

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 6 ++++++
 block/blk-rq-qos.c | 7 -------
 block/blk-sysfs.c  | 4 ++++
 block/blk-wbt.c    | 7 ++++++-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d93654334854..e4ccabf132c0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,6 +33,7 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
+#include "blk-mq-debugfs.h"
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
 
@@ -746,6 +747,11 @@ void blkg_conf_end(struct blkg_conf_ctx *ctx)
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, ctx->memflags);
 	blkdev_put_no_open(ctx->bdev);
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 }
 EXPORT_SYMBOL_GPL(blkg_conf_end);
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 654478dfbc20..d7ce99ce2e80 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
 
 	blk_mq_unfreeze_queue(q, memflags);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
 	return 0;
 ebusy:
 	blk_mq_unfreeze_queue(q, memflags);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76c47fe9b8d6..52bb4db25cf5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -688,6 +688,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	mutex_unlock(&disk->rqos_state_mutex);
 
 	blk_mq_unquiesce_queue(q);
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..a120b5ba54db 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -724,8 +724,13 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
+	if (queue_is_mq(q) && enable) {
 		wbt_init(disk);
+
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
-- 
2.39.2


