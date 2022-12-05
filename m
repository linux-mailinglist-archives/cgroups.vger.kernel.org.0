Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D43642216
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 04:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLED6H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Dec 2022 22:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiLED6C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Dec 2022 22:58:02 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBEFD29;
        Sun,  4 Dec 2022 19:58:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NQVBW1ZTyz4f3pG9;
        Mon,  5 Dec 2022 11:57:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDXfq1CbI1jRaRVBg--.57323S10;
        Mon, 05 Dec 2022 11:57:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v3 8/9] blk-throttle: remove repeat check of elapsed time from last upgrade in throtl_hierarchy_can_downgrade
Date:   Mon,  5 Dec 2022 19:57:08 +0800
Message-Id: <20221205115709.251489-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221205115709.251489-1-shikemeng@huaweicloud.com>
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXfq1CbI1jRaRVBg--.57323S10
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrJFyUAF4xGF4UJr1rXrb_yoW8XFyrpF
        W3ArWUKr1kWrsFkr43t3ZxWay8Kw4xGry5t3s8Wr43AF4Uuw1UGF13CF1Fqa40vF9a9w40
        yr4ayry8Ka1UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is no need to check elapsed time from last upgrade for each node in
hierarchy. Move this check before traversing as throtl_can_upgrade do
to remove repeat check.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-throttle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e6a087de414d..413e668249cf 100644
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

