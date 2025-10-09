Return-Path: <cgroups+bounces-10621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2384BC9F07
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5500F354429
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B82F83BA;
	Thu,  9 Oct 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKpqS30a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF502EFD98;
	Thu,  9 Oct 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025514; cv=none; b=UZh1kzIVfn38ax2EEuhHSLKI/t2NRaVko80tIom9BecfJU0QSUXnofulxn6Fb3Uzl22qnWKldHeHWij9/whoh4GZqP4iLjy66ilVZqalA/wFxT4U4CUSDYs8bqVZmG4wpr0Doa5fnXPxVyRNTUZnNm0yrIwTuhMXGuOpOs4p10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025514; c=relaxed/simple;
	bh=7Y8n+ObxSsW3XgRqwjBSqj6g6ZQ087u2cr5KpN5eOFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udxuLvEg44L8+mr15HDck50KqZ9hd8hce5j3TdtYeHw5p555nyVE6EJ8wBP5GmGTLGegc+M+A8A6MUD6zVFD/U3NHqTCB3ohHzoyrnhW7q3DLoJZ0U8MGttpsz2AXKZZEW53FOtuBdCE7yChoJoVc6WnGjzhPq+lGCK091IAk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKpqS30a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A33C4CEE7;
	Thu,  9 Oct 2025 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025511;
	bh=7Y8n+ObxSsW3XgRqwjBSqj6g6ZQ087u2cr5KpN5eOFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKpqS30a0IJhJBXs9NkmBnRxqbEqdLvpZ7aCmGbKca8q8CgWSdHKtSPuQ+k8mFMpM
	 QS6SXb5u+sdQlZcNBRFCr9xbvHaDA1PMkwEJ4m92TURYyCBDNcF/vq88zFXMXytOiD
	 rvB+xWAAJ5JFiIIcFdnos3Wrb1QYE+xLQGrXCNo92VifwiSoIf0YY7XccujeSc/rbl
	 AUSYhgn52BbRSMF8cY/cR6sMnQJGnUeptD7Evlz7zZw4IjSYSkggVIar2vpnWdtf8R
	 hGIqONHut4XiV5trIvyGYNPiCzbE7v7CphaSr3HEGMC/+ZMeUetZsRma1B0/PIasdl
	 Cm+SRyDhPl22g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] blk-cgroup: fix possible deadlock while configuring policy
Date: Thu,  9 Oct 2025 11:54:49 -0400
Message-ID: <20251009155752.773732-23-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 5d726c4dbeeddef612e6bed27edd29733f4d13af ]

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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation:

- Fixes a real deadlock. The report shows a lockdep-proven circular
  dependency involving `&q->sysfs_lock`, `&q->rq_qos_mutex`, and
  `&q->q_usage_counter`, triggered during blkcg policy configuration
  while devices are being removed. The root cause is explicitly
  identified in the commit message: `blkg_conf_prep()` took
  `rq_qos_mutex` (indirectly via open) and then grabbed
  `q_usage_counter` via `blk_queue_enter()`, but other paths freeze the
  queue before taking `rq_qos_mutex`, creating an inversion.

- Core change eliminates the lock inversion without changing semantics:
  - Replaces `blk_queue_enter(q, 0)` with `mutex_lock(&q->blkcg_mutex)`
    to prevent concurrent policy deactivation, matching the protection
    already used by `blkcg_deactivate_policy()`.
    - Before: `blk_queue_enter()` grabbed `q_usage_counter` while
      `rq_qos_mutex` was already held (bad ordering).
    - After: Take `q->blkcg_mutex` instead, which is the correct lock to
      serialize with policy deactivation and does not participate in the
      problematic chain.
    - Code reference (new behavior at the commit): block/blk-
      cgroup.c:880 acquires `mutex_lock(&q->blkcg_mutex)`; block/blk-
      cgroup.c:fail_exit and success paths unlock it instead of
      `blk_queue_exit()`.
  - Drops the corresponding `blk_queue_exit(q)` calls since
    `blk_queue_enter()` is no longer used (block/blk-
    cgroup.c:success/fail paths).

- Allocation context adjusted for freeze safety:
  - Changes `blkg_alloc(..., GFP_KERNEL)` to `GFP_NOIO` while
    `blkcg_mutex` is held, because policy deactivation holds
    `blkcg_mutex` after freezing the queue; `GFP_NOIO` avoids potential
    IO/reclaim that could deadlock while the queue is frozen.
    - Code reference: block/blk-cgroup.c:911 switches to `GFP_NOIO`.

- Locking contract to callers is preserved:
  - `blkg_conf_prep()` still returns with `queue_lock` held as annotated
    (`__acquires(&bdev->bd_queue->queue_lock)`), and `blkg_conf_exit()`
    remains responsible for releasing `rq_qos_mutex` and `queue_lock`
    (block/blk-cgroup.c:992-1007). The new `blkcg_mutex` is released
    inside `blkg_conf_prep()` before returning, so external APIs don’t
    change.

- Small, contained change in a single subsystem file:
  - Only touches `block/blk-cgroup.c` and only the `blkg_conf_prep()`
    path. No UAPI or architectural shifts; minimal surface area.

- Aligns with existing design:
  - `blkcg_deactivate_policy()` already uses `q->blkcg_mutex` to
    serialize policy teardown with queue freeze (e.g., v6.6 has
    `mutex_lock(&q->blkcg_mutex)` in block/blk-cgroup.c:1625). Using the
    same mutex in `blkg_conf_prep()` is consistent and resolves the
    ordering with `rq_qos_mutex`.

- Applicability to stable:
  - Affects stable branches that:
    - Hold `rq_qos_mutex` in `blkg_conf_open_bdev()` and use
      `blk_queue_enter()` in `blkg_conf_prep()` (e.g., v6.6).
    - Have `q->blkcg_mutex` and use it in `blkcg_deactivate_policy()`.
  - Not directly applicable to much older series (e.g., v6.1) where the
    blkcg prep logic and locks differ (no `blkcg_mutex` field there, and
    `blkg_conf_prep()` is structured differently). Those branches may
    not exhibit the same lock chain or would need a different
    adaptation.

- Risk of regression is low:
  - The switch from `q_usage_counter` to `blkcg_mutex` is targeted to
    the specific policy update path and matches existing deactivate-
    policy synchronization.
  - The `GFP_NOIO` change is safer under queue freeze; allocation
    failure is handled with existing error paths (-ENOMEM) and retry
    logic for -EBUSY remains intact for other sources.

- Process signals quality:
  - Reviewed-by: Ming Lei; Signed-off-by: Jens Axboe. This is a well-
    scoped block layer fix.

Conclusion: This is a clear bug fix that removes a proven deadlock with
a minimal, well-aligned locking change. It should be backported to
stable trees where the affected locking and function structure exist
(e.g., 6.6+). It is not a straightforward backport to older trees
lacking `blkcg_mutex` and the newer prep/open split, so applicability
should be limited to branches that already have `rq_qos_mutex` in
`blkg_conf_open_bdev()` and `blk_queue_enter()` in `blkg_conf_prep()`.

 block/blk-cgroup.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fe9ebd6a2e14d..6e89e64c71be0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -883,14 +883,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
@@ -920,16 +914,16 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
@@ -957,7 +951,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
-	blk_queue_exit(q);
+	mutex_unlock(&q->blkcg_mutex);
 	ctx->blkg = blkg;
 	return 0;
 
@@ -965,9 +959,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
2.51.0


