Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E325562FC0
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiGAJWF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiGAJWD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 05:22:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E358FC0;
        Fri,  1 Jul 2022 02:22:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LZ8nx1Yf1z6S2BH;
        Fri,  1 Jul 2022 17:21:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mm1vL5i6ab6AA--.40529S4;
        Fri, 01 Jul 2022 17:21:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RESEND v6 0/8] bugfix and cleanup for blk-throttle
Date:   Fri,  1 Jul 2022 17:34:33 +0800
Message-Id: <20220701093441.885741-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mm1vL5i6ab6AA--.40529S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4DArW8XF1UuFW5ZFykAFb_yoW8tr43pF
        WSgr45Cr4UCrnrGw43Cw43XFW5Ga1kJ345X3sxJ34fuF4qyryDAr1v9w4ruFyIvFZ7K3yI
        qr1jvrn2kFyUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
        Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UHnQUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Resend v5 by a new mail address(huaweicloud.com) because old
address(huawei.com)has some problem that emails can end up in spam.
Please let me know if anyone still see this patchset end up in spam.

Changes in v6:
 - rename parameter in patch 3
 - add comments and reviewed tag for patch 4
Changes in v5:
 - add comments in patch 4
 - clear bytes/io_skipped in throtl_start_new_slice_with_credit() in
 patch 4
 - and cleanup patches 5-8
Changes in v4:
 - add reviewed-by tag for patch 1
 - add patch 2,3
 - use a different way to fix io hung in patch 4
Changes in v3:
 - fix a check in patch 1
 - fix link err in patch 2 on 32-bit platform
 - handle overflow in patch 2
Changes in v2:
 - use a new solution suggested by Ming
 - change the title of patch 1
 - add patch 2

Patch 1 fix that blk-throttle can't work if multiple bios are throttle,
Patch 2 fix overflow while calculating wait time
Patch 3,4 fix io hung due to configuration updates.
Patch 5-8 are cleanup patches, there are no functional changes, just
some places that I think can be optimized during code review.

Previous version:
v1: https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/
v4: https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
v5: https://lore.kernel.org/all/20220528064330.3471000-1-yukuai3@huawei.com/

Yu Kuai (8):
  blk-throttle: fix that io throttle can only work for single bio
  blk-throttle: prevent overflow while calculating wait time
  blk-throttle: factor out code to calculate ios/bytes_allowed
  blk-throttle: fix io hung due to config updates
  blk-throttle: use 'READ/WRITE' instead of '0/1'
  blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
  blk-throttle: cleanup tg_update_disptime()
  blk-throttle: clean up flag 'THROTL_TG_PENDING'

 block/blk-throttle.c | 168 +++++++++++++++++++++++++++++--------------
 block/blk-throttle.h |  16 +++--
 2 files changed, 128 insertions(+), 56 deletions(-)

-- 
2.31.1

