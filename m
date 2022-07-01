Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37FF562D2C
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiGAHzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiGAHzO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:55:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F796D54F;
        Fri,  1 Jul 2022 00:55:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LZ6ST0qdBz6Pmfc;
        Fri,  1 Jul 2022 15:35:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWgIpL5igL73AA--.48972S4;
        Fri, 01 Jul 2022 15:36:40 +0800 (CST)
From:   Yu Kuai <yukuai3@huawei.com>
To:     tj@kernel.org, mkoutny@suse.com, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v6 0/8] bugfix and cleanup for blk-throttle
Date:   Fri,  1 Jul 2022 15:49:14 +0800
Message-Id: <20220701074923.657426-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWgIpL5igL73AA--.48972S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4DArW8XF1UuFW5ZFykAFb_yoW8uw1xpF
        WSgr45Cr4UGrnrGw43Cw43XFW5Kan5J345X3sxJ34fuF4qyryDAr1v9w4ruFyIvFZ7K3yI
        qr1jvrn2kFyUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
        FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07
        x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF-BMDUUUU
Sender: yukuai1@huaweicloud.com
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

