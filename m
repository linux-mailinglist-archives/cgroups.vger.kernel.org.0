Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63C63B86D
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiK2DCL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiK2DB7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE445084;
        Mon, 28 Nov 2022 19:01:58 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCy4y5WzRpX3;
        Tue, 29 Nov 2022 11:01:18 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:56 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 10/10] blk-throttle: avoid dead code in throtl_hierarchy_can_upgrade
Date:   Tue, 29 Nov 2022 11:01:47 +0800
Message-ID: <20221129030147.27400-11-shikemeng@huawei.com>
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

Function throtl_hierarchy_can_upgrade will always return from while loop,
so the return outside while loop is never reached. Break the loop when
we traverse to root as throtl_hierarchy_can_downgrade do to avoid dead
code.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4c80f2aa1e29..9946524de158 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1854,7 +1854,7 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
 			return true;
 		tg = sq_to_tg(tg->service_queue.parent_sq);
 		if (!tg || !tg_to_blkg(tg)->parent)
-			return false;
+			break;
 	}
 	return false;
 }
-- 
2.30.0

