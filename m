Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3D41600F
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbhIWNi0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9914 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhIWNiZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFbgQ3mcMz8yCm;
        Thu, 23 Sep 2021 21:32:18 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:36:51 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 21:36:51 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/6] io-cost: introduce ioc_rqos_free()
Date:   Thu, 23 Sep 2021 21:46:28 +0800
Message-ID: <20210923134631.105719-4-yukuai3@huawei.com>
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

Prepare to split 'kfree(ioc)' from ioc_rqos_exit(), no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b3880e4ba22a..b4a6c1f70eb0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2813,6 +2813,13 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static void ioc_rqos_free(struct rq_qos *rqos)
+{
+	struct ioc *ioc = rqos_to_ioc(rqos);
+
+	kfree(ioc);
+}
+
 static struct rq_qos_ops ioc_rqos_ops = {
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
@@ -2820,6 +2827,7 @@ static struct rq_qos_ops ioc_rqos_ops = {
 	.done = ioc_rqos_done,
 	.queue_depth_changed = ioc_rqos_queue_depth_changed,
 	.exit = ioc_rqos_exit,
+	.free = ioc_rqos_free,
 };
 
 static int blk_iocost_init(struct request_queue *q)
-- 
2.31.1

