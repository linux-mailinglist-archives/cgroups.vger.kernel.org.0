Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB514821B7
	for <lists+cgroups@lfdr.de>; Fri, 31 Dec 2021 04:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbhLaDMf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Dec 2021 22:12:35 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30195 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbhLaDMd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Dec 2021 22:12:33 -0500
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JQ99j20lWz8wCT;
        Fri, 31 Dec 2021 11:10:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 11:12:30 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 31 Dec
 2021 11:12:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 2/3] block, bfq: avoid moving bfqq to it's parent bfqg
Date:   Fri, 31 Dec 2021 11:23:53 +0800
Message-ID: <20211231032354.793092-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211231032354.793092-1-yukuai3@huawei.com>
References: <20211231032354.793092-1-yukuai3@huawei.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09ff0bb1042c..5e65b0407e85 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -645,6 +645,14 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg)
 {
 	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_group *old_parent = bfq_group(bfqq);
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

