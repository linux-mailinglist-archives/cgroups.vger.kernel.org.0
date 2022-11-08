Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53C620CEF
	for <lists+cgroups@lfdr.de>; Tue,  8 Nov 2022 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiKHKNG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKHKNF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 05:13:05 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8011828;
        Tue,  8 Nov 2022 02:13:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N63nj0JMMz4f3wRR;
        Tue,  8 Nov 2022 18:12:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDHcK+qK2pjh8qrAA--.29617S4;
        Tue, 08 Nov 2022 18:13:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] block, bfq: fix null pointer dereference in bfq_bio_bfqg()
Date:   Tue,  8 Nov 2022 18:34:34 +0800
Message-Id: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHcK+qK2pjh8qrAA--.29617S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DJrW8XrW3XrW8Kr1UGFg_yoWrKrykpr
        W3tr4UCr48tr15JF4jyr1UJryUtF4fAF1UJrWxZr15tF1Uuw1UJF1UAr4UJryrJF45XF13
        Jw17Jw18tr1UtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
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

Out test found a following problem in kernel 5.10, and the same problem
should exist in mainline:

BUG: kernel NULL pointer dereference, address: 0000000000000094
PGD 0 P4D 0
Oops: 0000 [#1] SMP
CPU: 7 PID: 155 Comm: kworker/7:1 Not tainted 5.10.0-01932-g19e0ace2ca1d-dirty 4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-b4
Workqueue: kthrotld blk_throtl_dispatch_work_fn
RIP: 0010:bfq_bio_bfqg+0x52/0xc0
Code: 94 00 00 00 00 75 2e 48 8b 40 30 48 83 05 35 06 c8 0b 01 48 85 c0 74 3d 4b
RSP: 0018:ffffc90001a1fba0 EFLAGS: 00010002
RAX: ffff888100d60400 RBX: ffff8881132e7000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffff888103580a18 RDI: ffff888103580a18
RBP: ffff8881132e7000 R08: 0000000000000000 R09: ffffc90001a1fe10
R10: 0000000000000a20 R11: 0000000000034320 R12: 0000000000000000
R13: ffff888103580a18 R14: ffff888114447000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88881fdc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000094 CR3: 0000000100cdb000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bfq_bic_update_cgroup+0x3c/0x350
 ? ioc_create_icq+0x42/0x270
 bfq_init_rq+0xfd/0x1060
 bfq_insert_requests+0x20f/0x1cc0
 ? ioc_create_icq+0x122/0x270
 blk_mq_sched_insert_requests+0x86/0x1d0
 blk_mq_flush_plug_list+0x193/0x2a0
 blk_flush_plug_list+0x127/0x170
 blk_finish_plug+0x31/0x50
 blk_throtl_dispatch_work_fn+0x151/0x190
 process_one_work+0x27c/0x5f0
 worker_thread+0x28b/0x6b0
 ? rescuer_thread+0x590/0x590
 kthread+0x153/0x1b0
 ? kthread_flush_work+0x170/0x170
 ret_from_fork+0x1f/0x30
Modules linked in:
CR2: 0000000000000094
---[ end trace e2e59ac014314547 ]---
RIP: 0010:bfq_bio_bfqg+0x52/0xc0
Code: 94 00 00 00 00 75 2e 48 8b 40 30 48 83 05 35 06 c8 0b 01 48 85 c0 74 3d 4b
RSP: 0018:ffffc90001a1fba0 EFLAGS: 00010002
RAX: ffff888100d60400 RBX: ffff8881132e7000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffff888103580a18 RDI: ffff888103580a18
RBP: ffff8881132e7000 R08: 0000000000000000 R09: ffffc90001a1fe10
R10: 0000000000000a20 R11: 0000000000034320 R12: 0000000000000000
R13: ffff888103580a18 R14: ffff888114447000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88881fdc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000094 CR3: 0000000100cdb000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Root cause is quite complex:

1) use bfq elevator for the test device.
2) create a cgroup CG
3) config blk throtl in CG

   blkg_conf_prep
    blkg_create

4) create a thread T1 and issue async io in CG:

   bio_init
    bio_associate_blkg
   ...
   submit_bio
    submit_bio_noacct
     blk_throtl_bio -> io is throttled
     // io submit is done

5) switch elevator:

   bfq_exit_queue
    blkcg_deactivate_policy
     list_for_each_entry(blkg, &q->blkg_list, q_node)
      blkg->pd[] = NULL
      // bfq policy is removed

5) thread t1 exist, then remove the cgroup CG:

   blkcg_unpin_online
    blkcg_destroy_blkgs
     blkg_destroy
      list_del_init(&blkg->q_node)
      // blkg is removed from queue list

6) switch elevator back to bfq

 bfq_init_queue
  bfq_create_group_hierarchy
   blkcg_activate_policy
    list_for_each_entry_reverse(blkg, &q->blkg_list)
     // blkg is removed from list, hence bfq policy is still NULL

7) throttled io is dispatched to bfq:

 bfq_insert_requests
  bfq_init_rq
   bfq_bic_update_cgroup
    bfq_bio_bfqg
     bfqg = blkg_to_bfqg(blkg)
     // bfqg is NULL because bfq policy is NULL

The problem is only possible in bfq because only bfq can be deactivated and
activated while queue is online, while others can only be deactivated while
the device is removed.

Fix the problem in bfq by checking if blkg is online before calling
blkg_to_bfqg().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 144bca006463..7d624a3a3f0f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -610,6 +610,10 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 	struct bfq_group *bfqg;
 
 	while (blkg) {
+		if (!blkg->online) {
+			blkg = blkg->parent;
+			continue;
+		}
 		bfqg = blkg_to_bfqg(blkg);
 		if (bfqg->online) {
 			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
-- 
2.31.1

