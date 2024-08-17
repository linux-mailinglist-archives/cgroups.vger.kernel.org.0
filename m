Return-Path: <cgroups+bounces-4336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97D9555E6
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 08:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03191C21193
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58D132121;
	Sat, 17 Aug 2024 06:52:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47D43152
	for <cgroups@vger.kernel.org>; Sat, 17 Aug 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877545; cv=none; b=DL07CVxEER/TKj/k3d0XsLPf70f4L4wUaHlMmr+y12tRT9eZuDg9WnaAkIHuw7j05+1CxMagV0oS+3E+Y/hgRIq6cYrnR2ksN6Xfz7vfhB6wic1634XuOhfcPNS/8fG9EBCzqUEycuaKEoDyKiDChqXV/toL1dgp29vQEjvFJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877545; c=relaxed/simple;
	bh=h1fCjK/WIByJ9rx9DApomzX/D1Bg8yCddNpd3OdUOPY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MixKuf4LuLrq0iIJGVkITop3mnfDch/Wuzfk7RXYU67kn7F1Vr4dcHbJX6rnm4N/AMtXJeuE8wDhtem+Yf7bqsyzArAAF7oy20ZlBqPfrsClBF4xcdaBJCQq5BniG0ZtFnFE1luVWl5HV0qq1SkA9vpguRz7qMesi62MlQclut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d244820edso22530975ab.3
        for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 23:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877543; x=1724482343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Qade8iv/yodhHht3ujpuNl+dPwbhOloEjWWYVpVSg=;
        b=bIIJ5uN0QkWhy3yQvp+ODFxZgFpz91twwKZk6tXSdRnT0bdyk5lvl+7eJJN3LIl6kt
         14JPWFxci1R5HfUpGut9t9lXuVmj3ySQ4grOEuskvwYWoJ88OH2CpM13Els4aajx4uRS
         Vz0V49AvEpY9sVX89CfPGXfebY1lCWt5hbfycDA71UpZEcn/Zruf9Prtr9LZQPr7lEsL
         XVqxkUu4/AVBCRrLU5+VVtHATKuhYUlj8/qkAJc/yqJ8C22JuxJzR3yu8P9Iw2A8rjCh
         ZxHPRnLBS136MFi/jQas4tc9QvmeW4XhpffBbcaXgiImtNr2fl187c+HaihI3+t764Ur
         +y1Q==
X-Gm-Message-State: AOJu0Ywb8xoIkAgPilIz1M/YCX42LZStav1xPoLjuxCoyd5izNRmFpwe
	efFRVcjUr8nL6ACw1WKl3qk3m9bGBkq/dW5rNxqy3vd1MdB/EiOivn0AUq2QM4ZdSh6s/c6s2Rf
	4Ln8z/2YirdcrR5NM37kfi3gbgE9p5OJ9ZPIYJUaUfzoXCCwkqY1GSCo=
X-Google-Smtp-Source: AGHT+IH0VpumDUuZHUV0sIajA3TfLtshcwr2uFxMidXEIPRQidrSQVIbw5cysuGH1IvKvShb4chWXNUgHIBo0FcfekOp8fxo1hOq
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39d26d95738mr4720435ab.6.1723877542779; Fri, 16 Aug 2024
 23:52:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:52:22 -0700
In-Reply-To: <000000000000e540f3061fc68863@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092ef86061fdb849b@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
From: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147f345b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d6dbf3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142413c5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-next-20240816-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:7/5301 is trying to acquire lock:
ffffffff8e815038 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

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
       dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4921
       dev_printk_emit+0xdd/0x120 drivers/base/core.c:4932
       _dev_warn+0x122/0x170 drivers/base/core.c:4988
       _request_firmware+0xd2c/0x12b0 drivers/base/firmware_loader/main.c:910
       request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
       process_one_work kernel/workqueue.c:3232 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3313
       worker_thread+0x86d/0xd10 kernel/workqueue.c:3390
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-...}-{2:2}:
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
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6818
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6842
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
       task_rq_unlock kernel/sched/sched.h:1759 [inline]
       __sched_setscheduler+0xf35/0x1ba0 kernel/sched/syscalls.c:858
       _sched_setscheduler kernel/sched/syscalls.c:880 [inline]
       sched_setscheduler_nocheck+0x190/0x2e0 kernel/sched/syscalls.c:927
       kthread+0x1aa/0x390 kernel/kthread.c:370
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

1 lock held by kworker/u8:7/5301:
 #0: ffff8880b913ea58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:587

stack backtrace:
CPU: 1 UID: 0 PID: 5301 Comm: kworker/u8:7 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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
RSP: 0018:ffffc9000417f6c8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880b903ea40 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c60a8c0
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
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6818
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6842
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 task_rq_unlock kernel/sched/sched.h:1759 [inline]
 __sched_setscheduler+0xf35/0x1ba0 kernel/sched/syscalls.c:858
 _sched_setscheduler kernel/sched/syscalls.c:880 [inline]
 sched_setscheduler_nocheck+0x190/0x2e0 kernel/sched/syscalls.c:927
 kthread+0x1aa/0x390 kernel/kthread.c:370
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
WARNING: CPU: 1 PID: 5301 at kernel/sched/sched.h:1476 lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
WARNING: CPU: 1 PID: 5301 at kernel/sched/sched.h:1476 rq_clock kernel/sched/sched.h:1624 [inline]
WARNING: CPU: 1 PID: 5301 at kernel/sched/sched.h:1476 replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
WARNING: CPU: 1 PID: 5301 at kernel/sched/sched.h:1476 update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Modules linked in:
CPU: 1 UID: 0 PID: 5301 Comm: kworker/u8:7 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
RIP: 0010:rq_clock kernel/sched/sched.h:1624 [inline]
RIP: 0010:replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
RIP: 0010:update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Code: b5 50 fe ff ff 4c 89 ff ba 20 00 00 00 e8 e9 4f 00 00 e9 58 fe ff ff 4c 89 ef be 20 00 00 00 e8 b7 13 00 00 e9 46 fe ff ff 90 <0f> 0b 90 e9 be fb ff ff 89 f1 80 e1 07 38 c1 0f 8c b5 f9 ff ff 48
RSP: 0018:ffffc9000417f6c8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880b903ea40 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c60a8c0
RBP: 0000000000000031 R08: ffff8880b902c883 R09: 1ffff11017205910
R10: dffffc0000000000 R11: ffffed1017205911 R12: ffff8880b903f468
R13: ffff8880b903f428 R14: 1ffff11017207e8f R15: ffff8880b903f858
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f69bb64cd58 CR3: 0000000078782000 CR4: 00000000003506f0
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
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6818
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6842
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 task_rq_unlock kernel/sched/sched.h:1759 [inline]
 __sched_setscheduler+0xf35/0x1ba0 kernel/sched/syscalls.c:858
 _sched_setscheduler kernel/sched/syscalls.c:880 [inline]
 sched_setscheduler_nocheck+0x190/0x2e0 kernel/sched/syscalls.c:927
 kthread+0x1aa/0x390 kernel/kthread.c:370
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

