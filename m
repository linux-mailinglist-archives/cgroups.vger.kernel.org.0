Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4DF3E14D7
	for <lists+cgroups@lfdr.de>; Thu,  5 Aug 2021 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHEMg6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Aug 2021 08:36:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16051 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbhHEMg5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Aug 2021 08:36:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgSgl1dh3zZxt4;
        Thu,  5 Aug 2021 20:33:07 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 20:36:41 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 5 Aug
 2021 20:36:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <bo.liu@linux.alibaba.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] blk-iolatency: error out if blk_get_queue() failed in iolatency_set_limit()
Date:   Thu, 5 Aug 2021 20:46:45 +0800
Message-ID: <20210805124645.543797-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If queue is dying while iolatency_set_limit() is in progress,
blk_get_queue() won't increment the refcount of the queue. However,
blk_put_queue() will still decrement the refcount later, which will
cause the refcout to be unbalanced.

Thus error out in such case to fix the problem.

Fixes: 8c772a9bfc7c ("blk-iolatency: fix IO hang due to negative inflight counter")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iolatency.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 81be0096411d..d8b0d8bd132b 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -833,7 +833,11 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 
 	enable = iolatency_set_min_lat_nsec(blkg, lat_val);
 	if (enable) {
-		WARN_ON_ONCE(!blk_get_queue(blkg->q));
+		if (!blk_get_queue(blkg->q)) {
+			ret = -ENODEV;
+			goto out;
+		}
+
 		blkg_get(blkg);
 	}
 
-- 
2.31.1

