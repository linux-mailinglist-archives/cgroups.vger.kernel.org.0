Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B993041600C
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbhIWNiZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16234 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhIWNiY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HFblH5ybTz1DHD0;
        Thu, 23 Sep 2021 21:35:39 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:36:51 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 21:36:50 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 1/6] rq-qos: introduce rq_qos_free()
Date:   Thu, 23 Sep 2021 21:46:26 +0800
Message-ID: <20210923134631.105719-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923134631.105719-1-yukuai3@huawei.com>
References: <20210923134631.105719-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prepare to split the release of rq_qos from blk_cleanup_queue() to
blk_release_queue() to fix a uaf problem, no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-rq-qos.c | 10 ++++++++++
 block/blk-rq-qos.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 14ff6d37698c..bc22d0312765 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -308,3 +308,13 @@ void rq_qos_exit(struct request_queue *q)
 		rqos->ops->exit(rqos);
 	}
 }
+
+void rq_qos_free(struct request_queue *q)
+{
+	while (q->rq_qos) {
+		struct rq_qos *rqos = q->rq_qos;
+
+		q->rq_qos = rqos->next;
+		rqos->ops->free(rqos);
+	}
+}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index f000f83e0621..0af5750bb737 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -46,6 +46,7 @@ struct rq_qos_ops {
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
+	void (*free)(struct rq_qos *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
 
@@ -215,5 +216,6 @@ static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 }
 
 void rq_qos_exit(struct request_queue *);
+void rq_qos_free(struct request_queue *);
 
 #endif
-- 
2.31.1

