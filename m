Return-Path: <cgroups+bounces-12430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A93CC8A40
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C186D31F9D98
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A803313E34;
	Wed, 17 Dec 2025 15:37:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199A31A56B
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985848; cv=none; b=fkP1X8rBuLCtIjcFcLCXBRned6dbg90KSSsbm+zKnb3tDcSVwuMmefxOWkY6dlLy2LhLoD/AcP1BVVl86DnVLI53Ix8d83ezklew/0jab0tL0fF4J7EbN1s9bzvygEMILHri7+M770OQ5aAy20z0BTHNsKAukKVz7mzv7Z7Cv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985848; c=relaxed/simple;
	bh=qa8+MN6aQSFscGbTirBZOkfFf9SGdNyqmzI91vM3XiU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mPhX1/3g60TZUEiC/2fsTTp6wMi6JykYyUH42xH0vj6tuTiBjxb1SyVIeZKskUpw7/+EUaL6xpkibw/BJkFkGGZfZ/KNVKUHh+5y/SGF3KS8OdeWzP1HvPAYI/6eueh4DSqCdPqxMoOYQprKssKsF6psuxOLesNbzSzdnGIpTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6574d564a9eso9526767eaf.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 07:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765985846; x=1766590646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHBBZDS3uErD1WD2BXCa3sIMfoS47xwCNCL3pxegcfQ=;
        b=QnhY75C2h/p+GNIAX8K1GooFHsWFLBAmaqt+X1yWimtSSxJJg+Np4riY5xeKb06M4l
         5OZPeCwewsMRAx2C0U7hXQVCPH+u4DhFZYakI+6hqM9ydQ9bNw7xaWjHXci7JPUNk0Bj
         ifl9XObvdYCgHYGxN0Z4F2dbqWnVUsce+AAs3qy8pF6IzFdL3S68P4HVJt0H9yoLiH+H
         hWVrFvJylFvHxLX/5vvmYLRbbnQQ86sZ+IUq7jV8wdrdPiUqLFh8V89AaqCDQmu62i3R
         g2vhVLZVpR5d1qoK2waXm9sWKzgEip4OAKMm+2ul/Defn42Qez+u4pMWtoUos/ezyK5f
         cc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIhP7IZntVySqOFTme6F+ZNV2v60CIETJxIWD/t2h2Pv1DfBgbs07eOwqhkxnmASisow+qb/mo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vwjzh3GKYT5xt6eU1IQ/tt/IvFWe51hwlKK1kDpfU2JfecOb
	aEaEKVCnrbZp9EMr0jsToFLhkysPXqhnZyaYiM8/1XpjlicQXPOQ87JAi+lVy2a8ugJ08cNaaGA
	ljsPRkQs4ZM0NYrOD2P4MG9DA1QpHzNAUsu0Dm95XrpLwTy3AK2efin1vQb0=
X-Google-Smtp-Source: AGHT+IFZP0qpyXlqzklfHcoOPG7u9lmcK6SkDw7cma3REMbPywpjFcCQZq8MnjXXF5NJMOZxqq/v+kKjJbuuCQLuaTifZacJHxSI
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:198f:b0:659:9a49:9044 with SMTP id
 006d021491bc7-65b45165e85mr7444714eaf.15.1765985845818; Wed, 17 Dec 2025
 07:37:25 -0800 (PST)
