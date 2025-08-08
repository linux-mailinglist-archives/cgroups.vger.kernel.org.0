Return-Path: <cgroups+bounces-9031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D1B1E743
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 13:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC392580D1B
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 11:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB6274668;
	Fri,  8 Aug 2025 11:25:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E2749E1
	for <cgroups@vger.kernel.org>; Fri,  8 Aug 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652336; cv=none; b=R5S2t17Q5qVT29z/Fwcnr1O9kCuE5Ql6v+iFr3Yxbu1K5ldgzx/x8JtOZ/aLR6vZj4bJsjuryd6PDok7vpf2EShkNAgtpIoPt1ewhCWdHw8hwwm+Ea2YGqUA09S9M6+Yuak2X0Pk0iplwipX6u6Fcwd+QZnh5tvynSgq+QRz5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652336; c=relaxed/simple;
	bh=KjRp50QOqJEYCucJ6EVn8veKXTqYz8rfmFK93Fs13P8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gXq2zX2LCGgi3DzmKjJfyYBK5ed/Ew4NNteU2t9kD47NVhTOYs2gVe6b2yTAoQgRmuEJGO9S4mEQELgSEvG//q2SVhO6BMuRRP8PAQU+CZ0S2B1q5hz+Uis3zmEP1C2coVblo0Gs7NjO2B0sleghJUWvUNklQ+HM5F1X8DoE13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88193bc4b09so380571539f.2
        for <cgroups@vger.kernel.org>; Fri, 08 Aug 2025 04:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652333; x=1755257133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9SKkmJQ0vqUohZuxkSO54a/10/2pDw6PsRf0BM7Caw=;
        b=UlAYt1ftDnORjXCVQavo1lxBh32MFpi06Qt62NZONvI1G4v7eMAUs5Bvxkuxsr2nV6
         Xnbbo0gWMhM+c4YWtfeYjCevfahBSTmyj9ejEkm2r8ieTmB1e7alesrEYU9+JYHZj9IV
         OPY3XK3EIepCm2mGWLT2GEBH7yJNzKK5WRr2K4DZSZPabkEWcLWJA4BV1r6OGaeT2pX3
         BxdDzz+lNK8Lx2yhtLp35RccFvPxQKs0RDtm0eWg+fxJVAOHM3MUGVse4mnYxPwMzIwW
         tEZKgI2+9MHrWwNFMNdO9GGbY7Cby9pmmJmDtUDMJ7jXG8lv/kXYuz8vy4IVZndwHi2b
         VM6g==
X-Gm-Message-State: AOJu0Yx7uqnDMhE3AZy7hgeHL6iBsKnavTyAae+GWXESYsepse7jh5Bj
	OMlCCMzA9HoEOXOBrIUdl0DOCmpq2+d0eWp+rTblsuyu+DgAyQ17XDNEKXiI4l0OOCWVUDB9aOB
	KsMM1WGyKgwcimFrU3Rglw/pnMTB90jD21IOiDsnEPaXgYUbFDl/8DkpDJh8HWQ==
X-Google-Smtp-Source: AGHT+IGOxkmPUhxv9Loki8lNbPNo6ZocbqH7QboraFb8YpKmID8NCAHd7Xu/bZ2m0lBQYRKpTRgKOhnlAmJuarcDxPUAb1BBkOLn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:84c2:0:b0:881:7e3a:4a37 with SMTP id
 ca18e2360f4ac-883f11e38bdmr399945939f.6.1754652333610; Fri, 08 Aug 2025
 04:25:33 -0700 (PDT)
