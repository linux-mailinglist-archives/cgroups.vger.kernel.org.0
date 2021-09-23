Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C08416012
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbhIWNi0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9913 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhIWNiZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFbgQ0htwz8ykf;
        Thu, 23 Sep 2021 21:32:18 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH 2/6] blk-wbt: introduce wbt_free()
Date:   Thu, 23 Sep 2021 21:46:27 +0800
Message-ID: <20210923134631.105719-3-yukuai3@huawei.com>
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

Prepare to split 'kfree(rwb)' from wbt_exit(), no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 874c1c37bf0c..4190453d5e0b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -694,6 +694,13 @@ static void wbt_exit(struct rq_qos *rqos)
 	kfree(rwb);
 }
 
+static void wbt_free(struct rq_qos *rqos)
+{
+	struct rq_wb *rwb = RQWB(rqos);
+
+	kfree(rwb);
+}
+
 /*
  * Disable wbt, if enabled by default.
  */
@@ -808,6 +815,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.cleanup = wbt_cleanup,
 	.queue_depth_changed = wbt_queue_depth_changed,
 	.exit = wbt_exit,
+	.free = wbt_free,
 #ifdef CONFIG_BLK_DEBUG_FS
 	.debugfs_attrs = wbt_debugfs_attrs,
 #endif
-- 
2.31.1

