Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7D414939
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhIVMnQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 08:43:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:20000 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhIVMnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 08:43:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDyVf31fVzbm3t;
        Wed, 22 Sep 2021 20:37:30 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:41:42 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 22
 Sep 2021 20:41:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 4/4] block: cancel all throttled bios in blk_cleanup_queue()
Date:   Wed, 22 Sep 2021 20:51:15 +0800
Message-ID: <20210922125115.381752-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922125115.381752-1-yukuai3@huawei.com>
References: <20210922125115.381752-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Throttled bios can't be issued after queue is dying in
blk_cleanup_queue(), thus it's better to cancel them immediately
rather than waiting for throttle is done.

For example, if user thread is throttled with low bps while is
issuing large io, and the device is deleted. The user thread will
wait for a long time for io to return.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263..356a56318068 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -389,6 +389,9 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
+	if (q->root_blkg)
+		blk_throtl_cancel_bios(q);
+
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.31.1

