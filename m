Return-Path: <cgroups+bounces-8527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C584ADA35E
	for <lists+cgroups@lfdr.de>; Sun, 15 Jun 2025 22:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A64E3AED41
	for <lists+cgroups@lfdr.de>; Sun, 15 Jun 2025 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C123283C9D;
	Sun, 15 Jun 2025 20:13:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A02820A5
	for <cgroups@vger.kernel.org>; Sun, 15 Jun 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750018414; cv=none; b=FfYAdofxBCqR39kzjRYbqrIcrTJL37LZmp1OSZ4b1+TITJOAz0oyog/eUyZwdNLkGfsQ35dqJk3Ez6B6Gr78SapVeY3GIE/dM2W/OJ0HQlCBcrD+pEbN7aN+qs8Px+5tqGApybG8qgqaLd1nkFBXWJsg5OXP9xrYwbLVwz/MghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750018414; c=relaxed/simple;
	bh=MKniLpCDwhbmrO/I0fj2QwvHLgMovvFWsaopjarRReE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XNeyT3NiahI5lP4PLqHA26xd8jUi3VimDL8OgZ4lVfxe7791OR9aZtsBNe/ahHZhi2w0bDajwwNhMzw/0Udg0OlDQiga569l+M0YcYmL3ngtsthxdwdIeSoLHw094V2vTmqjFpBCk+dFCpl86yuW88pVRwwtkU2Sgob72xX2J4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cf0364dd2so751879839f.0
        for <cgroups@vger.kernel.org>; Sun, 15 Jun 2025 13:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750018411; x=1750623211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APoc7MBnEICN7+nM4RYPtq8BlhTLNhS8RXtzVSBPA48=;
        b=BWEy0ew1PHcjMeNNXiM/xuVF/FEanKHA3lyrowsxd2KOwsNk3JaWeO8HkLD0cI5LZC
         4+cw0LDnyBe8TLlhwDUSkf23iS1qenZiPejo+ZfLsZIdvi+U1Eb9rMySVwTYOXlKAuhu
         JtlB8uvvU4VkrP3oluG7kzn1jKiYhGnBGgI85Betat1X0nUTztfWDEXGaGsfbOtaqOZ/
         Xt2hokP856U63+SZUDHxmKLTDxVPCpA9WgMAMs8czSyj5qVQ/oHgzPEwt+GzWys2TJuo
         GG11r4w1xCMkyeffYe+lMk533A4XDuJOv14XPZZXrhLh8MZOa5r9OrJNzALWo3PmZa5X
         FOpA==
X-Gm-Message-State: AOJu0YzA6auAZOFR7ZzFg70KlCP4h2mMuGXm2n4McDn87Hj5+bP2vdnu
	wAhFqMiswBB4Y4wYCtwXRM432eK8JXDeaIK6k8bjaUHm9fEkXRfgzb34sd0PnV4W0gyUhEr2Ham
	cxYkrTEsVc190ciEWZszC8wkFJq8R9/HX9usIOAX/Auy5Nhx2eI5lDZMJk7pKtQ==
X-Google-Smtp-Source: AGHT+IEfduYzJCu15I2ttz/tOQ9bEvf01/H5zsj3bby1baRB70GqhhVQaifU/eQKabUXMlqJg2+FFoxMppp9hZQusHKIusQc7VMO
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178f:b0:3dd:79e6:3ba4 with SMTP id
 e9e14a558f8ab-3de07c4164cmr71970555ab.9.1750018411508; Sun, 15 Jun 2025
 13:13:31 -0700 (PDT)
Date: Sun, 15 Jun 2025 13:13:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684f296b.a00a0220.279073.0033.GAE@google.com>
Subject: [syzbot] [cgroups?] WARNING in NUM (2)
From: syzbot <syzbot+ee0ddd3c79cac08cd4f6@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1005b682580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8409c4d4e51ac27
dashboard link: https://syzkaller.appspot.com/bug?extid=ee0ddd3c79cac08cd4f6
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92d22b0c6493/disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fb0142bb63a/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d5f3836ae42/Image-19272b37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee0ddd3c79cac08cd4f6@syzkaller.appspotmail.com

