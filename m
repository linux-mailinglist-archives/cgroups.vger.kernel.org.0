Return-Path: <cgroups+bounces-452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF9B7EDF2B
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC24B1F23FDA
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460A2D780;
	Thu, 16 Nov 2023 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B6A8
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 03:08:27 -0800 (PST)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-28001f80712so688369a91.1
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 03:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132906; x=1700737706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUu0mxVAmb+assglELuUMPCwWUjJiBkQhf0gEKVZ2CU=;
        b=Uh8IH7oRV97bbZzqc9rAQ+GMODBrHSxHFKKFmqoz8BwmZg8JbqXuoN+Op/QGDo9oSw
         LMZbiOC4kxvFjK0M6mAhnhqVPNLQZHe/z/TotHt318aCQeLNkyq5/uiyXgomb32XS20X
         KZQzO6BAk7OeXg9J8tYsBcFjqRfZ6Kh/wad7Gc1FZbGMvpJGUj1j5VAYTls2T7tMzgkF
         R6KwHdjjWZPyLYDDFPz97toFtUl4riigGSlld5iUpD9b51xlDZEmJSUhgT87s04Uf/Tr
         r11WVUkQe+n+AYk0RBsg6LvQTNnwhG2H+uP4RnT6qtEofQWds+tRsXybYD+o8+pRpZz4
         bfuA==
X-Gm-Message-State: AOJu0Yxuv/5LWCnFXWDrRuojocvSAFcEXV5tI3qGuTjgjt0o3v1hgLJi
	EuWNoAZR5IzrwlYXLNgCr1etmYs+5Vn1FwElzPxeBi2TgOk1XK1trw==
X-Google-Smtp-Source: AGHT+IGMFnD9EWhd5PBIN37z20MKZ7T6A2PTp3nlFY29PBgUWUWcrk4ltzCDM3AhpDVXf6F5nHhUgcp+HL5MNyBQBlM1w0weWqRk
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2b4b:b0:280:a5e9:3b61 with SMTP id
 rr11-20020a17090b2b4b00b00280a5e93b61mr4627369pjb.9.1700132906445; Thu, 16
 Nov 2023 03:08:26 -0800 (PST)
Date: Thu, 16 Nov 2023 03:08:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5b0d0060a430995@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in cgroup_free
From: syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d0aca7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cef555184e66963dabc2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/8188 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88801f641298 (&sighand->siglock){+.+.}-{2:2}, at: __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422

