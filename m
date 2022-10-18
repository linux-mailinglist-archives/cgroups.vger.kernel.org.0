Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C76029EF
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJRLMx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Oct 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiJRLMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Oct 2022 07:12:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBBB5FFC;
        Tue, 18 Oct 2022 04:12:47 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsB0x1dRpzmV8Y;
        Tue, 18 Oct 2022 19:08:01 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 19:12:43 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 1/3] block: Remove redundant parent blkcg_gp check in check_scale_change
Date:   Tue, 18 Oct 2022 19:12:38 +0800
Message-ID: <20221018111240.22612-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221018111240.22612-1-shikemeng@huawei.com>
References: <20221018111240.22612-1-shikemeng@huawei.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 571fa95aafe9..b24d7b788ba3 100644
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

