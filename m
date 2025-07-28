Return-Path: <cgroups+bounces-8913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D5B13888
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C823A1C6C
	for <lists+cgroups@lfdr.de>; Mon, 28 Jul 2025 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD50242D9B;
	Mon, 28 Jul 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pri0AUEN"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFB26AF3
	for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697085; cv=none; b=Gsr/rmY7mBS0UeFE1/leU2CrnZ5Fqk6SWXSeOYyMM8SP2cM8HRusUx6zfp7sV5hFa4HOwqwyeLfNB0DRtIvqbFHkitM9cRcWd7VJIlxG7225xtHQ3G1b7aqgiuciISabQgo48C6sdDVDAbR2BgMxcf85EVjn181n0qVFhNoHBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697085; c=relaxed/simple;
	bh=LJVLyxgyABlXHpYw153VKEv/B5Eal91bab73K3/yBIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=d/542E34zup1sbKnuteeFbqRWt4250DYYi29ONd22h4iyu2i3XJsSUhS1OyreDRkCJ0Poc9SqDYF1Y0NEbd8WKf5sdQPqVfwn0ZtrO0KEjE7oh6OczQFDDAF8qYMpRQaJBDubHLmQb4snsFFS5yYR56N2K7MM6v6ccZ8K1w9038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pri0AUEN; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250728100435epoutp024c3be19f1e8fa530484c86e210838d5b~WYjLMO9912008020080epoutp02f
	for <cgroups@vger.kernel.org>; Mon, 28 Jul 2025 10:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250728100435epoutp024c3be19f1e8fa530484c86e210838d5b~WYjLMO9912008020080epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753697075;
	bh=J9ZLlX2aSkwMcC5wFXnqoLTWTC5wxs/G49Rac37NqYM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pri0AUENRvd4rdKedtZmXaAbPzRDxVHYAvYlFHx170JAWvTI/uRZkih3dn7YI6x2N
	 HmP8MYmTMUjvBNC6gYQrbYru4hJn7iZZ00yM1yfsRAT3LaW87/KiL9C46g53Kf5jY8
	 oMRCT4UTQ/k6B+dP9H9kELKRiWXMI4lQO6XkjNP0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250728100434epcas5p3c986696b00e17c6e513a4883209fd9e0~WYjKekBPG1620016200epcas5p3-;
	Mon, 28 Jul 2025 10:04:34 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4brDbk2jn3z3hhTB; Mon, 28 Jul
	2025 10:04:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250728100434epcas5p3995d3444fcec14715c60f73e7a60b1c0~WYjKRMyrh1618416184epcas5p3m;
	Mon, 28 Jul 2025 10:04:34 +0000 (GMT)
Received: from dl380gen10.. (unknown [109.120.22.112]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250728100433epsmtip23ee8525d47871ff2ceb5e39bd2f6d9f3~WYjJ4P88_2723727237epsmtip2I;
	Mon, 28 Jul 2025 10:04:33 +0000 (GMT)
From: Jiufei Xue <jiufei.xue@samsung.com>
To: tj@kernel.org, jack@suse.cz
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiufei Xue <jiufei.xue@samsung.com>
Subject: [PATCH] fs: writeback: fix use-after-free in __mark_inode_dirty()
Date: Mon, 28 Jul 2025 18:07:15 +0800
Message-ID: <20250728100715.3863241-1-jiufei.xue@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250728100434epcas5p3995d3444fcec14715c60f73e7a60b1c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20250728100434epcas5p3995d3444fcec14715c60f73e7a60b1c0
References: <CGME20250728100434epcas5p3995d3444fcec14715c60f73e7a60b1c0@epcas5p3.samsung.com>

An use-after-free issue occurred when __mark_inode_dirty() get the
bdi_writeback that was in the progress of switching.

CPU: 1 PID: 562 Comm: systemd-random- Not tainted 6.6.56-gb4403bd46a8e #1
......
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mark_inode_dirty+0x124/0x418
lr : __mark_inode_dirty+0x118/0x418
sp : ffffffc08c9dbbc0
........
Call trace:
 __mark_inode_dirty+0x124/0x418
 generic_update_time+0x4c/0x60
 file_modified+0xcc/0xd0
 ext4_buffered_write_iter+0x58/0x124
 ext4_file_write_iter+0x54/0x704
 vfs_write+0x1c0/0x308
 ksys_write+0x74/0x10c
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x114
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x40/0xe4
 el0t_64_sync_handler+0x120/0x12c
 el0t_64_sync+0x194/0x198

Root cause is:

systemd-random-seed                         kworker
----------------------------------------------------------------------
___mark_inode_dirty                     inode_switch_wbs_work_fn

  spin_lock(&inode->i_lock);
  inode_attach_wb
  locked_inode_to_wb_and_lock_list
     get inode->i_wb
     spin_unlock(&inode->i_lock);
     spin_lock(&wb->list_lock)
  spin_lock(&inode->i_lock)
  inode_io_list_move_locked
  spin_unlock(&wb->list_lock)
  spin_unlock(&inode->i_lock)
                                    spin_lock(&old_wb->list_lock)
                                      inode_do_switch_wbs
                                        spin_lock(&inode->i_lock)
                                        inode->i_wb = new_wb
                                        spin_unlock(&inode->i_lock)
                                    spin_unlock(&old_wb->list_lock)
                                    wb_put_many(old_wb, nr_switched)
                                      cgwb_release
                                      old wb released
  wb_wakeup_delayed() accesses wb,
  then trigger the use-after-free
  issue

Fix this race condition by holding inode spinlock until
wb_wakeup_delayed() finished.

Signed-off-by: Jiufei Xue <jiufei.xue@samsung.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb..a07b8cf73 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2608,10 +2608,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2621,6 +2617,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
 				wb_wakeup_delayed(wb);
+
+			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
+			trace_writeback_dirty_inode_enqueue(inode);
+
 			return;
 		}
 	}
-- 
2.43.0


