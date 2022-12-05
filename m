Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A54642215
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 04:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiLED6G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Dec 2022 22:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiLED6C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Dec 2022 22:58:02 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9731FD17;
        Sun,  4 Dec 2022 19:57:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NQVBV5VpZz4f3rq2;
        Mon,  5 Dec 2022 11:57:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDXfq1CbI1jRaRVBg--.57323S7;
        Mon, 05 Dec 2022 11:57:57 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v3 5/9] blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
Date:   Mon,  5 Dec 2022 19:57:05 +0800
Message-Id: <20221205115709.251489-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221205115709.251489-1-shikemeng@huaweicloud.com>
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXfq1CbI1jRaRVBg--.57323S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1xXw48AFy5tw1kWw45ZFb_yoW7Xw4Dpr
        ZFkrZ8Jw1UJFsxWwn8tF4Ska4Fg3y7GFW3Ar97KrsrAr1UGFnxWF9xJrySqF1SgF93Wa1r
        ZF4DZa98WF1UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kemeng Shi <shikemeng@huawei.com>

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
  read_limit && sq->nr_queued[READ] &&
  (!write_limit || sq->nr_queued[WRITE])
condition 3
  write_limit && sq->nr_queued[WRITE] &&
  (!read_limit || sq->nr_queued[READ])

Transferring condition 2 as following:
  (read_limit && sq->nr_queued[READ]) &&
  (!write_limit || sq->nr_queued[WRITE])
is equivalent to
  (read_limit && sq->nr_queued[READ]) &&
  (!write_limit || (write_limit && sq->nr_queued[WRITE]))
is equivalent to
condition 2.1
  (read_limit && sq->nr_queued[READ] &&
  !write_limit) ||
condition 2.2
  (read_limit && sq->nr_queued[READ] &&
  (write_limit && sq->nr_queued[WRITE]))

Transferring condition 3 as following:
  write_limit && sq->nr_queued[WRITE] &&
  (!read_limit || sq->nr_queued[READ])
is equivalent to
  (write_limit && sq->nr_queued[WRITE]) &&
  (!read_limit || (read_limit && sq->nr_queued[READ]))
is equivalent to
condition 3.1
  ((write_limit && sq->nr_queued[WRITE]) &&
  !read_limit) ||
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
  (!read_limit || (read_limit && sq->nr_queued[READ])) &&
  (!write_limit || (write_limit && sq->nr_queued[WRITE]))
which is equivalent to
  (!read_limit || sq->nr_queued[READ]) &&
  (!write_limit || sq->nr_queued[WRITE])

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-throttle.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d5b7a2354ad7..1623507ed56e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1816,24 +1816,29 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	return ret;
 }
 
-static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
+static bool throtl_low_limit_reached(struct throtl_grp *tg, int rw)
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
+	if (throtl_low_limit_reached(tg, READ) &&
+	    throtl_low_limit_reached(tg, WRITE))
 		return true;
 
 	if (time_after_eq(jiffies,
-- 
2.30.0

