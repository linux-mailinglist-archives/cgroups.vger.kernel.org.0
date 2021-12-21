Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A047B8E2
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 04:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhLUDKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 22:10:04 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30082 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhLUDKC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 22:10:02 -0500
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JJ1Zj0cY1z1DKBf;
        Tue, 21 Dec 2021 11:06:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:10:00 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 11:09:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 4/4] block, bfq: update pos_root for idle bfq_queue in bfq_bfqq_move()
Date:   Tue, 21 Dec 2021 11:21:35 +0800
Message-ID: <20211221032135.878550-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211221032135.878550-1-yukuai3@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During code review, we found that if bfqq is not busy in
bfq_bfqq_move(), bfq_pos_tree_add_move() won't be called for the bfqq,
thus bfqq->pos_root still points to the old bfqg. However, the ref
that bfqq hold for the old bfqg will be released, so it's possible
that the old bfqg can be freed. This is problematic because the freed
bfqg can still be accessed by bfqq->pos_root.

Fix the problem by calling bfq_pos_tree_add_move() for idle bfqq
as well.

Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 8e8cf6b3d946..822dd28ecf53 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -677,7 +677,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_and_blkg_put(old_parent);
 
 	if (entity->parent &&
 	    entity->parent->last_bfqq_created == bfqq)
@@ -690,11 +689,16 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	/* pin down bfqg and its associated blkg  */
 	bfqg_and_blkg_get(bfqg);
 
-	if (bfq_bfqq_busy(bfqq)) {
-		if (unlikely(!bfqd->nonrot_with_queueing))
-			bfq_pos_tree_add_move(bfqd, bfqq);
+	/*
+	 * Don't leave the pos_root to old bfqg, since the ref to old bfqg will
+	 * be released and the bfqg might be freed.
+	 */
+	if (unlikely(!bfqd->nonrot_with_queueing))
+		bfq_pos_tree_add_move(bfqd, bfqq);
+	bfqg_and_blkg_put(old_parent);
+
+	if (bfq_bfqq_busy(bfqq))
 		bfq_activate_bfqq(bfqd, bfqq);
-	}
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
-- 
2.31.1

