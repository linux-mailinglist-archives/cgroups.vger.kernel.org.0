Return-Path: <cgroups+bounces-10705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B03DBD7150
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823764F28DC
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9896E304BD7;
	Tue, 14 Oct 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QJjqvb51"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D4304BC1;
	Tue, 14 Oct 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408938; cv=none; b=lAnF8MH/eG+O9GATJjVAEExGxWlJ21n+IIn20nMH+e/Lns1RKKg6lA7GqfPN0WfdHws2jiQcgny+tfBdvN08zjL5RpQ/xVA6xpZQWUQrREOHzmiaYTfoTH9qrgCupake51eDRPRO/S5uTCaQeGYyeWlPbtI0kNBDXwZOz9VsvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408938; c=relaxed/simple;
	bh=pDgBsjcnO4PnoDSdWUg8hLSZaLLNuu6oc+5r6/FtMtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq4JWa6fmIzxDsN7OOGt1IyBA9GWLBbw+oX2ddoqrNoVrv9fqhq7VppQg2eqY0ewD2RRaSte4hJgEhYVHQOR1nxk7wRv2JtYUK4vqP75/8IA7Dfttt9wcO6+BXzPnrnN/JunnS7/a7AYbkR8gpSeaLQohuc+D2Ffdo1jhyFevuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QJjqvb51; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YNcTBLxNG3SN4ulnOBC7R6JQgBkk1lAYrEhvD/MrSlI=;
	b=QJjqvb51wkZRnZf2+O8o9/f+GaH76SPXEuHsQCFheLJ1wPJMYsekaYXpZhWTs/Qy1sfDB0HML
	jzCNY+8SXlBTKTw1MUOdK5OGZhcTwCO57x6zXZflSU7FMlAqEYYEL+gPJ7yH7LKLdCjoaYYvWk0
	7lLjHUOL9jiuISR5hJGu+XI=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4clynT19KzzRhR0;
	Tue, 14 Oct 2025 10:28:29 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id CCF3C18006C;
	Tue, 14 Oct 2025 10:28:48 +0800 (CST)
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
Subject: [PATCH 2/4] blk-mq-debugfs: factor out a helper blk_mq_debugfs_register_rq_qos()
Date: Tue, 14 Oct 2025 10:21:47 +0800
Message-ID: <20251014022149.947800-3-yukuai3@huawei.com>
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

Prepare to fix possible deadlock to create blk-mq debugfs entries while
queue is still freezed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c | 23 +++++++++++++++--------
 block/blk-mq-debugfs.h |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 66864ed0b77f..1de9bab7ba80 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -633,6 +633,20 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 				    (void *)attr, data, &blk_mq_debugfs_fops);
 }
 
+void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
+{
+	lockdep_assert_held(&q->debugfs_mutex);
+
+	if (q->rq_qos) {
+		struct rq_qos *rqos = q->rq_qos;
+
+		while (rqos) {
+			blk_mq_debugfs_register_rqos(rqos);
+			rqos = rqos->next;
+		}
+	}
+}
+
 void blk_mq_debugfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -645,14 +659,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 			blk_mq_debugfs_register_hctx(q, hctx);
 	}
 
-	if (q->rq_qos) {
-		struct rq_qos *rqos = q->rq_qos;
-
-		while (rqos) {
-			blk_mq_debugfs_register_rqos(rqos);
-			rqos = rqos->next;
-		}
-	}
+	blk_mq_debugfs_register_rq_qos(q);
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index c80e453e3014..9f76603792fe 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -34,6 +34,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
@@ -78,6 +79,10 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 }
 
+static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
+{
+}
+
 static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 }
-- 
2.39.2


