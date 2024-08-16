Return-Path: <cgroups+bounces-4320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AF95415F
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 07:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990A4283626
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAB6FE16;
	Fri, 16 Aug 2024 05:50:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E22C6BB
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787423; cv=none; b=jVwVCT6zSZrmJgviYEBTAEGQObHky/ceIt3vVl9HQJrg3EPQdB8bn1qwDTELBJluLhx5ldE1Lph72WCJMsKBErYtVyv07irsLOpRpIVlvHkzDO9Eq0ruqtDNxw/znXpAXj9kG01l01K05w5Lp59vRlJdvh4s9ATYq6yhrwp7MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787423; c=relaxed/simple;
	bh=NlyeKC98G07ZlP3JtbyLpS66PuDKj7yfqVE4C+kSgq8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dL50h58+C+JDhbnHJaaBf1BDNlvxFsPK0KOEwmCkq9QAVbAa1hbyYqGgcIyB3CEIvIFOPRVqnh4msWh/2LV28xnpLtPfJDpnc45dqDN11Jq7u15Mosrmz0EwyIRjgvt89tawpQFWiCzgpSVh0nAOULZacUGnWynEPRW4717HxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3dc8cdcbso19200735ab.2
        for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 22:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723787421; x=1724392221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsRx3+LRntTKS6uYKzXbggn0dk4hpH/2iuhIfPVYhd4=;
        b=q0l8/ySMqwjT+IiDka55EGMkhFZ8/LmR4p2rooDMOpLZg2h0JJRYrLXkfYIN3OnW4n
         i+LnAaQaL4jJQ2fxfC1e8W+ZhtnCvR+9OAMLld8quBY0rzsRjM0iY8C+MtTsWssN3frc
         aH8PKbpA2NMJqnXdvlgwHOEPQrF+gQa6xem3VVxX/NRX3+OYCETMxpcS3vVJkDDSUVju
         hczdNcXWidHsReTeV32tjXsegMuMGHp+K0NJsZAabX6cWcDjHR/W3iojV79QSuojanIM
         JBD9TZWfygaX/ii7OEPMj5gQO3C+/AVuhCN0umFnGqKvp/6zKUGFEKv8JlrCTu49b4A6
         5iIw==
X-Gm-Message-State: AOJu0Yzedv8AWuMTNRHiUn2L689G5Fyrdk7trkA3P2ZY3Ftm9ulk5vll
	h+ctWrmMuRfjfmW+EpjO5LgAISJvOlhcmqOH8/qLmKoOKUmlr9Q0/hzp5AhO1YGYfyiCz4wxMbG
	J1TSwOJrTILJdQqiKMTI/oHapSEY6esxzZ3U8IssuuyqNH01dN9boi1s=
X-Google-Smtp-Source: AGHT+IGivPBrGdxOdfD1RLlszJrbZlQ1c7663DoJLPrBeUlwu4yqAV9nRh+l8e36WllT15AZlDSihero5fycQ4ggNv3K4YUsvnCG
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:39a:e909:29f6 with SMTP id
 e9e14a558f8ab-39d26c343c3mr1675475ab.0.1723787420970; Thu, 15 Aug 2024
 22:50:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 22:50:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e540f3061fc68863@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in task_rq_lock
