Return-Path: <cgroups+bounces-9143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5AB25421
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9665A6B43
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE93299959;
	Wed, 13 Aug 2025 19:56:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2252F99A6
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114994; cv=none; b=hyjBT4+A9BdpsF/jkEldbIsQN7NXVPbjcaMJjnDcdDWfZkGz0zw1fmzZvtRYDs9t5/q27UOVLQEqJY6Wnmg/W63ILR0kTpVKOr/5n2Zp4avOxIZy0uJcuumQ7q/HCPliMSvP5XUk7VQ8Yl7/NasOfky6BbxiauLVH+g2xGcwots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114994; c=relaxed/simple;
	bh=9fj49A+2eb7KOsAljGVmiXL6DOU4uQi30GgB8LevqwI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hr3m7kZUEBzHaxGzmW9zwjNf4yiWaj6PKIMeOqAaJYVO3fGP0/OR6uBdl3RLKX285rcCCw+YHWcGGCkgsfq8JITWURBugjzeyIKY88E8IVjZJpH8ZrvqAKhxPDhzKfQoYYnODfPsBHFyp2KlriWaes2JsxlJdH01aKWyoKbduVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432ccc211so27954139f.0
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 12:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755114992; x=1755719792;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJxiQLV/sV8tZa4aMmkrgIRqw9Q26jw6TU8InBUTCsk=;
        b=n6IJrU+08sI7lI9t9QL8pD0lc3k+zxd1dSnDjeSajAqrWsxTLMjQS3oujyf+V+dO81
         fmCheX3DGByz0e4BV3WTLSuTO31rYDhKoMlnV14IIVa7dGVRlA9EwQim4WZAs0nEyL4f
         rvTDLFNY1nWkd9a16CQJwvtj/ZZymP2pUoaeIQAlCDnCuflVbDAvfIARlPqR1mntmmij
         8CHfV+r15ZBGNcswLejXj+LdPTSIgD3hxCxvbANlooR1tjudIpMZG7qa1Fvl28qEdzyI
         imkZSuNU8saSwnXoSEaNYaeDQ78zyAYIlUE/qww9abiXSmqx2MxRo9CJns6plHLvydWw
         PvSQ==
X-Gm-Message-State: AOJu0YzQh88TnjLpBiTQ49qpMALMqRzmOx6g6sm2oK1l7+tXVBzAu9C/
	v17IEiaL+9QPiah+BedMYZoELP7GU5rlj1yfOP/9gUvf6KG/u9eTvcxRXcmp+B3P3b9wQBziIOx
	C3753huGvcR+DQLUflE8yG6zp8oLTsw1kZMyJI5bpAak/yI5W43buioPoobYHoA==
X-Google-Smtp-Source: AGHT+IFLMDC1E23T4zrPqSbO2CAX1Y68ZOMDSd8vNH6j0MVrthHPMkoXA4p6D8kFPvNR7aDTnS6SKrYRkp5otFhTUE8TA+1yPZ+1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140b:b0:87c:5a38:45e9 with SMTP id
 ca18e2360f4ac-884337d6412mr67094239f.3.1755114991996; Wed, 13 Aug 2025
 12:56:31 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:56:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689cedef.050a0220.7f033.015c.GAE@google.com>
