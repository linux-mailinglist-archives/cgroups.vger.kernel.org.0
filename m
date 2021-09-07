Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E964027F6
	for <lists+cgroups@lfdr.de>; Tue,  7 Sep 2021 13:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhIGLom (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Sep 2021 07:44:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15301 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGLoj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Sep 2021 07:44:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H3k0j4mfVz8srh;
        Tue,  7 Sep 2021 19:43:01 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 19:43:30 +0800
Received: from localhost.huawei.com (10.175.124.27) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 7 Sep 2021 19:43:29 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>
Subject: [PATCH] blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()
Date:   Tue, 7 Sep 2021 20:12:42 +0800
Message-ID: <20210907121242.2885564-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema773-chm.china.huawei.com (10.1.198.217)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Li Jinlin <lijinlin3@huawei.com>

The pending timer has been set up in blk_throtl_init(). However, the
timer is not deleted in blk_throtl_exit(). This means that the timer
handler may still be running after freeing the timer, which would
result in a use-after-free.

Fix by calling del_timer_sync() to delete the timer in blk_throtl_exit().

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 block/blk-throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 55c49015e533..dbe49e181a88 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2458,6 +2458,7 @@ int blk_throtl_init(struct request_queue *q)
 void blk_throtl_exit(struct request_queue *q)
 {
 	BUG_ON(!q->td);
+	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
 	free_percpu(q->td->latency_buckets[READ]);
-- 
2.27.0

