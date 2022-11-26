Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10466395F1
	for <lists+cgroups@lfdr.de>; Sat, 26 Nov 2022 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKZMQD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Nov 2022 07:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZMQB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Nov 2022 07:16:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7F1D678;
        Sat, 26 Nov 2022 04:15:59 -0800 (PST)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NK9ff1SzjzmW99;
        Sat, 26 Nov 2022 20:15:22 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 26 Nov
 2022 20:15:57 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>
Subject: [PATCH] blk-iocost: fix shift-out-of-bounds in iocg_hick_delay()
Date:   Sat, 26 Nov 2022 20:14:58 +0800
Message-ID: <20221126121458.3564942-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We got the following UBSAN report:
====================================================================
UBSAN: shift-out-of-bounds in block/blk-iocost.c:1294:23
shift exponent 18446744073709 is too large for 64-bit type ......
CPU: 1 PID: 1088217 Comm: fsstress Kdump: loaded Not tainted ......
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
Call Trace:
 dump_stack+0x9c/0xd3
 ubsan_epilogue+0xa/0x4e
 __ubsan_handle_shift_out_of_bounds.cold+0x87/0x137
 iocg_kick_delay.cold+0x18/0x60
 ioc_rqos_throttle+0x7f8/0x870
 __rq_qos_throttle+0x40/0x60
 blk_mq_submit_bio+0x24d/0xd60
 __submit_bio_noacct_mq+0x10b/0x270
 submit_bio_noacct+0x13d/0x150
 submit_bio+0xbf/0x280
 submit_bh_wbc+0x3aa/0x450
 ext4_read_bh_nowait+0xdb/0x180 [ext4]
 ext4_read_bh_lock+0x6d/0x90 [ext4]
 ext4_bread_batch+0x24c/0x2e0 [ext4]
 __ext4_find_entry+0x2d2/0x880 [ext4]
 ext4_lookup.part.0+0xbf/0x370 [ext4]
 ext4_lookup+0x3e/0x60 [ext4]
 lookup_open.isra.0+0x343/0x630
 open_last_lookups+0x1f2/0x750
 path_openat+0x133/0x330
 do_filp_open+0x122/0x270
 do_sys_openat2+0x3a8/0x550
 __x64_sys_creat+0xae/0xe0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
===================================================================

The result of E1 >> E2 is E1 right-shifted E2 bit positions. From the
report, we know E2 is greater than the width of E1. In the C99 standard,
if the value of the E2 is negative or is greater than or equal to the
width of E1, the behavior is undefined.

In the actual test, if the E2 is greater than or equal to the width of
E1, the result of E1 >> E2 is E1 >> (E2 %/ E1width), which is not what we
want.

So letting the value of the right operand be less than the width of u64
in this expression.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 07c1a31dd495..2b837ac4b2ba 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1332,7 +1332,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
 	if (iocg->delay)
-		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+		delay = iocg->delay >> min(div64_u64(tdelta, USEC_PER_SEC), 63);
 	else
 		delay = 0;
 
-- 
2.30.2

