Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97641601B
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbhIWNia (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9915 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbhIWNi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFbgR34cdz8ylw;
        Thu, 23 Sep 2021 21:32:19 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:36:52 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 21:36:52 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 5/6] blk-ioprio: introduce blkcg_ioprio_free()
Date:   Thu, 23 Sep 2021 21:46:30 +0800
Message-ID: <20210923134631.105719-6-yukuai3@huawei.com>
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

Prepare to split 'kfree(blkioprio_blkg)' from blkcg_ioprio_exit(),
no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioprio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 332a07761bf8..55338ebee356 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -212,9 +212,18 @@ static void blkcg_ioprio_exit(struct rq_qos *rqos)
 	kfree(blkioprio_blkg);
 }
 
+static void blkcg_ioprio_free(struct rq_qos *rqos)
+{
+	struct blk_ioprio *blkioprio_blkg =
+		container_of(rqos, typeof(*blkioprio_blkg), rqos);
+
+	kfree(blkioprio_blkg);
+}
+
 static struct rq_qos_ops blkcg_ioprio_ops = {
 	.track	= blkcg_ioprio_track,
 	.exit	= blkcg_ioprio_exit,
+	.free	= blkcg_ioprio_free,
 };
 
 int blk_ioprio_init(struct request_queue *q)
-- 
2.31.1

