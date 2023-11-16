Return-Path: <cgroups+bounces-454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68D7EE27E
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D61C20A5C
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0BF31A60;
	Thu, 16 Nov 2023 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975111F
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 06:16:28 -0800 (PST)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-6c7c69e4327so1087307b3a.0
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 06:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144187; x=1700748987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfoefBWXMEzAp8Tij4EmiijiIQ3lqChOjkMyMqTBtuM=;
        b=hZf5xNJmweJwGlBn60fu2QmyjZuGhGSbgheXFv4x7ItwVVL23W3ZfKhwVBEuLPEcog
         4RbhgL4Y5XwAuNeNSI3LdANoYsnceEYtJF5IKiXxUxTuHQhUy5vxauF06NUchu0hQcbL
         6xpWnjmet0awHcEk0+orAQAN189DiZS2gD/9o6JLsukto5MOBZfCn6eiCysu9weUBcKL
         p3GD7Z1MlKY3iXcvHhMRMK1ORHPiqoYGx0/wRJA+4BXVCv65tBXY3yGh9/lAtcSxoLLK
         af1BFaQDdhjlOK0Jr0jwZaLY0yDjxsB5VwTahDlsKW5EHnzhAUlIM6eMazJ+EVkje38d
         M/xA==
X-Gm-Message-State: AOJu0YxV2in8QxPEyuaoNM7ITGuhqo6zXDi8+LXIUirX9pLM7KxwoqEZ
	y5BdKtZvAYIjIB5X9ecPNQihQg20HHM+8BgPK8PJP9J9aOWk2U+W6A==
X-Google-Smtp-Source: AGHT+IGq8xG3QZslYPDllP+7Tz5OU+Y7/Ga/vFvKl0GRd2Siw7OvvKqYCdp1Ws3KF4gCKAiHrhN0uLK+XR4DuM4JrgDoyL1qv6wZ
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1786:b0:6c3:9efc:6833 with SMTP id
 s6-20020a056a00178600b006c39efc6833mr5586725pfg.2.1700144187506; Thu, 16 Nov
 2023 06:16:27 -0800 (PST)
Date: Thu, 16 Nov 2023 06:16:27 -0800
In-Reply-To: <000000000000f5b0d0060a430995@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d0a27060a45aadc@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
From: syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fa5a48e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cef555184e66963dabc2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fd7920e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d80920e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
--------------------------------------------------------
swapper/0/0 just changed the state of lock:
ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: put_css_set kernel/cgroup/cgroup-internal.h:208 [inline]
ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: put_css_set kernel/cgroup/cgroup-internal.h:196 [inline]
ffffffff8cff86b8 (css_set_lock){..-.}-{2:2}, at: cgroup_free+0x7c/0x1d0 kernel/cgroup/cgroup.c:6748
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&sighand->siglock){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


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

2 locks held by swapper/0/0:
 #0: ffffffff8cfacf40 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf40 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2152 [inline]
 #0: ffffffff8cfacf40 (rcu_callback){....}-{0:0}, at: rcu_core+0x7cc/0x16b0 kernel/rcu/tree.c:2431
 #1: ffffffff8ce58800 (put_task_map-wait-type-override){+...}-{3:3}, at: put_task_struct include/linux/sched/task.h:135 [inline]
 #1: ffffffff8ce58800 (put_task_map-wait-type-override){+...}-{3:3}, at: put_task_struct include/linux/sched/task.h:123 [inline]
 #1: ffffffff8ce58800 (put_task_map-wait-type-override){+...}-{3:3}, at: delayed_put_task_struct+0x21e/0x2d0 kernel/exit.c:227

the shortest dependencies between 2nd lock and 1st lock:
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
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
                    acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                    cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
                    cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                    cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                    do_idle+0x314/0x3f0 kernel/sched/idle.c:312
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:410
                    rest_init+0x16f/0x2b0 init/main.c:730
                    arch_call_rest_init+0x13/0x30 init/main.c:827
                    start_kernel+0x39e/0x480 init/main.c:1072
                    x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
                    x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
                    secondary_startup_64_no_verify+0x166/0x16b
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
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4566 [inline]
   __lock_acquire+0x13c2/0x3b10 kernel/locking/lockdep.c:5090
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
   native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
   acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
   acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
   cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
   cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
   cpuidle_idle_call kernel/sched/idle.c:215 [inline]
   do_idle+0x314/0x3f0 kernel/sched/idle.c:312
   cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:410
   rest_init+0x16f/0x2b0 init/main.c:730
   arch_call_rest_init+0x13/0x30 init/main.c:827
   start_kernel+0x39e/0x480 init/main.c:1072
   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
   x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
   secondary_startup_64_no_verify+0x166/0x16b


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_irq_inversion_bug.part.0+0x3e1/0x590 kernel/locking/lockdep.c:4079
 print_irq_inversion_bug kernel/locking/lockdep.c:4032 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4110 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4242 [inline]
 mark_lock+0x570/0xc50 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4566 [inline]
 __lock_acquire+0x13c2/0x3b10 kernel/locking/lockdep.c:5090
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
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:113
Code: 08 ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 05 a8 8a 82 75 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 78 0a b9 00 fb f4 <fa> c3 0f 1f 40 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb
RSP: 0018:ffffffff8cc07d68 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a8117f5
RDX: 0000000000000001 RSI: ffff8880156c2800 RDI: ffff8880156c2864
RBP: ffff8880156c2864 R08: 0000000000000001 R09: ffffed1017306dbd
R10: ffff8880b9836deb R11: 0000000000000000 R12: ffff888147ac4000
R13: ffffffff8db1a520 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x314/0x3f0 kernel/sched/idle.c:312
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:410
 rest_init+0x16f/0x2b0 init/main.c:730
 arch_call_rest_init+0x13/0x30 init/main.c:827
 start_kernel+0x39e/0x480 init/main.c:1072
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
 secondary_startup_64_no_verify+0x166/0x16b
 </TASK>
----------------
Code disassembly (best guess):
   0:	08 ed                	or     %ch,%ch
   2:	c3                   	ret
   3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00 00
   e:	66 90                	xchg   %ax,%ax
  10:	65 48 8b 05 a8 8a 82 	mov    %gs:0x75828aa8(%rip),%rax        # 0x75828ac0
  17:	75
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 78 0a b9 00 	verw   0xb90a78(%rip)        # 0xb90aa0
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 40 00          	nopl   0x0(%rax)
  30:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  34:	3c 01                	cmp    $0x1,%al
  36:	74 0b                	je     0x43
  38:	3c 02                	cmp    $0x2,%al
  3a:	74 05                	je     0x41
  3c:	8b 7f 04             	mov    0x4(%rdi),%edi
  3f:	eb                   	.byte 0xeb


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

