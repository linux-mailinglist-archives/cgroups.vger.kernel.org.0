Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9131063AC2B
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiK1PXi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 10:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiK1PXe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 10:23:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B325EA;
        Mon, 28 Nov 2022 07:23:33 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NLTf902d3zqSkM;
        Mon, 28 Nov 2022 23:19:29 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:23:29 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:23:29 +0800
From:   Li Nan <linan122@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linan122@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 6/8] blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refresh_params()
Date:   Mon, 28 Nov 2022 23:44:32 +0800
Message-ID: <20221128154434.4177442-7-linan122@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128154434.4177442-1-linan122@huawei.com>
References: <20221128154434.4177442-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

vrate_min is calculated by DIV64_U64_ROUND_UP, but vrate_max is calculated
by div64_u64. Vrate_min may be 1 greater than vrate_max if the input
values min and max of cost.qos are equal.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a4fa17ebb2fa..03977385449f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -926,7 +926,7 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 
 	ioc->vrate_min = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MIN] *
 					    VTIME_PER_USEC, MILLION);
-	ioc->vrate_max = div64_u64((u64)ioc->params.qos[QOS_MAX] *
+	ioc->vrate_max = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MAX] *
 				   VTIME_PER_USEC, MILLION);
 
 	return true;
-- 
2.31.1

