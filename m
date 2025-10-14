Return-Path: <cgroups+bounces-10707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF497BD7160
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 04:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1FEB4F6FB1
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B59305076;
	Tue, 14 Oct 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dOP6xvqW"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF142288C6;
	Tue, 14 Oct 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408939; cv=none; b=VSzkeJkvXk1GZRfs4K4/LPaBTj4WWgC6e4nKT8s2UJ+iTl7SPgEU2cU4l0UeUNpL0siPjU4VCwOmgRcE2B7/e5n7nhUe2e4ON1FGYsJ5czW+V56AlnIf5hTrCcL/1NyCx630WsWXr/Dvug4Tycz5xYsh/1cHNE3MLJpy5Qr3R/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408939; c=relaxed/simple;
	bh=t4TmkTnxBxFsPMMgCpLUCqQfV3Ld9evdSq4pBq4ykKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZuN+2YSGqf7N69Uh7krFOWYBo6OO28lbiNTDL/ij/PUxfp/qCie2ChRatr11pbApXHTLvXqWso2zPdMR2FvS9Ct253hymYx5nNEdQEvY7YY4wKjxRKopi3DfF+9z1208j9qjHDzQ79Y2Agl7FoU0ytJRa550odSBQUJf+ovO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dOP6xvqW; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L1Y/dJ23z38rGLpMWBLQrEYtDiYGHHrj1WObdSKChYM=;
	b=dOP6xvqWwTiLG2O3TkqkahCHEdT60fKJv3t7U06dAwnPUsCh1cbGNi3f50NYAa1AZvwBXu5io
	lKgcF4rxEB2cZOIs5txAQHmZs3BJ4njib76cWOU0GkvI3tLGV1wdvUan0Qk9g0TZYUIomiwDC3o
	w4NRyeLlSGyBDGqnjnYBtvg=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4clynV0xygzRhR0;
	Tue, 14 Oct 2025 10:28:30 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id C51F91401E0;
	Tue, 14 Oct 2025 10:28:49 +0800 (CST)
Received: from huawei.com (10.50.87.129) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Oct
 2025 10:28:49 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <nilay@linux.ibm.com>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<johnny.chenyi@huawei.com>
Subject: [PATCH 4/4] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
Date: Tue, 14 Oct 2025 10:21:49 +0800
Message-ID: <20251014022149.947800-5-yukuai3@huawei.com>
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

Because it's only used inside blk-mq-debugfs.c now.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 block/blk-mq-debugfs.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1de9bab7ba80..919e484aa1b2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -14,6 +14,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+
 static int queue_poll_stat_show(void *data, struct seq_file *m)
 {
 	return 0;
@@ -774,7 +776,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	rqos->debugfs_dir = NULL;
 }
 
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 9f76603792fe..d94daa66556b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -33,7 +33,6 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
@@ -75,10 +74,6 @@ static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hc
 {
 }
 
-static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
-{
-}
-
 static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
 {
 }
-- 
2.39.2


