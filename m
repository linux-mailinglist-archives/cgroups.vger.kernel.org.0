Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D4642207
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 04:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiLED6D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Dec 2022 22:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLED6B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Dec 2022 22:58:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A99FCD3;
        Sun,  4 Dec 2022 19:57:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NQVBS4RdJz4f3rpv;
        Mon,  5 Dec 2022 11:57:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDXfq1CbI1jRaRVBg--.57323S2;
        Mon, 05 Dec 2022 11:57:55 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v3 0/9] A few bugfix and cleanup patches for blk-throttle
Date:   Mon,  5 Dec 2022 19:57:00 +0800
Message-Id: <20221205115709.251489-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXfq1CbI1jRaRVBg--.57323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkKr13Gr4kCrykJrW7XFb_yoW8KFyxpr
        WfZr1rGr4UXrnrGr1Sk3WavayrtaykJw4aqwnF9rZ3JF1vk34kKr129F18Zry7uFZ2ka1v
        vr42yr97GF1DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU01mh7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, this series contain a few patches to fix problem when on the default
hierarchy, corret comment and so on. More details can be found in
respective changelogs. Thanks.

---
V2->V3:
 -Thanks for the review and advice from Tejun. Now all patches are acked
  by Tejun.
 -remove quotes around parent in corrected comment in patch "blk-throttle:
  correct stale comment in throtl_pd_init"
 -improve log message and rename throtl_tg_reach_low_limit to
  throtl_low_limit_reached.
 -drop patch "blk-throttle: avoid dead code in
  throtl_hierarchy_can_upgrade"
---
V1->V2:
 -Thanks for the review and advice from Tejun. The corrected comment of
  "blk-throttle: correct stale comment in throtl_pd_init" and the
  solution of "blk-throttle: Fix that bps of child could exceed bps
  limited in parent" are from reply of Tejun.
 -Collect Ack from Tejun.
 -Fix the compile problem when CONFIG_BLK_DEV_THROTTLING_LOW is set.
 -Drop "blk-throttle: Limit whole system if root group is configured
  when on the default hierarchy", "blk-throttle: remove unnecessary check
  for validation of limit index" and "blk-throttle: remove unused variable
  td in tg_update_has_rules"
 -Add "blk-throttle: correct stale comment in throtl_pd_init" and
  "blk-throttle: avoid dead code in throtl_hierarchy_can_upgrade"
 -Use solution that set the BIO_BPS_THROTTLED flag only when the bio
  traversed the entire tree to fix that bps of child could exceed bps
  limited in parent in patch 2/10.
 -Improve the description and comment of most commits.
---

Kemeng Shi (9):
  blk-throttle: correct stale comment in throtl_pd_init
  blk-throttle: Fix that bps of child could exceed bps limited in parent
  blk-throttle: ignore cgroup without io queued in
    blk_throtl_cancel_bios
  blk-throttle: correct calculation of wait time in tg_may_dispatch
  blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
  blk-throttle: fix typo in comment of throtl_adjusted_limit
  blk-throttle: remove incorrect comment for tg_last_low_overflow_time
  blk-throttle: remove repeat check of elapsed time from last upgrade in
    throtl_hierarchy_can_downgrade
  blk-throttle: Use more siutable time_after check for update of
    slice_start

 block/blk-throttle.c | 102 +++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

-- 
2.30.0