ODEBUG: object 0000000005ba7bd0 is on stack 000000007a4ecf0e, but NOT annotated.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7772 at lib/debugobjects.c:655 debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
WARNING: CPU: 0 PID: 7772 at lib/debugobjects.c:655 lookup_object_or_alloc lib/debugobjects.c:688 [inline]
WARNING: CPU: 0 PID: 7772 at lib/debugobjects.c:655 __debug_object_init+0x364/0x40c lib/debugobjects.c:743
Modules linked in:
CPU: 0 UID: 0 PID: 7772 Comm: bch-copygc/loop Not tainted 6.16.0-rc1-syzkaller-g19272b37aa4f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
pc : lookup_object_or_alloc lib/debugobjects.c:688 [inline]
pc : __debug_object_init+0x364/0x40c lib/debugobjects.c:743
lr : debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
lr : lookup_object_or_alloc lib/debugobjects.c:688 [inline]
lr : __debug_object_init+0x364/0x40c lib/debugobjects.c:743
sp : ffff80009dce7700
x29: ffff80009dce7700 x28: 0000000000000000 x27: dfff800000000000
x26: ffff800097589000 x25: ffff0000f7badba0 x24: 0000000000000000
x23: ffff0000f55ff1c0 x22: 0000000000000000 x21: ffff8000974ba208
x20: ffff80008af00de0 x19: ffff80009dce7bb0 x18: 00000000ffffffff

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc1-syzkaller-g19272b37aa4f #0 Not tainted
------------------------------------------------------
bch-copygc/loop/7772 is trying to acquire lock:
ffff0000c943a848 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
ffff0000c943a848 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226

but task is already holding lock:
ffff8000974ba228 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x6c/0x40c lib/debugobjects.c:741

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&obj_hash[i].lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       debug_object_assert_init+0xa0/0x2c8 lib/debugobjects.c:1007
       debug_timer_assert_init kernel/time/timer.c:803 [inline]
       debug_assert_init kernel/time/timer.c:848 [inline]
       __mod_timer+0x5c/0xd00 kernel/time/timer.c:1025
       add_timer_global+0x88/0xc0 kernel/time/timer.c:1283
       __queue_delayed_work+0x218/0x2c8 kernel/workqueue.c:2526
       queue_delayed_work_on+0xe4/0x194 kernel/workqueue.c:2561
       queue_delayed_work include/linux/workqueue.h:677 [inline]
       schedule_delayed_work include/linux/workqueue.h:817 [inline]
       psi_group_change+0xd50/0x12e4 kernel/sched/psi.c:873
       psi_task_change+0xec/0x244 kernel/sched/psi.c:912
       psi_enqueue kernel/sched/stats.h:166 [inline]
       enqueue_task+0x250/0x2f4 kernel/sched/core.c:2086
       activate_task kernel/sched/core.c:2126 [inline]
       wake_up_new_task+0x324/0x990 kernel/sched/core.c:4891
       kernel_clone+0x440/0x7a0 kernel/fork.c:2630
       user_mode_thread+0xc8/0x11c kernel/fork.c:2677
       rest_init+0x30/0x2f4 init/main.c:709
       start_kernel+0x450/0x4ac init/main.c:1101
       __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246

-> #1 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested kernel/sched/core.c:606 [inline]
       raw_spin_rq_lock kernel/sched/sched.h:1532 [inline]
       task_rq_lock+0xc4/0x33c kernel/sched/core.c:708
       cgroup_move_task+0x9c/0x454 kernel/sched/psi.c:1161
       css_set_move_task+0x69c/0x8bc kernel/cgroup/cgroup.c:918
       cgroup_post_fork+0x160/0x5cc kernel/cgroup/cgroup.c:6754
       copy_process+0x2e48/0x31ec kernel/fork.c:2413
       kernel_clone+0x1d8/0x7a0 kernel/fork.c:2599
       user_mode_thread+0xc8/0x11c kernel/fork.c:2677
       rest_init+0x30/0x2f4 init/main.c:709
       start_kernel+0x450/0x4ac init/main.c:1101
       __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
       try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226
       wake_up_process kernel/sched/core.c:4475 [inline]
       wake_up_q+0x70/0x9c kernel/sched/core.c:1081
       up+0x100/0x170 kernel/locking/semaphore.c:235
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x88/0xc4 kernel/printk/printk.c:2885
       __console_flush_and_unlock kernel/printk/printk.c:3287 [inline]
       console_unlock+0xfc/0x288 kernel/printk/printk.c:3325
       vprintk_emit+0x298/0x430 kernel/printk/printk.c:2450
       vprintk_default+0x54/0x80 kernel/printk/printk.c:2465
       vprintk+0x90/0x128 kernel/printk/printk_safe.c:82
       _printk+0xd0/0x118 kernel/printk/printk.c:2475
       __show_regs+0x294/0x2dc arch/arm64/kernel/process.c:241
       show_regs+0x20/0x44 arch/arm64/kernel/process.c:247
       __warn+0x1d0/0x658 kernel/panic.c:775
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x288/0x568 lib/bug.c:215
       bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:1002
       call_break_hook arch/arm64/kernel/debug-monitors.c:315 [inline]
       brk_handler+0x1d8/0x288 arch/arm64/kernel/debug-monitors.c:325
       do_debug_exception+0x1e4/0x38c arch/arm64/mm/fault.c:1002
       el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:513
       el1h_64_sync_handler+0x40/0xcc arch/arm64/kernel/entry-common.c:559
       el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
       debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
       lookup_object_or_alloc lib/debugobjects.c:688 [inline]
       __debug_object_init+0x364/0x40c lib/debugobjects.c:743
       debug_object_init+0x20/0x2c lib/debugobjects.c:779
       __init_work+0x58/0x68 kernel/workqueue.c:677
       rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
       bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
       kthread+0x5fc/0x75c kernel/kthread.c:464
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> &obj_hash[i].lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&obj_hash[i].lock);
                               lock(&rq->__lock);
                               lock(&obj_hash[i].lock);
  lock(&p->pi_lock);

 *** DEADLOCK ***

