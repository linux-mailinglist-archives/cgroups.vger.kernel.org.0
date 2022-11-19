Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678D630A58
	for <lists+cgroups@lfdr.de>; Sat, 19 Nov 2022 03:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiKSCZA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Nov 2022 21:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiKSCX2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Nov 2022 21:23:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED847EC89;
        Fri, 18 Nov 2022 18:15:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43003B8267D;
        Sat, 19 Nov 2022 02:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2264C433D6;
        Sat, 19 Nov 2022 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668824129;
        bh=Uha3JSi27qAZYklk7skNMOdy3BYTAWOlDdWDXV0LTb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpLKo2J4MWL4wV5K0RIsF9tJBN1LCCGyg8RARdOZg9ExYQuG4TcVDEHs78aWsN1EB
         jhlLe2pTw18/C6YO62h9sJCFwFovzZ+495RLSWNSPnzQf3WQn7n6FIgxChSNA8eAD6
         wt/1sFp85JluuZoYo87ZMVdZKZzjv55VYWd21Vj7v4l1llC6h9fEZE+qp7vCM+JP1y
         UsLHQM28Ui/IkDC1b3WJKiiTrOfDgWoMLm7pITulEjA1kE0hPCuQAtHkkGu88mdU9M
         H4XhYoYtqnIcWTzuVLN50r2DRNOJRX1iszDL8VeWmn7iAi2Rj3K2DdU8SxqfN6ZK6t
         uCvCVWMTmC/Gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        paolo.valente@linaro.org, tj@kernel.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/18] block, bfq: fix null pointer dereference in bfq_bio_bfqg()
Date:   Fri, 18 Nov 2022 21:14:56 -0500
Message-Id: <20221119021459.1775052-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021459.1775052-1-sashal@kernel.org>
References: <20221119021459.1775052-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit f02be9002c480cd3ec0fcf184ad27cf531bd6ece ]

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
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20221108103434.2853269-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index be6733558b83..badb90352bf3 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -611,6 +611,10 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
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
2.35.1