From: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    edd1ec2e3a9f Add linux-next specific files for 20240815
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ba4ed5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d063ca2a0d8c/disk-edd1ec2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08634f60bc99/vmlinux-edd1ec2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6f08ac13836/bzImage-edd1ec2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-next-20240815-syzkaller #0 Not tainted
------------------------------------------------------
dhcpcd-run-hook/12621 is trying to acquire lock:
ffffffff8e815038 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff8880b913ea58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:587

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:587
       raw_spin_rq_lock kernel/sched/sched.h:1485 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:689
       cgroup_move_task+0x92/0x2d0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6690
       copy_process+0x3ab1/0x3e30 kernel/fork.c:2620
       kernel_clone+0x226/0x8f0 kernel/fork.c:2806
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2884
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4113
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:340 [inline]
       __console_unlock kernel/printk/printk.c:2801 [inline]
       console_unlock+0x22f/0x4d0 kernel/printk/printk.c:3120
       vprintk_emit+0x5dc/0x7c0 kernel/printk/printk.c:2348
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       set_capacity_and_notify+0x1ae/0x240 block/genhd.c:86
       loop_set_size+0x44/0xb0 drivers/block/loop.c:232
       loop_configure+0x9fb/0xec0 drivers/block/loop.c:1102
       lo_ioctl+0x849/0x1f60
       blkdev_ioctl+0x580/0x6b0 block/ioctl.c:676
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3136 [inline]
       check_prevs_add kernel/locking/lockdep.c:3255 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:323
       console_trylock kernel/printk/printk.c:2754 [inline]
       console_trylock_spinning kernel/printk/printk.c:1958 [inline]
       vprintk_emit+0x2aa/0x7c0 kernel/printk/printk.c:2347
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
       rq_clock kernel/sched/sched.h:1624 [inline]
       replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
       update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
       update_curr+0x575/0xb20 kernel/sched/fair.c:1176
       put_prev_entity+0x3d/0x210 kernel/sched/fair.c:5505
       put_prev_task_fair+0x4d/0x80 kernel/sched/fair.c:8686
       put_prev_task kernel/sched/sched.h:2423 [inline]
       put_prev_task_balance+0x11d/0x190 kernel/sched/core.c:5886
       __pick_next_task+0xc6/0x2f0 kernel/sched/core.c:5946
       pick_next_task kernel/sched/core.c:6012 [inline]
       __schedule+0x725/0x4ad0 kernel/sched/core.c:6594
       preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6961
       irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
       asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
       lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5766
       down_read_trylock+0x24f/0x3c0 kernel/locking/rwsem.c:1568
       mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
       get_mmap_lock_carefully mm/memory.c:6033 [inline]
       lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6093
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
       schedule_tail+0x96/0xb0 kernel/sched/core.c:5205
       ret_from_fork+0x24/0x80 arch/x86/kernel/process.c:143
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

2 locks held by dhcpcd-run-hook/12621:
 #0: ffff888011d14d98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff888011d14d98 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:6033 [inline]
 #0: ffff888011d14d98 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6093
 #1: ffff8880b913ea58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:587

