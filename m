Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC95D442553
	for <lists+cgroups@lfdr.de>; Tue,  2 Nov 2021 02:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKBB47 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Nov 2021 21:56:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30892 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBB47 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Nov 2021 21:56:59 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HjtBC32Nkzcb4n;
        Tue,  2 Nov 2021 09:49:39 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 09:54:19 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 09:54:18 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <yukuai3@huawei.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH] blk-cgroup: fix missing put device in error path from blkg_conf_pref()
Date:   Tue, 2 Nov 2021 10:07:05 +0800
Message-ID: <20211102020705.2321858-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If blk_queue_enter() failed due to queue is dying, the
blkdev_put_no_open() is needed because blkcg_conf_open_bdev() succeeded.

Fixes: 0c9d338c8443 ("blk-cgroup: synchronize blkg creation against policy deactivation")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 88b1fce90520..663aabfeba18 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -640,7 +640,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	 */
 	ret = blk_queue_enter(q, 0);
 	if (ret)
-		return ret;
+		goto fail;
 
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
@@ -676,13 +676,13 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
-			goto fail;
+			goto fail_exit_queue;
 		}
 
 		if (radix_tree_preload(GFP_KERNEL)) {
 			blkg_free(new_blkg);
 			ret = -ENOMEM;
-			goto fail;
+			goto fail_exit_queue;
 		}
 
 		rcu_read_lock();
@@ -722,9 +722,10 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
+fail_exit_queue:
+	blk_queue_exit(q);
 fail:
 	blkdev_put_no_open(bdev);
-	blk_queue_exit(q);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
-- 
2.31.1

