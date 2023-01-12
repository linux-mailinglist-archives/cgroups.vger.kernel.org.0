Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDEA666EB8
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjALJyo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjALJyJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 04:54:09 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 01:50:25 PST
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDC8E25;
        Thu, 12 Jan 2023 01:50:25 -0800 (PST)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 89C1F3E0EB4;
        Thu, 12 Jan 2023 12:44:03 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Anton Fadeev <anton.fadeev@red-soft.ru>
Subject: [PATCH] block: bfq fix null pointer dereference of bfqg in bfq_bio_bfqg()
Date:   Thu, 12 Jan 2023 12:43:58 +0300
Message-Id: <20230112094358.451029-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.30.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 174659 [Jan 12 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6, {Tracking_from_domain_doesnt_match_to}, localhost.biz:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;red-soft.ru:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/01/12 08:47:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/01/12 05:58:00 #20761738
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is possible for bfqg to be NULL after being initialized as result of
blkg_to_bfqg() function.

That was achieved on kernel 5.15.78, but should exist in mainline as
well

host1 login: [ 460.855794] watchdog: watchdog0: watchdog did not stop!
[  898.944512] BUG: kernel NULL pointer dereference, address: 0000000000000094
[  899.285776] #PF: supervisor read access in kernel mode
[  899.536511] #PF: error_code(0x0000) - not-present page
[  899.647305]  connection4:0: detected conn error (1020)
[  899.786794] PGD 0 P4D 0
[  899.786799] Oops: 0000 [#1] SMP PTI
[  899.786802] CPU: 15 PID: 6073 Comm: ID iothread1 Not tainted 5.15.78-1.el7virt.x86_64 #1
[  899.786804] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
[  899.786806] RIP: 0010:bfq_bio_bfqg+0x26/0x80
[  901.325944] Code: 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 89 f7 53 48 8b 56 48 48 85 d2
74 32 48 63 05 83 7f 35 01 48 83 c0 16 48 8b 5c c2 08 <80> bb 94 00 00 00 00 00
[  902.237825] RSP: 0018:ffffae2649437688 EFLAGS: 00010002
[  902.493396] RAX: 0000000000000019 RBX: 0000000000000000 RCX: dead000000000122
[  902.841529] RDX: ffff8b6012cb3a00 RSI: ffff8b71002bbed0 RDI: ffff8b71002bbed0
[  903.189374] RBP: ffff8b601c46e800 R08: ffffae26494377c8 R09: 0000000000000000
[  903.532985] R10: 0000000000000001 R11: 0000000000000008 R12: ffff8b6f844c5b30
[  903.880809] R13: ffff8b601c46e800 R14: ffffae2649437760 R15: ffff8b601c46e800
[  904.220054] FS:  00007fec2fc4a700(0000) GS:ffff8b7f7f640000(0000) kn1GS:00000000000000000
[  904.614349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  904.894717] CR2: 0000000000000094 CR3: 0000000111fd8002 CR4: 00000000003726e0
[  905.243702] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  905.592493] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  905.936859] Call Trace:
[  906.055955] <TASK>
[  906.158109] bfq_bic_update_cgroup+0x2c/0x1f0
[  906.371057] bfq_insert_requests+0x2c2/0x1fb0
[  906.579207] blk_mq_sched_insert_request+0xc2/0x140
[  906.817640] __blk_mq_try_issue_directly+0xe0/0x1f0
[  907.055737] blk_mq_request_issue_directly+0x4e/0xa0
[  907.298547] dm_mq_queue_rq+0x217/0x3e0
[  907.485935] blk_mq_dispatch_rq_list+0x14b/0x860
[  907.711973] ? sbitmap_get+0x87/0x1a0
[  907.890370] blk_mq_do_dispatch_sched+0x350/0x3b0
[  908.074869] NMI watchdog: Watchdog detected hard LOCKUP on cpu 40

Fixes: 075a53b78b81 ("bfq: Make sure bfqg for which we are queueing requests is online")
Co-developed-by: Anton Fadeev <anton.fadeev@red-soft.ru>
Signed-off-by: Anton Fadeev <anton.fadeev@red-soft.ru>
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1b2829e99dad..d4e9428cdbe5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -616,7 +616,7 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 			continue;
 		}
 		bfqg = blkg_to_bfqg(blkg);
-		if (bfqg->online) {
+		if (bfqg && bfqg->online) {
 			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
 			return bfqg;
 		}
-- 
2.30.3

