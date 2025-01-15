Return-Path: <cgroups+bounces-6165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED4EA11E40
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CDB3AE983
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B61EEA31;
	Wed, 15 Jan 2025 09:37:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA29248164;
	Wed, 15 Jan 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933845; cv=none; b=B4W7eFZyxwLL+yXMlaCM9N+xD6yV7hZ3WmfD5HulTiZ89+u9BcZIs4wq/6acduasPI8UuAd+KgH0eH3dp6c2BWBeWfCR2F1ThYJZeMLV8Znt5a/NCfstoknv+Yw/V7ulMWIpe7sCtz31VWPBdtRx/UlQKwOQGn5/8fYze3smsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933845; c=relaxed/simple;
	bh=RICQ+FugO2UuAfARIMKAug4IAivXM59w3ZjanIHQpkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iN0lfQrPRcc5XY0NCOehem8tyDZi7ZKinHkDAMb9VL///AddYGNw/mGq7dXm2ZABqV7jYCy9nfqfxOKos5UlDO69WwmO9C+n6RkOnvxT0Sc5M0xX0IQeyYJNHygJLTubbbDH4RTUMybEgl7FrTMIPw5s42vvX7nLjBooIQjqkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 3B720233A9;
	Wed, 15 Jan 2025 12:37:20 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	Tejun Heo <tj@kernel.org>,
	Abagail ren <renzezhongucas@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10/5.15] blk-cgroup: Fix UAF in blkcg_unpin_online()
Date: Wed, 15 Jan 2025 12:37:09 +0300
Message-Id: <20250115093709.335950-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

commit 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af upstream.

blkcg_unpin_online() walks up the blkcg hierarchy putting the online pin. To
walk up, it uses blkcg_parent(blkcg) but it was calling that after
blkcg_destroy_blkgs(blkcg) which could free the blkcg, leading to the
following UAF:

  ==================================================================
  BUG: KASAN: slab-use-after-free in blkcg_unpin_online+0x15a/0x270
  Read of size 8 at addr ffff8881057678c0 by task kworker/9:1/117

  CPU: 9 UID: 0 PID: 117 Comm: kworker/9:1 Not tainted 6.13.0-rc1-work-00182-gb8f52214c61a-dirty #48
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
  Workqueue: cgwb_release cgwb_release_workfn
  Call Trace:
   <TASK>
   dump_stack_lvl+0x27/0x80
   print_report+0x151/0x710
   kasan_report+0xc0/0x100
   blkcg_unpin_online+0x15a/0x270
   cgwb_release_workfn+0x194/0x480
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ...
  Freed by task 1944:
   kasan_save_track+0x2b/0x70
   kasan_save_free_info+0x3c/0x50
   __kasan_slab_free+0x33/0x50
   kfree+0x10c/0x330
   css_free_rwork_fn+0xe6/0xb30
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30

Note that the UAF is not easy to trigger as the free path is indirected
behind a couple RCU grace periods and a work item execution. I could only
trigger it with artifical msleep() injected in blkcg_unpin_online().

Fix it by reading the parent pointer before destroying the blkcg's blkg's.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Abagail ren <renzezhongucas@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Fixes: 4308a434e5e0 ("blkcg: don't offline parent blkcg first")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[kovalev: in versions 5.10 and 5.15, the blkcg_unpin_online()
function was not moved to the block/blk-cgroup.c file]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-56672
Link: https://www.cve.org/CVERecord/?id=CVE-2024-56672
---
 include/linux/blk-cgroup.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0e6e84db06f674..b89099360a8673 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -428,10 +428,14 @@ static inline void blkcg_pin_online(struct blkcg *blkcg)
 static inline void blkcg_unpin_online(struct blkcg *blkcg)
 {
 	do {
+		struct blkcg *parent;
+
 		if (!refcount_dec_and_test(&blkcg->online_pin))
 			break;
+
+		parent = blkcg_parent(blkcg);
 		blkcg_destroy_blkgs(blkcg);
-		blkcg = blkcg_parent(blkcg);
+		blkcg = parent;
 	} while (blkcg);
 }
 
-- 
2.33.8


