Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3060347B8DB
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhLUDKA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 22:10:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15954 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhLUDKA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 22:10:00 -0500
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJ1Zg0qBszZdll;
        Tue, 21 Dec 2021 11:06:51 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:09:58 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 11:09:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/4] block, bfq: avoid moving bfqq to it's parent bfqg
Date:   Tue, 21 Dec 2021 11:21:33 +0800
Message-ID: <20211221032135.878550-3-yukuai3@huawei.com>
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

Moving bfqq to it's parent bfqg is pointless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 24a5c5329bcd..0f62546a72d4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -645,6 +645,11 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg)
 {
 	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_group *old_parent = bfq_group(bfqq);
+
+	/* No point to move bfqq to the same group */
+	if (old_parent == bfqg)
+		return;
 
 	/*
 	 * Get extra reference to prevent bfqq from being freed in
@@ -666,7 +671,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_and_blkg_put(bfqq_group(bfqq));
+	bfqg_and_blkg_put(old_parent);
 
 	if (entity->parent &&
 	    entity->parent->last_bfqq_created == bfqq)
-- 
2.31.1

