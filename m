Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61E63B863
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiK2DCI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiK2DB6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6C45097;
        Mon, 28 Nov 2022 19:01:57 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLnCx4dyFz15Mxq;
        Tue, 29 Nov 2022 11:01:17 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:55 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 08/10] blk-throttle: remove repeat check of elapsed time from last upgrade in throtl_hierarchy_can_downgrade
Date:   Tue, 29 Nov 2022 11:01:45 +0800
Message-ID: <20221129030147.27400-9-shikemeng@huawei.com>
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

There is no need to check elapsed time from last upgrade for each node in
hierarchy. Move this check before traversing as throtl_can_upgrade do
to remove repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 block/blk-throttle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3ddd8a15aa3f..94d850b57462 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1955,8 +1955,7 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-	if (time_after_eq(now, td->low_upgrade_time + td->throtl_slice) &&
-	    time_after_eq(now, tg_last_low_overflow_time(tg) +
+	if (time_after_eq(now, tg_last_low_overflow_time(tg) +
 					td->throtl_slice) &&
 	    (!throtl_tg_is_idle(tg) ||
 	     !list_empty(&tg_to_blkg(tg)->blkcg->css.children)))
@@ -1966,6 +1965,11 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 
 static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
 {
+	struct throtl_data *td = tg->td;
+
+	if (time_before(jiffies, td->low_upgrade_time + td->throtl_slice))
+		return false;
+
 	while (true) {
 		if (!throtl_tg_can_downgrade(tg))
 			return false;
-- 
2.30.0

