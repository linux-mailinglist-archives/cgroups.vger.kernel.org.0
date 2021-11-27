Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB145FDE8
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354586AbhK0KEj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28182 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353952AbhK0KCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:37 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J1RqX1Lyfz8vfT;
        Sat, 27 Nov 2021 17:57:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:22 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:21 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 1/9] block, bfq: add new apis to iterate bfq entities
Date:   Sat, 27 Nov 2021 18:11:24 +0800
Message-ID: <20211127101132.486806-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211127101132.486806-1-yukuai3@huawei.com>
References: <20211127101132.486806-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The old and the new apis are the same currently, prepare to count
root group into 'num_groups_with_pending_reqs'. The old apis will be
used to iterate with root group's entity, and the new apis will be
used to iterate without root group's entity.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a73488eec8a4..f5afc80ff11c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1034,9 +1034,20 @@ extern struct blkcg_policy blkcg_policy_bfq;
 #define for_each_entity_safe(entity, parent) \
 	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
 
+#define is_root_entity(entity) \
+	(entity->sched_data == NULL)
+
+#define for_each_entity_not_root(entity) \
+	for (; entity && !is_root_entity(entity); entity = entity->parent)
+
+#define for_each_entity_not_root_safe(entity, parent) \
+	for (; entity && !is_root_entity(entity) && \
+	       ({ parent = entity->parent; 1; }); entity = parent)
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
+#define is_root_entity(entity) (false)
+
 /*
- * Next two macros are fake loops when cgroups support is not
+ * Next four macros are fake loops when cgroups support is not
  * enabled. I fact, in such a case, there is only one level to go up
  * (to reach the root group).
  */
@@ -1045,6 +1056,12 @@ extern struct blkcg_policy blkcg_policy_bfq;
 
 #define for_each_entity_safe(entity, parent) \
 	for (parent = NULL; entity ; entity = parent)
+
+#define for_each_entity_not_root(entity) \
+	for (; entity ; entity = NULL)
+
+#define for_each_entity_not_root_safe(entity, parent) \
+	for (parent = NULL; entity ; entity = parent)
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
-- 
2.31.1

