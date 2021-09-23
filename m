Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A01416019
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbhIWNib (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:20002 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhIWNi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HFbgq5vQnzbmDF;
        Thu, 23 Sep 2021 21:32:39 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:36:52 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 21:36:51 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 4/6] blk-iolatency: splict blkcg_iolatency_free() from blkcg_iolatency_exit()
Date:   Thu, 23 Sep 2021 21:46:29 +0800
Message-ID: <20210923134631.105719-5-yukuai3@huawei.com>
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

Prepare to split 'kfree(blkiolat)' from blkcg_iolatency_exit(), no
functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iolatency.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c0545f9da549..f3b8848e6a46 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -648,10 +648,18 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	kfree(blkiolat);
 }
 
+static void blkcg_iolatency_free(struct rq_qos *rqos)
+{
+	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
+
+	kfree(blkiolat);
+}
+
 static struct rq_qos_ops blkcg_iolatency_ops = {
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
+	.free = blkcg_iolatency_free,
 };
 
 static void blkiolatency_timer_fn(struct timer_list *t)
-- 
2.31.1

