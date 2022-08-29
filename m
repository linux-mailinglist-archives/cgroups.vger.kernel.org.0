Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43E5A40E5
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 04:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiH2CL0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Aug 2022 22:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2CLZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Aug 2022 22:11:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA91EC58;
        Sun, 28 Aug 2022 19:11:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGDR84DtXzl6nJ;
        Mon, 29 Aug 2022 10:09:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenNFIAxjqVZKAA--.51100S4;
        Mon, 29 Aug 2022 10:11:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, mkoutny@suse.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v9 0/4] blk-throttle bugfix
Date:   Mon, 29 Aug 2022 10:22:36 +0800
Message-Id: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenNFIAxjqVZKAA--.51100S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xZFWfWFyUCFW3ZF4xWFg_yoW5Jry8pF
        Wfurs8Cr17CrnrGw43Ca12gFy5Kan5Xr1UWrnxJw1ruF4q9ryUCwn29w45uFyIvrZ7K34I
        qrsrtF92yryUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
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

Changes in v9:
 - renaming the flag BIO_THROTTLED to BIO_BPS_THROTTLED, and always
 apply iops limit in path 1;
 - add tag for patch 4
Changes in v8:
 - use a new solution in patch 1
 - move cleanups to a separate patchset
 - rename bytes/io_skipped to carryover_bytes/ios in patch 4
Changes in v7:
 - add patch 5 to improve handling of re-entered bio for bps limit
 - as suggested by Tejun, add some comments
 - sdd some Acked tag by Tejun
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

Patch 1 fix that blk-throttle can't work if multiple bios are throttle.
Patch 2 fix overflow while calculating wait time.
Patch 3,4 fix io hung due to configuration updates.

Previous version:
v1: https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/
v4: https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
v5: https://lore.kernel.org/all/20220528064330.3471000-1-yukuai3@huawei.com/
v6: https://lore.kernel.org/all/20220701093441.885741-1-yukuai1@huaweicloud.com/
v7: https://lore.kernel.org/all/20220802140415.2960284-1-yukuai1@huaweicloud.com/
v8: https://lore.kernel.org/all/20220823033130.874230-1-yukuai1@huaweicloud.com/

Yu Kuai (4):
  blk-throttle: fix that io throttle can only work for single bio
  blk-throttle: prevent overflow while calculating wait time
  blk-throttle: factor out code to calculate ios/bytes_allowed
  blk-throttle: fix io hung due to configuration updates

 block/bio.c               |   2 -
 block/blk-throttle.c      | 137 +++++++++++++++++++++++++-------------
 block/blk-throttle.h      |  11 ++-
 include/linux/bio.h       |   2 +-
 include/linux/blk_types.h |   2 +-
 5 files changed, 104 insertions(+), 50 deletions(-)

-- 
2.31.1