Date: Wed, 17 Dec 2025 07:37:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6942ce35.a70a0220.207337.006b.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] INFO: rcu detected stall in sys_signalfd4 (2)
From: syzbot <syzbot+d27ce4d3ef3a5d501b54@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a5663c04bb6 Add linux-next specific files for 20251215
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b5ed92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f785244b836412
dashboard link: https://syzkaller.appspot.com/bug?extid=d27ce4d3ef3a5d501b54
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10568392580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fea1fcf777e7/disk-4a5663c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23d586650b2f/vmlinux-4a5663c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a3fea0a5cdf/bzImage-4a5663c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d27ce4d3ef3a5d501b54@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5805/1:b..l P6096/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=13969, q=225 ncpus=2)
task:udevd           state:R  running task     stack:28344 pid:6096  tgid:6096  ppid:5197   task_flags:0x400040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:debug_lockdep_rcu_enabled+0x2d/0x40 kernel/rcu/update.c:320
Code: fa 31 c0 83 3d 17 57 5e 04 00 74 1e 83 3d 2a 86 5e 04 00 74 15 65 48 8b 0c 25 08 a0 c3 92 31 c0 83 b9 2c 0b 00 00 00 0f 94 c0 <e9> 8e e3 02 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90
RSP: 0018:ffffc900031a7938 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffffffff8e37db60 RCX: ffff88807e5a3d00
RDX: 000000005a44979c RSI: ffffffff8be252c0 RDI: ffff88807e5a3d00
RBP: ffffc900031a79d0 R08: ffffffff8230bf9a R09: ffffffff8e341b20
R10: dffffc0000000000 R11: ffffed100fcb4a72 R12: ffffffff8230bf9a
R13: ffff88807e5a3d2c R14: 1ffff92000634f28 R15: dffffc0000000000
 rcu_read_lock_held_common kernel/rcu/update.c:105 [inline]
 rcu_read_lock_sched_held+0x60/0x100 kernel/rcu/update.c:124
 task_css include/linux/cgroup.h:460 [inline]
 mem_cgroup_from_task+0x4d/0x120 mm/memcontrol.c:885
 current_objcg_update+0x1a8/0x2c0 mm/memcontrol.c:2685
 current_obj_cgroup mm/memcontrol.c:2714 [inline]
 __memcg_slab_post_alloc_hook+0x67e/0x730 mm/memcontrol.c:3166
 memcg_slab_post_alloc_hook mm/slub.c:2338 [inline]
 slab_post_alloc_hook mm/slub.c:4964 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_lru_noprof+0x41f/0x6e0 mm/slub.c:5282
 __d_alloc+0x37/0x6f0 fs/dcache.c:1730
 d_alloc_pseudo+0x21/0xc0 fs/dcache.c:1861
 alloc_path_pseudo fs/file_table.c:363 [inline]
 alloc_file_pseudo+0xcc/0x210 fs/file_table.c:379
 __anon_inode_getfile fs/anon_inodes.c:166 [inline]
 anon_inode_getfile_fmode+0xb0/0x1c0 fs/anon_inodes.c:232
 do_signalfd4+0x1a5/0x3f0 fs/signalfd.c:273
 __do_sys_signalfd4 fs/signalfd.c:308 [inline]
 __se_sys_signalfd4 fs/signalfd.c:299 [inline]
 __x64_sys_signalfd4+0x154/0x190 fs/signalfd.c:299
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac0bf214ff
RSP: 002b:00007ffe3f3752e8 EFLAGS: 00000286 ORIG_RAX: 0000000000000121
RAX: ffffffffffffffda RBX: 000056168c657840 RCX: 00007fac0bf214ff
RDX: 0000000000000008 RSI: 00007ffe3f375360 RDI: 00000000ffffffff
RBP: 000056168c64d910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000080800 R11: 0000000000000286 R12: 000056168c66aca0
R13: 00007ffe3f375360 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:kworker/1:3     state:R  running task     stack:24000 pid:5805  tgid:5805  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_power_efficient gc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:seqcount_lockdep_reader_access+0x17e/0x1c0 include/linux/seqlock.h:75
Code: f8 4d 85 e4 75 16 e8 71 39 34 f8 eb 15 e8 6a 39 34 f8 e8 15 ba d7 01 4d 85 e4 74 ea e8 5b 39 34 f8 fb 48 c7 04 24 0e 36 e0 45 <4b> c7 04 3e 00 00 00 00 66 43 c7 44 3e 09 00 00 43 c6 44 3e 0b 00
RSP: 0018:ffffc9000401f860 EFLAGS: 00000293
RAX: ffffffff898db805 RBX: 0000000000000000 RCX: ffff8880336c1e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000401f910 R08: ffffffff8fc3ce77 R09: 1ffffffff1f879ce
R10: dffffc0000000000 R11: fffffbfff1f879cf R12: 0000000000000200
R13: 1ffff110066d8460 R14: 1ffff92000803f0c R15: dffffc0000000000
 nf_conntrack_get_ht include/net/netfilter/nf_conntrack.h:342 [inline]
 gc_worker+0x308/0x1380 net/netfilter/nf_conntrack_core.c:1548
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10562 jiffies! g13969 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27728 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6097 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 ea d9 36 f6 48 89 df e8 22 51 37 f6 e8 5d b8 61 f6 fb bf 01 00 00 00 <e8> a2 45 29 f6 65 8b 05 db 8f 5b 07 85 c0 74 07 5b e9 c1 4b 00 00
RSP: 0018:ffffc900031e7c60 EFLAGS: 00000286
RAX: 0b0f3b2f78972000 RBX: ffff88802ef040c0 RCX: 0b0f3b2f78972000
RDX: 0000000000000000 RSI: ffffffff8daa56ad RDI: 0000000000000001
RBP: 0000000000000011 R08: ffffffff8fc3ce77 R09: 1ffffffff1f879ce
R10: dffffc0000000000 R11: fffffbfff1f879cf R12: 1ffff11005de086b
R13: 0000000000000000 R14: 0000000004000000 R15: ffff88802ef04358
FS:  000055558e963500(0000) GS:ffff8881259e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31463fff CR3: 00000000730da000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 get_signal+0x11a7/0x1340 kernel/signal.c:3037
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2d0/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92b238f751
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:00007ffc8149b8b8 EFLAGS: 00000217
RAX: 0000000000000000 RBX: 00007f92b25e5fa0 RCX: 00007f92b238f749
RDX: 0000200000000300 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f92b2413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f92b25e5fa0 R14: 00007f92b25e5fa0 R15: 0000000000000004
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