1 lock held by bch-copygc/loop/7772:
 #0: ffff8000974ba228 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x6c/0x40c lib/debugobjects.c:741

stack backtrace:
CPU: 0 UID: 0 PID: 7772 Comm: bch-copygc/loop Not tainted 6.16.0-rc1-syzkaller-g19272b37aa4f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2046
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
 try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226
 wake_up_process kernel/sched/core.c:4475 [inline]
 wake_up_q+0x70/0x9c kernel/sched/core.c:1081
 up+0x100/0x170 kernel/locking/semaphore.c:235
 __up_console_sem kernel/printk/printk.c:343 [inline]
 __console_unlock+0x88/0xc4 kernel/printk/printk.c:2885
 __console_flush_and_unlock kernel/printk/printk.c:3287 [inline]
 console_unlock+0xfc/0x288 kernel/printk/printk.c:3325
 vprintk_emit+0x298/0x430 kernel/printk/printk.c:2450
 vprintk_default+0x54/0x80 kernel/printk/printk.c:2465
 vprintk+0x90/0x128 kernel/printk/printk_safe.c:82
 _printk+0xd0/0x118 kernel/printk/printk.c:2475
 __show_regs+0x294/0x2dc arch/arm64/kernel/process.c:241
 show_regs+0x20/0x44 arch/arm64/kernel/process.c:247
 __warn+0x1d0/0x658 kernel/panic.c:775
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x288/0x568 lib/bug.c:215
 bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:1002
 call_break_hook arch/arm64/kernel/debug-monitors.c:315 [inline]
 brk_handler+0x1d8/0x288 arch/arm64/kernel/debug-monitors.c:325
 do_debug_exception+0x1e4/0x38c arch/arm64/mm/fault.c:1002
 el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:513
 el1h_64_sync_handler+0x40/0xcc arch/arm64/kernel/entry-common.c:559
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
 debug_object_is_on_stack lib/debugobjects.c:-1 [inline] (P)
 lookup_object_or_alloc lib/debugobjects.c:688 [inline] (P)
 __debug_object_init+0x364/0x40c lib/debugobjects.c:743 (P)
 debug_object_init+0x20/0x2c lib/debugobjects.c:779
 __init_work+0x58/0x68 kernel/workqueue.c:677
 rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
 bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
x17: ffff800093215000 x16: ffff80008ae5617c x15: 0000000000000001
x14: 1ffff00013b9ce58 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013b9ce59 x10: 0000000000ff0100 x9 : 83cd6914eae67d00
x8 : 83cd6914eae67d00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009dce7098 x4 : ffff80008f657060 x3 : ffff8000807bb744
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000050
Call trace:
 debug_object_is_on_stack lib/debugobjects.c:-1 [inline] (P)
 lookup_object_or_alloc lib/debugobjects.c:688 [inline] (P)
 __debug_object_init+0x364/0x40c lib/debugobjects.c:743 (P)
 debug_object_init+0x20/0x2c lib/debugobjects.c:779
 __init_work+0x58/0x68 kernel/workqueue.c:677
 rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
 bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 18
hardirqs last  enabled at (17): [<ffff800083e501f4>] get_random_u32+0x2d4/0x540 drivers/char/random.c:554
hardirqs last disabled at (18): [<ffff80008ae77604>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (18): [<ffff80008ae77604>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffff8000803aab44>] copy_process+0x1134/0x31ec kernel/fork.c:2114
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
bcachefs (loop6): Detected missing backpointers in bucket 34, now have 1/128 with missing
  running recovery pass check_extents_to_backpointers (17), currently at check_dirents (31)


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

