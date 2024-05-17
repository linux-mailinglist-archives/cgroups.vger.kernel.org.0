Return-Path: <cgroups+bounces-2949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EE8C8130
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 09:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A21C20CA6
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907E15AE0;
	Fri, 17 May 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwnO16QU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA514AA8;
	Fri, 17 May 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930079; cv=none; b=ZqHmFhzQymMxLfveqRHuaIiw3Db+UquqNWm+3oAshzCf8I8bLgyxc6WXARV+HiZ++hYtuzXaPqHJA9pe2p7c/EW68X/XF4wDLVaFvrxDtpB1o/bZWMS3PLL8V2nb1K3xbE8x+IxoMIKQoN02hO9rNhhpPG3yuOjQvXsrmjobUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930079; c=relaxed/simple;
	bh=2tYx13tcjA8/9sWQVmVdr7yenargZvWhHyjvwmideG4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A2gPZ3cVDvzm5+9SpFU7qftHV4HjshkPFsIwxEiROiVyy5fClnImL6FPUCWdiZjm+qTg9H/gC0g1M4IOj/SNBd4y/DN/SCgTkTbARkNZ1ASXn6wqbIQzKV6U/F9Crj32so+0nAeGPY/IFrxD5tpHh0Ndc7Bf+dharsEbfZGKr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwnO16QU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b81d087aso380229066b.3;
        Fri, 17 May 2024 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715930076; x=1716534876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQNZo5+WH/rQrWlnhqMOJqcbx7yABzdijkFTSTjJ2DI=;
        b=JwnO16QUPipjwxS2Tblnz0pD88m3Lc4TEueCZqtrZNeFO0IHEs92dn9yASQF0CZXoN
         iGhoqsE9tAxzpCB+U/J+K36jCD8c3TGw7R4FNpWPm4m242RUL6BHzB/5n2nw5uj7ZbbH
         iTBS+21vWz+HvTIyF5MwoaCVROCWtrhZkNDHbYBRSfYXTYbSXlP7fl+/JLpYcM7LcYAL
         o+sQiZy5HL0H/k+8PHyphC0v2CppR2VjtokPu34Pqw3zcWA5PdXJ86TQMRpyJQ9Hn0hY
         zQ7oVH/Rl6f7TQbmseDt73qQBVPL8KoXZNTFdItsG3cMRC+8lvTZ8oeG8k48xyNxYJ6o
         iLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930076; x=1716534876;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQNZo5+WH/rQrWlnhqMOJqcbx7yABzdijkFTSTjJ2DI=;
        b=tREAbzEBkJj+LQpDFDBqCMqWCWm6kMQEha9yH8AqncVF3bfG7M6KUg8j1ma74ekmhS
         bgM6+nPQCOnV0BypSng1oihczakJpErkF6mj8/tTPMk3yH1Kxg/iFoFFyvheDJSM0e76
         HjyX1n6gfJRpMHshnH02ShhRqYyPiFv/oFyK07ZaQqj4Rf9cvKidMwHX3u1zTTc19+vG
         JXECO9AJs6avChNUhoV3i+mQvfPRDO0ceDHwl+L0KLzJYryoGkHfa4m4pzcPk3h4Ib/l
         v2lVA4ei2E9Bmxo5S28+dj4O9oi0hnsRAV7ouDgoDqyaDsAlghoZDrUfh354z7ARuxPj
         oP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8npWYw8b3p0RDIPx7yRBahIc64iy/r5MVuGR/fjpD2na6E6AasM7LVualuw64qAvH0UoiFVGCWOdg3uEJbi/yA7Cl+WVnIQ==
X-Gm-Message-State: AOJu0YydXfT1rxocCIS8PWTql2gld3ge26JS+3Fp7VW3A/+VqtNxakL3
	RbzUadaup7cUfNp+Tr9JlhiqUMP/x7j4M7Zx+WGcAELf1XJQR0FmmsFCxhb9FQSzkF+OCG5CSib
	uqsVFcktfvkjTYcxgEybKtEA0/l0bCh9waKfFvA==
X-Google-Smtp-Source: AGHT+IGCW3QJDfGn/iaUG9/r/evjnwOz8ukz3z9i4MTFS71LedT8ckpot7+pKjcojVMUguOsNxQ/AeDTMpqJQR8SEAM=
X-Received: by 2002:a17:907:7748:b0:a59:cf38:5343 with SMTP id
 a640c23a62f3a-a5a2d5724dfmr1938100166b.27.1715930075643; Fri, 17 May 2024
 00:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 17 May 2024 15:14:23 +0800
Message-ID: <CAEkJfYMMobwnoULvM8SyfGtbuaWzqfvZ_5BGjj0APv+=1rtkbA@mail.gmail.com>
Subject: [Linux kernel bug] KASAN: slab-use-after-free Read in pressure_write
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, tj@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a slab-use-after-free bug while using our modified
syzkaller. It was tested against the latest upstream kernel (6.9).
Kernel crash log is listed below.

==================================================================
BUG: KASAN: slab-use-after-free in pressure_write+0x21e/0x500
kernel/cgroup/cgroup.c:3789
Read of size 8 at addr ffff888014beec08 by task syz-executor.2/9495

