Return-Path: <cgroups+bounces-12955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C6D0097F
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 02:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26BE302F814
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC22B8C5;
	Thu,  8 Jan 2026 01:53:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE617C77;
	Thu,  8 Jan 2026 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837188; cv=none; b=tlr8cLRoYEiCBueRMESM+fvxndlkTYAxGC/RB1/FwIig1vU7rB8RmRFruKSjNZHi9bgSQfHTtYSzMraYlrVxTnfCYvz+EhguXqgKze1ZLkGFdt7XGC9b80hAMMZoLS94NOJpi3e0BoYUtj750tXfql4Fym18f0iqgbwZJtHb5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837188; c=relaxed/simple;
	bh=XgZrthFT1lbb9PsLOPRpfTbT5iylEyW16lqf0VbVdpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxjVkxzdx0O4aKlLLYo1WDLK+yzx0UgJmbY8ka9tsZlHdG3jqANyfhIAKg7Z4p4q52Jt7lTpIq2ZZ/DLda/CVQqZ/Zg6SMjDBDIzW/3RKE/oOT18B6gKhd2RQqGl1XRv3PYS13/KZdeaU1wdiDsZZxYntPKdonHVPDipJoLkEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmnw41WF9zKHMTj;
	Thu,  8 Jan 2026 09:52:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54EEE4056F;
	Thu,  8 Jan 2026 09:53:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_f8DV9pVBQTDA--.41552S6;
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
Subject: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy() racing with blkg_free_workfn()
Date: Thu,  8 Jan 2026 09:44:15 +0800
Message-Id: <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXd_f8DV9pVBQTDA--.41552S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrJr4kuFW7GF4UJw15CFg_yoW5uF45pr
	Z8KryxA340gryUAFsF9w12q348ta9Yqry5JrWxGr43uFsxuw1F9a4DCr1kWFW7ur97AF43
	Za4Ut3yUK3Wvyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UJ
	xhLUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

When switching IO schedulers on a block device (e.g., loop0),
blkcg_activate_policy() is called to allocate blkg_policy_data (pd)
for all blkgs associated with that device's request queue.

However, a race condition exists between blkcg_activate_policy() and
concurrent blkcg deletion that leads to a use-after-free:

T1 (blkcg_activate_policy):
  - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
  - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
  - Goes to enomem error path to rollback blkg1's resources

T2 (blkcg deletion):
  - blkcgA is being deleted concurrently
  - blkg1 is freed via blkg_free_workfn()
  - blkg1->pd is freed

T1 (continued):
  - In the rollback path, accesses pd->online after blkg1->pd
    has been freed
  - Triggers use-after-free

The issue occurs because blkcg_activate_policy() doesn't hold
adequate protection against concurrent blkg freeing during the
error rollback path. The call trace is as follows:

==================================================================
BUG: KASAN: slab-use-after-free in blkcg_activate_policy+0x516/0x5f0
Read of size 1 at addr ffff88802e1bc00c by task sh/7357
CPU: 1 PID: 7357 Comm: sh Tainted: G           OE       6.6.0+ #1
Call Trace:
 <TASK>
 blkcg_activate_policy+0x516/0x5f0
 bfq_create_group_hierarchy+0x31/0x90
 bfq_init_queue+0x6df/0x8e0
 blk_mq_init_sched+0x290/0x3a0
 elevator_switch+0x8a/0x190
 elv_iosched_store+0x1f7/0x2a0
 queue_attr_store+0xad/0xf0
 kernfs_fop_write_iter+0x1ee/0x2e0
 new_sync_write+0x154/0x260
 vfs_write+0x313/0x3c0
 ksys_write+0xbd/0x160
 do_syscall_64+0x55/0x100
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Allocated by task 7357:
 bfq_pd_alloc+0x6e/0x120
 blkcg_activate_policy+0x141/0x5f0
 bfq_create_group_hierarchy+0x31/0x90
 bfq_init_queue+0x6df/0x8e0
 blk_mq_init_sched+0x290/0x3a0
 elevator_switch+0x8a/0x190
 elv_iosched_store+0x1f7/0x2a0
 queue_attr_store+0xad/0xf0
 kernfs_fop_write_iter+0x1ee/0x2e0
 new_sync_write+0x154/0x260
 vfs_write+0x313/0x3c0
 ksys_write+0xbd/0x160
 do_syscall_64+0x55/0x100
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Freed by task 14318:
 blkg_free_workfn+0x7f/0x200
 process_one_work+0x2ef/0x5d0
 worker_thread+0x38d/0x4f0
 kthread+0x156/0x190
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1b/0x30

Fix this bug by adding q->blkcg_mutex in the enomem branch of
blkcg_activate_policy().

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
 block/blk-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5e1a724a799a..af468676cad1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1693,9 +1693,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 enomem:
 	/* alloc failed, take down everything */
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 	blkcg_policy_teardown_pds(q, pol);
 	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 	ret = -ENOMEM;
 	goto out;
 }
-- 
2.39.2