Date: Fri, 08 Aug 2025 04:25:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895dead.050a0220.7f033.005e.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in console_flush_all (4)
From: syzbot <syzbot+d10e9d53059eb8aed654@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9104cec3e8f Merge tag 'bpf-next-6.17' of git://git.kernel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14464ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0888b9ad46cd69
dashboard link: https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140a62f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120a62f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed717a4a878a/disk-d9104cec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08035d746f31/vmlinux-d9104cec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b5bf8caca80/bzImage-d9104cec.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d10e9d53059eb8aed654@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 1
======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-06574-gd9104cec3e8f #0 Not tainted
------------------------------------------------------
syz-executor502/5847 is trying to acquire lock:
ffffffff8e130720 (console_owner){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:336 [inline]
ffffffff8e130720 (console_owner){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:346 [inline]
ffffffff8e130720 (console_owner){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:288 [inline]
ffffffff8e130720 (console_owner){....}-{0:0}, at: console_flush_all+0x13a/0xc40 kernel/printk/printk.c:3203

but task is already holding lock:
ffff8880b8739f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
       raw_spin_rq_lock kernel/sched/sched.h:1522 [inline]
       task_rq_lock+0xbc/0x470 kernel/sched/core.c:736
       cgroup_move_task+0x92/0x2a0 kernel/sched/psi.c:1174
       css_set_move_task+0x658/0x9e0 kernel/cgroup/cgroup.c:918
       cgroup_post_fork+0x1ef/0x790 kernel/cgroup/cgroup.c:6759
       copy_process+0x3862/0x3c00 kernel/fork.c:2416
       kernel_clone+0x21e/0x840 kernel/fork.c:2602
       user_mode_thread+0xdd/0x140 kernel/fork.c:2680
       rest_init+0x23/0x300 init/main.c:709
       start_kernel+0x3a9/0x410 init/main.c:1097
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
       try_to_wake_up+0x6e/0x1290 kernel/sched/core.c:4210
       __wake_up_common kernel/sched/wait.c:90 [inline]
       __wake_up_common_lock+0x137/0x1f0 kernel/sched/wait.c:107
       tty_port_default_wakeup+0xa2/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x72e/0x970 drivers/tty/serial/8250/8250_port.c:1728
       serial8250_handle_irq+0x633/0xbb0 drivers/tty/serial/8250/8250_port.c:1836
       serial8250_default_handle_irq+0xbf/0x1e0 drivers/tty/serial/8250/8250_port.c:1856
       serial8250_interrupt+0x8d/0x160 drivers/tty/serial/8250/8250_core.c:82
       __handle_irq_event_percpu+0x289/0x980 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x23b/0x9f0 kernel/irq/chip.c:849
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:254 [inline]
       call_irq_handler arch/x86/kernel/irq.c:266 [inline]
       __common_interrupt+0x143/0x250 arch/x86/kernel/irq.c:292
       common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:285
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
       arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
       default_idle+0x13/0x20 arch/x86/kernel/process.c:757
       default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
       cpuidle_idle_call kernel/sched/idle.c:190 [inline]
       do_idle+0x1e8/0x510 kernel/sched/idle.c:330
       cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
       rest_init+0x2de/0x300 init/main.c:744
       start_kernel+0x3a9/0x410 init/main.c:1097
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #2 (&tty->write_wait){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0x2f/0x1f0 kernel/sched/wait.c:106
       tty_port_default_wakeup+0xa2/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x72e/0x970 drivers/tty/serial/8250/8250_port.c:1728
       serial8250_handle_irq+0x633/0xbb0 drivers/tty/serial/8250/8250_port.c:1836
       serial8250_default_handle_irq+0xbf/0x1e0 drivers/tty/serial/8250/8250_port.c:1856
       serial8250_interrupt+0x8d/0x160 drivers/tty/serial/8250/8250_core.c:82
       __handle_irq_event_percpu+0x289/0x980 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x23b/0x9f0 kernel/irq/chip.c:849
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:254 [inline]
       call_irq_handler arch/x86/kernel/irq.c:266 [inline]
       __common_interrupt+0x143/0x250 arch/x86/kernel/irq.c:292
       common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:285
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
       arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
       default_idle+0x13/0x20 arch/x86/kernel/process.c:757
       default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
       cpuidle_idle_call kernel/sched/idle.c:190 [inline]
       do_idle+0x1e8/0x510 kernel/sched/idle.c:330
       cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
       rest_init+0x2de/0x300 init/main.c:744
       start_kernel+0x3a9/0x410 init/main.c:1097
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
       serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.c:3355
       console_emit_next_record kernel/printk/printk.c:3138 [inline]
       console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
       vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       register_console+0xa8b/0xf90 kernel/printk/printk.c:4125
       univ8250_console_init+0x3a/0x70 drivers/tty/serial/8250/8250_core.c:516
       console_init+0x10e/0x430 kernel/printk/printk.c:4323
       start_kernel+0x254/0x410 init/main.c:1035
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       console_lock_spinning_enable kernel/printk/printk.c:1924 [inline]
       console_emit_next_record kernel/printk/printk.c:3132 [inline]
       console_flush_all+0x6d2/0xc40 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
       vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       fail_dump lib/fault-inject.c:66 [inline]
       should_fail_ex+0x3f5/0x560 lib/fault-inject.c:174
       strncpy_from_user+0x36/0x290 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x72/0x150 mm/maccess.c:193
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
       ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
       bpf_probe_read_compat_str+0xe2/0x180 kernel/trace/bpf_trace.c:306
       bpf_prog_56079403e473c493+0x70/0x76
       bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
       __bpf_prog_run include/linux/filter.h:718 [inline]
       bpf_prog_run include/linux/filter.h:725 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
       bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
       __bpf_trace_tlb_flush+0xf5/0x150 include/trace/events/tlb.h:38
       __traceiter_tlb_flush+0x76/0xd0 include/trace/events/tlb.h:38
       __do_trace_tlb_flush include/trace/events/tlb.h:38 [inline]
       trace_tlb_flush+0x115/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x53e/0x7a0 arch/x86/mm/tlb.c:-1
       context_switch kernel/sched/core.c:5335 [inline]
       __schedule+0x109d/0x4d30 kernel/sched/core.c:6954
       preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7281
       irqentry_exit+0x6f/0x90 kernel/entry/common.c:196
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
       fs_reclaim_acquire+0x99/0x100 mm/page_alloc.c:4062
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4099 [inline]
       slab_alloc_node mm/slub.c:4177 [inline]
       kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
       __d_alloc+0x36/0x7a0 fs/dcache.c:1690
       d_alloc_pseudo+0x21/0xc0 fs/dcache.c:1821
       alloc_path_pseudo fs/file_table.c:363 [inline]
       alloc_file_pseudo+0xcc/0x210 fs/file_table.c:379
       __anon_inode_getfile fs/anon_inodes.c:166 [inline]
       __anon_inode_getfd fs/anon_inodes.c:291 [inline]
       anon_inode_getfd+0xca/0x1b0 fs/anon_inodes.c:326
       bpf_enable_runtime_stats kernel/bpf/syscall.c:5829 [inline]
       bpf_enable_stats+0xdc/0x140 kernel/bpf/syscall.c:5850
       __sys_bpf+0x325/0x870 kernel/bpf/syscall.c:6105
       __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6130
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

7 locks held by syz-executor502/5847:
 #0: ffffffff8e1bb9c8 (bpf_stats_enabled_mutex){+.+.}-{4:4}, at: bpf_enable_runtime_stats kernel/bpf/syscall.c:5821 [inline]
 #0: ffffffff8e1bb9c8 (bpf_stats_enabled_mutex){+.+.}-{4:4}, at: bpf_enable_stats+0x94/0x140 kernel/bpf/syscall.c:5850
 #1: ffffffff8e243360 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
 #1: ffffffff8e243360 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4099 [inline]
 #1: ffffffff8e243360 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4177 [inline]
 #1: ffffffff8e243360 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
 #2: ffffffff8e255260 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire+0x7d/0x100 mm/page_alloc.c:4062
 #3: ffff8880b8739f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #4: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2256 [inline]
 #4: ffffffff8e13c4e0 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2298
 #5: ffffffff8e130780 (console_lock){+.+.}-{0:0}, at: _printk+0xcf/0x120 kernel/printk/printk.c:2475
 #6: ffffffff8e018050 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:336 [inline]
 #6: ffffffff8e018050 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:346 [inline]
 #6: ffffffff8e018050 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:288 [inline]
 #6: ffffffff8e018050 (console_srcu){....}-{0:0}, at: console_flush_all+0x13a/0xc40 kernel/printk/printk.c:3203

stack backtrace:
CPU: 1 UID: 0 PID: 5847 Comm: syz-executor502 Not tainted 6.16.0-syzkaller-06574-gd9104cec3e8f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 console_lock_spinning_enable kernel/printk/printk.c:1924 [inline]
 console_emit_next_record kernel/printk/printk.c:3132 [inline]
 console_flush_all+0x6d2/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 fail_dump lib/fault-inject.c:66 [inline]
 should_fail_ex+0x3f5/0x560 lib/fault-inject.c:174
 strncpy_from_user+0x36/0x290 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x72/0x150 mm/maccess.c:193
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
 bpf_probe_read_compat_str+0xe2/0x180 kernel/trace/bpf_trace.c:306
 bpf_prog_56079403e473c493+0x70/0x76
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
 __bpf_trace_tlb_flush+0xf5/0x150 include/trace/events/tlb.h:38
 __traceiter_tlb_flush+0x76/0xd0 include/trace/events/tlb.h:38
 __do_trace_tlb_flush include/trace/events/tlb.h:38 [inline]
 trace_tlb_flush+0x115/0x140 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x53e/0x7a0 arch/x86/mm/tlb.c:-1
 context_switch kernel/sched/core.c:5335 [inline]
 __schedule+0x109d/0x4d30 kernel/sched/core.c:6954
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7281
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:196
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 cb 8e fc 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003d4fa68 EFLAGS: 00000206
RAX: e3643158a89e2500 RBX: 0000000000000000 RCX: e3643158a89e2500
RDX: 0000000000030000 RSI: ffffffff8db65e8b RDI: ffffffff8be30a00
RBP: ffffffff8215895d R08: ffffc90003d4f888 R09: 0000000000000020
R10: 00000000b2b5dd6f R11: ffffffff819de180 R12: 0000000000000000
R13: ffffffff8e255260 R14: 0000000000000001 R15: 0000000000000246
 fs_reclaim_acquire+0x99/0x100 mm/page_alloc.c:4062
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4099 [inline]
 slab_alloc_node mm/slub.c:4177 [inline]
 kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
 __d_alloc+0x36/0x7a0 fs/dcache.c:1690
 d_alloc_pseudo+0x21/0xc0 fs/dcache.c:1821
 alloc_path_pseudo fs/file_table.c:363 [inline]
 alloc_file_pseudo+0xcc/0x210 fs/file_table.c:379
 __anon_inode_getfile fs/anon_inodes.c:166 [inline]
 __anon_inode_getfd fs/anon_inodes.c:291 [inline]
 anon_inode_getfd+0xca/0x1b0 fs/anon_inodes.c:326
 bpf_enable_runtime_stats kernel/bpf/syscall.c:5829 [inline]
 bpf_enable_stats+0xdc/0x140 kernel/bpf/syscall.c:5850
 __sys_bpf+0x325/0x870 kernel/bpf/syscall.c:6105
 __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6130
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe51845c8d9
Code: Unable to access opcode bytes at 0x7fe51845c8af.
RSP: 002b:00007ffe3c17a318 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe3c17a330 RCX: 00007fe51845c8d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000001 R08: 00007ffe3c17a0b7 R09: 0000000000000140
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
CPU: 1 UID: 0 PID: 5847 Comm: syz-executor502 Not tainted 6.16.0-syzkaller-06574-gd9104cec3e8f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x414/0x560 lib/fault-inject.c:174
 strncpy_from_user+0x36/0x290 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x72/0x150 mm/maccess.c:193
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
 bpf_probe_read_compat_str+0xe2/0x180 kernel/trace/bpf_trace.c:306
 bpf_prog_56079403e473c493+0x70/0x76
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x281/0x4b0 kernel/trace/bpf_trace.c:2298
 __bpf_trace_tlb_flush+0xf5/0x150 include/trace/events/tlb.h:38
 __traceiter_tlb_flush+0x76/0xd0 include/trace/events/tlb.h:38
 __do_trace_tlb_flush include/trace/events/tlb.h:38 [inline]
 trace_tlb_flush+0x115/0x140 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x53e/0x7a0 arch/x86/mm/tlb.c:-1
 context_switch kernel/sched/core.c:5335 [inline]
 __schedule+0x109d/0x4d30 kernel/sched/core.c:6954
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7281
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:196
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 cb 8e fc 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003d4fa68 EFLAGS: 00000206
RAX: e3643158a89e2500 RBX: 0000000000000000 RCX: e3643158a89e2500
RDX: 0000000000030000 RSI: ffffffff8db65e8b RDI: ffffffff8be30a00
RBP: ffffffff8215895d R08: ffffc90003d4f888 R09: 0000000000000020
R10: 00000000b2b5dd6f R11: ffffffff819de180 R12: 0000000000000000
R13: ffffffff8e255260 R14: 0000000000000001 R15: 0000000000000246
 fs_reclaim_acquire+0x99/0x100 mm/page_alloc.c:4062
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4099 [inline]
 slab_alloc_node mm/slub.c:4177 [inline]
 kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
 __d_alloc+0x36/0x7a0 fs/dcache.c:1690
 d_alloc_pseudo+0x21/0xc0 fs/dcache.c:1821
 alloc_path_pseudo fs/file_table.c:363 [inline]
 alloc_file_pseudo+0xcc/0x210 fs/file_table.c:379
 __anon_inode_getfile fs/anon_inodes.c:166 [inline]
 __anon_inode_getfd fs/anon_inodes.c:291 [inline]
 anon_inode_getfd+0xca/0x1b0 fs/anon_inodes.c:326
 bpf_enable_runtime_stats kernel/bpf/syscall.c:5829 [inline]
 bpf_enable_stats+0xdc/0x140 kernel/bpf/syscall.c:5850
 __sys_bpf+0x325/0x870 kernel/bpf/syscall.c:6105
 __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6130
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe51845c8d9
Code: Unable to access opcode bytes at 0x7fe51845c8af.
RSP: 002b:00007ffe3c17a318 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe3c17a330 RCX: 00007fe51845c8d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000001 R08: 00007ffe3c17a0b7 R09: 0000000000000140
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	9c                   	pushf
   5:	8f 44 24 30          	pop    0x30(%rsp)
   9:	f7 44 24 30 00 02 00 	testl  $0x200,0x30(%rsp)
  10:	00
  11:	0f 85 cd 00 00 00    	jne    0xe4
  17:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
  1e:	00
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 cb 8e fc 	mov    %gs:0x10fc8ecb(%rip),%rax        # 0x10fc8ef5
  29:	10
* 2a:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax <-- trapping instruction
  2f:	0f 85 f2 00 00 00    	jne    0x127
  35:	48 83 c4 60          	add    $0x60,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


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

