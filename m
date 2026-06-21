Return-Path: <cgroups+bounces-17110-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fap8K0TuN2r4VgcAu9opvQ
	(envelope-from <cgroups+bounces-17110-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 15:59:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 421956AB039
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 15:59:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="KADqT/t7";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17110-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17110-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264E33006B20
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D7368D6F;
	Sun, 21 Jun 2026 13:59:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBB3161BF
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 13:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050370; cv=none; b=fO8zER+cC4zYtEnB+0QLLy/uREWRv62DMrBGPqhvBDsJna6Agxsu+HqvBbM0XrFXU2Q1dvUHXdRrRO8gCPRNwI2we/Vrs00U7t5Qf8qXefqp6A4tH+fNqetnjrmRFO7s1Kb6Wzu9SmQrA5zBt0A4BjBMHAfQpmmD/wObsZqxSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050370; c=relaxed/simple;
	bh=7E8W3VETOqPs9uJNQ/rJsMQaDBaWzPuymTc/8AWSl9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UVZ7OqJB2RCoWQ5ioqbSJQufDs9MmbMxiq3HJx83rB+6VrCNJXqN2Mw4DtQG4C6TOluQ4PUtUfGfKSzuqPV7drinwZrvJm2DwnTzo/RRVTHaOwpADV01wCsD984tUiWb02d0NbvFK08fEgz+mc4z6YyMikWoSH0RqOP4TiioeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KADqT/t7; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c68190ade4so32272065ad.0
        for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050368; x=1782655168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOlLZDSp/+f4baWmQ+nL2uVR8nR0njaY3srnmTa/4vA=;
        b=KADqT/t7A8AxSN7wX/GeeM3MSeNHVpFwjMHO4zZ4YFxlENfvjP14UtpN7mOM9y/bKK
         JddU/IWDcH01+G2pMkvbMpYC3yschpu+K40bTGLVIG7ZERU88dNyuYFIMdTdvghXBLwk
         z4toQjbPNQgofZ6KMPYU1kjC6GuiE5tOjpDQrAS4l3QtAmaouC77Qi6B1FPFix5B2amB
         GdMxffF+UeEzWi2RNLRldG3YCFQ8bT7ojNQHf2PUB2YQX/+XlPUqHljZYclbi0B+5LQ4
         mvxrgIYPtAy23HKPC7ejvhcOHNjDt8yY+aHBsbmCwiO7Z2LFqKlvbkjUo6Xd7wcJz6zb
         weRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050368; x=1782655168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOlLZDSp/+f4baWmQ+nL2uVR8nR0njaY3srnmTa/4vA=;
        b=QxARGmFdkg5bYvmWwD+ia6D0Hsyc5TJOBuSTKtJtG7joueLBTiNEWMkzOk1fs4uyJ2
         AdasSuOEMc+Y4fgZAXJPBRYOCM+YpQmgMWZtH0SJa0LX4XqX7x5ydTxKGQ0VqfnzcFdI
         SuvwSYuZ/66XD+0/GIcljcFy9v8kQNY3ujDk8IJxqYEPwIZlPGrtgmgidr6JE4naqLd5
         xfeKkT4KNpPfgQAgUGebKAgTbVrKhyihZ/JWGfaM2lXHUh5xmL0GUwehMb3j9SFso78I
         698nNze2P8wg8TIMbEKtyUrtL8gvd4M8tmNsnXdAfatXVmM+WBNa/7dHay6tdbjfIpUu
         xc6g==
X-Gm-Message-State: AOJu0Yw7VcYC5QWwxh3bLa0cal1M7I1sw8jcTKeb2IehOlgXq6D9hgyM
	ke5aTjQBg/pFS5jABJs7bIwgxfrXe6pKYkidnKkSUSHrmpCQIORyuR63
X-Gm-Gg: AfdE7cljTPsAJ1jyyW9K5F5ziHTRX+R87ppYCCUIH2G/NmD139RNWgKmtrgdGDmnOEB
	tOWJc2Nb8V8q1dfvr469CjJ4ErV1xNkbcCoemGkjLpZcBEhs0jIRyKpTHK90xgQT3p05zjnC2OP
	RRFqlPHwW47aFuCZxiw0xw54o5FxUTt4SW5h4SP6YCAqYvWiUWzKqUlbq9L7V8AEUWzEkWFBEXz
	XQfytlm2WBB24r6Zbe9X9RjHV2+6Wstmls6EIE/g7gtmCgtui6kfuo9PKQwnHUZiARdr3JVHHZu
	bI8jwp0q1sR5uZ3DxF+7MDThjBrIMK6xBaWL9dDKCxrzHnVfp5jHUx/oDoc/+0L5at+fwRZgGxX
	AAllzU63c9Jpmw9hXYr11gfo/x+YgBn1b6IcgZ7xmJ4VawbPaYshYo0VUbE2TfhxKlodLtbmZnX
	DLSmZqUhk=
X-Received: by 2002:a17:903:3b8f:b0:2bf:1aa9:6c8a with SMTP id d9443c01a7336-2c719548b7bmr92391135ad.12.1782050367929;
        Sun, 21 Jun 2026 06:59:27 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f5ff5sm50948385ad.29.2026.06.21.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:59:27 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] blk-iolatency: flush enable work after policy deactivation