CPU: 0 PID: 9495 Comm: syz-executor.2 Not tainted 6.9.0-05151-g1b294a1f3561 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x201/0x300 lib/dump_stack.c:114
 print_address_description+0x7b/0x360 mm/kasan/report.c:377
 print_report+0xfd/0x1e0 mm/kasan/report.c:488
 kasan_report+0xce/0x100 mm/kasan/report.c:601
 pressure_write+0x21e/0x500 kernel/cgroup/cgroup.c:3789
 cgroup_file_write+0x2cc/0x690 kernel/cgroup/cgroup.c:4092
 kernfs_fop_write_iter+0x3ab/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa46/0xcb0 fs/read_write.c:590
 ksys_write+0x17b/0x2a0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fb7d3044caf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 fd ff ff 48 8b 54
24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 2d 44 89 c7 48 89 44 24 08 e8 cc fd ff ff 48
RSP: 002b:00007fb7d3d65f60 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fb7d3044caf
RDX: 0000000000000003 RSI: 00007fb7d3d667c0 RDI: 0000000000000008
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200004c0 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffeac4a58bf R14: 00007ffeac4a5a60 R15: 00007fb7d3d66d80
 </TASK>

Allocated by task 9495:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x370 mm/slub.c:4070
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 cgroup_file_open+0x8e/0x2a0 kernel/cgroup/cgroup.c:4038
 kernfs_fop_open+0xa4b/0xd00 fs/kernfs/file.c:706
 do_dentry_open+0x8e7/0x1560 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x285b/0x3200 fs/namei.c:3807
 do_filp_open+0x268/0x4f0 fs/namei.c:3834
 do_sys_openat2+0x12f/0x1c0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

Freed by task 9496:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4353 [inline]
 kfree+0x137/0x310 mm/slub.c:4463
 kernfs_release_file+0x12b/0x2d0 fs/kernfs/file.c:746
 kernfs_drain_open_files+0x2a0/0x480 fs/kernfs/file.c:815
 kernfs_drain+0x4f8/0x6b0 fs/kernfs/dir.c:514
 kernfs_show+0x267/0x370 fs/kernfs/dir.c:1441
 cgroup_file_show kernel/cgroup/cgroup.c:4503 [inline]
 cgroup_pressure_write+0x458/0x770 kernel/cgroup/cgroup.c:3881
 cgroup_file_write+0x2cc/0x690 kernel/cgroup/cgroup.c:4092
 kernfs_fop_write_iter+0x3ab/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa46/0xcb0 fs/read_write.c:590
 ksys_write+0x17b/0x2a0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

The buggy address belongs to the object at ffff888014beec00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 freed 192-byte region [ffff888014beec00, ffff888014beecc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14bee
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff8880134413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 8145,
tgid 8145 (syz-executor.3), ts 154392465805, free_ts 77458148506
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x7d2/0x850 mm/page_alloc.c:3317
 __alloc_pages+0x25e/0x580 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x6b/0x1a0 mm/slub.c:2190
 allocate_slab+0x5d/0x200 mm/slub.c:2353
 new_slab mm/slub.c:2406 [inline]
 ___slab_alloc+0xa95/0xf20 mm/slub.c:3592
 __slab_alloc mm/slub.c:3682 [inline]
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 __do_kmalloc_node mm/slub.c:4038 [inline]
 __kmalloc_node_track_caller+0x2d8/0x4f0 mm/slub.c:4059
 kmemdup+0x2a/0x70 mm/util.c:131
 _Z7kmemdupPKvU25pass_dynamic_object_size0mj
include/linux/fortify-string.h:743 [inline]
 neigh_parms_alloc+0x7d/0x4d0 net/core/neighbour.c:1718
 ipv6_add_dev+0x321/0x1290 net/ipv6/addrconf.c:399
 addrconf_notify+0x6a0/0x1010 net/ipv6/addrconf.c:3652
 notifier_call_chain+0x13b/0x1f0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 register_netdevice+0x15fd/0x1a90 net/core/dev.c:10407
 bond_newlink+0x43/0x90 drivers/net/bonding/bond_netlink.c:577
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1581/0x20c0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x893/0x10e0 net/core/rtnetlink.c:6595
page last free pid 8084 tgid 8084 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x72f/0x7c0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_small mm/swap.c:119 [inline]
 __folio_put+0x20b/0x360 mm/swap.c:142
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x714/0x1400 fs/pipe.c:344
 call_read_iter include/linux/fs.h:2114 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x96c/0xbb0 fs/read_write.c:476
 ksys_read+0x17b/0x2a0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

Memory state around the buggy address:
 ffff888014beeb00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888014beeb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888014beec00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888014beec80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888014beed00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Currently, no C repro available. Only reproducer in syzlang is
available. However, since we modified syzkaller, the reproducer cannot
be executed directly by original syzkaller.

We analyzed the root cause of this problem. It happens when
concurrently accessing
"/sys/fs/cgroup/sys-fs-fuse-connections.mount/irq.pressure" and
"/sys/fs/cgroup/sys-fs-fuse-connections.mount/cgroup.pressure". If we
echo 0 to cgroup.pressure, kernel will invoke cgroup_pressure_write(),
and call kernfs_show(). It will set kn->flags to KERNFS_HIDDEN and
call kernfs_drain(), in which it frees kernfs_open_file *of. On the
other side, when accessing irq.pressure, kernel calls
pressure_write(), which will access of->priv. So that it triggers a
use-after-free.

If you have any questions, please contact us.

Reported by Yue Sun <samsun1006219@gmail.com>
Reported by xingwei lee <xrivendell7@gmail.com>

Best Regards,
Yue

