Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24F63B865
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 04:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiK2DCH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiK2DB4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 22:01:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B85303F3;
        Mon, 28 Nov 2022 19:01:55 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLnCr1jMyzCqjL;
        Tue, 29 Nov 2022 11:01:12 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 11:01:53 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 05/10] blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
Date:   Tue, 29 Nov 2022 11:01:42 +0800
Message-ID: <20221129030147.27400-6-shikemeng@huawei.com>
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

Commit c79892c557616 ("blk-throttle: add upgrade logic for LIMIT_LOW
state") added upgrade logic for low limit and methioned that
1. "To determine if a cgroup exceeds its limitation, we check if the cgroup
has pending request. Since cgroup is throttled according to the limit,
pending request means the cgroup reaches the limit."
2. "If a cgroup has limit set for both read and write, we consider the
combination of them for upgrade. The reason is read IO and write IO can
interfere with each other. If we do the upgrade based in one direction IO,
the other direction IO could be severly harmed."
Besides, we also determine that cgroup reaches low limit if low limit is 0,
see comment in throtl_tg_can_upgrade.

Collect the information above, the desgin of upgrade check is as following:
1.The low limit is reached if limit is zero or io is already queued.
2.Cgroup will pass upgrade check if low limits of READ and WRITE are both
reached.

Simpfy the check code described above to removce repeat check and improve
readability. There is no functional change.

Detail equivalence proof is as following:
All replaced conditions to return true are as following:
condition 1
(!read_limit && !write_limit)
condition 2
read_limit && sq->nr_queued[READ] && (!write_limit || sq->nr_queued[WRITE])
condition 3
write_limit && sq->nr_queued[WRITE] && (!read_limit || sq->nr_queued[READ])

Transferring condition 2 as following:
read_limit && sq->nr_queued[READ] && (!write_limit || sq->nr_queued[WRITE])
is equivalent to
(read_limit && sq->nr_queued[READ]) &&
(!write_limit || (write_limit && sq->nr_queued[WRITE]))
is equivalent to
condition 2.1
(read_limit && sq->nr_queued[READ] && !write_limit) ||
condition 2.2
(read_limit && sq->nr_queued[READ] &&
(write_limit && sq->nr_queued[WRITE]))

Transferring condition 3 as following:
write_limit && sq->nr_queued[WRITE] && (!read_limit || sq->nr_queued[READ])
is equivalent to
(write_limit && sq->nr_queued[WRITE]) &&
(!read_limit || (read_limit && sq->nr_queued[READ]))
is equivalent to
condition 3.1
((write_limit && sq->nr_queued[WRITE]) && !read_limit) ||
condition 3.2
((write_limit && sq->nr_queued[WRITE]) &&
(read_limit && sq->nr_queued[READ]))

Condition 3.2 is the same as condition 2.2, so all conditions we get to
return are as following:
(!read_limit && !write_limit) (1)
(!read_limit && (write_limit && sq->nr_queued[WRITE])) (3.1)
((read_limit && sq->nr_queued[READ]) && !write_limit) (2.1)
((write_limit && sq->nr_queued[WRITE]) &&
(read_limit && sq->nr_queued[READ])) (2.2)

As we can extract conditions "(a1 || a2) && (b1 || b2)" to:
a1 && b1
a1 && b2
a2 && b1
ab && b2

Considering that:
a1 = !read_limit
a2 = read_limit && sq->nr_queued[READ]
b1 = !write_limit
b2 = write_limit && sq->nr_queued[WRITE]

We can pack replaced conditions to
(!read_limint || (read_limit && sq->nr_queued[READ])) &&
(!write_limit || (write_limit && sq->nr_queued[WRITE])
which is equivalent to
(!read_limint || sq->nr_queued[READ]) &&
(!write_limit || sq->nr_queued[WRITE])

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 block/blk-throttle.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 06e4193b064e..4977fac56a00 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1816,24 +1816,29 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	return ret;
 }
 
-static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+static bool throtl_tg_reach_low_limit(struct throtl_grp *tg, int rw)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
-	bool read_limit, write_limit;
+	bool limit = tg->bps[rw][LIMIT_LOW] || tg->iops[rw][LIMIT_LOW];
 
 	/*
-	 * if cgroup reaches low limit (if low limit is 0, the cgroup always
-	 * reaches), it's ok to upgrade to next limit
+	 * if low limit is zero, low limit is always reached.
+	 * if low limit is non-zero, we can check if there is any request
+	 * is queued to determine if low limit is reached as we throttle
+	 * request according to limit.
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
+	return !limit || sq->nr_queued[rw];
+}
+
+static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+{
+	/*
+	 * cgroup reaches low limit when low limit of READ and WRITE are
+	 * both reached, it's ok to upgrade to next limit if cgroup reaches
+	 * low limit
+	 */
+	if (throtl_tg_reach_low_limit(tg, READ) &&
+	    throtl_tg_reach_low_limit(tg, WRITE))
 		return true;
 
 	if (time_after_eq(jiffies,
-- 
2.30.0

