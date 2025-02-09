Return-Path: <cgroups+bounces-6473-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E0A2E081
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDB23A5F4D
	for <lists+cgroups@lfdr.de>; Sun,  9 Feb 2025 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA451E00BF;
	Sun,  9 Feb 2025 20:43:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4124337A
	for <cgroups@vger.kernel.org>; Sun,  9 Feb 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739133805; cv=none; b=dsT3eukQGpP7k7T1zzDiVvm6xONnF8gVQn8xouzmctsB5TNPVV+ua6pE3sLa/xD3UK7TvD8LqKcjyijje70fFB2n76WYvd9HbOxTbj/j9QyycjRllos/EHi4C4VXIDHQk7iI3L4AP6hZRl79DnLt6y8ptAzUXPeMwJcLvbHhaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739133805; c=relaxed/simple;
	bh=3tNmviieMuKNM8H3MYEezH7LQVAIW+lX8320/Kcny5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=okOn6UMF8f3N299lyqKNbit4bXDkiAsP1tN5yk9rnWYLw5XJS4ecRav6EsfQYAaiEmKLqPOB2OSxFg7hOYmbm2plK/+4ybsos5bkyZoUO1LQmzN9F05UK/AUfEtNaOHw/0XL8svlKX1CGurrMcB3hlH5BDTMc4JrWzTG59M1ETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d162c02150so1359895ab.0
        for <cgroups@vger.kernel.org>; Sun, 09 Feb 2025 12:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739133802; x=1739738602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mE7LmRUh89THsi2tF3Lw21ph8fQLx74Z71kTQ79ixRY=;
        b=m9sFn35X7b0EhZQhYsgz+CMao5ThBEKqwFvKzcSHgB3DYtrVyzTF5lNCSDmnHnDzS5
         k7vr6WURxISveY5TStUWuwhWRryXqfaDrQ+uJPqFG1G83GaZxp0cxCQVmft75xVmFCd8
         Yhghid+kjqQUmqggnXkqKKSURxVHPgWvjDSz9M8dh1O5ZjUMkzoNMN/tuqwAaEd/YSba
         7GTwfYYj9vYM07QzbuQZREkoraRjb5QdSK32hNfw8KuDJGnZZ8+zv8lZT5HU6x53RN4U
         Iijqhvse43wGXG2+7Yd4ESviR4+rRiwRq9cmwZDJ3Jg4oR+KkwE/jIBnfckp6kjvFPNW
         l21Q==
X-Gm-Message-State: AOJu0YzTsAXDNBfFkCIMNBjOpiHdoXbCByJ5tiwx70A3WgYWCnS+KpNf
	cVNjn/U3NGMMlsxRv6pkqopye5xRKE1UnEfrbXKucIc0kWApCSgDk+s7z9LAM1UUppALNLvcKaK
	YXESyTIvGbOM65WhMlsyf30xrWeqjjGCXqen7slZoA/UroPC2d9LTG8aJ3Q==
X-Google-Smtp-Source: AGHT+IH9mBOzVJUL5OWmEH4zDtHMcFNicbRuUVEDzG9uvtKi2jssb2rec6mmzfx5dhDb5b82f+WWRkfVCZvdqTr2yY4joVUS8OHk
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348c:b0:3d0:f2ca:65aa with SMTP id
 e9e14a558f8ab-3d13e1ad5c5mr91988445ab.4.1739133802604; Sun, 09 Feb 2025
 12:43:22 -0800 (PST)
