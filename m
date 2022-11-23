Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9D634FF1
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 07:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiKWGEN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 01:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiKWGEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 01:04:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42123F2C09;
        Tue, 22 Nov 2022 22:04:09 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NH9Tv4b8SzJnrS;
        Wed, 23 Nov 2022 14:00:51 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:04:06 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH 05/11] blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
Date:   Wed, 23 Nov 2022 14:03:55 +0800
Message-ID: <20221123060401.20392-6-shikemeng@huawei.com>
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

Cgroup reaches low limit if limit is zero or io is already queued. Cgroup
will pass upgrade check if low limits of READ and WRITE are both reached.
Simpfy the check code described above to removce repeat check and improve
readability. There is no functional change.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-throttle.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 01e30380c19b..322a6ee38fb6 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1800,24 +1800,22 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	return ret;
 }
 
-static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+static bool throtl_tg_reach_low_limit(struct throtl_grp *tg, int rw)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
-	bool read_limit, write_limit;
+	bool limit = tg->bps[rw][LIMIT_LOW] || tg->iops[rw][LIMIT_LOW];
 
 	/*
 	 * if cgroup reaches low limit (if low limit is 0, the cgroup always
 	 * reaches), it's ok to upgrade to next limit
 	 */
-	read_limit = tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW];
-	write_limit = tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW];
-	if (!read_limit && !write_limit)
-		return true;
-	if (read_limit && sq->nr_queued[READ] &&
-	    (!write_limit || sq->nr_queued[WRITE]))
-		return true;
-	if (write_limit && sq->nr_queued[WRITE] &&
-	    (!read_limit || sq->nr_queued[READ]))
+	return !limit || sq->nr_queued[rw].
+}
+
+static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+{
+	if (throtl_tg_reach_low_limit(tg, READ) &&
+	    throtl_tg_reach_low_limit(tg, WRITE))
 		return true;
 
 	if (time_after_eq(jiffies,
-- 
2.30.0

