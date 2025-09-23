Return-Path: <cgroups+bounces-10382-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E134B94EA8
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2746519038BB
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE970319875;
	Tue, 23 Sep 2025 08:05:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE992E1746;
	Tue, 23 Sep 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614739; cv=none; b=MUQh3Y2+gkGVt/sPgnPfdR+gDva0mIX+eZ9AsPPXbHvB06dHZLdeY2r6z2lu869G3Snjtc23CyvhxUvdlsGoGQGyKqBFURJm+ysfpiEL/H02cCY188QvLGX5+fJcYqqB54qWsoIuENzqlJ2AxgDANDU9+ubuENpJZK+xZ9Mu8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614739; c=relaxed/simple;
	bh=T6BhKFVvxZM6CRbhNMqQFdJeF8w33ZSkSyUv/N7p0+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ26QJv1T/1sbijYYe2jR6+cddyPIKSnCAZkXqQ4RTaDEP7vrCQItYJjh9s7pOS2AyMAa7pzhp2mU2Ae2oHDl5ZO9duGSnG6l5ew0iIL8cGTeV4XpuxwPa5ts7YMch2/nArPSwTvyu/QMR6pEeG2xL0foL38j523p2G5Fi/wiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWCG171kCzKHN0p;
	Tue, 23 Sep 2025 16:05:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D9E081A1B52;
	Tue, 23 Sep 2025 16:05:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGTLVNJoHpMlAg--.40262S6;
	Tue, 23 Sep 2025 16:05:34 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 2/2] blk-cgroup: fix possible deadlock while configuring policy
Date: Tue, 23 Sep 2025 15:55:20 +0800
Message-Id: <20250923075520.3746244-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGTLVNJoHpMlAg--.40262S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWfXw1rtr47GF45AFW8JFb_yoW7uFWkpF
	W3KF13Ary0gr4DZrWkGr17WryUtay8Kr45GrZ3GryS9F42vr1YgF1jyF10kFW8ArZrJFZ5
	tF4FqayFkF4DCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Following deadlock can be triggered easily by lockdep:

WARNING: possible circular locking dependency detected
6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
------------------------------------------------------
check/1334 is trying to acquire lock:
ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x53/0x180

but task is already holding lock:
ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/0x110

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
       blk_queue_enter+0x40b/0x470
       blkg_conf_prep+0x7b/0x3c0
       tg_set_limit+0x10a/0x3e0
       cgroup_file_write+0xc6/0x420
       kernfs_fop_write_iter+0x189/0x280
       vfs_write+0x256/0x490
       ksys_write+0x83/0x190
       __x64_sys_write+0x21/0x30
       x64_sys_call+0x4608/0x4630
       do_syscall_64+0xdb/0x6b0
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
       __mutex_lock+0xd8/0xf50
       mutex_lock_nested+0x2b/0x40
       wbt_init+0x17e/0x280
       wbt_enable_default+0xe9/0x140
       blk_register_queue+0x1da/0x2e0
       __add_disk+0x38c/0x5d0
       add_disk_fwnode+0x89/0x250
       device_add_disk+0x18/0x30
       virtblk_probe+0x13a3/0x1800
       virtio_dev_probe+0x389/0x610
       really_probe+0x136/0x620
       __driver_probe_device+0xb3/0x230
       driver_probe_device+0x2f/0xe0
       __driver_attach+0x158/0x250
       bus_for_each_dev+0xa9/0x130
       driver_attach+0x26/0x40
       bus_add_driver+0x178/0x3d0
       driver_register+0x7d/0x1c0
       __register_virtio_driver+0x2c/0x60
       virtio_blk_init+0x6f/0xe0
       do_one_initcall+0x94/0x540
       kernel_init_freeable+0x56a/0x7b0
       kernel_init+0x2b/0x270
       ret_from_fork+0x268/0x4c0
       ret_from_fork_asm+0x1a/0x30

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       __lock_acquire+0x1835/0x2940
       lock_acquire+0xf9/0x450
       __mutex_lock+0xd8/0xf50
       mutex_lock_nested+0x2b/0x40
       blk_unregister_queue+0x53/0x180
       __del_gendisk+0x226/0x690
       del_gendisk+0xba/0x110
       sd_remove+0x49/0xb0 [sd_mod]
       device_remove+0x87/0xb0
       device_release_driver_internal+0x11e/0x230
       device_release_driver+0x1a/0x30
       bus_remove_device+0x14d/0x220
       device_del+0x1e1/0x5a0
       __scsi_remove_device+0x1ff/0x2f0
       scsi_remove_device+0x37/0x60
       sdev_store_delete+0x77/0x100
       dev_attr_store+0x1f/0x40
       sysfs_kf_write+0x65/0x90
       kernfs_fop_write_iter+0x189/0x280
       vfs_write+0x256/0x490
       ksys_write+0x83/0x190
       __x64_sys_write+0x21/0x30
       x64_sys_call+0x4608/0x4630
       do_syscall_64+0xdb/0x6b0
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

Chain exists of:
  &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(queue)#3);
                               lock(&q->rq_qos_mutex);
                               lock(&q->q_usage_counter(queue)#3);
  lock(&q->sysfs_lock);

Root cause is that queue_usage_counter is grabbed with rq_qos_mutex
held in blkg_conf_prep(), while queue should be freezed before
rq_qos_mutex from other context.

The blk_queue_enter() from blkg_conf_prep() is used to protect against
policy deactivation, which is already protected with blkcg_mutex, hence
convert blk_queue_enter() to blkcg_mutex to fix this problem. Meanwhile,
consider that blkcg_mutex is held after queue is freezed from policy
deactivation, also convert blkg_alloc() to use GFP_NOIO.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
BTW, I'm not quite sure about the fix tag, when blk_queue_enter() and
rq_qos_mutex are first introduced, queue is still freezed inside
rq_qos_mutex.

 block/blk-cgroup.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0c7b58696d3c..9f153f5f2ceb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -877,14 +877,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	disk = ctx->bdev->bd_disk;
 	q = disk->queue;
 
-	/*
-	 * blkcg_deactivate_policy() requires queue to be frozen, we can grab
-	 * q_usage_counter to prevent concurrent with blkcg_deactivate_policy().
-	 */
-	ret = blk_queue_enter(q, 0);
-	if (ret)
-		goto fail;
-
+	/* Prevent concurrent with blkcg_deactivate_policy() */
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 
 	if (!blkcg_policy_enabled(q, pol)) {
@@ -914,16 +908,16 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
 		spin_unlock_irq(&q->queue_lock);
 
-		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
+		new_blkg = blkg_alloc(pos, disk, GFP_NOIO);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
-			goto fail_exit_queue;
+			goto fail_exit;
 		}
 
 		if (radix_tree_preload(GFP_KERNEL)) {
 			blkg_free(new_blkg);
 			ret = -ENOMEM;
-			goto fail_exit_queue;
+			goto fail_exit;
 		}
 
 		spin_lock_irq(&q->queue_lock);
@@ -951,7 +945,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
-	blk_queue_exit(q);
+	mutex_unlock(&q->blkcg_mutex);
 	ctx->blkg = blkg;
 	return 0;
 
@@ -959,9 +953,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	radix_tree_preload_end();
 fail_unlock:
 	spin_unlock_irq(&q->queue_lock);
-fail_exit_queue:
-	blk_queue_exit(q);
-fail:
+fail_exit:
+	mutex_unlock(&q->blkcg_mutex);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
-- 
2.39.2