stack backtrace:
CPU: 1 UID: 0 PID: 12621 Comm: dhcpcd-run-hook Not tainted 6.11.0-rc3-next-20240815-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2189
 check_prev_add kernel/locking/lockdep.c:3136 [inline]
 check_prevs_add kernel/locking/lockdep.c:3255 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:323
 console_trylock kernel/printk/printk.c:2754 [inline]
 console_trylock_spinning kernel/printk/printk.c:1958 [inline]
 vprintk_emit+0x2aa/0x7c0 kernel/printk/printk.c:2347
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
RIP: 0010:rq_clock kernel/sched/sched.h:1624 [inline]
RIP: 0010:replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
RIP: 0010:update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Code: b5 50 fe ff ff 4c 89 ff ba 20 00 00 00 e8 e9 4f 00 00 e9 58 fe ff ff 4c 89 ef be 20 00 00 00 e8 b7 13 00 00 e9 46 fe ff ff 90 <0f> 0b 90 e9 be fb ff ff 89 f1 80 e1 07 38 c1 0f 8c b5 f9 ff ff 48
RSP: 0018:ffffc90004faf668 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880b903ea40 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: 0000000000000031 R08: ffff8880b902c883 R09: 1ffff11017205910
R10: dffffc0000000000 R11: ffffed1017205911 R12: ffff8880b903f468
R13: ffff8880b903f428 R14: 1ffff11017207e8f R15: ffff8880b903f858
 update_curr+0x575/0xb20 kernel/sched/fair.c:1176
 put_prev_entity+0x3d/0x210 kernel/sched/fair.c:5505
 put_prev_task_fair+0x4d/0x80 kernel/sched/fair.c:8686
 put_prev_task kernel/sched/sched.h:2423 [inline]
 put_prev_task_balance+0x11d/0x190 kernel/sched/core.c:5886
 __pick_next_task+0xc6/0x2f0 kernel/sched/core.c:5946
 pick_next_task kernel/sched/core.c:6012 [inline]
 __schedule+0x725/0x4ad0 kernel/sched/core.c:6594
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6961
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5766
Code: 2b 00 74 08 4c 89 f7 e8 2a 39 8c 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90004fafba0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920009f5f80 RCX: 5f14a1617595db00
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: ffffc90004fafce8 R08: ffffffff9375c837 R09: 1ffffffff26eb906
R10: dffffc0000000000 R11: fffffbfff26eb907 R12: 1ffff920009f5f7c
R13: dffffc0000000000 R14: ffffc90004fafc00 R15: 0000000000000246
 down_read_trylock+0x24f/0x3c0 kernel/locking/rwsem.c:1568
 mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 get_mmap_lock_carefully mm/memory.c:6033 [inline]
 lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6093
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_4+0x11/0x20 arch/x86/lib/putuser.S:88
Code: 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90004faff00 EFLAGS: 00050206
RAX: 000000000000314d RBX: 0000000000000000 RCX: 00007f0b3e35e650
RDX: 0000000000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: ffff8880217fa490 R08: ffffffff9018b8af R09: 1ffffffff2031715
R10: dffffc0000000000 R11: fffffbfff2031716 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000314d R15: dffffc0000000000
 schedule_tail+0x96/0xb0 kernel/sched/core.c:5205
 ret_from_fork+0x24/0x80 arch/x86/kernel/process.c:143
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
WARNING: CPU: 1 PID: 12621 at kernel/sched/sched.h:1476 lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
WARNING: CPU: 1 PID: 12621 at kernel/sched/sched.h:1476 rq_clock kernel/sched/sched.h:1624 [inline]
WARNING: CPU: 1 PID: 12621 at kernel/sched/sched.h:1476 replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
WARNING: CPU: 1 PID: 12621 at kernel/sched/sched.h:1476 update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Modules linked in:
CPU: 1 UID: 0 PID: 12621 Comm: dhcpcd-run-hook Not tainted 6.11.0-rc3-next-20240815-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
RIP: 0010:rq_clock kernel/sched/sched.h:1624 [inline]
RIP: 0010:replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
RIP: 0010:update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Code: b5 50 fe ff ff 4c 89 ff ba 20 00 00 00 e8 e9 4f 00 00 e9 58 fe ff ff 4c 89 ef be 20 00 00 00 e8 b7 13 00 00 e9 46 fe ff ff 90 <0f> 0b 90 e9 be fb ff ff 89 f1 80 e1 07 38 c1 0f 8c b5 f9 ff ff 48
RSP: 0018:ffffc90004faf668 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880b903ea40 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: 0000000000000031 R08: ffff8880b902c883 R09: 1ffff11017205910
R10: dffffc0000000000 R11: ffffed1017205911 R12: ffff8880b903f468
R13: ffff8880b903f428 R14: 1ffff11017207e8f R15: ffff8880b903f858
FS:  00007f0b3e35e380(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b3e35e650 CR3: 000000006f33e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 update_curr+0x575/0xb20 kernel/sched/fair.c:1176
 put_prev_entity+0x3d/0x210 kernel/sched/fair.c:5505
 put_prev_task_fair+0x4d/0x80 kernel/sched/fair.c:8686
 put_prev_task kernel/sched/sched.h:2423 [inline]
 put_prev_task_balance+0x11d/0x190 kernel/sched/core.c:5886
 __pick_next_task+0xc6/0x2f0 kernel/sched/core.c:5946
 pick_next_task kernel/sched/core.c:6012 [inline]
 __schedule+0x725/0x4ad0 kernel/sched/core.c:6594
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6961
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5766
Code: 2b 00 74 08 4c 89 f7 e8 2a 39 8c 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90004fafba0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920009f5f80 RCX: 5f14a1617595db00
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: ffffc90004fafce8 R08: ffffffff9375c837 R09: 1ffffffff26eb906
R10: dffffc0000000000 R11: fffffbfff26eb907 R12: 1ffff920009f5f7c
R13: dffffc0000000000 R14: ffffc90004fafc00 R15: 0000000000000246
 down_read_trylock+0x24f/0x3c0 kernel/locking/rwsem.c:1568
 mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 get_mmap_lock_carefully mm/memory.c:6033 [inline]
 lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6093
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_4+0x11/0x20 arch/x86/lib/putuser.S:88
Code: 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90004faff00 EFLAGS: 00050206
RAX: 000000000000314d RBX: 0000000000000000 RCX: 00007f0b3e35e650
RDX: 0000000000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c609dc0
RBP: ffff8880217fa490 R08: ffffffff9018b8af R09: 1ffffffff2031715
R10: dffffc0000000000 R11: fffffbfff2031716 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000314d R15: dffffc0000000000
 schedule_tail+0x96/0xb0 kernel/sched/core.c:5205
 ret_from_fork+0x24/0x80 arch/x86/kernel/process.c:143
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 2a 39 8c 00       	call   0x8c3936
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


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

