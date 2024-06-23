Return-Path: <cgroups+bounces-3289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533A91379E
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 06:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AFA1C2109E
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 04:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6A168CC;
	Sun, 23 Jun 2024 04:25:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849214293
	for <cgroups@vger.kernel.org>; Sun, 23 Jun 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719116728; cv=none; b=dgJiEMY56MQ21tgeXZt+HfqSzhmBqmu8i02jh/UOkNzimm7KRhibhNp09iejBn3bu9hkrCN7vRQVVJP3KOU7TTSo9M3Sdl+b7m0xwoIHITuDMiJ4c9WFaj5mzw5VLbSqspS1NeBL2Yb3EKA1WqHmtcEb7ZzYKP3U4cmpxvuoIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719116728; c=relaxed/simple;
	bh=ihiWTy2t1CwhS+Zprhb2LRRAKWfjvvCLhOEtXdV2nJo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C/PpPDImJFW5HM3sCdbkULXelTj1EC20O8esS7SVzhnTPd8lTR3snty7Tj8I3teW7MRSqgMAW/mk0TPlgwNn48rQ1x78BMqgQMMQo1yGEyLtnV4ZpsLajfBCb4PtvV3Bu0VJ+oWeesu4woxUOnYHHcZL8XedG8B137YbBCg6eks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eee7741583so382528239f.1
        for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 21:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719116725; x=1719721525;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwdLFI2e5gs/0LMJ6TM9AV+N+XHwFR0ZXviw3DAT3UA=;
        b=YgAqirNKbQ8pYMuu+Wo+bFKio5SZ2i79yiSBWziP21ZuzwWgV7TDYxTgWiK2UryKph
         4FHmi32l+g0Clh7kZV4e2cHha/WT8xj9VjHW0MBKLU9n9wwX1gmNDoAuMB+vmkv9LX4L
         vB4PdVQDFXze+0lky5GfULCl6KygS4D9qD9rs0Py0kfVaslw9bLtUSv/U0c/LWSc0ERg
         8Jnq8XyqpCSu5wvWdYti4FVXQ9RDaSa3F5bYIHj2SOqUy/SaT81ZrU1SRIsDurwPqPIY
         6s4Cb+wUc7f1vyTd3CNnG5o2rH1GUXi4qpT+YhBrTOzE5Mt6TPYoVqdkOMV/HgWiUYRK
         TRwA==
X-Gm-Message-State: AOJu0YzfTgI8JtdLhqcyLYuL7//9shs24QufSwsxwFEI38lIBwaYDxKX
	joYhmd1LEMdoxo40yS1BcxhTyVR6ygZAvtGVv+4we+pwOMdgOpFGLWYPsW5m477bFKNxg5jwzNq
	5K+qQj6ewrm0jw7lnnCFpjCFWK/kVGna4Zvoag11iIxUbddumLv9y6bvoqA==
X-Google-Smtp-Source: AGHT+IECEEwlJEqAN2j2SR95CqZiX+Zqf56dFqp++xLeTctujp0SskuOQTuxGFNDykVOOzE5ltSm9keCK4nHpS7EjdmC3lcB4e9v
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871c:b0:4b9:38aa:497a with SMTP id
 8926c6da1cb9f-4b9ef9befecmr50213173.0.1719116725116; Sat, 22 Jun 2024
 21:25:25 -0700 (PDT)
Date: Sat, 22 Jun 2024 21:25:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba7521061b870df8@google.com>
Subject: [syzbot] [cgroups?] KASAN: invalid-free in build_sched_domains
From: syzbot <syzbot+05801a3641d9817ee5ec@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, longman@redhat.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b21bca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=05801a3641d9817ee5ec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05801a3641d9817ee5ec@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 1024
hfsplus: unable to find HFS+ superblock
==================================================================
BUG: KASAN: invalid-free in __sdt_free kernel/sched/topology.c:2302 [inline]
BUG: KASAN: invalid-free in __free_domain_allocs kernel/sched/topology.c:1498 [inline]
BUG: KASAN: invalid-free in build_sched_domains+0x14df/0x52e0 kernel/sched/topology.c:2535
Free of addr ffff88802b4a3f89 by task syz-executor.1/13033

