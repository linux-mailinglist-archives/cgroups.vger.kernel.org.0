Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FC2BBE12
	for <lists+cgroups@lfdr.de>; Sat, 21 Nov 2020 09:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgKUIbD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 Nov 2020 03:31:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8383 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKUIbD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 Nov 2020 03:31:03 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CdRSc2zNqz71RQ;
        Sat, 21 Nov 2020 16:30:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 21 Nov 2020
 16:30:50 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <houtao1@huawei.com>
Subject: [RFC PATCH] blk-cgroup: prevent rcu_sched detected stalls warnings in blkg_destroy_all()
Date:   Sat, 21 Nov 2020 16:34:20 +0800
Message-ID: <20201121083420.3857433-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test procedures:

a. create 20000 cgroups, and echo "8:0 10000" to
   blkio.throttle.write_bps_device
b. echo 1 > /sys/blocd/sda/device/delete

test result:

CPU: 6 PID: 472 Comm: bash Not tainted 5.10.0-rc4-next-20201120-dirty #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-p4
RIP: 0010:css_next_descendant_post+0x5d/0x110
Code: 00 48 8b b3 c0 00 00 00 48 89 df e8 1d e9 ff ff 49 89 c4 48 85 c0 74 68 49 8d 5c f
RSP: 0018:ffff88810761faf8 EFLAGS: 00000046
RAX: ffff888001f1a830 RBX: ffff888001f1a830 RCX: ffffffff812e0548
RDX: dffffc0000000000 RSI: ffff888106f3f400 RDI: ffff888001f1a830
RBP: ffff8880133b14c0 R08: ffffffff812dee71 R09: 0000000000000001
R10: 0000000000000003 R11: ffffed1020ec3f6b R12: ffff888001f1a800
R13: ffff888100ff58b4 R14: 0000000000000016 R15: ffffffff8c330180
FS:  00007f36ed4df700(0000) GS:ffff88810b380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c8a5a45010 CR3: 000000000436c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 blk_throtl_update_limit_valid.isra.0+0x193/0x2b0
 throtl_pd_offline+0x95/0x100
 blkg_destroy+0xb6/0x2b0
 blkg_destroy_all+0x9f/0x140
 blkcg_exit_queue+0x16/0x30
 blk_release_queue+0x17e/0x320
 kobject_put+0x1b2/0x440
 blk_put_queue+0x16/0x20
 scsi_device_dev_release_usercontext+0x38c/0x5f0
 ? scsi_device_cls_release+0x30/0x30
 execute_in_process_context+0x2d/0xb0
 scsi_device_dev_release+0x20/0x30
 device_release+0xbc/0x180
 kobject_put+0x1b2/0x440
 put_device+0x17/0x30
 scsi_device_put+0x52/0x60
 sdev_store_delete+0x93/0x100
 ? dev_driver_string+0xa0/0xa0
 dev_attr_store+0x40/0x70
 sysfs_kf_write+0x89/0xc0
 kernfs_fop_write+0x167/0x310
 ? sysfs_kf_bin_read+0x130/0x130
 vfs_write+0x104/0x4c0
 ksys_write+0xcd/0x1e0
 ? __x64_sys_read+0x60/0x60
 ? up_read+0x25/0xf0
 ? do_user_addr_fault+0x408/0x990
 __x64_sys_write+0x46/0x60
 do_syscall_64+0x45/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f36ecbcd130
Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 4
RSP: 002b:00007ffe261fe678 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f36ecbcd130
RDX: 0000000000000002 RSI: 0000559fb4244080 RDI: 0000000000000001
RBP: 0000559fb4244080 R08: 000000000000000a R09: 00007f36ed4df700
R10: 0000559fb45d0180 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000001 R14: 00007f36ece9d5e0 R15: 00007f36ece988c0

The usage of so many blkg is very rare, however, such problem do exist
in theory. In order to avoid such warnings, release 'q->queue_lock' for
a while when a batch of blkg were destroyed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c68bdf58c9a6..566195490f4a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -420,14 +420,27 @@ static void blkg_destroy(struct blkcg_gq *blkg)
  *
  * Destroy all blkgs associated with @q.
  */
+#define BLKG_DESTROY_BATH 4096
 static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
+	int count = BLKG_DESTROY_BATH;
 
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
+		/*
+		 * If the list is too long, the loop can took a long time,
+		 * thus relese the lock for a while when a batch of blkcg
+		 * were destroyed.
+		 */
+		if (!(--count)) {
+			count = BLKG_DESTROY_BATH;
+			spin_unlock_irq(&q->queue_lock);
+			cond_resched();
+			spin_lock_irq(&q->queue_lock);
+		}
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
-- 
2.25.4

