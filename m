Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2024A2B13
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 02:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbiA2Bsp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 20:48:45 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32131 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352083AbiA2Bsm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 20:48:42 -0500
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jlxx05GsFz8wWB;
        Sat, 29 Jan 2022 09:45:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 09:48:40 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 29 Jan
 2022 09:48:39 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 2/3] block, bfq: avoid moving bfqq to it's parent bfqg
Date:   Sat, 29 Jan 2022 09:59:23 +0800
Message-ID: <20220129015924.3958918-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220129015924.3958918-1-yukuai3@huawei.com>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Moving bfqq to it's parent bfqg is pointless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 24a5c5329bcd..9783c1156159 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -645,6 +645,14 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg)
 {
 	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_group *old_parent = bfqq_group(bfqq);
+
+	/*
+	 * No point to move bfqq to the same group, which can happen when
+	 * root group is offlined
+	 */
+	if (old_parent == bfqg)
+		return;
 
 	/*
 	 * Get extra reference to prevent bfqq from being freed in
@@ -666,7 +674,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_and_blkg_put(bfqq_group(bfqq));
+	bfqg_and_blkg_put(old_parent);
 
 	if (entity->parent &&
 	    entity->parent->last_bfqq_created == bfqq)
-- 
2.31.1

