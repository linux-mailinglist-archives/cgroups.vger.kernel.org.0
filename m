Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7C4CE3D0
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiCEI5s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Mar 2022 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiCEI5m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Mar 2022 03:57:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C897255FB1;
        Sat,  5 Mar 2022 00:56:50 -0800 (PST)
Received: from kwepemi500018.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K9dp84ZlQzBrhP;
        Sat,  5 Mar 2022 16:54:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500018.china.huawei.com (7.221.188.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:56:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 16:56:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next 11/11] block, bfq: cleanup bfqq_group()
Date:   Sat, 5 Mar 2022 17:12:05 +0800
Message-ID: <20220305091205.4188398-12-yukuai3@huawei.com>
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

Now that if bfqq is under root group, 'bfqq->entity.parent' is set to
root group's entity instead of NULL, there is no point for the judgement
in bfqq_group() anymore.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 58acaf14a91d..1fcb13e97cf0 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -307,11 +307,7 @@ static struct bfq_group *bfqg_parent(struct bfq_group *bfqg)
 
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 {
-	struct bfq_entity *group_entity = bfqq->entity.parent;
-
-	return group_entity ? container_of(group_entity, struct bfq_group,
-					   entity) :
-			      bfqq->bfqd->root_group;
+	return container_of(bfqq->entity.parent, struct bfq_group, entity);
 }
 
 /*
-- 
2.31.1