Date: Sun, 21 Jun 2026 21:59:16 +0800
Message-Id: <20260621135916.2657247-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17110-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 421956AB039

A blk-iolatency rq-qos teardown can free struct blk_iolatency while a
freshly queued enable_work callback still references it. The observed
failure is:

blkcg_iolatency_exit() flushes enable_work before deactivating the
iolatency policy. However, blkcg_deactivate_policy() calls
iolatency_pd_offline() for online policy data, and iolatency_pd_offline()
clears min_lat_nsec through iolatency_set_min_lat_nsec(). If this clears
the last nonzero latency target, enable_cnt reaches zero and schedules
enable_work again after the flush has already returned.

The buggy scenario involves two paths, with each column showing the order
within that path:

blkcg_iolatency_exit() path:          system_wq worker path:
1. Flush old enable_work.             1. enable_work is idle.
2. Deactivate the policy.             2. no worker owns it.
3. Offline queues new enable_work.    3. work item becomes pending.
4. Free blkiolat.                     4. worker later runs the item.
5. Owner storage is gone.             5. worker dereferences blkiolat.

Flush enable_work again after blkcg_deactivate_policy() returns and before
freeing blkiolat. Policy offline callbacks have completed at that point,
so the second drain covers the late queueing path without changing the
normal enable/disable accounting rules.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in assign_work+0x2a/0x150

Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_report+0xd0/0x630
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0xea/0x1a0
 ? assign_work+0x2a/0x150
 kasan_report+0xce/0x100
 ? assign_work+0x2a/0x150
 assign_work+0x2a/0x150
 worker_thread+0x1b7/0x500
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x192/0x1d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2ac/0x3c0
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x2d5/0x6e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 470:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 iolatency_set_limit+0x301/0x450
 cgroup_file_write+0x178/0x2e0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 611:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x43/0x70
 kfree+0x131/0x390
 rq_qos_exit+0x5d/0x90
 __del_gendisk+0x394/0x490
 del_gendisk+0xa1/0xe0
 virtblk_remove+0x41/0xd0
 virtio_dev_remove+0x63/0xe0
 device_release_driver_internal+0x246/0x2e0
 unbind_store+0xa9/0xb0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 __queue_work+0x42a/0x800
 queue_work_on+0x5d/0x70
 iolatency_set_min_lat_nsec+0x196/0x230
 iolatency_pd_offline+0x1f/0x40
 blkcg_deactivate_policy+0x194/0x270
 blkcg_iolatency_exit+0x33/0x40
 rq_qos_exit+0x5d/0x90
 __del_gendisk+0x394/0x490
 del_gendisk+0xa1/0xe0
 virtblk_remove+0x41/0xd0
 virtio_dev_remove+0x63/0xe0
 device_release_driver_internal+0x246/0x2e0
 unbind_store+0xa9/0xb0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 __queue_work+0x42a/0x800
 queue_work_on+0x5d/0x70
 iolatency_set_min_lat_nsec+0x196/0x230
 iolatency_set_limit+0x3f1/0x450
 cgroup_file_write+0x178/0x2e0
 kernfs_fop_write_iter+0x1ef/0x290
 vfs_write+0x446/0x6f0
 ksys_write+0xc7/0x160
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 block/blk-iolatency.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1aaee6fb0f59..a0bdd8a5c94c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -639,6 +639,11 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	timer_shutdown_sync(&blkiolat->timer);
 	flush_work(&blkiolat->enable_work);
 	blkcg_deactivate_policy(rqos->disk, &blkcg_policy_iolatency);
+	/*
+	 * blkcg_deactivate_policy() invokes iolatency_pd_offline(), which may
+	 * queue enable_work again when it clears the last latency target.
+	 */
+	flush_work(&blkiolat->enable_work);
 	kfree(blkiolat);
 }
 
-- 
2.43.0


