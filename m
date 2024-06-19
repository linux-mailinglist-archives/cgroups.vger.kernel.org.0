Return-Path: <cgroups+bounces-3237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71690E180
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 04:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA82281E5B
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 02:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6C1097B;
	Wed, 19 Jun 2024 02:05:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EFCA40;
	Wed, 19 Jun 2024 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762721; cv=none; b=ERNeSRHs4/FebWIXhiWNwiGdpBPWMGbLxjFO5T23jJljicRaeG2zmzvfZ1EIsQ7d/ZsgTwFO8kwL2ZubzdxWhx7eoGQy9NGpgl3u084WCHXFYakFJ9lmJ3GU7DD3iBJKPJ9SK2ml5tVpLYyFI6raPB6dkMG/srLAjS9UvhFz07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762721; c=relaxed/simple;
	bh=6hfhcRfORR1MPZG5dinZMM37Ch6col2tLUEnp/EQ41g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U1WXwemg8yBmtQJWfE06LY4wxCfsLIEMSbouEeyJm6cDrcnK33ML3v8jWOJ5uNLf10wx0To2K7uLW5dMwhEAUkHyW+UE7IL91DSVDH82U5TtAonRCbajTWDD8piB3/su1lr34M4tRZDZJQvzYMPETxNydJ+9gE0UFxUqMjFRyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3n0N5Z8czPrf6;
	Wed, 19 Jun 2024 10:01:08 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 261911403D1;
	Wed, 19 Jun 2024 10:04:41 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 10:04:40 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<akpm@linux-foundation.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <sj@kernel.org>, <m.szyprowski@samsung.com>
Subject: [PATCH v3 -next] mm/hugetlb_cgroup: register lockdep key for cftype
Date: Wed, 19 Jun 2024 01:55:27 +0000
Message-ID: <20240619015527.2212698-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)

When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
trigger a bug,

mount -t cgroup2 none /sys/fs/cgroup
cd /sys/fs/cgroup
echo "+hugetlb" > cgroup.subtree_control

The log is as below:

BUG: key ffff8880046d88d8 has not been registered!
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 3 PID: 226 at kernel/locking/lockdep.c:4945 lockdep_init_map_type+0x185/0x220
Modules linked in:
CPU: 3 PID: 226 Comm: bash Not tainted 6.10.0-rc4-next-20240617-g76db4c64526c #544
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:lockdep_init_map_type+0x185/0x220
Code: 00 85 c0 0f 84 6c ff ff ff 8b 3d 6a d1 85 01 85 ff 0f 85 5e ff ff ff 48 c7 c6 21 99 4a 82 48 c7 c7 60 29 49 82 e8 3b 2e f5
RSP: 0018:ffffc9000083fc30 EFLAGS: 00000282
RAX: 0000000000000000 RBX: ffffffff828dd820 RCX: 0000000000000027
RDX: ffff88803cd9cac8 RSI: 0000000000000001 RDI: ffff88803cd9cac0
RBP: ffff88800674fbb0 R08: ffffffff828ce248 R09: 00000000ffffefff
R10: ffffffff8285e260 R11: ffffffff828b8eb8 R12: ffff8880046d88d8
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880067281c0
FS:  00007f68601ea740(0000) GS:ffff88803cd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005614f3ebc740 CR3: 000000000773a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __warn+0x77/0xd0
 ? lockdep_init_map_type+0x185/0x220
 ? report_bug+0x189/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? lockdep_init_map_type+0x185/0x220
 __kernfs_create_file+0x79/0x100
 cgroup_addrm_files+0x163/0x380
 ? find_held_lock+0x2b/0x80
 ? find_held_lock+0x2b/0x80
 ? find_held_lock+0x2b/0x80
 css_populate_dir+0x73/0x180
 cgroup_apply_control_enable+0x12f/0x3a0
 cgroup_subtree_control_write+0x30b/0x440
 kernfs_fop_write_iter+0x13a/0x1f0
 vfs_write+0x341/0x450
 ksys_write+0x64/0xe0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f68602d9833
Code: 8b 15 61 26 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 08
RSP: 002b:00007fff9bbdf8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f68602d9833
RDX: 0000000000000009 RSI: 00005614f3ebc740 RDI: 0000000000000001
RBP: 00005614f3ebc740 R08: 000000000000000a R09: 0000000000000008
R10: 00005614f3db6ba0 R11: 0000000000000246 R12: 0000000000000009
R13: 00007f68603bd6a0 R14: 0000000000000009 R15: 00007f68603b8880

For lockdep, there is a sanity check in lockdep_init_map_type(), the
lock-class key must either have been allocated statically or must
have been registered as a dynamic key. However the commit e18df2889ff9
("mm/hugetlb_cgroup: prepare cftypes based on template") has changed
the cftypes from static allocated objects to dynamic allocated objects,
so the cft->lockdep_key must be registered proactively.

Fixes: e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on template")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406181046.8d8b2492-oliver.sang@intel.com
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

---
v3: remove #ifdef CONFIG_DEBUG_LOCK_ALLOC in struct cftype
v2: add bug log to commit message
---
 include/linux/cgroup-defs.h | 2 --
 mm/hugetlb_cgroup.c         | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b36690ca0d3f..293af7f8a694 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -681,9 +681,7 @@ struct cftype {
 	__poll_t (*poll)(struct kernfs_open_file *of,
 			 struct poll_table_struct *pt);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key	lockdep_key;
-#endif
 };
 
 /*
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2b899c4ae968..4ff238ba1250 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
 			cft->file_offset = MEMFILE_OFFSET0(offset) +
 					   MEMFILE_FIELD_SIZE(offset) * idx;
 		}
+
+		lockdep_register_key(&cft->lockdep_key);
 	}
 }
 
-- 
2.34.1


