Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E0634FFF
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiKWGET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiKWGEM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:04:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FE729A9;
        Tue, 22 Nov 2022 22:04:12 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH9Y669zwzmW7F;
        Wed, 23 Nov 2022 14:03:38 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:09 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 08/11] blk-throttle: remove repeat check of elapsed time from last upgrade in throtl_hierarchy_can_downgrade
Date:   Wed, 23 Nov 2022 14:03:58 +0800
Message-ID: <20221123060401.20392-9-shikemeng@huawei.com>
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

There is no need to check elapsed time from last upgrade for each node in
hierarchy. Move this check before traversing as throtl_can_upgrade do
to remove repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bd07f562c799..3eccc7af4368 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1932,8 +1932,7 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
-	    time_after_eq(now, tg_last_low_overflow_time(tg) +
+	if (time_after_eq(now, tg_last_low_overflow_time(tg) +
 					td->throtl_slice) &&
 	    (!throtl_tg_is_idle(tg) ||
 	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
@@ -1943,6 +1942,9 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 
 static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
 {
+	if (time_before(now, tg->td->low_upgrade_time + td->throtl_slice))
+		return false;
+
 	while (true) {
 		if (!throtl_tg_can_downgrade(tg))
 			return false;
-- 
2.30.0

