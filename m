Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D7635009
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiKWGEV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiKWGEN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:04:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE56F2C0A;
        Tue, 22 Nov 2022 22:04:12 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH9Y73f6LzmW7J;
        Wed, 23 Nov 2022 14:03:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:10 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 09/11] blk-throttle: remove unnecessary check for validation of limit index
Date:   Wed, 23 Nov 2022 14:03:59 +0800
Message-ID: <20221123060401.20392-10-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221123060401.20392-1-shikemeng@huawei.com>
References: <20221123060401.20392-1-shikemeng@huawei.com>
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

We always keep limit index valid as following:
Max limit is always valid and low limit can only be invalidated in
blk_throtl_update_limit_valid. Each time low limit may become invalid
after blk_throtl_update_limit_valid is called, we will check and make
sure current limit index is valid.

It's reasonable to always keep limit index valid, so we can remove this
check.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3eccc7af4368..6f509cadd92b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -418,12 +418,10 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 	for (rw = READ; rw <= WRITE; rw++) {
 		tg->has_rules_iops[rw] =
 			(parent_tg && parent_tg->has_rules_iops[rw]) ||
-			(td->limit_valid[td->limit_index] &&
-			  tg_iops_limit(tg, rw) != UINT_MAX);
+			  (tg_iops_limit(tg, rw) != UINT_MAX);
 		tg->has_rules_bps[rw] =
 			(parent_tg && parent_tg->has_rules_bps[rw]) ||
-			(td->limit_valid[td->limit_index] &&
-			 (tg_bps_limit(tg, rw) != U64_MAX));
+			 (tg_bps_limit(tg, rw) != U64_MAX);
 	}
 }
 
-- 
2.30.0

