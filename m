Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1E5EEF63
	for <lists+cgroups@lfdr.de>; Thu, 29 Sep 2022 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiI2Hli (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Sep 2022 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiI2HlS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Sep 2022 03:41:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0975139F64;
        Thu, 29 Sep 2022 00:41:00 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdQD31rKyzWh2W;
        Thu, 29 Sep 2022 15:36:51 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 15:40:57 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 1/3] block: Remove redundant parent blkcg_gp check in check_scale_change
Date:   Thu, 29 Sep 2022 15:40:53 +0800
Message-ID: <20220929074055.30080-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20220929074055.30080-1-shikemeng@huawei.com>
References: <20220929074055.30080-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Function blkcg_iolatency_throttle will make sure blkg->parent is not
NULL before calls check_scale_change. And function check_scale_change
is only called in blkcg_iolatency_throttle.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iolatency.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e285152345a2..a8cc5abe91e5 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -403,9 +403,6 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	u64 scale_lat;
 	int direction = 0;
 
-	if (lat_to_blkg(iolat)->parent == NULL)
-		return;
-
 	parent = blkg_to_lat(lat_to_blkg(iolat)->parent);
 	if (!parent)
 		return;
-- 
2.30.0