and this task is already holding:
ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: cgroup_migrate_execute+0xd8/0x1230 kernel/cgroup/cgroup.c:2566
which would create a new lock dependency:
 (css_set_lock){..-.}-{2:2} -> (&sighand->siglock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (css_set_lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
  put_css_set kernel/cgroup/cgroup-internal.h:208 [inline]
  put_css_set kernel/cgroup/cgroup-internal.h:196 [inline]
  cgroup_free+0x7c/0x1d0 kernel/cgroup/cgroup.c:6748
  __put_task_struct+0x10b/0x3d0 kernel/fork.c:992
  put_task_struct include/linux/sched/task.h:136 [inline]
  put_task_struct include/linux/sched/task.h:123 [inline]
  delayed_put_task_struct+0x22c/0x2d0 kernel/exit.c:227
  rcu_do_batch kernel/rcu/tree.c:2158 [inline]
  rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2431
  __do_softirq+0x216/0x8d5 kernel/softirq.c:553
  invoke_softirq kernel/softirq.c:427 [inline]
  __irq_exit_rcu kernel/softirq.c:632 [inline]
  irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644
  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
  lock_acquire+0x1f2/0x530 kernel/locking/lockdep.c:5721
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  lockref_put_or_lock+0x18/0x80 lib/lockref.c:147
  fast_dput fs/dcache.c:775 [inline]
  fast_dput fs/dcache.c:765 [inline]
  dput+0x4c4/0xd90 fs/dcache.c:900
  shmem_unlink+0x1bc/0x310 mm/shmem.c:3373
  shmem_rename2+0x1ff/0x3b0 mm/shmem.c:3451
  vfs_rename+0xe20/0x1c30 fs/namei.c:4844
  do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
  __do_sys_rename fs/namei.c:5042 [inline]
  __se_sys_rename fs/namei.c:5040 [inline]
  __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a

to a SOFTIRQ-irq-unsafe lock:
 (&sighand->siglock){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:530 [inline]
  ptrace_set_stopped kernel/ptrace.c:391 [inline]
  ptrace_attach+0x401/0x650 kernel/ptrace.c:478
  __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(css_set_lock);
                               lock(&sighand->siglock);
  <Interrupt>
    lock(css_set_lock);

 *** DEADLOCK ***

8 locks held by syz-executor.3/8188:
 #0: ffff88801d0e0d48 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x170 fs/file.c:1177
 #1: ffff888014b44420 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:637
 #2: ffff88807ad7f088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #3: ffffffff8cff8768 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:368 [inline]
 #3: ffffffff8cff8768 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock_and_drain_offline+0xad/0x6d0 kernel/cgroup/cgroup.c:3092
 #4: ffffffff8ce51f70 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2413 [inline]
 #4: ffffffff8ce51f70 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_update_dfl_csses+0x2fb/0x640 kernel/cgroup/cgroup.c:3050
 #5: ffffffff8cff8530 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2415 [inline]
 #5: ffffffff8cff8530 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2411 [inline]
 #5: ffffffff8cff8530 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_update_dfl_csses+0x3d1/0x640 kernel/cgroup/cgroup.c:3050
 #6: ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #6: ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: cgroup_migrate_execute+0xd8/0x1230 kernel/cgroup/cgroup.c:2566
 #7: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #7: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #7: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x3f/0x340 kernel/signal.c:1405

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (css_set_lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                    put_css_set kernel/cgroup/cgroup-internal.h:208 [inline]
                    put_css_set kernel/cgroup/cgroup-internal.h:196 [inline]
                    cgroup_free+0x7c/0x1d0 kernel/cgroup/cgroup.c:6748
                    __put_task_struct+0x10b/0x3d0 kernel/fork.c:992
                    put_task_struct include/linux/sched/task.h:136 [inline]
                    put_task_struct include/linux/sched/task.h:123 [inline]
                    delayed_put_task_struct+0x22c/0x2d0 kernel/exit.c:227
                    rcu_do_batch kernel/rcu/tree.c:2158 [inline]
                    rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2431
                    __do_softirq+0x216/0x8d5 kernel/softirq.c:553
                    invoke_softirq kernel/softirq.c:427 [inline]
                    __irq_exit_rcu kernel/softirq.c:632 [inline]
                    irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                    lock_acquire+0x1f2/0x530 kernel/locking/lockdep.c:5721
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    lockref_put_or_lock+0x18/0x80 lib/lockref.c:147
                    fast_dput fs/dcache.c:775 [inline]
                    fast_dput fs/dcache.c:765 [inline]
                    dput+0x4c4/0xd90 fs/dcache.c:900
                    shmem_unlink+0x1bc/0x310 mm/shmem.c:3373
                    shmem_rename2+0x1ff/0x3b0 mm/shmem.c:3451
                    vfs_rename+0xe20/0x1c30 fs/namei.c:4844
                    do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
                    __do_sys_rename fs/namei.c:5042 [inline]
                    __se_sys_rename fs/namei.c:5040 [inline]
                    __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   cgroup_setup_root+0x62c/0xa00 kernel/cgroup/cgroup.c:2138
                   cgroup_init+0x23f/0x1100 kernel/cgroup/cgroup.c:6120
                   start_kernel+0x385/0x480 init/main.c:1063
                   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
                   x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
                   secondary_startup_64_no_verify+0x166/0x16b
 }
 ... key      at: [<ffffffff8cff86b8>] css_set_lock+0x18/0x60

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&sighand->siglock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   calculate_sigpending+0x44/0xa0 kernel/signal.c:197
                   ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
                   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 }
 ... key      at: [<ffffffff90b49f80>] __key.341+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5753 [inline]
   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
   __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
   lock_task_sighand include/linux/sched/signal.h:748 [inline]
   cgroup_freeze_task+0x80/0x190 kernel/cgroup/freezer.c:160
   cgroup_freezer_migrate_task+0x1b7/0x3a0 kernel/cgroup/freezer.c:257
   cgroup_migrate_execute+0x2d3/0x1230 kernel/cgroup/cgroup.c:2580
   cgroup_update_dfl_csses+0x51b/0x640 kernel/cgroup/cgroup.c:3068
   cgroup_apply_control kernel/cgroup/cgroup.c:3308 [inline]
   cgroup_subtree_control_write+0xb94/0xed0 kernel/cgroup/cgroup.c:3453
   cgroup_file_write+0x209/0x7c0 kernel/cgroup/cgroup.c:4092
   kernfs_fop_write_iter+0x33f/0x500 fs/kernfs/file.c:334
   call_write_iter include/linux/fs.h:2021 [inline]
   new_sync_write fs/read_write.c:491 [inline]
   vfs_write+0x64d/0xdf0 fs/read_write.c:584
   ksys_write+0x12f/0x250 fs/read_write.c:637
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


stack backtrace:
CPU: 1 PID: 8188 Comm: syz-executor.3 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe18/0x1470 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x247c/0x3b10 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
 lock_task_sighand include/linux/sched/signal.h:748 [inline]
 cgroup_freeze_task+0x80/0x190 kernel/cgroup/freezer.c:160
 cgroup_freezer_migrate_task+0x1b7/0x3a0 kernel/cgroup/freezer.c:257
 cgroup_migrate_execute+0x2d3/0x1230 kernel/cgroup/cgroup.c:2580
 cgroup_update_dfl_csses+0x51b/0x640 kernel/cgroup/cgroup.c:3068
 cgroup_apply_control kernel/cgroup/cgroup.c:3308 [inline]
 cgroup_subtree_control_write+0xb94/0xed0 kernel/cgroup/cgroup.c:3453
 cgroup_file_write+0x209/0x7c0 kernel/cgroup/cgroup.c:4092
 kernfs_fop_write_iter+0x33f/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2021 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x64d/0xdf0 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f83f387cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83f466d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f83f399bf80 RCX: 00007f83f387cae9
RDX: 0000000000000006 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f83f38c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f83f399bf80 R15: 00007ffdda059fd8
 </TASK>


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

