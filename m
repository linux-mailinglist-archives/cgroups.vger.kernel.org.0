Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F54CE3BB
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCEI5d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCEI5c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE600254A92;
        Sat,  5 Mar 2022 00:56:42 -0800 (PST)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9dpd5r8hzdcJs;
        Sat,  5 Mar 2022 16:55:21 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:56:40 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:40 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 01/11] block, bfq: add new apis to iterate bfq entities
Date:   Sat, 5 Mar 2022 17:11:55 +0800
Message-ID: <20220305091205.4188398-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220305091205.4188398-1-yukuai3@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 3b83e3d1c2e5..d703492714e2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1037,9 +1037,20 @@ extern struct blkcg_policy blkcg_policy_bfq;
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
@@ -1048,6 +1059,12 @@ extern struct blkcg_policy blkcg_policy_bfq;
 
 #define for_each_entity_safe(entity, parent) \
 	for (parent = NULL; entity ; entity = parent)
+
+#define for_each_entity_not_root(entity) \
+	for (; entity ; entity = NULL)
+
+#define for_each_entity_not_root_safe(entity, parent) \
+	for (parent = NULL; entity ; entity = parent)
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
-- 
2.31.1

