Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9563B862
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiK2DCH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiK2DB4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D43D92C;
        Mon, 28 Nov 2022 19:01:56 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCr6DsJzCqjd;
        Tue, 29 Nov 2022 11:01:12 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:53 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 06/10] blk-throttle: fix typo in comment of throtl_adjusted_limit
Date:   Tue, 29 Nov 2022 11:01:43 +0800
Message-ID: <20221129030147.27400-7-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221129030147.27400-1-shikemeng@huawei.com>
References: <20221129030147.27400-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

lapsed time -> elapsed time

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4977fac56a00..4b11099625da 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -129,7 +129,7 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 /*
  * cgroup's limit in LIMIT_MAX is scaled if low limit is set. This scale is to
  * make the IO dispatch more smooth.
- * Scale up: linearly scale up according to lapsed time since upgrade. For
+ * Scale up: linearly scale up according to elapsed time since upgrade. For
  *           every throtl_slice, the limit scales up 1/2 .low limit till the
  *           limit hits .max limit
  * Scale down: exponentially scale down if a cgroup doesn't hit its .low limit
-- 
2.30.0