Date: Sun, 09 Feb 2025 12:43:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a9136a.050a0220.110943.001e.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in __run_timer_base (2)
From: syzbot <syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179453df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=ed801a886dfdbfe7136d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92514ef2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4d8b91f8769/vmlinux-92514ef2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c24ec4365966/bzImage-92514ef2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0 Not tainted
------------------------------------------------------
syz.0.0/5328 is trying to acquire lock:
ffffffff8e814418 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1836 [inline]
ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: __run_timers kernel/time/timer.c:2414 [inline]
ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: __run_timer_base+0x69d/0x8e0 kernel/time/timer.c:2426

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_timer_base kernel/time/timer.c:1046 [inline]
       __mod_timer+0x24a/0x10e0 kernel/time/timer.c:1127
       queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2559
       psi_task_change+0xed/0x270 kernel/sched/psi.c:912
       psi_enqueue kernel/sched/stats.h:166 [inline]
       enqueue_task+0x306/0x3d0 kernel/sched/core.c:2076
       activate_task kernel/sched/core.c:2116 [inline]
       wake_up_new_task+0x576/0xc70 kernel/sched/core.c:4878
       kernel_clone+0x4ee/0x8e0 kernel/fork.c:2846
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
       raw_spin_rq_lock kernel/sched/sched.h:1521 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:700
       cgroup_move_task+0x9b/0x5a0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6691
       copy_process+0x39e9/0x3d50 kernel/fork.c:2629
       kernel_clone+0x226/0x8e0 kernel/fork.c:2815
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xc2/0x1470 kernel/sched/core.c:4213
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2869
       __console_flush_and_unlock kernel/printk/printk.c:3271 [inline]
       console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3309
       vga_remove_vgacon+0xbe/0xd0 drivers/pci/vgaarb.c:186
       virtio_gpu_pci_quirk drivers/gpu/drm/virtio/virtgpu_drv.c:62 [inline]
       virtio_gpu_probe+0x33f/0x3c0 drivers/gpu/drm/virtio/virtgpu_drv.c:93
       virtio_dev_probe+0x931/0xc80 drivers/virtio/virtio.c:341
       really_probe+0x2b9/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
       bus_add_driver+0x346/0x670 drivers/base/bus.c:678
       driver_register+0x23a/0x320 drivers/base/driver.c:249
       do_one_initcall+0x248/0x870 init/main.c:1257
       do_initcall_level+0x157/0x210 init/main.c:1319
       do_initcalls+0x3f/0x80 init/main.c:1335
       kernel_init_freeable+0x435/0x5d0 init/main.c:1568
       kernel_init+0x1d/0x2b0 init/main.c:1457
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
       console_trylock kernel/printk/printk.c:2852 [inline]
       console_trylock_spinning kernel/printk/printk.c:2009 [inline]
       vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       expire_timers kernel/time/timer.c:1827 [inline]
       __run_timers kernel/time/timer.c:2414 [inline]
       __run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2426
       run_timer_base kernel/time/timer.c:2435 [inline]
       run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
       handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
       __do_softirq kernel/softirq.c:595 [inline]
       invoke_softirq kernel/softirq.c:435 [inline]
       __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
       irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
       sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       get_stack_info+0x4/0xf0 arch/x86/kernel/dumpstack_64.c:193
       __unwind_start+0x434/0x740 arch/x86/kernel/unwind_orc.c:729
       unwind_start arch/x86/include/asm/unwind.h:64 [inline]
       arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
       stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
       kasan_save_stack mm/kasan/common.c:47 [inline]
       kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
       kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
       poison_slab_object mm/kasan/common.c:247 [inline]
       __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
       kasan_slab_free include/linux/kasan.h:233 [inline]
       slab_free_hook mm/slub.c:2353 [inline]
       slab_free mm/slub.c:4609 [inline]
       kfree+0x196/0x430 mm/slub.c:4757
       bch2_printbuf_exit+0x6d/0xa0 fs/bcachefs/printbuf.c:219
       __bch2_fsck_err+0x11a0/0x1420 fs/bcachefs/error.c:458
       bch2_alloc_write_key fs/bcachefs/btree_gc.c:860 [inline]
       bch2_gc_alloc_done fs/bcachefs/btree_gc.c:894 [inline]
       bch2_check_allocations+0x47ad/0x6aa0 fs/bcachefs/btree_gc.c:1044
       bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:226
       bch2_run_recovery_passes+0x2ad/0xa90 fs/bcachefs/recovery_passes.c:291
       bch2_fs_recovery+0x265a/0x3de0 fs/bcachefs/recovery.c:936
       bch2_fs_start+0x37c/0x610 fs/bcachefs/super.c:1030
       bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3560
       do_mount fs/namespace.c:3900 [inline]
       __do_sys_mount fs/namespace.c:4111 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->__lock);
                               lock(&base->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

5 locks held by syz.0.0/5328:
 #0: ffff888052b80278 (&c->state_lock){+.+.}-{4:4}, at: bch2_fs_start+0x45/0x610 fs/bcachefs/super.c:999
 #1: ffff888052ba66d0 (&c->gc_lock){+.+.}-{4:4}, at: bch2_check_allocations+0x1df/0x6aa0 fs/bcachefs/btree_gc.c:1020
 #2: ffff888052b84378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:164 [inline]
 #2: ffff888052b84378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:256 [inline]
 #2: ffff888052b84378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0x9a/0x1a0 fs/bcachefs/btree_iter.c:3202
 #3: ffff888052368140 (bcachefs_btree){+.+.}-{0:0}, at: trans_set_locked fs/bcachefs/btree_locking.h:198 [inline]
 #3: ffff888052368140 (bcachefs_btree){+.+.}-{0:0}, at: bch2_trans_begin+0x9ca/0x1d90 fs/bcachefs/btree_iter.c:3274
 #4: ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1836 [inline]
 #4: ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: __run_timers kernel/time/timer.c:2414 [inline]
 #4: ffff88801fc2a398 (&base->lock){-.-.}-{2:2}, at: __run_timer_base+0x69d/0x8e0 kernel/time/timer.c:2426

stack backtrace:
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
 console_trylock kernel/printk/printk.c:2852 [inline]
 console_trylock_spinning kernel/printk/printk.c:2009 [inline]
 vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:expire_timers kernel/time/timer.c:1827 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:2414 [inline]
RIP: 0010:__run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2426
Code: 24 38 42 80 3c 30 00 74 08 4c 89 ef e8 a5 c4 79 00 4d 8b 7d 00 4d 85 ff 74 33 e8 27 2c 13 00 e9 dd fe ff ff e8 1d 2c 13 00 90 <0f> 0b 90 eb ae 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 25 ff ff ff
RSP: 0018:ffffc90000007ca0 EFLAGS: 00010046
RAX: ffffffff81ac3203 RBX: ffff888044012cf0 RCX: ffff888000cc2440
RDX: 0000000000000100 RSI: ffffffff8c6089e0 RDI: ffffffff8c6089a0
RBP: ffffc90000007df0 R08: ffffffff81ac6c04 R09: 1ffffffff2036a2e
R10: dffffc0000000000 R11: fffffbfff2036a2f R12: 0000000000000000
R13: ffffc90000007d48 R14: dffffc0000000000 R15: ffff888044012cd8
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_stack_info+0x4/0xf0 arch/x86/kernel/dumpstack_64.c:193
Code: c5 c0 23 05 8c c3 cc cc cc cc 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 <55> 41 57 41 56 41 55 41 54 53 49 89 ce 48 89 d3 48 89 f5 48 85 f6
RSP: 0018:ffffc9000d486358 EFLAGS: 00000246
RAX: 1ffff92001a90c7f RBX: ffffc9000d486360 RCX: ffffc9000d4863e0
RDX: ffffc9000d4863c0 RSI: ffff888000cc2440 RDI: ffffc9000d486360
RBP: ffffc9000d486401 R08: ffffc9000d48641f R09: 0000000000000000
R10: ffffc9000d4863c0 R11: fffff52001a90c84 R12: ffffc9000d4863e0
R13: ffffc9000d4863e8 R14: ffffc9000d4863c0 R15: 1ffff92001a90c7d
 __unwind_start+0x434/0x740 arch/x86/kernel/unwind_orc.c:729
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 bch2_printbuf_exit+0x6d/0xa0 fs/bcachefs/printbuf.c:219
 __bch2_fsck_err+0x11a0/0x1420 fs/bcachefs/error.c:458
 bch2_alloc_write_key fs/bcachefs/btree_gc.c:860 [inline]
 bch2_gc_alloc_done fs/bcachefs/btree_gc.c:894 [inline]
 bch2_check_allocations+0x47ad/0x6aa0 fs/bcachefs/btree_gc.c:1044
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:226
 bch2_run_recovery_passes+0x2ad/0xa90 fs/bcachefs/recovery_passes.c:291
 bch2_fs_recovery+0x265a/0x3de0 fs/bcachefs/recovery.c:936
 bch2_fs_start+0x37c/0x610 fs/bcachefs/super.c:1030
 bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f903af8e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f903bd70e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f903bd70ef0 RCX: 00007f903af8e58a
RDX: 0000200000000000 RSI: 0000200000000040 RDI: 00007f903bd70eb0
RBP: 0000200000000000 R08: 00007f903bd70ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000040
R13: 00007f903bd70eb0 R14: 000000000000593f R15: 0000200000000380
 </TASK>
WARNING: CPU: 0 PID: 5328 at kernel/time/timer.c:1827 expire_timers kernel/time/timer.c:1827 [inline]
WARNING: CPU: 0 PID: 5328 at kernel/time/timer.c:1827 __run_timers kernel/time/timer.c:2414 [inline]
WARNING: CPU: 0 PID: 5328 at kernel/time/timer.c:1827 __run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2426
Modules linked in:
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:expire_timers kernel/time/timer.c:1827 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:2414 [inline]
RIP: 0010:__run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2426
Code: 24 38 42 80 3c 30 00 74 08 4c 89 ef e8 a5 c4 79 00 4d 8b 7d 00 4d 85 ff 74 33 e8 27 2c 13 00 e9 dd fe ff ff e8 1d 2c 13 00 90 <0f> 0b 90 eb ae 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 25 ff ff ff
RSP: 0018:ffffc90000007ca0 EFLAGS: 00010046
RAX: ffffffff81ac3203 RBX: ffff888044012cf0 RCX: ffff888000cc2440
RDX: 0000000000000100 RSI: ffffffff8c6089e0 RDI: ffffffff8c6089a0
RBP: ffffc90000007df0 R08: ffffffff81ac6c04 R09: 1ffffffff2036a2e
R10: dffffc0000000000 R11: fffffbfff2036a2f R12: 0000000000000000
R13: ffffc90000007d48 R14: dffffc0000000000 R15: ffff888044012cd8
FS:  00007f903bd716c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056372c09c0c8 CR3: 000000003bc66000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_stack_info+0x4/0xf0 arch/x86/kernel/dumpstack_64.c:193
Code: c5 c0 23 05 8c c3 cc cc cc cc 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 <55> 41 57 41 56 41 55 41 54 53 49 89 ce 48 89 d3 48 89 f5 48 85 f6
RSP: 0018:ffffc9000d486358 EFLAGS: 00000246
RAX: 1ffff92001a90c7f RBX: ffffc9000d486360 RCX: ffffc9000d4863e0
RDX: ffffc9000d4863c0 RSI: ffff888000cc2440 RDI: ffffc9000d486360
RBP: ffffc9000d486401 R08: ffffc9000d48641f R09: 0000000000000000
R10: ffffc9000d4863c0 R11: fffff52001a90c84 R12: ffffc9000d4863e0
R13: ffffc9000d4863e8 R14: ffffc9000d4863c0 R15: 1ffff92001a90c7d
 __unwind_start+0x434/0x740 arch/x86/kernel/unwind_orc.c:729
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 bch2_printbuf_exit+0x6d/0xa0 fs/bcachefs/printbuf.c:219
 __bch2_fsck_err+0x11a0/0x1420 fs/bcachefs/error.c:458
 bch2_alloc_write_key fs/bcachefs/btree_gc.c:860 [inline]
 bch2_gc_alloc_done fs/bcachefs/btree_gc.c:894 [inline]
 bch2_check_allocations+0x47ad/0x6aa0 fs/bcachefs/btree_gc.c:1044
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:226
 bch2_run_recovery_passes+0x2ad/0xa90 fs/bcachefs/recovery_passes.c:291
 bch2_fs_recovery+0x265a/0x3de0 fs/bcachefs/recovery.c:936
 bch2_fs_start+0x37c/0x610 fs/bcachefs/super.c:1030
 bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f903af8e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f903bd70e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f903bd70ef0 RCX: 00007f903af8e58a
RDX: 0000200000000000 RSI: 0000200000000040 RDI: 00007f903bd70eb0
RBP: 0000200000000000 R08: 00007f903bd70ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000040
R13: 00007f903bd70eb0 R14: 000000000000593f R15: 0000200000000380
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	c0 23 05             	shlb   $0x5,(%rbx)
   3:	8c c3                	mov    %es,%ebx
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	31 c0                	xor    %eax,%eax
   b:	c3                   	ret
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	66 0f 1f 00          	nopw   (%rax)
* 29:	55                   	push   %rbp <-- trapping instruction
  2a:	41 57                	push   %r15
  2c:	41 56                	push   %r14
  2e:	41 55                	push   %r13
  30:	41 54                	push   %r12
  32:	53                   	push   %rbx
  33:	49 89 ce             	mov    %rcx,%r14
  36:	48 89 d3             	mov    %rdx,%rbx
  39:	48 89 f5             	mov    %rsi,%rbp
  3c:	48 85 f6             	test   %rsi,%rsi


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

