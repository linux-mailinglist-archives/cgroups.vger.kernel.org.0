Return-Path: <cgroups+bounces-12954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901DBD00973
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86EF93014128
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776C2264A3;
	Thu,  8 Jan 2026 01:53:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3037136E3F;
	Thu,  8 Jan 2026 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837187; cv=none; b=hKBeDGtynnQJaWnkhdowWr3ptDBkpHkB2l6N02UczrTE3UdS+AxkqW2suTRwoDmrVsRizW8U7CMnS26gGw2farLaiKySNqwNNw3xEKFyvbCSlphwOhZsw9W1CHsn65JpIoPoG4IV/E2MQ34OnB0iTbjvlu8cxnPz+z4flECbFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837187; c=relaxed/simple;
	bh=0/Y9yOEwzq8gMNbOAp62DRq10dZ05AoU8GAii37SP40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klHVxIwNWJXmo0fm74GzXrihPAgOpiCcEhbfzpm7O0r4YzOnyLT7nRAv5fV0f7ZasyUVS92pk1H6WjiwJZ324wz0X6ZqBnaDyZAlQle+EyaTkn7sydiT6dfNyOuCWJ/wi2P/s0KoEGiFWHB9VfMG9vlYd63wT5R7RBWkP/DobPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmnw42MZLzKHMTj;
	Thu,  8 Jan 2026 09:52:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6EBC740574;
	Thu,  8 Jan 2026 09:53:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_f8DV9pVBQTDA--.41552S7;
	Thu, 08 Jan 2026 09:53:02 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fnnas.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH 3/3] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Date: Thu,  8 Jan 2026 09:44:16 +0800
Message-Id: <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_f8DV9pVBQTDA--.41552S7
X-Coremail-Antispam: 1UD129KBjvJXoWxArWfuFWDZrWDXFW3AF4kCrg_yoW5KrWfpr
	Z5KryxCryDGFyDZan8t3WUXry8AF43JrW8JrWxKr4a9F43Aw18AFnrur1DGrWUCFWDAa15
	Za1ktryDAa1UK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Up
	c_-UUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

When switching IO schedulers on a block device, blkcg_activate_policy()
can race with concurrent blkcg deletion, leading to a use-after-free of
the blkg.

T1:				  T2:
elv_iosched_store		  blkg_destroy
elevator_switch			  kill(&blkg->refcnt) // blkg->refcnt=0
...				  blkg_release // call_rcu
blkcg_activate_policy		  __blkg_release
list for blkg			  blkg_free
				  blkg_free_workfn
				  ->pd_free_fn(pd)
blkg_get(blkg) // blkg->refcnt=0->1
				  list_del_init(&blkg->q_node)
				  kfree(blkg)
blkg_put(pinned_blkg) // blkg->refcnt=1->0
blkg_release // call_rcu again
call_rcu(..., __blkg_release)

Fix this by replacing blkg_get() with blkg_tryget(), which fails if
the blkg's refcount has already reached zero. If blkg_tryget() fails,
skip processing this blkg since it's already being destroyed.

The uaf call trace is as follows:

==================================================================
 BUG: KASAN: slab-use-after-free in rcu_accelerate_cbs+0x114/0x120
 Read of size 8 at addr ffff88815a20b5d8 by task bash/1068
 CPU: 0 PID: 1068 Comm: bash Not tainted 6.6.0-g6918ead378dc-dirty #31
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
Call Trace:
 <IRQ>
 rcu_accelerate_cbs+0x114/0x120
 rcu_report_qs_rdp+0x1fb/0x3e0
 rcu_core+0x4d7/0x6f0
 handle_softirqs+0x198/0x550
 irq_exit_rcu+0x130/0x190
 sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20

Allocated by task 1031:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x8b/0x90
 blkg_alloc+0xb6/0x9c0
 blkg_create+0x8c6/0x1010
 blkg_lookup_create+0x2ca/0x660
 bio_associate_blkg_from_css+0xfb/0x4e0
 bio_associate_blkg+0x62/0xf0
 bio_init+0x272/0x8d0
 bio_alloc_bioset+0x45a/0x760
 ext4_bio_write_folio+0x68e/0x10d0
 mpage_submit_folio+0x14a/0x2b0
 mpage_process_page_bufs+0x1b1/0x390
 mpage_prepare_extent_to_map+0xa91/0x1060
 ext4_do_writepages+0x948/0x1c50
 ext4_writepages+0x23f/0x4a0
 do_writepages+0x162/0x5e0
 filemap_fdatawrite_wbc+0x11a/0x180
 __filemap_fdatawrite_range+0x9d/0xd0
 file_write_and_wait_range+0x91/0x110
 ext4_sync_file+0x1c1/0xaa0
 __x64_sys_fsync+0x55/0x90
 do_syscall_64+0x55/0x100
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Freed by task 24:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x27/0x40
 __kasan_slab_free+0x106/0x180
 __kmem_cache_free+0x162/0x350
 process_one_work+0x573/0xd30
 worker_thread+0x67f/0xc30
 kthread+0x28b/0x350
 ret_from_fork+0x30/0x70
 ret_from_fork_asm+0x1b/0x30

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index af468676cad1..ac7702db0836 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1645,9 +1645,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			 * GFP_NOWAIT failed.  Free the existing one and
 			 * prealloc for @blkg w/ GFP_KERNEL.
 			 */
+			if (!blkg_tryget(blkg))
+				continue;
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
-			blkg_get(blkg);
 			pinned_blkg = blkg;
 
 			spin_unlock_irq(&q->queue_lock);
-- 
2.39.2


