Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22317432BC7
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJSCbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 22:31:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25165 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhJSCbN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 22:31:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HYHh26nmxz1DHbH;
        Tue, 19 Oct 2021 10:27:14 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:28:57 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 10:28:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <avanzini.arianna@gmail.com>, <fchecconi@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 -next 1/2] blk-cgroup: don't call blk_mq_freeze_queue() in blkcg_deactivate_policy()
Date:   Tue, 19 Oct 2021 10:41:31 +0800
Message-ID: <20211019024132.432458-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019024132.432458-1-yukuai3@huawei.com>
References: <20211019024132.432458-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

blkcg_deactivate_policy() can be called from either
blk_cleanup_queue() for all policies or elevator_switch() for bfq
policy. Thus there is no need to freeze queue in
blkcg_deactivate_policy() since the caller freeze the queue aready.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cec86a705c89..ca60233c8392 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1398,9 +1398,6 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
-	if (queue_is_mq(q))
-		blk_mq_freeze_queue(q);
-
 	spin_lock_irq(&q->queue_lock);
 
 	__clear_bit(pol->plid, q->blkcg_pols);
@@ -1419,9 +1416,6 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	}
 
 	spin_unlock_irq(&q->queue_lock);
-
-	if (queue_is_mq(q))
-		blk_mq_unfreeze_queue(q);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
-- 
2.31.1