Subject: [syzbot] [cgroups?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (4)
From: syzbot <syzbot+f0efdf3dc4fade355f17@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b388bf7a9d9 Merge patch series "Linux SBI MPXY and RPMI d..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11098842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486f4d7dd4dcbb24
dashboard link: https://syzkaller.appspot.com/bug?extid=f0efdf3dc4fade355f17
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7b388bf7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc41eb358030/vmlinux-7b388bf7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d9b169ef31a4/Image-7b388bf7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0efdf3dc4fade355f17@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 235ba17f9123a408

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc7-syzkaller-g7b388bf7a9d9 #0 Not tainted
------------------------------------------------------
syz.1.16/4027 is trying to acquire lock:
ffffffff884e8200 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x9a/0xd6 kernel/printk/printk.c:1920

but task is already holding lock:
ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:606 [inline]
ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1532 [inline]
ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1856 [inline]
ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x314/0x4088 kernel/sched/core.c:6710

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       _raw_spin_lock_nested+0x36/0x4e kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested kernel/sched/core.c:606 [inline]
       raw_spin_rq_lock kernel/sched/sched.h:1532 [inline]
       task_rq_lock+0xea/0x3be kernel/sched/core.c:708
       cgroup_move_task+0x86/0x1f4 kernel/sched/psi.c:1161
       css_set_move_task+0x1da/0x446 kernel/cgroup/cgroup.c:918
       cgroup_post_fork+0x16c/0x816 kernel/cgroup/cgroup.c:6754
       copy_process+0x51ae/0x62e4 kernel/fork.c:2413
       kernel_clone+0x128/0xe1e kernel/fork.c:2599
       user_mode_thread+0xd4/0x110 kernel/fork.c:2677
       rest_init+0x34/0x2e6 init/main.c:710
       console_on_rootfs+0x0/0x96 init/main.c:1102

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3e/0x62 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
       try_to_wake_up+0xb8/0xfcc kernel/sched/core.c:4227
       default_wake_function+0x30/0x58 kernel/sched/core.c:7121
       woken_wake_function+0x38/0x64 kernel/sched/wait.c:444
       __wake_up_common+0x106/0x184 kernel/sched/wait.c:89
       __wake_up_common_lock kernel/sched/wait.c:106 [inline]
       __wake_up+0x32/0x58 kernel/sched/wait.c:127
       tty_wakeup+0x60/0xfc drivers/tty/tty_io.c:519
       tty_port_default_wakeup+0x2c/0x44 drivers/tty/tty_port.c:69
       tty_port_tty_wakeup+0x52/0x72 drivers/tty/tty_port.c:415
       uart_write_wakeup+0x40/0x5e drivers/tty/serial/serial_core.c:121
       serial8250_tx_chars+0x5f8/0x7a6 drivers/tty/serial/8250/8250_port.c:1838
       serial8250_handle_irq+0x648/0x938 drivers/tty/serial/8250/8250_port.c:1946
       serial8250_default_handle_irq+0x80/0xe4 drivers/tty/serial/8250/8250_port.c:1966
       serial8250_interrupt+0xda/0x1ee drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x268/0xb38 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xb4/0x1ee kernel/irq/handle.c:210
       handle_fasteoi_irq+0x32c/0xd5a kernel/irq/chip.c:706
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq_desc+0xfc/0x140 kernel/irq/irqdesc.c:676
       generic_handle_domain_irq+0x2a/0x36 kernel/irq/irqdesc.c:732
       plic_handle_irq+0x17a/0x3c8 drivers/irqchip/irq-sifive-plic.c:386
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq_desc+0xfc/0x140 kernel/irq/irqdesc.c:676
       generic_handle_domain_irq+0x2a/0x36 kernel/irq/irqdesc.c:732
       riscv_intc_irq+0x4a/0xcc drivers/irqchip/irq-riscv-intc.c:33
       handle_riscv_irq+0x2e/0x4c arch/riscv/kernel/traps.c:442
       call_on_irq_stack+0x32/0x40 arch/riscv/kernel/entry.S:395

-> #2 (&tty->write_wait){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3e/0x62 kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:105 [inline]
       __wake_up+0x22/0x58 kernel/sched/wait.c:127
       tty_wakeup+0x60/0xfc drivers/tty/tty_io.c:519
       tty_port_default_wakeup+0x2c/0x44 drivers/tty/tty_port.c:69
       tty_port_tty_wakeup+0x52/0x72 drivers/tty/tty_port.c:415
       uart_write_wakeup+0x40/0x5e drivers/tty/serial/serial_core.c:121
       serial8250_tx_chars+0x5f8/0x7a6 drivers/tty/serial/8250/8250_port.c:1838
       serial8250_handle_irq+0x648/0x938 drivers/tty/serial/8250/8250_port.c:1946
       serial8250_default_handle_irq+0x80/0xe4 drivers/tty/serial/8250/8250_port.c:1966
       serial8250_interrupt+0xda/0x1ee drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x268/0xb38 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xb4/0x1ee kernel/irq/handle.c:210
       handle_fasteoi_irq+0x32c/0xd5a kernel/irq/chip.c:706
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq_desc+0xfc/0x140 kernel/irq/irqdesc.c:676
       generic_handle_domain_irq+0x2a/0x36 kernel/irq/irqdesc.c:732
       plic_handle_irq+0x17a/0x3c8 drivers/irqchip/irq-sifive-plic.c:386
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq_desc+0xfc/0x140 kernel/irq/irqdesc.c:676
       generic_handle_domain_irq+0x2a/0x36 kernel/irq/irqdesc.c:732
       riscv_intc_irq+0x4a/0xcc drivers/irqchip/irq-riscv-intc.c:33
       handle_riscv_irq+0x2e/0x4c arch/riscv/kernel/traps.c:442
       call_on_irq_stack+0x32/0x40 arch/riscv/kernel/entry.S:395

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3e/0x62 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave+0x2a/0x2b6 include/linux/serial_core.h:717
       serial8250_console_write+0x1ae/0x15d4 drivers/tty/serial/8250/8250_port.c:3415
       univ8250_console_write+0x70/0x9c drivers/tty/serial/8250/8250_core.c:396
       console_emit_next_record kernel/printk/printk.c:3138 [inline]
       console_flush_all+0x7bc/0xb70 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0x108/0x22e kernel/printk/printk.c:3325
       vprintk_emit+0x476/0x784 kernel/printk/printk.c:2450
       vprintk_default+0x26/0x32 kernel/printk/printk.c:2465
       vprintk+0x20/0x2c kernel/printk/printk_safe.c:82
       _printk+0x98/0xc4 kernel/printk/printk.c:2475
       register_console+0x9a2/0xf30 kernel/printk/printk.c:4125
       uart_configure_port drivers/tty/serial/serial_core.c:2637 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3157 [inline]
       serial_core_register_port+0x1f6e/0x2058 drivers/tty/serial/serial_core.c:3388
       serial_ctrl_register_port+0x20/0x2c drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x20/0x2c drivers/tty/serial/serial_port.c:143
       serial8250_register_8250_port+0x12cc/0x2072 drivers/tty/serial/8250/8250_core.c:822
       of_platform_serial_probe+0x724/0xb42 drivers/tty/serial/8250/8250_of.c:246
       platform_probe+0xfa/0x1e8 drivers/base/platform.c:1404
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x236/0x9c2 drivers/base/dd.c:657
       __driver_probe_device+0x1d4/0x3f2 drivers/base/dd.c:799
       driver_probe_device+0x60/0x1ce drivers/base/dd.c:829
       __driver_attach+0x250/0x4ee drivers/base/dd.c:1215
       bus_for_each_dev+0x124/0x1ba drivers/base/bus.c:370
       driver_attach+0x3e/0x52 drivers/base/dd.c:1233
       bus_add_driver+0x29e/0x5e6 drivers/base/bus.c:678
       driver_register+0x18e/0x3ee drivers/base/driver.c:249
       __platform_driver_register+0x5e/0x7e drivers/base/platform.c:867
       of_platform_serial_driver_init+0x22/0x2a drivers/tty/serial/8250/8250_of.c:370
       do_one_initcall+0x1b0/0xb76 init/main.c:1274
       do_initcall_level init/main.c:1336 [inline]
       do_initcalls init/main.c:1352 [inline]
       do_basic_setup init/main.c:1371 [inline]
       kernel_init_freeable+0x6e4/0x790 init/main.c:1584
       kernel_init+0x28/0x24c init/main.c:1474
       ret_from_fork_kernel+0x2a/0xbec arch/riscv/kernel/process.c:228
       ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:362

-> #0 (console_owner){....}-{0:0}:
       check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x12a0/0x24d8 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       console_lock_spinning_enable+0xc0/0xd6 kernel/printk/printk.c:1924
       console_emit_next_record kernel/printk/printk.c:3132 [inline]
       console_flush_all+0x772/0xb70 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0x108/0x22e kernel/printk/printk.c:3325
       vprintk_emit+0x476/0x784 kernel/printk/printk.c:2450
       vprintk_default+0x26/0x32 kernel/printk/printk.c:2465
       vprintk+0x20/0x2c kernel/printk/printk_safe.c:82
       _printk+0x98/0xc4 kernel/printk/printk.c:2475
       die_kernel_fault+0x3e/0x7f0 arch/riscv/mm/fault.c:81
       no_context arch/riscv/mm/fault.c:111 [inline]
       no_context arch/riscv/mm/fault.c:90 [inline]
       mm_fault_error arch/riscv/mm/fault.c:117 [inline]
       handle_page_fault+0x9dc/0x1388 arch/riscv/mm/fault.c:431
       do_page_fault+0x20/0x56 arch/riscv/kernel/traps.c:428
       handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:231
       bpf_prog_67a7f92a6a5e5f13+0x62/0x7c

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

8 locks held by syz.1.16/4027:
 #0: ffffffff88660188 (tracepoints_mutex){+.+.}-{4:4}, at: tracepoint_probe_register_prio_may_exist+0xa6/0x10a kernel/tracepoint.c:431
 #1: ffffffff8847d590 (cpu_hotplug_lock){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #1: ffffffff8847d590 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x14/0x1c kernel/cpu.c:490
 #2: ffffffff88705b28 (jump_label_mutex){+.+.}-{4:4}, at: jump_label_lock kernel/jump_label.c:27 [inline]
 #2: ffffffff88705b28 (jump_label_mutex){+.+.}-{4:4}, at: static_key_enable_cpuslocked+0xd4/0x28e kernel/jump_label.c:207
 #3: ffffffff8849b8a8 (text_mutex){+.+.}-{4:4}, at: arch_jump_label_transform_queue+0x192/0x312 arch/riscv/kernel/jump_label.c:44
 #4: ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:606 [inline]
 #4: ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1532 [inline]
 #4: ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1856 [inline]
 #4: ffffaf806ed1d098 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x314/0x4088 kernel/sched/core.c:6710
 #5: ffffffff885dbd80 (rcu_read_lock){....}-{1:3}, at: bpf_set_run_ctx include/linux/bpf.h:2193 [inline]
 #5: ffffffff885dbd80 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2255 [inline]
 #5: ffffffff885dbd80 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run4+0x20a/0x70c kernel/trace/bpf_trace.c:2301
 #6: ffffffff884e7e00 (console_lock){+.+.}-{0:0}, at: vprintk_default+0x26/0x32 kernel/printk/printk.c:2465
 #7: ffffffff884e8050 (console_srcu){....}-{0:0}, at: console_flush_all+0x114/0xb70 kernel/printk/printk.c:3234

stack backtrace:
CPU: 1 UID: 0 PID: 4027 Comm: syz.1.16 Not tainted 6.16.0-rc7-syzkaller-g7b388bf7a9d9 #0 PREEMPT 
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007b6f0>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
[<ffffffff80003298>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
[<ffffffff80062c2c>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff80062c2c>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff80062cc0>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
[<ffffffff802d7c98>] print_circular_bug+0x254/0x29a kernel/locking/lockdep.c:2046
[<ffffffff802d7e10>] check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
[<ffffffff802dafd8>] check_prev_add kernel/locking/lockdep.c:3168 [inline]
[<ffffffff802dafd8>] check_prevs_add kernel/locking/lockdep.c:3287 [inline]
[<ffffffff802dafd8>] validate_chain kernel/locking/lockdep.c:3911 [inline]
[<ffffffff802dafd8>] __lock_acquire+0x12a0/0x24d8 kernel/locking/lockdep.c:5240
[<ffffffff802dce4e>] lock_acquire kernel/locking/lockdep.c:5871 [inline]
[<ffffffff802dce4e>] lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
[<ffffffff80307d9e>] console_lock_spinning_enable+0xc0/0xd6 kernel/printk/printk.c:1924
[<ffffffff8030a62e>] console_emit_next_record kernel/printk/printk.c:3132 [inline]
[<ffffffff8030a62e>] console_flush_all+0x772/0xb70 kernel/printk/printk.c:3226
[<ffffffff8030ab34>] __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
[<ffffffff8030ab34>] console_unlock+0x108/0x22e kernel/printk/printk.c:3325
[<ffffffff8030d2ae>] vprintk_emit+0x476/0x784 kernel/printk/printk.c:2450
[<ffffffff8030d5e2>] vprintk_default+0x26/0x32 kernel/printk/printk.c:2465
[<ffffffff8030f884>] vprintk+0x20/0x2c kernel/printk/printk_safe.c:82
[<ffffffff80008dea>] _printk+0x98/0xc4 kernel/printk/printk.c:2475
[<ffffffff800995be>] die_kernel_fault+0x3e/0x7f0 arch/riscv/mm/fault.c:81
[<ffffffff8009a74c>] no_context arch/riscv/mm/fault.c:111 [inline]
[<ffffffff8009a74c>] no_context arch/riscv/mm/fault.c:90 [inline]
[<ffffffff8009a74c>] mm_fault_error arch/riscv/mm/fault.c:117 [inline]
[<ffffffff8009a74c>] handle_page_fault+0x9dc/0x1388 arch/riscv/mm/fault.c:431
[<ffffffff863fdd78>] do_page_fault+0x20/0x56 arch/riscv/kernel/traps.c:428
[<ffffffff864262fe>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:231
[<ffffffff78000076>] bpf_prog_67a7f92a6a5e5f13+0x62/0x7c
Current syz.1.16 pgtable: 4K pagesize, 48-bit VAs, pgdp=0x00000000a1a90000
[235ba17f9123a408] pgd=000000002460b401, p4d=000000002460b401, pud=0000000000000000
Oops [#1]
Modules linked in:
CPU: 1 UID: 0 PID: 4027 Comm: syz.1.16 Not tainted 6.16.0-rc7-syzkaller-g7b388bf7a9d9 #0 PREEMPT 
Hardware name: riscv-virtio,qemu (DT)
epc : bpf_prog_67a7f92a6a5e5f13+0x62/0x7c
 ra : bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 ra : __bpf_prog_run include/linux/filter.h:718 [inline]
 ra : bpf_prog_run include/linux/filter.h:725 [inline]
 ra : __bpf_trace_run kernel/trace/bpf_trace.c:2258 [inline]
 ra : bpf_trace_run4+0x2a6/0x70c kernel/trace/bpf_trace.c:2301
epc : ffffffff78000076 ra : ffffffff80595fb0 sp : ffff8f80046b7180
 gp : ffffffff89e816e0 tp : ffffaf8011991a40 t0 : 0000000000000000
 t1 : 235ba17f9123a408 t2 : ffffffff9123a400 s0 : ffff8f80046b71b0
 s1 : ffff8f80046b7280 a0 : ffffaf80123179d8 a1 : ffff8f80046b7188
 a2 : 0000000000000008 a3 : 0000000000000000 a4 : 1ffff1f0001bf206
 a5 : ffffffff17b0a000 a6 : 0000000000000021 a7 : ffffffff80595f14
 s2 : 1ffff1f0008d6e3c s3 : 0000000000000000 s4 : ffffffff9123a400
 s5 : ffff8f80046b7190 s6 : 0000000000000001 s7 : 1ffff1f0001bf205
 s8 : ffff8f8000df9028 s9 : ffff8f80046b7200 s10: 0000000000000001
 s11: 0000000000000000 t3 : ca76b45d00000000 t4 : 0000000000001fff
 t5 : 00000000000000c8 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000100 badaddr: 235ba17f9123a408 cause: 000000000000000d
[<ffffffff78000076>] bpf_prog_67a7f92a6a5e5f13+0x62/0x7c
[<ffffffff80595fb0>] bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
[<ffffffff80595fb0>] __bpf_prog_run include/linux/filter.h:718 [inline]
[<ffffffff80595fb0>] bpf_prog_run include/linux/filter.h:725 [inline]
[<ffffffff80595fb0>] __bpf_trace_run kernel/trace/bpf_trace.c:2258 [inline]
[<ffffffff80595fb0>] bpf_trace_run4+0x2a6/0x70c kernel/trace/bpf_trace.c:2301
[<ffffffff80211c92>] __bpf_trace_sched_switch+0x14/0x1c include/trace/events/sched.h:220
[<ffffffff8640899c>] __traceiter_sched_switch include/trace/events/sched.h:220 [inline]
[<ffffffff8640899c>] __do_trace_sched_switch include/trace/events/sched.h:220 [inline]
[<ffffffff8640899c>] trace_sched_switch include/trace/events/sched.h:220 [inline]
[<ffffffff8640899c>] __schedule+0x1372/0x4088 kernel/sched/core.c:6783
[<ffffffff8640bbb6>] preempt_schedule_common kernel/sched/core.c:6966 [inline]
[<ffffffff8640bbb6>] preempt_schedule+0xd2/0x1e2 kernel/sched/core.c:6990
[<ffffffff8007d968>] __patch_insn_write+0xb7c/0xd88 arch/riscv/kernel/patch.c:159
[<ffffffff8007ecae>] patch_insn_write+0x78/0xb4 arch/riscv/kernel/patch.c:226
[<ffffffff80094424>] arch_jump_label_transform_queue+0x19e/0x312 arch/riscv/kernel/jump_label.c:45
[<ffffffff8081aff8>] __jump_label_update+0x11c/0x3ee kernel/jump_label.c:513
[<ffffffff8081b5ec>] jump_label_update+0x322/0x52c kernel/jump_label.c:919
[<ffffffff8081bc44>] static_key_enable_cpuslocked+0x1e4/0x28e kernel/jump_label.c:210
[<ffffffff8081bd10>] static_key_enable+0x22/0x34 kernel/jump_label.c:223
[<ffffffff8050ae10>] tracepoint_add_func+0x812/0xa26 kernel/tracepoint.c:315
[<ffffffff8050b0e2>] tracepoint_probe_register_prio_may_exist+0xbe/0x10a kernel/tracepoint.c:435
[<ffffffff8059dfd8>] tracepoint_probe_register_may_exist include/linux/tracepoint.h:50 [inline]
[<ffffffff8059dfd8>] bpf_probe_register+0x150/0x1c2 kernel/trace/bpf_trace.c:2326
[<ffffffff805ef294>] bpf_raw_tp_link_attach+0x27c/0x538 kernel/bpf/syscall.c:4007
[<ffffffff805f0dfe>] bpf_raw_tracepoint_open kernel/bpf/syscall.c:4038 [inline]
[<ffffffff805f0dfe>] __sys_bpf+0x14ba/0x419e kernel/bpf/syscall.c:5878
[<ffffffff805f4846>] __do_sys_bpf kernel/bpf/syscall.c:5943 [inline]
[<ffffffff805f4846>] __se_sys_bpf kernel/bpf/syscall.c:5941 [inline]
[<ffffffff805f4846>] __riscv_sys_bpf+0x6c/0xc6 kernel/bpf/syscall.c:5941
[<ffffffff8007937a>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff863fdb66>] do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:343
[<ffffffff864262fe>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:231
Code: 97aa 639c 3303 00c2 a397 1923 8393 3963 6333 2073 (3303) 0003 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97aa                	add	a5,a5,a0
   2:	639c                	flw	fa5,0(a5)
   4:	00c23303          	.4byte	0xc23303
   8:	1923a397          	auipc	t2,0x1923a
   c:	39638393          	add	t2,t2,918 # 0x1923a39e
  10:	20736333          	.4byte	0x20736333
* 14:	00033303          	.4byte	0x33303 <-- trapping instruction


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

