Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411746FC46
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbhLJIIZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 03:08:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32901 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbhLJIIY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 03:08:24 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9NjG4pVgzcdVk;
        Fri, 10 Dec 2021 16:04:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:04:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 16:04:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC] block, bfq: update pos_root for idle bfq_queue in bfq_bfqq_move()
Date:   Fri, 10 Dec 2021 16:16:41 +0800
Message-ID: <20211210081641.3025060-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 24a5c5329bcd..85f34c29b909 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -645,6 +645,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg)
 {
 	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_group *old_parent = bfqq_group(bfqq);
 
 	/*
 	 * Get extra reference to prevent bfqq from being freed in
@@ -666,7 +667,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_and_blkg_put(bfqq_group(bfqq));
 
 	if (entity->parent &&
 	    entity->parent->last_bfqq_created == bfqq)
@@ -679,11 +679,16 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
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

