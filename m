Return-Path: <cgroups+bounces-10704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1ABD7144
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052B34F334F
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B63043D6;
	Tue, 14 Oct 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KywnTYG0"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6962288C6;
	Tue, 14 Oct 2025 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408934; cv=none; b=ltXmKShts+NRIyHg1J+x8EQpoNC2b3zl2wI98hLcvGaIT/UPUxEhZuKWiPaPVe7sGVRXJnnJj5kSEmi+5/QPKL81DV7XH92CPZDlgdNo7ZGkh+7f+mFQI/MeVqS2I7Gx2zhH4YXz12Ewqu+L+waTZMmypUgLs//JQ9qDTEdE0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408934; c=relaxed/simple;
	bh=Noa5rH2LMOKH3rYhMMEz3fMEyP2sjiInFZH2zhJnaJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ocxr4VKogUV5VqAVC6AS2G9MsHwXIjByyip9XVgDDsQBsMsV6/dy1vVTcRjOhdhawQ/R1lbM4VU1QzelNrYTxSbm8EPtikXuRULgAjwqtRDEJqsJWcJJnBOZS0phmO8tpED4+yJ9psUO+dcpYAwJxB3U1FMzJ1FQWzCEZOS5hwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KywnTYG0; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v5SelAZTA6HduxeSjnW9mQ7hqiKYzrwTzJhzF5+cQiM=;
	b=KywnTYG0O4BVotFgVEToELJ+Q1MRgdN8KuZcHHKGfnPnSIayuslvgyfwjJeVpz1y+ixNyhDKS
	Uso9iJEMAOAvSaTK86GgypO2K2DXj82mEEam4RPD2NrjswRTps5XUBHcIIqGxyxmBgfdhHRCoEe
	K2HSBn2vgVIXIDbPHGGDoRM=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4clyn14Hywz1T4Gl;
	Tue, 14 Oct 2025 10:28:05 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CECB18006C;
	Tue, 14 Oct 2025 10:28:48 +0800 (CST)
Received: from huawei.com (10.50.87.129) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 14 Oct
 2025 10:28:47 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <nilay@linux.ibm.com>, <ming.lei@redhat.com>, <tj@kernel.org>,
	<josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<johnny.chenyi@huawei.com>
Subject: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
Date: Tue, 14 Oct 2025 10:21:46 +0800
Message-ID: <20251014022149.947800-2-yukuai3@huawei.com>
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

Creating new debugfs entries can trigger fs reclaim, hence we can't do
this with queue freezed, meanwhile, other locks that can be held while
queue is freezed should not be held as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4896525b1c05..66864ed0b77f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static void debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
+				 void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	/*
+	 * Creating new debugfs entries with queue freezed has the rist of
+	 * deadlock.
+	 */
+	WARN_ON_ONCE(q->mq_freeze_depth != 0);
+	/*
+	 * debugfs_mutex should not be nested under other locks that can be
+	 * grabbed while queue is freezed.
+	 */
+	lockdep_assert_not_held(&q->elevator_lock);
+	lockdep_assert_not_held(&q->rq_qos_mutex);
+	lockdep_assert_not_held(&q->blkcg_mutex);
+
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
@@ -624,7 +638,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
@@ -650,7 +664,8 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 
-	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
+	debugfs_create_files(hctx->queue, ctx_dir, ctx,
+			     blk_mq_debugfs_ctx_attrs);
 }
 
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -666,7 +681,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	debugfs_create_files(q, hctx->debugfs_dir, hctx,
+			     blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -717,7 +733,7 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	debugfs_create_files(q, q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -766,7 +782,8 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 							 q->debugfs_dir);
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+	debugfs_create_files(q, rqos->debugfs_dir, rqos,
+			     rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
@@ -789,7 +806,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+	debugfs_create_files(q, hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
 }
 
-- 
2.39.2


