Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94DA5BA72E
	for <lists+cgroups@lfdr.de>; Fri, 16 Sep 2022 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIPHI5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Sep 2022 03:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIPHIx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Sep 2022 03:08:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3459A346F;
        Fri, 16 Sep 2022 00:08:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTQ9q288hzl74K;
        Fri, 16 Sep 2022 15:07:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXP9ICRj02qwAw--.33483S4;
        Fri, 16 Sep 2022 15:08:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [patch v11 0/6] support concurrent sync io for bfq on a specail occasion
Date:   Fri, 16 Sep 2022 15:19:36 +0800
Message-Id: <20220916071942.214222-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXP9ICRj02qwAw--.33483S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8Kw17Ary7GrWrtFWUJwb_yoWrZFW3p3
        yfKwsxWr45tr13JwsxGw1UXasYq3WrJryUWwnxX34rCrsrZr1rA3Wvkw4rZFyxAF93Jw42
        qa1aq3ZYk34UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v11:
 - keep the comments in bfq_weights_tree_remove() and move it to the
 caller where bfqq can be freed.
 - add two followed up cleanup patches.

Changes in v10:
 - Add reviewed-tag for patch 2

Changes in v9:
 - also update how many bfqqs have pending_reqs bfq_bfqq_move().
 - fix one language in patch 4
 - Add reviewed-tag for patch 1,3,4

Changes in v8:
 - Instead of using whether bfqq is busy, using whether bfqq has pending
 requests. As Paolo pointed out the former way is problematic.

Changes in v7:
 - fix mismatch bfq_inc/del_busy_queues() and bfqq_add/del_bfqq_busy(),
 also retest this patchset on v5.18 to make sure functionality is
 correct.
 - move the updating of 'bfqd->busy_queues' into new apis

Changes in v6:
 - add reviewed-by tag for patch 1

Changes in v5:
 - rename bfq_add_busy_queues() to bfq_inc_busy_queues() in patch 1
 - fix wrong definition in patch 1
 - fix spelling mistake in patch 2: leaset -> least
 - update comments in patch 3
 - add reviewed-by tag in patch 2,3

Changes in v4:
 - split bfq_update_busy_queues() to bfq_add/dec_busy_queues(),
   suggested by Jan Kara.
 - remove unused 'in_groups_with_pending_reqs',

Changes in v3:
 - remove the cleanup patch that is irrelevant now(I'll post it
   separately).
 - instead of hacking wr queues and using weights tree insertion/removal,
   using bfq_add/del_bfqq_busy() to count the number of groups
   (suggested by Jan Kara).

Changes in v2:
 - Use a different approch to count root group, which is much simple.

Currently, bfq can't handle sync io concurrently as long as they
are not issued from root group. This is because
'bfqd->num_groups_with_pending_reqs > 0' is always true in
bfq_asymmetric_scenario().

The way that bfqg is counted into 'num_groups_with_pending_reqs':

Before this patchset:
 1) root group will never be counted.
 2) Count if bfqg or it's child bfqgs have pending requests.
 3) Don't count if bfqg and it's child bfqgs complete all the requests.

After this patchset:
 1) root group is counted.
 2) Count if bfqg has pending requests.
 3) Don't count if bfqg complete all the requests.

With the above changes, concurrent sync io can be supported if only
one group is activated.

fio test script(startdelay is used to avoid queue merging):
[global]
filename=/dev/sda
allow_mounted_write=0
ioengine=psync
direct=1
ioscheduler=bfq
offset_increment=10g
group_reporting
rw=randwrite
bs=4k

[test1]
numjobs=1

[test2]
startdelay=1
numjobs=1

[test3]
startdelay=2
numjobs=1

[test4]
startdelay=3
numjobs=1

[test5]
startdelay=4
numjobs=1

[test6]
startdelay=5
numjobs=1

[test7]
startdelay=6
numjobs=1

[test8]
startdelay=7
numjobs=1

test result:
running fio on root cgroup
v5.18:	   112 Mib/s
v5.18-patched: 112 Mib/s

running fio on non-root cgroup
v5.18:	   51.2 Mib/s
v5.18-patched: 112 Mib/s

Note that I also test null_blk with "irqmode=2
completion_nsec=100000000(100ms) hw_queue_depth=1", and tests show
that service guarantees are still preserved.

Previous versions:
RFC: https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/
v1: https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
v4: https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/
v5: https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/
v6: https://lore.kernel.org/all/20220523131818.2798712-1-yukuai3@huawei.com/
v7: https://lore.kernel.org/all/20220528095020.186970-1-yukuai3@huawei.com/


Yu Kuai (6):
  block, bfq: support to track if bfqq has pending requests
  block, bfq: record how many queues have pending requests
  block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one group is activated
  block, bfq: cleanup bfq_weights_tree add/remove apis
  block, bfq: cleanup __bfq_weights_tree_remove()

 block/bfq-cgroup.c  | 10 +++++++
 block/bfq-iosched.c | 71 +++++++--------------------------------------
 block/bfq-iosched.h | 30 +++++++++----------
 block/bfq-wf2q.c    | 69 ++++++++++++++++++++++++++-----------------
 4 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.31.1

