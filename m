Return-Path: <cgroups+bounces-15876-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHXtG/4uBGqNFAIAu9opvQ
	(envelope-from <cgroups+bounces-15876-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:57:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CD52F2F8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A1733006929
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7833D75D6;
	Wed, 13 May 2026 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qw7k/od9"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A53EDE4C;
	Wed, 13 May 2026 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659064; cv=none; b=A9+Ui55fN/xLFtqaCH17FZQ0H69sCccxRzbnBVEqrsc1/a81s579/HY8IqYvoNkwUCpjh005hyx1x3VtinTMwpXtOhGS2cR3I17hZmRyyPrmQ3xOiQsciTKk5TFy7yTPRMoCGs0r6PlmoeXPhM1GINwObea7kbqMnaXUbwg2KvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659064; c=relaxed/simple;
	bh=q1kYmQJIIXdK7nHLWyP1FRpGZnD6+wdlRASZoMilCpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxaaHwAK7L528WvXVDszAj8KkNOvrAGJ+22voE/P/jgAYqsBT/fgzdgkqLBzYlSaVN+60ENPxr2xfWKu9ytUEB3dQQzP927fT8iRZW7yET2M9IEwJFxe3jNhhk2RDSnBfM06RB5bWiVuzHBNkmwNH0Sf3uoSfe1mfpDjxlFSnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qw7k/od9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QN
	J0pX4HvWDuJCJuN3VN499U7DmFHT6TG7ja77n/UiY=; b=Qw7k/od90YlkvU6+Wb
	LxMfbDMhMYuhtd0ltslbOb3IzcBKWAw4xOpgM1V+yjgJzsG9RpUyclbxL6zfoue2
	jMNper4sTXrfIaB/aOa9F10pkbmhOPkvegbOj63c71OjXXTAQPvzcfcYR72FSvW2
	0iw9a45UD4cDB/gIb992W1jTc=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXdeHHLgRqvE5+BA--.7181S2;
	Wed, 13 May 2026 15:56:55 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Breno Leitao <leitao@debian.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Robert Garcia <rob_garcia@163.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init
Date: Wed, 13 May 2026 15:56:54 +0800
Message-Id: <20260513075654.2132595-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXdeHHLgRqvE5+BA--.7181S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr1fXF48tryDuw47AFyxXwb_yoWxJrW5pF
	43Kry5GrW0qr4xWF4jgF15uryYgan5A3WUArWfurn5AF1UKrn7Z3WDAFWUZryfAr47WF4a
	qr4Ut3y8Kwn0kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_c_-DUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5ghZxGoELsgYoAAA3D
X-Rspamd-Queue-Id: 6D6CD52F2F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15876-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,debian.org,toxicpanda.com,163.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

[ Upstream commit ec14a87ee1999b19d8b7ed0fa95fea80644624ae ]

blk-iocost sometimes causes the following crash:

  BUG: kernel NULL pointer dereference, address: 00000000000000e0
  ...
  RIP: 0010:_raw_spin_lock+0x17/0x30
  Code: be 01 02 00 00 e8 79 38 39 ff 31 d2 89 d0 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 65 ff 05 48 d0 34 7e b9 01 00 00 00 31 c0 <f0> 0f b1 0f 75 02 5d c3 89 c6 e8 ea 04 00 00 5d c3 0f 1f 84 00 00
  RSP: 0018:ffffc900023b3d40 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 00000000000000e0 RCX: 0000000000000001
  RDX: ffffc900023b3d20 RSI: ffffc900023b3cf0 RDI: 00000000000000e0
  RBP: ffffc900023b3d40 R08: ffffc900023b3c10 R09: 0000000000000003
  R10: 0000000000000064 R11: 000000000000000a R12: ffff888102337000
  R13: fffffffffffffff2 R14: ffff88810af408c8 R15: ffff8881070c3600
  FS:  00007faaaf364fc0(0000) GS:ffff88842fdc0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000000e0 CR3: 00000001097b1000 CR4: 0000000000350ea0
  Call Trace:
   <TASK>
   ioc_weight_write+0x13d/0x410
   cgroup_file_write+0x7a/0x130
   kernfs_fop_write_iter+0xf5/0x170
   vfs_write+0x298/0x370
   ksys_write+0x5f/0xb0
   __x64_sys_write+0x1b/0x20
   do_syscall_64+0x3d/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

This happens because iocg->ioc is NULL. The field is initialized by
ioc_pd_init() and never cleared. The NULL deref is caused by
blkcg_activate_policy() installing blkg_policy_data before initializing it.

blkcg_activate_policy() was doing the following:

1. Allocate pd's for all existing blkg's and install them in blkg->pd[].
2. Initialize all pd's.
3. Online all pd's.

blkcg_activate_policy() only grabs the queue_lock and may release and
re-acquire the lock as allocation may need to sleep. ioc_weight_write()
grabs blkcg->lock and iterates all its blkg's. The two can race and if
ioc_weight_write() runs during #1 or between #1 and #2, it can encounter a
pd which is not initialized yet, leading to crash.

The crash can be reproduced with the following script:

  #!/bin/bash

  echo +io > /sys/fs/cgroup/cgroup.subtree_control
  systemd-run --unit touch-sda --scope dd if=/dev/sda of=/dev/null bs=1M count=1 iflag=direct
  echo 100 > /sys/fs/cgroup/system.slice/io.weight
  bash -c "echo '8:0 enable=1' > /sys/fs/cgroup/io.cost.qos" &
  sleep .2
  echo 100 > /sys/fs/cgroup/system.slice/io.weight

with the following patch applied:

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index fc49be622e05..38d671d5e10c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1553,6 +1553,12 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
> 		pd->online = false;
> 	}
>
> +       if (system_state == SYSTEM_RUNNING) {
> +               spin_unlock_irq(&q->queue_lock);
> +               ssleep(1);
> +               spin_lock_irq(&q->queue_lock);
> +       }
> +
> 	/* all allocated, init in the same order */
> 	if (pol->pd_init_fn)
> 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)