CPU: 3 PID: 13033 Comm: syz-executor.1 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x15e/0x160 mm/kasan/common.c:223
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4558
 __sdt_free kernel/sched/topology.c:2302 [inline]
 __free_domain_allocs kernel/sched/topology.c:1498 [inline]
 build_sched_domains+0x14df/0x52e0 kernel/sched/topology.c:2535
 partition_sched_domains_locked+0x519/0x9e0 kernel/sched/topology.c:2747
 partition_and_rebuild_sched_domains kernel/cgroup/cpuset.c:1181 [inline]
 rebuild_sched_domains_locked+0xebb/0x2100 kernel/cgroup/cpuset.c:1246
 update_relax_domain_level kernel/cgroup/cpuset.c:2952 [inline]
 cpuset_write_s64+0x2ca/0x340 kernel/cgroup/cpuset.c:3560
 cgroup_file_write+0x5ad/0x7d0 kernel/cgroup/cgroup.c:4113
 kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7293579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e855ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 000000000000000e RCX: 0000000020000040
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 13033:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_node_noprof include/linux/slab.h:677 [inline]
 __sdt_alloc kernel/sched/topology.c:2251 [inline]
 __visit_domain_allocation_hell kernel/sched/topology.c:1510 [inline]
 build_sched_domains+0x37c/0x52e0 kernel/sched/topology.c:2401
 partition_sched_domains_locked+0x519/0x9e0 kernel/sched/topology.c:2747
 partition_and_rebuild_sched_domains kernel/cgroup/cpuset.c:1181 [inline]
 rebuild_sched_domains_locked+0xebb/0x2100 kernel/cgroup/cpuset.c:1246
 update_relax_domain_level kernel/cgroup/cpuset.c:2952 [inline]
 cpuset_write_s64+0x2ca/0x340 kernel/cgroup/cpuset.c:3560
 cgroup_file_write+0x5ad/0x7d0 kernel/cgroup/cgroup.c:4113
 kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff88802b4a3f80
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 9 bytes inside of
 16-byte region [ffff88802b4a3f80, ffff88802b4a3f90)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b4a3
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888015442640 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5530, tgid 5530 (syz-executor.3), ts 162857508656, free_ts 162402453637
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_slowpath mm/page_alloc.c:4211 [inline]
 __alloc_pages_noprof+0x6ad/0x2460 mm/page_alloc.c:4691
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_node_noprof+0x36c/0x450 mm/slub.c:4129
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:634
 xt_jumpstack_alloc net/netfilter/x_tables.c:1355 [inline]
 xt_replace_table+0x1c7/0x910 net/netfilter/x_tables.c:1394
 __do_replace+0x1d9/0x9c0 net/ipv4/netfilter/arp_tables.c:912
 compat_do_replace+0x3ca/0x500 net/ipv4/netfilter/ip_tables.c:1529
 do_ip6t_set_ctl+0x686/0xc20 net/ipv6/netfilter/ip6_tables.c:1641
 nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x133/0x1a0 net/ipv6/ipv6_sockglue.c:999
 tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3765
page last free pid 7520 tgid 7520 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4008
 ptlock_alloc+0x1f/0x70 mm/memory.c:6444
 ptlock_init include/linux/mm.h:2968 [inline]
 pagetable_pte_ctor include/linux/mm.h:2991 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:73 [inline]
 pte_alloc_one+0x74/0x370 arch/x86/mm/pgtable.c:33
 __pte_alloc+0x6e/0x3a0 mm/memory.c:442
 copy_pte_range mm/memory.c:1094 [inline]
 copy_pmd_range mm/memory.c:1240 [inline]
 copy_pud_range mm/memory.c:1277 [inline]
 copy_p4d_range mm/memory.c:1301 [inline]
 copy_page_range+0x2fea/0x5c10 mm/memory.c:1399
 dup_mmap kernel/fork.c:751 [inline]
 dup_mm kernel/fork.c:1688 [inline]
 copy_mm+0x1416/0x2680 kernel/fork.c:1737
 copy_process+0x3ea8/0x6f50 kernel/fork.c:2390
 kernel_clone+0xfd/0x980 kernel/fork.c:2797
 __do_compat_sys_ia32_clone+0xb7/0x100 arch/x86/kernel/sys_ia32.c:254
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Memory state around the buggy address:
 ffff88802b4a3e80: 00 06 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff88802b4a3f00: 00 00 fc fc fa fb fc fc 00 07 fc fc 00 00 fc fc
>ffff88802b4a3f80: 00 00 fc fc 00 00 fc fc fa fb fc fc 00 00 fc fc
                      ^
 ffff88802b4a4000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802b4a4080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