I don't see a reason why all pd's should be allocated, initialized and
onlined together. The only ordering requirement is that parent blkgs to be
initialized and onlined before children, which is guaranteed from the
walking order. Let's fix the bug by allocating, initializing and onlining pd
for each blkg and holding blkcg->lock over initialization and onlining. This
ensures that an installed blkg is always fully initialized and onlined
removing the the race window.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 9d179b865449 ("blkcg: Fix multiple bugs in blkcg_activate_policy()")
Link: https://lore.kernel.org/r/ZN0p5_W-Q9mAHBVY@slm.duckdns.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 block/blk-cgroup.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f314192b6de8..ce074d9fb709 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1392,7 +1392,7 @@ int blkcg_activate_policy(struct request_queue *q,
 retry:
 	spin_lock_irq(&q->queue_lock);
 
-	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
+	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
@@ -1430,21 +1430,20 @@ int blkcg_activate_policy(struct request_queue *q,
 				goto enomem;
 		}
 
-		blkg->pd[pol->plid] = pd;
+		spin_lock(&blkg->blkcg->lock);
+
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		pd->online = false;
-	}
+		blkg->pd[pol->plid] = pd;
 
-	/* all allocated, init in the same order */
-	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
-			pol->pd_init_fn(blkg->pd[pol->plid]);
+		if (pol->pd_init_fn)
+			pol->pd_init_fn(pd);
 
-	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		if (pol->pd_online_fn)
-			pol->pd_online_fn(blkg->pd[pol->plid]);
-		blkg->pd[pol->plid]->online = true;
+			pol->pd_online_fn(pd);
+		pd->online = true;
+
+		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
@@ -1461,14 +1460,19 @@ int blkcg_activate_policy(struct request_queue *q,
 	return ret;
 
 enomem:
-	/* alloc failed, nothing's initialized yet, free everything */
+	/* alloc failed, take down everything */
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
+		struct blkg_policy_data *pd;
 
 		spin_lock(&blkcg->lock);
-		if (blkg->pd[pol->plid]) {
-			pol->pd_free_fn(blkg->pd[pol->plid]);
+		pd = blkg->pd[pol->plid];
+		if (pd) {
+			if (pd->online && pol->pd_offline_fn)
+				pol->pd_offline_fn(pd);
+			pd->online = false;
+			pol->pd_free_fn(pd);
 			blkg->pd[pol->plid] = NULL;
 		}
 		spin_unlock(&blkcg->lock);
-- 
2.34.1


